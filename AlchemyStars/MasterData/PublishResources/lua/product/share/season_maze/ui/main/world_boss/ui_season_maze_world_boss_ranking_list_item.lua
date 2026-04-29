_class("UISeasonMazeWorldBossRankingListItem", UICustomWidget)
UISeasonMazeWorldBossRankingListItem = UISeasonMazeWorldBossRankingListItem

function UISeasonMazeWorldBossRankingListItem:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonMazeWorldBossRankingListItem:InitWidget()
  self.rankImg = self:GetUIComponent("Image", "rankImg")
  self.rankText = self:GetUIComponent("UILocalizationText", "rankText")
  self.rankImgObj = self:GetGameObject("rankImg")
  self.rankTextObj = self:GetGameObject("rankText")
  self.name = self:GetUIComponent("UILocalizationText", "name")
  self.headBg = self:GetUIComponent("UICircleMaskLoader", "headBg")
  self.head = self:GetUIComponent("RawImageLoader", "head")
  self.frame = self:GetUIComponent("RawImageLoader", "frame")
  self.damage = self:GetUIComponent("UILocalizationText", "damage")
  self.atlas = self:RootUIOwner():GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self.rootObj = self:GetGameObject("root")
  self.nameColor = {
    [1] = "a0853f",
    [2] = "658091",
    [3] = "af9175"
  }
end

function UISeasonMazeWorldBossRankingListItem:SetNull()
  self.rootObj:SetActive(false)
end

function UISeasonMazeWorldBossRankingListItem:SetData(rank, playerName, damage, headBgID, headIconID, frameID, isRealPlayer)
  self.rootObj:SetActive(true)
  local name = isRealPlayer and playerName or StringTable.Get(playerName)
  if rank <= 3 then
    self.rankImg.sprite = self.atlas:GetSprite("cn15_sjmjhd_zi0" .. rank)
    self.rankImgObj:SetActive(true)
    self.rankTextObj:SetActive(false)
    name = "<color=#" .. self.nameColor[rank] .. ">" .. name .. "</color>"
  else
    local str = rank .. ""
    if 100 < rank then
      str = "100+"
    end
    self.rankText:SetText(str)
    self.rankImgObj:SetActive(false)
    self.rankTextObj:SetActive(true)
  end
  self.name:SetText(name)
  local bgIconName, iconTag = HelperProxy:GetInstance():GetHeadBgName(headBgID)
  self.headBg:LoadImage(bgIconName)
  local iconName, iconTag = HelperProxy:GetInstance():GetHeadIconName(headIconID)
  self.head:LoadImage(iconName)
  local frameName, iconTag = HelperProxy:GetInstance():GetHeadFrameName(frameID)
  self.frame:LoadImage(frameName)
  local showNum, oriNum = HelperProxy:GetInstance():SMazeDamageUnit(damage)
  local str = ""
  if oriNum then
    local len = string.len(damage .. "")
    if len < 8 then
      local holder = ""
      for i = 1, 8 - len do
        holder = holder .. "0"
      end
      str = "<color=#949598>" .. holder .. "</color>" .. damage
    else
      str = damage .. ""
    end
  else
    str = showNum
  end
  self.damage:SetText(str)
end
