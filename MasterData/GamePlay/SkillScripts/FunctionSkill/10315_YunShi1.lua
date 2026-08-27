local bs_10315 = class("bs_10315", LuaSkillBase)
local base = LuaSkillBase
bs_10315.config = {ysBuff = 1227, ysBuffDuration = 90}

function bs_10315:ctor()
end

function bs_10315:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("10314_after_hurt", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack)
  self.attackNum = 0
end

function bs_10315:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self:IsReadyToTake() and not isTriggerSet then
    self.attackNum = self.attackNum + 1
    self:CheckAndAddBuffToTarget(sender, target)
  end
end

function bs_10315:CheckAndAddBuffToTarget(sender, target)
  if target ~= nil and target.hp > 0 and sender ~= nil and sender.hp > 0 and self.attackNum >= self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, target, self.config.ysBuff, 1, self.config.ysBuffDuration)
    self:PlayChipEffect()
    self:OnSkillTake()
    self.attackNum = 0
  end
end

function bs_10315:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10315
