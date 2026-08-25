local player_info_scene = require("ejoysdk_lua.player.player_info_scene")
local util = require("ejoysdk_lua.ejoysdk_utils")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local player_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local player_log_util = require("ejoysdk_lua.player.player_log_util")
local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local string_unpack = compat.string.unpack
local DEFAULT_EXPIRE_TIME = 60
local cache_expire_time = DEFAULT_EXPIRE_TIME
local scene_expire_time = {}
local TAG = EM.MODULE.PLAYER .. "player_info_cache"
local M = {}

local function merge_table_at_scene(a_old_table, a_new_table, is_selected_all, scene_info)
  assert(type(a_old_table) == "table", "param old_table must be table type")
  assert(type(a_new_table) == "table", "param new_table must be table type")
  assert(type(is_selected_all) == "boolean", "param is_selected_all must be boolean type")
  if is_selected_all then
    for k, _ in pairs(a_old_table) do
      a_old_table[k] = nil
    end
    for k, _ in pairs(a_new_table) do
      a_old_table[k] = a_new_table[k]
    end
  elseif scene_info then
    local function inner_merge_table_at_scene(old_table, new_table, scene_infos)
      for scene_info_k, _ in pairs(scene_infos) do
        local v = new_table[scene_info_k]
        
        local old_table_v = old_table[scene_info_k]
        if type(v) ~= type(old_table_v) then
          old_table[scene_info_k] = v
        elseif type(v) == "table" then
          if type(scene_infos[scene_info_k]) == "table" then
            old_table[scene_info_k] = inner_merge_table_at_scene(old_table[scene_info_k], v, scene_infos[scene_info_k])
          else
            old_table[scene_info_k] = v
          end
        else
          old_table[scene_info_k] = v
        end
      end
      return old_table
    end
    
    util.merge_table(a_old_table, a_new_table)
    inner_merge_table_at_scene(a_old_table, a_new_table, scene_info)
  else
    util.merge_table(a_old_table, a_new_table)
  end
  return a_old_table
end

local player_cache = {}
local account_cache = {}
local customer_cache = {}
local virtual_cache = {}
local scene_player_cache = {}
local PLAYER = "player"
local ACCOUNT = "account"
local CUSTOMER = "customer"
local VIRTUAL = "ov"
local type_to_cache = {
  [PLAYER] = player_cache,
  [ACCOUNT] = account_cache,
  [CUSTOMER] = customer_cache,
  [VIRTUAL] = virtual_cache
}
local scene_to_cache = {
  [PLAYER] = scene_player_cache
}

local function add_info(type, id, new_info, sdk_src, input_use_deepcopy)
  local cache = type_to_cache[type]
  if nil == cache then
    return
  end
  M.decode_update_time(new_info)
  local new_value = new_info
  if input_use_deepcopy then
    new_value = util.deepcopy(new_info)
  end
  local new_entity = {
    value = new_value,
    create_ts = os.time(),
    sdk_src = sdk_src
  }
  local old_entity = cache[id]
  if old_entity then
    local old_update_ts = old_entity.value.update_time or 0
    local new_update_time = new_info.update_time
    if new_update_time then
      if old_update_ts <= new_update_time then
        cache[id] = new_entity
      end
    else
      cache[id] = new_entity
    end
  else
    cache[id] = new_entity
  end
end

