local MessageBoxItemCtrl = class("MessageBoxItemCtrl", BaseCtrl)
MessageBoxItemCtrl._mapNodeConfig = {
  aniMessageBox = {
    sNodeName = "goMessageBox",
    sComponentName = "Animator"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Title"
  },
  txtContentMain = {sComponentName = "TMP_Text"},
  txtContentSub = {sComponentName = "TMP_Text"},
  rtItem = {},
  goItem = {
    nCount = 5,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnItem = {
    nCount = 5,
    sNodeName = "goItem",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tips"
  },
  goItemList = {},
  sv = {
    sComponentName = "LoopScrollView"
  },
  btnClose = {sComponentName = "UIButton"},
  btnCancel = {sComponentName = "UIButton"},
  btnConfirm = {nCount = 2, sComponentName = "UIButton"},
  txtCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  },
  txtConfirm = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  }
}
MessageBoxItemCtrl._mapEventConfig = {}

function MessageBoxItemCtrl:OpenBox(mapMsg, ctrlBase)
  self:RefreshConfirm(mapMsg, ctrlBase)
end

function MessageBoxItemCtrl:RefreshConfirm(mapMsg, ctrlBase)
  local sContent = mapMsg.sContent
  local sContentSub = mapMsg.sContentSub
  local tbItem = mapMsg.tbItem
  self.tbItem = tbItem
  local sTitle = mapMsg.sTitle
  local sConfirm = mapMsg.sConfirm
  local sCancel = mapMsg.sCancel
  local callbackConfirm = mapMsg.callbackConfirm
  local callbackCancel = mapMsg.callbackCancel
  self.bDisableSnap = mapMsg.bDisableSnap
  self._mapNode.txtContentSub.gameObject:SetActive(sContentSub)
  self._mapNode.btnConfirm[1].gameObject:SetActive(true)
  self._mapNode.btnConfirm[2].gameObject:SetActive(false)
  self._mapNode.btnCancel.gameObject:SetActive(true)
  if sContentSub then
    NovaAPI.SetTMPText(self._mapNode.txtContentSub, sContentSub)
  end
  if sConfirm then
    NovaAPI.SetTMPText(self._mapNode.txtConfirm[1], sConfirm)
  end
  if sCancel then
    NovaAPI.SetTMPText(self._mapNode.txtCancel, sCancel)
  end
  local nItemCount = #tbItem
  self._mapNode.rtItem:SetActive(nItemCount <= 5)
  self._mapNode.goItemList:SetActive(5 < nItemCount)
  if nItemCount <= 5 then
    for i = 1, 5 do
      self._mapNode.goItem[i].gameObject:SetActive(i <= nItemCount)
      if i <= nItemCount then
        self._mapNode.goItem[i]:SetItem(tbItem[i].nTid, nil, tbItem[i].nCount)
      end
    end
  else
    self._mapNode.sv:Init(nItemCount, self, self.OnGridRefresh, self.OnGridBtnClick)
  end
  NovaAPI.SetTMPText(self._mapNode.txtContentMain, sContent)
  if sTitle then
    NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, sTitle)
  end
  if self.handlerConfirm then
    self._mapNode.btnConfirm[1].onClick:RemoveListener(self.handlerConfirm)
  end
  self.handlerConfirm = nil
  
  local function func_confirm()
    if self._panel.bBlur then
      self._mapNode.aniMessageBox:Play("t_window_04_t_out")
    end
    ctrlBase:DefaultClick(callbackConfirm)
  end
  
  self.handlerConfirm = ui_handler(self, func_confirm, self._mapNode.btnConfirm[1])
  self._mapNode.btnConfirm[1].onClick:AddListener(self.handlerConfirm)
  if self.handlerCancel then
    self._mapNode.btnCancel.onClick:RemoveListener(self.handlerCancel)
  end
  self.handlerCancel = nil
  
  local function func_cancel()
    if self._panel.bBlur then
      self._mapNode.aniMessageBox:Play("t_window_04_t_out")
    end
    ctrlBase:DefaultClick(callbackCancel)
  end
  
  self.handlerCancel = ui_handler(self, func_cancel, self._mapNode.btnCancel)
  self._mapNode.btnCancel.onClick:AddListener(self.handlerCancel)
  if self.handlerClose then
    self._mapNode.btnClose.onClick:RemoveListener(self.handlerClose)
  end
  self.handlerClose = nil
  
  local function func_close()
    if self._panel.bBlur then
      self._mapNode.aniMessageBox:Play("t_window_04_t_out")
    end
    ctrlBase:DefaultClick(callbackCancel)
  end
  
  self.handlerClose = ui_handler(self, func_close, self._mapNode.btnClose)
  self._mapNode.btnClose.onClick:AddListener(self.handlerClose)
  self._mapNode.aniMessageBox:Play("t_window_04_t_in", 0, 0)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function MessageBoxItemCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapItem = self.tbItem[nIndex]
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid.transform:Find("btnGrid").gameObject, "Game.UI.TemplateEx.TemplateItemCtrl")
  end
  self.tbGridCtrl[nInstanceId]:SetItem(mapItem.nTid, nil, mapItem.nCount)
end

function MessageBoxItemCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapItemCfgData = ConfigTable.GetData_Item(self.tbItem[nIndex].nTid)
  if mapItemCfgData and (mapItemCfgData.Type == GameEnum.itemType.Disc or mapItemCfgData.Type == GameEnum.itemType.Char) then
    return
  end
  self._mapNode.sv:SetScrollGridPos(gridIndex, 0.1, 1)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.1)
  self:AddTimer(1, 0.1, function()
    UTILS.ClickItemGridWithTips(self.tbItem[nIndex].nTid, goGrid.transform:Find("btnGrid"), true, true, false)
  end, true, true, true)
end

function MessageBoxItemCtrl:Close()
  if self.bDisableSnap then
    return
  end
  if self.handlerClose then
    self.handlerClose()
  end
end

function MessageBoxItemCtrl:Awake()
  self.tbGridCtrl = {}
end

function MessageBoxItemCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function MessageBoxItemCtrl:OnBtnClick_Tips(btn, nIndex)
  local mapItemCfgData = ConfigTable.GetData_Item(self.tbItem[nIndex].nTid)
  if mapItemCfgData and (mapItemCfgData.Type == GameEnum.itemType.Disc or mapItemCfgData.Type == GameEnum.itemType.Char) then
    return
  end
  UTILS.ClickItemGridWithTips(self.tbItem[nIndex].nTid, btn.transform, true, true, false)
end

return MessageBoxItemCtrl
