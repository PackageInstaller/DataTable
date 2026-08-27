local bs_10065 = class("bs_10065", LuaSkillBase)
local base = LuaSkillBase
bs_10065.config = {
  buffId = 103,
  buffTier = 1,
  damageFormula = 10006,
  shieldKey = "10165_HuDun"
}

function bs_10065:ctor()
end

function bs_10065:InitSkill(isMidwaySkill)
  self:AddSetHurtTrigger("bs_10065_2", 1, self.OnSetHurt, nil, self.caster, nil, nil, nil, 1)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10065_10", 1, self.OnRoleDie)
  self:AddLuaTrigger(eSkillLuaTrigger.OnRevengeCall, self.eventFunc)
  self.caster.recordTable.sheildValue_10044 = 0
  self.rand_flag = 4
  local cm = LuaSkillCtrl:GetPlayerRoleEntity()
  if cm.recordTable["30043"] == nil then
    cm.recordTable["30043"] = {}
    for i = 1, 5 do
      cm.recordTable["30043"][i] = -1
    end
  end
  cm.recordTable["30043"][self.rand_flag] = self.rand_flag
end

function bs_10065:OnSetHurt(context)
end

function bs_10065:OnRoleDie(killer, role)
  if self.caster.belongNum == role.belongNum and role.roleType == 1 then
    self:PlayChipEffect()
    local sheildValue = LuaSkillCtrl:CallFormulaNumberWithSkill(self.config.damageFormula, role, role, self)
    LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, sheildValue)
  end
end

function bs_10065:eventFunc(killer, role, tb)
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

function bs_10065:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10065
