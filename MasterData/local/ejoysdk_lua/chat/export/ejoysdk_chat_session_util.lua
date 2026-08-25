local M = {}
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local EC = require("ejoysdk_lua.chat.ejoysdk_chat_base")
M.SESSION_TYPE = {
  TYPE_PERSONAL = EC.TYPE_PERSONAL,
  TYPE_GROUP = EC.TYPE_GROUP,
  TYPE_SYSTEM = EC.TYPE_SYSTEM,
  SYSTEM_CHAT_GROUP = EC.SYSTEM_CHAT_GROUP,
  SYSTEM_CHAT = EC.SYSTEM_CHAT,
  SYSTEM_FRIEND = EC.SYSTEM_FRIEND,
  SYSTEM_GAME = EC.SYSTEM_GAME,
  SYSTEM_GANGPLANK = EC.SYSTEM_GANGPLANK
}
M.SESSION_FROM = {
  FROM_ARRIVAL = "chat_arrival"
}

function M.get_session_type(session_id)
  do return EC.get_session_type end
  return EC.get_session_type, session_id
end

E_UTILS.do_export_wrapping(M, "chat")
return M
