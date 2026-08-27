local bs_10211 = class("bs_10211", LuaSkillBase)
local base = LuaSkillBase
bs_10211.config = {
  effectId = 1050,
  buffId = 1059,
  hurt_config = {basehurt_formula = 10076}
}

function bs_10211:ctor()
end

function bs_10211:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10211_12", 1, self.OnAfterPlaySkill)
end

function bs_10211:OnAfterPlaySkill(skill, role)
  if not skill.maker:IsUnSelect(self.caster) and skill.maker.belongNum ~= self.caster.belongNum and not skill.isCommonAttack and not skill.isPassive then
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(skill.maker, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_10211:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10211:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10211
