local bs_212101 = class("bs_212101", LuaSkillBase)
local base = LuaSkillBase
bs_212101.config = {
  buffId_pow = 212101,
  buffId_skill_intensity = 212102,
  debuff_def = 212104
}

function bs_212101:ctor()
end

function bs_212101:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_212101", 1, self.OnAfterHurt, nil, self.caster)
  self.caster.recordTable.def = false
  self.caster.recordTable.def_intensity = false
end

function bs_212101:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self.caster.recordTable.P2 == true and 0 < hurt and self.caster.recordTable.def == false and self.caster.recordTable.def_intensity == false and 0 >= self.caster:GetBuffTier(self.config.debuff_def) then
    local target_pow = LuaSkillCtrl:CallTargetSelect(self, 15, 10)
    local target_skill_intensity = LuaSkillCtrl:CallTargetSelect(self, 54, 10)
    if 0 < target_pow.Count and 0 < target_skill_intensity.Count then
      if target_pow[0].targetRole.pow >= target_skill_intensity[0].targetRole.skill_intensity then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_pow, 1, nil, true)
        self.caster.recordTable.def = true
      else
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_skill_intensity, 1, nil, true)
        self.caster.recordTable.def_intensity = true
      end
    end
  end
end

function bs_212101:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_212101
