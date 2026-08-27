local bs_10016 = class("bs_10016", LuaSkillBase)
local base = LuaSkillBase
bs_10016.config = {
  hurt_config = {basehurt_formula = 10007},
  effectIdAttack = 10120
}

function bs_10016:ctor()
end

function bs_10016:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10016_3", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_10016:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] then
    self:PlayChipEffect()
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallEffect(targetList, self.config.effectIdAttack, self, self.SkillEventFunc)
  end
end

function bs_10016:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10016:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10016
