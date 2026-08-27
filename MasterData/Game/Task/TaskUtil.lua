local TaskUtil = {}

function TaskUtil.SortTaskDataList(taskDataList)
  table.sort(taskDataList, function(a, b)
    if a.state ~= b.state then
      if a:IsPickedTaskReward() then
        return false
      elseif b:IsPickedTaskReward() then
        return true
      end
    end
    local aComplect = a:CheckComplete()
    local bComplect = b:CheckComplete()
    if aComplect ~= bComplect then
      return aComplect
    end
    if a.stcData.order ~= b.stcData.order then
      return a.stcData.order < b.stcData.order
    end
    return a.id < b.id
  end)
end

return TaskUtil
