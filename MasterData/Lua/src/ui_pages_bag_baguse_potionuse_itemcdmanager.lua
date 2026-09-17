local ItemCooldownManager = class("ItemCooldownManager")
local tag = ItemCooldownManager:getName()

function ItemCooldownManager:ctor(timerManagerInstance)
  self.timerMgr = timerManagerInstance
  if not self.timerMgr then
    self.timerMgr = L_TimerManager
  end
end

function ItemCooldownManager:dispose()
  if self.timerMgr then
    self.timerMgr:clearTimer(self)
    print(tag .. " disposed and all associated timers cleared.")
  end
  self.timerMgr = nil
end

function ItemCooldownManager:startCooldown(itemOrId, duration)
  local itemId = self:_getItemId(itemOrId)
  if not itemId then
    print(tag .. " startCooldown failed: Invalid item or item ID provided.")
    return false
  end
  if not duration or duration <= 0 then
    print(tag .. " startCooldown failed: Duration must be greater than 0.")
    return false
  end
  self.timerMgr:newOrResetTimer(self, itemId, function()
  end, duration, 1)
  return true
end

function ItemCooldownManager:getRemainingTime(itemOrId)
  local itemId = self:_getItemId(itemOrId)
  if not itemId then
    return 0
  end
  local timerInstance = self.timerMgr._timerMap[self] and self.timerMgr._timerMap[self][itemId]
  if timerInstance and timerInstance.running then
    return math.max(0, timerInstance.consume)
  end
  return 0
end

function ItemCooldownManager:hasCooldown(itemOrId)
  return self:getRemainingTime(itemOrId) > 0
end

function ItemCooldownManager:stopCooldown(itemOrId)
  local itemId = self:_getItemId(itemOrId)
  if not itemId then
    return
  end
  self.timerMgr:stopTimer(self, itemId)
end

function ItemCooldownManager:_getItemId(itemOrId)
  local itemType = type(itemOrId)
  if itemType == "number" then
    return tostring(itemOrId)
  elseif itemType == "string" then
    return itemOrId
  elseif itemType == "table" then
  end
  return nil
end

return ItemCooldownManager
