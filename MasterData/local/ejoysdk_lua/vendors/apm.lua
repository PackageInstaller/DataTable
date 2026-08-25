local E = require("ejoysdk_lua.ejoysdk")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ETAPUS = require("ejoysdk_lua.ejoysdk_to_apus")
local CHANNEL = "APM"
local M = Vendor:Inherit(CHANNEL)
local CAST_NETWORK_PING = "CAST_NETWORK_PING"
local CAST_NETWORK_TRACEROUTE = "CAST_NETWORK_TRACEROUTE"
local CALLBACK_NETWORK_EVENT = "network_state_change"
local APM_EVENT_NET = "apm.net.netanalysis"
local TAG = EM.MODULE.VENDORS.APM
local inited = false
local DEFAULT_FREQUNCE_ENABLE = true
local DEFAULT_FREQUNCE_PER_SEC = 900
local MIN_FREQUNCE_PER_SEC = 300
local DEFAULT_PRE_NETWORK_CHANGED_DETECT = 300
local DEFAULT_DOMAIN_SERVICES = {gangplank = true}
local default_domains = {}
local frequnce_per_sec = DEFAULT_FREQUNCE_PER_SEC
local frequnce_enable = DEFAULT_FREQUNCE_ENABLE
local detect_domains
local not_enable_domains = {}
local nw_namespace_config = {}
local last_dectected_time = 0
local acc_info = {}
local APMEVENT

local function report_apm_event(event_name, _lablels, _trace_id, _msg, _stats)
  if nil == APMEVENT then
    local ok, apm_event = pcall(require, "ejoysdk_lua.apm-sdk-lua.event.event")
    if ok then
      APMEVENT = apm_event
    end
  end
  if nil ~= APMEVENT then
    local labels = _lablels or {}
    local trace_id = _trace_id or 0
    local stats = _stats or {}
    local msg = _msg or ""
    APMEVENT.post(event_name, labels, trace_id, msg, stats)
  end
end

function M.set_frequnce_enable(_frequnce_enable)
  frequnce_enable = _frequnce_enable
end

function M.set_frequnce_per_sec(_frequnce_per_sec)
  frequnce_per_sec = _frequnce_per_sec
  if frequnce_per_sec < MIN_FREQUNCE_PER_SEC then
    frequnce_per_sec = MIN_FREQUNCE_PER_SEC
  end
end

function M.ping(_params, cb)
  local os_name = _ejoysdk.os()
  local params = _params or {}
  if "windows" == os_name or "weixin" == os_name or "douyin" == os_name then
    E.Sysinfo.network_ping(params, cb)
  else
    UNI.async_call(CHANNEL, CAST_NETWORK_PING, {params = params}, nil, function(succ, ...)
      if succ then
        local body = (...)
        if nil ~= body then
          cb(true, body.data)
        end
      else
        local code, body = ...
        E.LOG.debug(TAG, "ping fail:" .. tostring(code) .. " ,msg: " .. tostring(body and body.msg))
        cb(false, tostring(code), tostring(body and body.msg))
      end
    end)
  end
end

function M.traceroute(_params, cb)
  local os_name = _ejoysdk.os()
  local params = _params or {}
  if "windows" == os_name or "weixin" == os_name or "douyin" == os_name then
    E.Sysinfo.network_traceroute(params, cb)
  else
    UNI.async_call(CHANNEL, CAST_NETWORK_TRACEROUTE, {params = params}, nil, function(succ, ...)
      if succ then
        local body = (...)
        if nil ~= body then
          cb(true, body.data)
        end
      else
        local code, body = ...
        E.LOG.debug(TAG, "traceroute fail:" .. tostring(code) .. " ,msg: " .. tostring(body and body.msg))
        cb(false, tostring(code), tostring(body and body.msg))
      end
    end)
  end
end

local function update_network_namespace_config(_config)
  nw_namespace_config = _config or {}
  local unique_domains = {}
  for _, v in pairs(detect_domains) do
    if v then
      unique_domains[v] = true
    end
  end
  local sub_config = nw_namespace_config.config
  if nil ~= sub_config then
    local net_any = sub_config.net_any or {}
    if nil ~= net_any.domains then
      local domains = net_any.domains
      for _, v in pairs(domains) do
        if nil == unique_domains[v] then
          table.insert(detect_domains, v)
        end
      end
    end
    M.set_frequnce_per_sec(net_any.frequnce_per_sec or DEFAULT_FREQUNCE_PER_SEC)
    if nil ~= net_any.frequnce_enable then
      frequnce_enable = net_any.frequnce_enable
    else
      frequnce_enable = DEFAULT_FREQUNCE_ENABLE
    end
  end
end

local function update_apm_namespace_config(_config)
end

