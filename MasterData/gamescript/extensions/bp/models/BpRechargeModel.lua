local TaskServerIndex = CommonDefine.TaskServerIndex
local BpRechargeModel = NewClass("BpRechargeModel", BaseModel)
local BpPage = CommonDefine.BpPage

function BpRechargeModel:OnInit()
  self.showWeaponRewards = {}
  self.weaponList = {}
  self.chargeAdvanceRewards = self:GetChargeAdvanceRewards()
  self.chargeDLCRewards = self:GetChargeDLCRewards()
  self.rollWeaponIdx = 1
end

function BpRechargeModel:OnReset()
  self.showWeaponRewards = self:GetShowWeaponRewards()
  self.weaponList = self:GetWeaponList()
end

function BpRechargeModel:SetRollWeaponIdx(numVal)
  self.rollWeaponIdx = numVal
end

function BpRechargeModel:GetShowWeaponRewards()
  local rst = {}
  local dropId = DT.Item[DT.GetConstant("BPWeaponBoxId")].SpParam[1]
  local dropCfg = DT.Drop[dropId]
  for _, data in pairs(dropCfg.data_list) do
    table.insert(rst, data.DropItem)
  end
  table.sort(rst, function(a, b)
    local cfgA = ItemDataUtils.GetItemConfig(a)
    local cfgB = ItemDataUtils.GetItemConfig(b)
    if cfgA.Type ~= "Weapon" and cfgB.Type == "Weapon" then
      return false
    elseif cfgA.Type == "Weapon" and cfgB.Type ~= "Weapon" then
      return true
    end
    return cfgA.BaseSortID < cfgB.BaseSortID
  end)
  return rst
end

function BpRechargeModel:GetWeaponList()
  local rst = {}
  local dropId = DT.Item[DT.GetConstant("BPWeaponBoxId")].SpParam[1]
  local dropCfg = DT.Drop[dropId]
  for _, data in pairs(dropCfg.data_list) do
    if DT.Item[data.DropItem].Type == "Weapon" then
      table.insert(rst, data.DropItem)
    end
  end
  table.sort(rst, function(a, b)
    local aSort = ItemDataUtils.GetItemConfig(a).BaseSortID
    local bSort = ItemDataUtils.GetItemConfig(b).BaseSortID
    return aSort < bSort
  end)
  return rst
end

function BpRechargeModel:GetChargeAdvanceRewards()
  local rst = {}
  local cfgGroup = DT.Constant.BPBaseRewardTotal.Data
  for idx = 1, #cfgGroup - 1, 2 do
    local tid = cfgGroup[idx]
    local num = cfgGroup[idx + 1]
    table.insert(rst, {tid = tid, num = num})
  end
  return rst
end

function BpRechargeModel:GetChargeDLCRewards()
  local rst = {}
  local bpCfg = BattlePassDataUtils.GetBPConfig()
  if not bpCfg or not bpCfg.BPSeniorRewardTotal then
    return rst
  end
  local cfgGroup = bpCfg.BPSeniorRewardTotal
  for idx = 1, #cfgGroup - 1, 2 do
    local tid = cfgGroup[idx]
    local num = cfgGroup[idx + 1]
    table.insert(rst, {tid = tid, num = num})
  end
  return rst
end

return BpRechargeModel
