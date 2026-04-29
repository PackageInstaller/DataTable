_class("UIBuildCollectCoinTaskItem", UICustomWidget)
UIBuildCollectCoinTaskItem = UIBuildCollectCoinTaskItem

function UIBuildCollectCoinTaskItem:OnShow(uiParams)
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._rewardLoader = self:GetUIComponent("UISelectObjectPath", "Content")
  self._completeGo = self:GetGameObject("Complete")
  self._doingGo = self:GetGameObject("Doing")
  self._unStartGo = self:GetGameObject("UnStart")
end

function UIBuildCollectCoinTaskItem:Refresh(taskData, isFirst, clickCallback)
  self._taskData = taskData
  self._countLabel:SetText(self._taskData:GetWishingCoinCount())
  self._desLabel:SetText(StringTable.Get("str_homeland_collect_coin_reward_des1", self._taskData:GetWishingCoinCount()))
  local rewards = self._taskData:GetRewards()
  local count = #rewards
  self._rewardLoader:SpawnObjects("UIBuildCollectRewardItem", count)
  local items = self._rewardLoader:GetAllSpawnList()
  for i = 1, count do
    items[i]:Refresh(rewards[i], function(id, go)
      clickCallback(id, go)
    end)
  end
  self._completeGo:SetActive(false)
  self._doingGo:SetActive(false)
  self._unStartGo:SetActive(false)
  if self._taskData:IsComplete() then
    self._completeGo:SetActive(true)
  elseif isFirst then
    self._doingGo:SetActive(true)
  else
    self._unStartGo:SetActive(true)
  end
end
