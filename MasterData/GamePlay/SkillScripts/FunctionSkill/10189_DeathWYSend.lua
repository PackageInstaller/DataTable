local bs_10189 = class("bs_10189", LuaSkillBase)
local base = LuaSkillBase
bs_10189.config = {}

function bs_10189:ctor()
end

function bs_10189:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.RoleDie, "bs_10189_10", 1, self.OnRoleDie)
end

function bs_10189:OnRoleDie(killer, role)
  if killer == self.caster and role.belongNum == 2 and LuaSkillCtrl:GetRoleEfcGrid(role) == 10 then
    local grid = LuaSkillCtrl:GetGridWithRole(role)
    LuaSkillCtrl:CallEffect(self.caster, 10263, self)
    LuaSkillCtrl:SetRolePos(grid, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, 10264, self)
  end
end

function bs_10189:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10189
