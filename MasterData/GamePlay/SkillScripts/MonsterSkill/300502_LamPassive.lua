local bs_300502 = class("bs_300502", LuaSkillBase)
local base = LuaSkillBase
bs_300502.config = {}

function bs_300502:ctor()
end

function bs_300502:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.lastSpeedOfs = 0
  self:OnCasterAttributeChange()
  self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_300502_attrObs", 1, self.OnCasterAttributeChange)
end

function bs_300502:OnCasterAttributeChange()
  if self.numtime == nil then
    self.numtime = 0
    self.ret_crit = 0
    self.speed_num = self.caster.speed
    self.crit_num = self.caster.crit
    self.critdamage_num = self.caster.critDamage
  end
  local change_spd = self.arglist[1] - self.caster.speed
  if self.numtime > 0 then
    self.speed_num = self.speed_num - change_spd
  end
  self.caster:AddRoleProperty(eHeroAttr.speed, change_spd, eHeroAttrType.Extra)
  self.numtime = self.numtime + 1
  if self.speed_num > self.arglist[1] then
    local ret_old = -self.ret_crit
    self.caster:AddRoleProperty(eHeroAttr.crit, ret_old, eHeroAttrType.Extra)
    local ret = self.speed_num - self.arglist[1]
    local ret_crit = Mathf.Min(1000, ret * self.arglist[3] // self.arglist[2])
    self.ret_crit = ret_crit
    self.caster:AddRoleProperty(eHeroAttr.crit, ret_crit, eHeroAttrType.Extra)
  else
    local ret_old = -self.ret_crit
    self.caster:AddRoleProperty(eHeroAttr.crit, ret_old, eHeroAttrType.Extra)
    self.ret_crit = 0
  end
end

function bs_300502:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_300502
