local Base = require("manager.sdk.base_sdk_mgr")
local Json = require("utils.json")
local M = Util.create_child_mt(Base)
local Account = require("gamelogic.account.account")
local LuaObjPoolMgr = require("manager.res.lua_obj_pool_mgr")
local TSISDKManager = CS.Game.TSISDKManager
local CSSDKManager = CS.Game.SDKManager
local SDKConst = CS.Game.TSISDKConst
local Handler = Util.create_class()
local UnitySystemInfo = UnityEngine.SystemInfo

function M:_init()
  Base._Init(self)
  self.v_handler_dic = {}
  TSISDKManager.RegisterLuCallback(function(type, param)
    self:_on_sdk_callback(type, param)
  end)
  self:_init_default_products()
  self:init_ios_purchse_products()
  local channel_id_string = self:get_sub_channel_id()
  if "" ~= channel_id_string then
    local channel_id = tonumber(channel_id_string)
    local channel_cfg = ShareRes.create("common.tc_channel", channel_id)
    if not channel_cfg then
      Log.Error("channel_cfg is nil, channel_id=", channel_id_string)
      return false
    end
    self.v_channel_cfg = channel_cfg
  end
  self:_register_callback(SDKConst.LoginSuccess)
  self:_register_callback(SDKConst.LoginFailed)
  self:_register_callback(SDKConst.LogoutFailed)
  self:_register_callback(SDKConst.LogoutSuccess)
  self:_register_callback(SDKConst.OnNoExitProvider)
end

function M:init_products()
end

function M:init_ios_purchse_products()
  if UNITY_IOS then
    local list = ShareRes.create("all_recharge_key")
    local products = {}
    for sdkkey, _ in pairs(list) do
      local tb = {id = sdkkey, type = 0}
      products[tb.id] = tb
    end
    CS.Game.PurchasingManager.Instance:InitProduct(products)
  end
end

local function _log(log, ...)
  if GAME_DEBUG then
    Log.Info("[Lua_SDK] " .. log, ...)
  else
    Log.Info("[Lua_SDK] " .. log)
  end
end

local PROCCESS_FUNC = {
  [SDKConst.LoginSuccess] = {
    custom_cb = function(mgr, response)
      mgr:on_sdk_login_success(response)
      mgr:set_is_logining(false)
      ScreenMaskMgr:force_close()
    end
  },
  [SDKConst.LoginFailed] = {
    custom_cb = function(mgr, response)
      mgr:set_is_logining(false)
      ScreenMaskMgr:force_close()
    end
  },
  [SDKConst.LogoutSuccess] = {
    custom_cb = function(mgr, response)
      mgr:set_is_logining(false)
      mgr:on_sdk_logout_success(response)
    end
  },
  [SDKConst.LogoutFailed] = {
    custom_cb = function(mgr, response)
      mgr:set_is_logining(false)
      mgr:on_sdk_logout_failed(response)
    end
  },
  [SDKConst.OnNoExitProvider] = {
    custom_cb = function(mgr, response)
      mgr:show_exit_game_popup()
    end
  },
  [SDKConst.PaySuccess] = {},
  [SDKConst.PayFailed] = {},
  [SDKConst.PayCancel] = {}
}

function Handler:_init(mgr, type, cb)
  self.v_mgr = mgr
  self.v_type = type
  self.v_config = PROCCESS_FUNC[type]
  self.v_cb = cb
end

function Handler:process(response)
  if self.v_cb then
    self.v_cb(response)
  end
  local custom_cb = self.v_config and self.v_config.custom_cb
  if custom_cb then
    custom_cb(self.v_mgr, response)
  end
  local event = self.v_config and self.v_config.event
  if event then
    local msg = MsgGame:mq_publish2(event)
    msg.mm_obj = response
  end
end

function Handler:on_destroy()
  self.v_type = nil
  self.v_mgr = nil
  self.v_config = nil
  self.v_cb = nil
end

function M:_on_sdk_callback(type, response)
  _log("on_sdk_callback ", type)
  local config = PROCCESS_FUNC[type]
  local handler = self.v_handler_dic[type]
  if config then
    if handler then
      handler:process(response)
    elseif config.event then
      local msg = MsgGame:mq_publish2(config.event)
      msg.mm_obj = response
    end
  else
    Log.Error("no defined sdk callback type! type=", type)
  end
end

function M:_register_callback(type, cb)
  local config = PROCCESS_FUNC[type]
  if config then
    local handler = Handler:new(self, type, cb)
    local old_handler = self.v_handler_dic[type]
    if old_handler then
      old_handler:on_destroy()
    end
    self.v_handler_dic[type] = handler
  else
    Log.Error("register callback failed! type=", type)
  end
