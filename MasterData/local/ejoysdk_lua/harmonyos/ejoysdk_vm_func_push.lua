local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local jf = lunate.js_functions
local M = {}
local TAG = "harmonyos#push"
local m_event_callbacks = {}

function M.set_event_callback(evt_handlers)
  if not evt_handlers then
    E.LOG.debug(TAG, "set_event_callback skip, evt_handlers is nil")
    return
  end
  m_event_callbacks = evt_handlers
  local ns_module = jf.EjoySDK():getProxy("PUSH")
  ns_module.setLuaPushListener({
    onEvent = function(_type, _body)
      if m_event_callbacks then
        local handler = m_event_callbacks[tostring(_type)]
        if handler then
          handler(JSON.decode(_body))
        else
          E.LOG.debug(TAG, "onEvent skip, no handler for event_id:" .. tostring(_type))
        end
      end
    end
  })
end

return M
