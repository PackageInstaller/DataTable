_class("UIBuildCollectCoinTask", UIController)
UIBuildCollectCoinTask = UIBuildCollectCoinTask

function UIBuildCollectCoinTask:OnShow(uiParams)
  self._collectCoinRewards = uiParams[1]
  self._taskLoader = self:GetUIComponent("UISelectObjectPath", "TaskList")
  self:RefreshUI()
end

function UIBuildCollectCoinTask:ShowItemTips(id, go)
  self:ShowDialog("UIItemTipsHomeland", id, go)
end

function UIBuildCollectCoinTask:RefreshUI()
  local tasks = self._collectCoinRewards:GetCollectCoinRewardDatas()
  if not tasks then
    return
  end
  self._taskLoader:SpawnObjects("UIBuildCollectCoinTaskItem", #tasks)
  local items = self._taskLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:Refresh(tasks[i], i == 1, function(id, pos)
      self:ShowItemTips(id, pos)
    end)
  end
end

function UIBuildCollectCoinTask:BtnCloseOnClick(go)
  self:CloseDialog()
end
