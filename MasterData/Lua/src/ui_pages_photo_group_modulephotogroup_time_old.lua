local this = class("modulePhotoGroup_time_old", require("ui.pages.photo.group.modulePhotoGroup_base"))
local MIN_ONEDAY = 1440

function this.bind()
  return {txtTimeCur = ""}
end

function this.methods()
  return {}
end

function this:open()
  local startTouch = self.bindComponents.transHandleStart
  local overTouch = self.bindComponents.transHandleOver
  local maxVal = startTouch.parent.sizeDelta.x
  self.slider = {
    maxVal = maxVal,
    start = startTouch,
    over = overTouch,
    fill1 = self.bindComponents.fill1,
    goTouch = self.bindComponents.touchArea.gameObject
  }
  self:screenTouchHandle("+")
  self.bindComponents.dayIconAnimation:Play("anim_timeloop_dayicon_move")
end

function this:close()
  self:screenTouchHandle("-")
end

function this:show()
  this.super.show(self)
  self:refreshTime()
end

function this:screenTouchHandle(operator)
  self.onTouchStartHandle = self.onTouchStartHandle or L_CommonUtil.handle(self.on_touchStartHandle, self)
  self.onTouchDownHandle = self.onTouchDownHandle or L_CommonUtil.handle(self.on_touchDownHandle, self)
  self.onTouchUpHandle = self.onTouchUpHandle or L_CommonUtil.handle(self.on_touchUpHandle, self)
  C_ScreenTouch.OnUI_DragStart(operator, self.onTouchStartHandle)
  C_ScreenTouch.OnUI_Drag(operator, self.onTouchDownHandle)
  C_ScreenTouch.OnUI_DragEnd(operator, self.onTouchUpHandle)
end

function this:on_touchStartHandle(gesture)
  local pickGo = gesture:GetCurrentFirstPickedUIElement()
  if pickGo == self.slider.goTouch and not self.isDraging then
    L_AudioUtil.playSound("Play_SFX_System_UI_Time_Slide_On")
    self.isDraging = true
  end
end

function this:on_touchDownHandle(gesture)
  if not self.isDraging then
    return
  end
  local deltaPos = gesture.deltaPosition
  self:refreshOffsetTime(deltaPos.x)
end

function this:on_touchUpHandle(gesture)
  if self.isDraging then
    self.isDraging = false
    L_AudioUtil.playSound("Play_SFX_System_UI_Time_Slide_Off")
  end
end

function this:refreshOffsetTime(offset)
  local offsetMin = self:lengthToMin(offset)
  offsetMin = offsetMin + self.curMin
  offsetMin = math.clamp(offsetMin, 0, MIN_ONEDAY - 1)
  self:setTime(offsetMin)
  self:refreshTime()
end

function this:refreshTime()
  self.curMin = C_GameTime.GetVirMinute()
  local sliderPos_x = self:minToLength(self.curMin)
  local sliderPos = self.slider.start.anchoredPosition
  sliderPos.x = sliderPos_x
  self.slider.start.anchoredPosition = sliderPos
  self.slider.over.anchoredPosition = sliderPos
  local hour = math.floor(self.curMin / 60)
  local min = math.floor(self.curMin % 60)
  local format = 10 <= min and "%s:%s" or "%s:0%s"
  self.bind.txtTimeCur = string.format(format, hour, min)
  local fillSize = self.slider.fill1.sizeDelta
  fillSize.x = sliderPos_x
  self.slider.fill1.sizeDelta = fillSize
  local rotation = self.curMin / MIN_ONEDAY * 360
  self.bindComponents.dayIconRect.sizeDelta = C_Vector2(rotation, 100)
  self.bindComponents.dayBgRotate.localEulerAngles = C_Vector3(0, 0, -rotation)
end

function this:setTime(time)
  C_GameTime.SetTimeOfDayTickFactor(0)
  C_GameTime.SetVirTimeWithMinute(time)
end

function this:minToLength(min)
  while min > MIN_ONEDAY do
    min = min - MIN_ONEDAY
  end
  local length = min / MIN_ONEDAY * self.slider.maxVal
  return length
end

function this:lengthToMin(length)
  local min = length / self.slider.maxVal * MIN_ONEDAY
  return math.floor(min)
end

return this
