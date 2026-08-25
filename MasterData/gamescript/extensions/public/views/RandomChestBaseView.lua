local RandomChestBaseView, Super = NewClass("RandomChestBaseView", BaseView)
RandomChestBaseView.uiResCls = UI_Events_Popup_Optional_OptimizedResource

function RandomChestBaseView:ctor(itemTid, isPreview)
  Super.ctor(self)
  self.itemTid = itemTid
  self.itemCfg = ItemCfgUtils.GetCfg(itemTid)
  self.showItemTidList = self:_GetShowItemTidList()
  self.isPreview = isPreview or false
end

function RandomChestBaseView:OnEnterView()
  Super.OnEnterView(self)
  DataCenter.itemData.IsRewardRandom = 1
  if not table.next(self.showItemTidList) then
    return
  end
  self.ui.Btn_Details:SetActive(false)
  self:_RefreshView()
end

function RandomChestBaseView:_CellItemAtIndex()
end

function RandomChestBaseView:_RefreshTxt()
end

function RandomChestBaseView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Receive, System.fn(self, self._OnClickReceive))
  self:_CreateTableView()
end

function RandomChestBaseView:_OnClickReceive()
  local subType = self.itemCfg and self.itemCfg.SubType
  local tipsId
  if subType == CommonDefine.ItemSubType.AwakerRandomChest then
    tipsId = "AwakerRandomChestConfirm"
  else
    tipsId = "WeaponRandomChestConfirm"
  end
  local desc = LT.Textf(DT.TipsType[tipsId].Desc, LT.Text(ItemCfgUtils.GetCfgField("Name", self.itemTid)))
  Alert.Show(tipsId, nil, function()
    ItemDataUtils.ReqOnUseItem(self.itemTid, 1, System.fn(self, self._OnUseItemSuccessful))
  end, nil, desc)
end

function RandomChestBaseView:_OnUseItemSuccessful()
  self.CloseByTimer = true
  TimerManager.Instance:CreateTimer(1, 0, nil, function()
    self:Close()
  end)
end

function RandomChestBaseView:Close()
  if not self.CloseByTimer then
    DataCenter.itemData.IsRewardRandom = nil
  end
  Super.Close(self)
end

function RandomChestBaseView:_GetShowItemTidList()
  return {}
end

function RandomChestBaseView:_RefreshView()
  self:_RefreshTxt()
  self.ui.Btn_Receive:SetActive(not self.isPreview)
  if self.ui.Group_Tips_Left and self.ui.Group_Tips_Middle then
    self.ui.Group_Tips_Left:SetActive(not self.isPreview)
    self.ui.Group_Tips_Middle:SetActive(self.isPreview)
  end
  self.showListView:ReloadData()
end

function RandomChestBaseView:_RefreshTxt()
  self:SetButtonText(self.ui.Btn_Receive, LT.Text("RandomChestTipConfirmBtnTxt"))
  self:SetText(self.ui.Text_Title, LT.Text("WeaponRandomChestTipTitle"))
end

function RandomChestBaseView:_CreateTableView()
  self.showListView = self:CreateTableview(self.ui.ScrollView, function()
    if not self.showItemTidList then
      return 0
    end
    return #self.showItemTidList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Events_Item_Optional)
    self:_CellItemAtIndex(cell, index)
    self:_BindCellDetailInteraction(cell, index)
    return cell
  end)
end

function RandomChestBaseView:_BindCellDetailInteraction(cell, index)
  local itemTid = self.showItemTidList[index]
  if not itemTid then
    return
  end
  local cellGO = cell.gameObject
  local cellUI = UI_Events_Item_OptionalResource(cellGO)
  local btnComp = cellUI.Btn_Click
  if self.isPreview then
    self:RemoveShortPressButtonListener(btnComp)
    self:AddButtonClickListener(btnComp, function()
      local itemData = ItemDataUtils.GetItemByTid(itemTid)
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.TipsParentNode, itemData and itemData.uid, itemTid)
    end)
  else
    self:SetLongPressButtonIntervalTime(btnComp, tonumber(DT.GetConstant("ItemAddPressTime")))
    self:AddLongPressButtonListener(btnComp, function()
      local itemData = ItemDataUtils.GetItemByTid(itemTid)
      ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.TipsParentNode, itemData and itemData.uid, itemTid)
    end)
  end
end

return RandomChestBaseView
