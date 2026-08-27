local bs_20300 = class("bs_20300", LuaSkillBase)
local base = LuaSkillBase
bs_20300.config = {}

function bs_20300:ctor()
end

function bs_20300:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddOnRoleDieTrigger("bs_20300_1", 1, self.OnRoleDie)
end

function bs_20300:OnRoleDie(killer, role)
  if role ~= self.caster and role.belongNum == self.caster.belongNum then
    local healNum = self.caster.maxHp * self.arglist[2] // 1000
    LuaSkillCtrl:CallHeal(healNum, self, self.caster)
  end
end

function bs_20300:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20300
