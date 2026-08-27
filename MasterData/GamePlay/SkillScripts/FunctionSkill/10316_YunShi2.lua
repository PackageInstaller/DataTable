local bs_10316 = class("bs_10316", LuaSkillBase)
local base = LuaSkillBase
bs_10316.config = {ysBuff = 1227, ysBuffDuration = 90}

function bs_10316:ctor()
end

function bs_10316:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("10315_after_hurt", 1, self.OnAfterHurt, nil, self.caster)
end

function bs_10316:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self:IsReadyToTake() and not isTriggerSet then
    self:CheckAndAddBuffToTarget(sender, target)
  end
end

function bs_10316:CheckAndAddBuffToTarget(sender, target)
  if target ~= nil and target.hp > 0 and sender ~= nil and sender.hp > 0 and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, sender, self.config.ysBuff, 1, self.config.ysBuffDuration)
    self:PlayChipEffect()
    self:OnSkillTake()
    self.attackNum = 0
  end
end

function bs_10316:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10316
