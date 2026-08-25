local M = {}
local is503 = string.pack ~= nil
local compat_string = {}
local compat_math = {}
local bitutil, compat_utf8, compat_xpcall, compat_table_move
if is503 then
  compat_string.pack = string.pack
  compat_string.unpack = string.unpack
  bitutil = require("ejoysdk_lua.compat.bitutil_503")
  compat_utf8 = utf8
  compat_xpcall = xpcall
  compat_table_move = table.move
  compat_math.type = math.type
else
  local LUA501 = require("ejoysdk_lua.compat.string_pack_501")
  compat_string.pack = LUA501.pack
  compat_string.unpack = LUA501.unpack
  bitutil = require("ejoysdk_lua.compat.bitutil_501")
  compat_utf8 = _ejoysdk.utf8
  local LUA501_xpcall = require("ejoysdk_lua.compat.xpcall_501")
  compat_xpcall = LUA501_xpcall.xpcall
  local LUA501_table_move = require("ejoysdk_lua.compat.table_move_501")
  compat_table_move = LUA501_table_move.table_move
  
  function compat_math.type(number)
    if type(number) ~= "number" then
      return nil
    end
    if math.floor(number) == number then
      return "integer"
    else
      return "float"
    end
  end
end
M.string = compat_string
M.bitutil = bitutil
M.utf8 = compat_utf8
M.xpcall = compat_xpcall
M.table_move = compat_table_move
M.math = compat_math
return M