function M.start_detect()
  local filter_domains = {}
  for _, v in pairs(detect_domains) do
    if nil == not_enable_domains[v] then
      table.insert(filter_domains, v)
    end
  end
  if #filter_domains > 0 and frequnce_enable then
    M.ping(filter_domains, function(succ, ...)
      if succ then
        local list = (...)
        if list and #list > 0 then
          for _, v in pairs(list) do
            local msg_str = tostring(v.status) .. "(" .. tostring(v.code) .. ")"
            local results = JSON.safe_decode(v.data)
            local stats = {}
            local labels = {
              target = v.target,
              cmd = "apm.net.ping"
            }
            if nil ~= results and type(results) == "table" then
              stats = {
                avg_delay = results.avg_delay or -1,
                loss = results.loss or -1,
                count = results.count or -1
              }
              labels.target_ip = results.target_ip or ""
            end
            report_apm_event(APM_EVENT_NET, labels, 0, msg_str, stats)
            if tostring(v.code) == "5" and v.target then
              not_enable_domains[v.target] = true
            end
          end
        end
      end
    end)
    M.traceroute(filter_domains, function(succ, ...)
      if succ then
        local list = (...)
        if list and #list > 0 then
          for _, v in pairs(list) do
            local labels = {
              target = v.target,
              cmd = "apm.net.traceroute"
            }
            local msg_str = tostring(v.status) .. "(" .. tostring(v.code) .. ")"
            if v.data ~= nil and v.data ~= "" then
              msg_str = v.data
            end
            report_apm_event(APM_EVENT_NET, labels, 0, msg_str, {})
            if tostring(v.code) == "5" and v.target then
              not_enable_domains[v.target] = true
            end
          end
        end
      end
    end)
  end
end

local function start_timer_detect()
  if frequnce_enable then
    E.Timer.once(frequnce_per_sec, start_timer_detect)
  end
  local current_time = os.time()
  if current_time - last_dectected_time > DEFAULT_PRE_NETWORK_CHANGED_DETECT or 0 == last_dectected_time then
    last_dectected_time = current_time
    M.start_detect()
  end
end

local first_state_changed = 1

local function start_net_state_changed_detect(state_info)
  if nil ~= state_info and type(state_info) == "table" and 1 == first_state_changed then
    if nil ~= state_info.state and tostring(state_info.state) ~= "0" then
      local current_time = os.time()
      if current_time - last_dectected_time > DEFAULT_PRE_NETWORK_CHANGED_DETECT then
        last_dectected_time = current_time
        M.start_detect()
      end
    end
    first_state_changed = 0
  end
end

local function init_apm_sdk(_opt)
  local ok, APM = pcall(require, "ejoysdk_lua.apm-sdk-lua.apm")
  if ok then
    APM.init()
  end
end

local function trim_start_http(str)
  local nstr = str
  if nil ~= nstr then
    if E.Utils.start_with(nstr, "https://") then
      nstr = E.Utils.trim_start(nstr, "https://")
    elseif E.Utils.start_with(nstr, "http://") then
      nstr = E.Utils.trim_start(nstr, "http://")
    end
  end
  return nstr
end

local function setup_defaul_domain()
  default_domains = {}
  local unique_domains = {}
  for k, v in pairs(DEFAULT_DOMAIN_SERVICES) do
    if v then
      local url_prefix = E.CONFIG.get_config(k)
      if url_prefix and #url_prefix > 0 then
        local url_domain = trim_start_http(url_prefix)
        table.insert(default_domains, url_domain)
        unique_domains[url_domain] = true
      end
    end
  end
  local ec = require("ejoysdk_lua.chat.ejoysdk_chat_server")
  if nil ~= ec then
    local chat_server = ec.get_server_addr()
    if nil ~= chat_server then
      local chat_domain = trim_start_http(chat_server)
      table.insert(default_domains, chat_domain)
      unique_domains[chat_domain] = true
    end
  end
  detect_domains = default_domains
  nw_namespace_config = ECC.get_config(ECC.NAMESPACE.NETWORK)
  if nil ~= nw_namespace_config then
    local sub_config = nw_namespace_config.config
    if nil ~= sub_config then
      local net_any = sub_config.net_any or {}
      if nil ~= net_any.domains then
        local domains = net_any.domains
        for _, v in pairs(domains) do
          if nil == unique_domains[v] then
            table.insert(detect_domains, v)
          end
        end
      end
      M.set_frequnce_per_sec(net_any.frequnce_per_sec or DEFAULT_FREQUNCE_PER_SEC)
      if nil ~= net_any.frequnce_enable then
        frequnce_enable = net_any.frequnce_enable
      else
        frequnce_enable = DEFAULT_FREQUNCE_ENABLE
      end
    end
  end
end

local function on_acc_info_change_handler(_acc_info)
  acc_info = _acc_info or {}
end

function M.init(opt, cb)
  E.LOG.debug(TAG, "apmsdk start init!")
  if inited then
    E.LOG.debug(TAG, "apmsdk had inited")
    cb(true)
    return
  end
  inited = true
  setup_defaul_domain()
  init_apm_sdk(opt)
  if frequnce_enable then
    E.Timer.once(5, start_timer_detect)
  end
  ECC.subscribe(ECC.NAMESPACE.NETWORK, update_network_namespace_config)
  ECC.subscribe(ECC.NAMESPACE.APM, update_apm_namespace_config)
  ET.subscribe(CALLBACK_NETWORK_EVENT, start_net_state_changed_detect)
  local estat = require("ejoysdk_lua.ejoysdk_stat")
  estat.register_acc_info_change_listener(on_acc_info_change_handler)
  ETAPUS.add_dynamic_label("acc_ch", function()
    return acc_info.accountCh
  end)
  ETAPUS.add_dynamic_label("acc_ch_uid", function()
    return acc_info.chuid
  end)
  ETAPUS.add_dynamic_label("acc_ch_user_type", function()
    return acc_info.chUserType
  end)
  ETAPUS.add_dynamic_label("acc_account_id", function()
    return acc_info.accountId
  end)
  cb(true)
end

return M
