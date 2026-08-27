local bs_10293 = class("bs_10293", LuaSkillBase)
local base = LuaSkillBase
bs_10293.config = {
  buffId1 = 1203,
  buffId2 = 1121,
  buffTier = 1
}

function bs_10293:ctor()
end

function bs_10293:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10293_10", 1, self.OnRoleDie)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRevengeCall, self.eventFunc)
  self.rand_flag = 2
  local cm = LuaSkillCtrl:GetPlayerRoleEntity()
  if cm.recordTable["30043"] == nil then
    cm.recordTable["30043"] = {}
    for i = 1, 5 do
      cm.recordTable["30043"][i] = -1
    end
  end
  cm.recordTable["30043"][self.rand_flag] = self.rand_flag
end

function bs_10293:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum and role.roleType == 1 then
    self:PlayChipEffect()
    if self.caster.attackRange == 1 then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, self.arglist[1], false)
    else
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, self.arglist[1], false)
    end
  end
end

function bs_10293:eventFunc(killer, role, tb)
  local isCastable = false
  for i = 1, #tb do
    if tb[i] == self.rand_flag then
      isCastable = true
      break
    end
  end
  if not isCastable then
    return
  end
  self:OnRoleDie(killer, role)
end

function bs_10293:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10293
