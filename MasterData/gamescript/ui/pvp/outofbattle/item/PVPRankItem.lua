local PVPRankItem, Super = System.NewComponent("PVPRankItem")
local SeasonGameplayType = CommonDefine.SeasonGameplayType
local rankCfgs = {}
for _, cfg in pairs(DT.PVPRank) do
  table.insert(rankCfgs, cfg)
end
table.sort(rankCfgs, function(a, b)
  return a.BaseSortID < b.BaseSortID
end)

function PVPRankItem:_GetField(key, defaultVal)
  if not self.data then
    return defaultVal
  end
  local getterName = "Get" .. string.upper(string.sub(key, 1, 1)) .. string.sub(key, 2)
  local getter = self.data[getterName]
  if type(getter) == "function" then
    local val = getter(self.data)
    if nil ~= val then
      return val
    end
  end
  return defaultVal
end

function PVPRankItem:ctor(obj, data, seasonTid, rankType, tabType)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_Chess_GameResource(obj)
  self.data = data
  self.seasonTid = seasonTid
  self.rankType = rankType
  self.tabType = tabType
end

function PVPRankItem:OnBind(binder)
  self.binder = binder
  binder:LoadAllLangFont(self.ui.Text_Name)
  local rank = self:_GetField("rank", 0)
  local score = self:_GetField("score", 0)
  local name = self:_GetField("name", "")
  local uid = self:_GetField("uid", 0)
  local rewardRankIndex = self:_GetField("rewardRankIndex", 0)
  binder:SetText(self.ui.Text_Ranking, rank)
  if not rank or 0 == rank then
    binder:SetText(self.ui.Text_Ranking, LT.Text("Unranked"))
  end
  binder:BindComponent((CommonHeadItem(self.ui.UI_Common_Head, {
    clickCb = System.fn(self, self._OnClick),
    headIcon = ItemDataUtils.GetAvatarIcon(self.data.icon),
    frameIcon = ItemDataUtils.GetItemIcon(self.data.avatarFrame)
  })))
  binder:SetText(self.ui.Text_Name, name)
  binder:SetText(self.ui.Text_Uid, uid)
  binder:SetActive(self.ui.Image_Pvp_Score, self.tabType == SeasonGameplayType.PvpPreBuilt)
  binder:SetActive(self.ui.Image_RotationMode_Score, self.tabType == SeasonGameplayType.PvpDraft)
  local oldSeasonTid = DT.GetConstant("PVPNewSeasonStart", 0)
  local oldSeasonCfg = DT.PVPSeason[oldSeasonTid]
  local curSeasonCfg = DT.PVPSeason[self.seasonTid]
  local isOldRank = false
  if self.seasonTid and curSeasonCfg and oldSeasonCfg then
    isOldRank = curSeasonCfg.BaseSortID < oldSeasonCfg.BaseSortID
  end
  local isInRank = 0 ~= tonumber(rank)
  self.ui.Image_Old:SetActive(isOldRank and isInRank)
  self.ui.Image_New:SetActive(not isOldRank and isInRank)
  binder:SetText(self.ui.Text_Integral, score)
  if isInRank then
    if isOldRank then
      local rankCfg
      for _, cfg in ipairs(rankCfgs) do
        if score >= cfg.ScoreRequired then
          rankCfg = cfg
        end
      end
      if rankCfg then
        binder:SetImage(self.ui.Image_Icon, rankCfg.Icon)
        binder:SetImage(self.ui.Image_Grade, CommonDefine.PVPRankStageIcon[rankCfg.Stage])
        binder:SetText(self.ui.Text_Level, LT.Text(rankCfg.Name))
        if rankCfg.ID == CommonDefine.HighestPVPRank.ID then
          self.ui.Image_Hoist:SetActive(true)
          local numStars = score - rankCfg.ScoreRequired + 1
          binder:SetText(self.ui.Text_Star, numStars)
        else
          self.ui.Image_Hoist:SetActive(false)
        end
      end
    else
      local gameplayType
      if self.rankType == RankDefine.RankType.PVP or self.rankType == RankDefine.RankType.SeasonRoPvpPrebuilt then
        gameplayType = CommonDefine.SeasonGameplayType.PvpPreBuilt
      elseif self.rankType == RankDefine.RankType.DraftPVP or self.rankType == RankDefine.RankType.SeasonRoPvpDraft then
        gameplayType = CommonDefine.SeasonGameplayType.PvpDraft
      end
      local playersNum = RankModel.Instance:GetRankLengthData(self.rankType, self.seasonTid) or 0
      local rankRow = gameplayType and rewardRankIndex > 0 and SeasonRotationModel.Instance:GetSeasonRankRewardRowByRewardIndex(self.seasonTid, gameplayType, rewardRankIndex, playersNum)
      if rankRow then
        self.ui.Image_New:SetActive(true)
        self.ui.Text_Positioning:SetActive(true)
        binder:SetImage(self.ui.Image_New, rankRow.RankIcon)
        binder:SetText(self.ui.Text_Positioning, LT.Text(rankRow.Name))
        ColorUtils.SetRankTitleColor(binder, rankRow.RankIcon, self.ui.Text_Positioning)
      else
        local rankCfg = RankModel.Instance:GetRankCfgByRewardIndex(self.rankType, self.seasonTid, rewardRankIndex)
        if rankCfg then
          self.ui.Image_New:SetActive(true)
          self.ui.Text_Positioning:SetActive(true)
          binder:SetImage(self.ui.Image_New, rankCfg.RankIcon)
          binder:SetText(self.ui.Text_Positioning, LT.Text(rankCfg.Name))
          ColorUtils.SetRankTitleColor(binder, rankCfg.RankIcon, self.ui.Text_Positioning)
        else
          self.ui.Image_New:SetActive(false)
          self.ui.Text_Positioning:SetActive(false)
        end
      end
    end
    self.ui.Text_C_Symbol_1:SetActive(false)
  else
    self.ui.Text_C_Symbol_1:SetActive(true)
  end
  self.ui.Text_C_Symbol_2:SetActive(false)
end

function PVPRankItem:_OnClick()
  local uid = self:_GetField("uid", 0)
  SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, uid)
end

return PVPRankItem
