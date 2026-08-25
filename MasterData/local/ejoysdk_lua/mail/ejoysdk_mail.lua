local E = require("ejoysdk_lua.ejoysdk")
local BASE_API = require("ejoysdk_lua.libs.base_api")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local game_adapter_api = BASE_API:New("game-adapter")
local TAG = "EJOYSDK_MAIL"
local M = {}
local mail_cache = {}
local MAIL_CLIENT_REFRESH_TIME = 600
local server_refresh_mail_time = 0
local server_mail_config = {}
local mail_pull_config = {}
local mail_push_handler
local mail_inited = false
local refresh_data_timer_enabled = false
local player_online = false
local interrupt_batch_request = false
local init_tick = false
local TICK_INTERVAL = 1
local MAIL_HANDLERS = {}
local request_page_queue = {}
local OP = {
  READ = "/read",
  DELETE = "/delete",
  FETCH_ATTACHMENT = "/fetch_attachment",
  UPDATE_MAIL_TAG = "/update_mail_tag"
}

local function merge_array_data(table1, table2)
  if nil == table2 then
    return
  end
  if nil == table1 then
    table1 = {}
  end
  for _, value in ipairs(table2) do
    table.insert(table1, value)
  end
end

local function is_array_table(t)
  if type(t) ~= "table" then
    return false
  end
  local n = #t
  for key, _ in pairs(t) do
    if type(key) ~= "number" then
      return false
    end
    if key > n then
      return false
    end
  end
  return true
end

local function merge_table_data(table1, table2)
  if nil == table2 then
    return
  end
  if nil == table1 then
    table1 = {}
  end
  for key, value in pairs(table2) do
    if nil == table1[key] then
      table1[key] = value
    elseif type(value) == "number" then
      table1[key] = table1[key] + value
    elseif is_array_table(value) then
      merge_array_data(table1[key], value)
    else
      E.LOG.debug(TAG, "error merge table data")
    end
  end
end

local function mail_api_path(api)
  api = "/client_api_v2/mail" .. api
  return api
end

local function get_page_cache(page)
  local page_cache = mail_cache[page]
  if page_cache and page_cache.now_ms == server_refresh_mail_time then
    return page_cache
  end
end

local function inner_get_mails(page, use_cache, cb, tag_id)
  local page_str = tostring(page)
  tag_id = tag_id or ""
  if use_cache and "" == tag_id then
    local cache_mails = get_page_cache(page)
    if cache_mails then
      if cb then
        cb(true, UTILS.deepcopy(cache_mails))
      end
      return
    end
  end
  mail_pull_config.tag_id = mail_pull_config.tag_id or ""
  if mail_pull_config and mail_pull_config.page == page and mail_pull_config.tag_id == tag_id and request_page_queue[page_str] and request_page_queue[page_str][tag_id] and request_page_queue[page_str][tag_id].requesting and request_page_queue[page_str][tag_id].server_refresh_mail_time == server_refresh_mail_time then
    if not request_page_queue[page_str][tag_id].cb_list then
      request_page_queue[page_str][tag_id].cb_list = {}
    end
    if cb then
      E.LOG.debug(TAG, "get_mails page requesting, cache cb and wait")
      table.insert(request_page_queue[page_str][tag_id].cb_list, cb)
    else
      E.LOG.debug(TAG, "get_mails page requesting, cb is nil and ignore")
    end
    return
  end
  if not request_page_queue[page_str] then
    request_page_queue[page_str] = {}
  end
  request_page_queue[page_str][tag_id] = {requesting = true, server_refresh_mail_time = server_refresh_mail_time}
  mail_pull_config.page = page
  mail_pull_config.tag_id = tag_id
  local opt = {use_moment_token = true}
  E.LOG.debug(TAG, mail_pull_config)
  game_adapter_api:post(mail_api_path("/list"), {}, mail_pull_config, opt, function(succ, ...)
    if succ then
      local res_body = (...)
      server_mail_config = res_body.config or {}
      if not mail_cache[page] then
        mail_cache[page] = {}
      end
      if "" == tag_id then
        mail_cache[page] = res_body
      end
      local msg = {
        now_ms = res_body.now_ms,
        need_concern = res_body.need_concern
      }
      if res_body.concern_info then
        msg.mails_add = {}
        msg.mails_add_count = 0
        for concern_info_key, concern_info_value in pairs(res_body.concern_info) do
          msg[concern_info_key] = concern_info_value
        end
      end
      MAIL_HANDLERS.mail_update_push(msg)
      if cb then
        cb(true, UTILS.deepcopy(res_body))
      end
      if request_page_queue[page_str][tag_id] then
        request_page_queue[page_str][tag_id].requesting = false
        if request_page_queue[page_str][tag_id].cb_list then
          for _, cache_cb in ipairs(request_page_queue[page_str][tag_id].cb_list) do
            cache_cb(true, UTILS.deepcopy(res_body))
          end
          request_page_queue[page_str][tag_id].cb_list = nil
        end
      end
    else
      if cb then
        cb(false, ...)
      end
      if request_page_queue[page_str][tag_id] then
        request_page_queue[page_str][tag_id].requesting = false
        if request_page_queue[page_str][tag_id].cb_list then
          for _, cache_cb in ipairs(request_page_queue[page_str][tag_id].cb_list) do
            cache_cb(false, ...)
          end
          request_page_queue[page_str][tag_id].cb_list = nil
        end
      end
    end
  end)
