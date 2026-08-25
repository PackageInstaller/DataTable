local E = require("ejoysdk_lua.ejoysdk")
local EH = require("ejoysdk_lua.ejoysdk_holo")
local player_cache = require("ejoysdk_lua.player.player_info_cache")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local util = require("ejoysdk_lua.ejoysdk_utils")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local player_scene = require("ejoysdk_lua.player.player_info_scene")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local player_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local player_log_util = require("ejoysdk_lua.player.player_log_util")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local STATES = require("ejoysdk_lua.chat.ejoysdk_chat_states")
local ejoysdk_user_info = require("ejoysdk_lua.server_api.ejoysdk_user_info")
local TAG = EM.MODULE.PLAYER .. "player_info"
local M = {}
local HTTP = E.HTTP
local module_inited = false
M.CACHE = player_cache
M.INFO_TYPES = {
  TYPE_PLAYER_INFOS = "player_infos",
  TYPE_ACCOUNT_INFOS = "account_infos",
  TYPE_CUSTOMER_INFOS = "customer_infos"
}
M.IDS = {
  IDS_PLAYER = "player_ids",
  IDS_ACCOUNT = "account_ids",
  IDS_CUSTOMER = "customer_account_ids"
}
M.PERSONAL_USER_TYPE = {
  CUSTOMER = "cs",
  ACCOUNT = "account",
  PLAYER = "player",
  OFFICIAL_VIRTUAL = "ov"
}
M.SYSTEM_USER_TYPE = {ACCOUNT = "account", PLAYER = "player"}
M.PERSONAL_USER_TYPE_TO_INFO_TYPE = {
  [M.PERSONAL_USER_TYPE.PLAYER] = M.INFO_TYPES.TYPE_PLAYER_INFOS,
  [M.PERSONAL_USER_TYPE.CUSTOMER] = M.INFO_TYPES.TYPE_CUSTOMER_INFOS,
  [M.PERSONAL_USER_TYPE.ACCOUNT] = M.INFO_TYPES.TYPE_ACCOUNT_INFOS
}
M.OLD_TYPE = {
  [M.IDS.IDS_PLAYER] = true,
  [M.IDS.IDS_ACCOUNT] = true,
  [M.IDS.IDS_CUSTOMER] = true
}
M.USER_ID_PREFIX_ACCOUNT = "acc_"
M.USER_ID_PREFIX_CUSTOMER_SERVICE = "cs_"
M.USER_ID_PREFIX_OFFICIAL_VIRTUAL = "ov_"
local start_with = E.Utils.start_with

function M.get_user_type_info(chat_user_id)
  local chat_ret = {}
  if type(chat_user_id) == "table" then
    local chat_user = chat_user_id
    chat_ret.personal_user_type = chat_user.user_type or ""
    chat_ret.user_id = chat_user.user_id
    return chat_ret
  end
  chat_ret.chat_user_id = chat_user_id
  if start_with(chat_user_id, M.USER_ID_PREFIX_ACCOUNT) then
    chat_ret.personal_user_type = M.PERSONAL_USER_TYPE.ACCOUNT
    chat_ret.user_id = chat_user_id:gsub(M.USER_ID_PREFIX_ACCOUNT, "")
  elseif start_with(chat_user_id, M.USER_ID_PREFIX_CUSTOMER_SERVICE) then
    chat_ret.personal_user_type = M.PERSONAL_USER_TYPE.CUSTOMER
    chat_ret.user_id = chat_user_id
  elseif start_with(chat_user_id, M.USER_ID_PREFIX_OFFICIAL_VIRTUAL) then
    chat_ret.personal_user_type = M.PERSONAL_USER_TYPE.OFFICIAL_VIRTUAL
    chat_ret.user_id = chat_user_id:gsub(M.USER_ID_PREFIX_OFFICIAL_VIRTUAL, "")
  else
    chat_ret.personal_user_type = M.PERSONAL_USER_TYPE.PLAYER
    chat_ret.user_id = chat_user_id
  end
  local res = chat_ret
  return res
end

function M.classify_ids(ids, user)
  if not user or type(user) == "string" and "" == user or type(user) == "table" and not next(user) then
    E.LOG.debug(TAG, "classify_ids: user is nil or empty")
    return
  end
  local user_type_info = M.get_user_type_info(user)
  local user_id = user_type_info.user_id
  local personal_user_type = user_type_info.personal_user_type
  E.LOG.debug(TAG, "classify_ids user_id:" .. user_id .. ", personal_user_type:" .. personal_user_type)
  if personal_user_type == M.PERSONAL_USER_TYPE.PLAYER then
    ids[M.IDS.IDS_PLAYER] = ids[M.IDS.IDS_PLAYER] or {}
    table.insert(ids[M.IDS.IDS_PLAYER], user_id)
  elseif personal_user_type == M.PERSONAL_USER_TYPE.ACCOUNT then
    ids[M.IDS.IDS_ACCOUNT] = ids[M.IDS.IDS_ACCOUNT] or {}
    table.insert(ids[M.IDS.IDS_ACCOUNT], user_id)
  elseif personal_user_type == M.PERSONAL_USER_TYPE.CUSTOMER then
    ids[M.IDS.IDS_CUSTOMER] = ids[M.IDS.IDS_CUSTOMER] or {}
    table.insert(ids[M.IDS.IDS_CUSTOMER], user_id)
  elseif "" ~= personal_user_type then
    ids[personal_user_type] = ids[personal_user_type] or {}
    table.insert(ids[personal_user_type], user_id)
  end
end

