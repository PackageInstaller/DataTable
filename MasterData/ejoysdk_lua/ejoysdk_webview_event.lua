local E = require("ejoysdk_lua.ejoysdk")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local WC = require("ejoysdk_lua.ejoysdk_web_config")
local CM = require("ejoysdk_lua.vm_channel.ejoy_vm_manager")
local M = {}
local WEBVIEW_EVENT_NAME = {
  PAGE_OPEN = "sdk.webview_page_open",
  PAGE_RESULT = "sdk.webview_page_result",
  PAGE_REDIRECT = "sdk.webview_page_redirect"
}
local WEBVIEW_PAGE_LIFECYCLE = {
  ON_PAGE_START = 0,
  ON_PAGE_FINISH = 1,
  ON_PAGE_ERROR = 2,
  ON_PAGE_CLOSE = 3
}
local has_inited_log = false

function M.init_log()
  if has_inited_log then
    return
  end
  has_inited_log = true
  if E.Sysinfo.os() == "harmonyos" then
    QL = CM.cross_vm_require(CM.LUA_VM.GAME, "ejoysdk_lua.ejoysdk_qualitylog")
  end
end

local function get_url_protocol(url)
  local protocol = (E.Utils.split_string(url, "://") or {})[1]
  if not E.Utils.start_with(protocol, "http") and not E.Utils.start_with(protocol, "file") then
    protocol = "other"
  end
  return protocol
end

local function commit_page_redirect(url, redirect_url)
  if url == redirect_url then
    return
  end
  M.init_log()
  local commit_params = {
    url = url,
    protocol = get_url_protocol(url),
    redirect_url = redirect_url,
    redirect_protocol = get_url_protocol(redirect_url)
  }
  QL.commit_event(WEBVIEW_EVENT_NAME.PAGE_REDIRECT, commit_params, true)
end

function M.commit_page_open(url)
  M.init_log()
  QL.commit_event(WEBVIEW_EVENT_NAME.PAGE_OPEN, {
    url = url,
    protocol = get_url_protocol(url)
  }, true)
end

function M.commit_page_result(url, redirect_url, cover, data)
  M.init_log()
  if not data or type(data) ~= "table" then
    data = {}
  end
  local commit_params = {
    url = url,
    redirect_url = redirect_url,
    status = data.status,
    method = data.method,
    cover = cover,
    can_open_url = data.can_open_url
  }
  QL.commit_event(WEBVIEW_EVENT_NAME.PAGE_RESULT, commit_params, true)
  commit_page_redirect(url, redirect_url)
end

function M.on_page_lifecycle(value)
  if not (value and value.data and value.data.is_entry_url) or not not value.data.has_error then
    return
  end
  if value.type == WEBVIEW_PAGE_LIFECYCLE.ON_PAGE_FINISH or value.type == WEBVIEW_PAGE_LIFECYCLE.ON_PAGE_ERROR then
    M.commit_page_result(value.url, value.data.redirect_url, "normal", {
      status = value.data.status,
      method = value.data.method
    })
  end
end

function M.on_entry_url_load_error(value)
  if not value then
    return
  end
  local data = value.data or {}
  local final_url = data.redirect_url
  local is_in_white_domains = WC.is_in_global_white_domains(value.url) or WC.is_in_global_white_domains(final_url)
  if data.is_entry_url then
    M.commit_page_result(value.url, final_url, is_in_white_domains and "normal" or "error", {
      status = data.status,
      method = data.method
    })
  end
  if is_in_white_domains then
    return
  end
  if (E.Sysinfo.os() == "ios" or E.Sysinfo.os() == "windows") and _ejoysdk.webview_load_url then
    if E.Sysinfo.os() == "ios" then
      E.Timer.once(0.1, function()
        _ejoysdk.webview_load_url(data.error_page_url)
      end)
    else
      _ejoysdk.webview_load_url(data.error_page_url)
    end
  elseif E.Sysinfo.os() == "android" then
    E.async_call("WEBVIEW_ERROR", {
      errorUrl = data.error_page_url
    })
  elseif E.Sysinfo.os() == "harmonyos" then
    local jf = lunate.js_functions
    if jf.webview().loadUrl then
      jf.webview():loadUrl(data.error_page_url)
    end
  end
end

function M.open_app(value)
  if value and E.Sysinfo.os() ~= "windows" then
    local US = require("ejoysdk_lua.ejoysdk_url_schemes_config")
    local data = value.data or {}
    local open_url = data.open_url or data.redirect_url
    local can_open_url = US.can_open_url(open_url)
    if E.Sysinfo.os() == "ios" and not can_open_url then
      open_url = string.match(open_url, "https?://[^%s]+$") or open_url
      can_open_url = US.can_open_url(open_url)
    end
    local redirect_page_url = data.redirect_page_url
    local need_return = false
    if can_open_url then
      E.Sysinfo.open_url(open_url)
      need_return = true
    else
      redirect_page_url = string.format("%s?status=error", redirect_page_url)
    end
    if data.is_entry_url and redirect_page_url then
      M.commit_page_result(value.url, data.redirect_url, "custom", {
        status = data.status,
        method = data.method,
        can_open_url = can_open_url
      })
      if E.Sysinfo.os() == "ios" and _ejoysdk.webview_load_url then
        _ejoysdk.webview_load_url(redirect_page_url)
      elseif E.Sysinfo.os() == "android" then
        E.async_call("WEBVIEW_OPEN_APP", {coverUrl = redirect_page_url, can_open_url = can_open_url})
      elseif E.Sysinfo.os() == "harmonyos" then
        local jf = lunate.js_functions
        if jf.webview().loadUrl then
          jf.webview():loadUrl(redirect_page_url)
        end
      end
      need_return = true
    end
    if need_return then
      return
    end
  end
  if E.Sysinfo.os() == "ios" and _ejoysdk.webview_fallback then
    _ejoysdk.webview_fallback()
  end
end

return M
