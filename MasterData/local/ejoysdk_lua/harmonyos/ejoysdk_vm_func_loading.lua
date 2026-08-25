local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local Win = require("ejoysdk_lua.harmonyos.ejoysdk_vm_func_window")
local jf = lunate.js_functions
local M = {}
local TAG = "ejoysdk_loading"
local m_loading_win, m_loading_page

local function prepare_loading_page(cb)
  if m_loading_page then
    cb(m_loading_page)
    return
  end
  if not jf.import_path then
    cb(nil, EC.BASE_API_COMMON_ERROR.CODE_NOT_SUPPORT, "import_path not support")
    return
  end
  jf.import_path("./pages/EjoyLoadingPage", function(succ, ret)
    if succ then
      m_loading_page = "EjoyLoadingPage"
      cb(m_loading_page)
    else
      local code = ret.code
      local msg = ret.message
      E.LOG.warn(TAG, "importWebviewPage failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      cb(nil, code, msg)
    end
  end)
end

local function prepare_loading_window(cb)
  local function on_window_ready(window)
    prepare_loading_page(function(page_name, ...)
      if page_name then
        window.loadContentByName(page_name, nil, function(_err)
          if _err and _err.code > 0 then
            E.LOG.warn(TAG, "loading loadContentByName failed, code:" .. tostring(_err.code) .. ",  msg:" .. tostring(_err.message))
            
            cb(false, _err.code, _err.message)
          else
            window:setWindowBackgroundColor("#0000FFFF")
            E.LOG.debug(TAG, "loading loadContentByName succ")
            cb(true)
          end
        end)
      else
        cb(false, ...)
      end
    end)
  end
  
  local is_modal = true
  local align, width, height
  if is_modal then
    width = -1
    height = -1
  else
    align = Win.ALIGN.CENTER
    width = 150
    height = 150
  end
  m_loading_win = Win:New("EjoyLoading")
  m_loading_win:create({
    align = align,
    size = {width = width, height = height}
  }, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "loading window create succ, begin load loading page")
      local window = m_loading_win:get_window()
      if window then
        on_window_ready(window)
      else
        E.LOG.warn(TAG, "prepare_loading_window failed, window is nil")
        cb(false, EC.EJOYSDK_ERROR_CODES.WINDOW_NOT_EXISTS, "loading window return nil")
      end
    else
      E.LOG.warn(TAG, "loading window create failed, skip load loading page")
      local code, msg = ...
      cb(false, code, msg)
    end
  end)
end

function M.show()
  E.LOG.debug(TAG, "show received")
  
  local function show_handler()
    m_loading_win:show()
  end
  
  if not m_loading_win then
    prepare_loading_window(function(succ, ...)
      if succ then
        show_handler()
      else
        local code, msg = ...
        E.LOG.warn(TAG, "loading show failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      end
    end)
  else
    show_handler()
  end
end

function M.dismiss()
  if not m_loading_win then
    E.LOG.debug(TAG, "loading window is nil, skip dismiss")
    return
  end
  m_loading_win:destroy()
  m_loading_win = nil
end

return M
