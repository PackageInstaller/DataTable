local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local DEFAULT_EXPIRE_TIME = 300
local tree_cache = {}
local M = {}
local TAG = EM.MODULE.BADGE .. "tree_cache"

function M.cal_key(app_id, tree_id)
  local key = app_id .. "/" .. tree_id
  return key
end

function M.add_badge_tree(app_id, tree_id, tree_info, deactivate_mode, src_cache_ttl)
  local cache_key = M.cal_key(app_id, tree_id)
  tree_cache[cache_key] = nil
  local now = os.time()
  local cache_ttl = src_cache_ttl or DEFAULT_EXPIRE_TIME
  local new_entity = {
    tree_info = tree_info,
    deactivate_mode = deactivate_mode,
    create_ts = now,
    cache_ttl = cache_ttl
  }
  tree_cache[cache_key] = new_entity
  E.LOG.debug(TAG, "badge: 新增/刷新缓存，key: " .. tostring(cache_key) .. ", 缓存时长(分钟): " .. tostring(cache_ttl))
end

function M.get_cache_tree(app_id, tree_id)
  local cache_key = M.cal_key(app_id, tree_id)
  local entity = tree_cache[cache_key]
  if entity then
    local now = os.time()
    local diff = now - entity.create_ts
    if diff > entity.cache_ttl then
      tree_cache[cache_key] = nil
      entity = nil
      E.LOG.debug(TAG, "badge: key: " .. tostring(cache_key) .. " 存在缓存, 但已过期, 清除该缓存")
    end
  end
  return entity
end

return M
