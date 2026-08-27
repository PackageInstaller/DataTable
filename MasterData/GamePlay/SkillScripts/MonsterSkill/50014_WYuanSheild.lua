local bs_50014 = class("bs_50014", LuaSkillBase)
local base = LuaSkillBase
bs_50014.config = {
  buffId = 1143,
  reBuffId = 1049,
  sheildBuffId = 174,
  effectId = 10371,
  shieldformula = 524
}

function bs_50014:ctor()
end

function bs_50014:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  local Value = self.caster.hp * 150 // 1000
  LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.LongRange, Value, self.config.shieldformula)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_50014_22", 1, self.OnBreakShield)
end

function bs_50014:OnBreakShield(shieldType, sender, target)
  if target == self.caster and shieldType == 1 then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_50014:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_50014
