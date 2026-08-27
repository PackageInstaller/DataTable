local bs_10040 = class("bs_10040", LuaSkillBase)
local base = LuaSkillBase
bs_10040.config = {buffId = 1005}

function bs_10040:ctor()
end

function bs_10040:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10040_1", 1, self.OnRoleDie)
end

function bs_10040:OnRoleDie(killer, role)
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.arglist[1], nil, true)
end

function bs_10040:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10040
