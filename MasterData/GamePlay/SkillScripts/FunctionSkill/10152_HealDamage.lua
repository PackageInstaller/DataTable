local bs_10152 = class("bs_10152", LuaSkillBase)
local base = LuaSkillBase
bs_10152.config = {
  realDamageConfig = {
    basehurt_formula = 10046,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0
  },
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  aoe_config1 = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 2
  },
  effectId = 10257,
  effectId2 = 10256,
  effectId3 = 10902
}

function bs_10152:ctor()
end

function bs_10152:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHealTrigger("bs_10152_5", 1, self.OnAfterHeal, self.caster)
end

function bs_10152:OnAfterHeal(sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  if self:IsReadyToTake() and not isTriggerSet and sender == self.caster then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    if self.caster.recordTable["30041_Flag"] then
      skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config1)
    end
    if skillResult.roleList.Count > 0 then
      if self.caster.recordTable["30041_Flag"] then
        LuaSkillCtrl:CallEffect(target, self.config.effectId3, self, self.SkillEventFunc)
      else
        LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
      end
      self:OnSkillTake()
    end
  end
end

function bs_10152:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    if target.targetRole.hp <= 0 then
      return
    end
    local targetPow = self.caster.skill_intensity
    local targetSunder = self.caster.magic_pen
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    if self.caster.recordTable["30041_Flag"] then
      targetPow = targetPow + targetPow * self.caster.recordTable["30041_arg"] // 1000
      skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config1)
    end
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.realDamageConfig, {targetPow, targetSunder}, true)
    if 0 < skillResult.roleList.Count then
      for i = 0, skillResult.roleList.Count - 1 do
        local role = skillResult.roleList[i]
        if not LuaSkillCtrl:IsFixedObstacle(role) then
          LuaSkillCtrl:CallEffect(role, self.config.effectId2, self)
        end
      end
    end
    skillResult:EndResult()
  end
end

function bs_10152:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10152
