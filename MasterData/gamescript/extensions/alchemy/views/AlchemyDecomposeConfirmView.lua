local ScrollView_Short_Pos_Y = -100
local ScrollView_Long_Pos_Y = -30
local Content_Long_Height = 634
local Content_Short_Height = 494
local AlchemyDecomposeConfirmView, Super = NewClass("AlchemyDecomposeConfirmView", BaseView)
AlchemyDecomposeConfirmView.uiResCls = UI_Alchemy_Popup_Break_DownResource
local itemType2ConfirtTipsMap = {
  [CommonDefine.ItemType.Trinket] = LT.Text("AlchemyDecomposeTrinketConfirmTIps"),
  [CommonDefine.ItemType.Weapon] = LT.Text("AlchemyDecomposeWeaponConfirmTIps")
}

function AlchemyDecomposeConfirmView:ctor(confirmCb, model)
  Super.ctor(self)
  self.model = model
  self.confirmCb = confirmCb
  self:_InitViewData()
end

function AlchemyDecomposeConfirmView:RegisterNotifications()
  self:_InitDecomposeListView()
end

function AlchemyDecomposeConfirmView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self.OnClickConfirm))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.OnClickCancel))
end

function AlchemyDecomposeConfirmView:_InitDecomposeListView()
  self.decomposeListView = self:CreateTableview(self.ui.ScrollView, function()
    if not self.showItemDataGroup then
      return 0
    end
    return #self.showItemDataGroup
  end, function(view, index)
    do return self._DecomposeItemCellAtIndex, self, view end
    return self._DecomposeItemCellAtIndex, self, view, index
  end)
  
  function self.decomposeListView.reloadFinishCallback()
    self.decomposeListView.reloadFinishCallback = nil
    self:_CenterRewardTableViewIfNeeded()
  end
  
  self.decomposeListView:ReloadData()
end

function AlchemyDecomposeConfirmView:_DecomposeItemCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type1)
  local itemData = self.showItemDataGroup[index]
  local tid = itemData.tid
  local uid = itemData.uid
  
  local function clickCb()
    ItemDataUtils.ShowItemDetailTips(self.binder, cell.gameObject, uid, tid, true)
  end
  
  local viewData = {
    tid = tid,
    uid = uid,
    num = itemData._showNum or 1,
    clickCb = clickCb,
    alchemyItemType = AlchemyDefine.AlchemyItemType.DecompositeConvertItem
  }
  self:AddViewComponentOnce(cell.gameObject, CompAlchemyBaseItem, viewData)
  return cell
end