function M.find_and_copy_in_combined_infos(combined_user_infos, chat_user_id)
  if nil == chat_user_id or "" == chat_user_id then
    return nil
  end
  local account_infos = combined_user_infos[M.INFO_TYPES.TYPE_ACCOUNT_INFOS]
  local player_infos = combined_user_infos[M.INFO_TYPES.TYPE_PLAYER_INFOS]
  local customer_infos = combined_user_infos[M.INFO_TYPES.TYPE_CUSTOMER_INFOS]
  local user_type_info = M.get_user_type_info(chat_user_id)
  local real_user_id = user_type_info.user_id
  local personal_user_type = user_type_info.personal_user_type
  local base_user_infos
  if personal_user_type == M.PERSONAL_USER_TYPE.ACCOUNT then
    base_user_infos = account_infos
  elseif personal_user_type == M.PERSONAL_USER_TYPE.PLAYER then
    base_user_infos = player_infos
  elseif personal_user_type == M.PERSONAL_USER_TYPE.CUSTOMER then
    base_user_infos = customer_infos
  elseif "" ~= personal_user_type then
    base_user_infos = combined_user_infos[personal_user_type]
  end
  local user_info
  if base_user_infos then
    user_info = base_user_infos[real_user_id]
    if user_info then
      user_info = util.deepcopy(user_info)
      user_info.user_id = real_user_id
      user_info.chat_user_id = chat_user_id
      user_info.user_type = user_type_info.personal_user_type
    end
  end
  return user_info
end

local function require_params(token)
  return {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["Ejoy-Token"] = token
    }
  }
end

local function require_player_params()
  local player_token = EH.get_player_token()
  local player_params = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["moment-Token"] = player_token
    },
    _log_config = {disable = true}
  }
  return player_params
end

local function https_get_player_infos(player_ids, params, cb)
  local user_info_url = E.CONFIG.get_config("user-info")
  local api_str = "/player_api/get_player_info_list"
  local url = user_info_url .. api_str
  local players = {}
  local count = #player_ids
  local MAX_COUNT_EACH_BATCH = 200
  
  local function get_one_batch_player_ids()
    local ids = {}
    if count > MAX_COUNT_EACH_BATCH then
      local i = MAX_COUNT_EACH_BATCH
      while i > 0 do
        table.insert(ids, table.remove(player_ids, 1))
        i = i - 1
        count = count - 1
      end
    else
      count = 0
      ids = player_ids
    end
    return ids
  end
  
  local https_func
  
  local function callback(succ, ...)
    if succ then
      local new_players = (...)
      for _, player in pairs(new_players) do
        table.insert(players, player)
      end
      if count > 0 then
        https_func()
      else
        cb(true, players)
      end
    elseif #players > 0 then
      cb(true, players)
    else
      cb(false, ...)
    end
  end
  
  local function https_get_player_infos_inner()
    local ids = get_one_batch_player_ids()
    local http_body = {player_id_list = ids}
    for key, value in pairs(params) do
      http_body[key] = value
    end
    local http_params = require_player_params()
    E.LOG.debug(TAG, "https_get_player_infos >>")
    player_log.debug(player_log_util.header(), TAG, "https_get_player_infos_req", "https_get_player_infos", {
      http_params = http_params,
      http_body = http_body,
      url = url
    }, {})
    E.HTTP.post(url, http_params, E.HTTP.CT_JSON, http_body, function(resp)
      if resp.status == 200 then
        if resp.body then
          if 0 == resp.body.code then
            callback(true, resp.body.player_list, resp.body.scene_info)
            local log_players = player_log_util.simple_player_infos(resp.body.player_list)
            local log_player_sections = player_log.list_by_section(log_players, 5)
            for _, v in pairs(log_player_sections) do
              player_log.debug(player_log_util.header(), TAG, "https_get_player_infos_resp_succ", "https_get_player_infos", {section = v}, {})
            end
            if #ids > #(resp.body.player_list or {}) then
              local resp_player_ids = {}
              for _, resp_player in pairs(resp.body.player_list) do
                if resp_player.player_id then
                  table.insert(resp_player_ids, resp_player.player_id)
                end
              end
              ESTAT.stat_error_with_limit(TAG, "get_player_infos_fail_on_count_less", "get_player_infos_fail_on_count_less", "chat_err_get_player_infos_fail", {player_id_list = ids, resp_player_list = resp_player_ids})
            end
          else
            callback(false, resp.body.code, resp.body.message)
            player_log.warn(player_log_util.header(), TAG, "https_get_player_infos_resp_fail", {
              code = resp.body.code,
              msg = resp.body.message
            }, {})
            ESTAT.stat_error_with_limit(TAG, "get_player_infos_fail_on_server_error", "get_player_infos_fail_on_server_error", "chat_err_get_player_infos_fail", {
              player_id_list = ids,
              code = resp.body.code or "null",
              msg = resp.body.message or "null"
            })
          end
        else
          callback(false, -1, "http nil body")
          player_log.warn(player_log_util.header(), TAG, "https_get_player_infos_resp_fail", {
            code = -1,
            msg = "http nil body"
          }, {})
          ESTAT.stat_error_with_limit(TAG, "get_player_infos_fail_on_body_nil", "get_player_infos_fail_on_body_nil", "chat_err_get_player_infos_fail", {player_id_list = ids})
        end
      else
        ESTAT.stat_error_with_limit(TAG, "get_player_infos_fail_on_http_error", "get_player_infos_fail_on_http_error", "chat_err_get_player_infos_fail", {
          player_id_list = ids,
          status = resp.status or "null"
        })
        callback(false, resp.status, "")
        player_log.warn(player_log_util.header(), TAG, "https_get_player_infos_resp_fail", {
          code = resp.status,
          msg = ""
        }, {})
      end
    end)
  end
  
  https_func = https_get_player_infos_inner
  https_get_player_infos_inner()
