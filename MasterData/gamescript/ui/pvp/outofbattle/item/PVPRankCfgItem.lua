local PVPRankCfgItem, Super = System.NewComponent("PVPRankCfgItem")

function PVPRankCfgItem:ctor(obj, rankRow, selfRewardRankIndex, rankType, seasonTid, playersNum)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_RankingResource(obj)
  self.rankRow = rankRow
  self.selfRewardRankIndex = selfRewardRankIndex or 0
  self.rankType = rankType
  self.seasonTid = seasonTid
  self.playersNum = playersNum or 0
end

function PVPRankCfgItem:OnBind(binder)
  self.binder = binder
  self.binder:SetText(self.ui.Text_Positioning, LT.Text(self.rankRow.Name))
  self.binder:SetImage(self.ui.Image_Positioning, self.rankRow.RankIcon)
  ColorUtils.SetRankTitleColor(binder, self.rankRow.RankIcon, self.ui.Text_Positioning)
  self.playersNum = math.max(self.playersNum or 0, 100)
  local miniCount = math.floor((self.rankRow.RankLowerInterval or 0) * self.playersNum / 100)
  local maxCount = math.floor((self.rankRow.RankUpperInterval or 0) * self.playersNum / 100)
  local from = miniCount + 1
  local to = math.max(maxCount, from)
  if from < to then
    binder:SetText(self.ui.Text_Ranking_01, LT.Textf("TheNth", from))
    binder:SetText(self.ui.Text_Ranking_02, LT.Textf("TheNth", to))
    binder:SetText(self.ui.Text_C_Over, "~")
  else
    binder:SetText(self.ui.Text_Ranking_01, "")
    binder:SetText(self.ui.Text_Ranking_02, "")
    binder:SetText(self.ui.Text_C_Over, LT.Textf("TheNth", from))
  end
  local isInTier = from <= self.selfRewardRankIndex and to >= self.selfRewardRankIndex
  self.ui.Image_Current:SetActive(isInTier)
  self:CreateRewardTable()
end

function PVPRankCfgItem:CreateRewardTable()
  local baseGameObj = self.ui.UI_Common_Item_WuPin_Type2
  local sizeDelta = baseGameObj.transform.sizeDelta
  local scaleX = baseGameObj.transform.localScale.x
  local itemW, itemH = sizeDelta.x * scaleX, sizeDelta.y * scaleX
  local itemComps = {}
  local rewardList = {}
  local rewardMap = self.rankRow.NewRankReward or {}
  for tid, count in pairs(rewardMap) do
    table.insert(rewardList, {itemTid = tid, itemCount = count})
  end
  self.tableView = UIBasePanel.CreateTableview(self, self.ui.ScrollView, function()
    return #rewardList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local itemData = rewardList[idx]
    itemComps[gameObj] = self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
  self.tableView:ReloadData()
end

return PVPRankCfgItem
