local bs_17501 = class("bs_17501", LuaSkillBase)
local base = LuaSkillBase
bs_17501.config = {
  effectId = 12209,
  buffId = 2250,
  HurtConfigId = 56,
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 4
  }
}

function bs_17501:ctor()
end

function bs_17501:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_17501", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, nil, false)
end

function bs_17501:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if isMiss or not self:IsReadyToTake() then
    return
  end
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillEventFunc)
end

function bs_17501:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    self:OnSkillTake()
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, self.config.aoe_config)
    if skillResult.roleList ~= nil and skillResult.roleList.Count > 1 then
      for i = 0, skillResult.roleList.Count - 1 do
        LuaSkillCtrl:CallBuff(self, skillResult.roleList[i], self.config.buffId, 1, 7, false, nil, false)
      end
    end
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfigId, {
      self.arglist[1]
    })
    skillResult:EndResult()
  end
end

function bs_17501:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17501
