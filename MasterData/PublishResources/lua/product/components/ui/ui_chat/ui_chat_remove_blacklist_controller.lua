_class("UIChatRemoveBlacklistController", UIController)
UIChatRemoveBlacklistController = UIChatRemoveBlacklistController

function UIChatRemoveBlacklistController:OnShow(uiParams)
  self._friendData = uiParams[1]
  self._chatFriendManager = uiParams[2]
  self:_GetComponents()
  self:_Init()
end

function UIChatRemoveBlacklistController:_GetComponents()
  self._tipsLabel = self:GetUIComponent("UILocalizationText", "Tips")
  self._sendAddFriendBtnOnGo = self:GetGameObject("SendAddFriendBtnOn")
end

function UIChatRemoveBlacklistController:_Init()
  self._tipsLabel.text = StringTable.Get("str_chat_remove_from_black_list_tips", self._friendData:GetName())
  self._sendAddFriendMessage = false
  self._sendAddFriendBtnOnGo:SetActive(self._sendAddFriendMessage)
end

function UIChatRemoveBlacklistController:SendAddFriendBtnOnClick(go)
  if self._sendAddFriendMessage then
    self._sendAddFriendMessage = false
  else
    self._sendAddFriendMessage = true
  end
  self._sendAddFriendBtnOnGo:SetActive(self._sendAddFriendMessage)
end

function UIChatRemoveBlacklistController:ConfirmBtnOnClick(go)
  self:Lock("ConfirmBtnOnClick")
  GameGlobal.TaskManager():StartTask(self._RemoveFromBlackList, self)
end

function UIChatRemoveBlacklistController:_RemoveFromBlackList(TT)
  if not self._friendData then
    self:UnLock("ConfirmBtnOnClick")
    self:CloseDialog()
    return
  end
  local res = self._chatFriendManager:HandleBlackOperate(TT, self._friendData:GetFriendId(), true)
  if not res then
    self:UnLock("ConfirmBtnOnClick")
    self:CloseDialog()
    return
  end
  if not self._sendAddFriendMessage then
    self:UnLock("ConfirmBtnOnClick")
    self:CloseDialog()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateChatBlackList)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeFriendInfoSuccess)
    return
  end
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res = socialModule:InvitationFriend(TT, self._friendData:GetFriendId())
  if not res:GetSucc() then
    local retCode = res:GetResult()
    if retCode == SocialErrorCode.SOCIAL_INVITATION_MUTUAL_SUCCESS then
      ToastManager.ShowToast(StringTable.Get("str_chat_is_your_friend"))
    else
      self._chatFriendManager:HandleErrorMsgCode(retCode)
    end
  else
    ToastManager.ShowToast(StringTable.Get("str_chat_send_request_add_friend_success"))
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateChatBlackList)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeFriendInfoSuccess)
  self:UnLock("ConfirmBtnOnClick")
  self:CloseDialog()
end

function UIChatRemoveBlacklistController:CancelBtnOnClick(go)
  self:CloseDialog()
end
