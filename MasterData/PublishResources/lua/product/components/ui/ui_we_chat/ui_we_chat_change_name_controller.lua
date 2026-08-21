_class("UIWeChatChangeNameController", UIController)
UIWeChatChangeNameController = UIWeChatChangeNameController

function UIWeChatChangeNameController:OnShow(uiParams)
  self.weChatRole = uiParams[1]
  self._module = self:GetModule(QuestChatModule)
  self._iptName = self:GetUIComponent("EmojiFilteredInputField", "iptName")
  local max = 10
  
  function self.OnIptValueChanged()
    local s = self._iptName.text
    if string.isnullorempty(s) then
      return
    end
    if string.match(s, " ") then
      ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_CHANGE_NICK_INVALID"))
      s = string.gsub(s, " ", "")
    end
    local showStr = HelperProxy:GetInstance():GetSubStringByWordsNum(s, max)
    self._iptName.text = showStr
  end
  
  self._iptName.onValueChanged:AddListener(self.OnIptValueChanged)
end

function UIWeChatChangeNameController:OnHide()
  self._iptName.onValueChanged:RemoveListener(self.OnIptValueChanged)
  self.OnIptValueChanged = nil
end

function UIWeChatChangeNameController:GetCharSize(char)
  if not char then
    return 0
  elseif 240 < char then
    return 4
  elseif 225 < char then
    return 3
  elseif 192 < char then
    return 2
  else
    return 1
  end
end

function UIWeChatChangeNameController:bgOnClick(go)
  self:CloseDialog()
end

function UIWeChatChangeNameController:btnCancelOnClick(go)
  self:CloseDialog()
end

function UIWeChatChangeNameController:btnEnsureOnClick(go)
  if string.isnullorempty(self._iptName.text) then
    ToastManager.ShowToast(StringTable.Get("str_quest_chat_gaiming_kong"))
    return
  end
  if self._iptName.text == self.weChatRole:GetName() then
    ToastManager.ShowToast(StringTable.Get("str_guide_ROLE_ERROR_NEWNAME_THE_SAME_AS_OLD"))
    return
  end
  self:StartTask(function(TT)
    local result, nErrorCode = self._module:Request_UpdateSpeakerName(TT, self.weChatRole:GetSpeakerId(), self._iptName.text)
    if result:GetSucc() then
      if nErrorCode == 0 then
        self.weChatRole:UpdateName(self._iptName.text)
        self:CloseDialog()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.WeChatChangeName, self.weChatRole:GetSpeakerId())
      else
        ToastManager.ShowToast(self._module:GetErrorMsg(nErrorCode))
      end
    end
  end)
end