end

local function start_timer_refresh_data()
  E.LOG.debug(TAG, "start timer to refresh data")
  local refresh_mail_data
  
  function refresh_mail_data()
    if player_online then
      inner_get_mails(1, false, nil)
    else
      E.LOG.debug(TAG, "player has logout, skip get mail")
    end
    E.Timer.once(MAIL_CLIENT_REFRESH_TIME, refresh_mail_data)
  end
  
  E.Timer.once(MAIL_CLIENT_REFRESH_TIME, refresh_mail_data)
end

local function logout_handler()
  M.clean_cache()
  player_online = false
end

function M.HANDLERS(header, msg)
  local method = header.method
  if not method then
    return
  end
  if MAIL_HANDLERS[method] then
    MAIL_HANDLERS[method](msg)
  end
end

function MAIL_HANDLERS.mail_update_push(msg)
  E.LOG.debug(TAG, "try mail_update_push")
  local now_ms = tonumber(msg.now_ms)
  local server_refresh_mail_time_number = tonumber(server_refresh_mail_time)
  local show_cb_mail = false
  if now_ms and server_refresh_mail_time_number and now_ms > server_refresh_mail_time_number then
    show_cb_mail = true
  else
    E.LOG.debug(TAG, "current refresh mail time is bigger than msg's now_ms, shouldn't push to game")
  end
  server_refresh_mail_time = msg.now_ms
  if show_cb_mail and mail_push_handler then
    E.LOG.debug(TAG, "push msg to game")
    mail_push_handler(msg)
  else
    E.LOG.debug(TAG, "not set push handler or refresh mail time is bigger, should not handle push")
  end
end