end

local function get_cache_player(player_id, opts)
  if opts.use_cache == false then
    do return player_cache.get_player_info_with_expire, player_id, 30 end
    return player_cache.get_player_info_with_expire, player_id, 30, opts.scene
  else
    do return player_cache.get_player_info, player_id end
    return player_cache.get_player_info, player_id, opts.scene, opts.scene
  end
end

function M.get_player_infos(player_ids, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "<<<<<<<<<<<< get_player_infos >>>>>>>>>>", player_log.LOG_LEVEL.LOW, {}, player_ids, opts, cb)
  opts = opts or {}
  if type(opts) == "function" then
    cb = opts
    opts = {}
  end
  if not opts.scene then
    opts.scene = player_scene.OFFICIAL_SCENE.DEFAULT
  end
  local unique_player_ids = {}
  for _, player_id in ipairs(player_ids) do
    unique_player_ids[player_id] = true
  end
  local uncache_player_ids = {}
  local player_infos = {}
  for player_id, _ in pairs(unique_player_ids) do
    local cached_player = get_cache_player(player_id, opts)
    if cached_player then
      player_infos[player_id] = cached_player
    else
      table.insert(uncache_player_ids, player_id)
    end
  end
  E.log("get player, uncache player ids: " .. tostring(#uncache_player_ids))
  E.log({uncache_player_ids = uncache_player_ids})
  
  local function callback_succ()
    if opts.playerid_to_info then
      if cb then
        cb(true, player_infos)
      end
      local temp_list = {}
      for _, v in pairs(player_infos) do
        table.insert(temp_list, v)
      end
      local simple_players = player_log_util.simple_player_infos(temp_list)
      local simple_player_sections = player_log.list_by_section(simple_players, 5)
      for _, v in pairs(simple_player_sections) do
        player_log.debug(player_log_util.header(), TAG, "log_player_infos", "chat_log_player_infos", {simple_player_section = v}, {})
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, "player_infos_placeholder")
    else
      local sorted_player_infos = {}
      for _, player_id in pairs(player_ids) do
        table.insert(sorted_player_infos, player_infos[player_id])
      end
      if cb then
        cb(true, sorted_player_infos)
      end
      local simple_players = player_log_util.simple_player_infos(sorted_player_infos)
      local simple_player_sections = player_log.list_by_section(simple_players, 5)
      for _, v in pairs(simple_player_sections) do
        player_log.debug(player_log_util.header(), TAG, "log_player_infos", "chat_log_player_infos", {simple_player_section = v}, {})
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, "player_infos_placeholder")
    end
  end
  
  local function get_uncache_player_infos_from_server(scene)
    local params = {scene_id = scene}
    local scene_for_md5 = "default"
    if scene and #scene > 0 then
      scene_for_md5 = scene
    end
    local scene_md5 = player_scene.get_scene_md5(scene_for_md5)
    if #scene_md5 > 0 then
      params.scene_hash = scene_md5
    else
      params.scene_hash = ""
    end
    https_get_player_infos(uncache_player_ids, params, function(succ, ...)
      if succ then
        local uncache_players, server_scene_info = ...
        if server_scene_info then
          local scene_info = player_scene.transform_to_scene_info(server_scene_info.params.player_info)
          local selected_all = server_scene_info.params.player_info.selected_all
          local md5 = server_scene_info.hash
          player_scene.set_scene_info(scene, scene_info, selected_all, md5)
        end
        for _, player in pairs(uncache_players) do
          player_cache.add_player_info_unsafe(player.player_id, player, "user_info_http", scene)
          player_infos[player.player_id] = player_cache.get_player_info(player.player_id, scene)
        end
        callback_succ()
      else
        if cb then
          cb(false, ...)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_infos", player_log.LOG_LEVEL.LOW, {}, cb, false, ...)
      end
    end)
  end
  
  if 0 == #uncache_player_ids then
    callback_succ()
    return
  end
  if opts.scene then
    player_scene.get_scene_info(opts.scene, function(succ, ...)
      if succ then
        get_uncache_player_infos_from_server(opts.scene)
      else
        if cb then
          cb(false, ...)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_infos", player_log.LOG_LEVEL.LOW, {}, cb, false, ...)
      end
    end)
  else
    get_uncache_player_infos_from_server()
  end
end

