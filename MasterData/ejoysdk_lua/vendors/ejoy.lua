local E = require("ejoysdk_lua.ejoysdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CHANNEL = "EJOY"
local EJOY = Vendor:Inherit(CHANNEL)
local TAG = EM.MODULE.VENDORS.EJOY
EJOY.EC_OAUTH_FAILED = -2
EJOY.EC_USER_CANCEL = -3
EJOY.EC_OAUTH_ERROR_CALLBACK_URL = -4
EJOY.EC_NONCE_ERROR = -5
local callback_info = {nonce = nil, type = "browser"}
local ejoy_token

local function ejoy_oauth_url()
  local url_base = E.CONFIG.get_config("id")
  return url_base .. "/o/oauth2/v1/auth"
end

local function cb_handler(succ, token, new_nonce, _new_state)
  local nonce = callback_info.nonce
  if callback_info.type ~= "browser" and not nonce then
    nonce = true
  end
  if not succ then
    ejoy_token = nil
    local error_info = token
    EJOY.opt.auth_listener(false, error_info)
  elseif nonce and new_nonce ~= nonce then
    ejoy_token = nil
    EJOY.opt.auth_listener(false, {
      code = EJOY.EC_NONCE_ERROR,
      msg = "nonce error"
    })
  else
    ejoy_token = token
    EJOY.opt.auth_listener(succ, {
      platform = CHANNEL,
      ptoken = token,
      pid = nil,
      guest = false,
      with = nil,
      with_account = nil
    }, {})
  end
end

local function ejoy_oauth_ticket_url()
  local url_base = E.CONFIG.get_config("id")
  return url_base .. "/app/api/v1/gen_ticket"
end

local function ejoy_catch_token_url(env)
  local os = E.CONFIG.get_config("os")
  local url_base = E.CONFIG.get_config("launcher")
  return url_base .. "/oauth/ejoy/" .. os .. "/" .. env
end

local function on_url(url)
  local ret = E.HTTP.parse(url)
  if ret.host == "sdk.ejoy.com" and ret.query then
    local query = ret.query
    if query._platform == "ejoy" and query.access_token and query.nonce and query.state then
      cb_handler(true, query.access_token, query.nonce, query.state)
    else
      E.LOG.warn(TAG, "on_url fail")
      if query.error then
        E.LOG.debug(TAG, query)
        cb_handler(false, {
          code = EJOY.EC_OAUTH_FAILED,
          msg = "ejoy id server: " .. tostring(query.error)
        })
      else
        cb_handler(false, {
          code = EJOY.EC_OAUTH_ERROR_CALLBACK_URL,
          msg = "ouath error callback url"
        })
      end
    end
  end
end

local function subscribe_on_url(type, data)
  if "url" == type and data.url then
    E.LOG.debug(TAG, "[url_open]ejoy_vendor, type:" .. tostring(type))
    on_url(data.url)
  end
end

local function on_login_done(value)
  callback_info.type = "browser"
  on_url(value.args.uri)
end

local function on_webview_close(_value)
  if callback_info.type ~= "browser" then
    callback_info.type = "browser"
    cb_handler(false, {
      code = EJOY.EC_USER_CANCEL,
      msg = "user canceled"
    })
  end
end

local EJOY_DEFAULT_OPT = {type = "webview", hide_email_login = false}
EJOY_DEFAULT_OPT.__index = EJOY_DEFAULT_OPT

local function init_opt(opt)
  assert(type(opt) == "table", "opt should be table")
  do return setmetatable, opt end
  return setmetatable, opt, EJOY_DEFAULT_OPT
end

function EJOY.init(opt, cb)
  EJOY.opt = init_opt(opt)
  ET.subscribe("urlopen_v2", subscribe_on_url)
  ET.subscribe("logindone", on_login_done)
  ET.subscribe("webview_close", on_webview_close)
  cb(true)
end

function EJOY.has_token()
  return ejoy_token
end

function EJOY.open_webview(webview_url)
  local secret = _ejoysdk_crypt.randomkey()
  local query = {
    secret = _ejoysdk_crypt.base64encode(_ejoysdk_crypt.dhexchange(secret))
  }
  local ticket_url = E.HTTP.url_query(ejoy_oauth_ticket_url(), query)
  E.HTTP.get(ticket_url, {
    acceptable = E.HTTP.CT_JSON
  }, function(resp)
    if resp.status ~= 200 or 0 ~= resp.body.code then
      do return cb_handler, false end
      return cb_handler, false, {
        code = EJOY.EC_OAUTH_FAILED,
        msg = "oauth failed"
      }, EJOY.EC_OAUTH_FAILED, nil, nil, nil, nil, nil, nil, nil, nil, nil
    end
    local server_secret = _ejoysdk_crypt.base64decode(resp.body.secret)
    local ticket_encrypted = _ejoysdk_crypt.base64decode(resp.body.ticket)
    local real_secret = _ejoysdk_crypt.dhsecret(server_secret, secret)
    local c = EU.XORCipher.new(real_secret)
    local ticket = c:decrypt(ticket_encrypted)
    local opt = {compactMode = true, closeEventData = "oauth"}
    E.WebView.open(webview_url, {
      [".ejoy.com"] = {
        startupData = {
          ejoy_ticket = _ejoysdk_crypt.base64encode(ticket),
          hide_email_login = EJOY.opt.hide_email_login
        },
        transparent = true
      }
    }, opt)
  end)
end

function EJOY.check_token(outsource, info)
  cb_handler(true, outsource, info)
end

function EJOY.simple_token()
  return true
end

function EJOY.merge_info(info, pinfo)
  do return EJOY.merge_helper, info end
  return EJOY.merge_helper, info, pinfo
end

function EJOY.login(_outsource, _info)
  local viewer_type = EJOY.opt.type
  local nonce = _ejoysdk_crypt.base64encode(_ejoysdk_crypt.randomkey())
  local query = {
    response_type = "token",
    client_id = E.CONFIG.get_config("product"),
    nonce = nonce,
    redirect_uri = ejoy_catch_token_url(viewer_type),
    scope = "profile",
    state = "login",
    login_hint = "CLEAN",
    v = 2
  }
  callback_info = {nonce = nonce, type = viewer_type}
  local url = E.HTTP.url_query(ejoy_oauth_url(), query)
  if "browser" == viewer_type then
    E.Sysinfo.open_url(url)
  else
    EJOY.open_webview(url)
  end
end

function EJOY.logout(cb)
  cb()
end

EJOY:is_implemented({"ACCOUNT"})
return EJOY
