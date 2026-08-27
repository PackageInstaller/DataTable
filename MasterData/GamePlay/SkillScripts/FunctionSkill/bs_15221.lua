local bs_15221 = class("bs_15221", LuaSkillBase)
local base = LuaSkillBase
bs_15221.config = {buffId = 110118}

function bs_15221:ctor()
end

function bs_15221:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterPlaySkillTrigger("bs_15221_01", 1, self.OnAfterPlaySkill, self.caster)
end

function bs_15221:OnAfterPlaySkill(skill, role)
  if skill.isCommonAttack and role == self.caster then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  elseif not skill.isCommonAttack and role == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_15221:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15221
