local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_config")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EI = require("ejoysdk_lua.ejoysdk_init")
local ES = require("ejoysdk_lua.ejoysdk_stat")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local ANNS_BADGE
local M = {}
M.TRACE_EVENT = "trace_event"
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "ejoysdk_launcher"
local vendor_cache
local inited = false
local SERVICE = {
  PARTNER = "partner",
  BOOT = "boot",
  LOG = "log",
  TICKET = "ticket",
  TICKET_POST = "ticket_post",
  TICKETS = "tickets",
  TICKETS_POST = "tickets_post",
  DETAIL = "detail",
  SERVER_LIST_TICKET = "server_list_ticket",
  SERVER_LIST_DETAIL = "server_list_detail",
  SERVER_LIST_TICKET_WITH_GROUP = "server_list_ticket_with_group",
  SERVER_LIST_TICKET_WITH_NODE = "server_list_ticket_with_node"
}
local url_items = {
  [SERVICE.PARTNER] = "trace/partner",
  [SERVICE.BOOT] = "trace/boot",
  [SERVICE.LOG] = "trace/tracelog",
  [SERVICE.TICKET] = "ann/v2/ticket/",
  [SERVICE.TICKET_POST] = "ann/v2/ticket_post/",
  [SERVICE.TICKETS] = "ann/v2/tickets/",
  [SERVICE.TICKETS_POST] = "ann/v2/tickets_post/",
  [SERVICE.DETAIL] = "ann/v2/detail/",
  [SERVICE.SERVER_LIST_TICKET] = "ann/realm/ticket",
  [SERVICE.SERVER_LIST_DETAIL] = "ann/realm/detail/",
  [SERVICE.SERVER_LIST_TICKET_WITH_GROUP] = "ann/realm/ticket_with_group",
  [SERVICE.SERVER_LIST_TICKET_WITH_NODE] = "ann/realm/ticket_with_node"
}

local function get_launcher_url_base(service)
  local url_prefix = E.CONFIG.get_config("launcher") .. "/"
  local service_path = url_items[service]
  return url_prefix .. service_path
end

local function get_log_collector_url_base(service)
  local url_prefix = E.CONFIG.get_config("log-collector") .. "/"
  local service_path = url_items[service]
  return url_prefix .. service_path
end

local KS_VENDERS_KEY = "VENDERS"

local function get_vendors_stored()
  local v = E.KeyStore.get(KS_VENDERS_KEY)
  if v then
    do return E.Utils.split_string, v end
    return E.Utils.split_string, v, ":"
  end
end

local function save_vendors(vendors)
  if #vendors > 0 then
    local v = table.concat(vendors, ":")
    E.KeyStore.set(KS_VENDERS_KEY, v)
  end
end

local KS_LAST_ENTER_SERVER_ID_FOR_LAUNCHER = "LAST_ENTER_SERVER_ID_FOR_LAUNCHER"

local function login_handler(user_info)
  if user_info and user_info.uid then
    E.KeyStore.set(KS_LAST_ENTER_SERVER_ID_FOR_LAUNCHER, user_info.server or "")
  end
end

local function logout_handler(_user_info)
  local launcher_ext = require("ejoysdk_lua.ejoysdk_launcher_ext")
  launcher_ext.reset_last_server_data()
end

function M.init(opt)
  if inited then
    E.LOG.debug(TAG, "already init and return")
    return
  end
  opt = opt or {}
  if opt.vendor then
    local vendors = get_vendors_stored()
    if not vendors then
      M.get_vendors(function(succ)
        if succ then
          inited = true
          ET.publish(EI.SUBSCRIBE_LAUNCHER_INITED, true)
        end
      end)
    else
      inited = true
      ET.publish(EI.SUBSCRIBE_LAUNCHER_INITED, true)
      vendor_cache = vendors
    end
  else
    inited = true
    ET.publish(EI.SUBSCRIBE_LAUNCHER_INITED, true)
  end
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
  ANNS_BADGE = require("ejoysdk_lua.badge.ejoysdk_badge_anns")
  ANNS_BADGE.init()
end

function M.event(tag, detail)
  if nil == detail then
    detail = tag
    tag = "boot"
  end
  local idfa = E.Sysinfo.idfa()
  local env_info = ES.env_info()
  local params = {
    tag = tag,
    uuid = idfa,
    timestamp = os.time(),
    detail = detail,
    envinfo = env_info
  }
  local log_url = get_log_collector_url_base(SERVICE.LOG)
  E.LOG.debug(TAG, "log_url: " .. log_url)
  E.HTTP.post(log_url, {
    acceptable = E.HTTP.CT_JSON
  }, E.HTTP.CT_JSON, params, function(resp)
    if resp.status ~= 200 or 200 ~= resp.body.code then
      E.log({
        error = "send event error",
        resp = resp
      })
    end
  end)
end

ET.subscribe(M.TRACE_EVENT, M.event)