function M.get_player_infos_default_scene(player_ids, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_player_infos_default_scene", player_log.LOG_LEVEL.LOW, {}, player_ids, opts, cb)
  opts = opts or {}
  opts.scene = player_scene.OFFICIAL_SCENE.DEFAULT
  M.get_player_infos(player_ids, opts, function(...)
    if cb then
      cb(...)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_infos_default_scene", player_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.get_player_infos_chat_scene(player_ids, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_player_infos_chat_scene", player_log.LOG_LEVEL.LOW, {}, player_ids, opts, cb)
  opts = opts or {}
  opts.scene = player_scene.OFFICIAL_SCENE.CHAT
  M.get_player_infos(player_ids, opts, function(...)
    if cb then
      cb(...)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_infos_chat_scene", player_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.get_player_infos_bbs_scene(player_ids, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_player_infos_bbs_scene", player_log.LOG_LEVEL.LOW, {}, player_ids, opts, cb)
  opts = opts or {}
  opts.scene = player_scene.OFFICIAL_SCENE.BBS
  M.get_player_infos(player_ids, opts, function(...)
    if cb then
      cb(...)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_infos_bbs_scene", player_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.get_player_infos_friend_scene(player_ids, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_player_infos_friend_scene", player_log.LOG_LEVEL.LOW, {}, player_ids, opts, cb)
  opts = opts or {}
  opts.scene = player_scene.OFFICIAL_SCENE.FRIEND
  do return M.get_player_infos, player_ids, opts end
  return M.get_player_infos, player_ids, opts, function(...)
    if cb then
      cb(...)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_infos_friend_scene", player_log.LOG_LEVEL.LOW, {}, cb, ...)
  end, player_log.LOG_LEVEL.LOW, {}, player_ids, opts, cb
end

function M.get_player_info(player_id, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_player_info", player_log.LOG_LEVEL.LOW, {}, player_id, opts, cb)
  if type(opts) == "function" then
    cb = opts
    opts = {}
  end
  local player_ids = {}
  table.insert(player_ids, player_id)
  M.get_player_infos(player_ids, opts, function(succ, ...)
    if succ then
      local players = (...)
      if cb then
        cb(true, players[1])
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_info", player_log.LOG_LEVEL.LOW, {}, cb, true, players[1])
    else
      if cb then
        cb(false, ...)
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_info", player_log.LOG_LEVEL.LOW, {}, cb, false, ...)
    end
  end)
end

function M.get_player_info_default_scene(player_id, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_player_info_default_scene", player_log.LOG_LEVEL.LOW, {}, player_id, opts, cb)
  opts = opts or {}
  opts.scene = player_scene.OFFICIAL_SCENE.DEFAULT
  M.get_player_info(player_id, opts, function(...)
    if cb then
      cb(...)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_info_default_scene", player_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.get_player_info_chat_scene(player_id, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_player_info_chat_scene", player_log.LOG_LEVEL.LOW, {}, player_id, opts, cb)
  opts = opts or {}
  opts.scene = player_scene.OFFICIAL_SCENE.CHAT
  do return M.get_player_info, player_id, opts end
  return M.get_player_info, player_id, opts, function(...)
    if cb then
      cb(...)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_info_chat_scene", player_log.LOG_LEVEL.LOW, {}, cb, ...)
  end, player_log.LOG_LEVEL.LOW, {}, player_id, opts, cb
end

function M.get_player_info_bbs_scene(player_id, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_player_info_bbs_scene", player_log.LOG_LEVEL.LOW, {}, player_id, opts, cb)
  opts = opts or {}
  opts.scene = player_scene.OFFICIAL_SCENE.BBS
  M.get_player_info(player_id, opts, function(...)
    if cb then
      cb(...)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_info_bbs_scene", player_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.get_player_info_friend_scene(player_id, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_player_info_friend_scene", player_log.LOG_LEVEL.LOW, {}, player_id, opts, cb)
  opts = opts or {}
  opts.scene = player_scene.OFFICIAL_SCENE.FRIEND
  M.get_player_info(player_id, opts, function(...)
    if cb then
      cb(...)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_info_friend_scene", player_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.get_player_vip_info(player_id, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_player_vip_info", player_log.LOG_LEVEL.LOW, {}, player_id, cb)
  local user_info = EG.user_info()
  if not user_info.ptoken or not user_info.token then
    if cb then
      cb(false, -1, "user ptoken or ejoy_token is invalid")
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_vip_info", player_log.LOG_LEVEL.LOW, {}, cb, false, -1, "user ptoken or ejoy_token is invalid")
  else
    local server_id = EG.player_info().server_id
    if not server_id or not player_id then
      if cb then
        cb(false, -1, "user server_id or player_id is invalid")
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_vip_info", player_log.LOG_LEVEL.LOW, {}, cb, false, -1, "user server_id or player_id is invalid")
      return
    end
    local vip_info_url = EG.gangplank_logined_url("/account_vip_info", "2")
    local params = {}
    params.ptoken = user_info.ptoken
    params.server_id = server_id
    params.player_id = player_id
    HTTP.post(vip_info_url, require_params(user_info.token), HTTP.CT_JSON, params, function(resp)
      if resp.status == 200 then
        if 0 == resp.body.code then
          if cb then
            cb(true, resp.body.vipinfo or {})
          end
          player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_vip_info", player_log.LOG_LEVEL.LOW, {}, cb, true, resp.body.vipinfo or {})
        else
          if cb then
            cb(false, resp.body.code, resp.body.message)
          end
          player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_vip_info", player_log.LOG_LEVEL.LOW, {}, cb, false, resp.body.code, resp.body.message)
        end
      else
        if cb then
          cb(false, resp.status, "")
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_player_vip_info", player_log.LOG_LEVEL.LOW, {}, cb, false, resp.status, "")
      end
    end)
  end
end

local function rpc_get_account_infos(account_ids, cb)
  local prefix = E.CONFIG.get_config("user-info")
  local url = prefix .. "/client_api/get_account_infos"
  local token = EG.user_info().token
  local headers = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["Ejoy-Token"] = token
    }
  }
  local params = {account_ids = account_ids}
  E.HTTP.post(url, headers, E.HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      if 0 == resp.body.code then
        cb(true, resp.body.account_list)
      else
        cb(false, resp.body.code, resp.body.message or "")
      end
    else
      cb(false, resp.status, "")
    end
  end)
end

local function http_get_customer_infos(account_ids, cb)
  local prefix = E.CONFIG.get_config("user-info")
  local api_str = "/player_api/get_chat_customer_info_list"
  local url = prefix .. api_str
  local params = {chat_user_ids = account_ids}
  E.HTTP.post(url, require_player_params(), E.HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      if 0 == resp.body.code then
        cb(true, resp.body.account_list)
      else
        cb(false, resp.body.code, resp.body.message or "")
      end
    else
      cb(false, resp.status, "")
    end
  end)
end

function M.player_change_server(target_player_id, target_server_id, cb)
  player_log.call_api(player_log_util.header(), TAG, "player_change_server", player_log.LOG_LEVEL.LOW, {}, target_player_id, target_server_id, cb)
  if not target_server_id or "" == target_server_id then
    cb(false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_SERVERID_INVALID, "server id is nil")
    return
  end
  local prefix = E.CONFIG.get_config("user-info")
  local url = prefix .. "/client_api/player_change_server"
  local token = EG.user_info().token
  local headers = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["Ejoy-Token"] = token
    }
  }
  local params = {want_to_server_id = target_server_id, player_id = target_player_id}
  E.HTTP.post(url, headers, E.HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      if 0 == resp.body.code or 200 == resp.body.code then
        if cb then
          cb(true, resp.body)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "player_change_server", player_log.LOG_LEVEL.LOW, {}, cb, true, resp.body)
      else
        if cb then
          cb(false, resp.body.code, resp.body.message or "")
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "player_change_server", player_log.LOG_LEVEL.LOW, {}, cb, false, resp.body.code, resp.body.message or "")
      end
    else
      if cb then
        cb(false, resp.status, "")
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "player_change_server", player_log.LOG_LEVEL.LOW, {}, cb, false, resp.status, "")
    end
  end)
