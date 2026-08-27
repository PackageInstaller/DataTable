local bs_10235 = class("bs_10235", LuaSkillBase)
local base = LuaSkillBase
bs_10235.config = {
  buffId = 1088,
  heal_config = {
    baseheal_formula = 10006,
    heal_number = 0,
    correct_formula = 9990
  },
  effectId = 10635,
  debuffId = 1119
}

function bs_10235:ctor()
end

function bs_10235:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.time = self.arglist[2]
  self:AddSetHealTrigger("bs_10235_1", 1000, self.OnSetHeal, self.caster, nil, nil, eBattleRoleBelong.player)
end

function bs_10235:OnSetHeal(context)
  if context.target.belongNum == 1 and context.sender == self.caster and self:IsReadyToTake() and self.time > 0 and not context.isTriggerSet then
    self:OnSkillTake()
    local buffTier = context.target:GetBuffTier(self.config.buffId)
    if 0 < buffTier then
      LuaSkillCtrl:CallBuff(self, context.target, self.config.debuffId, 1, 3)
      LuaSkillCtrl:DispelBuff(context.target, self.config.buffId, 0)
      LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
      self.config.heal_config.isTriggerSet = true
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, nil, true)
      skillResult:EndResult()
      self:PlayChipEffect()
      self.time = self.time - 1
    end
  end
end

function bs_10235:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10235
