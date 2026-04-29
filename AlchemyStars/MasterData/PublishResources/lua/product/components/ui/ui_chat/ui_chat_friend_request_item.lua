_class("UIChatFriendRequestItem", UICustomWidget)
UIChatFriendRequestItem = UIChatFriendRequestItem

function UIChatFriendRequestItem:OnShow(uiParam)
  self._headBg = self:GetUIComponent("UICircleMaskLoader", "headBg")
  self._head = self:GetUIComponent("RawImageLoader", "head")
  self._headRect = self:GetUIComponent("RectTransform", "head")
  self._frame = self:GetUIComponent("RawImageLoader", "frame")
  self._frameRect = self:GetUIComponent("RectTransform", "frame")
  self._headBgMaskRect = self:GetUIComponent("RectTransform", "headBgMask")
  self._headBgRect = self:GetUIComponent("RectTransform", "headBg")
  self._headRoot = self:GetUIComponent("RectTransform", "headRoot")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._level = self:GetUIComponent("UILocalizationText", "Level")
  self._requestBtnsGo = self:GetGameObject("RequestBtns")
  self._searchBtnsGo = self:GetGameObject("SearchBtns")
  self._hasRequestTipsGo = self:GetGameObject("HasRequest")
  self._tipsBgGo = self:GetGameObject("TipsBg")
  self._suggestTipsLabel = self:GetUIComponent("UILocalizationText", "SuggestTips")
  self._id = self:GetUIComponent("UILocalizationText", "Id")
  self._petPanel = self:GetUIComponent("UISelectObjectPath", "PetPanel")
  self._petList = {}
  self._maxPetCount = 4
  self._petPanel:SpawnObjects("UIChatPetItem", self._maxPetCount, self._petList)
  self._danBadgeGen = self:GetUIComponent("UISelectObjectPath", "DanBadgeSimpleGen")
  self._danBadgeGenGo = self:GetGameObject("DanBadgeSimpleGen")
  self._danBadgeGenRect = self:GetUIComponent("RectTransform", "DanBadgeSimpleGen")
end

function UIChatFriendRequestItem:Refresh(friendData, panelType, chatFriendManager, isSuggest, addFriendPanel)
  self._addFriendPanel = addFriendPanel
  self._chatFriendManager = chatFriendManager
  self._panelType = panelType
  self._friendData = friendData
  self._headBg:LoadImage(self._friendData:GetHeadBgName())
  local iconName, iconTag = self._friendData:GetHeadIconName()
  self._head:LoadImage(iconName)
  HelperProxy:GetInstance():GetHeadIconSizeWithTag(self._headRect, iconTag)
  self._frame:LoadImage(self._friendData:GetHeadFrameName())
  UIWorldBossHelper.InitOtherDanBadgeSimple(self._danBadgeGen, self._danBadgeGenGo, self._danBadgeGenRect, self._friendData:GetWorldBossInfo())
  HelperProxy:GetInstance():GetHeadBgSizeWithTag(self._headBgRect)
  HelperProxy:GetInstance():GetHeadBgMaskSizeWithTag(self._headBgMaskRect)
  HelperProxy:GetInstance():GetHeadFrameSizeWithTag(self._frameRect)
  HelperProxy:GetInstance():GetHeadRootSizeWithTag(self._headRoot, RoleHeadFrameSizeType.Size3)
  self._name.text = self._friendData:GetName()
  self._level.text = StringTable.Get("str_chat_level", tostring(self._friendData:GetLevel()))
  self._id.text = self._friendData:GetShowFriendId()
  if self._panelType == UIAddFriendPanelType.SearchFriend then
    self._requestBtnsGo:SetActive(false)
    self._searchBtnsGo:SetActive(true)
  elseif self._panelType == UIAddFriendPanelType.Request then
    self._requestBtnsGo:SetActive(true)
    self._searchBtnsGo:SetActive(false)
  end
  self._hasRequestTipsGo:SetActive(false)
  local petList = self._friendData:GetPetDataList()
  for i = 1, self._maxPetCount do
    if petList and petList[i] then
      self._petList[i]:Refresh(petList[i])
    else
      self._petList[i]:Refresh(nil)
    end
  end
  self._tipsBgGo:SetActive(false)
  if isSuggest then
    local suggestSource = self._friendData:GetSuggestSource()
    if string.isnullorempty(suggestSource) then
      self._tipsBgGo:SetActive(false)
    else
      self._tipsBgGo:SetActive(true)
      self._suggestTipsLabel.text = suggestSource
    end
    self:RefreshButtonStatus()
  end
end

function UIChatFriendRequestItem:RefreshButtonStatus()
  local hasRequest = self._addFriendPanel:IsSendRequest(self._friendData:GetFriendId())
  self._searchBtnsGo:SetActive(not hasRequest)
  self._hasRequestTipsGo:SetActive(hasRequest)
end

function UIChatFriendRequestItem:AddBtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self._SendAddFriendMsg, self)
end

function UIChatFriendRequestItem:_SendAddFriendMsg(TT)
  self:Lock("_SendAddFriendMsg")
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res, invtInfo = socialModule:InvitationFriend(TT, self._friendData:GetFriendId())
  if not res:GetSucc() then
    local retCode = res:GetResult()
    if retCode == SocialErrorCode.SOCIAL_INVITATION_MUTUAL_SUCCESS then
      ToastManager.ShowToast(StringTable.Get("str_chat_is_your_friend"))
    else
      self._chatFriendManager:HandleErrorMsgCode(retCode)
      if retCode == SocialErrorCode.SOCIAL_ERROR_IN_PEER_INV_LIST then
        self._searchBtnsGo:SetActive(false)
        self._hasRequestTipsGo:SetActive(true)
        self._addFriendPanel:SendRequest(self._friendData:GetFriendId())
      end
    end
  else
    ToastManager.ShowToast(StringTable.Get("str_chat_send_request_add_friend_success"))
    self._searchBtnsGo:SetActive(false)
    self._hasRequestTipsGo:SetActive(true)
    self._addFriendPanel:SendRequest(self._friendData:GetFriendId())
  end
  self:UnLock("_SendAddFriendMsg")
end

function UIChatFriendRequestItem:RefuseBtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self._ProcessAddFriend, self, false)
end

function UIChatFriendRequestItem:AcceptBtnOnClick(go)
  GameGlobal.TaskManager():StartTask(self._ProcessAddFriend, self, true)
end

function UIChatFriendRequestItem:_ProcessAddFriend(TT, isPass)
  self:Lock("_ProcessAddFriend")
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res = socialModule:ProcessAddFriend(TT, self._friendData:GetFriendId(), isPass)
  if not res:GetSucc() then
    local retCode = res:GetResult()
    self._chatFriendManager:HandleErrorMsgCode(retCode)
  elseif isPass then
    ToastManager.ShowToast(StringTable.Get("str_chat_add_friend_success"))
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateInvitationList, true)
  self:UnLock("_ProcessAddFriend")
end

function UIChatFriendRequestItem:HeadOnClick(go)
  self:ShowDialog("UIPlayerInfoController", PlayerInfoFrom.Chat, self._friendData:GetFriendId(), self._chatFriendManager)
end