end

function M.batch_player_change_server(change_list, cb)
  player_log.call_api(player_log_util.header(), TAG, "batch_player_change_server", player_log.LOG_LEVEL.LOW, {}, change_list, cb)
  local prefix = E.CONFIG.get_config("user-info")
  local url = prefix .. "/client_api/batch_player_change_server"
  local token = EG.user_info().token
  local headers = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["Ejoy-Token"] = token
    }
  }
  local change_info_list = {}
  for player_id, change_server in pairs(change_list) do
    table.insert(change_info_list, {player_id = player_id, want_to_server_id = change_server})
  end
  local length = #change_info_list
  local count = 0
  local ONE_BATCH_LENGTH = 30
  local result = {}
  
  local function request_one_batch()
    local one_batch_change_info_list = {}
    local one_batch_count = 0
    while one_batch_count < ONE_BATCH_LENGTH and count < length do
      one_batch_count = one_batch_count + 1
      count = count + 1
      table.insert(one_batch_change_info_list, change_info_list[count])
    end
    local params = {change_info_list = one_batch_change_info_list}
    E.HTTP.post(url, headers, E.HTTP.CT_JSON, params, function(resp)
      if resp.status == 200 then
        if 0 == resp.body.code or 200 == resp.body.code then
          for _, item in ipairs(resp.body.change_result) do
            table.insert(result, item)
          end
          if count < length then
            request_one_batch()
          else
            if cb then
              cb(true, result)
            end
            player_log.call_api_async_callback(player_log_util.header(), TAG, "player_change_server", player_log.LOG_LEVEL.LOW, {}, cb, true, result)
          end
        else
          if cb then
            cb(false, resp.body.code, resp.body.message or "")
          end
          player_log.call_api_async_callback(player_log_util.header(), TAG, "player_change_server", player_log.LOG_LEVEL.LOW, {}, cb, false, resp.body.code, resp.body.message or "")
        end
      else
        if cb then
          cb(false, resp.status, "")
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "player_change_server", player_log.LOG_LEVEL.LOW, {}, cb, false, resp.status, "")
      end
    end)
  end
  
  request_one_batch()
end

function M.get_self_account_info(cb)
  local account_id = EG.user_info().uid
  if not account_id or 0 == #account_id then
    util.safe_call_cb(cb, false, CONSTANTS.PLAYER_ERROR_CODES.CODE_ACCOUNT_ID_MISS, "account id miss")
    return
  end
  M.get_account_infos({account_id}, function(succ, ...)
    if succ then
      local account_infos = (...)
      if #account_infos > 0 then
        local self_account_info = account_infos[1]
        util.replace_empty_table(self_account_info, nil)
        util.safe_call_cb(cb, true, self_account_info)
      else
        util.safe_call_cb(cb, false, CONSTANTS.PLAYER_ERROR_CODES.CODE_ACCOUNT_INFO_MISS, "account info miss")
      end
    else
      util.safe_call_cb(cb, false, ...)
    end
  end)
end

function M.get_account_infos(account_ids, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_account_infos", player_log.LOG_LEVEL.LOW, {}, account_ids, cb)
  local account_infos = {}
  local uncache_account_ids = {}
  for _, account_id in ipairs(account_ids) do
    local cache_account_info = player_cache.get_account_info(account_id)
    if cache_account_info then
      table.insert(account_infos, cache_account_info)
    else
      table.insert(uncache_account_ids, account_id)
    end
  end
  E.LOG.debug(TAG, "get_account_infos uncache_account_ids >>")
  E.log({uncache_account_ids = uncache_account_ids})
  if #uncache_account_ids > 0 then
    rpc_get_account_infos(uncache_account_ids, function(succ, ...)
      if succ then
        local new_account_infos = (...)
        for _, new_account_info in ipairs(new_account_infos) do
          player_cache.add_account_info(new_account_info.account_id, new_account_info)
          table.insert(account_infos, new_account_info)
        end
        if cb then
          cb(true, account_infos)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_account_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, account_infos)
      else
        if cb then
          cb(false, ...)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_account_infos", player_log.LOG_LEVEL.LOW, {}, cb, false, ...)
      end
    end)
  else
    if cb then
      cb(true, account_infos)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_account_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, account_infos)
  end
