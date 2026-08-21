_class("UIChatAddFriendPanel", UICustomWidget)
UIChatAddFriendPanel = UIChatAddFriendPanel
local UIAddFriendPanelType = {SearchFriend = 1, Request = 2}
_enum("UIAddFriendPanelType", UIAddFriendPanelType)

function UIChatAddFriendPanel:OnShow(uiParam)
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "RequestList")
  self._requestCanvasGroup = self:GetUIComponent("CanvasGroup", "RequestList")
  self._requestPanel = self:GetGameObject("RequestPanel")
  self._searchPanel = self:GetGameObject("SearchPanel")
  self._suggestedFriendPanel = self:GetGameObject("SuggestedFriendPanel")
  self._dontSearchFriendGo = self:GetGameObject("DontSearchFriend")
  self._sarchBtnOn = self:GetGameObject("SearchBtnOn")
  self._sarchLineOn = self:GetGameObject("SearchLineOn")
  self._requestBtnOn = self:GetGameObject("RequestBtnOn")
  self._requestLineOn = self:GetGameObject("RequestLineOn")
  self._searchIdInput = self:GetUIComponent("InputField", "SearchInput")
  self._searchResultParent = self:GetUIComponent("UISelectObjectPath", "SearchResult")
  self._haveNewFriendRequestGo = self:GetGameObject("HaveNewFriendRequest")
  self._requestCountLabel = self:GetUIComponent("UILocalizationText", "RequestCount")
  self._requestParentGo = self:GetGameObject("RequestParent")
  self._requestEmptyParentGo = self:GetGameObject("RequestEmptyParent")
  self._suggestedScrollView = self:GetUIComponent("UIDynamicScrollView", "SugestedList")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._timeGo = self:GetGameObject("Time")
  self._clearBtnGo = self:GetGameObject("ClearBtn")
  self._isInited = false
  self:AttachEvent(GameEventType.UpdateInvitationList, self._UpdateInvitationList)
  self:AttachEvent(GameEventType.UpdateFriendInvitation, self._UpdateInvitationList)
  self:AddUIEvent(UIEvent.InputFieldChanged, self._searchIdInput)
  local socialModule = GameGlobal.GetModule(SocialModule)
  if not socialModule.hasSendRequestList then
    socialModule.hasSendRequestList = {}
  end
  self._hasSendRequestList = socialModule.hasSendRequestList
  self._nameTex = self:GetUIComponent("UILocalizationText", "UserName")
  self._idTex = self:GetUIComponent("UILocalizationText", "id")
  self._roleModule = self:GetModule(RoleModule)
  self._playerInfo = self._roleModule:UI_GetPlayerInfo()
  self._userName = self._playerInfo.m_stRoleName
  self._roleId = self._playerInfo.m_player_showid
  self._nameTex:SetText(self._userName)
  local id = self._roleId
  self._idTex:SetText(StringTable.Get("str_player_info_id") .. id)
end

function UIChatAddFriendPanel:MessageInputOnValueChanged()
  self:_RefreshClearBtnStatus()
  if string.isnullorempty(self._searchIdInput.text) and self._suggestedFriendPanel.activeInHierarchy == false then
    self:_SwitchPanel(UIAddFriendPanelType.SearchFriend, true)
  end
end

function UIChatAddFriendPanel:OnHide()
  self:DetachEvent(GameEventType.UpdateInvitationList, self._UpdateInvitationList)
  self:DetachEvent(GameEventType.UpdateFriendInvitation, self._UpdateInvitationList)
  if self._cdEventHandler then
    GameGlobal.Timer():CancelEvent(self._cdEventHandler)
  end
  self._cdEventHandler = nil
end

function UIChatAddFriendPanel:Init(uiChatController)
  if self._isInited == false then
    self._uiChatController = uiChatController
    self._chatFriendManager = self._uiChatController:GetChatFriendManager()
    self._panelType = self._uiChatController:GetCurrentPanelType()
    self._searchResultItem = self._searchResultParent:SpawnObject("UIChatFriendRequestItem")
  end
  if self._isInited == false then
    self._requestDatas = {}
    self._requestCount = #self._requestDatas
    self:_InitScrollView()
    self._suggestFriendList = {}
    self._suggestFriendCount = table.count(self._suggestFriendList)
    self:_InitSuggestScrollView()
    self._isInCD = false
    self._cdTimer = 5
    self._cdEventHandler = nil
    self._timeGo:SetActive(false)
  end
  local socialModule = GameGlobal.GetModule(SocialModule)
  local hasRequest = socialModule:HaveNewInvitation()
  if hasRequest then
    self:_SwitchPanel(UIAddFriendPanelType.Request)
  else
    self:_SwitchPanel(UIAddFriendPanelType.SearchFriend)
  end
  self._isInited = true
