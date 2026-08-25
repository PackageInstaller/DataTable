local ECA = require("ejoysdk_lua.chat.ejoysdk_chat_account")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
E_UTILS.do_export_wrapping(ECA, "chat")
return ECA
