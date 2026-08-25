local TaskParentChildModel = NewClass("TaskParentChildModel", BaseModel)
local TaskServerIndex = CommonDefine.TaskServerIndex
local TaskType = CommonDefine.TaskType
local fatherTaskTypeMap = {
  [TaskServerIndex.Career] = TaskType.TaskType_Career_Main,
  [TaskServerIndex.School] = TaskType.TaskType_School_Main
}
local childTaskTypeMap = {
  [TaskServerIndex.Career] = TaskType.TaskType_Career_Sub,
  [TaskServerIndex.School] = TaskType.TaskType_School_Sub
}

function TaskParentChildModel:OnInit()
  self:OnReset()
end

function TaskParentChildModel:OnReset()
  self.curTaskServerIndex = 0
  self.curTaskSelChapter = 1
  self.taskGroupData = {}
end

function TaskParentChildModel:IsParentChildTask(serverIdx)
  return nil ~= fatherTaskTypeMap[serverIdx]
end

function TaskParentChildModel:GetTaskGroupsData()
  return self.taskGroupData
end

function TaskParentChildModel:GetFirstUnCompleteFatherChapter()
  local rst = 1
  for _, value in pairs(self.taskGroupData) do
    if value.fatherTask.state ~= CommonDefine.TaskState.Done then
      break
    end
    rst = rst + 1
  end
  do return math.min, rst end
  return math.min, rst, #self.taskGroupData, pairs(self.taskGroupData)
end

function TaskParentChildModel:SetTaskServerIndex(serverIdx)
  self.curTaskServerIndex = serverIdx
  self.curTaskSelChapter = 1
  self.taskGroupData = {}
  if not fatherTaskTypeMap[serverIdx] then
    return
  end
  for _, cfg in pairs(DT.Task) do
    if cfg.BelongTaskGroup and (cfg.TaskType == fatherTaskTypeMap[serverIdx] or cfg.TaskType == childTaskTypeMap[serverIdx]) then
      self:_InitGroupDataByConfig(cfg)
    end
  end
  local taskList = TaskDataUtils.GetTaskDataListBySvrIdx(serverIdx)
  for _, taskData in pairs(taskList) do
    local belongGroup = DT.Task[taskData.tid].BelongTaskGroup
    if self.taskGroupData[belongGroup].fatherTask.tid == taskData.tid then
      self.taskGroupData[belongGroup].fatherTask = taskData
    else
      for index, childTask in pairs(self.taskGroupData[belongGroup].childsTasks) do
        if childTask.tid == taskData.tid then
          self.taskGroupData[belongGroup].childsTasks[index] = taskData
        end
      end
    end
  end
  local rst = 1
  for _, value in ipairs(self.taskGroupData) do
    if value.fatherTask.state ~= CommonDefine.TaskState.Done then
      break
    end
    rst = rst + 1
  end
  self.curTaskSelChapter = math.min(rst, #self.taskGroupData)
  self:LocalNotify(NotifyId.OnTaskParentChildServerIndexChanged, serverIdx)
end

function TaskParentChildModel:GetCurGroupData()
  return self.taskGroupData[self.curTaskSelChapter]
end

function TaskParentChildModel:GetCurTaskServerIndex()
  return self.curTaskServerIndex
end

function TaskParentChildModel:SetCurTaskSelectChapter(curTaskSelChapter)
  self.curTaskSelChapter = curTaskSelChapter
  self:LocalNotify(NotifyId.OnTaskParentChildChapterChanged, curTaskSelChapter)
end

function TaskParentChildModel:GetCurTaskSelectChapter()
  return self.curTaskSelChapter
end

function TaskParentChildModel:GetTaskChapterTitle()
end

function TaskParentChildModel:_InitGroupDataByConfig(taskConfig)
  local belongTaskGroup = taskConfig.BelongTaskGroup
  if self.taskGroupData[belongTaskGroup] == nil then
    self.taskGroupData[belongTaskGroup] = {
      groupId = belongTaskGroup,
      fatherTask = nil,
      childsTasks = {}
    }
  end
  if taskConfig.TaskType == fatherTaskTypeMap[self.curTaskServerIndex] then
    self.taskGroupData[belongTaskGroup].fatherTask = {
      tid = taskConfig.ID,
      state = CommonDefine.TaskState.Doing,
      uid = nil,
      count = 0
    }
  elseif taskConfig.TaskType == childTaskTypeMap[self.curTaskServerIndex] then
    table.insert(self.taskGroupData[belongTaskGroup].childsTasks, {
      tid = taskConfig.ID,
      state = CommonDefine.TaskState.Doing,
      uid = nil,
      count = 0
    })
  end
end

return TaskParentChildModel
