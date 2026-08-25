local RandomChestWeaponView, Super = NewClass("RandomChestWeaponView", RandomChestBaseView)

function RandomChestWeaponView:_RefreshTxt()
  if self.ui.Group_Tips_Left and self.ui.Group_Tips_Middle then
    self:SetText(self.ui.Text_Tips_Left, LT.Text("WeaponSelectUseDetailTips"))
    self:SetText(self.ui.Text_Tips_Middle, LT.Text("WeaponSelectPreviewDetailTips"))
  end
  self.ui.Btn_Receive:SetActive(not self.isPreview)
  if self.isPreview then
    self:SetText(self.ui.Text_Title, LT.Text("WeaponPreviewTitle"))
    return
  end
  self:SetButtonText(self.ui.Btn_Receive, LT.Text("RandomChestTipConfirmBtnTxt"))
  self:SetText(self.ui.Text_Title, LT.Text("WeaponRandomChestTipTitle"))
end

function RandomChestWeaponView:_GetShowItemTidList()
  local rst = {}
  if not self.itemCfg or CommonDefine.ItemSubType.WeaponRandomChest ~= self.itemCfg.SubType then
    return rst
  end
  local dropTid = self.itemCfg.SpParam and self.itemCfg.SpParam[1]
  rst = DropDataUtils.GetDropItemTids(dropTid)
  local dropIdxDict = {}
  for idx, itemTid in ipairs(rst) do
    dropIdxDict[itemTid] = idx
  end
  table.sort(rst, function(a, b)
    local ownedWeightA = ItemDataUtils.GetItemNum(a) > 0 and 1 or 0
    local ownedWeightB = ItemDataUtils.GetItemNum(b) > 0 and 1 or 0
    if ownedWeightA ~= ownedWeightB then
      return ownedWeightA < ownedWeightB
    end
    local idxA = dropIdxDict[a]
    local idxB = dropIdxDict[b]
    return idxA < idxB
  end)
  return rst
end

function RandomChestWeaponView:_CellItemAtIndex(cell, index)
  local itemTid = self.showItemTidList[index]
  local weaponData = ItemDataUtils.GetItemByTid(itemTid)
  local viewData = {
    isSelect = false,
    weaponTid = itemTid,
    refineLevel = weaponData and weaponData.level,
    weaponUid = weaponData and weaponData.uid
  }
  self:AddViewComponentOnce(cell.gameObject, CompSelectWeaponItem, viewData)
end

return RandomChestWeaponView
