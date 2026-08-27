local bs_10202 = class("bs_10202", LuaSkillBase)
local base = LuaSkillBase
bs_10202.config = {
  hurt_config = {def_formula = 9996, basehurt_formula = 10018},
  aoe_config = {
    effect_shape = 3,
    aoe_select_code = 4,
    aoe_range = 1
  },
  effectId = 10504
}

function bs_10202:ctor()
end

function bs_10202:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10202_2", 1, self.OnSetHurt, self.caster)
end

function bs_10202:OnSetHurt(context)
  if context.sender == self.caster and context.target.belongNum == 0 and context.target.intensity == 0 and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and self:IsReadyToTake() and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self, self.SkillEventFunc)
  end
end

function bs_10202:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    self:OnSkillTake()
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, nil, true)
    skillResult:EndResult()
  end
end

function bs_10202:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10202
