local M = Util.create_class()
local BREAKABLE_OBJ_CLASEE = require("obj.breakable_obj")
local ROOM_STATE_PASS = 1
local UnityFind = _ENV.UnityFind
local PathDefine = require("utils.path_define")
local TypeSceneContainer = typeof(CS.Game.SceneContainer)
local DROP_TYPE = Config.DROP_TYPE
local ROOM_TYPE = Config.ROOM_TYPE
local HAVE_ANIMATION = Config.ENTER_ROOM_IS_HAVE_ANIMATIOIN
local TIMER_DESC = "auto_tp_next_floor_timer"
local _insert = table.insert
local BREAKABLE_ROOT_NAME = "breakable"
local SceneDef = require("cs_share.scene_define")
local FightDefine = require("cs_share.fight_define")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local ROOM_WAY_TYPE = FightDefine.ROOM_WAY_TYPE
local CommonDefine = require("cs_share.common_define")
M.PRE_FIGHT_STORY_STATE = {
  NONE = 0,
  WAIT_START = 1,
  WAIT_END = 2
}
local PRE_FIGHT_STORY_STATE = M.PRE_FIGHT_STORY_STATE

function M:_init(room_data)
  if type(room_data.room_info) == "number" then
    self.v_room_id = room_data.room_info
  else
    self.v_room_info = room_data.room_info
    self.v_room_id = room_data.room_info.room_id
  end
  Log.Info("room_id = ", self.v_room_id)
  if Global.sound_mgr then
    Global.sound_mgr:play_transmit_sound(false)
  end
  self.room_cfg = ShareRes.create("tower.tower_room", self.v_room_id)
  self.v_scene_logic_id = self.room_cfg.SceneLogicID
  if ShareRes.is_exist_config("scene_logic." .. self.v_scene_logic_id) then
    self.room_preload_cfg = ShareRes.create("preload." .. string.lower(self.v_scene_logic_id))
  end
  assert(self.room_cfg, "can't find tower_room config: " .. self.v_room_id)
  self.v_tower = room_data.tower
  self.v_tp_index = room_data.tp_index
  self.v_random_seed = room_data.random_seed
  self.v_room_num = room_data.room_num
  self.v_is_new_floor = room_data.is_new_floor
  self.v_is_first_enter = room_data.is_first_enter
  self.v_create_room_data = room_data.create_room_data
  self:set_check_node_stroy(not self.v_is_first_enter and self.v_create_room_data and self.v_create_room_data.check_node_story)
  self:set_fight_end(false)
  self.v_breakable_obj_list = {}
  self._cur_save_node_id = nil
  self.v_continue_tp_next_floor_cb = nil
  if self.v_room_info and self.v_room_info.status == ROOM_STATE_PASS then
    self:set_fight_end(true)
  end
  if not SceneMgr:try_enter_scene(self.room_cfg.SceneID, room_data.is_new_floor, nil, room_data.need_reload_same_scene) then
    TimeLineSeqPlayer.release_all_timeline()
    self:enter_room()
  end
  self.v_msg_handles = {}
  Util.bind_msg(self, Const.MSG_NETWORK_FIGHT_RCT_SUC, self._on_reconnect, self)
  self:register_event()
  self.v_is_upload_skill_hit = false
  self.v_get_all_drop_item = true
  self.v_cancel_footmark = false
  self.v_enter_time = Global.real_time
  self.v_fight_uuid = self.v_enter_time .. "/" .. self.v_room_id
end

function M:register_event()
  Util.bind_msg(self, Const.MSG_ON_CR_GET_RING_INFO_SUCCESS, self.response_get_ring_info, self)
  Util.bind_msg(self, Const.MSG_ON_DROP_EVENT, self.response_drop_event, self)
  Util.bind_msg(self, Const.MSG_TRIGGER_TRANSMIT_DOOR, self._response_interact_with_door, self)
  Util.bind_msg(self, Const.MSG_ON_HERO_BORN_ANIM_END, self.response_born_anim_end, self)
