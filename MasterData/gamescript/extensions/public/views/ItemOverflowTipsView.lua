local ItemOverflowTipsView, Super = NewClass("ItemOverflowTipsView", BaseView)
ItemOverflowTipsView.uiResCls = UI_Event_Popup_Overflow_TipsResource

function ItemOverflowTipsView:ctor(convertList, data)
  Super.ctor(self)
  Logger.Debug("[overflow] ctor convertList=%s", convertList)
  self.showQueque = convertList
  self.data = data or {}
  self.tipTid = self.data.tipTid or 20159
  self.sourceItemTid = 0
  self.convertItems = {}
end

function ItemOverflowTipsView:RegisterNotifications()
end

function ItemOverflowTipsView:RegisterEvents()
  self:_InitButtons()
end

function ItemOverflowTipsView:OnEnterView()
  self.convertItemsTf = self.ui.Root_NewItems.transform
  Super.OnEnterView(self)
  self:_SetBgTips()
  self:_ShowNextConvertItems()
  self:_RefreshView()
end

function ItemOverflowTipsView:_SetBgTips(...)
  local tipsTid = self.tipTid
  local tipsTitle = LT.Text(DT.TipsType[tipsTid].Title)
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    textTitleCN = tipsTitle
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Popup_Tips_Confirm_S, CompPublicPopupConfirmTips, commonPopupConfirmTipsData)
end

function ItemOverflowTipsView:_RefreshView()
  self:_RefreshTips()
  self:_RefreshConvertion()
end

function ItemOverflowTipsView:_InitButtons()
  local tipsTid = self.tipTid
  local tipConfig = DT.TipsType[tipsTid]
  local showDouble = tipConfig.LeftBtn and tipConfig.RightBtn
  local leftBtnType = self:_GetBtnType(tipConfig.LeftBtn)
  local rightBtnType = self:_GetBtnType(tipConfig.RightBtn)
  local leftBtnText = self.data.leftBtnDesc or LT.Text(tipConfig.LeftBtnDesc)
  local rightBtnText = self.data.rightBtnDesc or LT.Text(tipConfig.RightBtnDesc)
  if showDouble then
    self.ui.Btn_Cancel:SetActive(true)
    self.ui.Btn_Confirm:SetActive(true)
    self:SetButtonState(self.ui.Btn_Cancel, leftBtnType)
    self:SetButtonState(self.ui.Btn_Confirm, rightBtnType)
    self:SetButtonText(self.ui.Btn_Cancel, leftBtnText)
    self:SetButtonText(self.ui.Btn_Confirm, rightBtnText)
    self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnClickLeft))
    self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickRight))
  elseif tipConfig.LeftBtn then
    self.ui.Btn_Confirm:SetActive(false)
    self.ui.Btn_Cancel:SetActive(true)
    self:SetButtonState(self.ui.Btn_Cancel, leftBtnType)
    self:SetButtonText(self.ui.Btn_Cancel, leftBtnText)
    self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnClickLeft))
  elseif tipConfig.RightBtn then
    self.ui.Btn_Confirm:SetActive(true)
    self.ui.Btn_Cancel:SetActive(false)
    self:SetButtonState(self.ui.Btn_Confirm, rightBtnType)
    self:SetButtonText(self.ui.Btn_Confirm, rightBtnText)
    self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickRight))
  end
end

function ItemOverflowTipsView:_RefreshTips()
  local itemName = ItemDataUtils.GetItemName(self.sourceItemTid)
  local tipsTid = self.tipTid
  local tipConfig = DT.TipsType[tipsTid]
  local descText = self.data.desc or LT.Textf(tipConfig.Desc, itemName, self.overflowNum)
  self:SetText(self.ui.Text_Tips, descText)
end

function ItemOverflowTipsView:_RefreshConvertion()
  local sourceItemData = {
    itemTid = self.sourceItemTid,
    itemCount = self.overflowNum
  }
  self:AddViewComponentOnce(self.ui.Group_Item_Old, CompPublicIconItemType2, sourceItemData)
  local totalNum = #self.convertItems
  local childCount = self.convertItemsTf.childCount
  while totalNum > childCount do
    Instantiate(self.ui.Group_Item_New, self.convertItemsTf)
    childCount = childCount + 1
  end
  for index = 1, totalNum do
    local go = self.convertItemsTf:GetChild(index - 1).gameObject
    go:SetActive(true)
    local convertData = self.convertItems[index]
    local itemData = {
      itemTid = convertData.tid,
      itemCount = convertData.num
    }
    self:AddViewComponentOnce(go, CompPublicIconItemType2, itemData)
  end
  for index = totalNum + 1, childCount do
    local go = self.convertItemsTf:GetChild(index - 1).gameObject
    go:SetActive(false)
  end
end

function ItemOverflowTipsView:_GetBtnType(btnCfgValue)
  if 1 == btnCfgValue then
    if self.leftBtnTypeFunc then
      do return end
      return self.leftBtnTypeFunc
    else
      return CommonDefine.BtnType.High
    end
  elseif 2 == btnCfgValue then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Unclickable
end

function ItemOverflowTipsView:_ShowNextConvertItems()
  Logger.Debug("[overflow] _ShowNextConvertItems 1 queue=%s", table.tostring(self.showQueque))
  if table.next(self.showQueque) == nil then
    return false
  end
  local data = table.remove(self.showQueque, 1)
  self.sourceItemTid = data.sourceItemTid
  self.convertItems = data.convertItems
  self.overflowNum = data.overflowNum
  Logger.Debug("[overflow] _ShowNextConvertItems 2 data=%s", table.tostring(data))
  return true
end

function ItemOverflowTipsView:_CheckClose()
  local hasNextData = self:_ShowNextConvertItems()
  if not hasNextData then
    self:Close()
    return true
  end
  self:_RefreshView()
  return false
end

function ItemOverflowTipsView:_OnClickLeft()
  local isClose = self:_CheckClose()
  if not isClose then
    return
  end
  if self.data.leftBtnFunc then
    self.data.leftBtnFunc()
  end
end

function ItemOverflowTipsView:_OnClickRight()
  local isClose = self:_CheckClose()
  if not isClose then
    return
  end
  if self.data.rightBtnFunc then
    self.data.rightBtnFunc()
  end
end

return ItemOverflowTipsView
