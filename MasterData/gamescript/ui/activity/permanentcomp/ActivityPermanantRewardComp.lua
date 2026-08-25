local ActivityPermanantRewardComp, Super = System.NewComponent("ActivityPermanantRewardComp")
local TaskState = CommonDefine.TaskState
local SeasonGameplayType = CommonDefine.SeasonGameplayType

function ActivityPermanantRewardComp:ctor(uiNode, activityTid)
  Super.ctor(self)
  self.ui = UI_Events_Panel_PermanentActivityResource(uiNode)
  self._activityTid = activityTid
  self._activityType2RewardInfoList = {
    [ActivityDefine.ActivityType.RailWayActivity] = function()
      do return RailWayModel.Instance.GetNotReceiveRewardInfoList end
      return RailWayModel.Instance.GetNotReceiveRewardInfoList, RailWayModel.Instance
    end
  }
  self._rewardInfoList = {}
  self._seasonTaskRewardList = {}
  self._seasonTaskTid = nil
  self:_UpdateViewData()
end

function ActivityPermanantRewardComp:OnBind(binder)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.OnCareerLevelDataChanged, System.fn(self, self._OnCareerLevelDataChanged))
  binder:BindEvent(EventMgr.Instance.TaskInfoUpdated, System.fn(self, self._OnTaskInfoUpdated))
  self:_CreateTableView()
  self:_RefreshListView()
end

function ActivityPermanantRewardComp:_IsRailWaySeasonTaskAreaApplicable()
  local activityType = ActivityCfgUtils.GetCfgField("ActivityType", self._activityTid)
  return activityType == ActivityDefine.ActivityType.RailWayActivity
end

function ActivityPermanantRewardComp:_GetRailWaySeasonTaskTid()
  if not self:_IsRailWaySeasonTaskAreaApplicable() then
    return nil
  end
  local seasonId = SeasonRotationModel.Instance:GetSeasonId(SeasonGameplayType.ConsciousnessRailway)
  if not seasonId or 0 == seasonId then
    return nil
  end
  local taskTid = SeasonRotationCfgUtils.GetSeasonTaskId(seasonId, SeasonGameplayType.ConsciousnessRailway)
  if not taskTid or 0 == taskTid then
    return nil
  end
  return taskTid
end

function ActivityPermanantRewardComp:_ShouldShowPermanentActivityRoot()
  if table.next(self._rewardInfoList) then
    return true
  end
  return self:_GetRailWaySeasonTaskTid() ~= nil
end

function ActivityPermanantRewardComp:_RefreshSeasonTaskArea()
  if not self.binder then
    return
  end
  local taskTid = self:_GetRailWaySeasonTaskTid()
  self._seasonTaskTid = taskTid
  if not taskTid then
    self._seasonTaskRewardList = {}
    if self.ui.Text_WinCount then
      self.binder:SetText(self.ui.Text_WinCount, "")
    end
    if self.ui.WinRewardView then
      self.binder:SetActive(self.ui.WinRewardView, false)
    end
    if self._seasonTaskRewardTableView then
      self._seasonTaskRewardTableView:ReloadData()
    end
    return
  end
  TaskDataUtils.GetTaskData(taskTid)
  if self.ui.Text_WinCount then
    local descFmt = "%s<color=#6E6C6C>(%s/%s)</color>"
    self.binder:SetText(self.ui.Text_WinCount, TaskDataUtils.GetTaskProgressDesc(taskTid, descFmt))
  end
  self._seasonTaskRewardList = TaskDataUtils.GetTaskCompleteAward(taskTid) or {}
  if self.ui.WinRewardView then
    self.binder:SetActive(self.ui.WinRewardView, #self._seasonTaskRewardList > 0)
  end
  if not self._seasonTaskRewardTableView then
    self:_CreateSeasonTaskRewardTableView()
  end
  if self._seasonTaskRewardTableView then
    self._seasonTaskRewardTableView:ReloadData()
  end
  self:_UpdateWinRewardViewPosition(#self._seasonTaskRewardList)
end

function ActivityPermanantRewardComp:_UpdateWinRewardViewPosition(rewardsNum)
  if rewardsNum >= 3 then
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.WinRewardView.transform, 346, -32)
  elseif 2 == rewardsNum then
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.WinRewardView.transform, 400, -32)
  else
    CS.Framework.TransformUtil.SetAnchoredPos(self.ui.WinRewardView.transform, 454, -32)
  end
