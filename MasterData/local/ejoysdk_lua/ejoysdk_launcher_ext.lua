local E = require("ejoysdk_lua.ejoysdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local launcher = require("ejoysdk_lua.ejoysdk_launcher")
local EM = require("ejoysdk_lua.ejoysdk_module")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local Chain = require("ejoysdk_lua.ejoysdk_chain")
local M = {}
M.SOURCE_TYPE = {
  LAST_LOGIN = "last_login",
  RECOMMEND = "recommend",
  RANDOM = "random"
}
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "launcher_ext"
local DEFAULT_REFRESH_INTERVAL = 15
local _get_server_node_info_list_timer_id

local function fill_alive_value(server_list, alive_server_info)
  local alive_server_map = {}
  for _, v in pairs(alive_server_info or {}) do
    alive_server_map[v.name] = v
  end
  for _, v in pairs(server_list) do
    if not v.alive_data_info then
      if alive_server_map[tostring(v.name)] then
        v.alive_data_info = alive_server_map[tostring(v.name)]
      else
        v.alive_data_info = {}
      end
    end
  end
end

local function fill_alive_value_v2(server_list, alive_server_info, force_update)
  local alive_server_map = {}
  for _, v in pairs(alive_server_info or {}) do
    local p_key = tostring(v.realm or v.name)
    alive_server_map[p_key] = v
  end
  for _, v in pairs(server_list) do
    if not v.alive_data_info or force_update then
      local p_key = tostring(v.server_id or v.name)
      if alive_server_map[p_key] then
        v.alive_data_info = alive_server_map[p_key]
      else
        v.alive_data_info = {}
      end
    end
  end
end

local function fill_recommend_value(server_list, recommend_list, force_update)
  local recommend_server_map = {}
  for _, v in pairs(recommend_list) do
    recommend_server_map[tostring(v)] = true
  end
  for _, v in pairs(server_list) do
    if not v.recommend_data_info or force_update then
      if recommend_server_map[tostring(v.server_id)] then
        v.recommend_data_info = true
      else
        v.recommend_data_info = false
      end
    end
  end
end

local function pick_server_id_list(server_list)
  local server_id_map = {}
  if server_list then
    for _, v in pairs(server_list) do
      server_id_map[v.server_id] = true
    end
  end
  local server_id_list = {}
  for k, _ in pairs(server_id_map) do
    table.insert(server_id_list, k)
  end
  return server_id_list
end

local function fetch_server_info(_params, _server_ids, _cb)
  local server_list_params = {}
  server_list_params.tags = _params.tags
  server_list_params.server_groups = _params.server_groups
  server_list_params.fields = _params.fields
  server_list_params.ext = _params.ext
  server_list_params.server_ids = _params.server_ids
  server_list_params.realm_types = _params.realm_types
  server_list_params.server_node = _params.server_node
  if _server_ids and next(_server_ids) ~= nil then
    server_list_params.server_ids = _server_ids
  end
  launcher.server_list_ticket_detail_with_params_v2(function(succ1, ...)
    if succ1 then
      local resp = (...)
      resp = resp or {}
      local server_list = resp.anns or {}
      if not next(server_list) then
        utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_SERVER_LIST_IS_EMPTY, "server list is empty on fetch server info")
        E.LOG.error(TAG, "server list is empty on fetch server info")
        return
      end
      local alive_params = {}
      if _server_ids and next(_server_ids) ~= nil then
        alive_params.server_ids = _server_ids
      end
      alive_params.tags = server_list_params.tags
      alive_params.realm_types = server_list_params.realm_types
      EG.alive_servers_with_params(function(succ2, ...)
        if succ2 then
          local alive_servers = (...)
          fill_alive_value(server_list, alive_servers)
          utils.safe_call_cb(_cb, true, server_list)
        else
          local code, msg = ...
          local detail = "code=" .. tostring(code) .. ", msg=" .. tostring(msg)
          utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_SERVER_ALIVE_ERROR, "alive api error, " .. detail)
          E.LOG.error(TAG, "alive api error on fetch server info, " .. detail)
        end
      end, alive_params)
    else
      local code, msg = ...
      local detail = "code=" .. tostring(code) .. ", msg=" .. tostring(msg)
      utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_SERVER_LIST_V2_ERROR, "server list v2 error, " .. detail)
      E.LOG.error(TAG, "server list v2 error on fetch server info, " .. detail)
    end
  end, server_list_params)
end

function M.sort_player_list(players_list)
  table.sort(players_list, function(a, b)
    local value
    if a.official_info and a.official_info.last_login_time and b.official_info and b.official_info.last_login_time then
      if a.official_info.last_login_time > b.official_info.last_login_time then
        value = -1
      elseif a.official_info.last_login_time == b.official_info.last_login_time then
        value = 0
      else
        value = 1
      end
    elseif a.official_info and a.official_info.last_login_time then
      value = -1
    elseif b.official_info and b.official_info.last_login_time then
      value = 1
    else
      value = 0
    end
    if value < 0 then
      return true
    else
      return false
    end
  end)
end

local function get_and_sort_last_login_player(cb)
  if not EG.user_info() or not EG.user_info().uid then
    utils.safe_call_cb(cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_LAST_ENTER_SERVER_UID_MISS, "uid miss for get last enter server")
    E.LOG.error(TAG, "uid miss for get last enter server")
    return
  end
  if EG.user_info().token then
    EG.get_players(nil, function(succ, ...)
      if succ then
        local players_list = (...)
        players_list = players_list or {}
        M.sort_player_list(players_list)
        local last_login_player = players_list[1]
        if last_login_player and last_login_player.server_id and last_login_player.official_info and last_login_player.official_info.last_login_time then
          utils.safe_call_cb(cb, true, last_login_player.server_id)
        else
          utils.safe_call_cb(cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_LAST_ENTER_SERVER_LAST_LOGIN_PLAYER_INFO_EMPTY, "last login player empty for get last enter server")
          E.LOG.error(TAG, "last login player empty for get last enter server >>")
          E.LOG.error(TAG, last_login_player)
        end
      else
        local code, msg = ...
        local detail = "code=" .. tostring(code) .. ", msg=" .. tostring(msg)
        utils.safe_call_cb(cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_LAST_ENTER_SERVER_ACCOUNT_INFO_FAIL, "players info fetch fail for get last enter server, " .. detail)
        E.LOG.error(TAG, "players info fetch fail for get last enter server, " .. detail)
      end
    end)
  else
    utils.safe_call_cb(cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CODE_EJOY_TOKEN_INVALID, "ejoy token miss for get last enter server")
    E.LOG.error(TAG, "ejoy token miss for get last enter server")
  end
