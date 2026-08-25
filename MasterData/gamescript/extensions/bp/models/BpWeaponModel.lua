local TaskServerIndex = CommonDefine.TaskServerIndex
local BpWeaponModel = NewClass("BpWeaponModel", BaseModel)
local BpPage = CommonDefine.BpPage

function BpWeaponModel:OnInit()
  self.chooseItemTid = 0
  self.showWeaponRewards = self:GetShowWeaponRewards()
  self.weaponList = self:GetWeaponList()
end

function BpWeaponModel:OnReset()
end

function BpWeaponModel:SetChooseItemTid(tid)
  self.chooseItemTid = tid
  self:LocalNotify(NotifyId.OnBpWeaponViewWeaponChanged, tid)
end

function BpWeaponModel:GetShowWeaponRewards()
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

function BpWeaponModel:GetWeaponList()
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

return BpWeaponModel
