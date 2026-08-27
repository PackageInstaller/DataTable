local bs_15057 = class("bs_15057", LuaSkillBase)
local base = LuaSkillBase
bs_15057.config = {
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10076,
    crit_formula = 0
  },
  effectIdAttack = 10953
}

function bs_15057:ctor()
end

function bs_15057:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_15057_14", 90, self.OnSetHurt, nil, nil, self.caster.belongNum)
end

function bs_15057:OnSetHurt(context)
  if context.isCrit and self:IsReadyToTake() and context.target.belongNum ~= self.caster.belongNum then
    self:OnSkillTake()
    LuaSkillCtrl:CallEffect(context.target, self.config.effectIdAttack, self, self.SkillEventFunc)
  end
end

function bs_15057:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_15057:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15057
