local AddressBookItemCtrl = class("AddressBookItemCtrl", BaseCtrl)
AddressBookItemCtrl._mapNodeConfig = {
  imgSelectBg = {},
  goNormal = {},
  animRoot = {sNodeName = "AnimRoot", sComponentName = "Animator"},
  animTip = {sNodeName = "btnGrid", sComponentName = "Animator"},
  btnTop = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeTopStatus"
  },
  txtName = {sComponentName = "TMP_Text", nCount = 2},
  txtChat = {sComponentName = "TMP_Text", nCount = 2},
  imgTopped = {},
  imgUntopped = {},
  imgHeadIcon = {sComponentName = "Image"},
  goRedDot = {},
  redDotNew = {},
  redDotUnComplete = {},
  imgLine = {}
}
AddressBookItemCtrl._mapEventConfig = {}

function AddressBookItemCtrl:SetAddressData(nAddressId, nChatId, bLast, bTop)
  self.nAddressId = nAddressId
  self.bTop = bTop
  self:SetTop(bTop)
  self:SetSelect(false)
  local cfgData = PlayerData.Phone:GetAvgContactsData(self.nAddressId)
  if nil ~= cfgData then
    local sIcon = Avg_ProcContactsIcon_M_F(cfgData.icon)
    sIcon = string.gsub(sIcon, AllEnum.CharHeadIconSurfix.S, "")
    self:SetPngSprite(self._mapNode.imgHeadIcon, sIcon, AllEnum.CharHeadIconSurfix.S)
    NovaAPI.SetTMPText(self._mapNode.txtName[1], cfgData.name)
    NovaAPI.SetTMPText(self._mapNode.txtName[2], cfgData.name)
  end
  self:RefreshChatContent(nChatId)
  self:RegisterRedDot()
  self._mapNode.imgLine.gameObject:SetActive(not bLast)
end

function AddressBookItemCtrl:RefreshChatContent(nChatId)
  local chatData = PlayerData.Phone:GetChatData(self.nAddressId, nChatId)
  if nil == chatData then
    return
  end
  self.chatData = chatData
  local nProcess = 1
  if self.chatData.nStatus == AllEnum.PhoneChatState.Complete and PlayerData.Phone:EnsureChatAvgLoaded(self.chatData) then
    nProcess = self.chatData.nAllProcess
  end
  local chatMsg = PlayerData.Phone:GetChatMsg(self.chatData, nProcess)
  local sContent = ""
  if chatMsg ~= nil then
    sContent = ProcAvgTextContentFallback(self._panel.sTxtLan, self._panel.sVoLan, self._panel.bIsPlayerMale, chatMsg.param[3], chatMsg.param[7], chatMsg.param[8], chatMsg.param[9])
    sContent = ProcAvgTextContent(sContent, GetLanguageIndex(Settings.sCurrentTxtLanguage))
    local nMsgType = chatMsg.param[1]
    if nMsgType == AllEnum.PhoneMsgType.ReceiveImgMsg or nMsgType == AllEnum.PhoneMsgType.ReplyImgMsg then
      local nImgType = tonumber(chatMsg.param[4])
      if nImgType == 0 then
        sContent = ConfigTable.GetUIText("Phone_Char_Emoji_Preview")
      elseif nImgType == 1 then
        sContent = ConfigTable.GetUIText("Phone_Char_Image_Preview")
      end
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtChat[1], sContent)
  NovaAPI.SetTMPText(self._mapNode.txtChat[2], sContent)
end

function AddressBookItemCtrl:SetSelect(bSelect)
  self._mapNode.btnTop.gameObject:SetActive(bSelect or self.bTop)
  self._mapNode.imgSelectBg.gameObject:SetActive(bSelect)
  self._mapNode.goNormal.gameObject:SetActive(not bSelect)
end

function AddressBookItemCtrl:SetTop(bTop)
  self._mapNode.imgTopped:SetActive(bTop)
  self._mapNode.imgUntopped:SetActive(not bTop)
end

function AddressBookItemCtrl:OnBtnClick_ChangeTopStatus()
  if not self.bTop and PlayerData.Phone:GetTopCount() >= ConfigTable.GetConfigNumber("PhoneChatTopLimit") then
    EventManager.Hit("PhoneChatTopLimit")
    return
  end
  self.bTop = not self.bTop
  self:SetTop(self.bTop)
  EventManager.Hit("ChangePhoneListTopStatus", self.nAddressId, self.bTop)
end

function AddressBookItemCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Phone_New_Item, self.nAddressId, self._mapNode.redDotNew, nil, true)
  RedDotManager.RegisterNode(RedDotDefine.Phone_UnComplete_Item, self.nAddressId, self._mapNode.redDotUnComplete)
end

function AddressBookItemCtrl:RefreshRedDotShow()
  RedDotManager.RefreshRedDotShow(RedDotDefine.Phone_New_Item, self.nAddressId)
end

function AddressBookItemCtrl:PlayAnim(nAddressId)
  if self.nAddressId ~= nAddressId then
    self._mapNode.animRoot:Play("PhonePanel_char_move")
  else
    self._mapNode.animRoot:Play("PhonePanel_char_new")
  end
end

function AddressBookItemCtrl:Awake()
end

function AddressBookItemCtrl:OnEnable()
end

function AddressBookItemCtrl:OnDisable()
end

function AddressBookItemCtrl:OnDestroy()
end

function AddressBookItemCtrl:OnBtnClick_SetTop()
end

return AddressBookItemCtrl