local function get_full_channel()
  local pkg_info = E.get_pkg_info()
  local channel = pkg_info.channel_id
  local sub_channel = pkg_info.ds_sub_channel_id
  channel = channel and tostring(channel)
  if channel and sub_channel and #sub_channel > 0 then
    E.log("channel is " .. channel .. ", and sub_channel is " .. sub_channel)
    local channelTable = {
      "DG_1",
      "DG_2",
      "DG_4",
      "DG_28"
    }
    local in_white = false
    for _i, v in pairs(channelTable) do
      if v == sub_channel then
        in_white = true
        break
      end
    end
    if in_white then
      E.log("sub_channel " .. sub_channel .. "在白名单内，直接拼接就好")
      channel = tostring(channel) .. "," .. tostring(sub_channel)
    else
      E.log("sub_channel " .. sub_channel .. "不在白名单内，替换为others")
      channel = tostring(channel) .. "," .. "OTHERS"
    end
  end
  if E.Sysinfo.os() == "windows" then
    channel = pkg_info.accountCh or ""
  end
  return channel
end

function M.tickets(ann_types, tags, server, cb, ext)
  local channel = get_full_channel()
  local params = {
    zone = EC.get_config("zone"),
    lang = EC.get_config("lang"),
    server = server,
    channel = channel
  }
  local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
  local pkg_info = E.get_pkg_info()
  if pkg_info.cloud_game_runmode == CSTAT.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE or pkg_info.cloud_game_runmode == CSTAT.MOBILE_RUN_MODE.MODE_RUN_IN_CLOUD_SIDE then
    params.client_mode = "CLOUD"
  else
    params.client_mode = "NORMAL"
  end
  
  local function ticket_cb(resp)
    local _status = resp and resp.status or CONSTANTS.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_GANGPLANK_RESP_BODY_INVALID
    if 200 == _status then
      local body = resp.body
      if body then
        cb(true, body.tickets)
      else
        cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_GET_NULL_BODY, "resp body is nil")
      end
    else
      cb(false, _status)
    end
  end
  
  if ext and next(ext) then
    params.types = ann_types
    for ext_key, ext_value in pairs(ext) do
      params[ext_key] = ext_value
    end
    if type(tags) == "string" then
      local tag_arr = {}
      table.insert(tag_arr, tags)
      params.tags = tag_arr
    elseif type(tags) == "table" then
      params.tags = tags
    end
    E.log(params)
    local ticket_post_url = get_launcher_url_base(SERVICE.TICKETS_POST)
    E.HTTP.post(ticket_post_url, {
      acceptable = E.HTTP.CT_JSON
    }, E.HTTP.CT_JSON, params, ticket_cb)
  else
    local tags_str
    if type(tags) == "table" then
      tags_str = table.concat(tags, ",")
    elseif type(tags) == "string" then
      tags_str = tags
    end
    params.tags = tags_str
    table.sort(ann_types)
    local ann_types_str = table.concat(ann_types, ",")
    local ticket_url = get_launcher_url_base(SERVICE.TICKETS)
    E.LOG.debug(TAG, "ticket_url: " .. ticket_url)
    local url = ticket_url .. ann_types_str
    url = E.HTTP.url_query(url, params)
    E.log("ticket full url = " .. url)
    E.HTTP.get(url, {
      acceptable = E.HTTP.CT_JSON
    }, ticket_cb)
  end
end

function M.ticket(ann_type, tags, server, cb, ext)
  local channel = get_full_channel()
  local params = {
    zone = EC.get_config("zone"),
    lang = EC.get_config("lang"),
    server = server,
    channel = channel
  }
  local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
  local pkg_info = E.get_pkg_info()
  if pkg_info.cloud_game_runmode == CSTAT.MOBILE_RUN_MODE.MODE_RUN_CONNECT_REMOTE or pkg_info.cloud_game_runmode == CSTAT.MOBILE_RUN_MODE.MODE_RUN_IN_CLOUD_SIDE then
    params.client_mode = "CLOUD"
  else
    params.client_mode = "NORMAL"
  end
  
  local function ticket_cb(resp)
    local _status = resp and resp.status or CONSTANTS.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_GANGPLANK_RESP_BODY_INVALID
    if 200 == _status then
      local body = resp.body
      if body and body.code ~= CONSTANTS.EJOYSDK_ERROR_CODES.HTTP_REQUEST_BODY_NIL then
        cb(true, body.hash, body.time)
      else
        cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_GET_NULL_BODY, "resp body is nil")
      end
    else
      cb(false, _status)
    end
  end
  
  if ext and next(ext) then
    params.type = ann_type
    for ext_key, ext_value in pairs(ext) do
      params[ext_key] = ext_value
    end
    if type(tags) == "string" then
      local tag_arr = {}
      table.insert(tag_arr, tags)
      params.tags = tag_arr
    elseif type(tags) == "table" then
      params.tags = tags
    end
    E.log(params)
    local ticket_post_url = get_launcher_url_base(SERVICE.TICKET_POST)
    E.HTTP.post(ticket_post_url, {
      acceptable = E.HTTP.CT_JSON
    }, E.HTTP.CT_JSON, params, ticket_cb)
  else
    local tags_str
    if type(tags) == "table" then
      tags_str = table.concat(tags, ",")
    elseif type(tags) == "string" then
      tags_str = tags
    end
    params.tags = tags_str
    local ticket_url = get_launcher_url_base(SERVICE.TICKET)
    E.LOG.debug(TAG, "ticket_url: " .. ticket_url)
    local url = ticket_url .. ann_type
    url = E.HTTP.url_query(url, params)
    E.log("ticket full url = " .. url)
    E.HTTP.get(url, {
      acceptable = E.HTTP.CT_JSON
    }, ticket_cb)
  end