end

function M:_android_buy_product(product_id, price, cb)
  if not self:_check_valid() then
    cb(false)
    return
  end
  local send_data = {
    product_id = product_id,
    tsi_custom = TSISDKManager.GetAndroidPaySdkCustom(product_id)
  }
  Network:call("c2gs_new_recharge_order", send_data, function(ok, resp)
    if ok then
      local order_id = resp.order_id
      local sdk_custom = resp.tsi_custom
      local open_transaction_id = resp.open_transaction_id
      TSISDKManager.SetOrderEvent(open_transaction_id, price)
      
      local function pay_success_cb()
        TSISDKManager.SetPaymentEvent(open_transaction_id, price)
        if cb then
          cb(true)
        end
      end
      
      local function sdk_pay_failed_cb(reason)
        if cb then
          cb(false)
        end
      end
      
      local function pay_cancel_cb()
        if cb then
          cb(false)
        end
      end
      
      self:_register_callback(SDKConst.PaySuccess, pay_success_cb)
      self:_register_callback(SDKConst.PayFailed, sdk_pay_failed_cb)
      self:_register_callback(SDKConst.PayCancel, pay_cancel_cb)
      TSISDKManager.CallAndroidSdkPay(sdk_custom)
    elseif cb then
      cb(false)
    end
  end)
end

function M:_ios_buy_product(product_id, price, cb)
  if not self:_check_valid() then
    cb(false)
    return
  end
  
  local function pay_success_cb()
    if cb then
      cb(true)
    end
  end
  
  local send_data1 = {product_id = product_id}
  Network:call("c2gs_new_recharge_order", send_data1, function(ok, resp)
    if ok then
      local order_id = resp.order_id
      local open_transaction_id = resp.open_transaction_id
      
      local function ios_pay_success(payload)
        local send_data2 = {
          order_id = order_id,
          open_transaction_id = open_transaction_id,
          ios_receipt = payload
        }
        Network:call("c2gs_ios_recharge_call_back", send_data2, function(ok, resp)
          if ok then
            pay_success_cb()
          elseif cb then
            cb(false)
          end
        end)
      end
      
      local function sdk_pay_failed_cb(reason)
        if cb then
          cb(false)
        end
      end
      
      CS.Game.PurchasingManager.Instance:Purchase(product_id, ios_pay_success, sdk_pay_failed_cb)
    elseif cb then
      cb(false)
    end
  end)
end

function M:_is_use_official_server()
  if not self.v_channel_cfg then
    return false
  end
  return not self.v_channel_cfg.use_channel_server
end

function M:is_third_party_channel()
  if not self.v_channel_cfg then
    return true
  end
  return self.v_channel_cfg.id > 52000 and self.v_channel_cfg.id < 53000
end

function M:logout(is_account_deleted, on_sdk_logout_success)
  Util.show_notify_popup_message(function()
    if self:_check_valid() and self:had_sdk_login() then
      TSISDKManager.Logout()
    elseif PlayerMgr then
      PlayerMgr:logout_game_server()
    end
    if on_sdk_logout_success then
      on_sdk_logout_success()
    end
  end, "退出登录", "登出", "确定", "取消", nil, false)
end

function M:login()
  if not self:_check_valid() or self:is_logining() or self:had_sdk_login() then
    return
  end
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    UIMgr:get_ui("ui_qrcode_login"):ui_show()
    return
  end
  ScreenMaskMgr:open_one_tag("logout", math.huge, false)
  self:set_is_logining(true)
  TSISDKManager.Login()
end

function M:had_sdk_login()
  return self.v_tsi_sdk_custom ~= nil
end

function M:on_login_game_server_failed()
  Base.on_login_game_server_failed(self)
  self.v_tsi_sdk_custom = nil
end

function M:on_sdk_login_success(sdk_response)
  Base.on_sdk_login_success(self, sdk_response)
  self.v_tsi_sdk_custom = sdk_response
  Log.Info("on_sdk_login_success")
end

function M:on_sdk_logout_success(sdk_response)
  Base.on_sdk_logout_success(self, sdk_response)
  self.v_tsi_sdk_custom = nil
  Log.Info("on_sdk_logout_success")
end

function M:on_sdk_logout_failed(sdk_response)
  Base.on_sdk_logout_success(self, sdk_response)
  self.v_tsi_sdk_custom = nil
  Log.Info("on_sdk_logout_success")
end

