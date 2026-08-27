local bs_50002 = class("bs_50002", LuaSkillBase)
local base = LuaSkillBase
bs_50002.config = {
  buffId = 1047,
  reBuffId = 1049,
  sheildBuffId = 174,
  effectId = 10371,
  shieldformula = 524
}

function bs_50002:ctor()
end

function bs_50002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local Value = self.caster.hp * 500 // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.LongRange, Value, self.config.shieldformula)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_50002_22", 1, self.OnBreakShield)
end

function bs_50002:OnBreakShield(shieldType, sender, target)
  if target == self.caster and shieldType == 1 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_50002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50002
