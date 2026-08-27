local bs_21033 = class("bs_21033", LuaSkillBase)
local base = LuaSkillBase
bs_21033.config = {
  buffId = 3004,
  heal_config = {
    baseheal_formula = 10088,
    heal_number = 0,
    correct_formula = 9990
  }
}

function bs_21033:ctor()
end

function bs_21033:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_21033_2", 2, self.OnSelfAfterMove)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
end

function bs_21033:OnSelfAfterMove()
  if LuaSkillCtrl:GetRoleEfcGrid(self.caster) ~= 0 and self:IsReadyToTake() then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[1])
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true, true)
    skillResult:EndResult()
    self:OnSkillTake()
  end
end

function bs_21033:OnRoleSplash(role)
  if role == self.caster and LuaSkillCtrl:GetRoleEfcGrid(self.caster) ~= 0 and self:IsReadyToTake() then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[1])
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true, true)
    skillResult:EndResult()
    self:OnSkillTake()
  end
end

function bs_21033:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_21033