end

function M:setup(...)
end

function M:update_room_info(data)
  if data.room_id ~= self.v_room_id or data.room_num ~= self.v_room_num then
    return
  end
  self.v_room_info = data
end

function M:update_maze_room_info(data)
  self.v_room_info = data
end

function M:update(delta_time)
  for _, breakable_lua_obj in pairs(self.v_breakable_obj_list) do
    breakable_lua_obj:update()
  end
  if self.v_room_preload and self.v_room_preload:update_preload_res() then
    self.v_room_preload = nil
  end
end

function M:release(by_map_enter)
  self.v_room_preload = nil
  self._cur_save_node_id = nil
  Util.unbind_all_msg(self)
  self.v_room_info = nil
  self:clear_breakable_obj()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_LEAVE_ROOM)
  msg.mm_obj = self.v_room_num
  SceneMgr:revert_main_light_dir()
  SceneMgr:reset_battle_monster_type()
  if self.v_auto_tp_next_floor_timer then
    Timer:remove_timer(self.v_auto_tp_next_floor_timer)
    self.v_auto_tp_next_floor_timer = nil
  end
  self.v_continue_tp_next_floor_cb = nil
  ResPoolMgr:clear_room_pool()
end

function M:get_tower()
  return self.v_tower
end

function M:get_enter_tp_index()
  return self.v_tp_index
end

function M:get_room_num()
  return self.v_room_num
end

function M:get_room_id()
  return self.v_room_id
end

function M:set_is_upload_skill_hit(is_on)
  self.v_is_upload_skill_hit = is_on
end

function M:get_state_report_id()
  return self.v_tower:get_tower_id() * 100000 + self.v_room_id
end

function M:_set_scene_show_cb()
  MsgGame:mq_publish2(Const.MSG_TP_ROOM_FINISH)
  MsgGame:mq_publish2(Const.MSG_SCENE_LOAD_FINISH)
  local delay_magic_cfg = ShareRes.create("tower.tower_room_delay_magic", self.v_room_id)
  if delay_magic_cfg and delay_magic_cfg.IsHaveAnimation == HAVE_ANIMATION.NO then
    UIMgr:get_ui("fight_room_delay_add_magic"):ui_show(delay_magic_cfg, self.v_is_fight_end)
  end
  NextFrameMgr:add_next_update(BehaviorMgr.call_event_fun, BehaviorMgr, BehaviorMgr.EVENTS.ON_TP_ROOM_FINISH)
  self:enter_room_trace_data()
  self:set_start_hero_hp_data()
  Global.sound_mgr:set_audio_active(true, true, 1)
end

function M:_setup_hero()
  local hero_list = SceneMgr:get_hero_list()
  if hero_list then
    for _, hero in pairs(hero_list) do
      if Global.enable_hero_9999999 then
        hero.magic_mgr:add_magic(hero, 49999999)
        hero.magic_mgr:add_magic(hero, 29999999)
        hero.magic_mgr:add_magic(hero, 39999999)
      end
      hero:setup_born_behavior()
    end
  end
  SceneMgr:set_attrs_data()
end

function M:on_scene_ready()
  FightDataMgr:clear_walkable_position()
  self:cr_scene_ready_end_logic()
  local scene_show_cb, duration
  self:_setup_hero()
  if TowerMgr:need_cancle_born_skill() and not Global.is_open_uifight_test then
    function scene_show_cb()
      self:_set_scene_show_cb()
    end
    
    duration = 0.5
  else
    self:_set_scene_show_cb()
    duration = 0
  end
  SceneMgr:set_scene_show(true, scene_show_cb, nil, duration)
  self.v_on_enter_room = false
end

function M:_pre_fight_story_cb()
  self:set_pre_fight_story_play_state(PRE_FIGHT_STORY_STATE.NONE)
  self:scene_ready_end_logic()
  self:on_scene_ready()
  SceneMgr:play_tower_sound()
end

