local bs_5033 = class("bs_5033", LuaSkillBase)
local base = LuaSkillBase
bs_5033.config = {buffId = 503301, effectId_reset = 503101}

function bs_5033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_5033_3", 1, self.OnAfterPlaySkill)
end

function bs_5033:CheckManualSkillTakeAvailable(role)
  if role.roleType ~= eBattleRoleType.character then
    return false
  end
  return base.CheckManualSkillTakeAvailable(self, role)
end

function bs_5033:PlaySkill(data, selectTargetCoord, selectRoles)
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

function bs_5033:CallSelectExecute(role)
  if role.hp <= 0 then
    return
  end
  if role.belongNum == eBattleRoleBelong.player then
    self.role = role
    self.curCd = role:GetMainSkillCurCd()
    LuaSkillCtrl:CallEffect(role, self.config.effectId_reset, self)
    LuaSkillCtrl:CallReFillMainSkillCdForRole(role)
    LuaSkillCtrl:CallBuff(self, role, self.config.buffId, 1, self.arglist[1])
  end
end

function bs_5033:OnAfterPlaySkill(skill, role)
  if role == self.role and skill.skillTag == eSkillTag.normalSkill and self.curCd ~= nil then
    LuaSkillCtrl:CallResetCDNumForRole(role, self.curCd)
    self.role = nil
    self.curCd = nil
  end
end

function bs_5033:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_5033