local function update_info(type, id, new_info, scene, async, cb)
  local function safe_cb(...)
  end
  
  cb = cb or safe_cb
  async = async or false
  local cache = type_to_cache[type]
  if nil == cache then
    return nil
  end
  M.decode_update_time(new_info)
  local old_entity = cache[id]
  if old_entity then
    local old_update_time = old_entity.value.update_time or 0
    local new_update_time = new_info.update_time
    
    local function update_entity()
      if scene then
        local scene_infos, selected_all_scenes = player_info_scene.get_all_scenes(scene)
        local cached_scene_info = scene_infos[scene]
        local cached_selected_all_scene = selected_all_scenes[scene]
        if cached_scene_info then
          merge_table_at_scene(old_entity.value, new_info, cached_selected_all_scene, cached_scene_info)
          old_entity.create_ts = os.time()
        else
          player_info_scene.get_scene_info(scene, function(...)
            local succ, scene_info, is_selected_all = ...
            if succ and scene_info then
              merge_table_at_scene(old_entity.value, new_info, is_selected_all, scene_info)
            else
              util.merge_table(old_entity.value, new_info)
              ESTAT.stat_fatal_error("update_player_info_fatal_error_get_scene_info_fail", "chat_err_update_player_info")
            end
            old_entity.create_ts = os.time()
            if async then
              cb(util.deepcopy(old_entity.value))
            else
              ESTAT.stat_fatal_error("update_player_info_fatal_error_sdk_should_use_async", "chat_err_update_player_info")
            end
          end)
          return
        end
      else
        util.merge_table(old_entity.value, new_info)
        old_entity.create_ts = os.time()
      end
    end
    
    if new_update_time then
      if old_update_time <= new_update_time then
        update_entity()
      end
    else
      update_entity()
    end
    if async then
      cb(util.deepcopy(old_entity.value))
      return
    else
      do return util.deepcopy end
      return util.deepcopy, old_entity.value, util.deepcopy(old_entity.value)
    end
  else
    player_log.warn(player_log_util.header(), TAG, "update_player_cache_failed", {target_player_id = id}, {})
  end
  if async then
    cb(nil)
  else
    return nil
  end
end

local function add_scene_info(type, id, scene, new_info, sdk_src, input_use_deepcopy)
  local cache = type_to_cache[type]
  if nil == cache then
    return nil
  end
  if not scene_to_cache[type] then
    return
  end
  M.decode_update_time(new_info)
  local scene_cache = scene_to_cache[type] and scene_to_cache[type][scene]
  if not scene_cache then
    scene_cache = {}
    scene_to_cache[type][scene] = scene_cache
  end
  local new_scene_entity = {
    update_time = new_info.update_time,
    create_ts = os.time()
  }
  local old_scene_entity = scene_cache[id]
  if old_scene_entity then
    if new_info.update_time then
      if new_info.update_time >= (old_scene_entity.update_time or 0) then
        scene_cache[id] = new_scene_entity
      end
    else
      scene_cache[id] = new_scene_entity
    end
  else
    scene_cache[id] = new_scene_entity
  end
  
  local function update_entity(old_entity)
    local scene_info, is_selected_all = player_info_scene.get_scene_player_info_keys(scene)
    if scene_info then
      merge_table_at_scene(old_entity.value, new_info, is_selected_all, scene_info)
      old_entity.value.update_time = new_info.update_time
      if old_entity.is_complete == false and true == is_selected_all then
        old_entity.is_complete = nil
      end
    else
      util.merge_table(old_entity.value, new_info)
    end
  end
  
  local old_entity = cache[id]
  if old_entity then
    local old_update_time = old_entity.value.update_time or 0
    local new_update_time = new_info.update_time
    if new_update_time then
      if old_update_time <= new_update_time then
        update_entity(old_entity)
      end
    else
      update_entity(old_entity)
    end
  else
    local new_value = new_info
    if input_use_deepcopy then
      new_value = util.deepcopy(new_info)
    end
    local new_entity = {
      value = new_value,
      create_ts = os.time(),
      sdk_src = sdk_src,
      is_complete = false
    }
    local scene_info, is_selected_all = player_info_scene.get_scene_player_info_keys(scene)
    if scene_info and true == is_selected_all then
      new_entity.is_complete = nil
    end
    cache[id] = new_entity
  end
end

local expire_trace_data = {
  last_count = 0,
  total_count = 0,
  last_player_id = ""
}
local trigger_processing = false

function M.trigger_expire_event(t_player_id)
  if t_player_id and expire_trace_data and type(t_player_id) == "string" then
    expire_trace_data.total_count = expire_trace_data.total_count + 1
    expire_trace_data.last_player_id = t_player_id
    if false == trigger_processing then
      local E = require("ejoysdk_lua.ejoysdk")
      E.LOG.debug(TAG, "cache player expire, player_id: " .. tostring(t_player_id))
      trigger_processing = true
      expire_trace_data.last_count = 1
      ESTAT.stat_action_with_limit("player_info", "player_cache_refresh_start", "player_cache_refresh_start", "player_cache_refresh", expire_trace_data, 60)
      E.Timer.once(300, function()
        ESTAT.stat_action_with_limit("player_info", "player_cache_refresh_end", "player_cache_refresh_end", "player_cache_refresh", expire_trace_data, 60)
        trigger_processing = false
      end)
    else
      expire_trace_data.last_count = expire_trace_data.last_count + 1
    end
  end
