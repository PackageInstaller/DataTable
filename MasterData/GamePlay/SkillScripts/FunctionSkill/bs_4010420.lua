local bs_4010420 = class("bs_4010420", LuaSkillBase)
local base = LuaSkillBase
bs_4010420.config = {buffId = 1227, duration = 90}

function bs_4010420:ctor()
end

function bs_4010420:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4010420", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, nil)
end

function bs_4010420:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss or hurtType ~= eHurtType.MagicDmg or isTriggerSet or sender ~= self.caster then
    return
  end
  local range = LuaSkillCtrl:CallRange(1, 1000)
  if range <= self.arglist[1] and self:IsReadyToTake() then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.config.duration, true)
    self:OnSkillTake()
  end
end

function bs_4010420:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010420
