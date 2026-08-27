local bs_17503 = class("bs_17503", LuaSkillBase)
local base = LuaSkillBase
bs_17503.config = {buffId = 2251}

function bs_17503:ctor()
end

function bs_17503:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_17501", 1, self.OnAfterHurt, nil, self.caster, nil, nil, nil, nil, nil, nil, false)
end

function bs_17503:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  if isMiss or not self:IsReadyToTake() then
    return
  end
  local heal_num = self.caster.maxHp * self.arglist[1] // 1000
  LuaSkillCtrl:CallHeal(heal_num, self, self.caster, true, self.caster, false, true)
  self:OnSkillTake()
end

function bs_17503:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_17503
