local FriendGridCtrl = class("FriendGridCtrl", BaseCtrl)
local GridType = {
  Friend = 1,
  Request = 2,
  Search = 3,
  Energy = 4
}
FriendGridCtrl._mapNodeConfig = {
  imgHead = {sComponentName = "Image"},
  txtWorldClass = {sComponentName = "TMP_Text"},
  txtRankCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainView_RANK"
  },
  txtName = {sComponentName = "TMP_Text"},
  txtTitle = {sComponentName = "TMP_Text"},
  txtTitleName = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_TitleTag"
  },
  imgStarFriend = {},
  txtLastLogin = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_Login"
  },
  txtLoginTime1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_24Hours"
  },
  txtLoginTime2 = {sComponentName = "TMP_Text"},
  txtUID = {sComponentName = "TMP_Text"},
  txtUIDCn = {sComponentName = "TMP_Text", sLanguageId = "Friend_UID"},
  goEnergy = {},
  btnSend = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Send"
  },
  imgSend = {},
  btnGet = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Get"
  },
  imgGet = {},
  goRequest = {},
  btnAdopt = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Adopt"
  },
  btnRefuse = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Refuse"
  },
  goSearch = {},
  btnAdd = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Add"
  },
  imgUnable = {},
  txtUnable = {
    sComponentName = "TMP_Text",
    sLanguageId = "Friend_HasRequested"
  },
  goFriend = {},
  btnStar = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Star"
  },
  imgStarOn = {},
  imgStarOff = {},
  btnDel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Delete"
  },
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  goHonorTitle_ = {
    nCount = 3,
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  }
}
FriendGridCtrl._mapEventConfig = {}

function FriendGridCtrl:SetType(nType)
  self.nType = nType
  self._mapNode.goEnergy:SetActive(nType == GridType.Energy)
  self._mapNode.goRequest:SetActive(nType == GridType.Request)
  self._mapNode.goSearch:SetActive(nType == GridType.Search)
  self._mapNode.goFriend:SetActive(nType == GridType.Friend)
end

function FriendGridCtrl:Refresh(mapFriend)
  if self.nType == GridType.Search then
    self._mapNode.goSearch:SetActive(not PlayerData.Friend:JudgeIsFriend(mapFriend.nUId))
  end
  self.mapFriend = mapFriend
  self:RefreshInfo()
  self:RefreshStar()
  self:RefreshSend()
  self:RefreshGet()
  self:RefreshAdd()
  self:RefreshHonorTitle()
end

function FriendGridCtrl:RefreshInfo()
  local mapCfg = ConfigTable.GetData("PlayerHead", self.mapFriend.nHeadIconId)
  if mapCfg then
    self:SetPngSprite(self._mapNode.imgHead, mapCfg.Icon)
  end
  NovaAPI.SetTMPText(self._mapNode.txtWorldClass, self.mapFriend.nWorldClass)
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapFriend.sName)
  local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", ConfigTable.GetData("Title", self.mapFriend.nTitlePrefix).Desc, ConfigTable.GetData("Title", self.mapFriend.nTitleSuffix).Desc)
  NovaAPI.SetTMPText(self._mapNode.txtTitle, self.mapFriend.nTitlePrefix == 0 and "" or sTitle)
  local sDate, nLoginTime = PlayerData.Friend:JudgeLogin(self.mapFriend.nLogin)
  self._mapNode.txtLoginTime1.gameObject:SetActive(nLoginTime == AllEnum.LoginTime.Today)
  self._mapNode.txtLoginTime2.gameObject:SetActive(nLoginTime ~= AllEnum.LoginTime.Today)
  NovaAPI.SetTMPText(self._mapNode.txtLoginTime2, sDate)
  NovaAPI.SetTMPText(self._mapNode.txtUID, self.mapFriend.nUId)
end

function FriendGridCtrl:RefreshStar()
  self._mapNode.imgStarOn:SetActive(self.mapFriend.bStar)
  self._mapNode.imgStarOff:SetActive(not self.mapFriend.bStar)
  self._mapNode.imgStarFriend:SetActive(self.mapFriend.bStar)
end

function FriendGridCtrl:RefreshSend()
  self._mapNode.btnSend.gameObject:SetActive(not self.mapFriend.bSendEnergy)
  self._mapNode.imgSend:SetActive(self.mapFriend.bSendEnergy)
end

function FriendGridCtrl:RefreshGet()
  local nCount = PlayerData.Friend:GetEnergyCount()
  if nCount >= self.nMaxEnergy then
    self._mapNode.btnGet[1].gameObject:SetActive(false)
    self._mapNode.btnGet[2].gameObject:SetActive(false)
    self._mapNode.imgGet:SetActive(true)
    return
  end
  self._mapNode.btnGet[1].gameObject:SetActive(self.mapFriend.nGetEnergy == 1)
  self._mapNode.btnGet[2].gameObject:SetActive(self.mapFriend.nGetEnergy == 0)
  self._mapNode.imgGet:SetActive(self.mapFriend.nGetEnergy == 2)
end

function FriendGridCtrl:RefreshAdd()
  for _, v in pairs(self._panel.tbAddCache) do
    if v == self.mapFriend.nUId then
      self._mapNode.btnAdd.gameObject:SetActive(false)
      self._mapNode.imgUnable:SetActive(true)
      return
    end
  end
  self._mapNode.btnAdd.gameObject:SetActive(true)
  self._mapNode.imgUnable:SetActive(false)
