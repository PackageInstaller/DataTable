local Const = require("const")
local Base = require("gamemode.base")
local GameLogin = require("gamelogic.login.game_login")
local LocalStorage = require("utils.localstorage")
local RuntimePackage = require("manager.res.runtime_package")
local Account = require("gamelogic.account.account")
local Json = require("utils.json")
local UnityWebRequest = UnityEngine.Networking.UnityWebRequest
local UnityApplication = UnityEngine.Application
local CSErrorUpLoad = CS.Game.ErrorUpLoad
local UnityPlayerPrefs = UnityEngine.PlayerPrefs
local UnityEngine = _ENV.UnityEngine
local UnityTime = UnityEngine.Time
local LOGIN_STATE = {
  NONE = 0,
  BEGIN = 1,
  INGAME = 2
}
local M = setmetatable({}, Base)
M.__index = M
local MAX_SYSTEM_INIT_TIME = 10

local function _client_only_create_obj()
  if Util.is_client_only() then
    local temp_team = {}
    local count = 0
    local role_list = DebugSetting:get_role_list()
    for i = 1, 3 do
      if 0 ~= role_list[i] then
        count = count + 1
        table.insert(temp_team, {
          id = role_list[i],
          uuid = count * 10 + 1,
          pos = count
        })
      end
    end
    if 0 == count then
      Log.Error("请在Service界面至少填上一个合法的roleId")
    end
    SceneMgr:create_team(1, temp_team)
    local operate_id = DebugSetting:get_operate_char_id()
    if operate_id > 0 then
      count = count + 1
      SceneMgr:create_robot_heros({
        id = operate_id,
        uuid = count * 10 + 1
      })
    end
    local monster_id = DebugSetting:get_monster_id()
    if monster_id > 0 then
      SceneMgr:create_npc(monster_id, 5, nil, 5, 10, 10, Config.CAMPS.ENEMY)
    end
    SceneMgr:create_god_npc_in_client()
  end
end

local function _to_check_update_mode()
  MsgGame:mq_publish2(Const.MSG_LOGIN_FAILED)
  Network:close()
  Global.gamemode:gmode_set_mode(Const.MODE_CHECK_UPDATE)
end

local function _connect_failed(msg, is_reconnect)
  UIMgr:try_hide_ui("ui_login_wait")
  UIMgr:try_hide_ui("reconnecting")
  Util.show_notify_popup_message(_to_check_update_mode, msg, "网络连接失败", "确定", nil, nil, true)
end

function M:gd_init()
  Base.gd_init(self)
  self.v_init_tasks = {
    {
      self._show_loginui
    },
    {
      self._shader_variant_warmup
    },
    {
      self._login
    },
    {
      self._init_systems
    },
    {
      self._start_receive_gs2c
    },
    {
      self._check_del_player_timer
    },
    {
      self._enter_scene
    }
  }
end

function M:gd_on_enter()
  Util.refresh_curr_language()
  if Global.sound_mgr then
    Global.sound_mgr:remove_all_cue_sheet()
  end
  Base.gd_on_enter(self)
  Global.is_enter_room_failed = false
  self.login_state = LOGIN_STATE.NONE
  Global.has_login = false
  Global.has_login_and_createplayer = false
  self.v_login_platform_time = nil
  RuntimePackage.reset()
  if Global.hero then
    Global.scene_mgr:remove_npc(Global.hero)
    Global.hero = nil
    Global.hero_uuid = nil
  end
  self.v_receive_msg_end = false
  UIMgr:on_enter_login_mode()
  if Global.reload_camera then
    Global.reload_camera:SetActive(false)
  end
  self.v_checked_del_player_timer = false
end

function M:gd_update(delta_time)
  Base.gd_update(self, delta_time)
  self:_exec_task()
end

function M:gd_on_leave()
  Base.gd_on_leave(self)
  self.v_login_start_time = 0
  self.v_has_show_notify = false
  self.v_login_time = nil
  self.v_login_platform_time = nil
end

function M:_show_loginui()
  if Util.is_client_only() then
    return true
  end
  if 0 == self.dummy_cnt then
    self.dummy_cnt = self.dummy_cnt + 1
    UIMgr:get_ui("uilogin"):ui_show(function()
      if self.login_state ~= LOGIN_STATE.NONE then
        return
      end
      self.login_state = LOGIN_STATE.BEGIN
      self:gd_next_task()
      Log.Info("login step 1:btn_login")
    end)
    UIMgr:hide_other_uis("uilogin")
    UIMgr:clear_ui_stack()
    if Global.camera and SceneMgr then
      SceneMgr:destroy_camera()
    end
    UIMgr.root_camera_obj:SetActive(true)
    self:login_trace_data("到达登入界面", 100009)
    return false
  end
end