end

function M.get_customer_infos(account_ids, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_customer_infos", player_log.LOG_LEVEL.HIGH, {}, account_ids, cb)
  local customer_infos = {}
  local uncache_account_ids = {}
  for _, account_id in ipairs(account_ids) do
    local cache_account_info = player_cache.get_customer_info(account_id)
    if cache_account_info then
      table.insert(customer_infos, cache_account_info)
    else
      table.insert(uncache_account_ids, account_id)
    end
  end
  E.LOG.debug(TAG, "get_customer_infos uncache_account_ids >>")
  E.log({uncache_account_ids = uncache_account_ids})
  if #uncache_account_ids > 0 then
    http_get_customer_infos(uncache_account_ids, function(succ, ...)
      if succ then
        local new_customer_infos = (...)
        for _, new_customer_info in ipairs(new_customer_infos) do
          player_cache.add_customer_info(new_customer_info.account_id, new_customer_info)
          table.insert(customer_infos, new_customer_info)
        end
        if cb then
          cb(true, customer_infos)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_account_infos", player_log.LOG_LEVEL.HIGH, {}, cb, true, customer_infos)
      else
        local _err_code, _err_msg = ...
        if cb then
          cb(false, ...)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_account_infos", player_log.LOG_LEVEL.HIGH, {}, cb, false, ...)
      end
    end)
  else
    if cb then
      cb(true, customer_infos)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_account_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, customer_infos)
  end
end

function M.get_account_info(account_id, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_account_info", player_log.LOG_LEVEL.LOW, {}, account_id, cb)
  local cache_account_info = player_cache.get_account_info(account_id)
  if cache_account_info then
    cb(true, cache_account_info)
  else
    local account_ids = {}
    table.insert(account_ids, account_id)
    rpc_get_account_infos(account_ids, function(succ, ...)
      if succ then
        local account_infos = (...)
        local account_info = account_infos[1]
        player_cache.add_account_info(account_info.account_id, account_info)
        if cb then
          cb(true, account_info)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_account_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, account_info)
      else
        if cb then
          cb(false, ...)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_account_infos", player_log.LOG_LEVEL.LOW, {}, cb, false, ...)
      end
    end)
  end
end

function M.get_filled_player_account_infos(account_ids, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_filled_player_account_infos", player_log.LOG_LEVEL.LOW, {}, account_ids, opts, cb)
  if type(opts) == "function" then
    cb = opts
    opts = {}
  end
  if type(opts) ~= "table" then
    opts = {}
  end
  local result_account_infos = {}
  if 0 == #account_ids then
    if cb then
      cb(true, result_account_infos)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_filled_player_account_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, result_account_infos)
    return
  end
  
  local function player_infos_callback(succ, ...)
    if succ then
      local player_infos = (...)
      for _, player_info in ipairs(player_infos) do
        local account_id = player_info.account
        if result_account_infos[account_id] and result_account_infos[account_id].official_info then
          result_account_infos[account_id].official_info.last_login_player = player_info
        end
      end
      if cb then
        cb(true, result_account_infos)
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_filled_player_account_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, result_account_infos)
    else
      if cb then
        cb(false, ...)
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_filled_player_account_infos", player_log.LOG_LEVEL.LOW, {}, cb, false, ...)
    end
  end
  
  local last_player_ids = {}
  
  local function account_infos_callback(succ, ...)
    if succ then
      local account_infos = (...)
      for _, account_info in ipairs(account_infos) do
        result_account_infos[account_info.account_id] = account_info
        if account_info.official_info and account_info.official_info.last_login_player then
          table.insert(last_player_ids, account_info.official_info.last_login_player)
        end
      end
      if #last_player_ids > 0 then
        M.get_player_infos(last_player_ids, opts, player_infos_callback)
      else
        if cb then
          cb(true, result_account_infos)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_filled_player_account_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, result_account_infos)
      end
    else
      if cb then
        cb(false, ...)
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_filled_player_account_infos", player_log.LOG_LEVEL.LOW, {}, cb, false, ...)
    end
  end
  
  M.get_account_infos(account_ids, account_infos_callback)
end

