local MessageBoxCommonCtrl = class("MessageBoxCommonCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
MessageBoxCommonCtrl._mapNodeConfig = {
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
  btnClose = {sComponentName = "UIButton"},
  btnCancel = {
    sComponentName = "NaviButton",
    sAction = "Back",
    sActionIconType = "Dark"
  },
  btnCancel2 = {
    sComponentName = "NaviButton",
    sAction = "Giveup",
    sActionIconType = "Dark"
  },
  btnConfirm = {
    nCount = 2,
    sComponentName = "NaviButton",
    sAction = "Confirm",
    sActionIconType = "Dark"
  },
  btnConfirmDisable = {
    sComponentName = "NaviButton",
    sAction = "Confirm",
    sActionIconType = "Dark"
  },
  txtBtnCancel = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  },
  txtCancel2_ = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  },
  txtConfirmDisable = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  txtConfirm2_ = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  txtConfirm1_ = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  btnAgain = {sComponentName = "NaviButton"},
  againSelect = {},
  texAgainTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_TodayWarning"
  },
  goAgain = {}
}
MessageBoxCommonCtrl._mapEventConfig = {}

function MessageBoxCommonCtrl:OpenBox(mapMsg, ctrlBase)
  if mapMsg.nType == AllEnum.MessageBox.Alert then
    self:RefreshAlert(mapMsg, ctrlBase)
  elseif mapMsg.nType == AllEnum.MessageBox.Confirm then
    self:RefreshConfirm(mapMsg, ctrlBase)
  end
end

