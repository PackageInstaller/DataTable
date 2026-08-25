local ItemSubType = CommonDefine.ItemSubType
local ItemUseController, Super = NewClass("ItemUseController", BaseController)

function ItemUseController:OnInit()
end

function ItemUseController:OnReset()
end

function ItemUseController:CheckOpenItemUseView(uid)
  local item = ItemDataUtils.GetItemByUid(uid)
  if ItemCfgUtils.IsAwakerChest(item.tid) or ItemCfgUtils.IsWeaponChest(item.tid) then
    UIManager.Instance:Reopen(Urls.FreeChoiceChestView, item.tid)
    return
  end
  if ItemCfgUtils.IsAwakerRandomChest(item.tid) then
    UIManager.Instance:Reopen(Urls.RandomChestAwakerView, item.tid)
    return
  end
  if ItemCfgUtils.IsWeaponRandomChest(item.tid) then
    UIManager.Instance:Reopen(Urls.RandomChestWeaponView, item.tid)
    return
  end
  local cfg = DT.Item[item.tid]
  if cfg.Type == CommonDefine.ItemType.Material then
    if cfg.SubType == ItemSubType.FastPromotion then
      local awakerList = ItemDataUtils.GetItemLevelUpAwakerList(uid, false)
      if #awakerList > 0 then
        UIManager.Instance:Reopen(Urls.AwakerLevelUpItemUseView, uid)
      else
        Alert.Show(10552)
      end
    end
  elseif cfg.Type == CommonDefine.ItemType.Special then
    if cfg.SubType == ItemSubType.BackTrack then
      UIManager.Instance:Reopen(Urls.BackTrackSelectPanel, item.tid)
    elseif cfg.SubType == ItemSubType.AwakerChipChest then
      UIManager.Instance:Reopen(Urls.FreeChoiceChestView, item.tid)
    elseif cfg.SubType == ItemSubType.CosmeticsChest then
      local miniUseCount = ItemDataUtils.GetMinUseCount(item.tid)
      local num = ItemDataUtils.GetBagItemNum(item.tid)
      if miniUseCount > num then
        Alert.Show(10651)
        return
      end
      UIManager.Instance:Reopen(Urls.UI_Bag_Panel_AppearancePreview, item.tid, true)
    elseif cfg.SubType == ItemSubType.CosmeticsRandChest then
      local miniUseCount = ItemDataUtils.GetMinUseCount(item.tid)
      local num = ItemDataUtils.GetBagItemNum(item.tid)
      if miniUseCount > num then
        Alert.Show(10651)
      else
        self:OnOpenItemUseView(item.tid)
      end
    else
      self:OnOpenItemUseView(item.tid)
    end
  end
end

function ItemUseController:OnOpenItemUseView(itemId, afterUseCallback)
  if itemId == DT.GetConstant("EnergyPotionItemTid") and not ItemDataUtils.CheckCanAddEnergy() then
    Alert.Show(10736)
    return
  end
  local url = Urls.ItemUsePanel
  if itemId == DT.GetConstant("EnergyPotionItemTid") then
    url = Urls.EnergyItemUsePanel
  end
  UIManager.Instance:Reopen(url, itemId, afterUseCallback)
end

function ItemUseController:ReqUseItem(itemId, addNum, afterUseCallback)
  local function DoUseItem()
    ItemDataUtils.ReqOnUseItem(itemId, addNum)
    
    local url = Urls.ItemUsePanel
    if itemId == DT.GetConstant("EnergyPotionItemTid") then
      url = Urls.EnergyItemUsePanel
    end
    UIManager.Instance:CloseByUrl(url)
    if afterUseCallback then
      afterUseCallback()
    end
  end
  
  if ItemDataUtils.IsItemsForChoose(itemId) then
    local panelData = {itemId = itemId, useNum = addNum}
    UIManager.Instance:Reopen(Urls.ItemUseSelectPanel, panelData)
    UIManager.Instance:CloseByUrl(Urls.ItemUsePanel)
    return
  end
  local EnergyPotionItemTid = DT.GetConstant("EnergyPotionItemTid")
  if EnergyPotionItemTid == itemId then
    local energyItemNum = tonumber(DT.GetConstant("ReplenishEnergyItemRestoreNum"))
    local addValue = energyItemNum * addNum
    if addValue > 0 and GetEnergyCheckUtils.EnergyIsOverMax(addValue) then
      GetEnergyCheckUtils.TipsShow(DoUseItem)
      return
    end
  end
  DoUseItem()
end

function ItemUseController:ReqFastPromotion(itemUid, awakerTid, successCallback)
  Logger.Debug("GameRequest OnFastPromotion", itemUid, awakerTid)
  ProtoManager.Instance:ReqServer("GameRequest", "OnFastPromotion", function()
    if successCallback then
      successCallback()
    end
  end, function()
    Logger.Warning("OnFastPromotion failed, itemUid:", itemUid, "awakerTid:", awakerTid)
  end, itemUid, awakerTid)
end

return ItemUseController
