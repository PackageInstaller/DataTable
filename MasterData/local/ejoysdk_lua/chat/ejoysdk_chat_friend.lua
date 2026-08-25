local _E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.CHAT .. "friend"
local M = {}

function M.process_friend_player_apply_refuse(data, cb)
  if cb then
    cb(true, data)
  end
end

function M.process_friend_player_apply_delete(data, cb)
  if cb then
    cb(true, data)
  end
end

return M