function MessageBoxCommonCtrl:RefreshPlainText(mapMsg, ctrlBase)
  local sContent = mapMsg.sContent
  local sTitle = mapMsg.sTitle
  local callbackCancel = mapMsg.callbackCancel
  self._mapNode.txtContentSub.gameObject:SetActive(false)
  self._mapNode.btnConfirm[1].gameObject:SetActive(false)
  self._mapNode.btnConfirm[2].gameObject:SetActive(false)
  self._mapNode.btnCancel.gameObject:SetActive(false)
  self._mapNode.btnAgain.gameObject:SetActive(false)
  self._mapNode.goAgain.gameObject:SetActive(false)
  NovaAPI.SetTMPText(self._mapNode.txtContentMain, sContent)
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
    ctrlBase:DefaultClick(callbackCancel)
  end
  
  self.handlerClose = ui_handler(self, func_close, self._mapNode.btnClose)
  self._mapNode.btnClose.onClick:AddListener(self.handlerClose)
  self._mapNode.aniMessageBox:Play("t_window_04_t_in", 0, 0)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function MessageBoxCommonCtrl:RefreshConfirm(mapMsg, ctrlBase)
  local sContent = mapMsg.sContent
  local sContentSub = mapMsg.sContentSub
  local sTitle = mapMsg.sTitle
  local sConfirm = mapMsg.sConfirm
  local sCancel = mapMsg.sCancel
  local callbackConfirm = mapMsg.callbackConfirm
  local callbackConfirmAfterClose = mapMsg.callbackConfirmAfterClose
  local callbackCancel = mapMsg.callbackCancel
  local callbackAgain = mapMsg.callbackAgain
  self.bDisableSnap = mapMsg.bDisableSnap
  self.bCloseNoHandler = mapMsg.bCloseNoHandler
  self._mapNode.txtContentSub.gameObject:SetActive(sContentSub)
  self._mapNode.btnConfirm[1].gameObject:SetActive(mapMsg.bGrayConfirm ~= true)
  self._mapNode.btnConfirmDisable.gameObject:SetActive(mapMsg.bGrayConfirm == true)
  self._mapNode.btnConfirm[2].gameObject:SetActive(false)
  self._mapNode.btnCancel.gameObject:SetActive(mapMsg.bRedCancel ~= true)
  self._mapNode.btnCancel2.gameObject:SetActive(mapMsg.bRedCancel == true)
  self._mapNode.btnAgain.gameObject:SetActive(callbackAgain ~= nil)
  self._mapNode.againSelect:SetActive(false)
  self._mapNode.goAgain.gameObject:SetActive(callbackAgain ~= nil)
  if mapMsg.sAgain then
    NovaAPI.SetTMPText(self._mapNode.texAgainTip, mapMsg.sAgain)
  end
  if sContentSub then
    NovaAPI.SetTMPText(self._mapNode.txtContentSub, sContentSub)
  end
  if sConfirm then
    for i = 1, 3 do
      NovaAPI.SetTMPText(self._mapNode.txtConfirm1_[i], sConfirm)
    end
    for i = 1, 3 do
      NovaAPI.SetTMPText(self._mapNode.txtConfirmDisable[i], sConfirm)
    end
  else
    for i = 1, 3 do
      NovaAPI.SetTMPText(self._mapNode.txtConfirm1_[i], ConfigTable.GetUIText("MessageBox_Confirm"))
    end
    for i = 1, 3 do
      NovaAPI.SetTMPText(self._mapNode.txtConfirmDisable[i], ConfigTable.GetUIText("MessageBox_Confirm"))
    end
  end
  if sCancel then
    for i = 1, 3 do
      NovaAPI.SetTMPText(self._mapNode.txtBtnCancel[i], sCancel)
      NovaAPI.SetTMPText(self._mapNode.txtCancel2_[i], sCancel)
    end
  else
    for i = 1, 3 do
      NovaAPI.SetTMPText(self._mapNode.txtBtnCancel[i], ConfigTable.GetUIText("MessageBox_Cancel"))
      NovaAPI.SetTMPText(self._mapNode.txtCancel2_[i], ConfigTable.GetUIText("MessageBox_Cancel"))
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtContentMain, sContent)
  if sTitle then
    NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, sTitle)
  end
  if self.handlerConfirm then
    self._mapNode.btnConfirm[1].onClick:RemoveListener(self.handlerConfirm)
    self._mapNode.btnConfirm[2].onClick:RemoveListener(self.handlerConfirm)
  end
  self.handlerConfirm = nil
  
  local function func_confirm()
    if self._panel.bBlur then
      self._mapNode.aniMessageBox:Play("t_window_04_t_out")
    end
    ctrlBase:DefaultClick(callbackConfirm, callbackConfirmAfterClose)
  end
  
  self.handlerConfirm = ui_handler(self, func_confirm, self._mapNode.btnConfirm[1])
  self._mapNode.btnConfirm[1].onClick:AddListener(self.handlerConfirm)
  if self.handlerConfirmGray then
    self._mapNode.btnConfirmDisable.onClick:RemoveListener(self.handlerConfirmGray)
  end
  self.handlerConfirmGray = nil
  
  local function func_confirmGray()
    callbackConfirm()
  end
  
  self.handlerConfirmGray = ui_handler(self, func_confirmGray, self._mapNode.btnConfirmDisable)
  self._mapNode.btnConfirmDisable.onClick:AddListener(self.handlerConfirmGray)
  if self.handlerCancel then
    self._mapNode.btnCancel.onClick:RemoveListener(self.handlerCancel)
    self._mapNode.btnCancel2.onClick:RemoveListener(self.handlerCancel)
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
  self._mapNode.btnCancel2.onClick:AddListener(self.handlerCancel)
  if self.handlerClose then
    self._mapNode.btnClose.onClick:RemoveListener(self.handlerClose)
  end
  self.handlerClose = nil
  
  local function func_close()
    if self._panel.bBlur then
      self._mapNode.aniMessageBox:Play("t_window_04_t_out")
    end
    ctrlBase:DefaultClick(nil)
  end
  
  if self.bCloseNoHandler then
    self.handlerClose = ui_handler(self, func_close, self._mapNode.btnClose)
  else
    self.handlerClose = ui_handler(self, func_cancel, self._mapNode.btnClose)
  end
  self._mapNode.btnClose.onClick:AddListener(self.handlerClose)
  if self.handlerAgain then
    self._mapNode.btnAgain.onClick:RemoveListener(self.handlerAgain)
  end
  self.handlerAgain = nil
  if callbackAgain ~= nil then
    local function func_again()
      self._mapNode.againSelect:SetActive(not self._mapNode.againSelect.activeSelf)
      
      callbackAgain(self._mapNode.againSelect.activeSelf)
    end
    
    self.handlerAgain = ui_handler(self, func_again, self._mapNode.btnAgain)
    self._mapNode.btnAgain.onClick:AddListener(self.handlerAgain)
  end
  self._mapNode.aniMessageBox:Play("t_window_04_t_in", 0, 0)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function MessageBoxCommonCtrl:RefreshAlert(mapMsg, ctrlBase)
  local sContent = mapMsg.sContent
  local sContentSub = mapMsg.sContentSub
  local sTitle = mapMsg.sTitle
  local sConfirm = mapMsg.sConfirm
  local callbackConfirm = mapMsg.callbackConfirm
  local callbackConfirmAfterClose = mapMsg.callbackConfirmAfterClose
  self.bDisableSnap = mapMsg.bDisableSnap
  self._mapNode.txtContentSub.gameObject:SetActive(sContentSub)
  self._mapNode.btnConfirm[1].gameObject:SetActive(false)
  self._mapNode.btnConfirm[2].gameObject:SetActive(true)
  self._mapNode.btnCancel.gameObject:SetActive(false)
  self._mapNode.btnAgain.gameObject:SetActive(false)
  self._mapNode.goAgain.gameObject:SetActive(false)
  if sContentSub then
    NovaAPI.SetTMPText(self._mapNode.txtContentSub, sContentSub)
  end
  if sConfirm then
    for i = 1, 3 do
      NovaAPI.SetTMPText(self._mapNode.txtConfirm2_[i], sConfirm)
    end
    for i = 1, 3 do
      NovaAPI.SetTMPText(self._mapNode.txtConfirmDisable[i], sConfirm)
    end
  else
    for i = 1, 3 do
      NovaAPI.SetTMPText(self._mapNode.txtConfirm2_[i], ConfigTable.GetUIText("MessageBox_Confirm"))
    end
    for i = 1, 3 do
      NovaAPI.SetTMPText(self._mapNode.txtConfirmDisable[i], ConfigTable.GetUIText("MessageBox_Confirm"))
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtContentMain, sContent)
  if sTitle then
    NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, sTitle)
  end
  if self.handlerConfirm then
    self._mapNode.btnConfirm[1].onClick:RemoveListener(self.handlerConfirm)
    self._mapNode.btnConfirm[2].onClick:RemoveListener(self.handlerConfirm)
  end
  self.handlerConfirm = nil
  
  local function func_confirm()
    if self._panel.bBlur then
      self._mapNode.aniMessageBox:Play("t_window_04_t_out")
    end
    ctrlBase:DefaultClick(callbackConfirm, callbackConfirmAfterClose)
  end
  
  self.handlerConfirm = ui_handler(self, func_confirm, self._mapNode.btnConfirm[2])
  self._mapNode.btnConfirm[2].onClick:AddListener(self.handlerConfirm)
  if self.handlerClose then
    self._mapNode.btnClose.onClick:RemoveListener(self.handlerClose)
  end
  self.handlerClose = nil
  
  local function func_close()
    if self._panel.bBlur then
      self._mapNode.aniMessageBox:Play("t_window_04_t_out")
    end
    ctrlBase:DefaultClick(callbackConfirm)
  end
  
  self.handlerClose = ui_handler(self, func_close, self._mapNode.btnClose)
  self._mapNode.btnClose.onClick:AddListener(self.handlerClose)
  self._mapNode.aniMessageBox:Play("t_window_04_t_in", 0, 0)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function MessageBoxCommonCtrl:Close()
  if self.bDisableSnap then
    return
  end
  if self.handlerClose then
    self.handlerClose()
  end
end

function MessageBoxCommonCtrl:Awake()
  self.tbGamepadUINode = self:GetGamepadUINode()
end

function MessageBoxCommonCtrl:OnEnable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.EnableGamepadUI("MessageBoxCommonCtrl", self.tbGamepadUINode, nil, nil, nil, AllEnum.UI_SORTING_ORDER.MessageBox)
  else
    for _, v in pairs(self.tbGamepadUINode) do
      if v.sComponentName == "NaviButton" then
        NovaAPI.SetNaviButtonAction(v.mapNode, false)
      end
    end
  end
end

function MessageBoxCommonCtrl:OnDisable()
  if GamepadUIManager.GetInputState() then
    GamepadUIManager.DisableGamepadUI("MessageBoxCommonCtrl")
  end
end

return MessageBoxCommonCtrl
