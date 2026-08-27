local bs_10265 = class("bs_10265", LuaSkillBase)
local base = LuaSkillBase
bs_10265.config = {}

function bs_10265:ctor()
end

function bs_10265:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10265_10", 1, self.OnRoleDie)
end

function bs_10265:OnRoleDie(killer, role)
  if role.belongNum ~= self.caster.belongNum and role.belongNum ~= 0 then
    local healNum = role.maxHp * self.arglist[1] // 1000
    LuaSkillCtrl:CallHeal(healNum, self, self.caster, true)
    self:PlayChipEffect()
  end
end

function bs_10265:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10265
