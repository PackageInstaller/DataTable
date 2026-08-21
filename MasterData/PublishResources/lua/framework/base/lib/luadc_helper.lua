require("log_helper")

local function LuaDcErrFunc(obj)
  dump(obj)
end

LuaDcHelper = {}

function LuaDcHelper.Init()
  local ret, msg = lua_dc.InitLogFunc(logfatal)
  if not ret then
    Log.fatal("lua_dc.InitLogFunc fail! ", msg)
  end
  ret, msg = lua_dc.InitErrFunc(LuaDcErrFunc)
  if not ret then
    Log.fatal("lua_dc.InitErrFunc fail! ", msg)
  end
  for _, v in pairs(_G.Classes) do
    ret, msg = lua_dc.InitSeria(v)
    if not ret then
      Log.fatal(v._className, " init seria fail! ", msg)
    end
  end
end
