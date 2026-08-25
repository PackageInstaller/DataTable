local KeeperSkillModel, Super = NewClass("KeeperSkillModel", BaseModel)
local EnergyAttrs = {
  keeper_energy = true,
  max_keeper_energy = true,
  keeper_energy_cost_per = true,
  max_keeper_energy_per = true
}

function KeeperSkillModel:ctor()
  Super.ctor(self)
end

function KeeperSkillModel:OnInit()
  self:OnReset()
end

function KeeperSkillModel:OnReset()
  self._selectedSkillId = 0
  self._usedSkillId = 0
  self._selectSchool = 0
end

function KeeperSkillModel:GetKeeperSkillOneRingCost()
  local max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
  local keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
  return max_keeper_energy * (1 + keeper_energy_cost_per / 100)
end

function KeeperSkillModel:GetKeeperSkillEnergyLevel(keeper_energy)
  local oneRingCost = self:GetKeeperSkillOneRingCost()
  local rst = math.floor(keeper_energy / oneRingCost)
  rst = math.max(CommonDefine.KeeperSkillEnergyMinLevel, rst)
  rst = math.min(CommonDefine.KeeperSkillEnergyMaxLevel, rst)
  return rst
end

function KeeperSkillModel:GetKeeperSkillCostPercent(keeper_energy)
  local oneRingCost = self:GetKeeperSkillOneRingCost()
  if 0 == keeper_energy or 0 == oneRingCost then
    return 0
  end
  return keeper_energy % oneRingCost / oneRingCost
end

function KeeperSkillModel:GetKeeperSkillPercent()
  local keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy") or 0
  local max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
  local keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
  local max_energy = max_keeper_energy * (1 + keeper_energy_cost_per / 100)
  if max_energy <= 0 then
    return 0
  end
  return keeper_energy / max_energy
end

function KeeperSkillModel:GetKeeperChargePercent()
  local max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
  local max_keeper_energy_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy_per") or 0
  local keeper_energy = math.max(CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy") or 0, max_keeper_energy)
  local keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
  local skill_keeper_energy = max_keeper_energy * (1 + keeper_energy_cost_per / 100)
  local max_keeper_energy_overlay = max_keeper_energy * (1 + max_keeper_energy_per / 100) * (1 + keeper_energy_cost_per / 100)
  if keeper_energy - skill_keeper_energy <= 0 or max_keeper_energy_overlay - skill_keeper_energy <= 0 then
    return 0
  end
  return (keeper_energy - skill_keeper_energy) / (max_keeper_energy_overlay - skill_keeper_energy)
end

function KeeperSkillModel:GetKeeperChargeEnergy(roleInfo)
  local keeper_energy = roleInfo.keeper_energy()
  local max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
  local keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
  return keeper_energy * 10000 + max_keeper_energy * 1000000 + keeper_energy_cost_per * 100
end

function KeeperSkillModel:GetSelectedSkillId()
  return self._selectedSkillId
end

function KeeperSkillModel:GetUsedSkillId()
  return self._usedSkillId
end

function KeeperSkillModel:GetSelectedSchool()
  return self._selectSchool
end

function KeeperSkillModel:SetSelectedSkillId(selectedSkillId)
  self._selectedSkillId = selectedSkillId
  self:LocalNotify(NotifyId.OnKeeperSkillSelectedSkillIdChanged, self._selectedSkillId)
end

function KeeperSkillModel:SetUsedSkillId(usedSkillId)
  if self._usedSkillId == usedSkillId then
    return
  end
  self._usedSkillId = usedSkillId
  self:LocalNotify(NotifyId.OnKeeperSkillUsedSkillIdChanged, self._usedSkillId)
end

function KeeperSkillModel:SetSelectedSchool(schoolId)
  if self._selectSchool == schoolId then
    return
  end
  self._selectSchool = schoolId
end

function KeeperSkillModel:OnPlayerAttrsSynced(data)
  for attrType in pairs(data) do
    if EnergyAttrs[attrType] then
      self:LocalNotify(NotifyId.OnKeeperSkillEnergyChanged)
      return
    end
  end
end

return KeeperSkillModel