function M:_play_pre_fight_story()
  local pre_fight_story_id
  if self.v_tower then
    self.v_tower:check_tp_room_play_story(self.v_room_num)
    if self.v_tower:check_play_story(nil, true) then
      self:set_pre_fight_story_play_state(PRE_FIGHT_STORY_STATE.WAIT_END)
      return
    end
  end
  if self.v_check_node_stroy then
    pre_fight_story_id = TowerMgr and TowerMgr:check_play_node_story(true)
    if Util.is_more_than_zero(pre_fight_story_id) then
      self:set_check_node_stroy(false)
      self:set_pre_fight_story_play_state(PRE_FIGHT_STORY_STATE.WAIT_START)
      SceneMgr:set_curtain_show(true)
      StoryMgr:on_start(pre_fight_story_id)
      return
    end
  end
  if BehaviorMgr:call_scene_logic_event_fun("play_pre_fight_story", nil) then
    self:set_pre_fight_story_play_state(PRE_FIGHT_STORY_STATE.WAIT_END)
    return
  end
  self:_pre_fight_story_cb()
end

function M:_preload_res_done_cb(on_load_scene)
  local fight_type = TowerMgr and TowerMgr:get_fight_type()
  if fight_type == CommonDefine.CHALLENGE_TYPE.NEWBIE_TOWER and not on_load_scene then
    UIMgr:try_hide_ui("loading")
  end
  UIMgr:try_destory_ui("ui_blackfade")
  SceneMgr:mat_vertexanim_reset()
  SceneMgr:check_create_hero()
  if self.v_tower then
    self.v_tower:set_in_room_preload(false)
  end
  SceneMgr:set_scene(self.v_scene_logic_id, self.room_cfg.MapInfo)
  SceneMgr:create_scene_logic(self.v_scene_logic_id, self)
  if self.v_is_fight_end then
    local scene_logic = SceneMgr:get_scene_logic()
    if scene_logic then
      scene_logic:create_random_door()
    end
  end
  
  local function scene_ready_cb(_, resp)
    self:record_scene_ready_respon(resp)
    self:_play_pre_fight_story()
  end
  
  self:_send_ready_scene_msg(scene_ready_cb)
end

function M:enter_room(on_load_scene)
  if SceneMgr:check_main_scene() then
    return
  end
  FightDataMgr:create_latest_hero_pos()
  if GAME_DEBUG then
    Util.add_debug_msg("_on_load_scene ")
  end
  SceneMgr:set_curtain_show(true)
  TimeLineSeqPlayer.on_enter_room()
  self:clear_view_before_enter_room()
  self.v_on_enter_room = true
  
  local function preload_res_cb()
    self:_preload_res_done_cb(on_load_scene)
  end
  
  if Util.is_client_only() then
    preload_res_cb()
  else
    self:preload_res(preload_res_cb)
  end
  local fight_type = TowerMgr and TowerMgr:get_fight_type()
  if fight_type == CommonDefine.CHALLENGE_TYPE.NEWBIE_TOWER and not on_load_scene then
    local loading = UIMgr:get_ui("loading")
    if not loading:visible() then
      loading:ui_show()
    end
  end
end

function M:cr_scene_ready_end_logic()
  if not self.v_tower:is_curse_ring_tower() then
    return
  end
  if self.v_room_info and self.v_room_info.status == ROOM_STATE_PASS then
    local scene_item_mgr = SceneMgr:get_scene_item_mgr()
    scene_item_mgr:create_award_point(self.v_room_num)
  end
  ChallengeRingPlusMgr:on_scene_ready()
end

function M:_on_reconnect()
  if self.v_rec_scene_ready then
    self.v_rec_scene_ready = false
    
    local function cb(ok, resp)
      self:scene_ready_end_logic(resp)
    end
    
    self:_send_ready_scene_msg(cb)
  end
end

function M:disconnect()
  self.v_rec_scene_ready = false
end