function M.init()
  if mail_inited then
    E.LOG.debug(TAG, "already init and return")
    return
  end
  local lang = E.CONFIG.get_config("lang")
  mail_pull_config = {
    limit = 50,
    sort_type = 1,
    recv_push = true,
    lang = lang or "zh-hans"
  }
  ET.subscribe(ET.gangplank.LOGOUT, function()
    E.LOG.debug(TAG, "gangplank logout, clean cache")
    logout_handler()
  end)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, function()
    E.LOG.debug(TAG, "player offline, clean cache")
    logout_handler()
  end)
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, function()
    M.clean_cache()
    player_online = true
    inner_get_mails(1, false, nil)
    if not refresh_data_timer_enabled then
      refresh_data_timer_enabled = true
      start_timer_refresh_data()
    end
    if not init_tick then
      init_tick = true
      local CHAT_SERVER = require("ejoysdk_lua.chat.ejoysdk_chat_server")
      local ticker
      
      function ticker()
        local CHAT = require("ejoysdk_lua.chat.ejoysdk_chat")
        if CHAT.has_tick() then
          return
        end
        CHAT_SERVER.tick()
        E.Timer.once(TICK_INTERVAL, ticker)
      end
      
      E.Timer.once(TICK_INTERVAL, ticker)
    end
  end)
  local CHAT = require("ejoysdk_lua.chat.ejoysdk_chat")
  CHAT.real_init()
  local DISPATCHER = require("ejoysdk_lua.chat.ejoysdk_chat_push_dispatcher")
  local CHAT_SERVER = require("ejoysdk_lua.chat.ejoysdk_chat_server")
  DISPATCHER.register_chat_handlers(CHAT_SERVER.DESTINATION.CLIENT_MAIL, M.HANDLERS)
  mail_inited = true
end

function M.set_mail_pull_config(params)
  for config_key, config_value in pairs(params) do
    mail_pull_config[config_key] = config_value
  end
end

function M.get_mails(page, cb, tag_id)
  inner_get_mails(page, true, cb, tag_id)
end

function M.get_mails_from_server(page, cb, tag_id)
  inner_get_mails(page, false, cb, tag_id)
end

local function is_need_batch(params)
  if params and params.mail_ids and server_mail_config.batch_size and #params.mail_ids > server_mail_config.batch_size then
    return true
  end
  return false
end

local function split_mails_array(mail_ids, batch_size)
  local mails_id_array = {}
  if mail_ids and next(mail_ids) then
    local current_array_index = 0
    local current_array = {}
    table.insert(mails_id_array, current_array)
    for _, mail_id in ipairs(mail_ids) do
      if current_array_index == batch_size then
        current_array = {}
        current_array_index = 0
        table.insert(mails_id_array, current_array)
      end
      current_array_index = current_array_index + 1
      table.insert(current_array, mail_id)
    end
  end
  return mails_id_array
end

local function batch_op_mails(params, op_fun, merge_result_op_fun, cb, batch_cb)
  interrupt_batch_request = false
  cb = cb or function()
  end
  local batch_size = server_mail_config.batch_size
  local mails_id_array = split_mails_array(params.mail_ids, batch_size)
  if mails_id_array and next(mails_id_array) then
    local merge_result, error_code, error_msg, batch_inner_cb
    params.mail_ids = mails_id_array[1]
    
    function batch_inner_cb(succ, ...)
      E.LOG.debug(TAG, "return op mails batch result")
      if batch_cb then
        batch_cb(succ, ...)
      end
      if succ then
        if nil == merge_result then
          merge_result = (...)
        else
          local batch_result = (...)
          merge_result_op_fun(merge_result, batch_result)
        end
      else
        error_code, error_msg = ...
        E.LOG.debug(TAG, "batch op mails fail, code is " .. tostring(error_code) .. ", msg is " .. tostring(error_msg))
      end
      table.remove(mails_id_array, 1)
      if next(mails_id_array) and false == interrupt_batch_request then
        params.mail_ids = mails_id_array[1]
        op_fun(params, batch_inner_cb)
      elseif merge_result then
        cb(true, merge_result)
      else
        cb(false, error_code, error_msg)
      end
    end
    
    op_fun(params, batch_inner_cb)
  end
end

local function handle_mails(api, params, cb, batch_cb)
  local opt = {use_moment_token = true}
  game_adapter_api:post(mail_api_path(api), {}, params, opt, function(succ, ...)
    if succ then
      local res_body = (...)
      M.clean_cache()
      if cb then
        cb(true, res_body)
      end
      if batch_cb then
        batch_cb(true, res_body)
      end
    else
      if cb then
        cb(false, ...)
      end
      if batch_cb then
        batch_cb(false, ...)
      end
    end
  end)
end

local function inner_set_mails_read(params, cb)
  handle_mails(OP.READ, params, cb)