end

function FriendGridCtrl:RefreshHonorTitle()
  for i = 1, 3 do
    local tbHonorTitle = self.mapFriend.tbHonorTitle or {}
    if tbHonorTitle[i] ~= nil and tbHonorTitle[i].Id > 0 then
      local honorData = ConfigTable.GetData("Honor", tbHonorTitle[i].Id)
      self._mapNode.goHonorTitle_[i]:SetHonotTitle(honorData.Id, i == 1, tbHonorTitle[i].AffinityLV)
    end
    self._mapNode.goHonorTitle_[i].gameObject:SetActive(tbHonorTitle[i] ~= nil and tbHonorTitle[i].Id > 0)
  end
end

function FriendGridCtrl:Awake()
  self.nMaxEnergy = ConfigTable.GetConfigNumber("FriendReceiveEnergyMax")
end

function FriendGridCtrl:OnEnable()
end

function FriendGridCtrl:OnDisable()
end

function FriendGridCtrl:OnDestroy()
end

function FriendGridCtrl:OnBtnClick_Delete(btn)
  local function confirmCallback()
    local function callback()
      EventManager.Hit("FriendRefreshList")
    end
    
    PlayerData.Friend:SendFriendDeleteReq(self.mapFriend.nUId, callback)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Friend_DeleteHint"),
    callbackConfirm = confirmCallback
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function FriendGridCtrl:OnBtnClick_Adopt(btn)
  local nFriendNum = PlayerData.Friend:GetFriendListNum()
  if nFriendNum == ConfigTable.GetConfigNumber("FriendMax") then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FRIEND_00"))
    return
  end
  
  local function callback()
    EventManager.Hit("FriendRefreshRequest")
  end
  
  PlayerData.Friend:SendFriendAddAgreeReq(self.mapFriend.nUId, callback)
end

function FriendGridCtrl:OnBtnClick_Refuse(btn)
  local function callback()
    EventManager.Hit("FriendRefreshRequest")
  end
  
  PlayerData.Friend:SendFriendInvitesDeleteReq({
    self.mapFriend.nUId
  }, callback)
end

function FriendGridCtrl:OnBtnClick_Add(btn)
  local nFriendNum = PlayerData.Friend:GetFriendListNum()
  if nFriendNum == ConfigTable.GetConfigNumber("FriendMax") then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FRIEND_00"))
    return
  end
  
  local function callback()
    table.insert(self._panel.tbAddCache, self.mapFriend.nUId)
    self._mapNode.btnAdd.gameObject:SetActive(false)
    self._mapNode.imgUnable:SetActive(true)
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FRIEND_01"))
  end
  
  PlayerData.Friend:SendAddFriendReq(self.mapFriend.nUId, callback)
end

function FriendGridCtrl:OnBtnClick_Star(btn)
  local function callback()
    EventManager.Hit("FriendRefreshList")
  end
  
  PlayerData.Friend:SendFriendStarSetReq({
    self.mapFriend.nUId
  }, not self.mapFriend.bStar, callback)
end

function FriendGridCtrl:OnBtnClick_Send(btn)
  if self.mapFriend.bSendEnergy then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_HasSend"))
    return
  end
  
  local function callback(UIds)
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_SendSuc"))
    for _, nId in pairs(UIds) do
      if nId == self.mapFriend.nUId then
        self.mapFriend.bSendEnergy = true
        break
      end
    end
    self:RefreshSend()
  end
  
  PlayerData.Friend:SendFriendSendEnergyReq({
    self.mapFriend.nUId
  }, callback)
end

function FriendGridCtrl:OnBtnClick_Get(btn, nIndex)
  if nIndex == 2 and self.mapFriend.nGetEnergy == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_GetNone"))
    return
  end
  local nCount = PlayerData.Friend:GetEnergyCount()
  if nCount >= self.nMaxEnergy then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Friend_MaxGet"))
    return
  end
  
  local function callback(UIds)
    for _, nId in pairs(UIds) do
      if nId == self.mapFriend.nUId then
        self.mapFriend.nGetEnergy = 2
        break
      end
    end
    self:RefreshGet()
    EventManager.Hit("FriendRefreshEnergy")
  end
  
  PlayerData.Friend:SendFriendReceiveEnergyReq({
    self.mapFriend.nUId
  }, callback)
end

function FriendGridCtrl:OnBtnClick_Detail(btn)
  if self.nType == GridType.Search then
    local bDone = false
    for _, v in pairs(self._panel.tbAddCache) do
      if v == self.mapFriend.nUId then
        bDone = true
        break
      end
    end
    
    local function callback()
      table.insert(self._panel.tbAddCache, self.mapFriend.nUId)
      self._mapNode.btnAdd.gameObject:SetActive(false)
      self._mapNode.imgUnable:SetActive(true)
    end
    
    EventManager.Hit(EventId.OpenPanel, PanelId.FriendCarte, self.mapFriend, self.nType, bDone, callback)
  else
    EventManager.Hit(EventId.OpenPanel, PanelId.FriendCarte, self.mapFriend, self.nType)
  end
end

return FriendGridCtrl
