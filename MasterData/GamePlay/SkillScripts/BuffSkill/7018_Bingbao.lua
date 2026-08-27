local bs_7018 = class("bs_7018", LuaSkillBase)
local base = LuaSkillBase
bs_7018.config = {
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 10183,
    minhurt_formula = 0,
    crit_formula = 0,
    correct_formula = 0,
    lifesteal_formula = 0,
    spell_lifesteal_formula = 0,
    returndamage_formula = 0
  },
  buffId = 2097,
  effectId2 = 10883
}

function bs_7018:ctor()
end

function bs_7018:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffHitMaxTierTrigger("bs_7018_1", 1, self.OnBuffHitMaxTier, nil, self.caster, nil, nil, self.config.buffId)
end

function bs_7018:OnBuffHitMaxTier(buff, role, isOverlay, maxTier)
  if role ~= nil and role.hp > 0 then
    local flag = false
    local addArg = 0
    local skillCaster = LuaSkillCtrl:GetPlayerRoleEntity()
    if skillCaster ~= nil then
      flag = skillCaster.recordTable["25200_Flag"]
      addArg = skillCaster.recordTable["25200_arg"]
    end
    local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 70, 100)
    if highAttRole ~= nil and 0 < highAttRole.Count and highAttRole[0] ~= nil then
      local skill_intensity = highAttRole[0].targetRole.skill_intensity
      local damageArg = skill_intensity
      if flag then
        damageArg = damageArg * (1000 + addArg) // 1000
      end
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {damageArg}, true, true)
      skillResult:EndResult()
      LuaSkillCtrl:CallEffect(role, self.config.effectId2, self)
      LuaSkillCtrl:DispelBuff(role, self.config.buffId, 0, true)
    end
  end
end

function bs_7018:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_7018
