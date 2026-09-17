local this = class("kiBoDuelSceneMgr", G_EventManagerBase)

function this:ctor()
  this.super.ctor(self)
end

function this:OpenKiboDuelUI()
  L_UI:openRoot("pagePetDuel", {directlyOpen = true})
end

function this:StartKiboDuel()
  L_KiBoDuelManager:addListener(L_KiBoDuelManager.event.restartKiBoDuel, self.restartKiBoDuel, self)
end

function this:ExitKiboDuel()
  L_KiBoDuelManager:onUnloadKiBoDuel()
  L_KiBoDuelManager:removeListener(L_KiBoDuelManager.event.restartKiBoDuel, self.restartKiBoDuel, self)
  if CS.Lens.Gameplay.Modules.BigWorld.Macro.IsKiboDuelSimulator then
    L_UI:openRoot("pageMainKiboDuelSimulator")
  else
    L_UI:openRoot("pageMainCity")
  end
  AzurWorld.KiBoDuelSceneMgr:DisposePlayerUnitAdapter()
  AzurWorld.playerMgr.myPlayerUnitAdapter.pause = false
  AzurWorld.playerMgr.myPlayerUnitAdapter:ResumePlayerUnit(nil, true)
end

function this:dealEnterKiBoDuel(duelId, callback)
  AzurWorld.KiBoDuelSceneMgr:SwitchEnterKiboDuel()
end

function this:restartKiBoDuel()
  L_KiBoDuelManager:onUnloadKiBoDuel()
  C_KiBoDuelLuaWrapper.RestartDuel()
  local duelId = L_PetDuelStore:getCurChallengeLevelId() or 1001
  self:dealEnterKiBoDuel(duelId)
  L_PetDuelStore:req_CSProtoKiboDuelStart(duelId)
end

return this
