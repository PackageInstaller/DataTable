local FriendRequestCtrl = class("FriendRequestCtrl", BaseCtrl)
FriendRequestCtrl._mapNodeConfig = {
  inputSearch = {
    sComponentName = "TMP_InputField"
  },
  btnSearch = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Search"
  },
  txtSearchDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_SearchDesc"
  },
  txtBtnSearch = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Search"
  },
  imgEmptyBg = {},
  txtEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_RequireNone"
  },
  srRequestList = {
    sComponentName = "LoopScrollView"
  },
  btnAdoptAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AdoptAll"
  },
  btnRefuseAll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RefuseAll"
  },
  btnRecommend = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Recommend"
  },
  txtAdoptAll = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_AdoptAll"
  },
  txtRefuseAll = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_RefuseAll"
  },
  txtRecommend = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Btn_Recommend"
  },
  txtRequireCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_RequireStatistics"
  },
  txtRequireCount = {sComponentName = "TMP_Text"}
}
FriendRequestCtrl._mapEventConfig = {
  FriendRefreshRequest = "Refresh",
  FriendClearSearch = "OnEvent_ClearSearch"
}

function FriendRequestCtrl:Refresh()
  self:ChangeShow(false)
  
  local function callback()
    self:ChangeShow(true)
    self:RefreshList()
  end
  
  PlayerData.Friend:SendFriendListGetReq(callback)
end

function FriendRequestCtrl:ChangeShow(bShow)
  self._mapNode.btnAdoptAll.gameObject:SetActive(bShow)
  self._mapNode.btnRefuseAll.gameObject:SetActive(bShow)
  self._mapNode.btnRecommend.gameObject:SetActive(bShow)
  self._mapNode.btnSearch.gameObject:SetActive(bShow)
end

function FriendRequestCtrl:RefreshList()
  local nRequestNum = PlayerData.Friend:GetFriendRequestNum()
  self._mapNode.srRequestList.gameObject:SetActive(0 < nRequestNum)
  self._mapNode.imgEmptyBg:SetActive(nRequestNum == 0)
  if 0 < nRequestNum then
    for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbGridCtrl[nInstanceId] = nil
    end
    self.tbFriendRequest = PlayerData.Friend:GetFriendRequestData()
    self._mapNode.srRequestList:Init(nRequestNum, self, self.OnGridRefresh)
  end
  NovaAPI.SetTMPText(self._mapNode.txtRequireCount, string.format("<color=#08D3D4>%d</color>/%d", nRequestNum, ConfigTable.GetConfigNumber("FriendApplyMax")))
end

function FriendRequestCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapFriend = self.tbFriendRequest[nIndex]
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.FriendEx.FriendGridCtrl")
    self.tbGridCtrl[nInstanceID]:SetType(2)
  end
  self.tbGridCtrl[nInstanceID]:Refresh(mapFriend)
end

function FriendRequestCtrl:Awake()
  self.tbGridCtrl = {}
end

function FriendRequestCtrl:OnEnable()
end

function FriendRequestCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function FriendRequestCtrl:OnDestroy()
end

function FriendRequestCtrl:OnBtnClick_Search()
  local sName = NovaAPI.GetTMPInputFieldText(self._mapNode.inputSearch)
  local sPlayerAll = PlayerData.Base:GetPlayerNickName() .. "#" .. PlayerData.Base:GetPlayerHashtag()
  local nUId = PlayerData.Base:GetPlayerId()
  if sName == sPlayerAll or tonumber(sName) == nUId then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Friend_UnableSelf")
    })
    return
  end
  if sName and sName ~= "" then
    local function callback(mapData)
      EventManager.Hit("FriendSearch", mapData)
    end
    
    if string.gsub(sName, "%d", "") == "" then
      PlayerData.Friend:SendFriendUIdSearchReq(tonumber(sName), callback)
    else
      PlayerData.Friend:SendFriendNameSearchReq(sName, callback)
    end
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FRIEND_02"))
  end
end

function FriendRequestCtrl:OnBtnClick_AdoptAll()
  local nRequestNum = PlayerData.Friend:GetFriendRequestNum()
  if nRequestNum == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_NoRequest"))
    return
  end
  local nFriendNum = PlayerData.Friend:GetFriendListNum()
  if nFriendNum == ConfigTable.GetConfigNumber("FriendMax") then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FRIEND_00"))
    return
  end
  
  local function callback(mapMainData)
    if mapMainData.Limit then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FRIEND_00"))
    end
    self:RefreshList()
  end
  
  PlayerData.Friend:SendFriendAllAgreeReq(callback)
end

function FriendRequestCtrl:OnBtnClick_RefuseAll()
  local nRequestNum = PlayerData.Friend:GetFriendRequestNum()
  if nRequestNum == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_NoRequest"))
    return
  end
  
  local function callback()
    self:RefreshList()
  end
  
  local tbUId = {}
  for _, mapFriendInfo in pairs(self.tbFriendRequest) do
    table.insert(tbUId, mapFriendInfo.nUId)
  end
  PlayerData.Friend:SendFriendInvitesDeleteReq(tbUId, callback)
end

function FriendRequestCtrl:OnBtnClick_Recommend()
  local function callback(mapData)
    EventManager.Hit("FriendRecommend", mapData)
  end
  
  PlayerData.Friend:SendFriendRecommendationGetReq(callback)
end

function FriendRequestCtrl:OnEvent_ClearSearch()
  NovaAPI.SetTMPInputFieldText(self._mapNode.inputSearch, "")
end

return FriendRequestCtrl
