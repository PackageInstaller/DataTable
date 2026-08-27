local Feature_1064 = class("Feature_1064", LuaSkillBase)
local base = LuaSkillBase
Feature_1064.config = {
  buffId = 2100,
  AOE_config = {
    effect_shape = 3,
    aoe_select_code = 5,
    aoe_range = 1
  },
  hurt_config = 5,
  effect = 10866
}

function Feature_1064:ctor()
end

function Feature_1064:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local pf = LuaSkillCtrl:GetGuardProfession()
  self:AddSetHurtTrigger("Feature_1064_1", 1, self.OnSetHurt, self.caster, pf, nil, nil, nil, nil, nil, nil, nil)
  LuaSkillCtrl:CallStartLocalScale(self.caster, Vector3.New(1.4, 1.4, 1.4), 0.1)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true, nil, true)
end

function Feature_1064:OnSetHurt(context)
  context.hurt = context.hurt + context.hurt * self.arglist[1] // 1000
end

function Feature_1064:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:CallBattleCamShakeByParam(0, 0.3, 0.6, 50)
  local target = LuaSkillCtrl:GetTargetWithGrid(self.caster.x, self.caster.y)
  LuaSkillCtrl:CallEffect(self.caster, self.config.effect, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, self.config.AOE_config)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurt_config, {
    self.arglist[2]
  })
  skillResult:EndResult()
end

return Feature_1064
