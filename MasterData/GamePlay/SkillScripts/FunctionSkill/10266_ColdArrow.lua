local bs_10266 = class("bs_10266", LuaSkillBase)
local base = LuaSkillBase
bs_10266.config = {
  freezeBuff = 1178,
  freezeBuffDuration = 75,
  effectId = 10876
}

function bs_10266:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("10266_after_hurt", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.commonAttack, false)
  self.attackNum = 0
end

function bs_10266:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self:IsReadyToTake() and not isTriggerSet then
    self.attackNum = self.attackNum + 1
    self:CheckAndAddBuffToTarget(sender, target)
  end
end

function bs_10266:CheckAndAddBuffToTarget(sender, target)
  if target ~= nil and target.hp > 0 and sender ~= nil and sender.hp > 0 and self.attackNum >= self.arglist[1] then
    LuaSkillCtrl:CallEffect(target, self.config.effectId, self, self.SkillEventFunc)
    self:PlayChipEffect()
    self:OnSkillTake()
    self.attackNum = 0
  end
end

function bs_10266:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.freezeBuff, 1, self.config.freezeBuffDuration)
  end
end

function bs_10266:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10266
