local E = require("ejoysdk_lua.ejoysdk")
local EV = require("ejoysdk_lua.ejoysdk_vendors")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EUTIL = require("ejoysdk_lua.ejoysdk_utils")
local LUTIL = require("ejoysdk_lua.native.utils.Utils")
local ejoysdk_init = require("ejoysdk_lua.ejoysdk_init")
local ejoysdk_topic = require("ejoysdk_lua.ejoysdk_topic")
local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local xpcall = compat.xpcall
local EM = require("ejoysdk_lua.ejoysdk_module")
local bitutil = compat.bitutil
local ejoysdk_chat
local JSON = require("ejoysdk_lua.ejoysdk_json")
local BADGE_MGR
local M = {}
local init_opts
local TAG = EM.MODULE.NATIVE .. "core.init"
local module_listeners = {}
local module_push = "push"
local module_chat = "chat"
local module_friend = "friend"
local module_anns_v2 = "anns_v2"
local module_voice = "voice"
local module_chat_v2 = "chat_v2"
local Features = {
  SUPPORT_LOGIN_TO_PLATFORM = 1,
  SUPPORT_ANNOUNCEMENT = bitutil.lshift(1, 1),
  SUPPORT_FRIEND = bitutil.lshift(1, 2),
  SUPPORT_CHAT = bitutil.lshift(1, 3),
  SUPPORT_SENSITIVE = bitutil.lshift(1, 4),
  SUPPORT_PUSH = bitutil.lshift(1, 5),
  SUPPORT_AGE = bitutil.lshift(1, 6),
  SUPPORT_FAVOR = bitutil.lshift(1, 7),
  SUPPORT_BADGE = bitutil.lshift(1, 8),
  SUPPORT_VOICE = bitutil.lshift(1, 9),
  SUPPORT_ANNOUNCEMENT_V2 = bitutil.lshift(1, 10),
  SUPPORT_CHAT_V2 = bitutil.lshift(1, 11)
}
local AnnV2_Listeners = {
  "block_announcement_listener"
}
local ChatV2_Listeners = {
  chat_state_listener = "info_chat_state",
  chat_session_change_listener = "info_chat_session_change",
  chat_msgs_listener = "info_chat_msgs",
  chat_changes_listener = "info_group_changes",
  chat_system_msg_listener = "info_group_system_msg",
  chat_rpc_result_listener = "info_chat_rpc_result",
  chat_handlers_error_listener = "on_handlers_error"
}
local SDKConfig_Features_Map = {
  LOGIN_TO_PLATFORM = 1,
  ANNOUNCEMENT = bitutil.lshift(1, 1),
  FRIEND = bitutil.lshift(1, 2),
  CHAT = bitutil.lshift(1, 3),
  SENSITIVE = bitutil.lshift(1, 4),
  PUSH = bitutil.lshift(1, 5),
  AGE = bitutil.lshift(1, 6),
  FAVOR = bitutil.lshift(1, 7),
  BADGE = bitutil.lshift(1, 8),
  VOICE = bitutil.lshift(1, 9),
  ANNOUNCEMENT_V2 = bitutil.lshift(1, 10),
  CHAT_V2 = bitutil.lshift(1, 11)
}
local Bit2FeatName = {
  [Features.SUPPORT_ANNOUNCEMENT] = "ANNOUNCEMENT",
  [Features.SUPPORT_FAVOR] = "FAVOR",
  [Features.SUPPORT_AGE] = "AGE",
  [Features.SUPPORT_PUSH] = "PUSH",
  [Features.SUPPORT_FRIEND] = "FRIEND",
  [Features.SUPPORT_SENSITIVE] = "SENSITIVE",
  [Features.SUPPORT_CHAT_V2] = "CHAT_V2",
  [Features.SUPPORT_CHAT] = "CHAT",
  [Features.SUPPORT_LOGIN_TO_PLATFORM] = "LOGIN_TO_PLATFORM",
  [Features.SUPPORT_BADGE] = "BADGE",
  [Features.SUPPORT_ANNOUNCEMENT_V2] = "ANNOUNCEMENT_V2",
  [Features.SUPPORT_VOICE] = "VOICE"
}

