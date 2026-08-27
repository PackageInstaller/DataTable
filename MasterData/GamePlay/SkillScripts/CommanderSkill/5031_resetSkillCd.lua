local bs_5031 = class("bs_5031", LuaSkillBase)
local base = LuaSkillBase
bs_5031.config = {effectId_reset = 503101}

function bs_5031:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_5031_3", 1, self.OnAfterPlaySkill)
end

function bs_5031:CheckManualSkillTakeAvailable(role)
  if role.roleType ~= eBattleRoleType.character then
    return false
  end
  return base.CheckManualSkillTakeAvailable(self, role)
end

function bs_5031:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5031:CallSelectExecute(role)
  if role.hp <= 0 then
    return
  end
  if role.belongNum == eBattleRoleBelong.player then
    self.role = role
    self.curCd = role:GetMainSkillCurCd()
    LuaSkillCtrl:CallEffect(role, self.config.effectId_reset, self)
    LuaSkillCtrl:CallReFillMainSkillCdForRole(role)
  end
end

function bs_5031:OnAfterPlaySkill(skill, role)
  if role == self.role and skill.skillTag == eSkillTag.normalSkill and self.curCd ~= nil then
    LuaSkillCtrl:CallResetCDNumForRole(role, self.curCd)
    self.role = nil
    self.curCd = nil
  end
end

function bs_5031:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5031
