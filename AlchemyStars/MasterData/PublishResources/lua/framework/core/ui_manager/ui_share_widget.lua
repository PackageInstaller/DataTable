_class("UIShareWidget", Object)
UIShareWidget = UIShareWidget

function UIShareWidget:InitShare(controller, storyComponent, shareTipName)
  if not storyComponent or not GameGlobal.GetModule(ShareModule):CanShare() then
    return
  end
  self._controller = controller
  self._isMainShare = false
  self._shareActive = false
  self._shareStoryComponent = storyComponent
  self._shareTipName = shareTipName
  if self._shareTipName == nil then
    self._shareTipName = "shareTip"
  end
  self._controller:AttachEvent(GameEventType.OnFocusAfterShareBack, self.OnShareResult, self)
  self:CheckShareBtnActive()
end

function UIShareWidget:GetShareStoryID()
  local comcfgid = self._shareStoryComponent:GetComponentCfgId()
  local cfg = Cfg.cfg_component_story[comcfgid]
  if not cfg then
    Log.error("###[UIShareWidget] cfg is nil ! id --> ", comcfgid)
    return
  end
  local storyList = cfg.StoryID
  if not storyList or not next(storyList) then
    Log.error("###[UIShareWidget] storyList is nil !")
    return
  end
  return storyList[1]
end

function UIShareWidget:CheckShareBtnActive()
  local storyInfo = self._shareStoryComponent:GetComponentInfo()
  local storyid = self:GetShareStoryID()
  local dataActive
  if storyInfo.m_recieved_reward_story and table.count(storyInfo.m_recieved_reward_story) > 0 then
    dataActive = not table.icontains(storyInfo.m_recieved_reward_story, storyid)
  else
    local storyReward = Cfg.cfg_campaign_story[storyid].RewardList
    dataActive = storyReward
  end
  self._shareActive = dataActive and GameGlobal.GetModule(ShareModule):CanShare()
  local goShareTip = self._controller:GetGameObject(self._shareTipName)
  if goShareTip ~= nil then
    goShareTip:SetActive(self._shareActive)
  end
  return self._shareActive
end

function UIShareWidget:OnShare(beginCB, endCB, shareAnchor, shareScene)
  if not self._shareStoryComponent or not GameGlobal.GetModule(ShareModule):CanShare() then
    return
  end
  if shareAnchor == nil then
    shareAnchor = ShareAnchorType.BottomRight
  end
  if shareScene == nil then
    shareScene = ShareSceneType.CampaignKV
  end
  local lockName = "UIShareWidget::OnShare"
  self._controller:StartTask(function(TT)
    self._controller:Lock(lockName)
    self._isMainShare = true
    beginCB()
    local goShareTip = self._controller:GetGameObject(self._shareTipName)
    if goShareTip ~= nil then
      goShareTip:SetActive(false)
    end
    YIELD(TT)
    self._controller:ShowDialog("UIShare", self._controller:GetName(), shareAnchor, function()
      self:CheckShareBtnActive()
      if goShareTip ~= nil then
        goShareTip:SetActive(self._shareActive)
      end
      endCB(self._shareActive)
    end, nil, nil, nil, shareScene)
    self._controller:UnLock(lockName)
  end, self)
end

function UIShareWidget.OnShareResult(controller, shareWidget)
  if not shareWidget._isMainShare then
    return
  end
  shareWidget._isMainShare = false
  if not shareWidget._shareActive then
    return
  end
  local goShareTip = controller:GetGameObject(shareWidget._shareTipName)
  if goShareTip ~= nil then
    goShareTip:SetActive(shareWidget._shareActive)
  end
  local storyid = shareWidget:GetShareStoryID()
  controller:StartTask(shareWidget.OnFinishShareStory, shareWidget, storyid)
end

function UIShareWidget:OnFinishShareStory(TT, storyid)
  local lockName = "UIShareWidget::OnFinishShareStory"
  self._controller:Lock(lockName)
  local res = AsyncRequestRes:New()
  local rewards = self._shareStoryComponent:HandleStoryTake(TT, res, storyid)
  self._controller:UnLock(lockName)
  if res:GetSucc() then
    self:ShowShareRewards(rewards)
  else
    Log.error("###[UIShareWidget] OnFinishStory fail, result:", res:GetResult(), " storyid:", storyid)
  end
end

function UIShareWidget:ShowShareRewards(rewards)
  if not rewards then
    return
  end
  if self._controller.view == nil then
    return
  end
  self._controller:ShowDialog("UIGetItemController", rewards, function()
    self:CheckShareBtnActive()
  end)
  GameGlobal.UIStateManager():CallUIMethod("UIShare", "HideTipsTex")
end
