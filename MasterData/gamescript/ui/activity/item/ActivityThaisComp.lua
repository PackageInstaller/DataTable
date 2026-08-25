local ActivityThaisComp, Super = System.NewClass("ActivityThaisComp", ActivityMagicStoryComp)
local UIAnimationController = CS.Z1Client.UIAnimationController
local T_PlayableDirector = typeof(CS.UnityEngine.Playables.PlayableDirector)

function ActivityThaisComp:ctor(res, activityTid, model)
  self.ui = UI_Events_Panel_ThaisResource(res)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.resonanceGroupId = nil
  self.produceTid = ActivityDataUtils.GetProduceTid(self.activityTid)
  self.hasFinishedActivity = ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid)
  DonationBoxController.Instance:ReqDonationBoxData()
end

function ActivityThaisComp:OnBind(binder)
  Super.OnBind(self, binder)
  binder:BindToVisible(self.ui.Image_Homology, function()
    return not ActivityManager.Instance:IsActivityFinishedByTid(self.activityTid)
  end)
end

function ActivityThaisComp:BindResonanceProgress()
end

function ActivityThaisComp:BindShopItem()
  self.ui.Btn_Shop:SetActive(true)
  local paras = table.clone(self.activityConfig.ActivityPara1)
  table.remove(paras, 1)
  local lotteryIdList = paras
  local showMoneyGroup = {}
  for lotteryId, cfg in pairs(DT.Lottery) do
    if table.contains(lotteryIdList, lotteryId) then
      for _, itemId in pairs(cfg.CurrencyColumn) do
        if not table.contains(showMoneyGroup, itemId) then
          table.insert(showMoneyGroup, itemId)
        end
      end
    end
  end
  for index = 1, 3 do
    local showMoneyId = showMoneyGroup[index]
    local imageGo = self.ui["Image_Currency_0" .. index]
    local numTextGo = self.ui["Text_Currency_0" .. index]
    if not showMoneyId then
      if imageGo then
        imageGo:SetActive(false)
      end
      if numTextGo then
        numTextGo:SetActive(false)
      end
    else
      if imageGo then
        imageGo:SetActive(true)
      end
      if numTextGo then
        numTextGo:SetActive(true)
      end
      local moneyItemCfg = showMoneyId and ItemDataUtils.GetItemConfig(showMoneyId)
      if moneyItemCfg and imageGo and numTextGo then
        self.binder:BindToText(numTextGo, function()
          do return ItemDataUtils.GetItemNum end
          return ItemDataUtils.GetItemNum, showMoneyId
        end)
        self.binder:SetImageSync(imageGo, ItemDataUtils.GetIcon(showMoneyId))
      end
    end
  end
  self.binder:BindZ1Button(self.ui.Btn_Shop, function()
    ActivityDrawPrizeController.Instance:OpenActivityDrawPrizePoolView(lotteryIdList)
  end)
  self.binder:BindComponent(RedDotComponent(self.ui.Red_Shop, nil, nil, function()
    local isRed = false
    for _, lotteryTid in pairs(lotteryIdList) do
      isRed = isRed or RedPointDataUtils.GetLotteryPoolRed(lotteryTid)
    end
    return isRed
  end))
  self.playableDirector = self.ui.uiNode:GetComponent(T_PlayableDirector)
end

function ActivityThaisComp:BindAchievementProgress()
  Super.BindAchievementProgress(self)
end

function ActivityThaisComp:BindSubPlotRecord()
  self.binder:BindButtonClick(self.ui.Btn_Record, function()
    UIManager.Instance:Reopen(Urls.CopyMainView, CommonDefine.MainCopyPanelPage.Vindicate)
  end)
  self.binder:SetActive(self.ui.NewTag_Record, true)
  self.binder:BindComponent(NewRedCom(UIBaseResource(self.ui.NewTag_Record).Group_New)):BindFirstFeatureOpen(cd.FeatureId.ConfessionEvent)
end

function ActivityThaisComp:BindBtnChallenge()
  self.binder:BindZ1Button(self.ui.Btn_Challenge, function()
    ActivityController.Instance:OpenActivityStageGroupPanel(self.activityData, self.resonanceGroupId)
  end)
  local stageGroupTypeId = self.activityConfig.ActivityPara1[1]
  local stageGroupList = CopyDataUtils.GetStageGroupIdList(stageGroupTypeId)
  self:BindNewStageGroupRed(stageGroupList)
end

function ActivityThaisComp:OnOpenAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_MagicStory_Open", callback)
  if self.playableDirector then
    self.playableDirector:Stop()
    self.playableDirector.time = 0
    self.playableDirector:Play()
  end
end

function ActivityThaisComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Panel_MagicStory_Close")
  if self.playableDirector then
    self.playableDirector:Stop()
  end
  callback()
end

return ActivityThaisComp
