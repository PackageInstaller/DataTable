local E = require("ejoysdk_lua.ejoysdk")
local COMPAT = require("ejoysdk_lua.compat.ejoysdk_compat")
local BASE_API = require("ejoysdk_lua.libs.base_api")
local LAUNCHER_API = BASE_API:New("launcher_anns")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "ejoysdk_anns"
local EC = require("ejoysdk_lua.ejoysdk_config")
local EI = require("ejoysdk_lua.ejoysdk_init")
local UTIL = require("ejoysdk_lua.ejoysdk_utils")
local M = {}
local ANNS_REQUEST_INTERVAL = 30
local ANNS_REQUEST_TIMEOUT = 30
M.TYPE = {COMMON = "common", CUSTOM = "custom"}
M.POPUP_CONDITION = {ALWAYS = "always", UNREAD = "unread"}
M.TRIGGER_TYPE = {
  ON_UPDATE = "on_update",
  BEFORE_LOGIN = "before_account_login",
  AFTER_LOGIN = "before_player_login",
  IN_GAME = "in_game",
  CUSTOM = "custom"
}
M.MARK_AS_READ_TRIGGER = {ON_SHOW = "on_show", ON_PULL = "on_pull"}
M.OFFICIAL_TAGS = {
  TRIGGER_TYPE = "trigger_type",
  SERVER = "server",
  CHANNEL = "channel",
  AREA = "area",
  OS = "os"
}
M.POPUP_TRIGGER = {DEFAULT = "default", CUSTOM = "custom"}
local BADGE_ANNS_READ_V2 = "EJOYSDK_BADGE_ANNS_READ_V2.json"
local ANNS_CACHE_MODEL = "EJOYSDK_ANNS_CACHE_MODEL.json"
local ann_data_map = {
  ann_version = 0,
  tpl_version = 0,
  version_id = "",
  anns = {},
  templates = {},
  env = {},
  product = E.CONFIG.get_config("product") or ""
}
local badge_anns_map = {}
local _block_callback
local _filter = {}
local _filter_change = false

local function reset_ann_data_map()
  E.LOG.d(TAG, "reset_ann_data_map")
  ann_data_map = {
    ann_version = 0,
    tpl_version = 0,
    version_id = "",
    anns = {},
    templates = {},
    env = {},
    product = E.CONFIG.get_config("product") or ""
  }
  badge_anns_map = {}
  E.File.writefile(ANNS_CACHE_MODEL, JSON.encode(UTIL.deepcopy(ann_data_map)))
  E.File.writefile(BADGE_ANNS_READ_V2, JSON.encode(UTIL.deepcopy(badge_anns_map)))
end

local function update_announcements(add_anns)
  if not add_anns then
    return
  end
  for _, add_ann in pairs(add_anns) do
    local key = tostring(add_ann.id)
    ann_data_map.anns[key] = add_ann
    local badge_ann_key = tostring(add_ann.template_id) .. ":" .. tostring(add_ann.id)
    if badge_anns_map[badge_ann_key] and badge_anns_map[badge_ann_key] ~= add_ann.c_version then
      badge_anns_map[badge_ann_key] = nil
    end
    local badge_template_key = tostring(add_ann.template_id)
    badge_anns_map[badge_template_key] = nil
  end
end

local function update_blocking()
  for _, template in pairs(ann_data_map.templates) do
    template.is_block = false
  end
  for _, ann in pairs(ann_data_map.anns) do
    if ann_data_map.templates[ann.template_id] and (ann.attr_info or {}).is_block then
      ann_data_map.templates[ann.template_id].is_block = true
    end
  end
end

local function remove_announcements(remove_anns)
  if not remove_anns then
    return
  end
  for _, key in pairs(remove_anns) do
    ann_data_map.anns[key] = nil
    badge_anns_map[key] = nil
  end
end

local function remove_templates(templates)
  if not templates or next(templates) == nil then
    return
  end
  for _, tpl_id in pairs(templates) do
    ann_data_map.templates[tpl_id] = nil
  end
end

local function update_templates(templates)
  if not templates or next(templates) == nil then
    return
  end
  for _, template in pairs(templates) do
    ann_data_map.templates[template.id] = template
  end
end