end

function ActivityPermanantRewardComp:_CreateSeasonTaskRewardTableView()
  if not self.ui.WinRewardView or not self.ui.UI_Common_Item_WuPin_Type2 then
    return
  end
  local baseGameObj = self.ui.UI_Common_Item_WuPin_Type2
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  self._seasonTaskRewardComps = {}
  self._seasonTaskRewardTableView = self:CreateTableview(self.ui.WinRewardView, function()
    return #self._seasonTaskRewardList
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if self._seasonTaskRewardComps[gameObj] then
      self._seasonTaskRewardComps[gameObj].binder:teardown()
    end
    local reward = self._seasonTaskRewardList[idx]
    local seasonTaskTid = self._seasonTaskTid
    local taskData = seasonTaskTid and TaskDataUtils.GetTaskData(seasonTaskTid) or nil
    local taskState = taskData and taskData.state or TaskState.UnDone
    if reward and seasonTaskTid then
      local itemData = {
        itemTid = reward.tid,
        itemCount = reward.num,
        isGotFunc = function()
          do return TaskDataUtils.TaskFinshAndGetedAward end
          return TaskDataUtils.TaskFinshAndGetedAward, seasonTaskTid
        end,
        isShowRing = function()
          do return TaskDataUtils.IsTaskCanReward end
          return TaskDataUtils.IsTaskCanReward, seasonTaskTid
        end
      }
      if taskState == TaskState.Receive then
        function itemData.clickFunc()
          TaskDataUtils.TaskComplete(seasonTaskTid, function()
            self:_RefreshSeasonTaskArea()
          end)
        end
      end
      self._seasonTaskRewardComps[gameObj] = self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
    end
    return cell
  end, function()
    return itemW, itemH
  end, function()
    self._seasonTaskRewardComps = nil
  end)
end

function ActivityPermanantRewardComp:OnUnbind()
  if self._seasonTaskRewardComps then
    for _, comp in pairs(self._seasonTaskRewardComps) do
      if comp and comp.binder then
        comp.binder:teardown()
      end
    end
  end
end

function ActivityPermanantRewardComp:_OnCareerLevelDataChanged()
  self:_UpdateViewData()
  self:_RefreshListView()
end

function ActivityPermanantRewardComp:_OnTaskInfoUpdated(taskData)
  local taskType = TaskCfgUtils.GetCfgField("TaskType", taskData.tid)
  if taskType ~= cd.TaskType.TaskType_RailWay then
    return
  end
  self:_UpdateViewData()
  self:_RefreshListView()
end

function ActivityPermanantRewardComp:_UpdateViewData()
  local activityType = ActivityCfgUtils.GetCfgField("ActivityType", self._activityTid)
  local rewardInfoListFunc = self._activityType2RewardInfoList[activityType]
  if rewardInfoListFunc then
    self._rewardInfoList = rewardInfoListFunc()
  end
end

function ActivityPermanantRewardComp:_RefreshListView()
  self._rewardListView:ReloadData()
  self.binder:SetActive(self.ui.uiNode, self:_ShouldShowPermanentActivityRoot())
  self:_RefreshSeasonTaskArea()
end

function ActivityPermanantRewardComp:_CreateTableView()
  local baseGameObj = self.ui.UI_Common_Item_WuPin_Type2
  local sizeDelta = baseGameObj.transform.sizeDelta
  local itemW, itemH = sizeDelta.x, sizeDelta.y
  local itemComps = {}
  self._rewardListView = self:CreateTableview(self.ui.RewardView, function()
    return #(self._rewardInfoList or {})
  end, function(view, idx)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(baseGameObj)
    local gameObj = cell.gameObject
    if itemComps[gameObj] then
      itemComps[gameObj].binder:teardown()
    end
    local rewardInfo = self._rewardInfoList[idx]
    local itemData = {
      itemTid = rewardInfo.tid,
      itemCount = rewardInfo.num
    }
    itemComps[gameObj] = self.binder:BindComponent(CommonIconItemType2(gameObj, itemData))
    return cell
  end, function()
    return itemW, itemH
  end, function()
    itemComps = nil
  end)
end

return ActivityPermanantRewardComp
