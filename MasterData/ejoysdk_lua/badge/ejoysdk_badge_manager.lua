local CHAT_SERVER = require("ejoysdk_lua.chat.ejoysdk_chat_server")
local DISPATCHER = require("ejoysdk_lua.chat.ejoysdk_chat_push_dispatcher")
local API = require("ejoysdk_lua.server_api.ejoysdk_badge")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local E = require("ejoysdk_lua.ejoysdk")
local ANNS = require("ejoysdk_lua.badge.ejoysdk_badge_anns")
local STATES = require("ejoysdk_lua.chat.ejoysdk_chat_states")
local CHAT = require("ejoysdk_lua.chat.ejoysdk_chat")
local BADGE_OP = require("ejoysdk_lua.badge.ejoysdk_badge_tree_op")
local CAST_UPDATE_BADGE = "UPDATE_BADGE_CONFIG"
local INTERVAL = 300
local TAG = "BADGE_SERVER#"
local M = {}
local SERVER_HANDLER = {}
local BADGE_CHANGE_CALLBACKS = {}
local badge_inited = false
local TICK_INTERVAL = 1

local function is_empty(str)
  return not str or "" == str
end

local meta_table = {
  __index = function(table, key)
    if is_empty(key) then
      return nil
    end
    local value = {}
    rawset(table, key, value)
    return value
  end
}
local app_tree_info = setmetatable({}, meta_table)
local app_update_interval = setmetatable({}, meta_table)

local function child_has_badge(root, direct_child)
  root = root or {}
  if root.children then
    for _, child in ipairs((root or {}).children or {}) do
      if child.is_activated == true then
        return true
      end
      if not direct_child and child.ref_tree_info and child.ref_tree_info.children then
        return child_has_badge(child.ref_tree_info)
      end
    end
  elseif root.ref_tree_info then
    do return child_has_badge end
    return child_has_badge, root.ref_tree_info, ipairs((root or {}).children or {})
  end
  return false
end

local function notify()
  local app_tree_info_list = {}
  for _app_id, app_info in pairs(app_tree_info) do
    app_tree_info_list[_app_id] = {}
    for _tree_id, tree_info in pairs(app_info) do
      tree_info.is_activated = child_has_badge(tree_info.tree_info)
      app_tree_info_list[_app_id][_tree_id] = tree_info
    end
  end
  if E.Sysinfo.os() == "ios" then
    if _ejoysdk.update_badge_config then
      local app_tree_info_str = JSON.encode(app_tree_info_list)
      _ejoysdk.update_badge_config(app_tree_info_str)
    end
  elseif E.Sysinfo.os() == "android" then
    E.invoke(CAST_UPDATE_BADGE, app_tree_info_list)
  end
end

local function has_player_info()
  local player_info = EG.player_info()
  return player_info and player_info.player_id
end

local function get_notice_tree(app_id, ann_type)
  ANNS.init()
  ANNS.subscribe(ann_type, function(notice_tree_info)
    notice_tree_info = notice_tree_info or {}
    notice_tree_info.app_id = app_id
    notice_tree_info.tree_id = ann_type
    app_tree_info[app_id][ann_type] = notice_tree_info
    notify()
  end)
end

local function update_badge_tree(app_info)
  local app_id = app_info.app_id
  local tree_id = app_info.tree_id
  local interval = app_info.cache_ttl or INTERVAL
  app_tree_info[app_id][tree_id] = app_info
  app_update_interval[app_id] = interval
  notify()
end

local function local_consume(app_id, tree_id, node_id)
  if is_empty(app_id) or is_empty(tree_id) or is_empty(node_id) then
    return
  end
  local app_info = app_tree_info[app_id]
  if not app_info then
    E.LOG.debug(TAG, "consume failed: app_info cache not found")
    return
  end
  local tree_info = app_info[tree_id]
  local has_find = false
  if tree_info then
    E.LOG.debug(TAG, "consume root tree")
    has_find = BADGE_OP.deactivate(tree_info.tree_info, node_id)
  end
  E.LOG.debug(TAG, "consume ref tree")
  for _, tree_item_info in pairs(app_info) do
    local all_ref_tree_record = BADGE_OP.find_all(tree_item_info.tree_info, tree_id, BADGE_OP.ID_TYPE.REF_TREE)
    if all_ref_tree_record and next(all_ref_tree_record) then
      for _, ref_tree_record in pairs(all_ref_tree_record) do
        if ref_tree_record and next(ref_tree_record) then
          local ref_tree_node = (ref_tree_record[1] or {}).ref_tree_info
          local find_node_in_ref_tree = BADGE_OP.deactivate(ref_tree_node, node_id, nil, ref_tree_record)
          if find_node_in_ref_tree then
            has_find = true
          end
        end
      end
    end
  end
  if has_find then
    notify()
  else
    E.LOG.debug(TAG, "consume failed: tree_info cache not found")
  end