end

function UIChatAddFriendPanel:_RefreshClearBtnStatus()
  if string.isnullorempty(self._searchIdInput.text) then
    self._clearBtnGo:SetActive(false)
  else
    self._clearBtnGo:SetActive(true)
  end
end

function UIChatAddFriendPanel:_SwitchPanel(panelType, notIgnore)
  self._requestPanel:SetActive(false)
  if not notIgnore then
    self._searchPanel:SetActive(false)
  end
  self._sarchBtnOn:SetActive(false)
  self._sarchLineOn:SetActive(false)
  self._requestBtnOn:SetActive(false)
  self._requestLineOn:SetActive(false)
  self._suggestedFriendPanel:SetActive(false)
  self._currentPanelType = panelType
  if panelType == UIAddFriendPanelType.SearchFriend then
    if not notIgnore then
      self._searchPanel:SetActive(true)
    end
    self._sarchBtnOn:SetActive(true)
    self._sarchLineOn:SetActive(true)
    self:_ShowSuggestedFriend(true, false)
    self:_RefreshClearBtnStatus()
  elseif panelType == UIAddFriendPanelType.Request then
    self._requestPanel:SetActive(true)
    self._requestBtnOn:SetActive(true)
    self._requestLineOn:SetActive(true)
    self:_RefreshRequestPanel()
  end
  self:_RefreshHaveNewFriendRequestStatus()
end

function UIChatAddFriendPanel:_ShowSuggestedFriend(isEnter, isRefresh)
  self._dontSearchFriendGo:SetActive(false)
  local go = self._searchResultItem:GetGameObject()
  go:SetActive(false)
  self._searchIdInput.text = ""
  self:Lock("_ShowSuggestedFriend")
  GameGlobal.TaskManager():StartTask(self._ShowSuggestedFriendCoro, self, isEnter, isRefresh)
end

function UIChatAddFriendPanel:_ShowSuggestedFriendCoro(TT, isEnter, isRefresh)
  if isEnter then
    self:_ResetCD()
  end
  self._suggestFriendList = self._chatFriendManager:GetSuggestFriendList(TT, isRefresh)
  self._suggestedFriendPanel:SetActive(true)
  self._suggestFriendCount = table.count(self._suggestFriendList)
  self._suggestedScrollView:SetListItemCount(self._suggestFriendCount, false)
  self._suggestedScrollView:RefreshAllShownItem()
  self._suggestedScrollView:MovePanelToItemIndex(0, 0)
  self:UnLock("_ShowSuggestedFriend")
end

function UIChatAddFriendPanel:IsSendRequest(friendId)
  if not friendId then
    return false
  end
  if self._hasSendRequestList[friendId] ~= nil then
    return true
  end
  return false
end

function UIChatAddFriendPanel:SendRequest(friendId)
  self._hasSendRequestList[friendId] = true
end

function UIChatAddFriendPanel:_UpdateInvitationList(isPlayAnim)
  self:_RefreshHaveNewFriendRequestStatus()
  if not self:_IsPanelActive() then
    return
  end
  if self._currentPanelType == UIAddFriendPanelType.Request then
    self:_RefreshRequestPanel(isPlayAnim)
  end
end

function UIChatAddFriendPanel:_RefreshHaveNewFriendRequestStatus()
  local socialModule = GameGlobal.GetModule(SocialModule)
  self._haveNewFriendRequestGo:SetActive(socialModule:HaveNewInvitation())
end

function UIChatAddFriendPanel:_ShowSearchResult(friendData)
  self._suggestedFriendPanel:SetActive(false)
  local go = self._searchResultItem:GetGameObject()
  if not friendData then
    go:SetActive(false)
    self._dontSearchFriendGo:SetActive(true)
    return
  end
  self._dontSearchFriendGo:SetActive(false)
  go:SetActive(true)
  self._searchResultItem:Refresh(friendData, self._currentPanelType, self._chatFriendManager, false, self)
