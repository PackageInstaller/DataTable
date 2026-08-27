local bs_10149 = class("bs_10149", LuaSkillBase)
local base = LuaSkillBase
bs_10149.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10076,
    crit_formula = 0
  },
  effectIdAttack = 10254
}

function bs_10149:ctor()
end

function bs_10149:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10149_3", 1, self.OnAfterHurt, nil, nil, nil, self.caster.belongNum)
end

function bs_10149:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.belongNum == self.caster.belongNum and isMiss and sender.belongNum ~= self.caster.belongNum then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(sender, self.config.effectIdAttack, self, self.SkillEventFunc)
  end
end

function bs_10149:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10149:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10149
