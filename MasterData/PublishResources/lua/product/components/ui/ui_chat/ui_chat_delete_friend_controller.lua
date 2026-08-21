_class("UIChatDeleteFriendController", UIController)
UIChatDeleteFriendController = UIChatDeleteFriendController

function UIChatDeleteFriendController:OnShow(uiParams)
  self._friendData = uiParams[1]
  self._chatFriendManager = uiParams[2]
  self:_GetComponents()
  self:_Init()
end

function UIChatDeleteFriendController:_GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
end

function UIChatDeleteFriendController:_Init()
  self._name.text = StringTable.Get("str_chat_delete_friend_confirm", self._friendData:GetName())
end

function UIChatDeleteFriendController:ConfirmBtnOnClick(go)
  self:Lock("ConfirmBtnOnClick")
  GameGlobal.TaskManager():StartTask(self._DeleteFriend, self)
end

function UIChatDeleteFriendController:_DeleteFriend(TT)
  self._chatFriendManager:DeleteFriend(TT, self._friendData:GetFriendId())
  self:UnLock("ConfirmBtnOnClick")
  self:CloseDialog()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeFriendInfoSuccess)
end

function UIChatDeleteFriendController:CancelBtnOnClick(go)
  self:CloseDialog()
end
