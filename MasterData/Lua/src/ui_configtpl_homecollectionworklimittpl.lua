local this = class("homeCollectionWorkLimitTpl")

function this:init(config)
  self.data = config
  self.allConditionGroup = {}
  for _, rowData in pairs(config) do
    local conditionGroup = rowData.condition
    table.insert(self.allConditionGroup, conditionGroup)
  end
end

function this:getRowDataById(id)
  return self.data[id]
end

function this:getConditionGroupById(id)
  local rowData = self:getRowDataById(id)
  if rowData then
    return rowData.condition
  end
end

function this:getAllConditionGroup()
  return self.allConditionGroup
end

function this:getMaxWorkingNumOfCollectionBuildingAtSameTimeById(id)
  local rowData = self:getRowDataById(id)
  if rowData then
    return rowData.workLimit
  end
end

function this:getCurMaxWorkingNum()
  local curMaxWorkingNum = 0
  for _, rowData in pairs(self.data) do
    local conditionGroup = rowData.condition
    if L_ConditionManager:isComplete(conditionGroup) == true then
      local maxWorkingNum = rowData.workLimit
      curMaxWorkingNum = curMaxWorkingNum > maxWorkingNum and curMaxWorkingNum or maxWorkingNum
    end
  end
  return curMaxWorkingNum
end

return this
