local RandomChestAwakerView, Super = NewClass("RandomChestAwakerView", RandomChestBaseView)

function RandomChestAwakerView:_RefreshTxt()
  if self.ui.Group_Tips_Left and self.ui.Group_Tips_Middle then
    self:SetText(self.ui.Text_Tips_Left, LT.Text("AwakerSelectUseDetailTips"))
    self:SetText(self.ui.Text_Tips_Middle, LT.Text("AwakerSelectPreviewDetailTips"))
  end
  self.ui.Btn_Receive:SetActive(not self.isPreview)
  if self.isPreview then
    self:SetText(self.ui.Text_Title, LT.Text("AwakerPreviewTitle"))
    return
  end
  self:SetButtonText(self.ui.Btn_Receive, LT.Text("RandomChestTipConfirmBtnTxt"))
  self:SetText(self.ui.Text_Title, LT.Text("AwakerRandomChestTipTitle"))
end

function RandomChestAwakerView:_GetShowItemTidList()
  local rst = {}
  if not self.itemCfg or CommonDefine.ItemSubType.AwakerRandomChest ~= self.itemCfg.SubType then
    return rst
  end
  local dropTid = self.itemCfg.SpParam and self.itemCfg.SpParam[1]
  rst = DropDataUtils.GetDropItemTids(dropTid)
  local dropIdxDict = {}
  for idx, itemTid in ipairs(rst) do
    dropIdxDict[itemTid] = idx
  end
  table.sort(rst, function(a, b)
    local awakerTidA = ItemDataUtils.GetAwakerTidByItemTid(a)
    local awakerTidB = ItemDataUtils.GetAwakerTidByItemTid(b)
    local ownedWeightA = AwakerDataUtils.HasOwnedAwaker(awakerTidA) and 1 or 0
    local ownedWeightB = AwakerDataUtils.HasOwnedAwaker(awakerTidB) and 1 or 0
    if ownedWeightA ~= ownedWeightB then
      return ownedWeightA < ownedWeightB
    end
    local idxA = dropIdxDict[a]
    local idxB = dropIdxDict[b]
    return idxA < idxB
  end)
  return rst
end

function RandomChestAwakerView:_CellItemAtIndex(cell, index)
  local itemTid = self.showItemTidList[index]
  local viewData = {isSelect = false, awakerItemTid = itemTid}
  self:AddViewComponentOnce(cell.gameObject, CompSelectAwakerItem, viewData)
end

function RandomChestAwakerView:_OnUseItemSuccessful(svrData)
  Super._OnUseItemSuccessful(self)
end

return RandomChestAwakerView
