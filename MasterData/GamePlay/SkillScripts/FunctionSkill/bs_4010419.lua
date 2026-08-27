local bs_4010419 = class("bs_4010419", LuaSkillBase)
local base = LuaSkillBase
bs_4010419.config = {buffId = 195, duration = 75}

function bs_4010419:ctor()
end

function bs_4010419:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_4010419", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, nil, false)
end

function bs_4010419:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if isMiss or hurtType ~= eHurtType.PhysicsDmg or isTriggerSet or sender ~= self.caster then
    return
  end
  local range = LuaSkillCtrl:CallRange(1, 1000)
  if range <= self.arglist[1] and self:IsReadyToTake() then
    LuaSkillCtrl:CallBuff(self, target, self.config.buffId, 1, self.config.duration, true)
    self:OnSkillTake()
  end
end

function bs_4010419:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_4010419
