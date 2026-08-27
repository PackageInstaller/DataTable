local bs_10013 = class("bs_10013", LuaSkillBase)
local base = LuaSkillBase
bs_10013.config = {
  effectId = 1009,
  aoe_config = {
    effect_shape = 1,
    aoe_select_code = 4,
    aoe_range = 10
  },
  buffId = 67,
  defBuffId = 92,
  buffTier = 1
}

function bs_10013:ctor()
end

function bs_10013:InitSkill(isMidwaySkill)
end

function bs_10013:PlaySkill()
  self:PlayChipEffect()
  LuaSkillCtrl:CallEffect(self.caster, self.config.effectId, self, self.SkillEventFunc)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.defBuffId, self.arglist[2], self.arglist[1])
end

function bs_10013:SkillEventFunc(effect, eventId, target)
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, self.config.aoe_config)
    skillResult:BuffResult(self.config.buffId, self.config.buffTier, self.arglist[1])
    skillResult:EndResult()
  end
end

function bs_10013:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10013
