local CheckerConditionRegister = class("CheckerConditionRegister")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function CheckerConditionRegister:AddCheckerNode(...)
  local paramNum = select("#", ...)
  if paramNum == 0 then
    print("[CheckCondition] not args")
    return false
  end
  local preConditions = select(1, ...)
  local length = #preConditions
  for i = 2, paramNum do
    local para = select(i, ...)
    local len = #para
    if 0 < len and len ~= length then
      print("[CheckCondition] args length is different")
      return false
    end
  end
  for i, preCondition in ipairs(preConditions) do
    if preCondition == CheckerTypeId.TimeRange and 3 <= paramNum then
      local paraStart = select(2, ...)
      local startTime = paraStart[i]
      local paraEnd = select(3, ...)
      local endTime = paraEnd[i] or 0
      self:_AddTimeCoditionNode(startTime, endTime)
    end
  end
end

function CheckerConditionRegister:_AddTimeCoditionNode(startTime, endTime)
  local function InsertToArray(arg, array)
    local left = 1
    
    local right = #array
    local mid
    while left <= right do
      mid = (left + right) // 2
      if arg <= array[mid] then
        left = mid + 1
      else
        right = mid - 1
      end
    end
    table.insert(array, left, arg)
  end
  
  if 0 < startTime and startTime > PlayerDataCenter.timestamp then
    if self.timeList == nil then
      self.timeList = {}
    end
    InsertToArray(startTime, self.timeList)
  end
  if 0 < endTime and endTime > PlayerDataCenter.timestamp then
    if self.timeList == nil then
      self.timeList = {}
    end
    InsertToArray(endTime, self.timeList)
  end
  if self.timeList ~= nil and 0 < #self.timeList and self.timerId == nil then
    self.timerId = TimerManager:StartTimer(1, function()
      self:_TimeLoop()
    end, self, false, false, false)
  end
end

function CheckerConditionRegister:_TimeLoop()
  local isThrounghNode = false
  local timestamp = PlayerDataCenter.timestamp
  for i = #self.timeList, 1, -1 do
    if timestamp < self.timeList[i] then
      break
    end
    isThrounghNode = true
    self.timeList[i] = nil
  end
  if #self.timeList == 0 then
    TimerManager:StopTimer(self.timerId)
    self.timerId = nil
  end
  if isThrounghNode then
    MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.TimeRange)
  end
end

return CheckerConditionRegister
