local bs_20116 = class("bs_20116", LuaSkillBase)
local base = LuaSkillBase
bs_20116.config = {effectId = 10335}

function bs_20116:ctor()
end

function bs_20116:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_20116_2", 2, self.OnAfterPlaySkill)
end

function bs_20116:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    local damage = self.caster.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:RemoveLife(damage, self, self.caster, true, nil, true, true)
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self)
  end
end

function bs_20116:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20116