function M:_send_ready_scene_msg(cb)
  if not self.v_rec_scene_ready then
    Network:call("c2gs_scene_ready", {}, function(ok, resp)
      if ok and 0 == resp.errcode and cb then
        cb(ok, resp)
      end
    end)
  end
end

function M:init_room_preload()
  if not self.v_room_preload and self.room_preload_cfg then
    self.v_room_preload = require("gamelogic.tower_mgr.room_preload"):new(self.room_preload_cfg, nil, self.v_is_new_floor)
  end
end

function M:preload_res(cb)
  if not self.room_preload_cfg then
    if ShareRes.is_exist_config("scene_logic." .. self.v_scene_logic_id) then
      Log.Error("当前房间没有预加载配置！", self.v_scene_logic_id)
    end
    if cb then
      cb()
    end
    return
  end
  Global.sound_mgr:set_audio_active(false, true)
  if self.v_tower then
    self.v_tower:set_in_room_preload(true)
  end
  self:init_room_preload()
  self.v_room_preload:set_callback(cb)
end

function M:get_room_preload()
  self:init_room_preload()
  return self.v_room_preload
end

function M:record_scene_ready_respon(resp)
  self.v_scene_ready_respon = resp
end

function M:scene_ready_end_logic(resp)
  local scene_logic = SceneMgr:get_scene_logic()
  if not scene_logic then
    if not resp then
      Log.Error("scene_logic 获取失败", self.v_scene_logic_id, debug.traceback())
    end
    return
  end
  resp = resp or self.v_scene_ready_respon
  self.v_scene_ready_respon = nil
  self.v_rec_scene_ready = true
  print("c2gs scene_ready done")
  if self.v_is_first_enter then
    BehaviorMgr:call_event_fun("on_all_born_behavior")
  end
  local map_path = scene_logic:get_map_path()
  self:create_breakable_obj(map_path)
  if BattleTaskMgr then
    BattleTaskMgr:set_fight_time(resp.in_fight_sec)
  end
  if self.v_tower and self.v_tower.v_is_first_enter_floor then
    local hero_list = SceneMgr:get_hero_list()
    local wait_hero_list = {}
    for uuid, hero in pairs(hero_list) do
      if uuid ~= Global.hero_uuid then
        table.insert(wait_hero_list, hero)
      end
    end
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_FLOOR_START, Global.hero, wait_hero_list[1], wait_hero_list[2], self.v_tower.v_floor_num)
    self.v_tower.v_is_first_enter_floor = false
  end
  MsgGame:mq_publish2(Const.MSG_ON_SCENE_READY)
  SceneMgr:start_scene_logic()
end

function M:on_fight_end(is_win)
  self:set_fight_end(true)
  self.v_tower:on_pass_room(is_win)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_FIGHT_END)
  msg.mm_x = is_win
  local scene_logic = SceneMgr:get_scene_logic()
  scene_logic:create_random_door()
  local scene_item_mgr = SceneMgr:get_scene_item_mgr()
  scene_item_mgr:get_breakable_item()
  self:send_hero_born_pos()
  if self.v_tower:is_end_room() then
    self:check_auto_tp_next_floor()
    local floor_num = self.v_tower:get_floor_num()
    TowerMgr:check_tower_task_update(CommonDefine.TOWER_TASK_TYPE.PASS_FLOOR_NUM, false, floor_num)
  end
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH and self.v_tower:get_tower_pass() then
    TowerMgr:buddy_teach_floor_settle(true)
  end
end

