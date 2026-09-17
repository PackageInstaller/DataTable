local this = class("showQueueBase")

function this:ctor(priorityShowQueueManager)
  self.priorityShowDatas = {}
  self.highestPriorityData = nil
  self.priorityShowQueueManager = priorityShowQueueManager
end

function this:initialize()
end

function this:show()
  if #self.priorityShowDatas <= 0 then
    return false
  end
  table.sort(self.priorityShowDatas, function(a, b)
    return a:compareQueue(b) < 0
  end)
  local index
  for i = #self.priorityShowDatas, 1, -1 do
    if self.priorityShowDatas[i]:checkShowFunc() then
      index = i
      break
    end
  end
  if index == nil then
    return false
  end
  self.highestPriorityData = self.priorityShowDatas[index]
  table.remove(self.priorityShowDatas, index)
  self.highestPriorityData:show()
  if self.highestPriorityData:checkStopGuide() then
    L_GuideManager:stopAllGuide()
  end
  return true
end

function this:isOnShow()
  local bShow = self.highestPriorityData ~= nil
  if bShow then
    C_MJLog.LogInfo("showQueueBase isOnShow = " .. self.highestPriorityData:getDesc(), C_ELogModule.UIMgr)
  end
  return bShow
end

function this:hide()
  if self.highestPriorityData ~= nil then
    self.highestPriorityData:hide()
    if self.highestPriorityData:checkStopGuide() then
      L_GuideManager:restartAllGuide()
    end
    self.highestPriorityData = nil
  end
end

function this:dispose(isFreeze)
  self.highestPriorityData = nil
  self.priorityShowDatas = {}
end

function this:addPriorityShowData(priorityShowData)
  table.insert(self.priorityShowDatas, priorityShowData)
end

function this:checkPriorityDataExist(dataType, ...)
  if #self.priorityShowDatas <= 0 then
    return false
  end
  for _, priorityData in ipairs(self.priorityShowDatas) do
    if priorityData:checkIsCurData(dataType, ...) then
      return true
    end
  end
  return false
end

return this
