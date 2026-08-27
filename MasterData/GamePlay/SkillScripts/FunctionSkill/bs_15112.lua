local bs_15112 = class("bs_15112", LuaSkillBase)
local base = LuaSkillBase
bs_15112.config = {
  buffId = 1287,
  buffTier = 1,
  buffDuration = 75
}

function bs_15112:ctor()
end

function bs_15112:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRoleSplash, self.OnRoleSplash)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRolePhaseMoveStart, self.OnRolePhaseMoveStart)
end

function bs_15112:OnRoleSplash(role, grid)
  if role.belongNum == self.caster.belongNum and role.roleType == eBattleRoleType.character then
    self:AddBuffBJ(role)
  end
end

function bs_15112:OnRolePhaseMoveStart(role, luaskill)
  if role.belongNum == self.caster.belongNum and role.roleType == eBattleRoleType.character then
    self:AddBuffBJ(role)
  end
end

function bs_15112:AddBuffBJ(role)
  LuaSkillCtrl:CallBuff(self, role, self.config.buffId, self.config.buffTier, self.config.buffDuration, true)
end

function bs_15112:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15112
