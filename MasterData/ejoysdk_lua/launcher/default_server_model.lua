local E = require("ejoysdk_lua.ejoysdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local Class = require("ejoysdk_lua.ejoysdk_class")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local STAT = require("ejoysdk_lua.ejoysdk_stat")
local TAG = "default_server_model"
local SELECT_TYPE = {
  MANUAL = "manual",
  AUTO_SUGGEST = "auto_suggest"
}
local EMPTY_SERVER_STORAGE = {
  server_id = nil,
  player_id = nil,
  select_type = nil
}
local M = {}
local LastPersistSelectedServerCache = E.LazyKeyStore:New("LastPersistSelectedServerCache", false, true, false)
local QueryServerStatusIntervalSec = 15
local static_temp_select_cache

local function request_alive_status(server_id, params, cb)
  local request_alive_fun = EG.alive_servers_with_params
  local permit_info = EG.user_info().permit_info or {}
  if permit_info.is_white == true then
    request_alive_fun = EG.alive_servers_auth_with_params
  end
  local query_params = utils.deepcopy(params) or {}
  query_params.server_ids = {server_id}
  E.LOG.debug(TAG, "begin query alive status for current_select_server_id:" .. tostring(server_id))
  request_alive_fun(function(succ, ...)
    if not succ then
      local code, msg = ...
      E.LOG.warn(TAG, "query_server_alives failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(nil, code, msg)
      return
    end
    local alive_servers = (...)
    local alive_server_size = alive_servers and #alive_servers or 0
    if alive_server_size >= 1 then
      cb(alive_servers[1])
    else
      E.LOG.warn(TAG, "query alive server for server_id empty")
      cb(nil, CONSTANTS.GANGPLANK_ERROR_CODE.ALIVE_SERVER_RESPONSE_SERVER_LIST_INVALID, "alive result server list empty")
    end
  end, query_params)
end

local function request_a_recommend_server(params, cb)
  local LauncherExt = require("ejoysdk_lua.ejoysdk_launcher_ext")
  params = params or {}
  params.use_guarantee = true
  LauncherExt.request_recommend_server_list(params, function(_succ, ...)
    if _succ then
      local sorted_recommend_server_list, marks = ...
      local recommend_server_info
      local select_server_id = static_temp_select_cache:get_select_server()
      if select_server_id then
        E.LOG.debug(TAG, "pick_a_recommend_server static_last_suggest_recommend_server:" .. tostring(select_server_id))
        for _, rs in ipairs(sorted_recommend_server_list) do
          if rs.server_id == select_server_id then
            recommend_server_info = rs
            break
          end
        end
      end
      if not recommend_server_info then
        E.LOG.debug(TAG, "pick_a_recommend_server need refresh recommend server")
        local index = math.random(1, math.ceil(#sorted_recommend_server_list / 4))
        recommend_server_info = utils.safe_get_array_item(sorted_recommend_server_list, index)
      end
      marks = marks or {}
      recommend_server_info.source_type = LauncherExt.SOURCE_TYPE.RECOMMEND
      recommend_server_info.recommend_data_info = true
      recommend_server_info.marks = marks[recommend_server_info.server_id] or {}
      cb(true, recommend_server_info)
    else
      local code, msg = ...
      E.LOG.error(TAG, "request_recommend_server failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

local function request_server_info(server_id, params, cb)
  local LauncherExt = require("ejoysdk_lua.ejoysdk_launcher_ext")
  params = params or {}
  params.enable_request_alive_with_auth = true
  LauncherExt.request_server_info(server_id, params, function(succ, ...)
    cb(succ, ...)
  end)
end

local function get_login_server(params, cb)
  if not (EG.user_info() and EG.user_info().uid) or not EG.user_info().token then
    cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_NEED_ACCOUNT_LOGIN, "need account login or ejoy token miss for get last enter server")
    E.LOG.error(TAG, "need account login or ejoy token miss for get last enter server")
    return
  end
  if params.player_id then
    params.player_id = tostring(params.player_id)
  end
  params.born_publish_area = params.born_publish_area or params.born_publish_area_list
  params.born_publish_area_list = nil
  local user_info_api = require("ejoysdk_lua.server_api.ejoysdk_user_info")
  user_info_api.get_last_login_player(params, function(succ, ...)
    if succ then
      local ret = (...) or {}
      E.LOG.debug(TAG, "get_last_login_player succ:")
      E.log(ret)
      cb(true, ret)
    else
      local code, msg, err_body = ...
      cb(false, code, msg, err_body)
    end
  end)
end

local function get_last_login_or_recommend_server(params, cb)
  local function do_request_a_recommend_server()
    request_a_recommend_server(params, function(succ3, ...)
      if succ3 then
        local recommend_server_info = (...)
        
        E.LOG.debug(TAG, "get_default_login_server pick a recommend server succ:")
        E.log(recommend_server_info)
        utils.safe_call_cb(cb, true, nil, recommend_server_info, SELECT_TYPE.AUTO_SUGGEST)
      else
        local code2, msg2 = ...
        E.LOG.error(TAG, "get_default_login_server pick a recommend server failed, code:" .. tostring(code2) .. ", msg:" .. tostring(msg2))
        utils.safe_call_cb(cb, false, code2, msg2)
      end
    end)
  end
  
  local get_params = utils.deepcopy(params) or {}
  get_params.player_id = nil
  get_login_server(get_params, function(succ, ...)
    if succ then
      local ret = (...)
      if ret.player then
        local server_id = ret.player.server_id
        local player_id = ret.player.player_id
        E.LOG.debug(TAG, "get_default_login_server suggest last login player_id:" .. tostring(player_id) .. ", and find server_id:" .. tostring(server_id))
        request_server_info(server_id, params, function(succ2, ...)
          if succ2 then
            local server_info = (...)
            utils.safe_call_cb(cb, true, player_id, server_info, SELECT_TYPE.AUTO_SUGGEST)
          else
            local code2, msg2 = ...
            utils.safe_call_cb(cb, false, code2, msg2)
          end
        end)
      else
        E.LOG.warn(TAG, "get_default_login_server get_last_login_player player not exists")
        do_request_a_recommend_server()
      end
    else
      local code2, msg2 = ...
      if code2 == CONSTANTS.GANGPLANK_ERROR_CODE.ACCOUNT_NOT_HAS_PLAYERS then
        E.LOG.error(TAG, "get_last_login_or_recommend_server server return no players in current account")
        do_request_a_recommend_server()
      else
        E.LOG.error(TAG, "get_last_login_or_recommend_server failed, code:" .. tostring(code2) .. ", msg:" .. tostring(msg2))
        utils.safe_call_cb(cb, false, code2, msg2)
      end
    end
  end)
end

local SelectServerCache = Class:Inherit("ServerInfoCache")

function SelectServerCache:_init()
  E.LOG.debug(TAG, "ServerInfoCache _init")
  local last_select_storage = LastPersistSelectedServerCache:get() or utils.deepcopy(EMPTY_SERVER_STORAGE)
  self._data = {
    params = {},
    on_update_listener = nil,
    is_server_info_update_running = false,
    server_info = nil,
    server_id = last_select_storage.server_id,
    player_id = last_select_storage.player_id,
    select_type = last_select_storage.select_type,
    select_time = E.system_clock()
  }
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO_INVOKED, function(player_info)
    E.LOG.debug(TAG, "set_player_info received, stop loop query")
    if self._data.server_id == player_info.server_id then
      E.LOG.debug(TAG, "set_player_info received, and equals with select server_id:" .. tostring(self._data.server_id) .. ", update player_id:" .. tostring(player_info.player_id))
      self._data.select_type = SELECT_TYPE.MANUAL
      self._data.player_id = player_info.player_id
    else
      E.LOG.error(TAG, "set_player_info received, and not equals with select server_id:" .. tostring(self._data.server_id) .. ", enter server_id:" .. tostring(player_info.server_id))
      local stat_params = {
        [STAT.STAT_KEY.IS_PRIORITY_HIGH] = true
      }
      STAT.stat_action("select_server_not_match", player_info.server_id, self._data.server_id, stat_params)
      self._data.select_type = SELECT_TYPE.MANUAL
      self._data.player_id = player_info.player_id
      self._data.server_id = player_info.server_id
    end
    self:save_select_server_cache()
    self:stop_loop_query()
  end)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, function()
    E.LOG.debug(TAG, "player_offline received, begin check query")
    self:start_loop_query()
  end)
  ET.subscribe(ET.gangplank.LOGOUT, function()
    E.LOG.debug(TAG, "logout received, stop loop query")
    self:stop_loop_query()
    self:clear_select_memory()
  end)
end

function SelectServerCache:save_select_server_cache()
  local cache_data = {}
  cache_data.server_id = self._data.server_id
  cache_data.player_id = self._data.player_id
  cache_data.select_type = self._data.select_type
  E.LOG.debug(TAG, "save_select_server_cache to local begin")
  E.log(cache_data)
  LastPersistSelectedServerCache:set(cache_data)
end

function SelectServerCache:stop_loop_query()
  E.LOG.warn(TAG, "stop_loop_query begin")
  self._data.is_server_info_update_running = false
end

function SelectServerCache:start_loop_query()
  if not (not self._data.is_server_info_update_running and self._data.server_id) or not self._data.on_update_listener then
    E.LOG.debug(TAG, "start_loop_query skip for status, running:" .. tostring(self._data.is_server_info_update_running) .. ", server_id is nil:" .. tostring(not self._data.server_id) .. ", update listener is nil:" .. tostring(not self._data.on_update_listener))
    return
  end
  self._data.is_server_info_update_running = true
  local loop_query_handler
  
  function loop_query_handler()
    if not (self._data.is_server_info_update_running and self._data.on_update_listener) or not self._data.server_id then
      E.LOG.warn(TAG, "query stopped for running status:" .. tostring(self._data.is_server_info_update_running) .. ", server_id is nil:" .. tostring(not self._data.server_id) .. ", update listener is nil:" .. tostring(not self._data.on_update_listener))
      return
    end
    
    local function on_handle_loop_query_failed(code, msg)
      local sub_code = code
      if code == CONSTANTS.GANGPLANK_ERROR_CODE.ALIVE_SERVER_RESPONSE_SERVER_LIST_INVALID or code == CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_SERVER_LIST_IS_EMPTY then
        code = CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_TARGET_SERVER_NOT_FOUND
      end
      E.LOG.warn(TAG, "on_handle_loop_query_failed code:" .. tostring(code) .. ", msg:" .. tostring(msg) .. ", sub_code:" .. tostring(sub_code))
      self._data.on_update_listener(false, code, msg)
    end
    
    local request_server_id = self._data.server_id
    local current_select_type = self._data.select_type
    if current_select_type == SELECT_TYPE.MANUAL then
      E.LOG.debug(TAG, "query begin, select type is manual, request alive status for current_select_server_id:" .. tostring(request_server_id))
      if not self._data.server_info then
        request_server_info(request_server_id, self._data.params, function(succ2, ...)
          if succ2 then
            local server_info = (...)
            local update_succ = self:update_server_info(server_info)
            if update_succ then
              self._data.on_update_listener(true, self._data.player_id, server_info)
            end
          else
            local code, msg = ...
            E.LOG.warn(TAG, "query_server_alives failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
            on_handle_loop_query_failed(code, msg)
          end
        end)
      else
        request_alive_status(request_server_id, self._data.params, function(alive_server_info, ...)
          if alive_server_info and self._data.server_info and request_server_id == self._data.server_id then
            local LauncherExt = require("ejoysdk_lua.ejoysdk_launcher_ext")
            LauncherExt._update_alive_value(self._data.server_info, alive_server_info)
            self._data.on_update_listener(true, self._data.player_id, self._data.server_info)
          else
            local code, msg = ...
            E.LOG.warn(TAG, "query_server_alives failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
            on_handle_loop_query_failed(code, msg)
          end
        end)
      end
    else
      E.LOG.debug(TAG, "query begin, select type is auto_suggest, request recommend server")
      get_last_login_or_recommend_server(self._data.params, function(succ, ...)
        if succ then
          local player_id, recommend_server_info = ...
          if self._data.select_type == SELECT_TYPE.AUTO_SUGGEST then
            E.LOG.debug(TAG, "request_a_recommend_server pick a recommend server succ:")
            E.log(recommend_server_info)
            local select_succ
            if player_id then
              select_succ = self:update_select_player(player_id, recommend_server_info.server_id, SELECT_TYPE.AUTO_SUGGEST)
            else
              select_succ = self:update_select_server(recommend_server_info.server_id, SELECT_TYPE.AUTO_SUGGEST)
            end
            if select_succ and self:update_server_info(recommend_server_info) then
              self._data.on_update_listener(true, player_id, recommend_server_info)
            end
          else
            E.LOG.warn(TAG, "request_a_recommend_server return but current select type is manual skip update:" .. tostring(self._data.select_type))
          end
        else
          local code, msg = ...
          E.LOG.error(TAG, "request_a_recommend_server pick a recommend server failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        end
      end)
    end
    E.Timer.once(QueryServerStatusIntervalSec, loop_query_handler)
  end
  
  E.Timer.once(QueryServerStatusIntervalSec, loop_query_handler)
end

function SelectServerCache:update_server_info(server_info)
  if not server_info then
    E.LOG.warn(TAG, "update_server_info skip, server_info is nil")
    return false
  end
  if self._data.server_id ~= server_info.server_id then
    E.LOG.debug(TAG, "update_server_info skip, server_info server_id not same with select server_id, server_info id:" .. tostring(server_info.server_id) .. ", select server_id:" .. tostring(self._data.server_id))
    return false
  end
  self._data.server_info = server_info
  return true
end

function SelectServerCache:clear_select_memory()
  self._data.server_id = EMPTY_SERVER_STORAGE.server_id
  self._data.player_id = EMPTY_SERVER_STORAGE.player_id
  self._data.select_type = EMPTY_SERVER_STORAGE.select_type
  self._data.select_time = 0
  self._data.server_info = nil
end

function SelectServerCache:clear()
  E.LOG.debug(TAG, "clear_default_server_cache memory and local cache begin")
  self:clear_select_memory()
  self:save_select_server_cache()
end

function SelectServerCache:update_server_info_cache_params(params, on_update_listener)
  self._data.params = params
  self._data.on_update_listener = on_update_listener
  E.LOG.debug(TAG, "update_server_info_cache_params >>")
  E.log(params)
  if not self._data.server_info then
    return nil
  end
  if not params or next(params) == nil then
    return self._data.server_info
  end
  
  local function check_params_matches(_params)
    local is_valid = _params.auto_player_change_server == self._data.params.auto_player_change_server and _params.server_node == self._data.params.server_node
    if is_valid then
      local new_born_publish_area_list = _params and (_params.born_publish_area or _params.born_publish_area_list)
      local cur_born_publish_area_list = not self._data.params or self._data.params.born_publish_area or self._data.params.born_publish_area_list
      if new_born_publish_area_list and cur_born_publish_area_list then
        local new_list_size = #new_born_publish_area_list
        local curr_list_size = #cur_born_publish_area_list
        if new_list_size ~= curr_list_size then
          return false
        else
          table.sort(new_born_publish_area_list)
          table.sort(cur_born_publish_area_list)
          for idx, item in ipairs(new_born_publish_area_list) do
            if cur_born_publish_area_list[idx] ~= item then
              return false
            end
          end
          return true
        end
      else
        return false
      end
    else
      return false
    end
  end
  
  local server_info_params_matches = check_params_matches(params)
  if server_info_params_matches then
    return self._data.server_info
  else
    E.LOG.warn(TAG, "update_server_info_cache_params check_params_matches not match, reset current server_info")
    self._data.server_info = nil
    return nil
  end
end

function SelectServerCache:update_select_player(player_id, server_id, select_type, select_operation_time)
  select_operation_time = select_operation_time or E.system_clock()
  if select_operation_time < self._data.select_time then
    E.LOG.debug(TAG, "update_select_player operation time before current select_time, select_operation_time:" .. tostring(select_operation_time) .. ", current select time:" .. tostring(self._data.select_time))
    local stat_params = {}
    stat_params.p1 = player_id
    stat_params.p2 = server_id
    stat_params.p3 = select_type
    stat_params.p4 = self._data.player_id
    stat_params.p5 = self._data.server_id
    STAT.stat_action("update_select_player_operation_skip", select_operation_time, self._data.select_time, stat_params)
    return false, CONSTANTS.GANGPLANK_ERROR_CODE.SELECT_OPERATION_EXPIRED_HAS_NEWER, "has new select operation"
  end
  E.LOG.debug(TAG, "select_default_login_player player_id:" .. tostring(player_id))
  local select_server_changes = self._data.player_id ~= player_id or self._data.server_id and server_id and self._data.server_id ~= server_id
  if select_server_changes then
    self._data.server_info = nil
  end
  E.LOG.debug(TAG, "select_default_login_player received, server_id:" .. tostring(server_id) .. ", player_id:" .. tostring(player_id) .. ", select_type:" .. tostring(select_type) .. ", last cache server_id:" .. tostring(self._data.server_id) .. ", last cache player_id:" .. tostring(self._data.player_id) .. ", select_operation_time:" .. tostring(select_operation_time))
  self._data.player_id = player_id
  self._data.server_id = server_id
  self._data.select_type = select_type
  self._data.select_time = select_operation_time
  static_temp_select_cache:start_loop_query()
  return true
end

function SelectServerCache:update_select_server(server_id, select_type, select_operation_time)
  select_operation_time = select_operation_time or E.system_clock()
  if select_operation_time < self._data.select_time then
    E.LOG.debug(TAG, "update_select_server operation time before current select_time, select_operation_time:" .. tostring(select_operation_time) .. ", current select time:" .. tostring(self._data.select_time))
    local stat_params = {}
    stat_params.p1 = server_id
    stat_params.p2 = select_type
    stat_params.p3 = self._data.player_id
    stat_params.p4 = self._data.server_id
    STAT.stat_action("update_select_server_operation_skip", select_operation_time, self._data.select_time, stat_params)
    return false, CONSTANTS.GANGPLANK_ERROR_CODE.SELECT_OPERATION_EXPIRED_HAS_NEWER, "has new select operation"
  end
  local select_server_changes = self._data.server_id ~= server_id
  if select_server_changes then
    self._data.server_info = nil
    if self._data.player_id then
      self._data.player_id = nil
    end
  end
  self._data.server_id = server_id
  self._data.select_type = select_type
  self._data.select_time = select_operation_time
  E.LOG.debug(TAG, "update_select_server received, server_id:" .. tostring(server_id) .. ", player_id:" .. tostring(self._data.player_id) .. ", select_type:" .. tostring(select_type) .. ", select_operation_time:" .. tostring(select_operation_time))
  static_temp_select_cache:start_loop_query()
  return true
end

function SelectServerCache:get_select_server()
  E.LOG.debug(TAG, "get_select_server, server_id:" .. tostring(self._data.server_id) .. ", player_id:" .. tostring(self._data.player_id) .. ", select_type:" .. tostring(self._data.select_type))
  return self._data.server_id, self._data.player_id, self._data.select_type, self._data.server_info
end

function SelectServerCache:on_server_id_invalid(server_id)
  E.LOG.debug(TAG, "on_server_id_invalid server_id:" .. tostring(server_id))
  STAT.stat_action("select_server_server_id_invalid", server_id)
  if server_id == self._data.server_id then
    self:clear_select_memory()
  end
  local storage_cache = LastPersistSelectedServerCache:get() or {}
  if storage_cache.server_id == server_id then
    LastPersistSelectedServerCache:delete()
  end
end

function SelectServerCache:on_player_id_invalid(player_id)
  E.LOG.debug(TAG, "on_player_id_invalid player_id:" .. tostring(player_id))
  STAT.stat_action("select_server_player_id_invalid", player_id)
  if player_id == self._data.player_id then
    self:clear_select_memory()
  end
  local storage_cache = LastPersistSelectedServerCache:get() or {}
  if storage_cache.player_id == player_id then
    LastPersistSelectedServerCache:delete()
  end
end

static_temp_select_cache = SelectServerCache:New()
M.TestConfig = {serverReturnNoPlayer = false}

function M.select_server_for_entergame(server_id)
  if not server_id then
    E.LOG.warn(TAG, "select_server_for_entergame should not be nil")
    return
  end
  static_temp_select_cache:update_select_server(server_id, SELECT_TYPE.MANUAL)
end

function M.select_player_for_entergame(player_id, server_id)
  if not player_id or not server_id then
    E.LOG.warn(TAG, "select_default_login_player player_id or server_id should not be nil")
    return
  end
  static_temp_select_cache:update_select_player(player_id, server_id, SELECT_TYPE.MANUAL)
end

local function get_default_login_server_with_player_id(select_player_id, params, cb)
  local function do_request_a_recommend_server()
    request_a_recommend_server(params, function(succ2, ...)
      if succ2 then
        local recommend_server_info = (...)
        
        E.LOG.debug(TAG, "get_default_login_server pick a recommend server succ:")
        E.log(recommend_server_info)
        utils.safe_call_cb(cb, true, nil, recommend_server_info, SELECT_TYPE.AUTO_SUGGEST)
      else
        local code, msg = ...
        E.LOG.error(TAG, "get_default_login_server pick a recommend server failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        utils.safe_call_cb(cb, false, code, msg)
      end
    end)
  end
  
  local get_params = utils.deepcopy(params) or {}
  get_params.player_id = select_player_id
  get_login_server(get_params, function(succ, ...)
    if succ then
      local ret = (...)
      if ret.player then
        local server_id = ret.player.server_id
        local player_id = ret.player.player_id
        local select_type
        if select_player_id ~= player_id then
          E.LOG.warn(TAG, "get_default_login_server select_player_id not exists:" .. tostring(select_player_id) .. ", server return last login player:" .. tostring(player_id))
          static_temp_select_cache:on_player_id_invalid(select_player_id)
          select_type = SELECT_TYPE.AUTO_SUGGEST
        else
          E.LOG.debug(TAG, "get_default_login_server select_player_id exists:" .. tostring(select_player_id) .. ", and find server_id:" .. tostring(server_id))
          select_type = SELECT_TYPE.MANUAL
        end
        request_server_info(server_id, params, function(succ2, ...)
          if succ2 then
            local server_info = (...)
            utils.safe_call_cb(cb, true, player_id, server_info, select_type)
          else
            local code, msg = ...
            utils.safe_call_cb(cb, false, code, msg)
          end
        end)
      else
        E.LOG.warn(TAG, "get_default_login_server get_last_login_player player not exists")
        static_temp_select_cache:on_player_id_invalid(select_player_id)
        do_request_a_recommend_server()
      end
    else
      local code, msg = ...
      if code == CONSTANTS.GANGPLANK_ERROR_CODE.ACCOUNT_NOT_HAS_PLAYERS then
        E.LOG.error(TAG, "get_default_login_server_with_player_id server return no players in current account")
        static_temp_select_cache:on_player_id_invalid(select_player_id)
        do_request_a_recommend_server()
      else
        E.LOG.error(TAG, "get_default_login_server_with_player_id failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        utils.safe_call_cb(cb, false, code, msg)
      end
    end
  end)
end

local function get_default_login_server_with_server_id(selected_server_id, params, cb)
  params = params or {}
  request_server_info(selected_server_id, params, function(succ2, ...)
    if succ2 then
      local server_info = (...)
      E.LOG.debug(TAG, "get_default_login_server has select server_id:" .. tostring(selected_server_id) .. ", get_server_info succ:")
      E.log(server_info)
      utils.safe_call_cb(cb, true, nil, server_info, SELECT_TYPE.MANUAL)
    else
      local code, msg = ...
      if code == CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_SERVER_LIST_IS_EMPTY then
        E.LOG.error(TAG, "get_default_login_server has select server_id:" .. tostring(selected_server_id) .. ", server_id not exists")
        static_temp_select_cache:on_server_id_invalid(selected_server_id)
        get_last_login_or_recommend_server(params, cb)
      else
        E.LOG.error(TAG, "get_default_login_server has select server_id:" .. tostring(selected_server_id) .. ", get_server_info failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        utils.safe_call_cb(cb, false, code, msg)
      end
    end
  end)
end

function M.get_default_login_server(params, on_result, on_update)
  params = params or {}
  local cache_server_info = static_temp_select_cache:update_server_info_cache_params(params, on_update)
  if cache_server_info then
    E.LOG.debug(TAG, "get_default_login_server has cache, just return")
    local _select_server_id, select_player_id = static_temp_select_cache:get_select_server()
    utils.safe_call_cb(on_result, true, select_player_id, cache_server_info)
    return
  end
  local select_operation_time = E.system_clock()
  
  local function inner_cb_wrapper(succ, ...)
    if succ then
      local player_id, server_info, select_type = ...
      local select_succ, code, msg
      if player_id then
        E.LOG.debug(TAG, "get_default_login_server select_player_id:" .. tostring(player_id) .. ", server_id:" .. tostring(server_info.server_id) .. ", select_type:" .. tostring(select_type))
        select_succ, code, msg = static_temp_select_cache:update_select_player(player_id, server_info.server_id, select_type, select_operation_time)
      else
        E.LOG.debug(TAG, "get_default_login_server no select_player_id")
        select_succ, code, msg = static_temp_select_cache:update_select_server(server_info.server_id, select_type, select_operation_time)
      end
      if select_succ then
        E.LOG.debug(TAG, "get_default_login_server select_operation apply succ")
        static_temp_select_cache:update_server_info(server_info)
        utils.safe_call_cb(on_result, true, player_id, server_info)
      else
        E.LOG.debug(TAG, "get_default_login_server select_operation apply failed")
        utils.safe_call_cb(on_result, false, code, msg)
      end
    else
      local code, msg = ...
      E.LOG.error(TAG, "get_default_login_server failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      utils.safe_call_cb(on_result, false, code, msg)
    end
    static_temp_select_cache:start_loop_query()
  end
  
  static_temp_select_cache:stop_loop_query()
  local select_server_id, select_player_id, select_type = static_temp_select_cache:get_select_server()
  E.LOG.debug(TAG, "get_default_login_server select_server_id:" .. tostring(select_server_id) .. ", select_player_id:" .. tostring(select_player_id) .. ", select_type:" .. tostring(select_type))
  if select_player_id then
    get_default_login_server_with_player_id(select_player_id, params, inner_cb_wrapper)
  elseif select_server_id then
    get_default_login_server_with_server_id(select_server_id, params, inner_cb_wrapper)
  else
    get_last_login_or_recommend_server(params, inner_cb_wrapper)
  end
end

function M.get_select_server()
  do return static_temp_select_cache.get_select_server end
  return static_temp_select_cache.get_select_server, static_temp_select_cache
end

function M.Test_get_cache()
  return static_temp_select_cache
end

function M.Test_reset_cache()
  static_temp_select_cache:clear()
end

return M