local function get_init_opts(opts)
  if type(opts) == "string" and "auto" == opts then
    local login_sdks = EV.get_native_vendors(EV.ABILITY.ACCOUNT)
    local pay_sdks = EV.get_native_vendors(EV.ABILITY.PAY)
    opts = {}
    for _, sdk in pairs(login_sdks) do
      opts[sdk] = {}
    end
    for _, sdk in pairs(pay_sdks) do
      opts[sdk] = {}
    end
  else
    opts = opts or {}
  end
  E.LOG.debug(TAG, "check init opts before >>")
  local sdk_infos = UNI.get_sdk_infos()
  for sdk_name, sdk_info in pairs(sdk_infos) do
    if nil == opts[sdk_name] then
      E.LOG.debug(TAG, "opts add native sdk: " .. tostring(sdk_name))
      sdk_info = sdk_info or {}
      local meta_info = sdk_info.meta or {}
      opts[sdk_name] = meta_info
    end
  end
  for vendor_name, options in pairs(opts) do
    if options._disable then
      E.LOG.debug(TAG, "vendor is disable, so remove it from opts:" .. vendor_name)
      opts[vendor_name] = nil
    end
  end
  E.LOG.debug(TAG, "check_init_opts opts after >>")
  return opts
end

local function tick()
  local function tick_func()
    ejoysdk_chat.tick()
  end
  
  xpcall(tick_func, function(x)
    E.LOG.w(TAG, {
      error_msg = tostring(x)
    })
  end)
  E.Timer.once(1, tick)
end

local function init_chat(chat_handlers, acc_chat_handlers)
  ejoysdk_chat = require("ejoysdk_lua.chat.ejoysdk_chat")
  ejoysdk_init.chat(chat_handlers)
  if acc_chat_handlers then
    ejoysdk_init.account_chat(acc_chat_handlers)
  end
  E.Timer.once(1, tick)
end

local function init_chat_v2(chat_listeners, _options)
  local native_chat = require("ejoysdk_lua.native.modules.chat.chat")
  native_chat.init(_options or {}, chat_listeners)
end

local function init_voice(voice_listener)
  if voice_listener then
    local ejoysdk_voice = require("ejoysdk_lua.chat.ejoysdk_voice")
    ejoysdk_voice.set_listener(voice_listener)
  end
end

local function init_badge()
  BADGE_MGR = require("ejoysdk_lua.badge.ejoysdk_badge_manager")
  BADGE_MGR.init()
end

