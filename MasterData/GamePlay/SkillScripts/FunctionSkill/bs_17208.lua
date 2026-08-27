local bs_17208 = class("bs_17208", LuaSkillBase)
local base = LuaSkillBase
bs_17208.config = {
  buffId = 2203,
  summontag = 3,
  roletag = 2,
  effectId = 60617,
  HurtConfig = 4
}

function bs_17208:ctor()
end

function bs_17208:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_17208_2", 1, self.OnSetHurt, self.caster, nil, nil, eBattleRoleBelong.enemy)
end

function bs_17208:OnSetHurt(context)
  if context.hurt_tag == self.config.summontag and context.target.hp > 0 and context.target:GetBuffTier(self.config.buffId) < self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, context.target, self.config.buffId, 1, nil, true)
  end
  if context.hurt_tag == self.config.roletag and context.target.hp > 0 and context.target:GetBuffTier(self.config.buffId) == self.arglist[1] then
    LuaSkillCtrl:DispelBuff(context.target, self.config.buffId, 0, false)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
    LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.HurtConfig, {
      self.arglist[2]
    }, true)
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(context.target, self.config.effectId, self)
  end
end

function bs_17208:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17208
