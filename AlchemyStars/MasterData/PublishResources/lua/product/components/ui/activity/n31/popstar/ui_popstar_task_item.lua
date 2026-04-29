_class("UIPopStarTaskItem", UICustomWidget)
UIPopStarTaskItem = UIPopStarTaskItem

function UIPopStarTaskItem:OnShow()
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._countLabel = self:GetUIComponent("UILocalizationText", "Count")
  self._complete = self:GetGameObject("Complete")
  self._rewardLoader = self:GetUIComponent("UISelectObjectPath", "Content")
end

function UIPopStarTaskItem:SetData(data, rewardClick)
  local total = data:GetTotal()
  local progress = data:GetProgress()
  self._desLabel:SetText(StringTable.Get("str_n31_popstar_task_des", total))
  self._countLabel:SetText(StringTable.Get("str_n31_popstar_challenge_level_task_count", progress, total))
  self._complete:SetActive(data:IsComplete())
  local rewards = data:GetRewards()
  self._rewardLoader:SpawnObjects("UIPopStarRewardItem", #rewards)
  local list = self._rewardLoader:GetAllSpawnList()
  for i = 1, #list do
    local item = list[i]
    item:SetData(rewards[i], data:IsComplete(), 0.9, function(id, pos)
      if rewardClick then
        rewardClick(id, pos)
      end
    end)
  end
end