local function init_features(features)
  local need_init_friend = false
  local friend_init_func = ejoysdk_init.friend
  local friend_listeners
  local need_init_chat = false
  local need_init_chat_v2 = false
  local chat_init_func = init_chat
  local chat_listeners
  local enable_voice = false
  local acc_chat_listeners
  local map = {
    [Features.SUPPORT_ANNOUNCEMENT] = ejoysdk_init.launcher,
    [Features.SUPPORT_FAVOR] = ejoysdk_init.favor,
    [Features.SUPPORT_AGE] = ejoysdk_init.age,
    [Features.SUPPORT_PUSH] = ejoysdk_init.push,
    [Features.SUPPORT_FRIEND] = friend_init_func,
    [Features.SUPPORT_SENSITIVE] = ejoysdk_init.block,
    [Features.SUPPORT_CHAT_V2] = init_chat_v2,
    [Features.SUPPORT_CHAT] = chat_init_func,
    [Features.SUPPORT_LOGIN_TO_PLATFORM] = ejoysdk_init.holo,
    [Features.SUPPORT_BADGE] = init_badge,
    [Features.SUPPORT_ANNOUNCEMENT_V2] = ejoysdk_init.announement,
    [Features.SUPPORT_VOICE] = init_voice
  }
  for feature, func in pairs(map) do
    if bitutil.band(features, feature) > 0 then
      if feature == Features.SUPPORT_FRIEND then
        local friend_listeners_key
        if _ejoysdk.os() == "windows" then
          friend_listeners_key = "friend_listener"
        else
          friend_listeners_key = module_friend
        end
        if module_listeners and module_listeners[friend_listeners_key] then
          friend_listeners = module_listeners[friend_listeners_key]
        end
        if friend_listeners then
          E.LOG.debug(TAG, "will init module " .. Bit2FeatName[feature])
          need_init_friend = true
        else
          E.LOG.debug(TAG, "need module friend but friend_listeners is nil")
        end
      elseif feature == Features.SUPPORT_CHAT_V2 then
        if module_listeners and module_listeners[module_chat_v2] then
          chat_listeners = module_listeners[module_chat_v2]
        end
        if chat_listeners then
          need_init_chat_v2 = true
          E.LOG.debug(TAG, "will init module " .. Bit2FeatName[feature])
        else
          E.LOG.debug(TAG, "need module CHAT_v2 but chat_listeners is nil")
        end
      elseif feature == Features.SUPPORT_CHAT then
        local chat_listeners_key
        if _ejoysdk.os() == "windows" then
          chat_listeners_key = "chat_listener"
        else
          chat_listeners_key = module_chat
        end
        if module_listeners and module_listeners[chat_listeners_key] then
          chat_listeners = module_listeners[chat_listeners_key]
        end
        if chat_listeners then
          E.LOG.debug(TAG, TAG, "will init module " .. Bit2FeatName[feature])
          need_init_chat = true
        else
          E.LOG.debug(TAG, "need module CHAT but chat_listeners is nil")
        end
        if module_listeners and module_listeners["acc_" .. chat_listeners_key] then
          if _ejoysdk.os() == "windows" then
            local ori_acc_chat_listeners = module_listeners["acc_" .. chat_listeners_key]
            local new_acc_chat_listeners = {}
            for acc_fun_key, acc_fun in pairs(ori_acc_chat_listeners) do
              local new_acc_fun_key = acc_fun_key
              if E.Utils.start_with(acc_fun_key, "acc_") then
                new_acc_fun_key = acc_fun_key:sub(5)
              end
              new_acc_chat_listeners[new_acc_fun_key] = acc_fun
            end
            acc_chat_listeners = new_acc_chat_listeners
          else
            acc_chat_listeners = module_listeners["acc_" .. chat_listeners_key]
          end
        end
      elseif feature == Features.SUPPORT_PUSH then
        local listeners
        if module_listeners then
          listeners = module_listeners[module_push]
        end
        if listeners then
          E.LOG.debug(TAG, TAG, "will init module " .. Bit2FeatName[feature])
          func(listeners)
        else
          E.LOG.debug(TAG, "need module " .. Bit2FeatName[feature] .. " but listeners is nil")
        end
      elseif feature == Features.SUPPORT_ANNOUNCEMENT_V2 then
        local listeners
        if module_listeners then
          listeners = module_listeners[module_anns_v2]
        end
        if listeners then
          E.LOG.debug(TAG, TAG, "will init module " .. Bit2FeatName[feature])
          func(listeners)
        else
          E.LOG.debug(TAG, "need module " .. Bit2FeatName[feature] .. " but listeners is nil")
        end
      elseif feature == Features.SUPPORT_VOICE then
        local listeners
        if module_listeners then
          listeners = module_listeners[module_voice]
        end
        if listeners then
          enable_voice = true
          E.LOG.debug(TAG, TAG, "will init module " .. Bit2FeatName[feature])
          func(listeners)
        else
          E.LOG.debug(TAG, "need module VOICE but voice_listeners is nil")
        end
      else
        E.LOG.debug(TAG, "will init module " .. Bit2FeatName[feature])
        func()
      end
    end
  end
  local utils = require("ejoysdk_lua.ejoysdk_utils")
  if need_init_friend and (need_init_chat or need_init_chat_v2) then
    friend_init_func()
    local merged_listeners
    if friend_listeners and chat_listeners then
      merged_listeners = utils.merge_table(chat_listeners, friend_listeners)
    elseif friend_listeners then
      merged_listeners = friend_listeners
    elseif chat_listeners then
      merged_listeners = chat_listeners
    end
    if need_init_chat_v2 then
      init_chat_v2(merged_listeners, {enable_voice = enable_voice})
    else
      chat_init_func(merged_listeners, acc_chat_listeners)
    end
  elseif need_init_friend then
    friend_init_func(friend_listeners)
  elseif need_init_chat then
    chat_init_func(chat_listeners, acc_chat_listeners)
  elseif need_init_chat_v2 then
    init_chat_v2(chat_listeners, {enable_voice = enable_voice})
  end
end

local function HasFeature(features, feature_bit)
  return bitutil.band(features, feature_bit) > 0
end

local function AddFeature(features, feature_bit)
  do return bitutil.bor, features end
  return bitutil.bor, features, feature_bit
end