function M:_shader_variant_warmup()
  if not Game_AssetBundle then
    return true
  end
  if 0 == self.dummy_cnt then
    self.dummy_cnt = 1
    local storage_key = "is_first_compile_shader"
    local is_first_compile_shader = LocalStorage:load_int(storage_key, 0)
    local shader_variant_collections
    shader_variant_collections = Global.assetbundle_mgr:get_need_warmup_shader_variant_collections()
    local all_variant_count = 0
    if shader_variant_collections then
      for _, collection in pairs(shader_variant_collections) do
        all_variant_count = all_variant_count + collection.variantCount
      end
    end
    UIMgr:get_ui("ui_login_wait"):ui_show()
    local prewarm_count = 0
    Coroutine.start(function()
      for _, variant in pairs(shader_variant_collections) do
        coroutine.yield(UnityEngine.WaitForSeconds(0.2))
        variant:WarmUp()
        prewarm_count = prewarm_count + variant.variantCount
        UIMgr:get_ui("ui_login_wait"):to_shader_warm_stage(math.ceil(prewarm_count / all_variant_count * 100) .. "%", 0 == is_first_compile_shader)
      end
      if 0 == is_first_compile_shader then
        LocalStorage:save_int(storage_key, 1)
      end
      self:gd_next_task()
    end)
  end
end

local function init_error_upload_info()
  local contextHead = {}
  table.insert(contextHead, "deviceModel = " .. UnityEngine.SystemInfo.deviceModel)
  table.insert(contextHead, "deviceName = " .. UnityEngine.SystemInfo.deviceName)
  table.insert(contextHead, "deviceUniqueIdentifier = " .. UnityEngine.SystemInfo.deviceUniqueIdentifier)
  table.insert(contextHead, "graphicsDeviceID = " .. UnityEngine.SystemInfo.graphicsDeviceID)
  table.insert(contextHead, "graphicsDeviceName = " .. UnityEngine.SystemInfo.graphicsDeviceName)
  table.insert(contextHead, "graphicsMemorySize = " .. UnityEngine.SystemInfo.graphicsMemorySize)
  table.insert(contextHead, "systemMemorySize = " .. UnityEngine.SystemInfo.systemMemorySize)
  table.insert(contextHead, "playerUuid = " .. Global.player_uuid)
  table.insert(contextHead, "playerName = " .. Account:get_account())
  table.insert(contextHead, "serverName = " .. Global.connect_info.name .. "  serverIp=" .. Global.connect_info.IP)
  local base_info = table.concat(contextHead, "\n") .. "\n"
  local player_id = Global.player_uuid
  CSErrorUpLoad.Instance:SetPlayerId(player_id)
  CSErrorUpLoad.Instance:SetBaseInfo(base_info)
  local cur_is_upload = 0
  if UnityPlayerPrefs.HasKey(Config.UPLOAD_ERROR_KEY) then
    cur_is_upload = UnityPlayerPrefs.GetInt(Config.UPLOAD_ERROR_KEY)
  end
  CSErrorUpLoad.Instance:SetIsPostError(1 == cur_is_upload)
end

local function _on_login_callbck(self, ok, rep, is_reconnect)
  Log.Info("is_reconnect = ", is_reconnect, " is_in_login = ", Global.gamemode:gmode_is_login(), "player_uuid = ", rep.uuid, "rep.fpid = ", rep.fpid, "ok = ", ok, "errcode = ", rep.errcode)
  if false == ok and true == is_reconnect then
    local msg
    if 0 ~= rep.errcode then
      msg = Util.get_error_code_msg(rep.errcode)
    else
      msg = "登录失败，请联系客服"
    end
    _connect_failed(msg, is_reconnect)
    return
  end
  if false == is_reconnect and not Global.gamemode:gmode_is_login() then
    return
  end
  if 0 ~= rep.errcode then
    Log.Error("连接校验失败！！！", is_reconnect)
    _connect_failed(Util.get_error_code_msg(rep.errcode), is_reconnect)
    return
  end
  if true == is_reconnect then
    MsgGame:mq_publish2(Const.MSG_NETWORK_RCT_SUC)
  end
  Global.has_login = true
  Global.has_login_and_createplayer = true
  if not is_reconnect then
    Global.player_uuid = assert(rep.uuid)
    local last_login_data = {}
    last_login_data.player_uuid = Global.player_uuid
    LocalStorage:save_table(Config.LAST_LOGIN_UUID_KEY, last_login_data)
    local is_login_saved = BattleSettingMgr:get_is_login_saved()
    if is_login_saved then
      BattleSettingMgr:save_local_setting_info()
      BattleSettingMgr:set_is_login_saved(false)
    end
    SDKTrack:set_account_id()
  else
    assert(Global.player_uuid)
  end
  CSHelper.SetBuglyUserId(Global.player_uuid)
  MsgGame:mq_publish2(Const.MSG_LOGIN_FINISHED)
  self.login_state = LOGIN_STATE.INGAME
  if not UNITY_EDITOR then
    init_error_upload_info()
  end
  self:login_trace_data("连接游戏服成功", 100013)
  local last_login_timestamp = LocalStorage:load_int(Config.LOCAL_DAILY_LOGIN_TIMESTEP_KEY, 0, true)
  local is_first_login_today = Date.is_daily_first(last_login_timestamp)
  Global.is_first_login_today = is_first_login_today
  if is_first_login_today then
    LocalStorage:save_int(Config.LOCAL_DAILY_LOGIN_TIMESTEP_KEY, Date.server_time(), true)
  end
  self:gd_next_task()
