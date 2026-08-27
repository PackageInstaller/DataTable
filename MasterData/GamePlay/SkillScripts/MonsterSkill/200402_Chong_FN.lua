local bs_200402 = class("bs_200402", LuaSkillBase)
local base = LuaSkillBase
bs_200402.config = {buffId_1005 = 1005}

function bs_200402:ctor()
end

function bs_200402:InitSkill(isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_200402_10", 1, self.OnRoleDie)
end

function bs_200402:OnRoleDie(killer, role)
  if killer == self.caster and role.belongNum == 1 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId_1005, self.arglist[1], nil, true)
  end
end

function bs_200402:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_200402