local function extract_sdkconfig_features(features_within_sdkconfig, SDKListeners)
  local _module_listeners = {}
  local sdkconfig_features = 0
  for _, feature_name in ipairs(features_within_sdkconfig) do
    local _feature_name = string.upper(feature_name)
    E.LOG.debug(TAG, "processing feat: " .. _feature_name)
    if "ANNOUNCEMENT_V2" == _feature_name then
      local enable_annv2 = true
      local t = {}
      for _, listener_name in ipairs(AnnV2_Listeners) do
        if SDKListeners[listener_name] then
          t[listener_name] = SDKListeners[listener_name]
        end
      end
      if enable_annv2 then
        sdkconfig_features = AddFeature(sdkconfig_features, SDKConfig_Features_Map[_feature_name])
        _module_listeners[module_anns_v2] = t
        E.LOG.debug(TAG, "add feature ANNOUNCEMENT_V2 from sdkconfig")
      end
    elseif "CHAT_V2" == _feature_name then
      local enable_chat_v2 = true
      local t = {}
      for listener_name, handlers_name in pairs(ChatV2_Listeners) do
        if SDKListeners[listener_name] then
          t[handlers_name] = SDKListeners[listener_name]
          E.LOG.debug(TAG, "chat's listener_name is " .. listener_name .. "'s handler is :" .. handlers_name)
        else
          enable_chat_v2 = false
        end
      end
      if enable_chat_v2 then
        sdkconfig_features = AddFeature(sdkconfig_features, SDKConfig_Features_Map[_feature_name])
        _module_listeners[module_chat_v2] = t
        E.LOG.debug(TAG, "add feature Chat_V2 from sdkconfig")
      end
    else
      local feat_bit = SDKConfig_Features_Map[string.upper(_feature_name)]
      if feat_bit then
        sdkconfig_features = AddFeature(sdkconfig_features, feat_bit)
      else
        E.LOG.debug(TAG, "feature" .. feature_name .. "  not supported!")
      end
    end
  end
  return sdkconfig_features, _module_listeners
end

function M.init(params, listeners, cb)
  local os = E.Sysinfo.os()
  if "windows" == os and params.windows_alert_param then
    local APP_Update = require("ejoysdk_lua.app_update.app_update")
    local alert_listener
    if params.windows_alert_listener_exist then
      alert_listener = listeners.app_version_update_alert_listener
    end
    APP_Update.set_windows_alert_callback(JSON.safe_decode(params.windows_alert_param), alert_listener)
  end
  local ejoysdk_log = require("ejoysdk_lua.ejoysdk_log")
  ejoysdk_log.set_native(true)
  params.open_app_version_update_check = true
  ejoysdk_init.config(nil, params)
  local sdk_list = params.sdk_list or {}
  local features = params.features or 0
  module_listeners = params.module_listeners or {}
  local features_within_sdkconfig = E.CONFIG.get_config("unisdk_meta").features or {}
  local sdkconfig_features, module_listeners_within_listeners = extract_sdkconfig_features(features_within_sdkconfig, listeners)
  if sdkconfig_features > 0 then
    module_listeners = module_listeners_within_listeners
  end
  init_opts = get_init_opts(sdk_list)
  ejoysdk_topic.subscribe(ejoysdk_init.SUBSCRIBE_GANGPLANK_INITED, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "初始化成功！")
      cb(true, LUTIL.Status.SUCC)
    else
      local error_msg = (...)
      E.LOG.warn(TAG, "初始化失败：" .. (error_msg or "nil"))
      cb(false, LUTIL.Status.FAIL, "初始化失败")
    end
  end)
  local vendors = sdk_list
  if HasFeature(features, Features.SUPPORT_CHAT_V2) or HasFeature(sdkconfig_features, Features.SUPPORT_CHAT_V2) then
    local ECC = require("ejoysdk_lua.chat.export.ejoysdk_chat")
    ECC.prefer_chat_version(2)
    E.LOG.debug(TAG, "=====> 设置使用新聊天版本")
  end
  if HasFeature(features, Features.SUPPORT_VOICE) or HasFeature(sdkconfig_features, Features.SUPPORT_VOICE) then
    E.LOG.debug(TAG, "=====> 设置声网初始化")
    vendors.AGORA = {}
  end
  ejoysdk_init.gangplank(vendors, {
    bind_listener = listeners.bind_listener,
    queue_listener = listeners.queue_listener,
    acquire_listener = listeners.acquire_listener,
    logout_listener = listeners.logout_listener,
    exit_listener = listeners.exit_listener,
    pay_listener = listeners.pay_listener,
    auth_listener = listeners.auth_listener
  })
  if sdkconfig_features > 0 then
    init_features(sdkconfig_features)
  else
    init_features(features)
  end
  ejoysdk_init.init()
end

M.exit = gangplank.exit

function M.get_opts()
  do return EUTIL.deepcopy end
  return EUTIL.deepcopy, init_opts or {}
end

return M
