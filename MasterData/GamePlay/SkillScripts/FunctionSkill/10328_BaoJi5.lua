local bs_10328 = class("bs_10328", LuaSkillBase)
local base = LuaSkillBase
bs_10328.config = {buffId = 1265, buffTier = 1}

function bs_10328:ctor()
end

function bs_10328:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10328_1", 1, self.OnAfterHurt, self.caster)
  self.times = 0
end

function bs_10328:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isCrit then
    self.times = self.times + 1
    if self.times >= self.arglist[1] then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
      self.times = 0
    end
  end
end

function bs_10328:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10328
