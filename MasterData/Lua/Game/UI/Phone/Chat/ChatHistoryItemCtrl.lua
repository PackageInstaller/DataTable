local ChatHistoryItemCtrl = class("ChatHistoryItemCtrl", BaseCtrl)
ChatHistoryItemCtrl._mapNodeConfig = {
  imgBg = {},
  imgBgSelect = {},
  goUnComplete = {},
  imgComplete = {},
  txtComplete = {sComponentName = "TMP_Text"},
  txtChatContent = {sComponentName = "TMP_Text", nCount = 2},
  redDotUnStart = {},
  redDotUnderway = {}
}
ChatHistoryItemCtrl._mapEventConfig = {}
local max_content_length = 15

function ChatHistoryItemCtrl:SetData(chatData)
  self.nChatId = chatData.nChatId
  local nProcess = 1
  local chatMsg = PlayerData.Phone:GetChatMsg(chatData, nProcess)
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
  for _, v in ipairs(self._mapNode.txtChatContent) do
    NovaAPI.SetTMPText(v, sContent)
  end
  NovaAPI.SetTMPText(self._mapNode.txtComplete, sContent)
  self.nChatStatus = chatData.nStatus
  self._mapNode.goUnComplete.gameObject:SetActive(self.nChatStatus ~= AllEnum.PhoneChatState.Complete)
  self._mapNode.imgComplete.gameObject:SetActive(self.nChatStatus == AllEnum.PhoneChatState.Complete)
  self._mapNode.redDotUnStart.gameObject:SetActive(self.nChatStatus == AllEnum.PhoneChatState.New)
  self._mapNode.redDotUnderway.gameObject:SetActive(self.nChatStatus == AllEnum.PhoneChatState.UnComplete)
  self:SetSelect(false)
end

function ChatHistoryItemCtrl:SetSelect(bSelect)
  self._mapNode.imgBgSelect.gameObject:SetActive(bSelect)
  self._mapNode.imgBg.gameObject:SetActive(not bSelect and self.nChatStatus ~= AllEnum.PhoneChatState.Complete)
  self._mapNode.txtComplete.gameObject:SetActive(not bSelect and self.nChatStatus == AllEnum.PhoneChatState.Complete)
end

function ChatHistoryItemCtrl:Awake()
end

function ChatHistoryItemCtrl:OnEnable()
end

function ChatHistoryItemCtrl:OnDisable()
end

function ChatHistoryItemCtrl:OnDestroy()
end

return ChatHistoryItemCtrl
