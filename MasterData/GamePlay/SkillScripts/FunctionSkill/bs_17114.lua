local bs_17114 = class("bs_17114", LuaSkillBase)
local base = LuaSkillBase
bs_17114.config = {effectId = 12113, buffId = 2143}

function bs_17114:ctor()
end

function bs_17114:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTriggerForTable("bs_17114_2", 2, self.OnAfterPlaySkill, {
    sender = self.caster,
    extraArg1 = eSkillTag.normalSkill
  })
end

function bs_17114:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.isNormalSkill then
    local shieldValue = self.caster.pow * self.arglist[1] // 1000
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue, nil, true)
  end
end

function bs_17114:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17114
