local bs_10267 = class("bs_10267", LuaSkillBase)
local base = LuaSkillBase
bs_10267.config = {
  freezeBuff = 1178,
  freezeBuffDuration = 75,
  effectId = 10876,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 10077,
    crit_formula = 0
  },
  formulaId = 10077
}

function bs_10267:InitSkill(isMidwaySkill)
  self:AddAfterHurtTrigger("10267_after_hurt", 1, self.OnAfterHurt, nil, nil, nil, eBattleRoleBelong.player)
end

function bs_10267:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if self:IsReadyToTake() and not isTriggerSet then
    if sender == nil or sender.hp <= 0 or sender == target then
      return
    end
    local hitChance = LuaSkillCtrl:CallRange(1, 1000)
    if hitChance <= self.arglist[1] then
      self:PlayChipEffect()
      LuaSkillCtrl:CallEffect(sender, self.config.effectId, self, self.SkillEventFunc)
      self:OnSkillTake()
    end
  end
end

function bs_10267:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, self.config.freezeBuff, 1, self.config.freezeBuffDuration)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config)
    skillResult:EndResult()
  end
end

function bs_10267:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10267
