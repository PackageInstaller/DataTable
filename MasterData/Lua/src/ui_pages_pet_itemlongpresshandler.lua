local this = {}
local longPressTime = 0.4
local longPressTime2 = 2.4
local progressShowDelay = 0.1
local longPressInterval = L_GameConstTpl:getValue("ITEM_NUM_CHANGE_SPEED_01", true, 0.05)
local longPressInterval2 = L_GameConstTpl:getValue("ITEM_NUM_CHANGE_SPEED_02", true, 0.025)
local IsPc = L_DeviceTpl:getIsPc()

function this:setLongPressProgress(progress)
  self.bind.active_longPressProgressMobile = not IsPc
  self.bind.active_longPressProgressPc = IsPc
  if IsPc then
    self.bind.img_longPressProgressPc = progress
  else
    self.bind.img_longPressProgressMobile = progress
  end
end

function this:hideLongPressProgress()
  self.bind.active_longPressProgress = false
  self:setLongPressProgress(0)
end

function this:beginLongPress(isAdd, showProgress)
  self.showProgress = showProgress
  self.isAdd = isAdd
  if not self.timer then
    self.timer = Timer.repeated(0, self.update, self)
  end
  self.curPressTime = 0
  self.curPressCount = 0
  self:hideLongPressProgress()
end

function this:endLongPress()
  if self.timer then
    Timer.remove(self.timer)
  end
  self.timer = nil
  self:hideLongPressProgress()
end

function this:update()
  local deltaTime = C_Time.deltaTime
  self.curPressTime = self.curPressTime + deltaTime
  if self.showProgress and self.curPressTime >= progressShowDelay then
    local progress = (self.curPressTime - progressShowDelay) / (longPressTime - progressShowDelay)
    self:setLongPressProgress(math.clamp(progress, 0, 1))
    self.bind.active_longPressProgress = true
  else
    self:hideLongPressProgress()
  end
  local pressCount = self:getPressCount()
  for _ = 1, pressCount - self.curPressCount do
    self:onLongPress()
  end
  self.curPressCount = pressCount
end

function this:getPressCount()
  local pressCount = 0
  local x = self.curPressTime - longPressTime
  if self.curPressTime > longPressTime2 then
    local x1 = longPressTime2 - longPressTime
    local y1 = x1 / longPressInterval
    local y2 = (x - x1) / longPressInterval2 + y1
    pressCount = math.floor(y2)
  elseif self.curPressTime > longPressTime then
    local y1 = x / longPressInterval
    pressCount = math.floor(y1)
  end
  return pressCount
end

function this:onLongPress()
  local moduleSelectNum = self.modules.modulePetAttrFruitSelectNum
  if self.isAdd then
    moduleSelectNum:onBtnAdd()
  else
    moduleSelectNum:onBtnDecrease()
  end
end

return this
