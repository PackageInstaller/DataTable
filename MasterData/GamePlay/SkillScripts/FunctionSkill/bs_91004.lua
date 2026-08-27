local bs_91004 = class("bs_91004", LuaSkillBase)
local base = LuaSkillBase
bs_91004.config = {buffId = 2004, buffTier = 1}

function bs_91004:ctor()
end

function bs_91004:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_91004_1", 1, self.OnAfterPlaySkill)
end

function bs_91004:OnAfterPlaySkill(skill, role)
  if not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_91004:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_91004