end

local last_server_id, last_server_source_type
local last_server_recommend_data_info = false
local last_server_marks = {}
local recommend_servers_cache, server_marks_cache

local function get_recommend_servers(cb, re_params)
  if recommend_servers_cache then
    utils.safe_call_cb(cb, true, utils.deepcopy(recommend_servers_cache))
    return
  end
  EG.get_recommend_servers(re_params or {}, function(succ, ...)
    if succ then
      local recommend_servers = (...)
      if recommend_servers and next(recommend_servers) ~= nil then
        recommend_servers_cache = recommend_servers
        utils.safe_call_cb(cb, true, utils.deepcopy(recommend_servers_cache))
      else
        utils.safe_call_cb(cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_GET_RECOMMEND_EMPTY, "get recommend servers empty")
        E.LOG.warn(TAG, "get recommend servers empty")
      end
    else
      local code, msg = ...
      local detail = "code=" .. tostring(code) .. ", msg=" .. tostring(msg)
      utils.safe_call_cb(cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_GET_RECOMMEND_FAIL, "get recommend servers fail, " .. detail)
      E.LOG.warn(TAG, "get recommend servers fail, " .. detail)
    end
  end)
end

local function get_server_marks(_params, cb)
  if server_marks_cache then
    utils.safe_call_cb(cb, true, utils.deepcopy(server_marks_cache))
    cb = nil
  end
  local server_marks_params = {}
  if _params and _params.server_node then
    server_marks_params.server_node = _params.server_node
  end
  EG.get_server_marks(server_marks_params, function(succ, ...)
    if succ then
      local server_marks = (...)
      if server_marks and next(server_marks) ~= nil then
        server_marks_cache = server_marks
        utils.safe_call_cb(cb, true, utils.deepcopy(server_marks_cache))
      else
        utils.safe_call_cb(cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_GET_SERVER_MARK_EMPTY, "get server marks empty")
        E.LOG.error(TAG, "get server_marks empty")
      end
    else
      local code, msg = ...
      local detail = "code=" .. tostring(code) .. ", msg=" .. tostring(msg)
      utils.safe_call_cb(cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_GET_SERVER_MARK_FAIL, "get server marks fail, " .. detail)
      E.LOG.error(TAG, "get server_marks fail, " .. detail)
    end
  end)
end

local function classify_server_info_list_by_alive(server_info_list)
  local alive_list = {}
  local un_alive_list = {}
  for _, v in pairs(server_info_list) do
    if v.alive_data_info.alive == true then
      table.insert(alive_list, v)
    else
      table.insert(un_alive_list, v)
    end
  end
  return {alive_list = alive_list, un_alive_list = un_alive_list}
end

function M._sort_server_info_list(server_info_list)
  if not server_info_list or next(server_info_list) == nil then
    return
  end
  table.sort(server_info_list, function(a, b)
    local value
    if a.alive_data_info.crow_propertion and b.alive_data_info.crow_propertion then
      if a.alive_data_info.crow_propertion == b.alive_data_info.crow_propertion then
        value = 0
      elseif a.alive_data_info.crow_propertion < b.alive_data_info.crow_propertion then
        value = -1
      else
        value = 1
      end
    elseif a.alive_data_info.crow_propertion then
      value = -1
    elseif b.alive_data_info.crow_propertion then
      value = 1
    else
      value = 0
    end
    if value < 0 then
      return true
    else
      return false
    end
  end)
  local front = {}
  local mid = math.ceil(#server_info_list / 2)
  for k, v in pairs(server_info_list) do
    if k <= mid then
      table.insert(front, v)
    end
  end
  table.sort(front, function(a, b)
    local value
    if a.alive_data_info.load_propertion and b.alive_data_info.load_propertion then
      if a.alive_data_info.load_propertion == b.alive_data_info.load_propertion then
        value = 0
      elseif a.alive_data_info.load_propertion < b.alive_data_info.load_propertion then
        value = -1
      else
        value = 1
      end
    elseif a.alive_data_info.load_propertion then
      value = -1
    elseif b.alive_data_info.load_propertion then
      value = 1
    else
      value = 0
    end
    if value < 0 then
      return true
    else
      return false
    end
  end)
  for k, v in pairs(front) do
    server_info_list[k] = v
  end
end

local function get_my_server_info_for_last_login(params, _cb)
  if last_server_source_type == M.SOURCE_TYPE.LAST_LOGIN and last_server_id then
    fetch_server_info(params, {last_server_id}, function(succ, ...)
      if not succ then
        utils.safe_call_cb(_cb, false, ...)
        return
      end
      local server_info_list = (...)
      local ret = utils.safe_get_array_item(server_info_list, 1)
      if not ret then
        utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_TARGET_SERVER_NOT_FOUND, "target server not found")
        return
      end
      ret.source_type = last_server_source_type
      ret.recommend_data_info = last_server_recommend_data_info
      ret.marks = last_server_marks or {}
      utils.safe_call_cb(_cb, true, ret)
    end)
    return
  end
  
  local function real_get_last_login_server(final_last_login_server_id)
    fetch_server_info(params, {final_last_login_server_id}, function(succ2, ...)
      if not succ2 then
        utils.safe_call_cb(_cb, false, ...)
        return
      end
      local server_info_list = (...)
      local ret = utils.safe_get_array_item(server_info_list, 1)
      if not ret then
        utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_TARGET_SERVER_NOT_FOUND, "target server not found")
        return
      end
      
      local function callback(result)
        result.source_type = M.SOURCE_TYPE.LAST_LOGIN
        result.recommend_data_info = result.recommend_data_info or false
        last_server_marks = result.marks or {}
        last_server_id = result.server_id
        last_server_source_type = result.source_type
        last_server_recommend_data_info = result.recommend_data_info
        utils.safe_call_cb(_cb, true, result)
      end
      
      get_server_marks(params or {}, function(succ4, ...)
        ret.marks = {}
        if succ4 then
          local marks = (...)
          ret.marks = marks[ret.server_id] or {}
          local recommend_server_ids = {}
          for server_id, mark in pairs(marks) do
            for _, m in ipairs(mark or {}) do
              if "recommend" == m then
                table.insert(recommend_server_ids, server_id)
                break
              end
            end
          end
          fill_recommend_value({ret}, recommend_server_ids)
          callback(ret)
        else
          get_recommend_servers(function(succ3, ...)
            if succ3 then
              local recommend_server_ids = (...)
              fill_recommend_value({ret}, recommend_server_ids)
            end
            callback(ret)
          end)
        end
      end)
    end)
  end
  
  get_and_sort_last_login_player(function(succ, ...)
    if not succ then
      utils.safe_call_cb(_cb, false, ...)
      return
    end
    local last_login_player_server_id = (...)
    real_get_last_login_server(last_login_player_server_id)
  end)