end

local function get_tree(app_id, tree_id)
  API.get_badge_tree(app_id, tree_id, function(succ, ...)
    if succ then
      local _tree_info, app_info = ...
      update_badge_tree(app_info)
    else
      local code, msg = ...
      E.LOG.debug(TAG, "request badge failed, code: " .. code .. ",msg: " .. msg)
    end
    E.Timer.once(app_update_interval[app_id], function()
      get_tree(app_id, tree_id)
    end)
  end)
end

local function refresh_query()
  local query_list = {}
  for app_id, app_info in pairs(app_tree_info) do
    for tree_id, _tree_info in pairs(app_info) do
      local app_tree = {app_id = app_id, tree_id = tree_id}
      table.insert(query_list, app_tree)
    end
  end
  if next(query_list) then
    M.batch_get_tree(query_list)
  end
end

function M.get_badge_tree(app_id, tree_id, cb)
  if not app_tree_info[app_id] then
    cb(false)
  end
  local app_tree = app_tree_info[app_id][tree_id]
  if app_tree and app_tree.tree_id and tree_id == app_tree.tree_id then
    local tree_info = JSON.encode(app_tree.tree_info)
    cb(true, tree_info)
    return
  end
  cb(false)
end

function M.batch_get_tree(batch_query, cb)
  cb = cb or function()
  end
  for i, query in ipairs(batch_query) do
    if query.app_id == ANNS.APP.announcement then
      get_notice_tree(query.app_id, query.ann_type)
      table.remove(batch_query, i)
      break
    end
  end
  if not has_player_info() then
    cb(false, -1, "no login")
    return
  end
  API.batch_get_tree(batch_query, function(succ, ...)
    if succ then
      local tree_info = (...)
      for _, app_tree in ipairs(tree_info) do
        local app_id = app_tree.app_id
        local tree_id = app_tree.tree_id
        local is_new = nil == app_tree_info[app_id][tree_id]
        local interval = app_tree.cache_ttl or INTERVAL
        update_badge_tree(app_tree)
        if is_new then
          E.Timer.once(interval, function()
            get_tree(app_id, tree_id)
          end)
        end
      end
      E.LOG.debug(TAG, {batch_badge_req = app_tree_info})
    else
      local code, msg = ...
      E.LOG.debug(TAG, "batch request badge failed, code: " .. code .. ",msg: " .. (msg or "nil"))
    end
    cb(succ, ...)
  end)
end

function M.consume(app_id, tree_id, node_id, cb)
  if app_id == ANNS.APP.announcement then
    local ret = ANNS.consume(tree_id, node_id)
    if cb then
      cb(ret)
    end
    return
  end
  if is_empty(app_id) or is_empty(tree_id) or is_empty(node_id) then
    return
  end
  local_consume(app_id, tree_id, node_id)
  API.report_visit_node(app_id, tree_id, {node_id}, function(succ, ...)
    if cb then
      cb(succ, ...)
    end
  end)
end

function SERVER_HANDLER.HANDLERS(header, msg)
  if header and header.destination == CHAT_SERVER.DESTINATION.BADGE and msg and msg.event == "badge_change" and next(msg.event_msg) then
    E.LOG.d(TAG, "receive push, update badge")
    local app_info = msg.event_msg
    update_badge_tree(app_info)
    local app_id = app_info.app_id
    local tree_id = app_info.tree_id
    if app_id and tree_id and BADGE_CHANGE_CALLBACKS[app_id] and BADGE_CHANGE_CALLBACKS[app_id][tree_id] then
      local badge_change_callback = BADGE_CHANGE_CALLBACKS[app_id][tree_id]
      badge_change_callback(app_info)
    end
  end
