local FreeChoiceChestView, Super = NewClass("FreeChoiceChestView", BaseView)
FreeChoiceChestView.uiResCls = UI_Events_Popup_OptionalResource

function FreeChoiceChestView:ctor(chestItemTid, confirmCallback, isPreview)
  Super.ctor(self)
  self._chestItemTid = chestItemTid
  self._confirmCallback = confirmCallback
  self._isPreview = isPreview or false
end

function FreeChoiceChestView:OnBuildView()
  Super.OnBuildView(self)
  self._chestModel = FreeChoiceChestDataModel.Instance
  self._chestModel:SetChestItemTid(self._chestItemTid)
  self._chestController = FreeChoiceChestController.Instance
  DataCenter.itemData.IsRewardRandom = false
end

function FreeChoiceChestView:RegisterNotifications()
end

function FreeChoiceChestView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  if not self._isPreview and self.ui.Btn_Receive then
    self:AddButtonClickListener(self.ui.Btn_Receive, System.fn(self, self._BtnReceiveClickFunc))
  end
end

function FreeChoiceChestView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshText()
  self:_RefreshVisible()
  self:_InitTableview()
end

function FreeChoiceChestView:OnExitView()
  Super.OnExitView(self)
end

function FreeChoiceChestView:_RefreshText()
  local isAwakerChest = self._chestModel:IsAwakerChest()
  local isWeaponChest = self._chestModel:IsWeaponChest()
  if self._isPreview then
    if isAwakerChest then
      self:SetText(self.ui.Text_Title, LT.Text("AwakerPreviewTitle"))
      if self.ui.Text_Tips_Middle then
        self:SetText(self.ui.Text_Tips_Middle, LT.Text("AwakerSelectPreviewDetailTips"))
      end
    elseif isWeaponChest then
      self:SetText(self.ui.Text_Title, LT.Text("WeaponPreviewTitle"))
      if self.ui.Text_Tips_Middle then
        self:SetText(self.ui.Text_Tips_Middle, LT.Text("WeaponSelectPreviewDetailTips"))
      end
    else
      self:SetText(self.ui.Text_Title, LT.Text("AwakerChipChestPreviewTitle"))
      if self.ui.Text_Tips_Middle then
        self:SetText(self.ui.Text_Tips_Middle, LT.Text("AwakerSelectPreviewDetailTips"))
      end
    end
  elseif isAwakerChest then
    self:SetText(self.ui.Text_Title, LT.Text("AwakerSelectTitle"))
    if self.ui.Text_Tips_Left then
      self:SetText(self.ui.Text_Tips_Left, LT.Text("AwakerSelectUseDetailTips"))
    end
  elseif isWeaponChest then
    self:SetText(self.ui.Text_Title, LT.Text("WeaponSelectTitle"))
    if self.ui.Text_Tips_Left then
      self:SetText(self.ui.Text_Tips_Left, LT.Text("WeaponSelectUseDetailTips"))
    end
  else
    self:SetText(self.ui.Text_Title, LT.Text("AwakerChipSelectTitle"))
    if self.ui.Text_Tips_Left then
      self:SetText(self.ui.Text_Tips_Left, LT.Text("AwakerSelectUseDetailTips"))
    end
  end
  if not self._isPreview and self.ui.Btn_Receive then
    self:SetButtonText(self.ui.Btn_Receive, LT.Text("CommonReceive"))
  end
end

function FreeChoiceChestView:_RefreshVisible()
  if self.ui.Btn_Details then
    self.ui.Btn_Details:SetActive(false)
  end
  if self.ui.Group_Tips_Left then
    self.ui.Group_Tips_Left:SetActive(not self._isPreview)
  end
  if self.ui.Group_Tips_Middle then
    self.ui.Group_Tips_Middle:SetActive(self._isPreview)
  end
  if self.ui.Btn_Receive then
    self.ui.Btn_Receive:SetActive(not self._isPreview)
  end
end

function FreeChoiceChestView:_InitTableview()
  self.tableView = self:CreateTableview(self.ui.ScrollView, function()
    return #self._chestModel:GetItemInfos()
  end, function(view, idx)
    do return self._ItemCellAtIndex, self, view end
    return self._ItemCellAtIndex, self, view, idx
  end)
  self.tableView:ReloadData()
end

function FreeChoiceChestView:_ItemCellAtIndex(view, idx)
  local itemInfo = self._chestModel:GetItemInfoByIndex(idx)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Events_Item_Optional)
  self:AddViewComponentOnce(cell.gameObject, CompFreeChoiceChestItem, self._chestModel, itemInfo, idx, self._isPreview)
  return cell
end

function FreeChoiceChestView:_BtnReceiveClickFunc()
  local itemInfo = self._chestModel:GetCurrSelectedItemInfo()
  if not itemInfo then
    Alert.Show(10650)
    return
  end
  local itemCfg = DT.Item[itemInfo.tid]
  local tipCfg = DT.TipsType[20107]
  local title = LT.Text(tipCfg.Title)
  local desc = LT.Textf(tipCfg.Desc, LT.Text(itemCfg.Name))
  local extraParams = {
    pickItems = {
      [self._chestItemTid] = {
        choose = itemInfo.tid
      }
    }
  }
  Alert.Show(20107, nil, function()
    self._chestController:OnChooseItem(itemInfo, extraParams, self._confirmCallback)
  end, title, desc)
end

return FreeChoiceChestView