end

local function _on_system_complete(self)
  self.v_init_sys_count = self.v_init_sys_count + 1
  if self.v_init_sys_count == self.v_sum_system_count then
    self.dummy_cnt = self.dummy_cnt + 1
    MsgGame:mq_unbind(self.v_system_handler)
    self.v_system_handler = nil
  end
end

function M:_init_systems()
  if Util.is_client_only() then
    Global.MagicPool = require("manager.magic.magic_pool"):new()
    for _, sys_info in ipairs(Config.system_modules) do
      if sys_info.is_init_client_only == true or sys_info.global_name == "CharacterMgr" then
        local clz = "gamelogic." .. sys_info.class
        local cls_obj = require(clz):new(sys_info.global_name)
        cls_obj:init_sys()
        _G[sys_info.global_name] = cls_obj
        _G[sys_info.global_name]:on_init_sys()
        _G[sys_info.global_name]:set_can_update(true)
      end
    end
    BehaviorMgr:create_common_manager()
    _client_only_create_obj()
    return true
  end
  if 0 == self.dummy_cnt then
    Global.MagicPool = require("manager.magic.magic_pool"):new()
    self.dummy_cnt = self.dummy_cnt + 1
    self.v_sum_system_count = #Config.system_modules
    self.v_init_sys_count = 0
    self.v_system_handler = MsgGame:mq_bind(Const.MSG_SYS_ON_SYSTEM_INIT_COMPLETE, _on_system_complete, self)
    self.v_init_time = Date.time()
    for _, sys_info in ipairs(Config.system_modules) do
      local old_sys = _G[sys_info.global_name]
      if old_sys then
        old_sys:on_destroy()
      end
    end
    GlobalTimeMgr:init_time_scale()
    for _, sys_info in ipairs(Config.system_modules) do
      local clz = "gamelogic." .. sys_info.class
      local cls_obj = require(clz):new(sys_info.global_name)
      cls_obj:init_sys()
      _G[sys_info.global_name] = cls_obj
    end
    return false
  elseif 1 == self.dummy_cnt then
    if Date.time() - self.v_init_time >= MAX_SYSTEM_INIT_TIME then
      for _, sys_info in ipairs(Config.system_modules) do
        if not _G[sys_info.global_name]:is_activated() then
          Log.Error(Util.format_str("系统: {1} 初始化失败", sys_info.global_name))
        end
      end
      self.dummy_cnt = self.dummy_cnt + 1
      self:show_login_failed("登录失败，请联系客服")
    end
    return false
  elseif 2 == self.dummy_cnt then
    for _, sys_info in pairs(Config.system_modules) do
      if _G[sys_info.global_name]:is_activated() then
        _G[sys_info.global_name]:on_init_sys()
        _G[sys_info.global_name]:set_can_update(true)
      end
    end
    return true
  end
end

function M:_start_receive_gs2c()
  if 0 == self.dummy_cnt then
    self.dummy_cnt = self.dummy_cnt + 1
    Network:call("c2gs_roleinfo", {}, function(ok, resp)
      self.v_receive_msg_end = true
    end)
    if Util.is_client_only() then
      return true
    end
  else
    return self.v_receive_msg_end
  end
end

function M:_check_del_player_timer()
  if not SDKManager:is_enable_del_player_timer_check() or not PlayerMgr then
    return true
  end
  if 0 == self.dummy_cnt then
    self.dummy_cnt = self.dummy_cnt + 1
    local del_player_timer = PlayerMgr:get_del_player_timer()
    local now_timestamp = Date.server_time()
    if nil ~= del_player_timer and del_player_timer > 0 then
      if del_player_timer < now_timestamp then
        SDKManager:do_delete_account(function(is_deleted)
          local deleted_content = LanguageMgr:get_code_text("803")
          self:show_login_failed(deleted_content)
        end)
      else
        local remain_days = Date.get_diff_days(now_timestamp, del_player_timer)
        local content = Util.format_str("您已申请删除账号，剩余{1}天可取消，否则数据将于期满自动删除", remain_days)
        Util.show_notify_popup_message(function()
          Network:call("c2gs_cancel_del_player_timer", nil, function(ok, resp)
            if ok then
              self.v_checked_del_player_timer = true
            else
              self:show_login_failed(LanguageMgr:get_code_text("514"))
            end
          end)
        end, content, nil, "取消删除", "确定", _to_check_update_mode)
      end
    else
      self.v_checked_del_player_timer = true
    end
  end
  return self.v_checked_del_player_timer
