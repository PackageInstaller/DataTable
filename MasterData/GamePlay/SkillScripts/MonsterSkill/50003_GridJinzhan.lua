local bs_50003 = class("bs_50003", LuaSkillBase)
local base = LuaSkillBase
bs_50003.config = {
  buffId = 1048,
  reBuffId = 1049,
  sheildBuffId = 174,
  effectId = 10373,
  shieldKey = "50003_HuDun",
  shieldformula = 523
}

function bs_50003:ctor()
end

function bs_50003:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local Value = self.caster.hp * 500 // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.NoRange, Value, self.config.shieldformula)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_50003_22", 1, self.OnBreakShield)
end

function bs_50003:OnBreakShield(shieldType, sender, target)
  if target == self.caster and shieldType == 2 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_50003:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50003
