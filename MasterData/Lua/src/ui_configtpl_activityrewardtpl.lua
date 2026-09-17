local this = class("activityRewardTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRequireActivity(tpl)
  return tpl.requireActivity
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getId(tpl)
  return tpl.id
end

function this:getTaskType(tpl)
  return tpl.taskType
end

function this:getAllData(index)
  if index == nil then
    return self.data
  else
    local data = {}
    if index == 1 then
      for i, v in pairs(self.data) do
        if v.taskType == 1 then
          table.insert(data, v)
        end
      end
    else
      for i, v in pairs(self.data) do
        if v.taskType == 2 then
          table.insert(data, v)
        end
      end
    end
    return data
  end
end

return this
