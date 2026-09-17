local this = class("formationManager", G_EventManagerBase)
table.merge(this, require("ui.manager.formation.formationManager_scene"))
table.merge(this, require("ui.manager.formation.formationManager_net"))
this.event = {
  formationNoEnergy = "formationNoEnergy",
  showFormations = "closeFormations"
}

function this:ctor()
  this.super.ctor(self)
end

function this:showFormationTip(tipType)
  L_FlyMsgManager:showNormalMsgByKey(L_FormationConst.FormationTipDesc[tipType])
end

function this:getCurFormationType()
  local battleTypeModule = L_BattleStore:getCreateBattleType()
  if battleTypeModule == L_Const.createBattleType.tower then
    return L_FormationConst.FormationType.tower
  end
  local fType = L_FormationConst.FormationType.world
  return fType
end

function this:switchMyPlayerMainControl(index, force, freezeEnterSkill, freezeLeaveSkill)
  AzurWorld.playerMgr.myPlayerUnitAdapter:SwitchFormationMainControlIndex(index, force == true, freezeEnterSkill == true, freezeLeaveSkill == true)
end

function this:dispose()
end

return this