local function handle_server_response(server_data, _env, progress_cb)
  if not server_data then
    return
  end
  if ann_data_map.version_id ~= "" and server_data.version_id ~= ann_data_map.version_id then
    E.LOG.w(TAG, "announcement version reset, local: " .. tostring(ann_data_map.version_id) .. ", server: " .. tostring(server_data.version_id))
    reset_ann_data_map()
    progress_cb(false)
    return
  end
  if ann_data_map.tpl_version <= server_data.version.tpl_version or ann_data_map.ann_version <= server_data.version.ann_version then
    E.LOG.d(TAG, "update server_data")
    ann_data_map.version_id = server_data.version_id
    ann_data_map.ann_version = server_data.version.ann_version
    ann_data_map.tpl_version = server_data.version.tpl_version
    ann_data_map.env = _env
    ann_data_map.product = E.CONFIG.get_config("product") or ""
    remove_templates(server_data.remove_templates)
    update_templates(server_data.templates)
    remove_announcements(server_data.remove_anns)
    update_announcements(server_data.add_anns)
    update_blocking()
    E.File.writefile(ANNS_CACHE_MODEL, JSON.encode(UTIL.deepcopy(ann_data_map)))
    E.File.writefile(BADGE_ANNS_READ_V2, JSON.encode(UTIL.deepcopy(badge_anns_map)))
    progress_cb(true)
  else
    E.LOG.d(TAG, "announcement version reset, local: " .. tostring(ann_data_map.version) .. ", server: " .. tostring(server_data.version))
    progress_cb(false)
  end
end

function M.http_request_anns_data(_filters, _env, _version, cb)
  if nil == _version or nil == _version.ann_version or nil == _version.tpl_version then
    _version = {ann_version = 0, tpl_version = 0}
  end
  local _ann_ids = {}
  local _template_ids = {}
  for _, va in pairs(ann_data_map.anns) do
    table.insert(_ann_ids, va.id)
  end
  for _, va in pairs(ann_data_map.templates) do
    table.insert(_template_ids, va.id)
  end
  if not _ann_ids or not next(_ann_ids) then
    _ann_ids = JSON.newArray()
  end
  if not _template_ids or not next(_template_ids) then
    _template_ids = JSON.newArray()
  end
  local body = {
    filter = _filters,
    is_filter_change = _filter_change,
    env = _env,
    ann_version = _version.ann_version,
    tpl_version = _version.tpl_version,
    ann_ids = _ann_ids,
    template_ids = _template_ids,
    version_id = ann_data_map.version_id or ""
  }
  E.LOG.d(TAG, {request_body = body})
  local opt = {}
  LAUNCHER_API:post("/ann/v2/get_anns", {timeout = ANNS_REQUEST_TIMEOUT}, body, opt, function(succ, ...)
    if succ then
      _filter_change = false
      local resp = (...)
      if resp and resp.data then
        resp.data.version_id = resp.version_id
        resp.data.version = {
          ann_version = resp.ann_version or 0,
          tpl_version = resp.tpl_version or 0
        }
        handle_server_response(resp.data, _env, function(succ1)
          if succ1 then
            if cb then
              E.LOG.d(TAG, {
                resp_data = resp and resp.data
              })
              cb(true, resp and resp.data)
            end
          else
            M.http_request_anns_data(_filters, _env, nil, cb)
          end
        end)
      end
    elseif cb then
      cb(false, ...)
    end
  end)
end

function M.request_anns_data(cb)
  E.LOG.d(TAG, "request_anns_data")
  local lang = EC.get_config("lang")
  local publish_area = EC.get_config(E.CONFIG.KEY.PUBLISH_AREA)
  local server_domain = EC.get_config(E.CONFIG.KEY.SERVER_DOMAIN)
  local version = {
    ann_version = ann_data_map.ann_version or 0,
    tpl_version = ann_data_map.tpl_version or 0
  }
  if ann_data_map.env.lang ~= "" and lang ~= ann_data_map.env.lang or publish_area ~= ann_data_map.env.publish_area or server_domain ~= ann_data_map.env.server_domain or E.CONFIG.get_config("product") ~= ann_data_map.product then
    E.LOG.debug(TAG, "env changed, reset ann data")
    reset_ann_data_map()
  end
  local env = {
    lang = lang,
    server_domain = server_domain,
    publish_area = publish_area
  }
  M.http_request_anns_data(_filter, env, version, cb)
end

local trigger_request_timer

function trigger_request_timer()
  M.request_anns_data(function(_succ)
  end)
  E.Timer.once(ANNS_REQUEST_INTERVAL, function(...)
    trigger_request_timer()
  end)
end

local function open_common_anns_webview(ann_result, close_callback)
  local template_data = ann_result and ann_result.template
  local url = template_data and template_data.raven_page_url
  if not UTIL.STR.is_empty(url) then
    local host = E.HTTP.parse(url).host
    E.LOG.debug(TAG, "anns url: " .. tostring(url))
    E.WebView.open(url, {
      [host] = {
        startupData = {
          template_id = template_data.id
        },
        transparent = true
      }
    }, {
      compactMode = true,
      use_fragment = true,
      hide_close_btn = true,
      use_cutout = true
    }, nil, function(_value)
      if close_callback then
        close_callback(true, ann_result)
      end
    end)
  else
    E.LOG.w(TAG, "anns url is nil!")
    if close_callback then
      close_callback(false, ann_result, -1, "anns url is nil!")
    end
  end