function AlchemyDecomposeConfirmView:_CenterRewardTableViewIfNeeded()
  self:CenterTableviewContentIfNeeded(self.ui.ScrollView, self.decomposeListView, #(self.showItemDataGroup or {}), self.ui.UI_Common_Item_WuPin_Type1.transform.sizeDelta.x)
end

function AlchemyDecomposeConfirmView:OnEnterView()
  Super.OnEnterView(self)
  self.ui.Image_Container:SetActive(self:_CheckContainImportantItem())
  self:SetText(self.ui.Text_Host_Title, LT.Text(DT.TipsType[10633].Title))
  self:SetText(self.ui.Text_Tips, self:_GetTips())
  self:SetText(self.ui.Text_Number_1, self._carculateVerificationData.addends_1)
  self:SetText(self.ui.Text_Number_2, self._carculateVerificationData.addends_2)
  self:SetButtonText(self.ui.Btn_Confirm, LT.Text("UniversalConfirmButton"))
  self:SetButtonText(self.ui.Btn_Cancel, LT.Text("UniversalCancelButton"))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddInputValueChangeListener(self.ui.InputField_Account, function()
    self._inputSum = self:GetInputText(self.ui.InputField_Account)
    self:RefreshView()
  end)
  CS.Framework.TransformUtil.SetHeight(self.ui.Content.transform, self:_CheckContainImportantItem() and Content_Short_Height or Content_Long_Height)
  CS.Framework.TransformUtil.SetAnchoredPos(self.ui.ScrollView.transform, self.ui.ScrollView.transform.anchoredPosition.x, self:_CheckContainImportantItem() and ScrollView_Short_Pos_Y or ScrollView_Long_Pos_Y)
  self:RefreshView()
end

function AlchemyDecomposeConfirmView:RefreshView()
  local btnState = CommonDefine.BtnType.Unclickable
  if not self:_CheckContainImportantItem() or self._inputSum ~= "" then
    btnState = CommonDefine.BtnType.High
  end
  self:SetButtonState(self.ui.Btn_Confirm, btnState)
end

function AlchemyDecomposeConfirmView:_InitViewData()
  local showItemDataGroup = {}
  local tidCountMap = {}
  local tidFirstUidMap = {}
  for _, uid in ipairs(self.model.curSelectItemUidGroup) do
    local itemData = ItemDataUtils.GetItemByUid(uid) or {}
    local tid = itemData.tid
    if tid then
      local itemType = ItemDataUtils.GetItemType(tid)
      if itemType == CommonDefine.ItemType.Weapon or itemType == CommonDefine.ItemType.Trinket then
        table.insert(showItemDataGroup, {tid = tid, uid = uid})
      else
        tidCountMap[tid] = (tidCountMap[tid] or 0) + 1
        if not tidFirstUidMap[tid] then
          tidFirstUidMap[tid] = uid
        end
      end
    end
  end
  for tid, count in pairs(tidCountMap) do
    table.insert(showItemDataGroup, {
      tid = tid,
      uid = tidFirstUidMap[tid],
      _showNum = count
    })
  end
  table.sort(showItemDataGroup, function(a, b)
    local aCfg = DT.Item[a.tid]
    local bCfg = DT.Item[b.tid]
    local aQualityWeight = CommonDefine.QualitySortValueTable[aCfg.Quality]
    local bQualityWeight = CommonDefine.QualitySortValueTable[bCfg.Quality]
    local aBaseSortId = aCfg.BaseSortID
    local bBaseSortId = bCfg.BaseSortID
    local aItemLevel, bItemLevel = ItemDataUtils.GetItemLevel(a.uid, aCfg.Type), ItemDataUtils.GetItemLevel(b.uid, bCfg.Type)
    if aQualityWeight ~= bQualityWeight then
      return aQualityWeight > bQualityWeight
    end
    if aItemLevel ~= bItemLevel then
      return aItemLevel > bItemLevel
    end
    return aBaseSortId < bBaseSortId
  end)
  self.showItemDataGroup = showItemDataGroup
  self.decomposeItemType = self:_GetDecomposeItemType(self.showItemDataGroup[1])
  self._inputSum = ""
  self._showTips = nil
  self._containSSRWeapon = nil
  self._containRefineItem = nil
  self._carculateVerificationData = ClientRandomManager.Instance:GetRandomCalculateVerification()
end

function AlchemyDecomposeConfirmView:OnClickConfirm()
  if not self:_CheckContainImportantItem() then
    self:_OnConfirm()
    return
  end
  if self._inputSum == "" then
    Alert.ShowStr(LT.Text("AlchemyDecomposeEmptyResultTips"))
    return
  end
  if not self:_CheckVerification() then
    Alert.ShowStr(LT.Text("AlchemyDecomposeWrongResultTips"))
    self:SetInputText(self.ui.InputField_Account, "")
    return
  end
  self:_OnConfirm()
end

function AlchemyDecomposeConfirmView:_OnConfirm()
  if self.confirmCb then
    self.confirmCb()
  end
  self:Close()
end

function AlchemyDecomposeConfirmView:OnClickCancel()
  self:Close()
end

function AlchemyDecomposeConfirmView:_CheckCanDecompose()
  if self:_CheckContainImportantItem() then
    do return self._CheckVerification end
    return self._CheckVerification, self
  end
  return true
end

function AlchemyDecomposeConfirmView:_CheckContainImportantItem()
  return self:_GetContainRefinedItem() or self:_GetContainSSRWeapon()
end

function AlchemyDecomposeConfirmView:_GetContainRefinedItem()
  if self._containRefineItem ~= nil then
    return self._containRefineItem
  end
  self._containRefineItem = false
  for _, itemData in pairs(self.showItemDataGroup) do
    local itemType = ItemDataUtils.GetItemType(itemData.tid)
    if ItemDataUtils.GetItemLevel(itemData.uid, itemType) > 0 then
      self._containRefineItem = true
      break
    end
  end
  return self._containRefineItem
end

function AlchemyDecomposeConfirmView:_GetContainSSRWeapon()
  if self._containSSRWeapon ~= nil then
    return self._containSSRWeapon
  end
  self._containSSRWeapon = false
  for _, itemData in pairs(self.showItemDataGroup) do
    local itemCfg = ItemDataUtils.GetItemConfig(itemData.tid)
    if itemCfg.Quality == CommonDefine.CommonQuality.Orange and itemCfg.Type == CommonDefine.ItemType.Weapon then
      self._containSSRWeapon = true
      break
    end
  end
  return self._containSSRWeapon
end

function AlchemyDecomposeConfirmView:_CheckVerification()
  if self._inputSum == "" then
    return false
  end
  return tonumber(self._inputSum) == self._carculateVerificationData.sum
end

function AlchemyDecomposeConfirmView:_GetTips()
  if self._showTips ~= nil then
    return self._showTips
  end
  if self:_CheckContainImportantItem() then
    self._showTips = itemType2ConfirtTipsMap[self.decomposeItemType]
  else
    self._showTips = LT.Text(DT.TipsType[10633].Desc)
  end
  return self._showTips
end

function AlchemyDecomposeConfirmView:_GetDecomposeItemType(itemData)
  do return ItemDataUtils.GetItemType end
  return ItemDataUtils.GetItemType, itemData.tid
end

return AlchemyDecomposeConfirmView
