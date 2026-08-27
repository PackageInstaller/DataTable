local bs_210803 = class("bs_210803", LuaSkillBase)
local base = LuaSkillBase
bs_210803.config = {buffId_power = 210801, configId = 5}

function bs_210803:ctor()
end

function bs_210803:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_210803", 99, self.OnSetHurt, self.caster, nil, self.caster.belongNum, nil, nil, nil, nil, nil, false)
end

function bs_210803:OnSetHurt(context)
  if context.target.belongNum ~= self.caster.belongNum and context.hurt > 0 and context.isTriggerSet ~= true then
    local num = self.caster:GetBuffTier(self.config.buffId_power)
    if 0 < num then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.target)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId, {
        self.arglist[1] * num
      }, true)
      skillResult:EndResult()
    end
  end
end

function bs_210803:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_210803
