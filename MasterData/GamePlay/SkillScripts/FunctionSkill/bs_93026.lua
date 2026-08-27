local bs_93026 = class("bs_93026", LuaSkillBase)
local base = LuaSkillBase
bs_93026.config = {
  hurt_config1 = {
    hit_formula = 0,
    crit_formula = 9992,
    basehurt_formula = 502
  },
  hurt_config2 = {
    hit_formula = 0,
    crit_formula = 9992,
    basehurt_formula = 502
  },
  effectIdAttack = 10953
}

function bs_93026:ctor()
end

function bs_93026:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_93026_1", 1, self.OnAfterHurt, nil, self.caster, eBattleRoleBelong.enemy)
  self.pow_Num = 0
  self.skill_intensity_Num = 0
end

function bs_93026:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss then
    self.pow_Num = target.pow * self.arglist[1] // 1000
    self.skill_intensity_Num = target.skill_intensity * self.arglist[1] // 1000
    self:OnSkillTake()
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(sender, self.config.effectIdAttack, self, self.SkillEventFunc)
  end
end

function bs_93026:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if self.pow_Num >= self.skill_intensity_Num then
      LuaSkillCtrl:CallRealDamage(self, target, nil, self.config.hurt_config1, {
        self.pow_Num
      }, true)
    else
      LuaSkillCtrl:CallRealDamage(self, target, nil, self.config.hurt_config2, {
        self.skill_intensity_Num
      }, true)
    end
  end
end

function bs_93026:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93026
