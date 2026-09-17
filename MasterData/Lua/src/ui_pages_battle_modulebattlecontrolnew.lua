local this = class("moduleBattleControlNew", G_UIModuleBase)

function this.bind()
  return {
    bgWorld = true,
    bgHome = false,
    goContent = true,
    goContent2 = true,
    moduleBattleAttackBtn = {
      moduleName = "pages/battle/moduleBattleAttackBtn"
    },
    modulePetCatchBtn = {
      moduleName = "pages/battle/modulePetCatchBtn"
    },
    moduleBattlePetSkill = {
      moduleName = "pages/battle/moduleBattlePetSkill"
    },
    moduleHeroESkill = {
      moduleName = "pages/battle/moduleBattleHeroSkillBtn"
    },
    moduleHeroUltimateSkill = {
      moduleName = "pages/battle/moduleBattleHeroUltimateSkillBtn"
    },
    moduleCountermeasuresSkill = {
      moduleName = "pages/battle/skillBtn/moduleBattleCountermeasuresSkillBtn"
    },
    moduleBattleDodgeSkillBtn = {
      moduleName = "pages/battle/skillBtn/moduleBattleDodgeSkillBtn"
    },
    moduleUIChargingSkill = {
      moduleName = "pages/battle/moduleUIChargingSkill"
    }
  }
end

function this.methods()
  return {
    onClick_jump = function(self)
      L_PlayerManager:fireJump()
    end,
    onDown_Lock = function(self)
    end,
    onUp_Lock = function(self)
    end
  }
end

function this:open(...)
  this.super.open(self, ...)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  L_PlayerManager:addListener(L_PlayerManager.event.playMount, self.onPlayerOnMount, self)
  L_PlayerManager:addListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
  L_MountManager:addListener(L_MountManager.event.onCSEntityMountStateChange, self.onEvent_CsEntityStateChange, self)
  self:refreshSkillIcon()
  self.bind.goContent = not C_PlayerHelper.GetPlayerIsRidingMount() and AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true) ~= nil
end

function this:onEvent_CsEntityStateChange()
  self.bind.goContent = not AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount()
end

function this:onPlayerOnMount()
  self.bind.goContent = false
end

function this:onPlayerOutMount()
  self.bind.goContent = true
end

function this:show()
  self:showModules()
  self:refreshSkillIcon()
end

function this:close(...)
  this.super.close(self, ...)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.setMainControl, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.playMount, self.onPlayerOnMount, self)
  L_PlayerManager:removeListener(L_PlayerManager.event.outMountEnd, self.onPlayerOutMount, self)
  L_MountManager:removeListener(L_MountManager.event.onCSEntityMountStateChange, self.onEvent_CsEntityStateChange)
end

function this:setMainControl()
  self:refreshSkillIcon()
end

function this:refreshSkillIcon()
  local mainControlType = AzurWorld.playerMgr.myPlayerData.mainControlType
  self.bind.goContent = mainControlType == C_EPlayerMainControlType.Formation and AzurWorld.playerMgr.myPlayerData:GetHeroEntity(AzurWorld.playerMgr.myPlayerData.formationMainControlIndex) ~= nil
end

function this:hide()
  self:hideModules()
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
