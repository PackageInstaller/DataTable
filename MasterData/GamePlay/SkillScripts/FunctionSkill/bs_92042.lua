local bs_92042 = class("bs_92042", LuaSkillBase)
local base = LuaSkillBase
bs_92042.config = {buffId = 2030, buffTier = 1}

function bs_92042:ctor()
end

function bs_92042:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_92042_1", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_92042:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, nil, true)
    self:PlayChipEffect()
  end
end

function bs_92042:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92042