function M:check_auto_tp_next_floor()
  local progress = TowerMgr:get_tower_progress()
  local fight_type = progress.challenge_type
  if fight_type == CommonDefine.CHALLENGE_TYPE.NEWBIE_TOWER then
    self.v_tower:go_to_next_floor_with_newbie_tower()
  elseif self.v_tower:is_need_auto_tp_next_floor() then
    if fight_type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
      local node_id = progress.node_id
      if ChapterMgr:check_node_is_first_save_suc(node_id) then
        return
      end
    end
    local max_floor_num = self.v_tower:get_max_floor()
    local cur_floor_num = math.max(self.v_tower:get_floor_num(), 1)
    if max_floor_num > cur_floor_num then
      local function tp_cb()
        self.v_tower:on_enter_floor(cur_floor_num + 1, false, true, false)
        
        self.v_auto_tp_next_floor_timer = nil
      end
      
      if fight_type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
        self.v_continue_tp_next_floor_cb = tp_cb
        TowerMgr:buddy_teach_floor_settle()
      else
        self.v_auto_tp_next_floor_timer = Timer:add_timer(TIMER_DESC, Config.AUTO_TP_NEXT_FLOOR_TIME, tp_cb)
      end
    end
  end
end

function M:check_need_send_save_req()
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
    local node_id = TowerMgr:get_cur_node_id()
    if node_id then
      local node_cfg = ShareRes.get_chapter_node_cfg(node_id)
      if self.v_room_id == node_cfg.LastRoomId then
        local is_first_save = ChapterMgr:check_node_is_first_save_suc(node_id)
        if is_first_save then
          local function cb(is_success, resp)
            if not StoryMgr:is_playing_full_screen_story() and is_first_save and resp.result_list and not StoryMgr:is_playing_full_screen_story() then
              local is_save = node_cfg.BehindNodeId ~= nil and node_cfg.BehindNodeId > 0
              
              local not_progress_battle_suc_settle = UIMgr:get_ui("not_progress_battle_suc_settle")
              if not_progress_battle_suc_settle:visible() then
                not_progress_battle_suc_settle:refresh_view(is_save, resp.result_list, node_cfg)
              else
                not_progress_battle_suc_settle:ui_show(is_save, resp.result_list, node_cfg)
              end
            end
            if condition then
            end
            if is_success then
              Util.show_message_tip(2172)
            else
              Util.show_message_tip(2075)
            end
          end
          
          TowerMgr:req_chapter_node_save(node_id, cb)
        else
          TowerMgr:change_to_next_node_id(nil, node_cfg)
        end
      end
    end
  end
end

function M:continue_tp_next_floor()
  if self.v_continue_tp_next_floor_cb then
    self.v_continue_tp_next_floor_cb()
    self.v_continue_tp_next_floor_cb = nil
    return true
  end
end

function M:have_tp_next_floor_cb()
  return self.v_continue_tp_next_floor_cb ~= nil
end

function M:get_random_seed()
  return self.v_random_seed or os.time()
end

function M:set_random_seed(seed)
  self.v_random_seed = seed
end

function M:pass_room_open_ring()
  if not self.v_rec_scene_ready then
    self.v_get_ring_info_success = true
    return
  end
  if self.v_room_info.status == ROOM_STATE_PASS then
    self:challenge_ring_logic()
  end
end

function M:is_treasure_room()
  return false
end

function M:is_restore_hp_room()
  return false
end

function M:is_no_fight_game_room()
  return false
end

function M:is_upload_skill_hit()
  return self.v_is_upload_skill_hit
end

function M:is_fight_end()
  return self.v_is_fight_end
end

function M:get_room_type()
  return self.room_cfg.Type
end

function M:challenge_ring_logic()
  local room_type = self:get_room_type()
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic and scene_logic:is_fun_npc_have_drop() then
    return
  end
  if room_type == ROOM_TYPE.CHALLENGE or room_type == ROOM_TYPE.PUZZLE then
    if self.v_get_all_drop_item then
      DropShowMgr:open_drop_show_state(true, DROP_TYPE.CONTINUE)
    end
  elseif not DropShowMgr:is_have_drop_item() then
    DropShowMgr:open_drop_show_state(true, DROP_TYPE.CONTINUE)
  end
end

function M:is_get_all_drop_item()
  return self.v_get_all_drop_item
end

function M:response_drop_event(msg)
  if nil == msg or nil == msg.mm_x then
    return
  end
  local drop_state = msg.mm_x
  self.v_get_all_drop_item = drop_state