end

function M.detail(ticket, cb)
  local detail_url = get_launcher_url_base(SERVICE.DETAIL)
  local url = tostring(detail_url) .. tostring(ticket)
  E.LOG.debug(TAG, "detail_url: " .. url)
  E.HTTP.get(url, {raw_body = true}, function(resp)
    if resp.status == 200 then
      cb(true, resp.body, ticket)
    else
      cb(false, resp.status, "get detail failed")
    end
  end)
end

local ticket_cache_format = "%s_ticket_cache"

function M.get_ticket_cache(type, hash)
  if hash and "" ~= hash then
    local fn = string.format(ticket_cache_format, type)
    local cache = E.File.readfile(fn)
    if nil ~= cache then
      local data = JSON.safe_decode(cache)
      if data and data.hash == hash then
        return data
      else
        E.log("ticket_detail  decode cache failed")
      end
    end
  end
  return nil
end

local function save_ticket_cache(type, data)
  local fn = string.format(ticket_cache_format, type)
  local json_str = JSON.encode(data)
  E.File.writefile(fn, json_str)
end

local function commit_action_succ_main_before_enter_game(action, type, params)
  local eg = require("ejoysdk_lua.ejoysdk_gangplank")
  local player_info = eg.player_info()
  if not player_info then
    E.LOG.debug(TAG, "commit_action_succ_main_before_enter_game begin:" .. tostring(action) .. ", type:" .. tostring(type))
    QL.commit_action_succ_main(action, type, params)
  end
end

local function commit_action_fail_main_before_enter_game(action, action_type, code, msg, params)
  local eg = require("ejoysdk_lua.ejoysdk_gangplank")
  local player_info = eg.player_info()
  if not player_info then
    E.LOG.debug(TAG, "commit_action_fail_main_before_enter_game begin:" .. tostring(action) .. ", type:" .. tostring(action_type))
    QL.commit_action_fail_main(action, action_type, code, msg, params)
  end
end