end

local function get_scene_info_with_expire(type, id, scene, expire_time, ignore_expire_time)
  local cache = type_to_cache[type]
  if nil == cache then
    return nil
  end
  local entity = cache[id]
  if not entity then
    return nil
  end
  local scene_cache = scene_to_cache[type] and scene_to_cache[type][scene]
  local create_ts = 0
  if scene_cache then
    local scene_entity = scene_cache[id]
    if scene_entity then
      create_ts = scene_entity.create_ts
    end
  end
  if entity.is_complete ~= false and create_ts < entity.create_ts then
    create_ts = entity.create_ts
  end
  
  local function get_cache_data()
    local scene_player_info = player_info_scene.filter_player_info(scene, entity.value)
    if not scene_player_info then
      return nil
    end
    scene_player_info = util.deepcopy(scene_player_info)
    scene_player_info._sdk_src = entity.sdk_src
    return scene_player_info
  end
  
  if ignore_expire_time then
    do return end
    return get_cache_data, nil, nil, nil
  else
    local now = os.time()
    local diff = now - create_ts
    if diff > expire_time * 60 then
      M.trigger_expire_event(id)
      return nil
    else
      do return end
      return get_cache_data, id
    end
  end
end

local function get_info_with_expire(type, id, expire_time, ignore_expire_time)
  local cache = type_to_cache[type]
  if nil == cache then
    return nil
  end
  local now = os.time()
  local info
  local old_entity = cache[id]
  if old_entity then
    if old_entity.is_complete == false then
      return nil
    end
    
    local function fill_info_data()
      info = util.deepcopy(old_entity.value)
      info._sdk_src = old_entity.sdk_src
    end
    
    if ignore_expire_time then
      fill_info_data()
    else
      local old_create_ts = old_entity.create_ts
      local diff = now - old_create_ts
      if diff > expire_time * 60 then
        M.trigger_expire_event(id)
        cache[id] = nil
      else
        fill_info_data()
      end
    end
  end
  return info
end

local function get_info(type, id, scene, ignore_expire_time)
  if scene then
    do return get_scene_info_with_expire, type, id, scene, scene_expire_time[scene] or DEFAULT_EXPIRE_TIME end
    return get_scene_info_with_expire, type, id, scene, scene_expire_time[scene] or DEFAULT_EXPIRE_TIME, ignore_expire_time
  else
    do return get_info_with_expire, type, id, cache_expire_time end
    return get_info_with_expire, type, id, cache_expire_time, ignore_expire_time, ignore_expire_time
  end
end

local function is_valid_player_info(player_info)
  local res = player_info and player_info.player_id and player_info.account and player_info.player_info
  if not res then
    local param = {}
    if player_info then
      param.player_id = player_info.player_id
      param.account = player_info.account
      if player_info.player_info then
        param.player_info_exist = true
      end
      param.update_time = player_info.update_time
    end
    ESTAT.stat_fatal_error("found_no_valid_player_info", "chat_err_found_no_valid_player_info", false, param)
  end
  return res
end

local function remove_info(type, id)
  local cache = type_to_cache[type]
  if nil == cache then
    return
  end
  cache[id] = nil
end

function M.add_player_info(player_id, player_info, sdk_source, scene)
  player_log.call_api(player_log_util.header(), TAG, "add_player_info", player_log.LOG_LEVEL.LOW, {}, player_id, player_info, sdk_source, scene)
  if scene then
    add_scene_info(PLAYER, player_id, scene, player_info, sdk_source, true)
  else
    if not is_valid_player_info(player_info) then
      return
    end
    add_info(PLAYER, player_id, player_info, sdk_source, true)
  end
end

function M.add_player_info_unsafe(player_id, player_info, sdk_source, scene)
  player_log.call_api(player_log_util.header(), TAG, "add_player_info_unsafe", player_log.LOG_LEVEL.LOW, {}, player_id, player_info, sdk_source, scene)
  if scene then
    add_scene_info(PLAYER, player_id, scene, player_info, sdk_source, false)
  else
    if not is_valid_player_info(player_info) then
      return
    end
    add_info(PLAYER, player_id, player_info, sdk_source, false)
  end
