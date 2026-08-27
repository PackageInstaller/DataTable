local bs_17106 = class("bs_17106", LuaSkillBase)
local base = LuaSkillBase
bs_17106.config = {buffId = 2030, buffTier = 1}

function bs_17106:ctor()
end

function bs_17106:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_17106_1", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_17106:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, self.arglist[3], true)
    self:PlayChipEffect()
  end
end

function bs_17106:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17106
