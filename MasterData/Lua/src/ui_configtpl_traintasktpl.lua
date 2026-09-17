local this = class("trainTaskTpl")

function this:init(config)
  self.data = config
  self._typeData = {}
  self._dungeon2TaskId = {}
  for i, v in pairs(config) do
    self._typeData[v.groupType] = self._typeData[v.groupType] or {}
    table.insert(self._typeData[v.groupType], v)
    self._dungeon2TaskId[v.dungeonId] = v.taskid
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getPassReward(tpl)
  return L_DataUtil.parseRewardConfig(tpl.passReward)
end

function this:getDungeonId(tpl)
  return tpl.dungeonId
end

function this:getTaskid(tpl)
  return tpl.taskid
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getTaskType(tpl)
  return tpl.taskType
end

function this:getGroupType(tpl)
  return tpl.groupType
end

function this:getTaskName(tpl)
  return L_Config:provider(tpl.taskName)
end

function this:getSortId(tpl)
  return tpl.sortId
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.dec)
end

function this:getTplListByTrainTaskType(type)
  return self._typeData[type] or {}
end

function this:getTaskIdByDungeonId(dungeonId)
  if not self._dungeon2TaskId[dungeonId] then
    print("找不到dungeonId：", dungeonId, "对应的taskId")
    return
  end
  return self._dungeon2TaskId[dungeonId]
end

return this
