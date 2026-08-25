local LuaProfiler = {}
local stringCache = {}
local uid = 0
LuaProfiler.isProfile = false

function LuaProfiler.Begin(name)
  if not LuaProfiler.isProfile then
    return
  end
  local id = stringCache[name]
  if nil == id then
    stringCache[name] = uid
    id = uid
    CS.LuaProfiler.SetId(name, uid)
    uid = uid + 1
  end
  CS.LuaProfiler.Begin(id)
end

function LuaProfiler.End(name)
  if not LuaProfiler.isProfile then
    return
  end
  local id = name and stringCache[name]
  if id then
    CS.LuaProfiler.End(id)
  else
    CS.LuaProfiler.End()
  end
end

return LuaProfiler
