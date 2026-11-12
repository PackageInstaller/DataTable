local TraceHuntFriendGridCtrl = class("TraceHuntFriendGridCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
local _, Blue = ColorUtility.TryParseHtmlString("#08D3D4")
TraceHuntFriendGridCtrl._mapNodeConfig = {
  imgFriendBoss = {sComponentName = "Image"},
  txtLeftTime = {sComponentName = "TMP_Text"},
  imgLeftTime = {sComponentName = "Image"},
  btnDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  goHonorTitle_ = {
    nCount = 3,
    sCtrlName = "Game.UI.FriendEx.HonorTitleCtrl"
  },
  goSelect = {},
  goStranger = {},
  txtStranger = {
    sComponentName = "TMP_Text",
    sLanguageId = "TraceHunt_Help_Stranger"
  },
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
  imgStarFriend = {}
}
TraceHuntFriendGridCtrl._mapEventConfig = {}

function TraceHuntFriendGridCtrl:Refresh(mapData)
  self.mapData = mapData
  self.mapFriend = mapData.mapFriend
  self:SetTimer()
  self:RefreshInfo()
  self:RefreshHonorTitle()
  self:SetSelect(false)
end

function TraceHuntFriendGridCtrl:SetTimer()
  local nLeft = self.mapData.nBossCreateTime + ConfigTable.GetConfigNumber("TraceHuntBossHuntLimitTime") - ClientManager.serverTimeStamp
  if nLeft < 0 then
    nLeft = 0
  end
  self.nHuntLeftTime = nLeft
  if self.timerCountDownHunt == nil then
    self.timerCountDownHunt = self:AddTimer(0, 1, "RefreshHuntTime", false, true, false)
  end
  self:RefreshHuntTime()
  if 0 < self.nHuntLeftTime then
    self.timerCountDownHunt:Pause(false)
  end
end

function TraceHuntFriendGridCtrl:RefreshHuntTime()
  self.nHuntLeftTime = self.nHuntLeftTime - 1
  if self.nHuntLeftTime > 0 then
    local sTime = ""
    if self.nHuntLeftTime <= 60 then
      local sec = math.floor(self.nHuntLeftTime)
      sTime = orderedFormat(ConfigTable.GetUIText("TraceHunt_FriendHuntRefresh_Sec"), sec)
    elseif self.nHuntLeftTime > 60 and self.nHuntLeftTime <= 3600 then
      local min = math.floor(self.nHuntLeftTime / 60)
      local sec = math.floor(self.nHuntLeftTime - min * 60)
      if sec == 0 then
        min = min - 1
        sec = 60
      end
      sTime = orderedFormat(ConfigTable.GetUIText("TraceHunt_FriendHuntRefresh_Min"), min, sec)
    elseif self.nHuntLeftTime > 3600 and self.nHuntLeftTime <= 86400 then
      local hour = math.floor(self.nHuntLeftTime / 3600)
      local min = math.floor((self.nHuntLeftTime - hour * 3600) / 60)
      if min == 0 then
        hour = hour - 1
        min = 60
      end
      sTime = orderedFormat(ConfigTable.GetUIText("TraceHunt_FriendHuntRefresh_Hour"), hour, min)
    end
    NovaAPI.SetTMPText(self._mapNode.txtLeftTime, sTime)
  else
    NovaAPI.SetTMPText(self._mapNode.txtLeftTime, ConfigTable.GetUIText("TraceHunt_HuntEnd"))
    self.timerCountDownHunt:Pause(true)
  end
  local bNormal = self.nHuntLeftTime > self.nEmergencyTime
  NovaAPI.SetTMPColor(self._mapNode.txtLeftTime, bNormal and White_Normal or Blue)
  NovaAPI.SetImageColor(self._mapNode.imgLeftTime, bNormal and White_Normal or Blue)
end

function TraceHuntFriendGridCtrl:RefreshInfo()
  local mapCfg = ConfigTable.GetData("PlayerHead", self.mapFriend.nHeadIconId)
  if mapCfg then
    self:SetPngSprite(self._mapNode.imgHead, mapCfg.Icon)
  end
  NovaAPI.SetTMPText(self._mapNode.txtWorldClass, self.mapFriend.nWorldClass)
  NovaAPI.SetTMPText(self._mapNode.txtName, self.mapFriend.sName)
  local sTitle = orderedFormat(ConfigTable.GetUIText("FriendPanel_PlayerTitle") or "", ConfigTable.GetData("Title", self.mapFriend.nTitlePrefix).Desc, ConfigTable.GetData("Title", self.mapFriend.nTitleSuffix).Desc)
  NovaAPI.SetTMPText(self._mapNode.txtTitle, self.mapFriend.nTitlePrefix == 0 and "" or sTitle)
  self._mapNode.imgStarFriend:SetActive(self.mapData.bStar)
  self._mapNode.goStranger:SetActive(not self.mapData.bFriend)
  local mapBossCfg = ConfigTable.GetData("TraceHuntBoss", self.mapData.nBossId)
  if mapBossCfg then
    self:SetPngSprite(self._mapNode.imgFriendBoss, mapBossCfg.HeadIcon)
  end
end

function TraceHuntFriendGridCtrl:RefreshHonorTitle()
  for i = 1, 3 do
    local tbHonorTitle = self.mapFriend.tbHonorTitle or {}
    if tbHonorTitle[i] ~= nil and tbHonorTitle[i].Id > 0 then
      local honorData = ConfigTable.GetData("Honor", tbHonorTitle[i].Id)
      self._mapNode.goHonorTitle_[i]:SetHonotTitle(honorData.Id, i == 1, tbHonorTitle[i].AffinityLV)
    end
    self._mapNode.goHonorTitle_[i].gameObject:SetActive(tbHonorTitle[i] ~= nil and tbHonorTitle[i].Id > 0)
  end
end

function TraceHuntFriendGridCtrl:SetSelect(bSelect)
  self._mapNode.goSelect:SetActive(bSelect)
end

function TraceHuntFriendGridCtrl:Awake()
  self.nEmergencyTime = ConfigTable.GetConfigNumber("TraceHuntHelpEmergencyTime")
end

function TraceHuntFriendGridCtrl:OnEnable()
end

function TraceHuntFriendGridCtrl:OnDisable()
end

function TraceHuntFriendGridCtrl:OnDestroy()
end

function TraceHuntFriendGridCtrl:OnBtnClick_Detail(btn)
  if self.mapData.bFriend == false then
    local bDone = false
    for _, v in pairs(self._panel.tbAddCache) do
      if v == self.mapFriend.nUId then
        bDone = true
        break
      end
    end
    
    local function callback()
      table.insert(self._panel.tbAddCache, self.mapFriend.nUId)
    end
    
    EventManager.Hit(EventId.OpenPanel, PanelId.FriendCarte, self.mapFriend, self.nType, bDone, callback)
  else
    EventManager.Hit(EventId.OpenPanel, PanelId.FriendCarte, self.mapFriend, self.nType)
  end
end

return TraceHuntFriendGridCtrl
