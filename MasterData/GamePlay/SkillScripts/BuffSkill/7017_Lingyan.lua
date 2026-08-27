local bs_7010 = class("bs_7010", LuaSkillBase)
local base = LuaSkillBase
bs_7010.config = {
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
  buffId = 2098
}

function bs_7010:ctor()
end

function bs_7010:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  self.timer = LuaSkillCtrl:StartTimer(nil, self.arglist[1], arriveCallBack, self, -1)
end

function bs_7010:OnArriveAction()
  if self.timer ~= nil and self.timer:IsOver() then
    self.timer = nil
  end
  local skillCaster = LuaSkillCtrl:GetPlayerRoleEntity()
  local flag = false
  local addArg = 0
  if skillCaster ~= nil then
    flag = skillCaster.recordTable["25200_Flag"]
    addArg = skillCaster.recordTable["25200_arg"]
  end
  local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 54, 20)
  if highAttRole ~= nil and 0 < highAttRole.Count and highAttRole[0] ~= nil then
    local skill_intensity = highAttRole[0].targetRole.skill_intensity
    local buffTier = self.caster:GetBuffTier(self.config.buffId)
    local damageArg = skill_intensity * buffTier
    if flag then
      damageArg = damageArg * (1000 + addArg) // 1000
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.HurtConfig, {damageArg}, true, true)
    skillResult:EndResult()
  end
end

function bs_7010:OnSkillRemove()
  base.OnSkillRemove(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

function bs_7010:OnCasterDie()
  base.OnCasterDie(self)
  if self.timer ~= nil then
    self.timer:Stop()
    self.timer = nil
  end
end

return bs_7010
