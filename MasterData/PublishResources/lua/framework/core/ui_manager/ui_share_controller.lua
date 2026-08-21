require("ui_controller")
_class("UIShareController", UIController)

function UIShareController:InitShare(storyComponent, shareTipName)
  self._isMainShare = false
  self._shareActive = false
  self._shareStoryComponent = storyComponent
  self._shareTipName = shareTipName
  if self._shareTipName == nil then
    self._shareTipName = "shareTip"
  end
  self:CheckShareBtnActive()
end

function UIShareController:GetShareStoryID()
  if not self._shareStoryComponent then
    return
  end
  local comcfgid = self._shareStoryComponent:GetComponentCfgId()
  local cfg = Cfg.cfg_component_story[comcfgid]
  if not cfg then
    Log.error("###[UIShareController] cfg is nil ! id --> ", comcfgid)
    return
  end
  local storyList = cfg.StoryID
  if not storyList or not next(storyList) then
    Log.error("###[UIShareController] storyList is nil !")
    return
  end
  return storyList[1]
end

function UIShareController:CheckShareBtnActive()
  local dataActive
  if self._shareStoryComponent then
    local storyInfo = self._shareStoryComponent:GetComponentInfo()
    local storyid = self:GetShareStoryID()
    if storyInfo.m_recieved_reward_story and table.count(storyInfo.m_recieved_reward_story) > 0 then
      dataActive = not table.icontains(storyInfo.m_recieved_reward_story, storyid)
    else
      local storyReward = Cfg.cfg_campaign_story[storyid].RewardList
      dataActive = storyReward
    end
  end
  self._shareActive = dataActive and GameGlobal.GetModule(ShareModule):CanShare()
  local goShareTip = self:GetGameObject(self._shareTipName)
  if goShareTip ~= nil then
    goShareTip:SetActive(self._shareActive)
  end
  return self._shareActive
end

function UIShareController:OnShare(beginCB, endCB, shareAnchor, shareScene)
end

function UIShareController:OnShareResult()
end

function UIShareController:OnFinishShareStory(TT, storyid)
end

function UIShareController:ShowShareRewards(rewards)
end
