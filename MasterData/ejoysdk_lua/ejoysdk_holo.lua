local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local ER = require("ejoysdk_lua.ejoysdk_resource")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local token_adapter = require("ejoysdk_lua.ejoysdk_token_adapter")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local EC = require("ejoysdk_lua.ejoysdk_config")
local M = {}
M.HOLO_TOPIC = "holo"
M.GENDER_UNKNOWN = 0
M.GENDER_MALE = 1
M.GENDER_FAMALE = 2
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "holo"
local inited = false
local info_cache
local url_items = {
  info = "user/info",
  user_infos = "user/user_infos",
  login_token = "user/login_token",
  location = "user/info/location",
  login_cb = "login_cb",
  set_avatar = "user/info/photo/show/avatar",
  transform = "audio/client/transform",
  transform_v2 = "audio/client/v2/transform",
  audiometa = "audio/client/text",
  get_player_token = "player_token/get_player_token",
  get_s_word_list_id = "sensitive_words/get_s_word_list_id",
  get_s_word_list = "sensitive_words/get_s_word_list",
  submit_record = "customer_service/submit_record",
  translate = "api/translate",
  device_score = "device_score/evaluate",
  bind_discord = "discord/bind_init",
  query_discord_player_bind = "discord/query_player_bind"
}

local function get_product_code()
  local product = E.CONFIG.get_config("product")
  product = product and product:lower()
  return product or ""
end

M._get_product_code = get_product_code

local function request_params()
  local token = EG.user_info().token
  return {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["Ejoy-Token"] = token
    }
  }
end

local function request_moment_token_params()
  local player_token = M.get_player_token()
  return {
    acceptable = E.HTTP.CT_JSON,
    headers = {
      ["moment-Token"] = player_token
    }
  }
end

local login_handler

function login_handler()
  ET.publish(ET.holo.INITED, true)
end

local clear_player_token_handler

function clear_player_token_handler()
  M.clear_player_token()
end

local function get_url_prefix()
  if EC.is_force_use_rule_service_splice_in_path("holo") then
    return E.CONFIG.get_config("holo") .. "/"
  end
  return E.CONFIG.get_config("holo") .. "/holo/" .. get_product_code() .. "/api/1/"
end

function M.holo_url(api)
  local server_api = url_items[api]
  if server_api then
    local url_prefix = get_url_prefix()
    local url = url_prefix .. server_api
    return url
  else
    return nil
  end
end

local player_token_body, last_player_id

function M.get_player_token()
  if player_token_body then
    return player_token_body.moment_token
  end
  return nil
end

function M.get_player_token_body()
  do return UTILS.deepcopy end
  return UTILS.deepcopy, player_token_body
end

function M.clear_player_token()
  player_token_body = nil
  last_player_id = nil
end

M.get_player_token_http = token_adapter.get_player_token_facade
local get_player_token_http_retry_max_count = 3
local get_player_token_http_retry_curr_count = 0

