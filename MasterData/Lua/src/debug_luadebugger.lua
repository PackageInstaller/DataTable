local m_breakSocketHandle, _ = require("Lua.tools.LuaIde.LuaDebug")("localhost", 7003)
Timer.repeated(1, m_breakSocketHandle)
local _input = Unity.Input
local _keyCode = Unity.KeyCode
local test = {}

function test.update()
  if _input.GetKeyDown(_keyCode.Q) then
    L_SystemBreakManager:jumpTo(L_SystemConst.enum.photo)
  end
  if _input.GetKeyDown(_keyCode.E) then
  end
  if _input.GetKeyDown(_keyCode.R) then
  end
  if _input.GetMouseButtonDown(0) then
  end
end

C_UpdateSource.AddUpdateEventHandler(test.update, "luaDebugger.update")
