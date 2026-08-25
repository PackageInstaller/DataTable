local GameObject = CS.UnityEngine.GameObject
local CompActivityDrawPrizeRewardGroup, Super = NewViewComponent("CompActivityDrawPrizeRewardGroup")

function CompActivityDrawPrizeRewardGroup:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Event_RewardGroupResource(uiNode)
  self.rewardType = data.rewardType
  self.rewardCompGroup = {}
  self.rewardType2Title = {
    [CommonDefine.LotteryRewardType.Normal] = LT.Text("LotteryNormalReward"),
    [CommonDefine.LotteryRewardType.Core] = LT.Text("LotteryCoreReward")
  }
end

function CompActivityDrawPrizeRewardGroup:OnEnterComponent()
  self:Refresh()
end

function CompActivityDrawPrizeRewardGroup:Refresh()
  self.prizeDataGroup = ActivityDrawPrizeModel.Instance.rewardGroupViewsData[self.rewardType] or {}
  self.lotteryTid = ActivityDrawPrizeModel.Instance.curSelectTab
  local remain, limit = ActivityDrawPrizeModel.Instance:GetRemainLimitByPrizeDatas(self.prizeDataGroup)
  local progress = string.format("(%d/%d)", remain, limit)
  local showTitle = LT.Text(self.rewardType2Title[self.rewardType])
  self:SetText(self.ui.Text_Title, showTitle)
  self:SetText(self.ui.Text_Quantity, progress)
  if self.rewardType == CommonDefine.LotteryRewardType.Core then
    local coreResetRemainTime = ActivityDrawPrizeModel.Instance:GetCoreResetRemainTime(self.lotteryTid)
    self.ui.Text_Reset:SetActive(true)
    self:SetText(self.ui.Text_Reset, coreResetRemainTime)
  else
    self.ui.Text_Reset:SetActive(false)
  end
  self:_RefreshRewardGroup()
end

function CompActivityDrawPrizeRewardGroup:_RefreshRewardGroup()
  for idx, prizeData in ipairs(self.prizeDataGroup) do
    local rewardComp = self.rewardCompGroup[idx] and self.rewardCompGroup[idx].comp
    local gameObject = self.rewardCompGroup[idx] and self.rewardCompGroup[idx].go
    if not gameObject or not rewardComp then
      gameObject = GameObject.Instantiate(self.ui.UI_Event_Activity_Thing_Item, self.ui.uiNode.transform)
      rewardComp = self:AddViewComponentOnce(gameObject, CompActivityDrawPrizeReward, {drawPrizeData = prizeData})
      self.rewardCompGroup[idx] = {comp = rewardComp, go = gameObject}
    end
    gameObject:SetActive(true)
    rewardComp:Refresh(prizeData)
  end
  if #self.rewardCompGroup > #self.prizeDataGroup then
    for i = #self.prizeDataGroup + 1, #self.rewardCompGroup do
      local targetGo = self.rewardCompGroup[i] and self.rewardCompGroup[i].go
      if targetGo then
        targetGo:SetActive(false)
      end
    end
  end
end

function CompActivityDrawPrizeRewardGroup:OnExitComponent()
  for _, compData in pairs(self.rewardCompGroup) do
    if not IsNil(compData.go) then
      GameObject.Destroy(compData.go)
    end
  end
  Super.OnExitComponent(self)
end

return CompActivityDrawPrizeRewardGroup
