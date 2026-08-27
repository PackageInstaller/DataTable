local bs_10010 = class("bs_10010", LuaSkillBase)
local base = LuaSkillBase
bs_10010.config = {
  hurt_config = {basehurt_formula = 10076},
  effectIdAttack = 1006
}

function bs_10010:ctor()
end

function bs_10010:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10010_3", 1, self.OnAfterHurt, self.caster)
end

function bs_10010:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] and not isTriggerSet then
    local targetL = self.caster.recordTable.lastAttackRole
    if targetL ~= nil then
      self:PlayChipEffect()
      self.caster:LookAtTarget(targetL)
      LuaSkillCtrl:CallEffect(targetL, self.config.effectIdAttack, self, self.SkillEventFunc)
    end
  end
end

function bs_10010:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10010:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10010
