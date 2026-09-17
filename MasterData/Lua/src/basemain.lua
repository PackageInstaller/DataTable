require("define")
require("alias")
require("r")
require("core.index")
require("const")
require("debug.index")
require("ui.uiIndex")
L_StoreManager = require("ui.store.storeManager").new()
L_ManagerRegistry = require("ui.manager.ManagerRegistry").new()
local metable = {
  __index = function(t, k)
    local res = L_StoreManager:checkGetStore(k)
    if res then
      return res
    end
    res = L_ManagerRegistry:getManager(k)
    if res then
      return res
    end
  end
}
setmetatable(_G, metable)

function metable.__index(t, k)
  local res = L_StoreManager:checkGetStore(k)
  if res then
    return res
  end
  res = L_ManagerRegistry:getManager(k)
  if res then
    return res
  end
  if k ~= "jit" and k ~= "emmy" then
    errorf("未注册的全局变量" .. k, 2)
  end
end

metable.__newindex = function(v1, v2, v3)
  if v2 ~= "i" and v2 ~= "j" and v2 ~= "socket" and v2 ~= "ltn12" and v2 ~= "reload" and not string.find(v2, "L_") then
    errorf("不能添加全局变量 " .. v2, 2)
  else
    rawset(v1, v2, v3)
  end
end, C_UpdateSource.AddUpdateEventHandler(handler(L_UI, L_UI.update), "L_UI.update")
C_UpdateSource.AddUpdateEventHandler(Timer.updateAll, "Timer.updateAll")
C_UpdateSource.AddUpdateEventHandler(FrameScheduler.frameTick, "FrameScheduler.frameTick")
L_Net:initialize(L_Proto)
