local E = require("ejoysdk_lua.ejoysdk")
local LAUNCHER = require("ejoysdk_lua.ejoysdk_launcher")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local TAG = "ejoysdk_badge_anns#"
local INTERVAL = 300
local M = {}
local inited = false
local hash_map = {}
local loop = {}
local subscribers = {}
local running = false
local badge_anns = {}
local BADGE_ANNS_READ = E.LazyKeyStore:New("EJOYSDK_BADGE_ANNS_READ", false, true, false)
M.APP = {
  announcement = "platform/announcement"
}
M.TYPE = {LOGIN = "login", GAMEBOX = "login"}

local function is_empty(str)
  return not str or "" == str
end

local function get_key(ann_type, uuid)
  return (ann_type or "") .. "_" .. (uuid or "")
end

local function build_tree(appid, ann_type, anns_info)
  local app_tree_info = {
    app_id = appid,
    tree_id = ann_type,
    cache_ttl = INTERVAL,
    tree_info = {
      children = {}
    }
  }
  local is_tree_activated = false
  for _, node_info in pairs(anns_info) do
    local child = {
      node_id = node_info.uuid,
      is_activated = not node_info.has_read
    }
    table.insert(app_tree_info.tree_info.children, child)
    is_tree_activated = is_tree_activated or child.is_activated
  end
  app_tree_info.tree_info.is_activated = is_tree_activated
  return app_tree_info
end

local function publish(ann_type)
  if not next(subscribers) then
    return
  end
  local badge_data = M.get_notice_badge(ann_type)
  local app_tree_info = build_tree(M.APP.announcement, ann_type, badge_data)
  for type, subscribe in pairs(subscribers) do
    if type == ann_type then
      subscribe(app_tree_info)
      break
    end
  end
end

local function fetch_badge(ann_type, tags, server, cb)
  LAUNCHER.ticket_detail(ann_type, tags, server, function(succ, body_str, _ticket, hash)
    local data = hash_map[ann_type] or {}
    cb = cb or function()
    end
    if succ and data.hash ~= hash then
      E.LOG.debug(TAG, "auto get anns : has updates")
      local body_data = JSON.safe_decode(body_str)
      local anns = (body_data or {}).anns or {}
      local cache_notices = data.body or {}
      local uuids = {}
      local has_new = false
      for _, ann in pairs(anns) do
        local new_uuid = ann._uuid
        local cache_notice = cache_notices[new_uuid] or {}
        local badge_switch = (ann or {})._badge_config or {}.is_open
        if nil == badge_switch then
          badge_switch = true
        end
        local has_read = cache_notice.has_read or badge_anns[get_key(ann_type, new_uuid)] or not badge_switch
        local notice = {uuid = new_uuid, has_read = has_read}
        if not next(cache_notice) and not has_read then
          has_new = true
          notice.has_read = false
        end
        uuids[new_uuid] = notice
      end
      hash_map[ann_type] = {hash = hash, body = uuids}
      if has_new then
        publish(ann_type)
      end
    else
      E.LOG.debug(TAG, "auto get anns : no updates")
    end
    cb(hash_map[ann_type])
  end)
end

local function fetch_launcher(ann_type, _subscribe)
  if is_empty(ann_type) or true == loop[ann_type] then
    return
  end
  hash_map[ann_type] = hash_map[ann_type] or {}
  local handler
  
  function handler()
    if running then
      loop[ann_type] = true
      fetch_badge(ann_type, nil, nil, function(_badge_data)
        E.Timer.once(INTERVAL, handler)
      end)
    else
      loop[ann_type] = false
    end
  end
  
  handler()
end

local function startTimer()
  if not next(subscribers) or running then
    return
  end
  running = true
  for type, subscribe in pairs(subscribers) do
    fetch_launcher(type, subscribe)
  end
end

local function stopTimer()
  if next(subscribers) or not running then
    return
  end
  loop = {}
  running = false
end

function M.get_notice_badge(ann_type)
  if is_empty(ann_type) then
    return {}
  end
  return (hash_map[ann_type] or {}).body or {}
end

function M.get_notice_badge_tree_imm(ann_type, tags, server, cb)
  cb = cb or function()
  end
  if is_empty(ann_type) then
    cb({})
    return
  end
  fetch_badge(ann_type, tags, server, function(_badge_data)
    local badge_data = M.get_notice_badge(ann_type)
    local app_tree_info = build_tree(M.APP.announcement, ann_type, badge_data)
    cb(app_tree_info)
  end)
end

function M.has_unread_notice(ann_type, tags, server, cb)
  M.get_notice_badge_tree_imm(ann_type, tags, server, function(badge_tree_data)
    cb = cb or function()
    end
    if badge_tree_data and badge_tree_data.tree_info then
      cb(badge_tree_data.tree_info.is_activated)
      return
    end
    cb(false)
  end)
end

function M.consume(ann_type, uuid)
  if is_empty(ann_type) or is_empty(uuid) then
    return false
  end
  local key = get_key(ann_type, uuid)
  local type_body = (hash_map[ann_type] or {}).body or {}
  ;(type_body[uuid] or {}).has_read = true
  badge_anns[key] = true
  BADGE_ANNS_READ:set(badge_anns)
  publish(ann_type)
  return true
end

function M.init()
  if inited then
    return
  end
  badge_anns = BADGE_ANNS_READ:get() or {}
  inited = true
end

function M.subscribe(ann_type, handler)
  if is_empty(ann_type) then
    return
  end
  M.unsubscribe(ann_type)
  subscribers[ann_type] = handler
  if not running then
    startTimer()
  else
    fetch_launcher(ann_type, handler)
  end
end

function M.unsubscribe(ann_type)
  if is_empty(ann_type) then
    return
  end
  subscribers[ann_type] = nil
  if not next(subscribers) then
    stopTimer()
  end
end

function M.clear_badge()
  for key, _ in pairs(badge_anns) do
    badge_anns[key] = false
    BADGE_ANNS_READ:delete(key)
  end
end

return M
