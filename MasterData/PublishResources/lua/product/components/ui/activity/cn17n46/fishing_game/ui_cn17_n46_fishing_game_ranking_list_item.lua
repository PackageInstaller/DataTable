_class("UICN17N46FishingGameRankingListItem", UICustomWidget)
UICN17N46FishingGameRankingListItem = UICN17N46FishingGameRankingListItem

function UICN17N46FishingGameRankingListItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN17N46FishingGameRankingListItem:InitWidget()
  self.rankImg = self:GetUIComponent("Image", "rankImg")
  self.rankText = self:GetUIComponent("UILocalizedTMP", "rankText")
  self.rankImgObj = self:GetGameObject("rankImg")
  self.rankTextObj = self:GetGameObject("rankText")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.headBg = self:GetUIComponent("UICircleMaskLoader", "headBg")
  self.head = self:GetUIComponent("RawImageLoader", "head")
  self.frame = self:GetUIComponent("RawImageLoader", "frame")
  self.damage = self:GetUIComponent("UILocalizationText", "damage")
  self.rank1ImgObj = self:GetGameObject("rank1")
  self.rank2ImgObj = self:GetGameObject("rank2")
  self.rank3ImgObj = self:GetGameObject("rank3")
  self.rank1ImgObj:SetActive(false)
  self.rank2ImgObj:SetActive(false)
  self.rank3ImgObj:SetActive(false)
  self.selfBgObj = self:GetGameObject("selfBg")
  self.selfBgObj:SetActive(false)
  self.selectQunObj = self:GetGameObject("selectQun")
  self.selectQunObj:SetActive(false)
  self.atlas = self:RootUIOwner():GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self.rootObj = self:GetGameObject("root")
  self.nameColor = {
    [1] = "a0853f",
    [2] = "658091",
    [3] = "af9175"
  }
end

function UICN17N46FishingGameRankingListItem:SetNull()
  self.rootObj:SetActive(false)
end

function UICN17N46FishingGameRankingListItem:SetData(rank, playerName, damage, headBgID, headIconID, frameID, isRealPlayer, isMyself, pstid, isInScroll)
  self.rootObj:SetActive(true)
  self.rank1ImgObj:SetActive(false)
  self.rank2ImgObj:SetActive(false)
  self.rank3ImgObj:SetActive(false)
  self.pstid = pstid
  self.isRealPlayer = isRealPlayer
  self.isMyself = isMyself
  self.isInScroll = isInScroll
  if not self.isInScroll then
    self.selfBgObj:SetActive(true)
    self.selectQunObj:SetActive(false)
  else
    self.selfBgObj:SetActive(false)
    self.selectQunObj:SetActive(self.isMyself)
  end
  local name = isRealPlayer and playerName or StringTable.Get(playerName)
  if rank <= 3 then
    local str1 = "<color=#" .. self.nameColor[rank] .. ">" .. rank .. "</color>"
    if rank == 1 then
      self.rank1ImgObj:SetActive(true)
      self.rankText:SetText(str1)
    elseif rank == 2 then
      self.rank2ImgObj:SetActive(true)
      self.rankText:SetText(str1)
    elseif rank == 3 then
      self.rank3ImgObj:SetActive(true)
      self.rankText:SetText(str1)
    end
    self.rankTextObj:SetActive(true)
  else
    local str = rank .. ""
    if 100 < rank then
      str = "100+"
    end
    self.rankText:SetText(str)
    self.rankTextObj:SetActive(true)
  end
  self.name:SetText(name)
  local bgIconName, iconTag = HelperProxy:GetInstance():GetHeadBgName(headBgID)
  self.headBg:LoadImage(bgIconName)
  local iconName, iconTag = HelperProxy:GetInstance():GetHeadIconName(headIconID)
  self.head:LoadImage(iconName)
  if frameID ~= nil then
    local frameName, iconTag = HelperProxy:GetInstance():GetHeadFrameName(frameID)
    self.frame.gameObject:SetActive(true)
    self.frame:LoadImage(frameName)
  else
    self.frame.gameObject:SetActive(false)
  end
  local len = string.len(damage .. "")
  local str = ""
  if len < 8 then
    local holder = ""
    for i = 1, 8 - len do
      holder = holder .. "0"
    end
    str = damage
  else
    str = damage .. ""
  end
  self.damage:SetText(str)
end

function UICN17N46FishingGameRankingListItem:BgOnClick()
  if not self.isRealPlayer then
    return
  end
  if self.isMyself then
    self:ShowDialog("UIPlayerInfoController", PlayerInfoFrom.MainLobby)
    return
  end
  local chatFriendManager = ChatFriendManager:New()
  chatFriendManager:Request(false, true, true, function(mgr)
    self:ShowDialog("UIPlayerInfoController", PlayerInfoFrom.WorldBoss, self.pstid, mgr)
  end)
end
