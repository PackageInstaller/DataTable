local this = class("noviceTaskTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTaskTplDataDic()
  local taskTplDataDic = {}
  for taskId, tpl in pairs(self.data) do
    local taskTplData = {}
    taskTplData.taskId = taskId
    taskTplData.reward = tpl.reward
    taskTplData.rewardShow = tpl.rewardShow
    taskTplData.systemJump = tpl.systemJump
    taskTplData.title = L_Config:provider(tpl.title)
    taskTplData.desc = string.format("" .. L_Config:provider(tpl.desc), tostring(tpl.param))
    taskTplData.maxProgress = tpl.param
    taskTplDataDic[taskId] = taskTplData
  end
  return taskTplDataDic
end

function this:getGroupId2TaskIdsDic()
  local groupId2TaskIdsDic = {}
  for taskId, tpl in pairs(self.data) do
    local groupId = tpl.groupId
    groupId2TaskIdsDic[groupId] = groupId2TaskIdsDic[groupId] or {}
    table.insert(groupId2TaskIdsDic[groupId], taskId)
  end
  for _, taskIds in pairs(groupId2TaskIdsDic) do
    table.sort(taskIds, function(a, b)
      return a < b
    end)
  end
  return groupId2TaskIdsDic
end

function this:getMaxTaskGroupId()
  local maxGroupId = 1
  for _, tpl in pairs(self.data) do
    local groupId = tpl.groupId
    if maxGroupId < groupId then
      maxGroupId = groupId
    end
  end
  return maxGroupId
end

return this
