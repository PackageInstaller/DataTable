local DailyChallengeRewardRuleItem, Super = System.NewComponent("DailyChallengeRewardRuleItem")

function DailyChallengeRewardRuleItem:ctor(uiNode, data, model)
  Super.ctor(self)
  self.ui = UI_Dungeous_Item_RewardResource(uiNode)
  self.rankID = data.rankID
  self.title = data.title
  self.titleBG = data.titleBG
  self.lowerLimit = data.lowerLimit
  self.higherLimit = data.higherLimit
  self.rewardGroup = data.rewardGroup
  self.model = model
end

function DailyChallengeRewardRuleItem:OnBind(binder)
  self.binder = binder
  local rankRanges = self.model.rankRanges
  local playerRank = self.model.currPlayerRank
  local playerRewardRankIndex = self.model.currPlayerRewardRankIndex or 0
  if 0 == #rankRanges then
    self.ui.Group_Sel:SetActive(false)
    self.ui.Text_Originally:SetActive(true)
    self.ui.Text_Hoist:SetActive(true)
    binder:SetText(self.ui.Text_Originally, "-")
    binder:SetText(self.ui.Text_Hoist, "-")
    binder:SetText(self.ui.Text_Symbol, "~")
    return
  end
  local from = 0
  local to = math.maxinteger
  for _, range in ipairs(rankRanges) do
    if range.rankID == self.rankID then
      from = range.from
      to = range.to
      break
    end
  end
  if from <= 0 then
    local playersNum = math.max(self.model.totalRankingNum or 0, 100)
    from = math.floor((self.lowerLimit or 0) * playersNum / 100) + 1
    if (self.higherLimit or 0) < 100 then
      to = math.floor((self.higherLimit or 0) * playersNum / 100)
      to = math.max(to, from)
    else
      to = math.maxinteger
    end
  end
  if from == to then
    self.ui.Text_Originally:SetActive(false)
    self.ui.Text_Hoist:SetActive(false)
    binder:SetText(self.ui.Text_Symbol, LT.Textf("TheNth", from))
  elseif to < math.maxinteger then
    self.ui.Text_Originally:SetActive(true)
    self.ui.Text_Hoist:SetActive(true)
    binder:SetText(self.ui.Text_Originally, LT.Textf("TheNth", from))
    binder:SetText(self.ui.Text_Hoist, LT.Textf("TheNth", to))
    binder:SetText(self.ui.Text_Symbol, "~")
  else
    self.ui.Text_Originally:SetActive(false)
    self.ui.Text_Hoist:SetActive(false)
    binder:SetText(self.ui.Text_Symbol, LT.Textf("AfterTheNth", from))
  end
  local isCurrentReward = false
  if playerRewardRankIndex > 0 and from > 0 then
    isCurrentReward = playerRewardRankIndex >= from and playerRewardRankIndex <= to
  else
    isCurrentReward = self.rankID == playerRank
  end
  self.ui.Group_Sel:SetActive(isCurrentReward)
  binder:BindToCircularListView(self.ui.ScrollView, function()
    return self.rewardGroup
  end, function(itemBinder, item, index)
    local data = self.rewardGroup[index]
    local itemData = {
      itemTid = data.tid,
      itemCount = data.num
    }
    itemBinder:BindComponent(CommonIconItemType2(item, itemData))
  end)
  self:BindDivingTitle(binder)
end

function DailyChallengeRewardRuleItem:BindDivingTitle(binder)
  UIComDungeonsDivingTitle.BindByTitleData(binder, self.ui.Group_Title, {
    titleText = LT.Text(self.title),
    titleIcon = self.titleBG,
    width = 325
  })
end

return DailyChallengeRewardRuleItem
