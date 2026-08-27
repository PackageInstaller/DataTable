local bs_17014 = class("bs_17014", LuaSkillBase)
local base = LuaSkillBase
bs_17014.config = {
  buffId = 2098,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 3010,
    crit_formula = 0
  },
  effectId = 10936,
  effectIdAttack = 10936,
  buffTier = 1
}

function bs_17014:ctor()
end

function bs_17014:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10002_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
end

function bs_17014:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and skill.isCommonAttack and not isTriggerSet then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:CallEffect(target, self.config.effectIdAttack, self, self.SkillEventFunc)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {
      self.arglist[1]
    }, true)
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, 90, false)
    skillResult:EndResult()
  end
end

function bs_17014:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17014