function M:on_game_server_auth_success(info)
  local open_user_id = info.account_id
  self.v_sdk_user_id = open_user_id
  CS.Game.TSISDKManager.UpdateUserInfo(open_user_id)
end

function M:_submit_role_data(type)
  if not self:_check_valid() then
    return
  end
  local connect_info = Global.connect_info
  local base_info = PlayerMgr:get_player_base_info()
  local role_id = Global.player_uuid
  local role_name = base_info.name
  local role_level = base_info.lv
  local server_id = connect_info.id
  local server_name = connect_info.name
  local param = {
    [SDKConst.dataType] = tostring(type),
    [SDKConst.roleId] = role_id,
    [SDKConst.roleName] = role_name,
    [SDKConst.roleLevel] = role_level,
    [SDKConst.serverId] = server_id,
    [SDKConst.serverName] = server_name
  }
  _log("call SubmitRoleData", param)
  TSISDKManager.SubmitRoleData(param)
end

function M:enter_login()
  Base.enter_login(self)
  self.v_tsi_sdk_custom = nil
end

function M:enter_game()
end

function M:create_role()
  if not self:_check_valid() then
    return
  end
  SDKTrack:trace_create_role()
end

function M:level_up()
  if not self:_check_valid() then
    return
  end
  self:_submit_role_data(SDKConst.upgradeRole)
end

function M:game_login()
  if not self:_check_valid() then
    return
  end
  self:_submit_role_data(SDKConst.loginRole)
end

function M:has_user_center()
  return self:_check_valid() and TSISDKManager.IsShowUserCenter()
end

function M:get_sub_channel_id()
  local channel_id = TSISDKManager.GetChannelId()
  return channel_id
end

function M:open_user_center()
  if not self:_check_valid() then
    return
  end
  TSISDKManager.EnterUserCenter(false)
end

function M:open_help_center()
  if not self:_check_valid() then
    return
  end
  TSISDKManager.EnterUserCenter(true)
end

function M:open_web_view(url)
  Base.open_web_view(self, url)
end

function M:is_show_exchange_code_btn_in_more_entry()
  if IS_STAGING and UNITY_IOS then
    return false
  end
  return true
end

function M:is_show_notice_btn()
  return self:_check_valid() and TSISDKManager.IsShowNotice()
end

function M:is_show_logout()
  return self:_check_valid() and TSISDKManager.IsShowLogout()
end

function M:is_show_vip()
  return self:_check_valid() and TSISDKManager.IsShowBBS()
end

function M:check_requestion()
  if not self:_check_valid() then
    return
  end
  TSISDKManager.CheckRequestion()
end

function M:show_requestion()
  if not self:_check_valid() then
    return
  end
  TSISDKManager.ShowRequestion()
end

function M:switch_account()
  if not self:_check_valid() then
    return
  end
  TSISDKManager.SwitchAccount()
end

function M:exit_game()
  if UNITY_EDITOR then
    return
  end
  if UNITY_IOS then
    self:show_exit_game_popup()
  else
    TSISDKManager.ExitGame()
  end
end

function M:show_vip()
  TSISDKManager.ShowVip()
end

function M:get_game_id()
  return self:_check_valid() and TSISDKManager.GetGameId()
end

function M:get_client_id()
  return self:_check_valid() and TSISDKManager.GetClientId()
end

function M:get_open_user_id()
  return self:_check_valid() and TSISDKManager.GetOpenUserId()
end

function M:qq_join_group()
end

function M:add_login_request_params(body)
  if not self:_check_valid() then
    return
  end
  Base.add_login_request_params(self, body)
  body.device_id = CSSDKManager.GetUniqueDeviceId()
  body.channel = self:get_sub_channel_id()
  if UNITY_IOS then
    body.is_trackingio = true
    local idfa = CSSDKManager.GetUniqueDeviceId()
    if Util.is_empty(idfa) then
      idfa = "00000000-0000-0000-0000-000000000000"
    end
    local idfv = UnityEngine.iOS.Device.vendorIdentifier
    body.idfa = idfa
    body.idfv = idfv
    body.package_name = "com.tiancity.blackbeacon.ap"
    body.ua = UnitySystemInfo.deviceModel .. " " .. UnityEngine.iOS.Device.systemVersion
    body.trackingio_distinct_id = idfv
    Log.Error("登录body", body)
  end
end

