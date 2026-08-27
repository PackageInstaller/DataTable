local bs_10017 = class("bs_10017", LuaSkillBase)
local base = LuaSkillBase
bs_10017.config = {
  hurt_config = {basehurt_formula = 10007},
  effectIdAttack = 1006
}

function bs_10017:ctor()
end

function bs_10017:InitSkill(isMidwaySkill)
  self:AddAfterHealTrigger("bs_10017_5", 1, self.OnAfterHeal, nil, self.caster)
end

function bs_10017:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] and not isTriggerSet then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallEffect(targetList, self.config.effectIdAttack, self, self.SkillEventFunc)
  end
end

function bs_10017:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10017:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10017
