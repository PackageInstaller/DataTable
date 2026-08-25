local TrinketUpgradeUsingMatSlotComp, Super = System.NewComponent("TrinketUpgradeUsingMatSlotComp")

function TrinketUpgradeUsingMatSlotComp:ctor(go, strengthenModel, commonIconItemModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Item_Weapon_Refining_ItemResource(go)
  self.strengthenModel = strengthenModel
  self.commonIconItemModel = commonIconItemModel
  self.itemNumNode = nil
end

function TrinketUpgradeUsingMatSlotComp:OnBind(binder)
  self.binder = binder
  
  local function GetItemNumStr(matData)
    local ownedItemNum = ItemDataUtils.GetItemNum(matData.tid)
    local numStr
    if ownedItemNum < matData.num then
      numStr = string.format("<color=%s>%d</color>/%d", DT.ColorConfig.Red.Light, ownedItemNum, matData.num)
    else
      numStr = ownedItemNum .. "/" .. matData.num
    end
    return numStr
  end
  
  binder:BindToRaw(function(childBinder, n, _)
    local matData = n
    childBinder:SetActive(self.ui.UI_Common_Item_WuPin_Type1, nil ~= matData and matData.num > 0)
    if not matData or 0 == matData.num then
      return
    end
    local numStr = GetItemNumStr(matData)
    local itemData = {
      tid = matData.tid,
      num = numStr,
      model = self.commonIconItemModel,
      strengthenModel = self.strengthenModel
    }
    local comp = childBinder:BindComponent(TrinketUpgradeUsingMatComp(self.ui.UI_Common_Item_WuPin_Type1, itemData))
    self.itemNumNode = comp.ui.Text_Article_Number
  end, function()
    return self.strengthenModel.trinketUpgradeCostItem
  end)
  binder:BindEvent(EventMgr.Instance.UpdateBagEvent, function(items)
    if not self.itemNumNode then
      return
    end
    local matCost = self.strengthenModel.trinketConversionMatCost
    for k, v in pairs(items) do
      for i = 1, #matCost do
        if matCost[i].tid == v.tid then
          local matData = self.strengthenModel.trinketUpgradeCostItem
          local numStr = GetItemNumStr(matData)
          binder:SetText(self.itemNumNode, numStr)
          break
        end
      end
    end
  end)
end

return TrinketUpgradeUsingMatSlotComp
