local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.ODR .. "state_util"
local M = {}
local tag_state = {}
M.TAG_STATE = {
  AVAILABLE = "STATE_AVAILABLE",
  DOWNLOADING = "STATE_DOWNLOADING",
  NOT_LOAD = "STATE_NOT_LOAD"
}

function M.get_state(tag)
  if tag_state[tag] then
    return tag_state[tag]
  end
  return M.TAG_STATE.NOT_LOAD
end

function M.set_state(tag, state)
  tag_state[tag] = state
end

function M.print_all_tag_state()
  E.LOG.debug(TAG, "print all tags state")
  E.LOG.debug(TAG, tag_state)
end

return M