end

local CODE_SDK_TICKET_INVALID = 1688

function M:_do_login()
  if not Global.gamemode:gmode_is_login() then
    return
  end
  local connect_info = Global.connect_info
  if not connect_info.WWW then
    GameLogin.login(_on_login_callbck, self)
    return
  end
  local address = connect_info.WWW
  local port = connect_info.port
  local host
  if port and 80 ~= port then
    host = string.format("%s:%s/verify/platform_auth?", address, port)
  else
    host = address .. "/verify/platform_auth?"
  end
  local url
  if SDKManager:is_use_sdk() then
    url = SDKManager:get_login_game_server_url(host)
  else
    local platform = Account:get_platform()
    local device_type = Account:get_device_type()
    local account = Account:get_account()
    local host_content = host .. "platform=%s&device_type=%s&account_id=%s&mac_address=%s&version=%s&auth_token=A9Cz4sv0O8"
    local mac_address = UnityEngine.SystemInfo.deviceUniqueIdentifier
    url = string.format(host_content, platform, device_type, account, mac_address, Util.get_login_version())
    if GAME_DEBUG then
      url = url .. "&debug=1"
    end
  end
  if GAME_DEBUG then
    Log.Info("login step 2, request url: " .. url)
  end
  CSHelper.RequestContent(url, function(content)
    if not content or "" == content then
      Log.Info("host: " .. host)
      if self.v_retry_login_cnt < 3 then
        Log.Info("request fail, retry, ", self.v_retry_login_cnt)
        self.v_retry_login_cnt = self.v_retry_login_cnt + 1
        self:_do_login()
        return
      end
      self:show_login_failed("无法连接网络")
      Util.show_error("request.error ", url)
    else
      local data = Json.decode(content)
      if 0 == data.errcode then
        Account:update_auth(data)
        if 0 == Account:get_gatesvrs_count() then
          self:show_login_failed("登录失败")
          return
        end
        GameLogin.login(_on_login_callbck, self)
      elseif data.errmsg then
        self:show_login_failed(data.errmsg)
      else
        local error_info = ShareRes.create("err_code.err_code", data.errcode)
        assert(error_info, data.errcode)
        local tips = error_info and error_info.tips or "未知错误码"
        self:show_login_failed(tips)
      end
    end
  end)
end

function M:_login()
  if 0 == self.dummy_cnt then
    self.dummy_cnt = self.dummy_cnt + 1
    if Util.is_client_only() then
      self:gd_next_task()
    else
      local connect_info = ServerList:get_default_server()
      Global.connect_info = connect_info
      UIMgr:get_ui("ui_login_wait"):to_login_stage()
      self.v_retry_login_cnt = 0
      self:_do_login()
    end
    return false
  end
end

function M:show_login_failed(msg)
  _connect_failed(msg)
end

function M:_enter_scene()
  if 0 == self.dummy_cnt then
    if Util.is_client_only() then
      local room_id = DebugSetting:get_room_id()
      if not room_id or room_id <= 0 then
        room_id = 100
      end
      local born_key = DebugSetting:get_born_key()
      Global.scene_mgr:set_gm_enter_born_key(born_key)
      Global.scene_mgr:gm_enter_room(room_id, true)
    else
      if NewbieTowerMgr:is_pass_tower() then
        NewbieTowerMgr:on_enter_newbie_tower()
      else
        self:login_trace_data("到达游戏主界面", 100014)
        UIMgr:get_ui("loading"):ignore_fight_type_trigger()
        Global.scene_mgr:on_enter_main_scene()
      end
      PlayerMgr:enter_game()
    end
    self.dummy_cnt = 1
  end
  if GAME_DEBUG and UNITY_EDITOR then
    local exclude = {
      _ = true,
      StateReport = true,
      hero = true
    }
    setmetatable(_G, {
      __newindex = function(t, k, v)
        if not rawget(exclude, k) then
          Log.Error("不允许对_G进行赋值!!", k, v, debug.traceback())
        end
        rawset(t, k, v)
      end,
      __pairs = function(_, t)
        return function(_, _)
        end, t, nil
      end
    })
  end
  return true
end

function M:login_trace_data(task_name, id)
  SDKTrack:track_loading(task_name, id)
end

return M