local function player_info_handler(player_info, cb)
  if last_player_id ~= player_info.player_id then
    E.LOG.debug(TAG, "更新player_id 清除了旧token。旧player_id: " .. tostring(last_player_id) .. ",新player_id:" .. tostring(player_info.player_id))
    player_token_body = nil
  end
  last_player_id = player_info.player_id
  if not player_info or not player_info.player_id then
    UTILS.safe_call_cb(cb, false, CONSTANTS.GANGPLANK_ERROR_CODE.GANGPLANK_ERROR_CODE_PLAYER_ID_INVALID, "player_info or player_id miss")
    return
  end
  local token_finish_handler
  
  function token_finish_handler(succ, ...)
    if succ then
      local body = (...)
      E.LOG.debug(TAG, body)
      player_token_body = body
      E.LOG.info(TAG, "获取 player token 成功: " .. tostring(player_token_body and player_token_body.moment_token))
      ET.publish(ET.holo.GET_PLAYER_TOKEN, player_token_body and player_token_body.moment_token)
      ET.publish(ET.gangplank.PLAYER_ONLINE, player_token_body and player_token_body.moment_token)
      get_player_token_http_retry_curr_count = 0
      UTILS.safe_call_cb(cb, true, M.get_player_token_body())
    else
      local stat_key = TAG .. "-get_player_token_http"
      local code, msg = ...
      E.LOG.error(TAG, "get_player_token_http fail code:" .. tostring(code) .. ", msg=" .. tostring(msg))
      ET.publish(ET.holo.GET_PLAYER_TOKEN_FAIL, {code = code, msg = msg})
      local time_retry_interval = 60
      if get_player_token_http_retry_curr_count < get_player_token_http_retry_max_count then
        time_retry_interval = 1
        get_player_token_http_retry_curr_count = get_player_token_http_retry_curr_count + 1
        ESTAT.stat_error_with_limit(TAG, stat_key, "get_player_token_http_fail", "get_player_token_http_fail", {code = code, msg = msg})
      end
      E.Timer.once(time_retry_interval, function()
        M.get_player_token_http(player_info.player_id, token_finish_handler)
      end)
    end
  end
  
  M.get_player_token_http(player_info.player_id, token_finish_handler)
end

local function update_player_info_handler(player_info, cb)
  if nil == player_token_body or player_token_body and nil == player_token_body.moment_token then
    player_info_handler(player_info, cb)
  end
end

function M.re_get_player_token(cb)
  player_info_handler(EG.player_info(), cb)
end

function M.init()
  if inited then
    E.LOG.debug(TAG, "already init and return")
    return
  end
  local player_info = require("ejoysdk_lua.player.player_info")
  player_info.init()
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.SET_PLAYER_INFO, player_info_handler)
  ET.subscribe(ET.gangplank.UPDATE_PLAYER_INFO, update_player_info_handler)
  ET.subscribe(ET.holo.CLEAR_PLAYER_TOKEN, clear_player_token_handler)
  inited = true
end

local function update_info(new_info)
  new_info.code = nil
  new_info.message = nil
  info_cache = new_info
end

function M.get_info(cb)
  local info_url = M.holo_url("info")
  E.LOG.debug(TAG, "get_info, info_url:" .. info_url)
  E.HTTP.get(info_url, request_params(), function(resp)
    if resp.status == 200 then
      update_info(resp.body)
      cb(true, info_cache)
    else
      cb(false)
    end
  end)
end

function M.set_info(name, gender, birthday, bio, cb)
  local params = {
    name = name,
    gender = gender,
    birthday = birthday,
    bio = bio
  }
  local info_url = M.holo_url("info")
  E.LOG.debug(TAG, "set_info, info_url:" .. info_url)
  E.HTTP.post(info_url, request_params(), E.HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      update_info(resp.body)
      cb(true, info_cache)
    else
      cb(false)
    end
  end)
end

function M.update_location(longitude, latitude, cb)
  local params = {longitude = longitude, latitude = latitude}
  local loc_url = M.holo_url("location")
  E.LOG.debug(TAG, "update_location, loc_url:" .. loc_url)
  E.HTTP.post(loc_url, request_params(), E.HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      update_info(resp.body)
      cb(true, info_cache)
    else
      cb(false)
    end
  end)
end

function M.info()
  return info_cache
end

