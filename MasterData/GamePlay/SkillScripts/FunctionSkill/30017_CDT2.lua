local bs_30017 = class("bs_30017", LuaSkillBase)
local base = LuaSkillBase
bs_30017.config = {buffId = 1142, buffTier = 1}

function bs_30017:ctor()
end

function bs_30017:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30017_1", 2, self.OnAfterPlaySkill)
end

function bs_30017:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and not skill.isCommonAttack then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_30017:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30017
