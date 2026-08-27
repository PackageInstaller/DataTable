local bs_50015 = class("bs_50015", LuaSkillBase)
local base = LuaSkillBase
bs_50015.config = {
  buffId = 1144,
  reBuffId = 1049,
  sheildBuffId = 174,
  effectId = 10373,
  shieldformula = 523
}

function bs_50015:ctor()
end

function bs_50015:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local Value = self.caster.hp * 150 // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.NoRange, Value, self.config.shieldformula)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_50015_22", 1, self.OnBreakShield)
end

function bs_50015:OnBreakShield(shieldType, sender, target)
  if target == self.caster and shieldType == 2 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_50015:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50015