end

function M.async_update_player_info_at_scene(player_id, new_player_info, scene, cb)
  player_log.call_api(player_log_util.header(), TAG, "async_update_player_info_at_scene", player_log.LOG_LEVEL.LOW, {}, player_id, new_player_info, scene, cb)
  update_info(PLAYER, player_id, new_player_info, scene, true, function(...)
    if cb then
      cb(...)
    end
    player_log.call_api_async_callback(player_log_util.header(), TAG, "async_update_player_info_at_scene", player_log.LOG_LEVEL.LOW, {}, cb, ...)
  end)
end

function M.update_player_info(player_id, new_player_info)
  player_log.call_api(player_log_util.header(), TAG, "update_player_info", player_log.LOG_LEVEL.LOW, {}, player_id, new_player_info)
  local res = update_info(PLAYER, player_id, new_player_info)
  player_log.call_api_sync_return(player_log_util.header(), TAG, "update_player_info", player_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.get_player_info(player_id, scene)
  player_log.call_api(player_log_util.header(), TAG, "get_player_info", player_log.LOG_LEVEL.LOW, {}, player_id, scene)
  local res = get_info(PLAYER, player_id, scene)
  return res
end

function M.get_player_info_with_ignore_expire_time(player_id, scene)
  player_log.call_api(player_log_util.header(), TAG, "get_player_info_with_ignore_expire_time", player_log.LOG_LEVEL.LOW, {}, player_id, scene)
  local res = get_info(PLAYER, player_id, scene, true)
  player_log.call_api_sync_return(player_log_util.header(), TAG, "get_player_info_with_ignore_expire_time", player_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.get_player_info_with_expire(player_id, expire_time, scene)
  player_log.call_api(player_log_util.header(), TAG, "get_player_info_with_expire", player_log.LOG_LEVEL.LOW, {}, player_id, expire_time, scene)
  local res
  if scene then
    res = get_scene_info_with_expire(PLAYER, player_id, scene, expire_time)
  else
    res = get_info_with_expire(PLAYER, player_id, expire_time)
  end
  player_log.call_api_sync_return(player_log_util.header(), TAG, "get_player_info_with_expire", player_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.add_account_info(account_id, account_info)
  player_log.call_api(player_log_util.header(), TAG, "add_account_info", player_log.LOG_LEVEL.LOW, {}, account_id, account_info)
  add_info(ACCOUNT, account_id, account_info, nil, true)
end

function M.add_customer_info(account_id, customer_info)
  player_log.call_api(player_log_util.header(), TAG, "add_customer_info", player_log.LOG_LEVEL.LOW, {}, account_id, customer_info)
  add_info(CUSTOMER, account_id, customer_info, nil, true)
end

function M.add_user_info(user_id, user_info, type)
  player_log.call_api(player_log_util.header(), TAG, "add_user_info", player_log.LOG_LEVEL.LOW, {}, user_id, user_info)
  add_info(type, user_id, user_info, nil, true)
end

function M.update_account_info(account, new_account_info)
  player_log.call_api(player_log_util.header(), TAG, "update_account_info", player_log.LOG_LEVEL.LOW, {}, account, new_account_info)
  local res = update_info(ACCOUNT, account, new_account_info)
  player_log.call_api_sync_return(player_log_util.header(), TAG, "update_account_info", player_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.get_account_info(account)
  player_log.call_api(player_log_util.header(), TAG, "get_account_info", player_log.LOG_LEVEL.LOW, {}, account)
  local res = get_info(ACCOUNT, account)
  player_log.call_api_sync_return(player_log_util.header(), TAG, "get_account_info", player_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.get_account_info_with_ignore_expire_time(account)
  player_log.call_api(player_log_util.header(), TAG, "get_account_info", player_log.LOG_LEVEL.LOW, {}, account)
  local res = get_info(ACCOUNT, account, "default", true)
  player_log.call_api_sync_return(player_log_util.header(), TAG, "get_account_info", player_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.get_customer_info(account)
  player_log.call_api(player_log_util.header(), TAG, "get_customer_info", player_log.LOG_LEVEL.LOW, {}, account)
  local res = get_info(CUSTOMER, account)
  player_log.call_api_sync_return(player_log_util.header(), TAG, "get_customer_info", player_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.get_user_info(user_id, type)
  player_log.call_api(player_log_util.header(), TAG, "get_virtual_user_info", player_log.LOG_LEVEL.LOW, {}, user_id)
  local res = get_info(type, user_id)
  player_log.call_api_sync_return(player_log_util.header(), TAG, "get_virtual_user_info", player_log.LOG_LEVEL.LOW, {}, res)
  return res
end

function M.remove_player_info(player_id)
  player_log.call_api(player_log_util.header(), TAG, "remove_player_info", player_log.LOG_LEVEL.LOW, {}, player_id)
  remove_info(PLAYER, player_id)
end

function M.remove_account_info(account_id)
  player_log.call_api(player_log_util.header(), TAG, "remove_account_info", player_log.LOG_LEVEL.LOW, {}, account_id)
  remove_info(ACCOUNT, account_id)
end

function M.clear()
  player_log.call_api(player_log_util.header(), TAG, "clear", player_log.LOG_LEVEL.HIGH, {})
  player_cache = {}
  account_cache = {}
  customer_cache = {}
  virtual_cache = {}
  type_to_cache[PLAYER] = player_cache
  type_to_cache[ACCOUNT] = account_cache
  type_to_cache[CUSTOMER] = customer_cache
  type_to_cache[VIRTUAL] = virtual_cache
  scene_player_cache = {}
  scene_to_cache[PLAYER] = scene_player_cache
end

M.player_info_cache = player_cache

function M.set_expire_time(expire_time)
  player_log.call_api(player_log_util.header(), TAG, "set_expire_time", player_log.LOG_LEVEL.LOW, {}, expire_time)
  cache_expire_time = expire_time
end

function M.set_scene_expire_time(scene, expire_time)
  player_log.call_api(player_log_util.header(), TAG, "set_scene_expire_time", player_log.LOG_LEVEL.LOW, {}, scene, expire_time)
  scene_expire_time[scene] = expire_time
end

local version_miss_error_flag = false
local update_time_illegal_flag = false
local version_num_unknown_flag = false

local function report_update_time_error(error_type, player_info)
  if "version_miss" == error_type then
    if not version_miss_error_flag then
      version_miss_error_flag = true
      ESTAT.stat_error_with_limit("player_info", "version_miss_decode_update_time_error", "version_miss", "decode_update_time_error", {
        player_id = player_info.player_id,
        account_id = player_info.account_id
      })
    end
  elseif "update_time_illegal" == error_type then
    if not update_time_illegal_flag then
      update_time_illegal_flag = true
      ESTAT.stat_error_with_limit("player_info", "update_time_illegal_decode_update_time_error", "update_time_illegal", "decode_update_time_error", {
        player_id = player_info.player_id,
        account_id = player_info.account_id
      })
    end
  elseif "version_num_unknown" == error_type and not version_num_unknown_flag then
    version_num_unknown_flag = true
    ESTAT.stat_error_with_limit("player_info", "version_num_unknown_decode_update_time_error", "version_num_unknown", "decode_update_time_error", {
      player_id = player_info.player_id,
      account_id = player_info.account_id
    })
  end
end

function M.decode_update_time(player_info)
  if player_info.update_time then
    return
  end
  if not player_info.version then
    report_update_time_error("version_miss", player_info)
    return
  end
  local update_time_version = _ejoysdk_crypt.base64decode(player_info.version)
  local version_num = string_unpack("I1", update_time_version:sub(1, 1))
  if 1 == version_num then
    local random = string_unpack("I4", update_time_version:sub(2, 5))
    local rc4_key = _ejoysdk_crypt.rc4_key(tostring(random) .. "F2yhLxs2!35U$mSw")
    local rc4 = _ejoysdk_crypt.rc4_decrypt(update_time_version:sub(6), rc4_key)
    local update_time = string_unpack("I8", rc4)
    if update_time <= 0 then
      report_update_time_error("update_time_illegal", player_info)
    else
      player_info.update_time = update_time
    end
  else
    report_update_time_error("version_num_unknown", player_info)
  end
end

return M
