local bs_100301 = class("bs_100301", LuaSkillBase)
local base = LuaSkillBase
bs_100301.config = {effectId_pass = 100306, audioId_pass = 100308}

function bs_100301:ctor()
end

function bs_100301:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_100301_2", 1, self.OnSetHurt, nil, self.caster)
end

function bs_100301:OnSetHurt(context)
  if context.target == self.caster and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[2] and context.skill.dataId ~= 202003 and context.isTriggerSet ~= true and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and context.skill.SkillRange ~= nil and 1 < context.skill.SkillRange then
    LuaSkillCtrl:CallEffect(self.caster, self.config.effectId_pass, self)
    context.hurt = context.hurt * (1000 - self.arglist[1]) // 1000
  end
end

function bs_100301:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_100301