function M.user_infos(ids, cb)
  assert(type(ids) == "table", "ids should be string array")
  assert(#ids > 0 and #ids <= 30, "ids amount should not larger then 30")
  local params = {ids = ids}
  local user_infos_url = M.holo_url("user_infos")
  E.LOG.debug(TAG, "user_infos, user_infos_url:" .. user_infos_url)
  E.HTTP.post(user_infos_url, request_params(), E.HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      local body = resp.body
      if 0 == body.code then
        cb(true, body.infos)
        return
      end
    end
    cb(false)
  end)
end

function M.set_avatar(source, id, cb)
  local params = {source = source, id = id}
  local set_avatar_url = M.holo_url("set_avatar")
  E.LOG.debug(TAG, "set_avatar, set_avatar_url:" .. set_avatar_url)
  E.HTTP.post(set_avatar_url, request_params(), E.HTTP.CT_JSON, params, function(resp)
    if resp.status == 200 then
      local body = resp.body
      if 0 == body.code then
        update_info(resp.body)
        cb(true, info_cache)
        return
      end
    end
    cb(false)
  end)
end

local PHOTO_THUMB = 0
local PHOTO_ORIGIN = 1
local image_source = {
  MOMO = function(t, info)
    local prefix = "http://img.immomo.com/album/"
    local id = info.id
    local dir1 = id:sub(1, 2)
    local dir2 = id:sub(3, 4)
    local suffix = "_S.jpg"
    if t == PHOTO_ORIGIN then
      suffix = "_L.jpg"
    end
    return prefix .. dir1 .. "/" .. dir2 .. "/" .. id .. suffix
  end,
  BI = function(_t, _info)
    return
  end,
  HOLO = function(t, info)
    local prefix = E.CONFIG.get_config("holo-cdn") .. "/" .. get_product_code() .. "/image/"
    local id = info.id
    local dir1 = id:sub(-4, -3)
    local dir2 = id:sub(-2)
    local suffix = "_t.jpg"
    if t == PHOTO_ORIGIN then
      suffix = "_o." .. info.type
    end
    return prefix .. dir1 .. "/" .. dir2 .. "/" .. id .. suffix
  end,
  CHANGBA = function(_t, info)
    return info.id
  end,
  FB = function(_t, info)
    return info.id
  end
}
local audio_source = {
  HOLO = function(id, type_)
    type_ = type_ or "amr"
    local prefix = E.CONFIG.get_config("holo-cdn") .. "/" .. get_product_code() .. "/audio/"
    local dir1 = id:sub(-4, -3)
    local dir2 = id:sub(-2)
    do return string.format, "%s%s/%s/%s.%s", prefix, dir1, dir2, id end
    return string.format, "%s%s/%s/%s.%s", prefix, dir1, dir2, id, type_
  end,
  RECORD_DIR = function(id, type_)
    type_ = type_ or "amr"
    local prefix = E.CONFIG.get_config("holo-cdn") .. "/" .. get_product_code() .. "/audio/"
    local dir1 = id:sub(-4, -3)
    local dir2 = id:sub(-2)
    do return string.format, "%s%s/%s/%s.%s", prefix, dir1, dir2, id end
    return string.format, "%s%s/%s/%s.%s", prefix, dir1, dir2, id, type_
  end
}

function M.get_thumb_url(photo_info)
  local f = image_source[photo_info.source]
  do return f, PHOTO_THUMB end
  return f, PHOTO_THUMB, photo_info
end

function M.get_origin_url(photo_info)
  if not photo_info then
    return
  end
  local f = image_source[photo_info.source]
  do return f, PHOTO_ORIGIN end
  return f, PHOTO_ORIGIN, photo_info
end

function M.get_audio_url(id, type_)
  local f = audio_source.HOLO
  do return f, id end
  return f, id, type_
end

local function open_url(cb_url, is_webview, login_token)
  local login_cb_url = M.holo_url("login_cb")
  E.LOG.debug(TAG, "open_url, login_cb_url:" .. login_cb_url)
  local url = E.HTTP.url_query(login_cb_url, {login_token = login_token, cb = cb_url})
  if is_webview then
    E.WebView.open(url)
  else
    E.Sysinfo.open_url(url)
  end
end

function M.edit(is_webview, package)
  local cb_url = E.CONFIG.get_config("holo") .. "/holo/" .. get_product_code() .. "/"
  if package then
    cb_url = cb_url .. "#!/home?package=" .. package
  end
  local login_token_url = M.holo_url("login_token")
  E.LOG.debug(TAG, "edit, login_token_url:" .. login_token_url)
  E.HTTP.get(login_token_url, request_params(), function(resp)
    if resp.status == 200 then
      local body = resp.body
      if 0 == body.code then
        local token = body.login_token
        open_url(cb_url, is_webview, token)
        return
      end
    end
    ET.publish(M.HOLO_TOPIC, ER.holo.EDITOR_ERROR)
  end)
end

function M.open_login_url(url, is_webview)
  local login_token_url = M.holo_url("login_token")
  E.LOG.debug(TAG, "open_login_url, login_token_url:" .. login_token_url)
  E.HTTP.get(login_token_url, request_params(), function(resp)
    if resp.status == 200 then
      local body = resp.body
      if 0 == body.code then
        local token = body.login_token
        open_url(url, is_webview, token)
        return
      end
    end
    ET.publish(M.HOLO_TOPIC, ER.holo.WEB_LOGIN_ERROR)
  end)
end

function M.speech_recognize(opt, cb, ext)
  local formdata = E.HTTP.FormData.New()
  formdata:add_simple_part("type", opt.format)
  local mime
  local rate = 0
  if opt.format == "amr" then
    rate = opt.sampling_rate or 16000
    mime = "audio/amr"
  else
    mime = "audio/aac"
  end
  ext = ext or {}
  ext.use_moment_token = ext.use_moment_token or false
  _ejoysdk.log("when speech recognize, rate: " .. tostring(rate))
  formdata:add_part("audio", opt.bytes, mime, "binary", "audio" .. opt.format)
  local transform = 0
  if opt.transform == nil or opt.transform == true then
    transform = 1
  end
  local param = {
    rate = rate,
    lan = ext.lang or "zh",
    transform = transform
  }
  for key, value in pairs(ext) do
    if "lang" ~= key and "use_moment_token" ~= key then
      param[key] = value
    end
  end
  formdata:add_part("_json", param, E.HTTP.CT_JSON, nil, nil)
  local content_type = formdata:content_type()
  local build = formdata:build()
  E.log("speech_recognize body:")
  E.log(build)
  
  local function post_cb(resp)
    if resp.status ~= 200 then
      cb({
        succ = false,
        message = "http error: " .. resp.status,
        text = ""
      })
      return
    end
    local body = resp.body
    E.log(body)
    if 0 ~= body.code then
      cb({
        succ = false,
        message = body.err_msg,
        text = ""
      })
      return
    end
    local ret = {
      succ = true,
      text = body.text,
      id = body.id,
      sign = body.sign,
      type = body.type,
      duration = body.duration
    }
    cb(ret)
  end
  
  local transform_v2_url = M.holo_url("transform_v2")
  E.LOG.debug(TAG, "speech_recognize, transform_v2_url:" .. transform_v2_url)
  local req_params = request_params()
  req_params.headers = {}
  if ext.use_moment_token then
    req_params.headers["moment-token"] = M.get_player_token()
  else
    req_params.headers["Ejoy-Token"] = EG.user_info().token
  end
  E.HTTP.post(transform_v2_url, req_params, content_type, build, post_cb)
end

local function get_device_score_from_server(params, cb)
  local req_params = {
    acceptable = E.HTTP.CT_JSON,
    trace = false
  }
  local url = M.holo_url("device_score")
  E.log("获取设备评分")
  E.log(params)
  E.HTTP.post(url, req_params, E.HTTP.CT_JSON, params, function(resp)
    E.log("获取设备评分结果")
    E.log(resp)
    if resp.status == 200 then
      local body = resp.body
      if body and 0 == body.code then
        cb(true, body.data.result)
        return
      else
        cb(false, body.code, body.message or "")
      end
    else
      cb(false, resp.status, "HTTP error")
    end
  end)
end

function M.get_device_score(cb)
  E.ability_report("get_device_score")
  local DEVICE_SCORE_STORGE = E.LazyKeyStore:New("DEVICE_SCORE_STORGE", false, true, false)
  local sp_score_info = DEVICE_SCORE_STORGE:get()
  if nil ~= sp_score_info and type(sp_score_info) == "table" then
    cb(true, sp_score_info)
    return
  end
  if not E.Sysinfo.is_support_hardware_info() then
    local CONTS = require("ejoysdk_lua.ejoysdk_constants")
    cb(false, CONTS.DEVICE_SCORE_CODES.CODE_NATIVE_API_NOT_SUPPORT, "native api not support")
    return
  end
  local os = E.Sysinfo.os()
  local device_info = {
    os = os,
    pkg_info = E.get_pkg_info()
  }
  device_info.cm = E.Sysinfo.get_cpu_model()
  
  local function do_get_device_score()
    local params = {device_info = device_info}
    get_device_score_from_server(params, function(succ, ...)
      if succ then
        local score_info = (...)
        DEVICE_SCORE_STORGE:set(score_info)
        if score_info and (-1 == score_info.cpu or -1 == score_info.gpu) then
          ESTAT.stat_action("device_score_missing", nil, false, {
            cm = device_info.cm
          })
        end
        cb(true, score_info)
      else
        local err_code = (...)
        ESTAT.stat_action("device_score_server_error", nil, false, {
          cm = device_info.cm,
          err_code = tonumber(err_code)
        })
        cb(false, ...)
      end
    end)
  end
  
  if "windows" == os then
    E.Sysinfo.get_hardware_info(function(hardware_info)
      if hardware_info.gpus then
        local gpus = hardware_info.gpus
        local gm = {}
        for _, gpu in ipairs(gpus) do
          table.insert(gm, gpu.model)
        end
        device_info.gm = gm
      end
      if hardware_info.cpu then
        device_info.cm = hardware_info.cpu.model
      end
      do_get_device_score()
    end)
  else
    do_get_device_score()
  end
end

function M.is_discord_bound(cb)
  local url = M.holo_url("query_discord_player_bind")
  E.LOG.debug(TAG, "is_discord_bound url:" .. tostring(url))
  E.HTTP.post(url, request_moment_token_params(), E.HTTP.CT_JSON, {}, function(resp)
    E.LOG.debug(TAG, "request resp >>")
    E.log(resp)
    if resp.status == 200 then
      if 0 == resp.body.code then
        local bind_info = resp.body.data
        E.LOG.debug(TAG, "is_discord_bound bound")
        cb(true, true, bind_info)
      elseif resp.body.code == CONSTANTS.PLAYER_ERROR_CODES.CODE_DISCORD_NOT_BOUND then
        E.LOG.debug(TAG, "is_discord_bound NOT bound")
        cb(true, false)
      else
        local code = resp.body.code
        local msg = resp.body.message
        E.LOG.debug(TAG, "is_discord_bound request failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
        cb(false, code, msg)
      end
    else
      cb(false, resp.status, resp.body and resp.body.message or "query discord bound status failed:" .. tostring(resp.status))
    end
  end)
end

local on_open_discord_bind_page_query_listener
local last_discord_bind_query_timer_tick_sec = 0
local last_discord_bind_query_request_sec = 0
local next_discord_bind_query_interval = 0
local duration_of_discord_continuous_query = 0
local TOTAL_DURATION_OF_DISCORD_QUERY_SEC = 300

local function reset_query_state()
  last_discord_bind_query_timer_tick_sec = 0
  last_discord_bind_query_request_sec = 0
  next_discord_bind_query_interval = 0
  duration_of_discord_continuous_query = 0
end

local function on_cancel_open_discord_bind_page_query(cb)
  reset_query_state()
  if on_open_discord_bind_page_query_listener and on_open_discord_bind_page_query_listener ~= cb then
    on_open_discord_bind_page_query_listener(false, CONSTANTS.PLAYER_ERROR_CODES.CODE_DISCORD_QUERY_CANCELLED, "query discord bind status cancelled")
    on_open_discord_bind_page_query_listener = nil
  end
end

local function on_open_discord_bind_page_query(cb, next_time_sec)
  reset_query_state()
  on_open_discord_bind_page_query_listener = cb
  local TICK_INTERVAL_SEC = 1
  local query_fun
  
  function query_fun()
    if not on_open_discord_bind_page_query_listener then
      E.LOG.debug(TAG, "on_open_discord_bind_page_query cancelled")
      return
    end
    local cur_time_sec = os.time()
    local could_request
    if 0 == last_discord_bind_query_request_sec or cur_time_sec - last_discord_bind_query_timer_tick_sec > 5 then
      E.LOG.debug(TAG, "on_open_discord_bind_page_query first or from back_ground")
      reset_query_state()
      could_request = true
    else
      duration_of_discord_continuous_query = duration_of_discord_continuous_query + TICK_INTERVAL_SEC
      if duration_of_discord_continuous_query > TOTAL_DURATION_OF_DISCORD_QUERY_SEC then
        reset_query_state()
        cb(false, CONSTANTS.PLAYER_ERROR_CODES.CODE_DISCORD_QUERY_TIMEOUT, "query timeout")
        return
      else
        local diff_time = cur_time_sec - last_discord_bind_query_request_sec
        could_request = diff_time > next_discord_bind_query_interval
      end
    end
    last_discord_bind_query_timer_tick_sec = cur_time_sec
    if not could_request then
      E.Timer.once(TICK_INTERVAL_SEC, query_fun)
      return
    end
    last_discord_bind_query_request_sec = cur_time_sec
    next_discord_bind_query_interval = next_discord_bind_query_interval + 2
    E.LOG.debug(TAG, "on_open_discord_bind_page_query query is_discord_bound begin, next_discord_bind_query_interval:" .. tostring(next_discord_bind_query_interval))
    M.is_discord_bound(function(succ, ...)
      if succ then
        local is_bound, bound_info = ...
        if is_bound then
          E.LOG.debug(TAG, "on_open_discord_bind_page_query is_discord_bound query bound, has_listener:" .. tostring(on_open_discord_bind_page_query_listener))
          cb(true, true, bound_info)
        else
          E.Timer.once(TICK_INTERVAL_SEC, query_fun)
        end
      else
        E.Timer.once(TICK_INTERVAL_SEC, query_fun)
      end
    end)
  end
  
  E.Timer.once(next_time_sec or TICK_INTERVAL_SEC, query_fun)
end

function M.bind_discord(cb)
  on_cancel_open_discord_bind_page_query(cb)
  E.Loading.dismiss()
  
  local function show_loading()
    E.Timer.once(0, function()
      E.Loading.show()
    end)
  end
  
  local function dismiss_loading()
    E.Timer.once(0, function()
      E.Loading.dismiss()
    end)
  end
  
  show_loading()
  M.is_discord_bound(function(succ, ...)
    if succ then
      local is_bound, bound_info = ...
      if not is_bound then
        local bind_url = M.holo_url("bind_discord")
        E.LOG.debug(TAG, "bind_discord not bound, now begin show bind discord page")
        E.Sysinfo.async_can_open_url(bind_url, function(can_open)
          dismiss_loading()
          if can_open then
            bind_url = E.HTTP.url_query(bind_url, {
              ["moment-token"] = M.get_player_token()
            })
            E.LOG.debug(TAG, "bind_discord is_discord_bound can open, and begion open_url:" .. tostring(bind_url))
            E.Sysinfo.open_url(bind_url)
            on_open_discord_bind_page_query(cb, 4)
          else
            E.LOG.error(TAG, "bind_discord is_discord_bound async_can_open_url false:" .. tostring(bind_url))
            cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_CANNOT_OPEN_URL, "can not open url:" .. tostring(bind_url))
          end
        end)
      else
        dismiss_loading()
        cb(true, is_bound, bound_info)
      end
    else
      dismiss_loading()
      local code, msg = ...
      E.LOG.error(TAG, "bind_discord is_discord_bound failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(false, code, msg)
    end
  end)
end

return M
