local bs_107909 = class("bs_107909", LuaSkillBase)
local base = LuaSkillBase
bs_107909.config = {buffId = 107904, buffId_atkSpeed = 107905}

function bs_107909:ctor()
end

function bs_107909:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnDamageEnd, self.OnDamageEnd, self)
end

function bs_107909:OnDamageEnd(skill)
  if skill.caster == self.caster and self.caster:GetBuffTier(self.config.buffId) > 0 and skill.cskill.isNormalSkill then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_atkSpeed, 1, self.arglist[2], true)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 1, true)
  end
end

function bs_107909:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_107909
