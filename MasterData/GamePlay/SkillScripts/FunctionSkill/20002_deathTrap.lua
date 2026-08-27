local bs_20002 = class("bs_20002", LuaSkillBase)
local base = LuaSkillBase
bs_20002.config = {}

function bs_20002:ctor()
end

function bs_20002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.RoleDie, "bs_20002_10", 1, self.OnRoleDie)
end

function bs_20002:OnRoleDie(killer, role)
  if killer == self.caster and role.belongNum == 2 and LuaSkillCtrl:GetRoleEfcGrid(role) == 10 then
    local grid = LuaSkillCtrl:GetGridWithRole(role)
    LuaSkillCtrl:CallEffect(self.caster, 10263, self)
    LuaSkillCtrl:SetRolePos(grid, self.caster)
    LuaSkillCtrl:CallEffect(self.caster, 10264, self)
  end
end

function bs_20002:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20002
