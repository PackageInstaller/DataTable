local bs_105704 = class("bs_105704", LuaSkillBase)
local base = LuaSkillBase
bs_105704.config = {buffId = 105702, buffId1 = 105706}

function bs_105704:ctor()
end

function bs_105704:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDamageEnd, self.OnDamageEnd, self)
end

function bs_105704:OnDamageEnd(skill)
  if skill.caster == self.caster and self.caster:GetBuffTier(self.config.buffId) > 0 and skill.cskill.isNormalSkill then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1)
  end
  if skill.caster == self.caster and 0 < self.caster:GetBuffTier(self.config.buffId1) and skill.cskill.isNormalSkill then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId1, 1)
  end
end

function bs_105704:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_105704