end

local function get_anns_from_local(template_id)
  local template = ann_data_map.templates[template_id]
  local sort_top_anns = {}
  local sort_anns = {}
  
  local function insert_pos(container, ann)
    local index = 1
    local order_time = ann.attr_info and ann.attr_info.order or 0
    local create_time = ann.create_time
    for _, v_ann in pairs(container) do
      if order_time > (v_ann.attr_info and v_ann.attr_info.order or 0) then
        table.insert(container, index, ann)
        return
      elseif 0 == order_time and 0 == (v_ann.attr_info and v_ann.attr_info.order or 0) and create_time >= v_ann.create_time then
        table.insert(container, index, ann)
        return
      end
      index = index + 1
    end
    table.insert(container, ann)
  end
  
  for _, v_ann in pairs(ann_data_map.anns) do
    if v_ann.template_id == template_id then
      local badge_ann_key = tostring(v_ann.template_id) .. ":" .. tostring(v_ann.id)
      if nil ~= badge_anns_map[badge_ann_key] then
        v_ann._sdk_has_read = true
      else
        v_ann._sdk_has_read = false
      end
      if v_ann.attr_info.badge == "top" then
        insert_pos(sort_top_anns, v_ann)
      else
        insert_pos(sort_anns, v_ann)
      end
    end
  end
  COMPAT.table_move(sort_anns, 1, #sort_anns, #sort_top_anns + 1, sort_top_anns)
  E.LOG.d(TAG, {anns_list = sort_top_anns})
  return {template = template, anns = sort_top_anns}
end

function M.sdk_show_announcement_ifneeded(cur_state, close_callback)
  M.actual_show_announcement_ifneeded(cur_state, close_callback)
end

function M.actual_show_announcement_ifneeded(cur_state, close_callback, _call_module)
  E.LOG.debug(TAG, "inner sdk_show_announcement_ifneeded, state:" .. (cur_state or "") .. " _call_module:" .. tostring(_call_module))
  for _, v_template in pairs(ann_data_map.templates) do
    local show_tpl_data
    local ignore_sdk_show = false
    if _call_module and v_template.type == M.TYPE.COMMON and v_template.show_config and v_template.show_config.trigger_type and v_template.show_config.trigger_type ~= M.TRIGGER_TYPE.CUSTOM and v_template.show_config.popup_trigger == M.POPUP_TRIGGER.CUSTOM then
      ignore_sdk_show = true
      E.LOG.debug(TAG, "inner sdk_show_announcement_ifneeded, state:" .. (cur_state or "") .. " ignore_sdk_show:" .. tostring(ignore_sdk_show) .. ", id:" .. tostring(v_template.id))
    end
    if v_template.type == M.TYPE.COMMON and v_template.show_config and v_template.show_config.trigger_type == cur_state and not ignore_sdk_show then
      if v_template.show_config.popup_condition == M.POPUP_CONDITION.ALWAYS then
        show_tpl_data = v_template
      elseif v_template.show_config.popup_condition == M.POPUP_CONDITION.UNREAD then
        for _, v_ann in pairs(ann_data_map.anns) do
          if v_ann.template_id == v_template.id then
            local badge_ann_key = tostring(v_ann.template_id) .. ":" .. tostring(v_ann.id)
            if not badge_anns_map[badge_ann_key] then
              show_tpl_data = v_template
              break
            end
          end
        end
      end
    end
    if show_tpl_data then
      local ann_result = get_anns_from_local(show_tpl_data.id)
      if ann_result and ann_result.anns and next(ann_result.anns) then
        E.LOG.d(TAG, {ann_result = ann_result})
        open_common_anns_webview(ann_result, close_callback)
      else
        E.LOG.d(TAG, "anns list empty")
      end
    end
  end
end

function M.show_announcement(template_id, close_callback)
  local ann_result = get_anns_from_local(template_id)
  if ann_result.template == nil then
    return false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_NOT_DATA, "the data for this template id cannot be found"
  end
  open_common_anns_webview(ann_result, close_callback)
  return true
end

function M.show_in_game_announcement(close_callback)
  M.sdk_show_announcement_ifneeded(M.TRIGGER_TYPE.IN_GAME, close_callback)
end

function M.get_announcement_data(template_id, is_sync_server, cb)
  if true == is_sync_server then
    M.request_anns_data(function()
      local ann_result = get_anns_from_local(template_id)
      cb(true, UTIL.deepcopy(ann_result))
    end)
  else
    local ann_result = get_anns_from_local(template_id)
    cb(true, UTIL.deepcopy(ann_result))
  end
end

function M.get_all_announcement_data()
  do return UTIL.deepcopy end
  return UTIL.deepcopy, ann_data_map
end

function M.consume(template_id, ann_id, cb)
  cb = cb or function()
  end
  if not (template_id and ann_id) or not ann_data_map.anns[ann_id] then
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "template_id or ann_id is nil")
    return
  end
  local badge_ann_key = tostring(template_id) .. ":" .. tostring(ann_id)
  badge_anns_map[badge_ann_key] = ann_data_map.anns[ann_id].c_version
  E.File.writefile(BADGE_ANNS_READ_V2, JSON.encode(badge_anns_map))
  cb(true)
