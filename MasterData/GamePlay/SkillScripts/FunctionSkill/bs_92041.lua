local bs_92041 = class("bs_92041", LuaSkillBase)
local base = LuaSkillBase
bs_92041.config = {buffId = 2029, buffTier = 1}

function bs_92041:ctor()
end

function bs_92041:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_92041_1", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_92041:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, self.arglist[3], true)
    self:PlayChipEffect()
  end
end

function bs_92041:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92041
