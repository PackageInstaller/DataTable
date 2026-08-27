local bs_10133 = class("bs_10133", LuaSkillBase)
local base = LuaSkillBase
bs_10133.config = {buffId = 2170, buffTier = 1}

function bs_10133:ctor()
end

function bs_10133:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10133_1", 1, self.OnRoleDie)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRevengeCall, self.eventFunc)
  self.rand_flag = 3
  local cm = LuaSkillCtrl:GetPlayerRoleEntity()
  if cm.recordTable["30043"] == nil then
    cm.recordTable["30043"] = {}
    for i = 1, 5 do
      cm.recordTable["30043"][i] = -1
    end
  end
  cm.recordTable["30043"][self.rand_flag] = self.rand_flag
end

function bs_10133:OnRoleDie(killer, role)
  if role.belongNum == self.caster.belongNum and self:IsReadyToTake() then
    self:PlayChipEffect()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, self.arglist[2], true)
    self:OnSkillTake()
  end
end

function bs_10133:eventFunc(killer, role, tb)
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

function bs_10133:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10133
