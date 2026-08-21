_class("UIChatAddBlacklistController", UIController)
UIChatAddBlacklistController = UIChatAddBlacklistController

function UIChatAddBlacklistController:OnShow(uiParams)
  self._friendData = uiParams[1]
  self._chatFriendManager = uiParams[2]
  self:_GetComponents()
  self:_Init()
end

function UIChatAddBlacklistController:_GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "Name")
end

function UIChatAddBlacklistController:_Init()
  self._name.text = StringTable.Get("str_chat_add_to_blacklist_confirm", self._friendData:GetName())
end

function UIChatAddBlacklistController:ConfirmBtnOnClick(go)
  self:Lock("ConfirmBtnOnClick")
  GameGlobal.TaskManager():StartTask(self._AddToBlackList, self)
end

function UIChatAddBlacklistController:_AddToBlackList(TT)
  if not self._friendData then
    self:UnLock("ConfirmBtnOnClick")
    self:CloseDialog()
    return
  end
  local res = self._chatFriendManager:HandleBlackOperate(TT, self._friendData:GetFriendId(), false)
  self:UnLock("ConfirmBtnOnClick")
  self:CloseDialog()
  if res then
    ToastManager.ShowToast(StringTable.Get("str_chat_add_blacklist_success", self._friendData:GetName()))
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeFriendInfoSuccess)
  end
end

function UIChatAddBlacklistController:CancelBtnOnClick(go)
  self:CloseDialog()
end
