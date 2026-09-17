local this = class("priorityShowData")

function this:ctor(data)
  self._checkShowFunc = data.checkShowFunc
  self._priority = 0
  self._uuid = 0
  self._queue = L_ShowQueueConst.showQueueEnum.tip
  self._priorityDataType = L_ShowQueueConst.priorityDataType.none
  self._blockType = {}
end

function this:getShowQueue()
  return self._queue or L_ShowQueueConst.showQueueEnum.tip
end

function this:getPriorityDataType()
  return self._priorityDataType
end

function this:getDesc()
  local priority = self._priority or "nil"
  local uuid = self._uuid or "nil"
  local queue = self._queue or "nil"
  local priorityDataType = self._priorityDataType or "nil"
  local desc = "priority " .. priority .. " uuid " .. uuid .. " queue " .. queue .. " priorityDataType " .. priorityDataType
  return desc
end

function this:getQueue()
  return self._priority or 0
end

function this:checkIsCurData(priorityDataType, ...)
  if priorityDataType ~= self._priorityDataType then
    return false
  end
  return self:checkIsCurDataInter(...)
end

function this:checkIsCurDataInter(...)
  return false
end

function this:checkStopGuide()
  return false
end

function this:compareQueue(data)
  local selfPriority = self:getQueue()
  local otherPriority = data:getQueue()
  if selfPriority ~= otherPriority then
    if selfPriority < otherPriority then
      return 1
    end
    return -1
  end
  if self._uuid ~= data._uuid then
    return self._uuid < data._uuid and 1 or -1
  end
  return 0
end

function this:show()
  self:doShow()
end

function this:checkShowFunc()
  local blockValue = L_PriorityShowQueueManager.blockValue
  if 0 < blockValue then
    for _, v in ipairs(self._blockType) do
      blockValue = blockValue & ~math.pow(2, v)
    end
    if 0 < blockValue then
      return false
    end
  end
  if not self._checkShowFunc then
    local defaultCanShow = self:defaultCheckShowFunc()
    if not defaultCanShow then
      C_MJLog.LogInfo("priorityShowData defaultCheckShowFunc false " .. self:getDesc(), C_ELogModule.UIMgr)
    end
    return defaultCanShow
  end
  local canShow = self._checkShowFunc()
  if not canShow then
    C_MJLog.LogInfo("priorityShowData _checkShowFunc false " .. self:getDesc(), C_ELogModule.UIMgr)
  end
  return canShow
end

function this:defaultCheckShowFunc()
  return true
end

function this:hide()
  self:doHide()
end

function this:doShow()
  C_MJLog.LogInfo("priorityShowData doshow" .. self:getDesc(), C_ELogModule.UIMgr)
end

function this:doHide()
  C_MJLog.LogInfo("priorityShowData doHide" .. self:getDesc(), C_ELogModule.UIMgr)
end

return this
