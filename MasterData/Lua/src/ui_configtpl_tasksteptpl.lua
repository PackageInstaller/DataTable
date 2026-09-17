local this = class("taskStepTpl")

function this:init(config)
  self.data = config
  self._dataMap = {}
  for _, conf in pairs(config) do
    self._dataMap[conf.taskId] = self._dataMap[conf.taskId] or {}
    self._dataMap[conf.taskId][conf.nodeId] = conf
  end
end

function this:getTplByNode(tId, nId)
  return self._dataMap[tId] and self._dataMap[tId][nId]
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRewardShow(tpl)
  return tpl.rewardShow
end

function this:getId(tpl)
  return tpl.id
end

function this:getTaskId(tpl)
  return tpl.taskId
end

function this:getSign(tpl)
  return L_Config:provider(tpl.sign)
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getRewardMain(tpl)
  return tpl.rewardMain
end

function this:getNodeId(tpl)
  return tpl.nodeId
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getIsLimitStep(tpl)
  return tpl.isLimitStep == 1
end

function this:getMutexSpawnerIdList(tpl)
  return tpl.mutexSpawnerIdList
end

return this