end

function M:get_tp_is_locked(tp_idx)
  return self.v_tower:get_tp_is_locked(self.v_room_num, tp_idx)
end

function M:response_get_ring_info()
  self:pass_room_open_ring()
end

function M:_response_interact_with_door(msg)
  local tp_idx = msg.mm_obj
  local is_in = msg.mm_x
  if not is_in then
    return
  end
  local condition, condition_str = self.v_tower:get_tp_condition(self.v_room_num, tp_idx)
  if not condition then
    Log.Error("get room condition cfg failure! room_num=", self.v_room_num, " tp_idx=", tp_idx)
    return
  end
  local can_tp = false
  for _, v in pairs(condition) do
    can_tp = can_tp or Condition:check_condition(v)
  end
  if can_tp then
    self.v_tower:unlock_tp_door(self.v_room_num, tp_idx)
  else
    local str = ""
    for _, v in pairs(condition) do
      local cfg = ShareRes.create("battle.battle_condition", v)
      if cfg then
        if "" ~= str then
          str = str .. Util.format_str("或") .. cfg.Desc
        else
          str = str .. cfg.Desc
        end
      else
        Log.Error("get battle_condition failure! condition_id=", v)
      end
    end
    self.v_tower:show_tp_lock_notice(self.v_room_num, tp_idx, condition_str or str)
  end
end

function M:response_born_anim_end()
  if TowerMgr then
    local fight_type = TowerMgr:get_fight_type()
    if WeeklyMgr and WeeklyMgr:check_weekly_fight(fight_type) then
      UIMgr:get_ui("weekly_pvp_fight_tip"):ui_show()
    end
  end
  local delay_magic_cfg = ShareRes.create("tower.tower_room_delay_magic", self.v_room_id)
  if delay_magic_cfg and delay_magic_cfg.IsHaveAnimation == HAVE_ANIMATION.YES then
    UIMgr:get_ui("fight_room_delay_add_magic"):ui_show(delay_magic_cfg, self.v_is_fight_end)
  end
end

function M:create_breakable_obj(map_path)
  if not map_path then
    Log.Error("map path is not exist !")
    return
  end
  local path = map_path .. ".breakable"
  local replace_path = string.gsub(path, "%.", "/")
  local total_path = PathDefine.config_dir .. replace_path .. ".lua"
  local file = io.open(total_path, "r")
  if not file then
    return
  else
    file:close()
  end
  local scene_breakable_cfg = ShareRes.create(path)
  if not scene_breakable_cfg then
    Log.Info("scene breakable not exist, path =", path)
    return
  end
  local room_breakable_cfg = scene_breakable_cfg[self.v_room_id]
  if not room_breakable_cfg then
    Log.Info("room breakable not exist, room id =", self.v_room_id)
    return
  end
  local scene_map = SceneMgr:get_scene_map()
  local scene_container = scene_map:get_scene_container()
  local breakable_root_go = scene_container:Get(BREAKABLE_ROOT_NAME)
  if not breakable_root_go then
    Log.Info("scene breakable not exist, path =", path)
    return
  end
  local container = breakable_root_go:GetComponent(TypeSceneContainer)
  if not container then
    Log.Error("container is not exist ")
    return
  end
  local breakable_list = room_breakable_cfg.BreakableItemList
  for breakable_id, cfg in ipairs(breakable_list) do
    local go_name = cfg.Name
    local go = container:Get(go_name)
    local pos = go.transform.position
    local lua_obj = BREAKABLE_OBJ_CLASEE:new(pos, cfg, breakable_id)
    _insert(self.v_breakable_obj_list, lua_obj)
    local cid = go:GetInstanceID()
    lua_obj:init_gameobj(cid, go, go.transform)
    SceneMgr:add_client_obj(cid, lua_obj)
  end
end

function M:clear_breakable_obj()
  for _, lua_obj in ipairs(self.v_breakable_obj_list) do
    lua_obj:on_destroy_luaobj()
    local cid = lua_obj.gameobj:GetInstanceID()
    SceneMgr:remove_client_obj(cid)
  end
  self.v_breakable_obj_list = {}