end

local function inner_delete_mails(params, cb)
  handle_mails(OP.DELETE, params, cb)
end

local function inner_fetch_attachment(params, cb)
  handle_mails(OP.FETCH_ATTACHMENT, params, cb)
end

local function inner_update_mail_tag(params, cb)
  handle_mails(OP.UPDATE_MAIL_TAG, params, cb)
end

function M.set_mails_read(params, cb, batch_cb)
  if is_need_batch(params) then
    batch_op_mails(params, inner_set_mails_read, function(merge_result, batch_result)
      merge_array_data(merge_result.succ_ids, batch_result.succ_ids)
    end, cb, batch_cb)
  else
    handle_mails(OP.READ, params, cb, batch_cb)
  end
end

function M.fetch_attachment(params, cb, batch_cb)
  if is_need_batch(params) then
    batch_op_mails(params, inner_fetch_attachment, function(merge_result, batch_result)
      merge_array_data(merge_result.succ_list, batch_result.succ_list)
      merge_array_data(merge_result.fail_list, batch_result.fail_list)
    end, cb, batch_cb)
  else
    handle_mails(OP.FETCH_ATTACHMENT, params, cb, batch_cb)
  end
end

function M.delete_mails(params, cb, batch_cb)
  if is_need_batch(params) then
    batch_op_mails(params, inner_delete_mails, function(merge_result, batch_result)
      merge_array_data(merge_result.succ_ids, batch_result.succ_ids)
    end, cb, batch_cb)
  else
    handle_mails(OP.DELETE, params, cb, batch_cb)
  end
end

function M.update_mail_tag(params, cb, batch_cb)
  params.tag_id = params.tag_id or ""
  if is_need_batch(params) then
    batch_op_mails(params, inner_update_mail_tag, function(merge_result, batch_result)
      merge_array_data(merge_result.succ_list, batch_result.succ_list)
      merge_array_data(merge_result.fail_list, batch_result.fail_list)
    end, cb, batch_cb)
  else
    handle_mails(OP.UPDATE_MAIL_TAG, params, cb, batch_cb)
  end
end

local function inner_operate_all(params, cb)
  local opt = {use_moment_token = true}
  params.batch_request = true
  game_adapter_api:post(mail_api_path("/operate_all"), {}, params, opt, function(succ, ...)
    if succ then
      local res_body = (...)
      local changed = res_body.changed or false
      if changed then
        M.clean_cache()
      end
      cb(true, res_body)
    else
      cb(false, ...)
    end
  end)
end

function M.operate_all(params, cb, batch_cb)
  interrupt_batch_request = false
  params = params or {}
  params.action = nil
  cb = cb or function()
  end
  local merge_result, batch_inner_cb
  
  function batch_inner_cb(succ, ...)
    if batch_cb then
      batch_cb(succ, ...)
    end
    if succ then
      local res_body = (...)
      if nil == merge_result then
        merge_result = res_body
      else
        merge_result.changed = res_body.changed or merge_result.changed
        merge_result.has_more = res_body.has_more and merge_result.has_more
        if res_body.result then
          merge_table_data(merge_result.result, res_body.result)
        end
      end
      if res_body.has_more and false == interrupt_batch_request then
        params = params or {}
        params.action = "continue"
        E.LOG.debug(TAG, "operate_all next page, action:continue")
        inner_operate_all(params, batch_inner_cb)
      else
        cb(true, merge_result)
      end
    else
      cb(false, ...)
    end
  end
  
  inner_operate_all(params, batch_inner_cb)
end

function M.clean_cache()
  mail_cache = {}
end

function M.set_mail_push_handlers(handler)
  mail_push_handler = handler
end

function M.interrupt()
  interrupt_batch_request = true
end

function M.get_mail_tag_list(params, cb)
  params = params or {}
  if not params.lang and mail_pull_config.lang then
    params.lang = mail_pull_config.lang
  end
  handle_mails("/list_tag", params, cb)
end

return M
