local bs_93023 = class("bs_93023", LuaSkillBase)
local base = LuaSkillBase
bs_93023.config = {buffId = 2027, buffTier = 1}

function bs_93023:ctor()
end

function bs_93023:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_93023_1", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_93023:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss then
    if target:GetBuffTier(self.config.buffId) < self.arglist[2] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, self.arglist[3], true)
    else
      LuaSkillCtrl:DispelBuff(target, self.config.buffId, 0)
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.arglist[2], self.arglist[3], true)
    end
    self:PlayChipEffect()
  end
end

function bs_93023:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93023