do
  local buy_product_tag = "buy_product"
  local network_error_msg = Util.get_error_code_msg(2180)
  local retry_content = LanguageMgr:get_code_text("410")
  
  function M:buy_product(config, cb)
    if UNITY_EDITOR or UNITY_STANDALONE_WIN then
      Util.show_notify_popup_message(nil, "模拟器暂不支持充值，请前往移动端充值", nil, nil, nil, nil, true)
      if cb then
        cb(false)
      end
      return
    end
    local mask_time = UNITY_ANDROID and 5 or math.huge
    ScreenMaskMgr:open_one_tag(buy_product_tag, mask_time, false)
    
    local function callback(result)
      ScreenMaskMgr:close_one_tag(buy_product_tag)
      if cb then
        cb(result)
      end
    end
    
    if not self:_check_valid() then
      callback(false)
      return
    end
    if not self:is_product_valid(config) then
      callback(false)
      return
    end
    local product_id = self:get_sdkkey(config)
    local price = config.ShowPrice
    if UNITY_ANDROID then
      self:_android_buy_product(product_id, price, callback)
    elseif UNITY_IOS then
      self:_ios_buy_product(product_id, price, callback)
    end
  end
  
  function M:check_sensitive(content)
    if not self:_check_valid() then
      return
    end
    return TSISDKManager.CheckSensitive(content)
  end
end

function M:get_login_game_server_url(host)
  local device_type = Account:get_device_type()
  local account = self:get_sdk_account()
  local mac_address = CSSDKManager.GetUniqueDeviceId()
  local channel_id = SDKManager:get_sub_channel_id()
  local host_content = host .. "platform=%s&device_type=%s&account_id=%s&mac_address=%s&version=%s&auth_token=A9Cz4sv0O8&tsi_custom=%s&channel_id=%s"
  local url = string.format(host_content, self.v_platform, device_type, account, mac_address, Util.get_login_version(), self.v_tsi_sdk_custom, channel_id)
  return url
end

function M:get_server_list_json_url()
  if IS_STAGING then
    return "https://cdnblackbeacon.mtiancity.com/sliebiao/shen/server_list.json?time=" .. Date.server_time()
  elseif self:_is_use_official_server() then
    return "https://cdnblackbeacon.mtiancity.com/sliebiao/live/server_list.json?time=" .. Date.server_time()
  else
    return "https://cdnblackbeacon.mtiancity.com/sliebiao/live-qd/server_list.json?time=" .. Date.server_time()
  end
end

function M:get_notice_url(picture)
  local file = picture or "maintenance_notice.json"
  local url = "https://cdnblackbeacon.mtiancity.com/notice/%s/%s?time=" .. Date.server_time()
  if GAME_DEBUG or PUBLISH_GM then
    url = string.format(url, "debug", file)
  else
    url = string.format(url, "release", file)
  end
  return url
end

function M:is_enable_qrcode_login()
  if GAME_RELEASE or self:is_simulator() then
    return false
  end
  return true
end

function M:is_enable_feedback_in_login()
  return false
end

function M:is_show_privacy_policy_btn_in_more_entry()
  if not UNITY_EDITOR and UNITY_STANDALONE_WIN then
    return true
  end
  if not self.v_channel_cfg then
    return false
  end
  return not self.v_channel_cfg.not_show_privacy
end

function M:open_privacy_policy()
  if UNITY_STANDALONE_WIN then
    UIMgr:get_ui("ui_user_agreement_tips"):ui_show()
  else
    ScreenMaskMgr:open_one_tag("privacy_policy", math.huge, false)
    TSISDKManager.GameRequestTsiPrivate()
    Timer:add_timer("close_privacy_policy", 3, function()
      ScreenMaskMgr:close_one_tag("privacy_policy")
    end)
  end
end

function M:is_show_delete_account_in_more_entry()
  if not self.v_channel_cfg then
    return false
  end
  return self.v_channel_cfg.show_delete_account
end

function M:is_show_user_center_btn_in_more_entry()
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    return false
  end
  return not self:is_third_party_channel()
end

function M:is_show_help_center_btn_in_more_entry()
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    return false
  end
  return true
end

function M:is_show_community_btn_in_more_entry()
  return false
end

function M:clear_sensitive_cache()
  TSISDKManager.ClearSensitiveCache()
end

function M:is_auto_login_game_after_login_sdk()
  return true
end

function M:is_enable_ta_guide_track()
  return false
end

function M:check_sdk_notice_is_show(channel_str_list)
  if not channel_str_list then
    return false
  end
  local channel_id = self:get_sub_channel_id()
  local channel_list = Json.decode(channel_str_list)
  for _, info in pairs(channel_list) do
    if info.channel_id == tostring(channel_id) then
      return true
    end
  end
  return false
end

return M
