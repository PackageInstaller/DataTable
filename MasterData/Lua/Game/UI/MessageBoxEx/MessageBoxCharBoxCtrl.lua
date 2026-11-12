local MessageBoxCharBoxCtrl = class("MessageBoxCharBoxCtrl", BaseCtrl)
MessageBoxCharBoxCtrl._mapNodeConfig = {
  aniMessageBox = {
    sNodeName = "goMessageBox",
    sComponentName = "Animator"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Title"
  },
  goCharItem = {},
  imgItemIcon = {sComponentName = "Image"},
  imgItemRare = {sComponentName = "Image"},
  txtCharName = {sComponentName = "TMP_Text"},
  txtContentMain = {sComponentName = "TMP_Text"},
  txtContentSub = {sComponentName = "TMP_Text"},
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
  },
  btnAgain = {sComponentName = "NaviButton"},
  againSelect = {},
  texAgainTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_TodayWarning"
  },
  goAgain = {}
}

function MessageBoxCharBoxCtrl:OpenBox(mapMsg, ctrlBase)
  local sContent = mapMsg.sContent
  local sContentSub = mapMsg.sContentSub
  local sTitle = mapMsg.sTitle
  local sConfirm = mapMsg.sConfirm
  local sCancel = mapMsg.sCancel
  local callbackConfirm = mapMsg.callbackConfirm
  local callbackCancel = mapMsg.callbackCancel
  local callbackAgain = mapMsg.callbackAgain
  local nCharId = mapMsg.nCharId
  self._mapNode.btnConfirm[1].gameObject:SetActive(true)
  self._mapNode.btnConfirm[2].gameObject:SetActive(false)
  self._mapNode.btnCancel.gameObject:SetActive(true)
  self._mapNode.btnAgain.gameObject:SetActive(callbackAgain ~= nil)
  self._mapNode.againSelect:SetActive(false)
  self._mapNode.goAgain.gameObject:SetActive(callbackAgain ~= nil)
  self._mapNode.txtContentSub.gameObject:SetActive(sContentSub)
  if sContentSub then
    NovaAPI.SetTMPText(self._mapNode.txtContentSub, sContentSub)
  end
  NovaAPI.SetTMPText(self._mapNode.txtContentMain, sContent)
  if sTitle then
    NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, sTitle)
  end
  if nCharId then
    local mapCharCfg = ConfigTable.GetData_Character(nCharId)
    if mapCharCfg then
      NovaAPI.SetTMPText(self._mapNode.txtCharName, mapCharCfg.Name)
      local nCharSkinId = mapCharCfg.DefaultSkinId
      local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
      if mapCharSkin then
        self:SetPngSprite(self._mapNode.imgItemIcon, mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.XXL)
      end
      local rareIconName = AllEnum.FrameType_New.BoardFrame .. AllEnum.BoardFrameColor[mapCharCfg.Grade]
      self:SetAtlasSprite(self._mapNode.imgItemRare, "12_rare", rareIconName)
    end
  end
  if sConfirm then
    NovaAPI.SetTMPText(self._mapNode.txtConfirm[1], sConfirm)
  end
  if sCancel then
    NovaAPI.SetTMPText(self._mapNode.txtCancel, sCancel)
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

function MessageBoxCharBoxCtrl:Close()
  if self.handlerClose then
    self.handlerClose()
  end
end

return MessageBoxCharBoxCtrl
