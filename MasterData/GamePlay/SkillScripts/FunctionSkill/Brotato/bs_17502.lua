local bs_17502 = class("bs_17502", LuaSkillBase)
local base = LuaSkillBase
bs_17502.config = {buffId = 2251}

function bs_17502:ctor()
end

function bs_17502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_17502", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, nil, false)
end

function bs_17502:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if isMiss or not self:IsReadyToTake() then
    return
  end
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[3], true, nil, true)
  self:OnSkillTake()
end

function bs_17502:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17502
