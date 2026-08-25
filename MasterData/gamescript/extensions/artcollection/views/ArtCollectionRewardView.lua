local ArtCollectionRewardView, Super = NewClass("ArtCollectionRewardView", ProgressRewardViewBase)
ArtCollectionRewardView.uiResCls = UI_Chaper_Popup_Award_OptimizedResource

function ArtCollectionRewardView:ctor(rewardType)
  Super.ctor(self)
  self.rewardType = rewardType
end

function ArtCollectionRewardView:OnBuildView()
  Super.OnBuildView(self)
end

function ArtCollectionRewardView:RegisterEvents()
  Super.RegisterEvents(self)
end

function ArtCollectionRewardView:RegisterNotifications()
  self:RegisterNotify(NotifyId.CollectionRewardGet, self.RefreshLoad, self)
end

function ArtCollectionRewardView:RefreshLoad()
  self:_RefreshRewardList(true)
end

function ArtCollectionRewardView:OnEnterView()
  Super.OnEnterView(self)
  local Text_Title = self.ui.Text_Title
  if Text_Title then
    self:SetText(Text_Title, LT.Text("ArchiveCollectionRewardsTitle"))
  end
end

function ArtCollectionRewardView:_GetProgressDataList()
  self.progressDataList = ArtCollectionRewardModel.Instance:GetProgressRewardDatas(self.rewardType)
  return self.progressDataList
end

function ArtCollectionRewardView:ReqOneKeyReward(callback)
  local taskTidList = {}
  local taskCfgList = ArtCollectionRewardModel.Instance:GetTaskCfg()[self.rewardType]
  if not taskCfgList then
    return
  end
  for _, cfgId in pairs(taskCfgList) do
    local state = ArtCollectionRewardModel.Instance:GetTaskState(cfgId)
    if state == CommonDefine.TaskState.Receive then
      table.insert(taskTidList, cfgId)
    end
  end
  TaskController.Instance:ReqOnBatchGainPrize(ArtCollectionDefine.TaskServerIndex, taskTidList, function()
    ArtCollectionRewardModel.Instance:UpdateTaskData()
    if callback then
      callback()
    end
  end)
end

function ArtCollectionRewardView:_OnClickClose()
  ArtCollectionRewardModel.Instance:UpdateTaskData()
  Super._OnClickClose(self)
end

function ArtCollectionRewardView:OnExitView()
  Super.OnExitView(self)
end

return ArtCollectionRewardView
