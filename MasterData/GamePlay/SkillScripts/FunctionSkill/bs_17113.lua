local bs_17113 = class("bs_17113", LuaSkillBase)
local base = LuaSkillBase
bs_17113.config = {
  hurt_config = {basehurt_formula = 10007},
  effectIdAttack = 1006
}

function bs_17113:ctor()
end

function bs_17113:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTriggerForTable("bs_17113_03", 1, self.OnAfterHurt, {
    targetBelongNum = eBattleRoleBelong.player,
    extraArg2 = false,
    senderBelongNum = eBattleRoleBelong.enemy
  })
end

function bs_17113:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target.belongNum == eBattleRoleBelong.player and not isTriggerSet and sender.belongNum == eBattleRoleBelong.enemy and target.career == 1 and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] and self:IsReadyToTake() then
    LuaSkillCtrl:CallEffect(sender, self.config.effectIdAttack, self, self.SkillEventFunc)
  end
end

function bs_17113:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_17113:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17113