function M.get_user_list_account_info(user_list, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_user_list_account_info", player_log.LOG_LEVEL.LOW, {}, user_list, opts, cb)
  if type(opts) == "function" then
    cb = opts
    opts = {}
  end
  if type(opts) ~= "table" then
    opts = {}
  end
  local item_maps = {}
  local account_ids = {}
  for _, item in ipairs(user_list) do
    local account_id = item.user_id
    if account_id then
      item.account_id = account_id
      item_maps[account_id] = item
      table.insert(account_ids, item.user_id)
    end
  end
  if 0 == #account_ids then
    if cb then
      cb(true, user_list)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_user_list_account_info", player_log.LOG_LEVEL.LOW, {}, cb, true, user_list)
    return
  end
  M.get_filled_player_account_infos(account_ids, opts, function(succ, ...)
    if succ then
      local account_info_map = (...)
      for account_id, account_info in pairs(account_info_map) do
        item_maps[account_id].account_info = account_info
      end
      local new_user_list = {}
      for _account_id, mix_item in pairs(item_maps) do
        table.insert(new_user_list, mix_item)
      end
      if cb then
        cb(true, new_user_list)
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_user_list_account_info", player_log.LOG_LEVEL.LOW, {}, cb, true, new_user_list)
    else
      if cb then
        cb(false, ...)
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_user_list_account_info", player_log.LOG_LEVEL.LOW, {}, cb, false, ...)
    end
  end)
end

function M.get_user_infos(user_list, cb)
  if not user_list or not next(user_list) then
    E.LOG.debug(TAG, "get_user_infos: user_list is nil or empty")
    return
  end
  local user_ids = {}
  for _, user in pairs(user_list) do
    table.insert(user_ids, user.user_id)
  end
  player_log.call_api(player_log_util.header(), TAG, "get_user_infos", player_log.LOG_LEVEL.HIGH, {}, user_ids, cb)
  local user_infos = {}
  local uncache_user_ids = {}
  local user_type = user_list[1].user_type
  for _, user_id in ipairs(user_ids) do
    local cache_user_info = player_cache.get_user_info(user_id, user_type)
    if cache_user_info then
      table.insert(user_infos, cache_user_info)
    else
      table.insert(uncache_user_ids, user_id)
    end
  end
  E.LOG.debug(TAG, "get_user_infos uncache_user_ids >>")
  E.log({uncache_user_ids = uncache_user_ids})
  if #uncache_user_ids > 0 then
    local params = {
      user_list = {}
    }
    for _, uncache_user_id in pairs(uncache_user_ids) do
      local uncache_user = {}
      uncache_user.user_id = uncache_user_id
      uncache_user.user_type = user_type
      table.insert(params.user_list, uncache_user)
    end
    ejoysdk_user_info.get_user_info_list(params, function(succ, ...)
      if succ then
        local new_user_infos = (...)
        for _, new_user_info in ipairs(new_user_infos) do
          player_cache.add_user_info(new_user_info.user_id, new_user_info, user_type)
          table.insert(user_infos, new_user_info)
        end
        if cb then
          cb(true, user_infos)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_user_infos", player_log.LOG_LEVEL.HIGH, {}, cb, true, user_infos)
      else
        local _err_code, _err_msg = ...
        if cb then
          cb(false, ...)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_user_infos", player_log.LOG_LEVEL.HIGH, {}, cb, false, ...)
      end
    end)
  else
    if cb then
      cb(true, user_infos)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_user_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, user_infos)
  end
end

local function table_unique(t)
  t = t or {}
  local check = {}
  local n = {}
  local idx = 1
  for _k, v in pairs(t) do
    if not check[v] then
      n[idx] = v
      idx = idx + 1
      check[v] = true
    end
  end
  return n
end

function M.batch_get_infos(ids, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "batch_get_infos", player_log.LOG_LEVEL.LOW, {}, ids, opts, cb)
  if type(opts) == "function" then
    cb = opts
    opts = {}
  end
  local unique_player_ids = table_unique(ids[M.IDS.IDS_PLAYER])
  local unique_account_ids = table_unique(ids[M.IDS.IDS_ACCOUNT])
  local unique_customer_account_ids = table_unique(ids[M.IDS.IDS_CUSTOMER])
  local need_info_types = {}
  need_info_types[M.INFO_TYPES.TYPE_PLAYER_INFOS] = #unique_player_ids > 0
  need_info_types[M.INFO_TYPES.TYPE_ACCOUNT_INFOS] = #unique_account_ids > 0
  need_info_types[M.INFO_TYPES.TYPE_CUSTOMER_INFOS] = #unique_customer_account_ids > 0
  local unique_ids = {}
  local need_other_info_types = false
  for type, id_list in pairs(ids) do
    if not M.OLD_TYPE[type] and next(id_list) then
      unique_ids[type] = table_unique(id_list)
      need_info_types[type] = #unique_ids[type] > 0
      need_other_info_types = need_other_info_types or need_info_types[type]
    end
  end
  local infos = {}
  if need_info_types[M.INFO_TYPES.TYPE_PLAYER_INFOS] or need_info_types[M.INFO_TYPES.TYPE_ACCOUNT_INFOS] or need_info_types[M.INFO_TYPES.TYPE_CUSTOMER_INFOS] or need_other_info_types then
    player_log.debug(player_log_util.header(), TAG, "start_batch_get_infos", "get_player_infos", {}, {})
  else
    if cb then
      cb(true, infos)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "batch_get_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, infos)
    return
  end
  local has_one_failed = false
  
  local function merge_infos_handler(succ, ...)
    if has_one_failed then
      return
    end
    if succ then
      local type, id_info_map = ...
      id_info_map = id_info_map or {}
      infos[type] = id_info_map
      local is_all_infos_ready = true
      for need_info_type, is_need in pairs(need_info_types) do
        if is_need and nil == infos[need_info_type] then
          is_all_infos_ready = false
          break
        end
      end
      if is_all_infos_ready then
        if cb then
          cb(true, infos)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "batch_get_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, infos)
      end
    else
      has_one_failed = true
      if cb then
        cb(false, ...)
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "batch_get_infos", player_log.LOG_LEVEL.LOW, {}, cb, false, ...)
    end
  end
  
  if need_info_types[M.INFO_TYPES.TYPE_PLAYER_INFOS] then
    M.get_player_infos(unique_player_ids, {
      playerid_to_info = true,
      scene = opts.scene
    }, function(succ, ...)
      if succ then
        local new_players = (...)
        merge_infos_handler(true, M.INFO_TYPES.TYPE_PLAYER_INFOS, new_players)
      else
        merge_infos_handler(false, ...)
      end
    end)
  end
  if need_info_types[M.INFO_TYPES.TYPE_ACCOUNT_INFOS] then
    M.get_filled_player_account_infos(unique_account_ids, opts, function(succ, ...)
      if succ then
        local account_info_map = (...)
        merge_infos_handler(true, M.INFO_TYPES.TYPE_ACCOUNT_INFOS, account_info_map)
      else
        merge_infos_handler(false, ...)
      end
    end)
  end
  if need_info_types[M.INFO_TYPES.TYPE_CUSTOMER_INFOS] then
    M.get_customer_infos(unique_customer_account_ids, function(succ, ...)
      if succ then
        local customer_infos = (...)
        local customer_info_map = {}
        for _, customer_info in ipairs(customer_infos) do
          customer_info_map[customer_info.account_id] = customer_info
        end
        merge_infos_handler(true, M.INFO_TYPES.TYPE_CUSTOMER_INFOS, customer_info_map)
      else
        merge_infos_handler(false, ...)
      end
    end)
  end
  for type, unique_id_list in pairs(unique_ids) do
    if not M.OLD_TYPE[type] and need_info_types[type] then
      local user_list = {}
      for _, unique_id in pairs(unique_id_list) do
        local user = {}
        user.user_id = unique_id
        user.user_type = type
        table.insert(user_list, user)
      end
      M.get_user_infos(user_list, function(succ, ...)
        if succ then
          local user_infos = (...)
          local user_info_map = {}
          for _, single_user_info in ipairs(user_infos) do
            user_info_map[single_user_info.user_id] = single_user_info
          end
          merge_infos_handler(true, type, user_info_map)
        else
          merge_infos_handler(false, ...)
        end
      end)
    end
  end
