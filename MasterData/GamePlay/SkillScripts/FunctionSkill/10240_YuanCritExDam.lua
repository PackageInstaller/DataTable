local bs_10240 = class("bs_10240", LuaSkillBase)
local base = LuaSkillBase
bs_10240.config = {
  realDamageConfig = {basehurt_formula = 10076},
  buffId2 = 1125
}

function bs_10240:ctor()
end

function bs_10240:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10240_2", 1000, self.OnSetHurt, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10240_1", 2, self.OnAfterBattleStart)
end

function bs_10240:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_10240:OnSetHurt(context)
  if context.sender == self.caster and context.isCrit and not context.isTriggerSet and self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:CallRealDamage(self, context.target, nil, self.config.realDamageConfig, nil, true)
  end
end

function bs_10240:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10240
