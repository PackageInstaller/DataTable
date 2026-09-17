local this = class("modulePhotoGroup_time", require("ui.pages.photo.group.modulePhotoGroup_base"))
local MIN_ONEDAY = 1440

function this.bind()
  return {
    txtTimeCur = "",
    txtTimeUp = "",
    arrowRot = nil,
    fxRot = nil,
    gearRot = nil,
    gearSmall = nil,
    activeInfo = false
  }
end

function this.methods()
  return {
    onDragStart = function(self)
      self.isDrag = true
      L_AudioUtil.playSound("Play_SFX_System_UI_Time_Slide_On")
    end,
    onDrag = function(self, screenPos)
      self:onDrag(screenPos)
    end,
    onDragEnd = function(self)
      if self.isDrag then
        L_AudioUtil.playSound("Play_SFX_System_UI_Time_Slide_Off")
      end
      self.isDrag = false
      L_PhotoManager:sendEvent(L_PhotoManager.event.changeEndAlpha)
      self.bind.activeInfo = false
    end,
    onClickReset = function(self)
      self:reset()
    end,
    onClickHideGroup = function(self)
      L_PhotoManager:sendEvent(L_PhotoManager.event.isActiveBg)
      self:hideGroup()
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
end

function this:open()
  self.onDragEndHandle = self.onDragEndHandle or L_CommonUtil.handle(self.onTouch_dragEnd, self)
end

function this:show()
  self:syncServerTime()
  L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Choose_Time")
end

function this:close()
  this.super.close(self)
  if self.isDrag then
    L_AudioUtil.playSound("Play_SFX_System_UI_Time_Slide_Off")
    self.isDrag = false
  end
end

function this:onDrag(screenPos)
  local _, uiPos = C_RectTransformUtility.ScreenPointToLocalPointInRectangle(self.bindComponents.rootRect, screenPos, C_CameraManager.uiCamera)
  local angle = C_Vector2.SignedAngle(C_Vector2.up, uiPos.normalized)
  local time = self:angleToTime(-angle)
  self:setTime(time)
  self.bind.activeInfo = true
  self:refreshTime(time)
  L_PhotoManager:sendEvent(L_PhotoManager.event.changeStartAlpha)
end

function this:syncServerTime()
  local curMin = C_GameTime.GetVirMinute()
  self:refreshTime(curMin)
  self.initTime = curMin
end

function this:setTime(time)
  C_GameTime.SetTimeOfDayTickFactor(0)
  C_GameTime.SetVirTimeWithMinute(time)
end

function this:refreshTime(minutes)
  local hour = math.floor(minutes / 60)
  local min = math.floor(minutes % 60)
  local format = 10 <= min and "%d:%d" or "%d:0%d"
  self.bind.txtTimeCur = string.format(format, hour, min)
  self.bind.txtTimeUp = string.format(format, hour, min)
  local angle = minutes / MIN_ONEDAY * 360
  self.bind.arrowRot = C_Vector3(0, 0, -angle)
  self.bind.fxRot = C_Vector3(0, 0, -angle)
  self.bind.gearRot = C_Vector3(0, 0, -angle)
  local smallAngle = (angle * 2 % 360 + 360) % 360
  self.bind.gearSmall = C_Vector3(0, 0, smallAngle)
end

function this:angleToTime(angle)
  local adjustedAngle = angle % 360
  if adjustedAngle < 0 then
    adjustedAngle = adjustedAngle + 360
  end
  local minutes = adjustedAngle / 360 * MIN_ONEDAY
  return math.floor(minutes)
end

function this:reset()
  if self.initTime then
    self:setTime(self.initTime)
    self:refreshTime(self.initTime)
  end
end

return this
