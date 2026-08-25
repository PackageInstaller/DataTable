local TownManager, Super = System.NewClass("TownManager", Manager, IUpdater)

function TownManager:ctor()
  Super.ctor(self)
end

function TownManager:Awake()
  Super.Awake(self)
end

function TownManager:OnDestroy()
  Super.OnDestroy(self)
end

return TownManager
