local this = {}

function this:setMainControlEntity(entity, setType)
  setType = setType or L_Const.setControlType.normal
  self.playerUnit:setMainControlEntity(entity, setType)
end

function this:fireJump()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainJump, true)
  Timer.once(0.1, function()
    C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainJump, false)
  end, self)
end

function this:fireEvadeDown()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainEvade, true)
end

function this:fireEvadeUp()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainEvade, false)
end

function this:fireEvade()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainEvade, true)
end

function this:fireAttackDown()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainAttack, true)
end

function this:fireAttackUp()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainAttack, false)
end

function this:fireAttack()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainAttack, true)
end

function this:firePetCatchDown()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainPetCatch, true)
end

function this:firePetCatchUp()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainPetCatch, false)
end

function this:firePetCatch()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainPetCatch, true)
end

function this:firePetHideShow()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainHideShowPet, true)
end

function this:fireStartCatch()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainPetStartCatch, true)
end

function this:fireUltimateSkillDown()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainUltimateSkill, true)
end

function this:fireUltimateSkillUp()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainUltimateSkill, false)
end

function this:fireUltimateSkill()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainUltimateSkill, true)
end

function this:fireSkillDown()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainSkill, true)
end

function this:fireSkillUp()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainSkill, false)
end

function this:fireSkill()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainSkill, true)
end

function this:firePetSkill()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainPetSkill, true)
end

function this:firePetBreakSkill()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainPetBreakSkill, true)
end

function this:fireFlyUp(press)
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainFlyUp, press)
end

function this:fireFlyFall(press)
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainFlyFall, press)
end

function this:fireFlySprint()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainFlySprint)
end

function this:fireCountermeasuresSkillDown()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainCountermeasures, true)
end

function this:fireCountermeasuresSkillUp()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainCountermeasures, false)
end

function this:fireCountermeasuresSkill()
  C_InputManager.OnUITriggerKey(C_InputManager_KeyType.EMainCountermeasures, true)
end

return this
