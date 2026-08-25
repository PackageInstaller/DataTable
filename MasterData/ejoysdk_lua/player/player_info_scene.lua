local E = require("ejoysdk_lua.ejoysdk")
local util = require("ejoysdk_lua.ejoysdk_utils")
local EM = require("ejoysdk_lua.ejoysdk_module")
local player_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local player_log_util = require("ejoysdk_lua.player.player_log_util")
local TAG = EM.MODULE.PLAYER .. "player_info_scene"
local M = {}
M.OFFICIAL_SCENE = {
  DEFAULT = "default",
  CHAT = "chat",
  CHAT_MSG_RES = "chat_msg_res",
  BBS = "bbs",
  FRIEND = "friend",
  LIVE = "live",
  FRIEND_APPLY = "friend_apply",
  BLACK_LIST = "black_list",
  FOLLOW = "follow"
}
local scene_infos = {}
local selected_all_scenes = {}
local scene_md5s = {}

local function filter_table_with_table_keys(t, table_keys)
  local filter_table = {}
  for key, value in pairs(table_keys) do
    if t[key] then
      if type(value) == "table" then
        filter_table[key] = filter_table_with_table_keys(t[key], value)
      else
        filter_table[key] = t[key]
      end
    end
  end
  return filter_table
end

function M.get_scene_player_info_keys(scene)
  player_log.call_api(player_log_util.header(), TAG, "get_scene_player_info_keys", player_log.LOG_LEVEL.LOW, {}, scene)
  return scene_infos[scene], selected_all_scenes[scene], scene_md5s[scene]
end

