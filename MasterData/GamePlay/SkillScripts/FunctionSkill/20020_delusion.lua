local bs_20020 = class("bs_20020", LuaSkillBase)
local base = LuaSkillBase
bs_20020.config = {buffId = 26}

function bs_20020:ctor()
end

function bs_20020:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_20020_2", 90, self.OnSetHurt, nil, self.caster)
end

function bs_20020:OnSetHurt(context)
  if context.target == self.caster and self:IsReadyToTake() and context.sender ~= self.caster and context.skill.isCommonAttack and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, context.sender, self.config.buffId, 1, self.arglist[2])
  end
end

function bs_20020:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20020