end

function M.get_user_list_player_info(user_list, opts, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_user_list_player_info", player_log.LOG_LEVEL.LOW, {}, user_list, opts, cb)
  if type(opts) == "function" then
    cb = opts
    opts = {}
  end
  local player_maps = {}
  local player_ids = {}
  for _, item in ipairs(user_list) do
    local player_id = item.user_id
    item.player_id = player_id
    player_maps[player_id] = item
    table.insert(player_ids, item.user_id)
  end
  M.get_player_infos(player_ids, opts, function(succ, ...)
    if succ then
      local player_infos = (...)
      for _, player_info in ipairs(player_infos) do
        player_maps[player_info.player_id].player_info = player_info
      end
      local new_user_list = {}
      for _account_id, mix_item in pairs(player_maps) do
        table.insert(new_user_list, mix_item)
      end
      if cb then
        cb(true, new_user_list)
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_user_list_player_info", player_log.LOG_LEVEL.LOW, {}, cb, true, new_user_list)
    else
      if cb then
        cb(false, ...)
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_user_list_player_info", player_log.LOG_LEVEL.LOW, {}, cb, false, ...)
    end
  end)
end

function M.global_player_search(search_data, opt, cb)
  assert(search_data and "" ~= search_data, "search_data is empty!")
  local url_prefix = E.CONFIG.get_config("search")
  local url = url_prefix .. "/global_player_search"
  local holo = require("ejoysdk_lua.ejoysdk_holo")
  local player_token = holo.get_player_token()
  if not player_token then
    cb(false, -100, "no player token")
    return
  end
  local headers = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["moment-Token"] = player_token
    }
  }
  opt = opt or {}
  opt.search_data = search_data
  E.HTTP.post(url, headers, E.HTTP.CT_JSON, opt, function(resp)
    if resp and resp.status == 200 then
      local body = resp.body
      if 0 == body.code then
        local search_id = body.search_id
        local region_count = body.region_count
        cb(true, search_id, region_count)
      else
        cb(false, body.code, body.message or "")
      end
    else
      cb(false, resp.status, "")
    end
  end)
end

function M.player_search(search_data, opt, cb)
  assert(search_data and "" ~= search_data, "search_data is empty!")
  local url_prefix = E.CONFIG.get_config("search")
  local url = url_prefix .. "/player_search"
  local holo = require("ejoysdk_lua.ejoysdk_holo")
  local player_token = holo.get_player_token()
  if not player_token then
    cb(false, CONSTANTS.PLAYER_ERROR_CODES.CODE_PLAYER_TOKEN_MISS, "no player token")
    return
  end
  local headers = {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["moment-Token"] = player_token
    }
  }
  opt = opt or {}
  opt.search_data = search_data
  E.HTTP.post(url, headers, E.HTTP.CT_JSON, opt, function(resp)
    if resp and resp.status == 200 then
      local body = resp.body
      if 0 == body.code then
        cb(true, body.player_info_list or {})
      else
        cb(false, body.code, body.message or "")
      end
    else
      cb(false, resp.status, "")
    end
  end)
end

local function gangplank_logout_handler()
  player_cache.clear()
end

local function player_offline_handler()
  player_cache.clear()
end

function M.init()
  player_log.call_api(player_log_util.header(), TAG, "init", player_log.LOG_LEVEL.HIGH, {})
  if module_inited then
    return
  end
  module_inited = true
  ET.subscribe(ET.gangplank.LOGOUT, gangplank_logout_handler)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, player_offline_handler)
  ET.subscribe(ET.chat.UPDATE_STATE, function(state)
    if state == STATES.DISCONNECT or state == STATES.ERROR then
      player_cache.clear()
    end
  end)
end

return M