end

local function get_my_server_info_for_recommend(params, _cb)
  if last_server_source_type == M.SOURCE_TYPE.RECOMMEND and last_server_id then
    fetch_server_info(params, {last_server_id}, function(succ, ...)
      if not succ then
        utils.safe_call_cb(_cb, false, ...)
        return
      end
      local server_info_list = (...)
      local ret = utils.safe_get_array_item(server_info_list, 1)
      if not ret then
        utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_TARGET_SERVER_NOT_FOUND, "target server not found")
        return
      end
      ret.source_type = last_server_source_type
      ret.recommend_data_info = last_server_recommend_data_info
      ret.marks = last_server_marks or {}
      utils.safe_call_cb(_cb, true, ret)
    end)
    return
  end
  
  local function fetch_server_info_inner(recommend_server_ids, marks)
    fetch_server_info(params, recommend_server_ids, function(succ3, ...)
      if not succ3 then
        utils.safe_call_cb(_cb, false, ...)
        return
      end
      local server_info_list = (...)
      local classify_info = classify_server_info_list_by_alive(server_info_list)
      local alive_list = classify_info.alive_list
      local un_alive_list = classify_info.un_alive_list
      local ret
      if alive_list and next(alive_list) ~= nil then
        M._sort_server_info_list(alive_list)
        local index = math.random(1, math.ceil(#alive_list / 4))
        ret = utils.safe_get_array_item(alive_list, index)
      elseif un_alive_list and next(un_alive_list) ~= nil then
        M._sort_server_info_list(un_alive_list)
        local index = math.random(1, math.ceil(#un_alive_list / 4))
        ret = utils.safe_get_array_item(un_alive_list, index)
      end
      if not ret then
        utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_TARGET_SERVER_NOT_FOUND, "target server not found")
        return
      end
      marks = marks or {}
      ret.source_type = M.SOURCE_TYPE.RECOMMEND
      ret.recommend_data_info = true
      ret.marks = marks[ret.server_id] or {}
      last_server_marks = ret.marks
      last_server_id = ret.server_id
      last_server_source_type = ret.source_type
      last_server_recommend_data_info = ret.recommend_data_info
      utils.safe_call_cb(_cb, true, ret)
    end)
  end
  
  get_server_marks(params or {}, function(succ4, ...)
    if succ4 then
      local marks = (...)
      local recommend_server_ids = {}
      for server_id, mark in pairs(marks) do
        for _, m in ipairs(mark or {}) do
          if "recommend" == m then
            table.insert(recommend_server_ids, server_id)
            break
          end
        end
      end
      fetch_server_info_inner(recommend_server_ids, marks)
    else
      get_recommend_servers(function(succ2, ...)
        if not succ2 then
          utils.safe_call_cb(_cb, false, ...)
          return
        end
        local recommend_server_ids = (...)
        fetch_server_info_inner(recommend_server_ids, nil)
      end)
    end
  end)
end

local function get_my_server_info_for_random(params, _cb)
  if last_server_source_type == M.SOURCE_TYPE.RANDOM and last_server_id then
    fetch_server_info(params, {last_server_id}, function(succ, ...)
      if not succ then
        utils.safe_call_cb(_cb, false, ...)
        return
      end
      local server_info_list = (...)
      local ret = utils.safe_get_array_item(server_info_list, 1)
      if not ret then
        utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_TARGET_SERVER_NOT_FOUND, "target server not found")
        return
      end
      ret.source_type = last_server_source_type
      ret.recommend_data_info = last_server_recommend_data_info
      ret.marks = last_server_marks or {}
      utils.safe_call_cb(_cb, true, ret)
    end)
    return
  end
  fetch_server_info(params, nil, function(succ, ...)
    if not succ then
      utils.safe_call_cb(_cb, false, ...)
      return
    end
    local server_info_list = (...)
    local classify_info = classify_server_info_list_by_alive(server_info_list)
    local alive_list = classify_info.alive_list
    local un_alive_list = classify_info.un_alive_list
    local ret
    if alive_list and next(alive_list) ~= nil then
      M._sort_server_info_list(alive_list)
      local index = math.random(1, math.ceil(#alive_list / 4))
      ret = utils.safe_get_array_item(alive_list, index)
    elseif un_alive_list and next(un_alive_list) ~= nil then
      M._sort_server_info_list(un_alive_list)
      local index = math.random(1, math.ceil(#un_alive_list / 4))
      ret = utils.safe_get_array_item(un_alive_list, index)
    end
    if not ret then
      utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_TARGET_SERVER_NOT_FOUND, "target server not found")
      return
    end
    
    local function callback(result)
      result.source_type = M.SOURCE_TYPE.LAST_LOGIN
      result.recommend_data_info = result.recommend_data_info or false
      last_server_marks = result.marks or {}
      last_server_id = result.server_id
      last_server_source_type = result.source_type
      last_server_recommend_data_info = result.recommend_data_info
      utils.safe_call_cb(_cb, true, result)
    end
    
    get_server_marks(params or {}, function(succ4, ...)
      ret.marks = {}
      if succ4 then
        local marks = (...)
        ret.marks = marks[ret.server_id] or {}
        local recommend_server_ids = {}
        for server_id, mark in pairs(marks) do
          for _, m in ipairs(mark or {}) do
            if "recommend" == m then
              table.insert(recommend_server_ids, server_id)
              break
            end
          end
        end
        fill_recommend_value({ret}, recommend_server_ids)
        callback(ret)
      else
        get_recommend_servers(function(succ3, ...)
          if succ3 then
            local recommend_server_ids = (...)
            fill_recommend_value({ret}, recommend_server_ids)
          end
          callback(ret)
        end)
      end
    end)
  end)
end

local function get_my_server_info_for_pipeline(params, _cb)
  get_my_server_info_for_last_login(params, function(succ, ...)
    if succ then
      utils.safe_call_cb(_cb, true, ...)
      return
    end
    get_my_server_info_for_recommend(params, function(succ2, ...)
      if succ2 then
        utils.safe_call_cb(_cb, true, ...)
        return
      end
      get_my_server_info_for_random(params, _cb)
    end)
  end)
end

function M.get_my_server_info(params, _cb)
  params = params or {}
  local type = params.source_type or "pipeline"
  params.source_type = nil
  
  local function _cb_wrapper(succ, ...)
    utils.safe_call_cb(_cb, succ, ...)
    if succ then
      E.LOG.debug(TAG, "get_my_server_info succ")
      QL.commit_action_succ_main("ejoy_my_server_info_end")
    else
      local _code, _msg = ...
      E.LOG.debug(TAG, "get_my_server_info failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
      QL.commit_action_fail_main("ejoy_my_server_info_end", nil, _code, _msg)
    end
  end
  
  if type == M.SOURCE_TYPE.LAST_LOGIN then
    get_my_server_info_for_last_login(params, _cb_wrapper)
  elseif type == M.SOURCE_TYPE.RECOMMEND then
    get_my_server_info_for_recommend(params, _cb_wrapper)
  elseif type == M.SOURCE_TYPE.RANDOM then
    get_my_server_info_for_random(params, _cb_wrapper)
  elseif "pipeline" == type then
    get_my_server_info_for_pipeline(params, _cb_wrapper)
  else
    local err_msg = "source_type of params is invalid"
    QL.commit_action_fail_main("ejoy_my_server_info_end", nil, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_SERVER_INFO_SOURCE_TYPE_INVALID, err_msg)
    assert(false, err_msg)
  end
end

function M.get_server_info_list(params, _cb)
  local function _cb_wrapper(_succ, ...)
    utils.safe_call_cb(_cb, _succ, ...)
    
    if _succ then
      E.LOG.debug(TAG, "get_server_info_list succ")
      QL.commit_action_succ_main("ejoy_server_info_list_end")
    else
      local _code, _msg = ...
      E.LOG.debug(TAG, "get_server_info_list failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
      QL.commit_action_fail_main("ejoy_server_info_list_end", nil, _code, _msg)
    end
  end
  
  launcher.server_list_ticket_detail_with_params_v2(function(succ1, ...)
    if succ1 then
      local resp, groups, recommend_server_list = ...
      local server_list = resp.anns
      local server_id_list = pick_server_id_list(server_list)
      local alive_finish = false
      local recommend_finish = false
      local get_players_finish = false
      local players_list
      
      local function total_cb()
        if not (alive_finish and recommend_finish) or not get_players_finish then
          return
        end
        local ret = {
          players_list = players_list,
          server_list = server_list,
          group_list = groups
        }
        utils.safe_call_cb(_cb_wrapper, true, ret)
      end
      
      if server_list and 0 == utils.tablelength(server_list) then
        alive_finish = true
        recommend_finish = true
      else
        local alive_params = {}
        if params then
          if params.server_groups or params.server_ids or params.link == true then
            alive_params = {server_ids = server_id_list}
          else
            alive_params.realm_types = params.realm_types
            if params.tags then
              alive_params.tags = params.tags
              alive_params.return_server_with_no_tags = true
            end
            if params.server_node then
              alive_params.server_node = params.server_node
            end
          end
        end
        EG.alive_servers_with_params(function(succ2, ...)
          alive_finish = true
          if succ2 then
            local alive_server_info = (...)
            fill_alive_value(server_list, alive_server_info)
            total_cb()
          else
            local code, msg = ...
            utils.safe_call_cb(_cb_wrapper, false, code, msg)
          end
        end, alive_params)
        
        local function recommend_cb(succ3, ...)
          recommend_finish = true
          if succ3 then
            local recommend_servers = (...)
            fill_recommend_value(server_list, recommend_servers)
          end
          total_cb()
        end
        
        if recommend_server_list and next(recommend_server_list) then
          local recommend_list = {}
          for _, sf in pairs(recommend_server_list) do
            table.insert(recommend_list, sf.server_id or "")
          end
          recommend_cb(true, recommend_list)
        else
          get_recommend_servers(recommend_cb)
        end
      end
      local include_players = (params or {}).include_players
      if type(include_players) ~= "boolean" then
        include_players = true
      end
      E.LOG.debug(TAG, "include_players:" .. tostring(include_players) .. ", token:" .. tostring(EG.user_info().token))
      if EG.user_info().token and include_players then
        EG.get_players(nil, function(succ4, ...)
          get_players_finish = true
          if succ4 then
            players_list = (...)
            total_cb()
          else
            local code, msg = ...
            E.LOG.warn(TAG, "player_id_list fail, code=" .. tostring(code) .. ", msg=" .. tostring(msg))
            total_cb()
          end
        end)
      else
        get_players_finish = true
        total_cb()
      end
    else
      local code, msg = ...
      utils.safe_call_cb(_cb_wrapper, false, code, msg)
    end
  end, params)
end

function M.reset_last_server_data()
  last_server_id = nil
  last_server_source_type = nil
  last_server_recommend_data_info = false
end

function M.get_last_login_player(params, _cb)
  if not (EG.user_info() and EG.user_info().uid) or not EG.user_info().token then
    utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_NEED_ACCOUNT_LOGIN, "need account login or ejoy token miss for get last enter server")
    E.LOG.error(TAG, "need account login or ejoy token miss for get last enter server")
    return
  end
  local GDP = require("ejoysdk_lua.gangplank_data_provider")
  local last_sp_player_info = GDP.PLAYER_INFO.get_simple()
  local player_id = last_sp_player_info and last_sp_player_info.player_id
  params = params or {}
  if params.player_id then
    player_id = tostring(params.player_id)
  end
  local user_info_api = require("ejoysdk_lua.server_api.ejoysdk_user_info")
  local _last_login_params = {player_id = player_id}
  params.born_publish_area = params.born_publish_area or params.born_publish_area_list
  for ak, av in pairs(params) do
    if not _last_login_params[ak] then
      _last_login_params[ak] = av
    end
  end
  params.auto_player_change_server = nil
  params.with_punishment = nil
  params.player_id = nil
  params.born_publish_area = nil
  params.born_publish_area_list = nil
  local server_node = params.server_node
  params.server_node = nil
  user_info_api.get_last_login_player(_last_login_params, function(succ, ...)
    if succ then
      local ret = (...) or {}
      M.fill_server_infos(M.SOURCE_TYPE.LAST_LOGIN, params, ret, _cb)
    else
      local code, msg, err_body = ...
      if 21012 == code then
        E.log("no last login_player and get recommend server")
        local ret = err_body or {}
        M.fill_server_infos(M.SOURCE_TYPE.RECOMMEND, {server_node = server_node}, ret, _cb)
        return
      end
      utils.safe_call_cb(_cb, false, code, msg)
    end
  end)
end

function M.fill_server_infos(fill_type, params, last_login_ret, _cb)
  local function fetch_server_info_inner(tmp_fill_server_ids)
    fetch_server_info(params, tmp_fill_server_ids, function(succ2, ...)
      if not succ2 then
        utils.safe_call_cb(_cb, false, ...)
        
        return
      end
      local server_info_list = (...) or {}
      if not server_info_list or 0 == (server_info_list and #server_info_list) then
        utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_SERVER_LIST_IS_EMPTY, "server list is empty on fetch server info")
        return
      end
      local server_list_map = {}
      for _, sv in pairs(server_info_list) do
        server_list_map[sv.server_id] = sv
      end
      last_login_ret.server_list = server_info_list
      last_login_ret.server_list_map = server_list_map
      utils.safe_call_cb(_cb, true, last_login_ret)
    end)
  end
  
  if fill_type == M.SOURCE_TYPE.LAST_LOGIN then
    local fill_server_ids = {}
    local m_fill_server_ids = {}
    if last_login_ret.server_info then
      if last_login_ret.server_info.server_id then
        table.insert(fill_server_ids, last_login_ret.server_info.server_id)
        m_fill_server_ids[last_login_ret.server_info.server_id] = true
      end
      if last_login_ret.server_info.born_server_id and not m_fill_server_ids[last_login_ret.server_info.born_server_id] then
        table.insert(fill_server_ids, last_login_ret.server_info.born_server_id)
        m_fill_server_ids[last_login_ret.server_info.born_server_id] = true
      end
      if last_login_ret.server_info.group_server_id and not m_fill_server_ids[last_login_ret.server_info.group_server_id] then
        table.insert(fill_server_ids, last_login_ret.server_info.group_server_id)
        m_fill_server_ids[last_login_ret.server_info.group_server_id] = true
      end
      if last_login_ret.server_info.born_serverid and not m_fill_server_ids[last_login_ret.server_info.born_serverid] then
        table.insert(fill_server_ids, last_login_ret.server_info.born_serverid)
        m_fill_server_ids[last_login_ret.server_info.born_serverid] = true
      end
    end
    fetch_server_info_inner(fill_server_ids)
  elseif fill_type == M.SOURCE_TYPE.RECOMMEND then
    if recommend_servers_cache then
      recommend_servers_cache = nil
    end
    get_recommend_servers(function(succ2, ...)
      if not succ2 then
        utils.safe_call_cb(_cb, false, ...)
        return
      end
      local recommend_server_ids = (...)
      fetch_server_info_inner(recommend_server_ids)
    end, params)
  end
end

function M.get_login_server(params, _cb)
  if not (EG.user_info() and EG.user_info().uid) or not EG.user_info().token then
    utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_NEED_ACCOUNT_LOGIN, "need account login or ejoy token miss for get last enter server")
    E.LOG.error(TAG, "need account login or ejoy token miss for get last enter server")
    return
  end
  local GDP = require("ejoysdk_lua.gangplank_data_provider")
  local last_sp_player_info = GDP.PLAYER_INFO.get_simple()
  local player_id = last_sp_player_info and last_sp_player_info.player_id
  params = params or {}
  if params.player_id then
    params.player_id = tostring(params.player_id)
  else
    params.player_id = player_id
  end
  params.born_publish_area = params.born_publish_area or params.born_publish_area_list
  params.born_publish_area_list = nil
  local user_info_api = require("ejoysdk_lua.server_api.ejoysdk_user_info")
  user_info_api.get_last_login_player(params, function(succ, ...)
    if succ then
      local ret = (...) or {}
      M.fill_server_infos_v2(M.SOURCE_TYPE.LAST_LOGIN, {}, ret, _cb)
    else
      local code, msg, err_body = ...
      if 21012 == code then
        E.log("no last login_player and get recommend server")
        local ret = err_body or {}
        M.fill_server_infos_v2(M.SOURCE_TYPE.RECOMMEND, {
          server_node = params.server_node,
          use_guarantee = true
        }, ret, _cb)
        return
      end
      utils.safe_call_cb(_cb, false, code, msg)
    end
  end)
end

function M.fill_server_infos_v2(fill_type, params, last_login_ret, _cb)
  local function fetch_server_info_inner(tmp_fill_server_ids)
    fetch_server_info(params, tmp_fill_server_ids, function(succ2, ...)
      if not succ2 then
        utils.safe_call_cb(_cb, false, ...)
        
        return
      end
      local server_info_list = (...) or {}
      if not server_info_list or 0 == (server_info_list and #server_info_list) then
        utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_SERVER_LIST_IS_EMPTY, "server list is empty on fetch server info")
        return
      end
      local server_list_map = {}
      for _, sv in pairs(server_info_list) do
        server_list_map[sv.server_id] = sv
      end
      local replace_server_infos = {}
      local replace_player_server_infos = {}
      if last_login_ret.server_info and last_login_ret.server_info.server_id then
        replace_server_infos.server_info = server_list_map[last_login_ret.server_info.server_id]
        replace_player_server_infos.server_info = server_list_map[last_login_ret.server_info.server_id]
      end
      if last_login_ret.server_info and last_login_ret.server_info.group_server_id then
        replace_server_infos.group_server_info = server_list_map[last_login_ret.server_info.group_server_id]
        replace_player_server_infos.group_server_info = server_list_map[last_login_ret.server_info.group_server_id]
      end
      if last_login_ret.player then
        if last_login_ret.server_info and last_login_ret.server_info.born_serverid then
          replace_player_server_infos.born_server_info = server_list_map[last_login_ret.server_info.born_serverid]
        end
        last_login_ret.player.server_infos = replace_player_server_infos
      end
      if not last_login_ret.player and fill_type == M.SOURCE_TYPE.RECOMMEND and server_info_list and #server_info_list > 0 then
        local ran_one = math.random(1, #server_info_list)
        replace_server_infos.server_info = server_info_list[ran_one]
      end
      last_login_ret.server_info = nil
      last_login_ret.server_infos = replace_server_infos
      utils.safe_call_cb(_cb, true, last_login_ret)
    end)
  end
  
  if fill_type == M.SOURCE_TYPE.LAST_LOGIN then
    local fill_server_ids = {}
    local m_fill_server_ids = {}
    if last_login_ret.server_info then
      if last_login_ret.server_info.server_id then
        table.insert(fill_server_ids, last_login_ret.server_info.server_id)
        m_fill_server_ids[last_login_ret.server_info.server_id] = true
      end
      if last_login_ret.server_info.born_serverid and not m_fill_server_ids[last_login_ret.server_info.born_serverid] then
        table.insert(fill_server_ids, last_login_ret.server_info.born_serverid)
        m_fill_server_ids[last_login_ret.server_info.born_serverid] = true
      end
      if last_login_ret.server_info.group_server_id and not m_fill_server_ids[last_login_ret.server_info.group_server_id] then
        table.insert(fill_server_ids, last_login_ret.server_info.group_server_id)
        m_fill_server_ids[last_login_ret.server_info.group_server_id] = true
      end
    end
    fetch_server_info_inner(fill_server_ids)
  elseif fill_type == M.SOURCE_TYPE.RECOMMEND then
    EG.get_recommend_servers(params, function(succ2, ...)
      if succ2 then
        local recommend_servers = (...)
        if recommend_servers and next(recommend_servers) ~= nil then
          fetch_server_info_inner(recommend_servers)
        else
          utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_GET_RECOMMEND_EMPTY, "get recommend servers empty")
          E.LOG.info(TAG, "get recommend servers empty")
        end
      else
        local code, msg = ...
        local detail = "code=" .. tostring(code) .. ", msg=" .. tostring(msg)
        utils.safe_call_cb(_cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_GET_RECOMMEND_FAIL, "get recommend servers fail, " .. detail)
        E.LOG.warn(TAG, "get recommend servers fail, " .. detail)
      end
    end)
  end
end

function M.replace_alive_server(alive_params, server_list, cb)
  EG.alive_servers_with_params(function(succ2, ...)
    if succ2 then
      local alive_server_info = (...)
      fill_alive_value_v2(server_list, alive_server_info, true)
      cb(true, server_list)
    end
  end, alive_params)
end

local function filter_current_node_server_list(origin_server_list, sort_server_list, servers_marks, filter_rules)
  local index_server_list = {}
  for _, server_info in pairs(origin_server_list) do
    index_server_list[server_info.server_id or ""] = server_info
  end
  local current_node_server_list = {}
  local filter_rule_marks
  if filter_rules and #filter_rules > 0 then
    for _, filter_rule in ipairs(filter_rules) do
      if filter_rule and filter_rule.op == "filter_by_servermark" then
        filter_rule_marks = filter_rule.args
        break
      end
    end
  end
  if filter_rule_marks then
    local filter_rule_marks_maps = {}
    for _, mv in ipairs(filter_rule_marks) do
      filter_rule_marks_maps[mv] = true
    end
    for _, server_id in ipairs(sort_server_list or {}) do
      local current_servers_marks = servers_marks and servers_marks[server_id] or {}
      for _, sv in pairs(current_servers_marks) do
        if filter_rule_marks_maps[sv] and index_server_list[server_id] then
          table.insert(current_node_server_list, index_server_list[server_id])
          break
        end
      end
    end
  else
    for _, server_id in ipairs(sort_server_list or {}) do
      if index_server_list[server_id] then
        table.insert(current_node_server_list, index_server_list[server_id])
      end
    end
  end
  return current_node_server_list
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

local function sort_mark(s1, s2, is_asc, index, marks1, marks2, _strategy_chain)
  index = index or 1
  local s1_score = mark_score(marks1)
  local s2_score = mark_score(marks2)
  if s1_score == s2_score and type(_strategy_chain[index + 1]) == "function" then
    do return _strategy_chain[index + 1], s1, s2, is_asc end
    return _strategy_chain[index + 1], s1, s2, is_asc, index + 1
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

function M.server_node_detail_sort(server_node, server_list, node_server_maps, player_server_maps)
  server_list = server_list or {}
  server_node = server_node or {}
  node_server_maps = node_server_maps or {}
  if server_node.node_id == nil or type(server_node) ~= "table" then
    E.LOG.d(TAG, "no any server_node")
    return
  end
  local node_id = server_node.node_id
  E.log("server_node_detail_sort , sort node: " .. tostring(node_id))
  local strategy_chain = {}
  local SERVER_SORT_STRATEGY = {
    server_mark_sorter_asc = function(s1, s2, index)
      local masks1 = node_server_maps[node_id] and node_server_maps[node_id][s1.server_id]
      local masks2 = node_server_maps[node_id] and node_server_maps[node_id][s2.server_id]
      do return sort_mark, s1, s2, true, index, masks1, masks2 end
      return sort_mark, s1, s2, true, index, masks1, masks2, strategy_chain
    end,
    server_mark_sorter_desc = function(s1, s2, index)
      local masks1 = node_server_maps[node_id] and node_server_maps[node_id][s1.server_id]
      local masks2 = node_server_maps[node_id] and node_server_maps[node_id][s2.server_id]
      do return sort_mark, s1, s2, false, index, masks1, masks2 end
      return sort_mark, s1, s2, false, index, masks1, masks2, strategy_chain
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
  local server_info_list = {}
  local target_servers = filter_current_node_server_list(server_list, server_node.server_ids, node_server_maps[node_id], server_node.filter_rules)
  E.log("server_node_detail_sort target_servers len: " .. tostring(target_servers and #target_servers))
  local sort_rules = server_node.sort_rules or {}
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
    local target_server
    if node_server_maps[node_id] and node_server_maps[node_id][server.server_id or ""] and next(node_server_maps[node_id][server.server_id or ""]) then
      local copy_server = utils.deepcopy(server)
      copy_server.marks = node_server_maps[node_id][server.server_id or ""]
      target_server = copy_server
    else
      target_server = server
    end
    for _, csm in ipairs(target_server.marks or {}) do
      if "recommend" == csm then
        target_server.is_recommended = true
        break
      end
    end
    if player_server_maps and server.server_id and player_server_maps[server.server_id] then
      target_server.players = player_server_maps[server.server_id]
    end
    table.insert(server_info_list, index, target_server)
  end
  server_node.server_info_list = server_info_list
  return server_node
end

function M.fill_and_sort_servers(params, detail_info, player_server_maps, cb)
  local server_marks_params = {}
  if params and params.server_node then
    server_marks_params.server_node = params.server_node
  end
  EG.get_server_marks_with_node(server_marks_params, function(succ, ...)
    if succ then
      local server_marks = (...) or {}
      E.log(server_marks)
      local node_server_maps = {}
      for _, smv in ipairs(server_marks) do
        if smv.node_id and not node_server_maps[smv.node_id] then
          node_server_maps[smv.node_id] = {}
        end
        for mk, mv in pairs(smv.mark_data or {}) do
          node_server_maps[smv.node_id][mk] = mv
        end
      end
      if detail_info.server_node then
        local server_node = detail_info.server_node
        local server_list = detail_info.servers
        local fill_node_func
        
        function fill_node_func(_server_node)
          if _server_node then
            M.server_node_detail_sort(_server_node, server_list, node_server_maps, player_server_maps)
            if _server_node.sub_nodes then
              for _, sub_node in ipairs(_server_node.sub_nodes) do
                fill_node_func(sub_node)
              end
            end
          end
        end
        
        fill_node_func(server_node)
      end
    end
    cb(succ, detail_info)
  end)
end

function M.fill_player_server_infos(players_list, player_server_maps, server_list_map)
  local fill_player_other_server_ids = {}
  if players_list then
    for _, pv in pairs(players_list) do
      local server_infos = {}
      if pv.server_id then
        if server_list_map[pv.server_id] then
          server_infos.server_info = utils.deepcopy(server_list_map[pv.server_id])
          if not player_server_maps[pv.server_id] then
            player_server_maps[pv.server_id] = {}
          end
          table.insert(player_server_maps[pv.server_id], pv)
        else
          table.insert(fill_player_other_server_ids, pv.server_id)
        end
      end
      if pv.group_id then
        if server_list_map[pv.group_id] then
          server_infos.group_server_info = utils.deepcopy(server_list_map[pv.group_id])
        else
          table.insert(fill_player_other_server_ids, pv.group_id)
        end
      end
      if pv.player_info and pv.player_info.born_serverid then
        if server_list_map[pv.player_info.born_serverid] then
          server_infos.born_server_info = utils.deepcopy(server_list_map[pv.player_info.born_serverid])
        else
          table.insert(fill_player_other_server_ids, pv.player_info.born_serverid)
        end
      end
      pv.server_infos = server_infos
    end
  end
  return fill_player_other_server_ids
end

function M.get_server_node_info_list(params, cb, _refresh_cb)
  if _get_server_node_info_list_timer_id then
    _get_server_node_info_list_timer_id = nil
  end
  
  local function _cb_wrapper(_succ, ...)
    utils.safe_call_cb(cb, _succ, ...)
    if _succ then
      E.LOG.debug(TAG, "get_server_node_info_list succ")
      QL.commit_action_succ_main("get_server_node_info_list_end")
    else
      local _code, _msg = ...
      E.LOG.debug(TAG, "get_server_node_info_list failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
      QL.commit_action_fail_main("get_server_node_info_list_end", nil, _code, _msg)
    end
  end
  
  params = params or {}
  params.ext = params.ext or {}
  params.ext.with_node = true
  if not params.realm_types then
    local sdk_realm_types = {"NORMAL"}
    local permit_info = EG.user_info() and EG.user_info().permit_info or {}
    if true == permit_info.is_white then
      table.insert(sdk_realm_types, "TESTING")
    end
    params.realm_types = sdk_realm_types
  end
  launcher.server_list_ticket_detail_with_node(function(succ1, ...)
    if not succ1 then
      local code, msg = ...
      utils.safe_call_cb(_cb_wrapper, false, code, msg)
      return
    end
    local resp = (...)
    local server_list = resp.servers or {}
    local server_id_list = pick_server_id_list(server_list)
    local alive_finish = false
    local get_players_finish = false
    local players_list, alive_params
    
    local function node_total_cb()
      if not alive_finish or not get_players_finish then
        return
      end
      local server_list_map = {}
      for _, sv in pairs(server_list) do
        server_list_map[sv.server_id] = sv
      end
      local player_server_maps = {}
      Chain.new():add(function(next_cb)
        local fill_player_other_server_ids = M.fill_player_server_infos(players_list, player_server_maps, server_list_map)
        if fill_player_other_server_ids and #fill_player_other_server_ids > 0 then
          local sp_params = {}
          sp_params.server_ids = fill_player_other_server_ids
          sp_params.fields = params.fields
          sp_params.realm_types = params.realm_types
          EG.get_realms_with_alive_info(sp_params, function(_succ, ...)
            if _succ then
              local other_server_list = (...)
              for _, sv in pairs(other_server_list or {}) do
                if sv.server_id then
                  server_list_map[sv.server_id] = sv
                end
              end
              M.fill_player_server_infos(players_list, player_server_maps, server_list_map)
            else
              local code, msg = ...
              E.log("get_realms_with_alive_info fail, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
            end
            next_cb(true)
          end)
        else
          next_cb(true)
        end
      end):add(function(next_cb)
        M.fill_and_sort_servers(params, resp, player_server_maps, function(_succ3, sort_result)
          local ret = {
            players_list = players_list,
            server_node = sort_result.server_node
          }
          utils.safe_call_cb(_cb_wrapper, true, ret)
          next_cb(true)
        end)
      end):add(function(next_cb)
        if _refresh_cb then
          local uuid = require("ejoysdk_lua.ejoysdk_uuid")
          local current_timer_id = uuid()
          _get_server_node_info_list_timer_id = current_timer_id
          local refresh_callback_wrapper
          local r_server_list = utils.deepcopy(server_list)
          local r_server_list_map = {}
          local r_players_list = utils.deepcopy(players_list)
          for _, sv in pairs(r_server_list) do
            r_server_list_map[sv.server_id] = sv
          end
          
          function refresh_callback_wrapper(loop_timer_id)
            if not _get_server_node_info_list_timer_id or loop_timer_id ~= _get_server_node_info_list_timer_id then
              E.LOG.debug(TAG, "diff timer id, ignore refresh")
              return
            end
            E.LOG.debug(TAG, "try to refresh alive server and marks")
            M.replace_alive_server(alive_params, r_server_list, function(replace_alive_server_succ, ...)
              if replace_alive_server_succ then
                local r_player_server_maps = {}
                M.fill_player_server_infos(r_players_list, r_player_server_maps, r_server_list_map)
                M.fill_and_sort_servers(params, resp, r_player_server_maps, function(_succ3, sort_result)
                  if _succ3 then
                    if not _get_server_node_info_list_timer_id or loop_timer_id ~= _get_server_node_info_list_timer_id then
                      E.LOG.debug(TAG, "diff timer id in cb, ignore refresh")
                      return
                    end
                    local ret2 = {
                      players_list = players_list,
                      server_node = sort_result.server_node
                    }
                    utils.safe_call_cb(_refresh_cb, true, ret2)
                  end
                  E.Timer.once(params.refresh_interval or DEFAULT_REFRESH_INTERVAL, function()
                    refresh_callback_wrapper(loop_timer_id)
                  end)
                end)
              end
            end)
          end
          
          E.Timer.once(params.refresh_interval or DEFAULT_REFRESH_INTERVAL, function()
            refresh_callback_wrapper(current_timer_id)
          end)
        end
        next_cb(true)
      end):execute(function(_succ, _index)
        E.LOG.debug(TAG, "get_server_node_info_list finish:" .. tostring(_succ) .. ", index:" .. tostring(_index))
      end)
    end
    
    if server_list and 0 == utils.tablelength(server_list) then
      alive_finish = true
    else
      alive_params = {}
      if params then
        if params.server_groups or params.server_ids or params.link == true then
          alive_params = {server_ids = server_id_list}
        else
          alive_params.realm_types = params.realm_types
          if params.tags then
            alive_params.tags = params.tags
            alive_params.return_server_with_no_tags = true
          end
          if params.server_node then
            alive_params.server_node = params.server_node
          end
        end
      end
      EG.alive_servers_with_params(function(succ2, ...)
        alive_finish = true
        if succ2 then
          local alive_server_info = (...)
          fill_alive_value_v2(server_list, alive_server_info)
          node_total_cb()
        else
          local code, msg = ...
          utils.safe_call_cb(_cb_wrapper, false, code, msg)
        end
      end, alive_params)
    end
    if EG.user_info().token then
      local user_info_api = require("ejoysdk_lua.server_api.ejoysdk_user_info")
      local player_params = {}
      player_params.with_punishment = params.with_punishment
      player_params.born_publish_area = params.born_publish_area or params.born_publish_area_list
      user_info_api.get_players_v2(player_params, function(succ4, ...)
        get_players_finish = true
        if succ4 then
          players_list = (...)
          node_total_cb()
        else
          local code, msg = ...
          E.LOG.warn(TAG, "player_id_list fail, code=" .. tostring(code) .. ", msg=" .. tostring(msg))
          node_total_cb()
        end
      end)
    else
      get_players_finish = true
      node_total_cb()
    end
  end, params)
end

function M.stop_get_server_node_info_list_refresh()
  _get_server_node_info_list_timer_id = nil
end

return M
