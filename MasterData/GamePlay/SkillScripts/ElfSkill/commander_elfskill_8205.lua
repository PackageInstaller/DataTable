local bs_8205 = class("bs_8205", LuaSkillBase)
local base = LuaSkillBase
bs_8205.config = {
  buffId = 503301,
  effectId_reset = 503101,
  buffId_2 = 718
}

function bs_8205:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_8205_3", 1, self.OnAfterPlaySkill)
end

function bs_8205:CheckManualSkillTakeAvailable(role)
  if role.roleType ~= eBattleRoleType.character then
    return false
  end
  return base.CheckManualSkillTakeAvailable(self, role)
end

function bs_8205:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_8205:CallSelectExecute(role)
  if role.hp <= 0 then
    return
  end
  if role.belongNum == eBattleRoleBelong.player then
    self.role = role
    self.curCd = role:GetMainSkillCurCd()
    LuaSkillCtrl:CallEffect(role, self.config.effectId_reset, self)
    LuaSkillCtrl:CallReFillMainSkillCdForRole(role)
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1])
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId_2, 1, self.arglist[1])
  end
end

function bs_8205:OnAfterPlaySkill(skill, role)
  if role == self.role and skill.skillTag == eSkillTag.normalSkill and self.curCd ~= nil then
    LuaSkillCtrl:CallResetCDNumForRole(role, self.curCd)
    self.role = nil
    self.curCd = nil
  end
end

function bs_8205:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_8205
