local MessageBoxItemListCtrl = class("MessageBoxItemListCtrl", BaseCtrl)
MessageBoxItemListCtrl._mapNodeConfig = {
  aniMessageBox = {
    sNodeName = "goMessageBox",
    sComponentName = "Animator"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Reward"
  },
  sv = {
    sComponentName = "LoopScrollView"
  },
  btnClose = {sComponentName = "UIButton"}
}
MessageBoxItemListCtrl._mapEventConfig = {}

function MessageBoxItemListCtrl:OpenBox(mapMsg, ctrlBase)
  self:RefreshConfirm(mapMsg, ctrlBase)
end

function MessageBoxItemListCtrl:RefreshConfirm(mapMsg, ctrlBase)
  self.tbItem = mapMsg.tbItem
  local sTitle = mapMsg.sTitle
  self.bDisableSnap = mapMsg.bDisableSnap
  local nItemCount = #self.tbItem
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  if 0 < nItemCount then
    self._mapNode.sv:SetAnim(0.04)
    self._mapNode.sv:Init(nItemCount, self, self.OnGridRefresh, self.OnGridBtnClick)
  end
  if sTitle then
    NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, sTitle)
  end
  if self.handlerClose then
    self._mapNode.btnClose.onClick:RemoveListener(self.handlerClose)
  end
  self.handlerClose = nil
  
  local function func_close()
    if self._panel.bBlur then
      self._mapNode.aniMessageBox:Play("t_window_04_t_out")
    end
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
    ctrlBase:DefaultClick()
  end
  
  self.handlerClose = ui_handler(self, func_close, self._mapNode.btnClose)
  self._mapNode.btnClose.onClick:AddListener(self.handlerClose)
  self._mapNode.aniMessageBox:Play("t_window_04_t_in", 0, 0)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function MessageBoxItemListCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbItem[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbGridCtrl[nInstanceID]:SetItem(mapData.nId, nil, mapData.nCount, nil, mapData.bReceived, mapData.bFirstPass, mapData.bThreePass, true, nil, nil, mapData.bExtraDrop, mapData.bDoubleDrop)
end

function MessageBoxItemListCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapItem = self.tbItem[nIndex]
  local rtItem = goGrid.transform:Find("AnimRoot/Item")
  self._mapNode.sv:SetScrollGridPos(gridIndex, 0.1, 1)
  local mapItemCfgData = ConfigTable.GetData_Item(mapItem.nId)
  if mapItemCfgData and (mapItemCfgData.Type == GameEnum.itemType.Disc or mapItemCfgData.Type == GameEnum.itemType.Char) then
    return
  end
  EventManager.Hit(EventId.BlockInput, true)
  self:AddTimer(1, 0.1, function()
    EventManager.Hit(EventId.BlockInput, false)
    UTILS.ClickItemGridWithTips(mapItem.nId, rtItem, false, true, false)
  end, true, true, true)
end

function MessageBoxItemListCtrl:Close()
  if self.bDisableSnap then
    return
  end
  if self.handlerClose then
    self.handlerClose()
  end
end

function MessageBoxItemListCtrl:Awake()
  self.tbGridCtrl = {}
end

function MessageBoxItemListCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

return MessageBoxItemListCtrl