end

function M:is_rec_scene_ready()
  return self.v_rec_scene_ready
end

local send_data

function M:send_hero_born_pos(force)
  if TowerMgr then
    local fight_type = TowerMgr:get_fight_type()
    if force or nil ~= fight_type and fight_type ~= CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER then
      local hero = Global.hero
      if hero and self:is_rec_scene_ready() then
        local is_in_tp_area, is_released = hero:is_in_tp_area()
        local is_in_moving_plat = hero:is_in_move_plat()
        if not is_in_tp_area and not is_released and not is_in_moving_plat then
          send_data = send_data or {}
          send_data[1], send_data[2], send_data[3] = hero:get_pos()
          SceneMgr:c2gs_call_scene("report_position", send_data)
        end
      end
    end
  end
end

function M:cancel_footmark()
  self.v_cancel_footmark = true
end

function M:get_is_cancel_footmark()
  return self.v_cancel_footmark
end

function M:get_room_name()
  return self.room_cfg.RoomName
end

function M:get_room_trace_data()
  if not TowerMgr then
    return
  end
  local mission_type = TowerMgr:get_trace_mission_type()
  if not mission_type then
    return
  end
  local tower_uuid = self.v_tower:get_tower_uuid()
  if not tower_uuid then
    return
  end
  local hero_hp = {}
  local hero_list = SceneMgr:get_hero_list()
  for _, hero in pairs(hero_list) do
    local hero_id = hero.buddy_cfg.Id
    local attr_mgr = hero.attr_mgr
    local hp_val = attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
    hero_hp["hero_id" .. hero_id] = {hero_id = hero_id, hp_val = hp_val}
  end
  local data = {
    mission_type = mission_type,
    unique_id = tower_uuid,
    room_id = self.v_room_id,
    hero_hp = hero_hp
  }
  return data
end

function M:enter_room_trace_data()
  local trace_data = self:get_room_trace_data()
  if not trace_data then
    return
  end
  local way_type = self.v_tower:get_enter_room_way()
  way_type = way_type or ROOM_WAY_TYPE.def_enter
  trace_data.type = way_type
  SDKTrack:trace_change_room(trace_data)
end

function M:exit_room_trace_data()
  local trace_data = self:get_room_trace_data()
  if not trace_data then
    return
  end
  local enter_new_way_type = self.v_tower:get_enter_room_way()
  enter_new_way_type = enter_new_way_type or ROOM_WAY_TYPE.def_enter
  local exit_type
  if enter_new_way_type == ROOM_WAY_TYPE.def_enter then
    exit_type = ROOM_WAY_TYPE.def_exit
  elseif enter_new_way_type == ROOM_WAY_TYPE.tp_enter or enter_new_way_type == ROOM_WAY_TYPE.reborn_enter then
    exit_type = ROOM_WAY_TYPE.tp_exit
  end
  trace_data.type = exit_type
  local now_time = Global.real_time
  trace_data.duration = now_time - self.v_enter_time
  SDKTrack:trace_change_room(trace_data)
end

function M:set_start_hero_hp_data()
  local hero_hp = {}
  local hero_list = SceneMgr:get_hero_list()
  for _, hero in pairs(hero_list) do
    local hero_id = hero.buddy_cfg.Id
    local attr_mgr = hero.attr_mgr
    local hp_val = attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
    hero_hp["hero_id" .. hero_id] = {hero_hp = hp_val}
  end
  self.v_fight_hp_data = hero_hp
end

