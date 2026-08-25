local NewRedCom, Super = System.NewClass("NewRedCom", NewRedComBase)

function NewRedCom:ctor(redDotGo, newTagGo, updateRedFunc)
  Super.ctor(self, redDotGo, newTagGo, updateRedFunc)
end

function NewRedCom:OnBind(binder)
  Super.OnBind(self, binder)
  self.binder = binder
end

function NewRedCom:BindActivityTask(activityData, isNewTag)
  self:_InsertRedFunc(isNewTag, "ActivityTask", function()
    if not activityData then
      return false
    end
    local taskList = activityData.taskList
    if not taskList and activityData.data then
      taskList = activityData.data.taskList
    end
    for taskTid, taskData in pairs(taskList or {}) do
      if taskData.state == CommonDefine.CommonState.GainPrize then
        local cfg = DT.Task[taskData.tid] or {}
        if cfg.CompleteAward then
          return true
        end
      end
    end
  end)
  return self
end

function NewRedCom:BindFirstFeatureOpen(featureId, subKey, isNewTag)
  self.binder:BindEvent(EventMgr.Instance.OnClientDataChanged, System.fn(self, self.UpdateRed))
  self:_InsertRedFunc(isNewTag, "BindFirstFeatureOpen", function()
    return RedPointDataUtils.IsFeatureFirstOpen(featureId, subKey) == RedPointDataUtils.RedAttrType.IsNew
  end)
  return self
end

function NewRedCom:BindTaskList(taskList, isNewTag)
  self:_InsertRedFunc(isNewTag, "TaskList", function()
    for taskTid, taskData in pairs(taskList or {}) do
      if taskData.state == CommonDefine.CommonState.GainPrize then
        local cfg = DT.Task[taskData.tid] or {}
        if cfg.CompleteAward then
          return true
        end
      end
    end
  end)
  return self
end

function NewRedCom:BindResonanceGroupId(resonanceGroupId, isNewTag, activityId)
  if not resonanceGroupId then
    return self
  end
  ResonanceDataUtils.ReqResonanceData(resonanceGroupId, function()
    RedPointDataUtils.UpdateMainStageResonance(resonanceGroupId)
    self:_InsertRedFunc(isNewTag, "BindResonanceGroupId", function()
      do return RedPointDataUtils.IsMainStageResonanceShow, resonanceGroupId, nil end
      return RedPointDataUtils.IsMainStageResonanceShow, resonanceGroupId, nil, activityId
    end)
  end)
  return self
end

function NewRedCom:BindAvgCommunicate(isNewTag)
  self:_InsertRedFunc(isNewTag, "BindAvgCommmunicate", function()
    do return end
    return AwakerChatDataUtils.IsHaveUnreadDialog, nil
  end)
  return self
end

return NewRedCom