end

function M.subscribe_badge_change(tree_info, callback)
  local app_id = tree_info.app_id
  local tree_id = tree_info.tree_id
  if not app_id or not tree_id then
    E.LOG.d(TAG, "[subscribe_badge_change] please specify app_id and tree_id, example: { app_id = \"ieu/a\", tree_id = \"ieu/b\" }")
    return
  end
  if type(callback) ~= "function" then
    E.LOG.d(TAG, "[subscribe_badge_change] you must subscribe a function, not " .. type(callback))
    return
  end
  if not BADGE_CHANGE_CALLBACKS[app_id] then
    BADGE_CHANGE_CALLBACKS[app_id] = {}
  end
  if BADGE_CHANGE_CALLBACKS[app_id][tree_id] then
    E.LOG.d(TAG, "[subscribe_badge_change] the app_info has been subscribed")
    return
  end
  BADGE_CHANGE_CALLBACKS[app_id][tree_id] = callback
end

function M.unsubscribe_badge_change(tree_info)
  local app_id = tree_info.app_id
  local tree_id = tree_info.tree_id
  if not app_id or not tree_id then
    E.LOG.d(TAG, "[unsubscribe_badge_change] please specify app_id and tree_id, example: { app_id = \"ieu/a\", tree_id = \"ieu/b\" }")
    return
  end
  if not BADGE_CHANGE_CALLBACKS[app_id] or not BADGE_CHANGE_CALLBACKS[app_id][tree_id] then
    E.LOG.d(TAG, "[unsubscribe_badge_change] you haven't subscribe this app_info")
    return
  end
  BADGE_CHANGE_CALLBACKS[app_id][tree_id] = nil
end

local BADGE_MGR_CALL = "BADGE_MGR_CALL"
local BADGE_MGR_CALL_CONSUME = 1
_ejoysdk.register_cb(BADGE_MGR_CALL, function(cbid, js_str)
  E.LOG.debug(TAG, "badge manager event: " .. tostring(cbid))
  if cbid == BADGE_MGR_CALL_CONSUME then
    local result = JSON.decode(js_str)
    if result and result.app_id and result.tree_id and result.node_id then
      M.consume(result.app_id, result.tree_id, result.node_id, nil)
    end
  end
end)
local init_tick = false

local function logout_handler()
  for key, _ in pairs(app_tree_info) do
    if key ~= ANNS.APP.announcement then
      app_tree_info[key] = {}
      app_update_interval[key] = {}
    end
  end
  notify()
end

function M.init()
  if badge_inited then
    E.LOG.d(TAG, "badge has init, could not init again, now return")
    return
  end
  badge_inited = true
  ET.subscribe(ET.gangplank.INITED, function()
  end)
  ET.subscribe(ET.gangplank.ACQUIRE, function()
    notify()
  end)
  ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
  ET.subscribe(ET.gangplank.PLAYER_OFFLINE, logout_handler)
  ET.subscribe(ET.gangplank.PLAYER_ONLINE, function(_player_info)
    E.LOG.debug(TAG, "badge get player token succ")
    if not init_tick then
      init_tick = true
      local ticker
      
      function ticker()
        if CHAT.has_tick() then
          return
        end
        CHAT_SERVER.tick()
        E.Timer.once(TICK_INTERVAL, ticker)
      end
      
      E.Timer.once(TICK_INTERVAL, ticker)
    end
  end)
  ET.subscribe(ET.chat.UPDATE_STATE, function(state, login_result_params)
    if state == STATES.LOGIN_SUCC then
      E.LOG.d(TAG, "chat update state succ")
      if login_result_params and login_result_params.destination == "chat" and 2 ~= login_result_params.chat_version then
        refresh_query()
        local ECA = require("ejoysdk_lua.chat.ejoysdk_chat_account")
        ECA.open(true)
      end
    end
  end)
  E.LOG.d(TAG, "real_init >>")
  CHAT.real_init()
  BADGE_CHANGE_CALLBACKS = {}
  DISPATCHER.register_chat_handlers(CHAT_SERVER.DESTINATION.BADGE, SERVER_HANDLER.HANDLERS)
  DISPATCHER.register_server_handlers(SERVER_HANDLER)
end

return M