function M.is_selected_all(scene)
  player_log.call_api(player_log_util.header(), TAG, "is_selected_all", player_log.LOG_LEVEL.LOW, {}, scene)
  local selected_all = selected_all_scenes[scene]
  local res
  if selected_all then
    res = true
  else
    res = false
  end
  player_log.call_api_sync_return(player_log_util.header(), TAG, "is_selected_all", player_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.filter_player_info(scene, player_info)
  local selected_all = selected_all_scenes[scene]
  local res
  if selected_all then
    res = util.deepcopy(player_info)
  else
    local player_info_keys = scene_infos[scene]
    if not player_info_keys then
      res = nil
    else
      res = filter_table_with_table_keys(player_info, player_info_keys)
    end
  end
  return res
end

function M.get_all_scenes()
  player_log.call_api(player_log_util.header(), TAG, "get_all_scenes", player_log.LOG_LEVEL.LOW, {})
  player_log.call_api_sync_return(player_log_util.header(), TAG, "get_all_scenes", player_log.LOG_LEVEL.LOW, {}, scene_infos, selected_all_scenes, scene_md5s)
  return scene_infos, selected_all_scenes, scene_md5s
end

function M.get_scene_md5(scene)
  player_log.call_api(player_log_util.header(), TAG, "get_scene_md5", player_log.LOG_LEVEL.LOW, {}, scene)
  local _, _, _scene_md5s = M.get_all_scenes()
  local md5 = _scene_md5s[scene] or ""
  player_log.call_api_sync_return(player_log_util.header(), TAG, "get_scene_md5", player_log.LOG_LEVEL.LOW, {}, md5)
  return md5
end

local function transform_to_scene_info(schema)
  local scene_info = {}
  local t = schema.children or schema
  for key, value in pairs(t) do
    if value.children then
      scene_info[key] = transform_to_scene_info(value.children)
    else
      scene_info[key] = true
    end
  end
  return scene_info
end

function M.transform_to_scene_info(schema)
  player_log.call_api(player_log_util.header(), TAG, "transform_to_scene_info", player_log.LOG_LEVEL.LOW, {}, schema)
  local res = transform_to_scene_info(schema)
  player_log.call_api_sync_return(player_log_util.header(), TAG, "transform_to_scene_info", player_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.set_scene_info(scene, scene_info, all_select, scene_md5)
  player_log.call_api(player_log_util.header(), TAG, "set_scene_info", player_log.LOG_LEVEL.LOW, {}, scene, scene_info, all_select, scene_md5)
  scene_infos[scene] = scene_info
  selected_all_scenes[scene] = all_select
  scene_md5s[scene] = scene_md5
end

function M.get_scene_infos(scenes, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_scene_infos", player_log.LOG_LEVEL.LOW, {}, scenes, cb)
  local uncache_scenes = {}
  local return_scene_infos = {}
  local return_selected_all_scenes = {}
  local return_scene_md5s = {}
  
  local function pick_return_from_mem_cache(scene)
    return_scene_infos[scene] = util.deepcopy(scene_infos[scene])
    if selected_all_scenes[scene] then
      return_selected_all_scenes[scene] = true
    else
      return_selected_all_scenes[scene] = false
    end
    return_scene_md5s[scene] = scene_md5s[scene]
  end
  
  for _, scene in ipairs(scenes) do
    if scene_infos[scene] then
      pick_return_from_mem_cache(scene)
    else
      table.insert(uncache_scenes, scene)
    end
  end
  if 0 == #uncache_scenes then
    if cb then
      cb(true, return_scene_infos, return_selected_all_scenes, return_scene_md5s)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "get_scene_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, return_scene_infos, return_selected_all_scenes, return_scene_md5s)
    return
  end
  local user_info_url = E.CONFIG.get_config("user-info")
  local p_api = "/params_manage/get_scene_info"
  local url = user_info_url .. p_api
  local EH = require("ejoysdk_lua.ejoysdk_holo")
  
  local function require_player_params()
    local player_token = EH.get_player_token()
    local player_params = {
      acceptable = E.HTTP.CT_JSON,
      headers = {
        ["moment-Token"] = player_token
      }
    }
    return player_params
  end
  
  local http_params = {scene_ids = uncache_scenes}
  local player_params = require_player_params()
  E.LOG.debug(TAG, player_params)
  E.HTTP.post(url, player_params, E.HTTP.CT_JSON, http_params, function(resp)
    if resp.status == 200 then
      if 200 == resp.body.code then
        local body = resp.body.data
        if body then
          for _, server_scene_info in ipairs(body) do
            local scene_id = server_scene_info.scene_id
            if server_scene_info.params and server_scene_info.params.player_info then
              local scene_info = transform_to_scene_info(server_scene_info.params.player_info)
              local selected_all = server_scene_info.params.player_info.selected_all
              local md5 = server_scene_info.hash
              M.set_scene_info(scene_id, scene_info, selected_all, md5)
              pick_return_from_mem_cache(scene_id)
            end
          end
        end
        if cb then
          cb(true, return_scene_infos, return_selected_all_scenes, return_scene_md5s)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_scene_infos", player_log.LOG_LEVEL.LOW, {}, cb, true, return_scene_infos, return_selected_all_scenes, return_scene_md5s)
      else
        if cb then
          cb(false, resp.body.code, resp.body.message)
        end
        player_log.call_api_async_callback(player_log_util.header(), TAG, "get_scene_infos", player_log.LOG_LEVEL.LOW, {}, cb, false, resp.body.code, resp.body.message)
      end
    else
      if cb then
        cb(false, resp.status, "")
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_scene_infos", player_log.LOG_LEVEL.LOW, {}, cb, false, resp.status, "")
    end
  end)
end

function M.get_scene_info(scene, cb)
  player_log.call_api(player_log_util.header(), TAG, "get_scene_info", player_log.LOG_LEVEL.LOW, {}, scene, cb)
  local scene_ids = {}
  table.insert(scene_ids, scene)
  M.get_scene_infos(scene_ids, function(succ, ...)
    if succ then
      local infos, return_selected_all_scenes, return_scene_md5s = ...
      if cb then
        cb(true, infos[scene], return_selected_all_scenes[scene], return_scene_md5s[scene])
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_scene_info", player_log.LOG_LEVEL.LOW, {}, cb, true, infos[scene], return_selected_all_scenes[scene], return_scene_md5s[scene])
    else
      if cb then
        cb(false, ...)
      end
      player_log.call_api_async_callback(player_log_util.header(), TAG, "get_scene_info", player_log.LOG_LEVEL.LOW, {}, cb, false, ...)
    end
  end)
end

return M
