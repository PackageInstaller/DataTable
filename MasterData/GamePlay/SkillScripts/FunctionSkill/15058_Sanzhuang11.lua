local bs_15058 = class("bs_15058", LuaSkillBase)
local base = LuaSkillBase
bs_15058.config = {buffId = 1247}

function bs_15058:ctor()
end

function bs_15058:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_15058_13", 1, self.OnAfterPlaySkill)
end

function bs_15058:OnAfterPlaySkill(skill, role)
  if not skill.isCommonAttack and role == self.caster then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[1], true)
  end
end

function bs_15058:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15058