function M:set_battle_data(hurt_val, dodge_num, injured_val, trap_hurt_val)
  if not self.v_battle_info then
    self.v_battle_info = {
      hero_all_hurt = 0,
      hero_dodge_num = 0,
      all_injured = 0,
      injured_num = 0,
      trap_hurt = 0,
      trap_hurt_num = 0
    }
  end
  local data = self.v_battle_info
  if hurt_val and 0 ~= hurt_val then
    data.hero_all_hurt = data.hero_all_hurt + hurt_val
  end
  if dodge_num and 0 ~= dodge_num then
    data.hero_dodge_num = data.hero_dodge_num + dodge_num
  end
  if injured_val and 0 ~= injured_val then
    data.all_injured = data.all_injured + injured_val
    data.injured_num = data.injured_num + 1
  end
  if trap_hurt_val and 0 ~= trap_hurt_val then
    data.trap_hurt = data.trap_hurt + trap_hurt_val
    data.trap_hurt_num = data.trap_hurt_num + 1
  end
end

function M:fight_trace()
  if self.v_trace_battle then
    return
  end
  if not TowerMgr then
    return
  end
  local fight_type = TowerMgr:get_fight_type()
  if fight_type == CommonDefine.CHALLENGE_TYPE.BUDDY_TEACH then
    self:trace_teaching_data()
    return
  end
  local mission_type = TowerMgr:get_trace_mission_type()
  if not mission_type then
    return
  end
  local tower_uuid = self.v_tower:get_tower_uuid()
  if not tower_uuid then
    return
  end
  local battle_type = SceneMgr:get_battle_monster_type()
  if not battle_type then
    return
  end
  local hero_list = SceneMgr:get_hero_list()
  for _, hero in pairs(hero_list) do
    local hero_id = hero.buddy_cfg.Id
    local attr_mgr = hero.attr_mgr
    local cur_hp_val = attr_mgr:get_attr(ATTR_TYPE.CHAR_HP)
    local key = "hero_id" .. hero_id
    if self.v_fight_hp_data[key] then
      local last_hp = self.v_fight_hp_data[key].hero_hp
      self.v_fight_hp_data[key].lost_hp = last_hp - cur_hp_val
    end
  end
  local result = self.v_is_fight_end and 1 or 2
  local data = {
    duration = Global.real_time - self.v_enter_time,
    mission_type = mission_type,
    unique_id = tower_uuid,
    room_id = self.v_room_id,
    battle_id = self.v_fight_uuid,
    battle_type = battle_type,
    result_info = {
      result = result,
      hero_info = self.v_fight_hp_data,
      battle_info = self.v_battle_info
    }
  }
  SDKTrack:trace_fight_state_change(data)
  self.v_battle_info = nil
  self.v_trace_battle = true
end

function M:trace_teaching_data()
  local result = self.v_is_fight_end and 1 or 2
  local point_id = TowerMgr:get_cur_point_id()
  if not self.v_is_fight_end then
    TowerMgr:add_teaching_fail_num(point_id)
  end
  local teach_data = TowerMgr:get_teaching_trace_data(point_id)
  local trace_data = {
    room_id = self.v_room_id,
    teaching_info = teach_data
  }
  SDKTrack:trace_teaching_battle(trace_data)
  TowerMgr:reset_teaching_trace_data()
end

function M:get_room_preload_cfg()
  return self.room_preload_cfg
end

function M:set_check_node_stroy(check_node_stroy)
  self.v_check_node_stroy = check_node_stroy
end

function M:set_fight_end(is_fight_end)
  self.v_is_fight_end = is_fight_end
end

function M:clear_view_before_enter_room()
  UIMgr:remove_stace_by_ui_name("ui_chapter_detail")
  UIMgr:try_destory_ui("ui_chapter_detail")
  UIMgr:try_destory_ui("team")
end

function M:is_on_enter_room()
  return self.v_on_enter_room
end

function M:set_pre_fight_story_play_state(state)
  self.v_pre_fight_story_play_state = state
end

function M:on_pre_fight_play(state)
  if not SceneMgr:get_scene_logic() then
    return
  end
  if self.v_pre_fight_story_play_state == state then
    self.v_pre_fight_story_play_state = PRE_FIGHT_STORY_STATE.NONE
    self:_pre_fight_story_cb()
  end
end

return M