end

function UIChatAddFriendPanel:_RefreshRequestPanel(isPlayAnim)
  self._requestParentGo:SetActive(false)
  self._requestEmptyParentGo:SetActive(false)
  GameGlobal.TaskManager():StartTask(self._RequestFriendInvitationList, self, isPlayAnim, function()
    if self._requestCount <= 0 then
      self._requestParentGo:SetActive(false)
      self._requestEmptyParentGo:SetActive(true)
    else
      self._requestParentGo:SetActive(true)
      self._requestEmptyParentGo:SetActive(false)
      self._scrollView:SetListItemCount(self._requestCount, false)
      self._scrollView:RefreshAllShownItem()
      local str = self._requestCount .. "/" .. self._chatFriendManager:GetMaxAddFriendRequestCount()
      self._requestCountLabel.text = StringTable.Get("str_chat_request_tips", str)
    end
  end)
end

function UIChatAddFriendPanel:_RequestFriendInvitationList(TT, isPlayAnim, callback)
  self:Lock("_RequestFriendInvitationList")
  local socialModule = GameGlobal.GetModule(SocialModule)
  local res, friendList = socialModule:GetFriendInvitationList(TT)
  if res:GetSucc() then
    self._requestDatas = {}
    if friendList then
      for k, v in pairs(friendList) do
        local simpleInfo = v.sender_info
        local createTime = v.create_time
        local hasNewMessage = false
        local chatFriendData = ChatFriendData:New(simpleInfo.pstid, simpleInfo.head, simpleInfo.head_bg, simpleInfo.frame_id, simpleInfo.level, simpleInfo.nick, hasNewMessage, simpleInfo.is_online, simpleInfo.create_time, 0, simpleInfo.last_logout_time, simpleInfo.remark_name, simpleInfo.help_pet, simpleInfo.world_boss_info, simpleInfo.homeland_info)
        chatFriendData.requestTime = createTime
        self._requestDatas[#self._requestDatas + 1] = chatFriendData
      end
      self._uiChatController:_UpdateHaveNewFriendRequestStatus()
      self:_RefreshHaveNewFriendRequestStatus()
      table.sort(self._requestDatas, function(a, b)
        local aTime = a.requestTime
        local bTime = b.requestTime
        if aTime ~= bTime then
          return aTime > bTime
        end
        return a:GetFriendId() > b:GetFriendId()
      end)
    end
    self._requestCount = #self._requestDatas
  else
    self._chatFriendManager:HandleErrorMsgCode(res:GetResult())
  end
  if isPlayAnim then
    self._requestCanvasGroup:DOFade(0, 0.165):OnComplete(function()
      self._requestCanvasGroup.alpha = 1
      if callback then
        callback()
      end
      self:UnLock("_RequestFriendInvitationList")
    end)
    return
  end
  self._requestCanvasGroup.alpha = 1
  if callback then
    callback()
  end
  self:UnLock("_RequestFriendInvitationList")
end

function UIChatAddFriendPanel:_IsPanelActive()
  if not self._isInited then
    return false
  end
  if not self._uiChatController then
    return false
  end
  if self._panelType ~= self._uiChatController:GetCurrentPanelType() then
    return false
  end
  return true
end

function UIChatAddFriendPanel:_InitScrollView()
  self._scrollView:InitListView(self._requestCount, function(scrollview, index)
    return self:_OnGetRequestItem(scrollview, index)
  end)
end

function UIChatAddFriendPanel:_OnGetRequestItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIChatFriendRequestItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._requestCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      self:_RefreshFriendRequestItemInfo(itemWidget, itemIndex)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIChatAddFriendPanel:_RefreshFriendRequestItemInfo(itemWidget, index)
  itemWidget:Refresh(self._requestDatas[index], self._currentPanelType, self._chatFriendManager)
end

function UIChatAddFriendPanel:_InitSuggestScrollView()
  self._suggestedScrollView:InitListView(self._suggestFriendCount, function(scrollview, index)
    return self:_OnGetSuggestFriendItem(scrollview, index)
  end)
end

function UIChatAddFriendPanel:_OnGetSuggestFriendItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UIChatFriendRequestItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._suggestFriendCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      self:_RefreshSuggestFriendItemInfo(itemWidget, itemIndex)
      itemWidget:GetGameObject():SetActive(true)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UIChatAddFriendPanel:_RefreshSuggestFriendItemInfo(itemWidget, index)
  itemWidget:Refresh(self._suggestFriendList[index], self._currentPanelType, self._chatFriendManager, true, self)
end

function UIChatAddFriendPanel:SearchBtnOnClick(go)
  if self._currentPanelType == UIAddFriendPanelType.SearchFriend then
    return
  end
  self:_SwitchPanel(UIAddFriendPanelType.SearchFriend)
end

function UIChatAddFriendPanel:RequestBtnOnClick(go)
  if self._currentPanelType == UIAddFriendPanelType.Request then
    return
  end
  self:_SwitchPanel(UIAddFriendPanelType.Request)
end

function UIChatAddFriendPanel:SearchFriendBtnOnClick(go)
  local friendId = self._searchIdInput.text
  if friendId == nil or friendId == "" then
    ToastManager.ShowToast(StringTable.Get("str_chat_error_search_pstid_is_empty"))
    return
  end
  local showId = tonumber(friendId)
  if showId <= 0 or 9223372036854775807 < showId then
    self._chatFriendManager:HandleErrorMsgCode(SocialErrorCode.SOCIAL_SEARCH_PSTID_INVALID)
    return
  end
  GameGlobal.TaskManager():StartTask(self._SearchFriendRequest, self, showId)
end

function UIChatAddFriendPanel:_SearchFriendRequest(TT, showId)
  self:Lock("_SearchFriendRequest")
  local loginModule = GameGlobal.GetModule(LoginModule)
  local socialModule = GameGlobal.GetModule(SocialModule)
  local idList = {}
  idList[#idList + 1] = loginModule:GetPstIdByShowId(showId)
  local res, playerInfoList = socialModule:HandleSearchPlayer(TT, idList)
  if res:GetSucc() then
    local simpleInfo = playerInfoList[1]
    local createTime = 0
    local hasNewMessage = false
    local friendData = ChatFriendData:New(simpleInfo.pstid, simpleInfo.head, simpleInfo.head_bg, simpleInfo.frame_id, simpleInfo.level, simpleInfo.nick, hasNewMessage, simpleInfo.is_online, simpleInfo.create_time, 0, simpleInfo.last_logout_time, simpleInfo.remark_name, simpleInfo.help_pet, simpleInfo.world_boss_info, simpleInfo.homeland_info)
    self:_ShowSearchResult(friendData)
  else
    self._chatFriendManager:HandleErrorMsgCode(res:GetResult())
    self:_ShowSearchResult(nil)
  end
  self:UnLock("_SearchFriendRequest")
end

function UIChatAddFriendPanel:RefreshBtnOnClick(go)
  if self._isInCD then
    return
  end
  self:_ShowSuggestedFriend(false, true)
  self._isInCD = true
  self._cdTimer = 5
  self._timeGo:SetActive(true)
  self._timeLabel.text = "(" .. self._cdTimer .. ")"
  self._cdEventHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, self._CDTimeDown, self)
end

function UIChatAddFriendPanel:_CDTimeDown()
  self._cdTimer = self._cdTimer - 1
  if self._cdTimer <= 0 then
    self:_ResetCD()
  end
  self._timeLabel.text = "(" .. self._cdTimer .. ")"
end

function UIChatAddFriendPanel:_ResetCD()
  self._timeGo:SetActive(false)
  self._isInCD = false
  if self._cdEventHandler then
    GameGlobal.Timer():CancelEvent(self._cdEventHandler)
  end
  self._cdEventHandler = nil
end

function UIChatAddFriendPanel:ClearBtnOnClick(go)
  self._searchIdInput.text = ""
  if self._suggestedFriendPanel.activeInHierarchy == false then
    self:_SwitchPanel(UIAddFriendPanelType.SearchFriend)
  end
end

function UIChatAddFriendPanel:IdCopyOnClick(go)
  local copyid = self._roleId
  HelperProxy:GetInstance():CopyString(copyid)
  ToastManager.ShowToast(StringTable.Get("str_player_info_id_copy_succ"))
end
