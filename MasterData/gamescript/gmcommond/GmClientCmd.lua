local s_isBanMinimap = true
local s_isOpenGC = true
local GmManager, Super = System.NewClass("GmManager", Manager, IUpdater)

function GmManager:ctor()
  Super.ctor(self)
  self.gmCopyAbilityData = {}
  self.gmTempCopyAbilityData = {}
end

return GmManager
