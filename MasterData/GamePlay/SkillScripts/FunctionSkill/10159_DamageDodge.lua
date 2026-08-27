local bs_10159 = class("bs_10159", LuaSkillBase)
local base = LuaSkillBase
bs_10159.config = {buffId = 1008}

function bs_10159:ctor()
end

function bs_10159:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10159_3", 1, self.OnAfterHurt, self.caster)
end

function bs_10159:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and not isMiss and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[3] then
    local layer = self.caster:GetBuffTier(self.config.buffId)
    self:PlayChipEffect()
    if layer ~= self.arglist[2] then
      if layer + self.arglist[1] <= self.arglist[2] then
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
      elseif layer + self.arglist[1] > self.arglist[2] then
        LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
        LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[2], nil, true)
      end
    end
  end
end

function bs_10159:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10159
