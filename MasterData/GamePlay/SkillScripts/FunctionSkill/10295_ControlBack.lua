local bs_10295 = class("bs_10295", LuaSkillBase)
local base = LuaSkillBase
bs_10295.config = {buffId = 26}

function bs_10295:ctor()
end

function bs_10295:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10295_2", 1, self.OnSetHurt, nil, self.caster)
end

function bs_10295:OnSetHurt(context)
  if context.target == self.caster and self:IsReadyToTake() and context.skill.isCommonAttack and not context.isTriggerSet and LuaSkillCtrl:CallRange(1, 1000) < self.arglist[1] then
    LuaSkillCtrl:CallBuff(self, context.sender, self.config.buffId, 1, self.arglist[2])
  end
end

function bs_10295:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10295
