local bs_10011 = class("bs_10011", LuaSkillBase)
local base = LuaSkillBase
bs_10011.config = {
  hurt_config = {basehurt_formula = 10007},
  effectIdAttack = 1006
}

function bs_10011:ctor()
end

function bs_10011:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10011_3", 1, self.OnAfterHurt, self.caster)
end

function bs_10011:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] and not isTriggerSet then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallEffect(targetList, self.config.effectIdAttack, self, self.SkillEventFunc)
  end
end

function bs_10011:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10011:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10011