end

local function update_filter(_custom_filter)
  _custom_filter = _custom_filter or {}
  local channel = {}
  local sub_channel = {}
  if not UTIL.STR.is_empty(E.get_pkg_info().ds_sub_channel_id) then
    sub_channel[E.get_pkg_info().ds_sub_channel_id] = {}
  end
  if not UTIL.STR.is_empty(E.get_pkg_info().channel_id) then
    channel[E.get_pkg_info().channel_id] = sub_channel
  end
  local default_filter = {
    tags = {
      o_os = {
        [_ejoysdk.os()] = {}
      },
      o_channel = channel
    }
  }
  if not UTIL.STR.is_empty(E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)) then
    default_filter.tags.o_area = {
      [E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)] = {}
    }
  end
  local custom_tags = _custom_filter.tags or {}
  local new_tags_list = {}
  for key, value in pairs(custom_tags) do
    if not E.Utils.start_with(key, "o_") or not E.Utils.start_with(key, "u_") then
      local prefix = "u_"
      if M.OFFICIAL_TAGS[string.upper(key)] then
        prefix = "o_"
      end
      new_tags_list[prefix .. key] = value
    else
      new_tags_list[key] = value
    end
  end
  _custom_filter.tags = new_tags_list
  _filter = UTIL.merge_table(default_filter, _custom_filter)
  _filter_change = true
end

function M.set_filter(_custom_filter, _cb)
  update_filter(_custom_filter)
  M.request_anns_data(_cb)
end

local function init_handler()
  M.actual_show_announcement_ifneeded(M.TRIGGER_TYPE.BEFORE_LOGIN, _block_callback, "init")
end

local function login_handler(_user_info)
  M.actual_show_announcement_ifneeded(M.TRIGGER_TYPE.AFTER_LOGIN, _block_callback, "login")
end

local function set_player_info_handler(_player_info, _type)
  M.actual_show_announcement_ifneeded(M.TRIGGER_TYPE.IN_GAME, _block_callback, "game")
end

local function res_update_handler(_status)
  local res_config = require("ejoysdk_lua.res.startup.startup_res_config")
  if _status == res_config.PUB_STARTUP_STATES.STARTUP_RES_DOWNLOADING then
    E.LOG.d(TAG, "有更新，显示热更")
    M.actual_show_announcement_ifneeded(M.TRIGGER_TYPE.ON_UPDATE, _block_callback, "update")
  end
end

local inited = false

function M.init(_opt)
  E.LOG.d(TAG, "anns init")
  local current_product_code = E.CONFIG.get_config("product")
  if nil == current_product_code then
    E.LOG.d(TAG, "product code is nil")
    return
  end
  if inited then
    return
  end
  inited = true
  badge_anns_map = JSON.decode(E.File.readfile(BADGE_ANNS_READ_V2) or "{}") or {}
  ann_data_map = JSON.decode(E.File.readfile(ANNS_CACHE_MODEL) or "") or ann_data_map
  _opt = _opt or {}
  if _opt.block_callback then
    function _block_callback(succ, ann_result)
      E.LOG.d(TAG, "block callback")
      
      if (ann_result or {}).template or {}.is_block == true then
        _opt.block_callback(succ, ann_result)
      end
    end
  end
  update_filter(_opt.filter or {})
  ET.subscribe(ET.gangplank.INITED, init_handler)
  ET.subscribe(ET.qz_startup_update.QZ_STARTUP_UPDATE_STATE_CHANGED, res_update_handler)
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO_WITH_TYPE, set_player_info_handler)
  trigger_request_timer()
  ET.publish(EI.SUBSCRIBE_ANNOUNCEMENT_INITED, true)
end

return M
