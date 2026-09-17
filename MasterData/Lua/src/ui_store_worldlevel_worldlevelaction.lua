local this = {}
local _worldDifficultyTpl = L_GameTpl:getWorldDifficultyTpl()

function this:req_worldLevel(level, callback)
  local data = {u32 = level}
  L_Net:sendMessage(MsgGenCode.CSProtoWorldMapSetLevel, data, callback)
end

function this:rsp_syncWorldLevel(info)
  self.data.serverLevelInfo = info
  self.data.freeTime = info.free_set
  self:call(self.event.syncWorldLevel)
  C_GlobalParamManager.SetWorldLevel(self:getNowLevel())
end

function this:getTaskMaxLevel()
  local tplList = _worldDifficultyTpl:getTplList()
  local nowLevel = 1
  for i, v in ipairs(tplList) do
    local taskId = _worldDifficultyTpl:getTaskId(v)
    local canChange = false
    if taskId == 0 or taskId == nil then
      canChange = true
    else
      canChange = AzurWorld.TaskMgr:IsFinishTask(taskId)
    end
    if canChange then
      nowLevel = _worldDifficultyTpl:getId(v)
    end
  end
  return nowLevel
end

function this:rsp_syncTaskMaxLevel(taskGroups)
  if self:getMaxLevel() == nil then
    self.data.maxLevel = self:getTaskMaxLevel()
  end
  if table.isEmpty(self.data.serverLevelInfo) then
    return
  end
  local oldMaxLevel = self:getMaxLevel()
  local nowLevel = self:getTaskMaxLevel()
  self.data.maxLevel = nowLevel
  if oldMaxLevel and oldMaxLevel < nowLevel then
    self.data.freeTime = self.data.freeTime + 1
    self.data.needShowLevel = true
    self:call(self.event.upWorldLevel)
  end
end

return this