function M.ticket_detail(ann_type, tags, server, cb, ext)
  local function cb_wrapper(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      E.LOG.debug(TAG, "ticket_detail succ")
      local _stat_params = {p1 = server}
      commit_action_succ_main_before_enter_game("ejoy_ticket_detail_end", ann_type, _stat_params)
    else
      local _code, _msg = ...
      E.LOG.warn(TAG, "ticket_detail failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
      local _stat_params = {p1 = server}
      commit_action_fail_main_before_enter_game("ejoy_ticket_detail_end", ann_type, _code, _msg, _stat_params)
    end
  end
  
  M.ticket(ann_type, tags, server, function(succ, ...)
    if succ then
      local hash, _time = ...
      local data = M.get_ticket_cache(ann_type, hash)
      if nil ~= data then
        cb_wrapper(true, data.body, data.ticket, hash)
        return
      end
      M.detail(hash, function(ok, ...)
        if ok then
          local body, ticket = ...
          local cb_data = {
            hash = hash,
            ticket = ticket,
            body = body
          }
          save_ticket_cache(ann_type, cb_data)
          cb_wrapper(true, body, ticket, hash)
        else
          local _code, _msg = ...
          cb_wrapper(false, _code, _msg)
        end
      end)
    else
      local _code, _msg = ...
      cb_wrapper(false, _code, _msg)
    end
  end, ext)
end

function M.tickets_details(ann_types, tags, server, cb, ext)
  local function cb_wrapper(succ, ...)
    if cb then
      cb(succ, ...)
    end
    table.sort(ann_types)
    local ann_types_str = table.concat(ann_types, ",")
    if succ then
      E.LOG.debug(TAG, "tickets_details succ")
      local _stat_params = {p1 = server}
      commit_action_succ_main_before_enter_game("ejoy_tickets_details_end", ann_types_str, _stat_params)
    else
      local _code, _msg = ...
      E.LOG.warn(TAG, "tickets_details failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
      local _stat_params = {p1 = server}
      commit_action_fail_main_before_enter_game("ejoy_tickets_details_end", ann_types_str, _code, _msg, _stat_params)
    end
  end
  
  M.tickets(ann_types, tags, server, function(succ, ...)
    if succ then
      local tickets = (...)
      local ticket_size = 0
      if tickets then
        ticket_size = #tickets
      end
      if nil == tickets or 0 == ticket_size then
        cb_wrapper(true, {})
        return
      end
      local get_detail_size = 0
      local detail_datas = {}
      for _, ticket in pairs(tickets) do
        local ann_type = ticket.type
        local hash = ticket.hash
        local time = ticket.time
        local ticket_detail_data = {
          ann_type = ann_type,
          time = time,
          hash = hash
        }
        local data = M.get_ticket_cache(ann_type, hash)
        if nil ~= data then
          ticket_detail_data.detail = data.body
          ticket_detail_data.code = 200
          table.insert(detail_datas, ticket_detail_data)
          get_detail_size = get_detail_size + 1
          if get_detail_size == ticket_size then
            cb_wrapper(true, detail_datas)
          end
        else
          M.detail(hash, function(detail_succ, ...)
            if detail_succ then
              local body, ticket_hash = ...
              local cache_data = {
                hash = hash,
                ticket = ticket_hash,
                body = body
              }
              save_ticket_cache(ann_type, cache_data)
              ticket_detail_data.detail = body
              ticket_detail_data.code = 200
            else
              local code, msg = ...
              ticket_detail_data.code = code
              ticket_detail_data.msg = msg
            end
            table.insert(detail_datas, ticket_detail_data)
            get_detail_size = get_detail_size + 1
            if get_detail_size == ticket_size then
              cb_wrapper(true, detail_datas)
            end
          end)
        end
      end
    else
      cb_wrapper(false, ...)
    end
  end, ext)
end

function M.ticket_detail_with_badge(ann_type, tags, server, cb, ext)
  local function cb_wrapper(succ, ...)
    if succ then
      local body_str, ticket, hash = ...
      
      ANNS_BADGE.get_notice_badge_tree_imm(ann_type, tags, server, function(ann_badge_data)
        local body_data = JSON.safe_decode(body_str)
        local anns = (body_data or {}).anns or {}
        local anns_badge = {}
        local children = (ann_badge_data or {}).tree_info or {}.children or {}
        for _, badge in pairs(children) do
          anns_badge[badge.node_id] = badge.is_activated or false
        end
        local is_force_popup = false
        for _, ann in pairs(anns) do
          ann.has_read = anns_badge[ann._uuid] == false
          is_force_popup = is_force_popup or not ann.has_read and ann._badge_config and ann._badge_config.is_force_popup == true
        end
        body_data.force_popup = is_force_popup
        local body = JSON.encode(body_data)
        cb(true, body, ticket, hash)
        local _stat_params = {p1 = server}
        commit_action_succ_main_before_enter_game("ejoy_ticket_detail_badge_end", ann_type, _stat_params)
      end)
    else
      local _code, _msg = ...
      cb(false, _code, _msg)
      local _stat_params = {p1 = server}
      commit_action_fail_main_before_enter_game("ejoy_ticket_detail_badge_end", ann_type, _code, _msg, _stat_params)
    end
  end
  
  M.ticket_detail(ann_type, tags, server, cb_wrapper, ext)
end

function M.vendors()
  return vendor_cache
end

local function update_vendor_cache(vendors)
  save_vendors(vendors)
  vendor_cache = vendors
end

function M.get_vendors(cb)
  local idfa = E.Sysinfo.idfa()
  local timestamp = os.time()
  local params = {
    product = E.CONFIG.get_config("product"),
    idfa = idfa,
    timestamp = timestamp
  }
  local partner_url = get_log_collector_url_base(SERVICE.PARTNER)
  E.LOG.debug(TAG, "partner_url: " .. partner_url)
  E.HTTP.post(partner_url, {
    acceptable = E.HTTP.CT_JSON
  }, E.HTTP.CT_URLENCODED, params, function(resp)
    if resp.status == 200 and 200 == resp.body.code then
      E.log(resp.body)
      update_vendor_cache(resp.body.data)
      cb(true, resp.body.data)
      return
    end
    cb(false)
  end)
end

function M.server_list_ticket_with_params(cb, params)
  params = params or {}
  local tags_str
  if params.tags then
    tags_str = table.concat(params.tags, ",")
  end
  local server_ids_str
  if params.server_ids then
    server_ids_str = table.concat(params.server_ids, ",")
  end
  local server_groups_str
  if params.server_groups then
    server_groups_str = table.concat(params.server_groups, ",")
  end
  local fields_str
  if params.fields then
    fields_str = table.concat(params.fields, ",")
  end
  local realm_types_str
  if params.realm_types and next(params.realm_types) ~= nil then
    realm_types_str = table.concat(params.realm_types, ",")
  end
  local params2 = {
    zone = EC.get_config("zone"),
    lang = EC.get_config("lang"),
    tags = tags_str,
    server_ids = server_ids_str,
    server_groups = server_groups_str,
    fields = fields_str,
    realm_types = realm_types_str
  }
  if params.server_node then
    params2.server_node = params.server_node
  end
  local server_list_ticket_url = get_launcher_url_base(SERVICE.SERVER_LIST_TICKET)
  local url = server_list_ticket_url
  local has_ext = params.ext and "table" == type(params.ext)
  if true == has_ext then
    if true == params.ext.with_group then
      server_list_ticket_url = get_launcher_url_base(SERVICE.SERVER_LIST_TICKET_WITH_GROUP)
      url = server_list_ticket_url
    elseif true == params.ext.with_node then
      params.ext.with_node = nil
      has_ext = params.ext and "table" == type(params.ext) and nil ~= next(params.ext)
      server_list_ticket_url = get_launcher_url_base(SERVICE.SERVER_LIST_TICKET_WITH_NODE)
      url = server_list_ticket_url
    end
  end
  url = E.HTTP.url_query(url, params2)
  if true == has_ext then
    url = url .. "&ext=true&" .. E.HTTP.urlencode(params.ext)
  end
  E.LOG.debug(TAG, "server_list_ticket_url, url:" .. url)
  _ejoysdk.log("server list ticket url: " .. tostring(url))
  E.HTTP.get(url, {
    trace = true,
    acceptable = E.HTTP.CT_JSON
  }, function(resp)
    if resp.status == 200 then
      local body = resp.body
      if body and body.hash then
        E.LOG.debug(TAG, "server_list_ticket_with_params resp succ, hash:" .. body.hash)
        cb(true, body.hash, body.time)
      else
        E.LOG.warn(TAG, "server_list_ticket_with_params resp failed, resp body or hash is invalid")
        cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_TICKET_HASH_INVALID, "ticket hash invalid")
      end
    else
      E.LOG.warn(TAG, "server_list_ticket_with_params resp failed, resp status >>")
      E.log(resp)
      cb(false, resp.status, "get failed")
    end
  end)
end

function M.server_list_ticket(tags, cb)
  local params = {}
  if type(tags) == "function" then
    cb = tags
    params.tags = nil
  else
    params.tags = tags
  end
  M.server_list_ticket_with_params(cb, params)
end

local SERVER_GROUP_TYPE = {
  ALL = "sys_all",
  RECOMMEND = "sys_recommend",
  MANUAL = "manual"
}

local function server_list_detail_sort(server_list, groups)
  server_list = server_list or {}
  groups = groups or {}
  if type(groups) ~= "table" or utils.table_maxn(groups) <= 0 then
    E.LOG.d(TAG, "no any group")
    return
  end
  local strategy_chain = {}
  
  local function filter_recommend_list(origin_server_list)
    origin_server_list = origin_server_list or {}
    local recommand_server_list = {}
    for _, server_info in ipairs(origin_server_list) do
      if server_info.recommend_data_info == true then
        table.insert(recommand_server_list, server_info)
      else
        for _, type in pairs(server_info.marks or {}) do
          E.LOG.d("test_demonk", "type=" .. type)
          if "recommend" == type then
            table.insert(recommand_server_list, server_info)
            break
          end
        end
      end
    end
    return recommand_server_list
  end
  
  local function filter_manual_list(origin_server_list, sort_server_list)
    local index_server_list = {}
    for _, server_info in pairs(origin_server_list) do
      index_server_list[server_info.server_id or ""] = server_info
    end
    local manual_server_list = {}
    for _, server_id in ipairs(sort_server_list or {}) do
      if index_server_list[server_id] then
        table.insert(manual_server_list, index_server_list[server_id])
      end
    end
    return manual_server_list
  end
  
  local function mark_score(marks)
    marks = marks or {}
    local score = 0
    for _, mark in ipairs(marks) do
      if "recommend" == mark then
        score = score + 2
      end
      if "new" == mark then
        score = score + 1
      end
    end
    return score
  end
  
  local function sort_mark(s1, s2, is_asc, index)
    index = index or 1
    local s1_score = mark_score(s1.marks)
    local s2_score = mark_score(s2.marks)
    if s1_score == s2_score and type(strategy_chain[index + 1]) == "function" then
      do return strategy_chain[index + 1], s1, s2, is_asc end
      return strategy_chain[index + 1], s1, s2, is_asc, index + 1
    end
    if is_asc then
      return s1_score < s2_score
    end
    return s1_score > s2_score
  end
  
  local function sort_server_id(s1, s2, is_asc, _index)
    local s1_id, s2_id = s1.server_id or "", s2.server_id or ""
    local s1_length = string.len(s1_id)
    local s2_length = string.len(s2_id)
    if s1_length ~= s2_length then
      if is_asc then
        return s1_length < s2_length
      end
      return s1_length > s2_length
    end
    if is_asc then
      return s1_id < s2_id
    end
    return s1_id > s2_id
  end
  
  local SERVER_SORT_STRATEGY = {
    server_mark_sorter_asc = function(s1, s2, index)
      do return sort_mark, s1, s2, true end
      return sort_mark, s1, s2, true, index
    end,
    server_mark_sorter_desc = function(s1, s2, index)
      do return sort_mark, s1, s2, false end
      return sort_mark, s1, s2, false, index
    end,
    server_id_sorter_asc = function(s1, s2, index)
      do return sort_server_id, s1, s2, true end
      return sort_server_id, s1, s2, true, index
    end,
    server_id_sorter_desc = function(s1, s2, index)
      do return sort_server_id, s1, s2, false end
      return sort_server_id, s1, s2, false, index
    end
  }
  local sort_groups = {}
  for group_index, group in ipairs(groups) do
    local new_group = {
      name = group.name,
      type = group.type,
      server_ids = {}
    }
    local target_servers
    if group.type == SERVER_GROUP_TYPE.ALL then
      target_servers = server_list
    elseif group.type == SERVER_GROUP_TYPE.RECOMMEND then
      target_servers = filter_recommend_list(server_list)
    elseif group.type == SERVER_GROUP_TYPE.MANUAL then
      target_servers = filter_manual_list(server_list, group.server_ids)
    else
      E.LOG.d(TAG, "not supported type: " .. tostring(group.type or ""))
      goto lbl_154
    end
    local sort_rules = group.sort_rules or {}
    strategy_chain = {}
    for index, rule in ipairs(sort_rules) do
      local strategy_proc = SERVER_SORT_STRATEGY[rule]
      if type(strategy_proc) == "function" then
        table.insert(strategy_chain, index, strategy_proc)
      end
    end
    if utils.table_maxn(strategy_chain) > 0 then
      table.sort(target_servers, strategy_chain[1])
    end
    for index, server in ipairs(target_servers) do
      table.insert(new_group.server_ids, index, server)
    end
    table.insert(sort_groups, group_index, new_group)
    ::lbl_154::
  end
  return sort_groups
end

function M.server_list_detail(ticket, cb)
  local server_list_detail_url = get_launcher_url_base(SERVICE.SERVER_LIST_DETAIL)
  local url = server_list_detail_url .. ticket
  E.LOG.debug(TAG, "server_list_detail, url:" .. url)
  local params = {
    zone = EC.get_config("zone"),
    lang = EC.get_config("lang")
  }
  url = E.HTTP.url_query(url, params)
  E.HTTP.get(url, {trace = true, raw_body = true}, function(resp)
    if resp.status == 200 then
      local server_list_str = resp.body
      local server_list = JSON.safe_decode(server_list_str)
      if server_list and type(server_list.anns) == "table" and "table" == type(server_list.anns.groups) and "table" == type(server_list.anns.servers) then
        server_list.groups = server_list.anns.groups
        server_list.anns = server_list.anns.servers
        server_list_str = JSON.safe_encode(server_list)
      end
      cb(true, server_list_str)
    else
      cb(false, resp.status)
    end
  end)
end

function M.server_list_node_detail(ticket, cb)
  local server_list_detail_url = get_launcher_url_base(SERVICE.SERVER_LIST_DETAIL)
  local url = server_list_detail_url .. ticket
  E.LOG.debug(TAG, "server_list_node_detail, url:" .. url)
  local params = {
    zone = EC.get_config("zone"),
    lang = EC.get_config("lang")
  }
  url = E.HTTP.url_query(url, params)
  E.HTTP.get(url, {trace = true, raw_body = true}, function(resp)
    if resp and resp.status == 200 then
      local body_str = resp and resp.body
      cb(true, body_str)
    else
      cb(false, resp and resp.status)
    end
  end)
end

function M.server_list_ticket_detail_with_params(cb, params)
  local function cb_wrapper(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      E.LOG.debug(TAG, "server_list_ticket_detail_with_params succ")
      QL.commit_action_succ_main("ejoy_server_info_list_end")
    else
      local _code, _msg = ...
      E.LOG.warn(TAG, "server_list_ticket_detail_with_params failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
      QL.commit_action_fail_main("ejoy_server_info_list_end", nil, _code, _msg)
    end
  end
  
  local function inner_cb(succ, ...)
    if succ then
      local hash, _time = ...
      local fn = string.format("%s_sl_cache", hash)
      local cache = E.File.readfile(fn)
      if nil ~= cache then
        local data = JSON.safe_decode(cache)
        if data and data.detail then
          local result = JSON.safe_decode(data.detail)
          if result then
            E.LOG.debug(TAG, "get_server_list_ticket_detail get from cache >>")
            E.log(data.detail)
            cb_wrapper(true, data.detail)
            return
          end
        end
      end
      M.server_list_detail(hash, function(succ2, ...)
        if succ2 then
          local detail = (...)
          local result = JSON.safe_decode(detail)
          if result then
            E.log("server_list_detail HTTP response data right，and ready to cache it")
            local data = {hash = hash, detail = detail}
            local json_str = JSON.encode(data)
            E.LOG.debug(TAG, "server_list_detail response >>")
            E.log(json_str)
            E.File.writefile(fn, json_str)
            cb_wrapper(true, detail)
          else
            E.log("server_list_detail HTTP response get wrong response data, please retry it")
            cb_wrapper(false, CONSTANTS.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_GANGPLANK_JSON_DECODE_ERROR, "detail decode failed")
          end
        else
          local status = (...)
          cb_wrapper(false, status)
        end
      end)
    else
      local _code, _msg = ...
      cb_wrapper(false, _code, _msg)
    end
  end
  
  M.server_list_ticket_with_params(inner_cb, params)
end

function M.server_list_ticket_detail_with_params_v2(cb, params)
  local function cb_wrapper(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      E.LOG.debug(TAG, "server_list_ticket_detail_with_params_v2 succ")
      QL.commit_action_succ_main("ejoy_server_info_list_end")
    else
      local _code, _msg = ...
      E.LOG.warn(TAG, "server_list_ticket_detail_with_params_v2 failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
      QL.commit_action_fail_main("ejoy_server_info_list_end", nil, _code, _msg)
    end
  end
  
  local function fill_with_marks(server_list, cb2)
    local EG = require("ejoysdk_lua.ejoysdk_gangplank")
    local server_marks_params = {}
    if params and params.server_node then
      server_marks_params.server_node = params.server_node
    end
    EG.get_server_marks(server_marks_params, function(succ4, ...)
      local recommand_server_list = {}
      if succ4 then
        local server_marks = (...)
        if next(server_marks) then
          for _, server_info in ipairs(server_list or {}) do
            server_info.marks = server_marks[server_info.server_id] or {}
            for _, type in pairs(server_info.marks or {}) do
              if "recommend" == type then
                table.insert(recommand_server_list, server_info)
                break
              end
            end
          end
        end
      end
      cb2(succ4, server_list, recommand_server_list)
    end)
  end
  
  local function inner_cb(succ, ...)
    if succ then
      local hash, _time = ...
      local fn = string.format("%s_sl_cache_v2", hash)
      local cache = E.File.readfile(fn)
      if nil ~= cache then
        local detail = JSON.safe_decode(cache)
        if detail then
          E.LOG.debug(TAG, "get_server_list_ticket_detail_table get from cache >>")
          E.log(detail)
          fill_with_marks(detail.anns or {}, function(_succ3, server_list, recommend_list)
            local sort_groups = server_list_detail_sort(server_list or {}, detail.groups or {})
            if nil == sort_groups then
              sort_groups = {}
            end
            cb_wrapper(true, detail, sort_groups, recommend_list)
          end)
          return
        end
      end
      M.server_list_detail(hash, function(succ2, ...)
        if succ2 then
          local detail = (...)
          local result = JSON.safe_decode(detail)
          if result then
            E.log("server_list_detail_table HTTP response data right，and ready to cache it")
            E.LOG.debug(TAG, "server_list_detail_table response >>")
            E.log(detail)
            E.File.writefile(fn, detail)
            fill_with_marks(result.anns or {}, function(_succ3, server_list, recommend_list)
              local sort_groups = server_list_detail_sort(server_list or {}, result.groups or {})
              if nil == sort_groups then
                sort_groups = {}
              end
              cb_wrapper(true, result, sort_groups, recommend_list)
            end)
          else
            E.log("server_list_detail_table HTTP response get wrong response data, please retry it")
            cb_wrapper(false, CONSTANTS.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_GANGPLANK_JSON_DECODE_ERROR, "detail decode failed")
          end
        else
          local status = (...)
          cb_wrapper(false, status)
        end
      end)
    else
      local _code, _msg = ...
      cb_wrapper(false, _code, _msg)
    end
  end
  
  M.server_list_ticket_with_params(inner_cb, params)
end

function M.server_list_ticket_detail_with_node(cb, params)
  local function cb_wrapper(succ, ...)
    if cb then
      cb(succ, ...)
    end
    if succ then
      E.LOG.debug(TAG, "server_list_ticket_detail_with_node succ")
    else
      local _code, _msg = ...
      E.LOG.warn(TAG, "server_list_ticket_detail_with_node failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
      QL.commit_action_fail_main("server_list_ticket_detail_with_node", nil, _code, _msg)
    end
  end
  
  local function inner_cb(succ, ...)
    if not succ then
      local _code, _msg = ...
      cb_wrapper(false, _code, _msg)
      return
    end
    local hash = (...)
    local fn = string.format("%s_sl_cache_v2", hash)
    local cache = E.File.readfile(fn)
    if nil ~= cache then
      local cache_detail_info = JSON.safe_decode(cache)
      if cache_detail_info then
        E.LOG.debug(TAG, "server_detail_node get from cache >>")
        E.LOG.debug(TAG, cache_detail_info)
        cb_wrapper(true, cache_detail_info.anns)
        return
      end
    end
    M.server_list_node_detail(hash, function(succ2, ...)
      if not succ2 then
        local _code2, _msg2 = ...
        cb_wrapper(false, _code2, _msg2)
        return
      end
      local detail = (...)
      local detail_info = JSON.safe_decode(detail)
      if detail_info then
        E.LOG.debug(TAG, "server_detail_node and cache >>")
        E.LOG.debug(TAG, detail)
        E.File.writefile(fn, detail)
        cb_wrapper(true, detail_info.anns)
      else
        E.LOG.debug(TAG, "server_list_ticket_detail_with_node HTTP response get wrong response data, please retry it")
        cb_wrapper(false, CONSTANTS.GLOBAL_GANGPLANK_ERROR_CODE.GLOBAL_GANGPLANK_JSON_DECODE_ERROR, "detail decode failed")
      end
    end)
  end
  
  M.server_list_ticket_with_params(inner_cb, params)
end

function M.server_list_ticket_detail_v2(tags, cb, ext)
  local no_tags = false
  if type(tags) == "function" then
    cb = tags
    no_tags = true
  elseif not tags then
    no_tags = true
  end
  local params = {}
  if not no_tags then
    params.tags = tags
  end
  params.ext = ext
  M.server_list_ticket_detail_with_params_v2(cb, params)
end

function M.server_list_ticket_detail(tags, cb)
  local no_tags = false
  if type(tags) == "function" then
    cb = tags
    no_tags = true
  elseif not tags then
    no_tags = true
  end
  local params = {}
  if not no_tags then
    params.tags = tags
  end
  M.server_list_ticket_detail_with_params(cb, params)
end

M.SHOW_TICKET_DETAIL_CODE = {
  ERR_GET_DETAIL = -1,
  ERR_EMPTY_LIST = -2,
  ERR_NOT_RENDER_WITH_H5 = -3
}

function M.show_ticket_detail(ann_type, tags, server, cb, ext)
  cb = cb or {}
  M.ticket_detail(ann_type, tags, server, function(succ, body_str, ticket, hash)
    local err_code = M.SHOW_TICKET_DETAIL_CODE.ERR_GET_DETAIL
    local err_msg = "获取公告失败"
    if succ then
      local body_data = JSON.safe_decode(body_str)
      local anns = body_data.anns
      if anns and next(anns) then
        local body = anns[1]
        local _ann_type = body._ann_type
        local _render_type = body._render_type
        local _server_name = body._ann_param or ""
        if 1 == _render_type and _server_name and "" ~= _server_name then
          E.log("show announcement in SDK")
          local EGC = require("ejoysdk_lua.ejoysdk_gangplank_config")
          local gangplank_config = EGC.get_current_cdn_config()
          local url = "https://game-notice.ejoy.com"
          if gangplank_config and gangplank_config.render_center and gangplank_config.render_center.game_notice and "" ~= gangplank_config.render_center.game_notice then
            url = gangplank_config.render_center.game_notice
          else
            local CC = require("ejoysdk_lua.ejoysdk_config_center")
            local env = CC.get_env()
            if env ~= CC.ENV.RELEASE then
              url = "https://ieu-render-raven.alibaba.net/p/r_dev"
            end
          end
          if url.sub(url, -1) ~= "/" then
            url = url .. "/"
          end
          url = url .. _server_name
          local channel = get_full_channel()
          local tags_str = tags
          if type(tags) == "table" then
            tags_str = table.concat(tags, ",")
          elseif type(tags) == "string" then
            tags_str = tags
          end
          local query_params = {
            zone = EC.get_config("zone"),
            lang = EC.get_config("lang"),
            product_code = EC.get_config("product"),
            tags = tags_str,
            server = server,
            channel = channel,
            type = ann_type,
            hash = hash
          }
          url = E.HTTP.url_query(url, query_params)
          local host = E.HTTP.parse(url).host
          E.LOG.debug(TAG, "notice url: " .. url)
          E.WebView.open(url, {
            [host] = {
              startupData = {},
              transparent = true
            }
          }, {
            compactMode = true,
            use_fragment = true,
            hide_close_btn = true,
            use_cutout = true
          }, nil, function(_value)
            cb(true, body_str, ticket, _ann_type)
          end)
          local stat_params = {p1 = server}
          commit_action_succ_main_before_enter_game("ejoy_ticket_detail_show_end", ann_type, stat_params)
          return
        else
          E.log("show announcement in game")
          err_code = M.SHOW_TICKET_DETAIL_CODE.ERR_NOT_RENDER_WITH_H5
          err_msg = "公告非H5渲染"
        end
      else
        err_code = M.SHOW_TICKET_DETAIL_CODE.ERR_EMPTY_LIST
        err_msg = "公告列表为空"
      end
    end
    cb(false, err_code, err_msg)
    local stat_params = {p1 = server}
    commit_action_fail_main_before_enter_game("ejoy_ticket_detail_show_end", ann_type, err_code, err_msg, stat_params)
  end, ext)
end

local _end_with_file_patterns = {
  "_sl_cache",
  "_sl_cache_v2",
  "_ticket_cache"
}
M.end_with_file_patterns = _end_with_file_patterns

function M.clean_disk_cache(_opts)
  local function matchPattern(fileName, patterns)
    for _, pattern in ipairs(patterns) do
      if fileName and E.Utils.end_with(fileName, pattern) then
        return true
      end
    end
    return false
  end
  
  local _cache_file_ends = utils.deepcopy(_end_with_file_patterns)
  if _opts and _opts.end_with_file_patterns then
    for _, v in pairs(_opts.end_with_file_patterns) do
      table.insert(_cache_file_ends, v)
    end
  end
  local currentDir = E.File.get_ext_file_dir()
  E.File.list_directory(currentDir, false, true, function(ret)
    local remove_files = {}
    for _, item in ipairs(ret) do
      local item_path = item.path
      if item_path and not item.is_dir and matchPattern(item_path, _cache_file_ends) then
        table.insert(remove_files, item_path)
      end
    end
    if #remove_files > 0 then
      E.File.batch_remove(remove_files, function(succ, ...)
        if not succ then
          local code, msg = ...
          E.log("ejoysdk_launcher clear_cache failed, code: " .. tostring(code) .. ", msg: " .. tostring(msg))
        else
          E.log("ejoysdk_launcher clear_cache success")
        end
      end, {is_fullpath = false})
    end
  end)
end

return M
