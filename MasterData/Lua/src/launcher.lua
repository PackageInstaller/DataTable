local Launcher = {}
Launcher.gameplayRequired = false

local function setLuaMetatable()
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
  L_LoadingMediator = require("modules.world.azurWorld.loadingMediator")
  
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
  
  function metable.__newindex(v1, v2, v3)
    if not Launcher.gameplayRequired then
      rawset(v1, v2, v3)
      return
    end
    if v2 ~= "i" and v2 ~= "j" and v2 ~= "socket" and v2 ~= "ltn12" and v2 ~= "reload" and not string.find(v2, "L_") then
      errorf("不能添加全局变量 " .. v2, 2)
    else
      rawset(v1, v2, v3)
    end
  end
end

local function initLuaEnv()
  C_UpdateSource.AddIndependentUpdate(handler(L_UI, L_UI.update), "LuaUI.Update")
  C_UpdateSource.AddIndependentUpdate(Timer.updateAll, "LuaTimer.UpdateAll")
  C_UpdateSource.AddIndependentUpdate(FrameScheduler.frameTick, "FrameScheduler.frameTick")
  L_Net:initialize(L_Proto)
end

function Launcher:requireBasic()
  require("define")
  self.alias = require("alias")
  self.alias:defBaseCS()
  require("r")
  require("core.index")
  require("const")
  require("debug.index")
  require("ui.uiIndex")
  L_StoreManager = require("ui.store.storeManager").new()
  L_ManagerRegistry = require("ui.manager.ManagerRegistry").new()
  setLuaMetatable()
  initLuaEnv()
end

function Launcher:requireGamePlay()
  if self.gameplayRequired then
    self.alias:defCsRef()
    L_ManagerRegistry:initializeAll()
    return
  end
  self.alias:defGamePlayCS()
  require("modules.common.behaviorTree.index")
  L_EcsConst = require("modules.common.ecs.ecsConst").new()
  L_Proto:initialize({
    bytes = {
      C_LuaManager.ReadBytesFiles("proto/descriptor.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/ExOptions.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/CommonMsg.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/Battle.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/Core.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/Pet.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/Home.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/KiboDuel.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/PoppingParty.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/Activity.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/WorldMap.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/Campaign.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/CSCore.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/Shop.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/GMMsg.pb.bytes"),
      C_LuaManager.ReadBytesFiles("proto/Task.pb.bytes")
    }
  })
  require("modules.guide.index")
  L_UI:initGameplay()
  require("ui.manager.shortCut.shortCutConst")
  require("modules.world.worldIndex")
  require("modules.battle.battleIndex")
  self.gameplayRequired = true
  L_ManagerRegistry:initializeAll()
  L_UI:open("pageFps")
end

function Launcher:dispose()
  self:disposeManagers()
end

function Launcher:disposeManagers()
  L_ManagerRegistry:disposeAll()
  L_StoreManager:allStoresDoClear()
end

function Launcher:initializeManagers()
end

return Launcher
