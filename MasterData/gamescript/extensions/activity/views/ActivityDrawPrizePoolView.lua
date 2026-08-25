local ActivityDrawPrizePoolView, Super = NewClass("ActivityDrawPrizePoolView", BaseView)
ActivityDrawPrizePoolView.uiResCls = UI_Event_Activity_RewardListResource

function ActivityDrawPrizePoolView:ctor()
  Super.ctor(self)
  self.model = ActivityDrawPrizeModel.Instance
  self.prizeRewardGroupComp = {}
end

function ActivityDrawPrizePoolView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnActivityDrawPrizePoolTabChanged, self.RefreshOnRendered, self)
  self:RegisterLocalNotify(NotifyId.OnActivityLotteryDataUpdated, self.RefreshOnRendered, self)
end

function ActivityDrawPrizePoolView:RegisterEvents()
end

function ActivityDrawPrizePoolView:OnEnterView()
  Super.OnEnterView(self)
  self:_InitRewardGroup()
  self:_Refresh()
end

function ActivityDrawPrizePoolView:RefreshOnRendered()
  self.ui.Content_RewardDetail.transform.anchoredPosition = CS.UnityEngine.Vector2(self.ui.Content_RewardDetail.transform.anchoredPosition.x, 0)
  for _, comp in pairs(self.prizeRewardGroupComp) do
    if comp and comp.Refresh then
      comp:Refresh()
    end
  end
  self:_Refresh()
end

function ActivityDrawPrizePoolView:_Refresh()
  self:SetText(self.ui.Text_Reward, LT.Text(self.model:GetLotteryCfgByField("Name", self.model.curSelectTab)))
end

function ActivityDrawPrizePoolView:_InitRewardGroup()
  for _, rewardType in ipairs({
    CommonDefine.LotteryRewardType.Core,
    CommonDefine.LotteryRewardType.Normal
  }) do
    local gameObject = GameObject.Instantiate(self.ui.UI_Event_RewardGroup, self.ui.Content_RewardDetail.transform)
    gameObject:SetActive(true)
    local compData = {rewardType = rewardType}
    local comp = self:AddViewComponentOnce(gameObject, CompActivityDrawPrizeRewardGroup, compData)
    comp:Refresh()
    self.prizeRewardGroupComp[rewardType] = comp
  end
end

function ActivityDrawPrizePoolView:_RestoreCanvasGroupAlpha()
  local scrollViewGo = self.ui.ScrollView_RewardDetail
  if scrollViewGo then
    local canvasGroup = scrollViewGo:GetComponent(typeof(CS.UnityEngine.CanvasGroup))
    if canvasGroup then
      canvasGroup.alpha = 1
    end
  end
end

function ActivityDrawPrizePoolView:OnExitView()
  Super.OnExitView(self)
end

return ActivityDrawPrizePoolView
