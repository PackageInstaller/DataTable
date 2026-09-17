local this = class("pageTimeLoop", G_UIPageBase)
local MIN_ONEDAY = 1440
local MAX_HEIGHT = 30
local SPEED_MOVE = 18

function this.bind()
  return {
    txtTimeCur = "",
    goPanel = true,
    txtTimeLoop = "",
    goTimeLoop = false,
    begin_time = "",
    time_1 = "",
    time_2 = "",
    time_3 = "",
    time_4 = "",
    time_5 = "",
    time_6 = "",
    activeBtnSure = true,
    activeBtnClose = true,
    scrollTime = {
      moduleName = "pages/time/cellTime"
    },
    snapToItemIndex_achievementGroup = 6,
    moveToItemIndex_achievementGroup = 0,
    show_curTimeBtn = false,
    show_nextDayBtn = false,
    txt_nextDay = "",
    txt_lastDay = ""
  }
end

function this.methods()
  return {
    onClick_exit = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_sure = function(self)
      self.bind.activeBtnSure = false
      self.bind.activeBtnClose = false
      self:doTimeLoop()
    end,
    onClick_moveToCurTimeIndex = function(self)
      self:moveToIndex()
    end,
    onClick_moveToNextTimeIndex = function(self)
      self:moveToIndex(true)
    end,
    onValueChange = function(self, pos)
    end
  }
end

function this:created(...)
  this.super.created(self, ...)
  self.data = {index = nil}
end

function this:preOpen()
  self.offsetMin = 0
  C_LBlurStack.SetBlurRadius(1)
  local startTouch = self.bindComponents.transHandleStart
  local overTouch = self.bindComponents.transHandleOver
  local maxVal = startTouch.parent.sizeDelta.x
  self.firstPlayLoop = false
  self.firstPlayStart = false
  self.firstPlayFinish = false
  self.slider = {
    maxVal = maxVal,
    start = startTouch,
    over = overTouch,
    startPos = startTouch.anchoredPosition,
    overPos = overTouch.anchoredPosition,
    fill1 = self.bindComponents.fill1,
    fill2 = self.bindComponents.fill2,
    goTouch = self.bindComponents.touchArea.gameObject,
    goTouchBg = self.bindComponents.touchAreaBg.gameObject,
    goImgBg = self.bindComponents.imgBg.gameObject
  }
  self.timeList = {
    [1] = self.bind.time_1,
    [2] = self.bind.time_2,
    [3] = self.bind.time_3,
    [4] = self.bind.time_4,
    [5] = self.bind.time_5,
    [6] = self.bind.time_6
  }
  self.animState = {
    alignVertical = -1,
    upMove = -1,
    timeLoop = -1,
    downMove = -1
  }
  self.bind.activeBtnSure = true
  self.bind.activeBtnClose = true
  self:syncServerTime()
  self:screenTouchHandle("+")
  self.bindComponents.dayIconAnimation:Play("anim_timeloop_dayicon_move")
end

function this:open(options)
  if options and options.toTime then
    self.offsetMin = options.toTime * 60
    self.methods.onClick_sure(self)
  end
  C_RealWeather.UISetUpdateBatchDisable()
end

function this:updateHander()
  if self.bindComponents == nil then
    return
  end
  local loopListViewRoot = self.bindComponents.LoopListViewRoot
  if loopListViewRoot == nil then
    return
  end
  local index = loopListViewRoot.CurSnapNearestItemIndex
  if index == nil then
    return
  end
  if self.indexToIdMap[index] == nil then
    return
  end
  if self.indexToIdMap[index] < 0 then
    return
  end
  self.data.index = self.indexToIdMap[index]
  self:refreshCurSelectTime()
end

function this:refreshCurSelectTime()
  local index = self.data.index
  if math.isEmpty(index) then
    return
  end
  local time = self.bind.scrollTime:getValue(index, "time")
  self.bind.begin_time = self:nextHourTime(time)
  local item = self.bindComponents.LoopListViewRoot:GetShownItemNearestItemIndex(index - 1)
  local itemRectTrans = item:GetComponent(typeof(C_RectTransform))
  local listTrans = self.bindComponents.LoopListScrollRect:GetComponent(typeof(C_RectTransform))
  self.initMin = time * 60 - listTrans:InverseTransformPoint(itemRectTrans.position).x / itemRectTrans.rect.width * 60 - 30
  local percent = (self.initMin - self.initHour * 60) / ((self.endHour - self.initHour) * 60)
  self:refreshTime()
  self:refreshJumpTimeBtn(self.curMin, self.initMin)
end

function this:refreshJumpTimeBtn(curMin, initMin)
  self.bind.show_nextDayBtn = true
  self.nextDayType = 2
  self.lastDayType = 2
  if 1440 <= initMin then
    self.bind.show_curTimeBtn = true
    self.nextDayType = 1
    self.lastDayType = 1
  else
    self.bind.show_curTimeBtn = false
  end
  if 2880 <= initMin then
    self.bind.show_nextDayBtn = false
    self.lastDayType = 2
  end
  if curMin <= 1440 and 1380 <= curMin and self.lastDayType == 1 then
    self.bind.show_curTimeBtn = false
  end
  if 0 <= curMin and curMin <= 60 then
    self.nextDayType = 2
    if 1440 <= initMin then
      self.bind.show_nextDayBtn = false
    end
  end
  self.bind.txt_nextDay = self.nextDayType == 1 and L_WordsTpl:getValue("ui_changetime_thedayaftertomorrow") or L_WordsTpl:getValue("ui_changetime_tomorrow")
  self.bind.txt_lastDay = self.lastDayType == 1 and L_WordsTpl:getValue("ui_changetime_today") or L_WordsTpl:getValue("ui_changetime_tomorrow")
end

function this:moveToIndex(isNextDay)
  local firstHour = 0
  if not isNextDay then
    if self.lastDayType == 1 then
      firstHour = self.initHour
    elseif self.lastDayType == 2 then
      firstHour = 25
    end
  elseif self.nextDayType == 1 then
    firstHour = 49
  elseif self.nextDayType == 2 then
    firstHour = 25
  end
  for i = 1, #self.bind.scrollTime do
    local time = self.bind.scrollTime:getValue(i, "time")
    if not math.isEmpty(time) and time == firstHour then
      local index = self.bind.scrollTime:getValue(i, "index")
      self.bind.snapToItemIndex_achievementGroup = index
      break
    end
  end
end

function this:escHandle()
  if self.bind.goTimeLoop == true then
    return
  end
  L_UI:close(self.pageName)
end

function this:close()
  this.super.close(self)
  C_RealWeather.UISetUpdateBatchEnable()
  C_LBlurStack.SetBlurRadius(0)
  if self.timer ~= nil then
    Timer.remove(self.timer)
    self.timer = nil
  end
  if self.virCamData and self.virCamData.souOffset then
    local body = self.virCamData.body
    body.m_TrackedObjectOffset = self.virCamData.souOffset
  end
  if self.loopAudioWrap then
    L_AudioUtil.stopSound(self.loopAudioWrap)
  end
  self:screenTouchHandle("-")
  C_GameTime.DoWorldTimeSync()
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
  self:enableTimer(false)
  if pickGo == self.slider.goTouch or pickGo == self.slider.goTouchBg or pickGo == self.slider.goImgBg then
    if not self.isDraging then
      L_AudioUtil.playSound("Play_SFX_System_UI_Time_Slide_On")
      self.isDraging = true
    end
    self.pickTrans = self.slider.over
  end
end

function this:on_touchDownHandle(gesture)
  if self.pickTrans == nil then
    return
  end
end

function this:on_touchUpHandle(gesture)
  if self.isDraging then
    self.isDraging = false
    L_AudioUtil.playSound("Play_SFX_System_UI_Time_Slide_Off")
  end
  self:enableTimer(true)
  self.pickTrans = nil
end

function this:refreshOffsetTime(offset)
  local offsetMin = self:lengthToMin(offset)
  offsetMin = offsetMin + self.offsetMin
  if offsetMin < 0 then
    offsetMin = 0
  elseif offsetMin > MIN_ONEDAY then
    offsetMin = 1440
  end
  self.offsetMin = offsetMin
  self:refreshTime()
end

function this:syncServerTime()
  self.curMin = C_GameTime.GetVirMinute()
  local hour = math.floor(self.curMin / 60)
  local min = math.floor(self.curMin % 60)
  self.initHour = hour + 1
  self.endHour = hour + L_GameConstTpl:getData("CHANGETIME_NUM", L_Const.GameTplType.int)
  self.bonusMin = 60 - min
  local timeIndex = {}
  for i = 1, 6 do
    table.insert(timeIndex, {id = -1, showBg = false})
  end
  local index = 1
  for i = self.initHour, self.endHour do
    table.insert(timeIndex, {
      time = i,
      id = index,
      isEnd = i + 1 == self.endHour
    })
    index = index + 1
  end
  for i = 1, 6 do
    table.insert(timeIndex, {id = -1, showBg = false})
  end
  self.indexToIdMap = {}
  for i, v in ipairs(timeIndex) do
    if v.id >= 0 then
      v.index = i - 1
      self.indexToIdMap[v.index] = i
    end
  end
  self.bind.scrollTime:clear()
  self.bind.scrollTime:insert_array(timeIndex)
  self.slider.startPos.x = 0
  local format = 10 <= min and "notice_modulePhotoGrouptime_01" or "notice_modulePhotoGrouptime_02"
  self.bind.txtTimeCur = L_WordsTpl:getValue(format, {
    [0] = hour,
    [1] = min
  })
  self.bind.begin_time = self:nextHourTime(self.initHour)
  self.initMin = self.initHour * 60
  self:refreshTime()
  self:refreshJumpTimeBtn(self.curMin, self.initMin)
end

function this:nextHourTime(hour)
  local nextHour = 0
  if 24 <= hour then
    nextHour = L_WordsTpl:getValue("ui_timeMessage_11") .. hour - 24
    if 48 <= hour then
      nextHour = L_WordsTpl:getValue("ui_timeMessage_12") .. hour - 48
    end
  else
    nextHour = hour
  end
  local format = "%s:00"
  return string.format(format, nextHour)
end

function this:refreshTime()
  local offsetMin = self.initMin - self.curMin
  self.offsetMin = offsetMin
  local hour = math.floor(offsetMin / 60)
  local min = math.floor(offsetMin % 60)
  local min = 0
  local curMin = 0
  if self.initMin < 1440 then
    curMin = self.initMin
  else
    curMin = self.initMin % 1440
  end
  if 24 <= hour and 24 < hour + min then
    hour = hour - 24
  else
  end
  local format = 10 <= min and "%s:%s" or "%s:0%s"
  local rotation = curMin / 1440 * 360
  self.bindComponents.dayIconRect.sizeDelta = C_Vector2(rotation, 100)
  self.bindComponents.dayBgRotate.localEulerAngles = C_Vector3(0, 0, -rotation)
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

function this:doTimeLoop()
  self.bind.goPanel = false
  self.bind.goTimeLoop = true
  C_LBlurStack.SetBlurRadius(0)
  if self.offsetMin == 0 then
    L_UI:close(self.pageName)
  else
    local eventData = {
      time_before = tostring(math.floor(self.curMin + 0.5) / 60),
      time_after = tostring(math.floor(self.initMin + 0.5) / 60 % 24),
      duration = math.floor(self.offsetMin * 60),
      custom_data = nil
    }
    L_GameUtil.logEvent("time_change", eventData)
    local camTactics = C_CameraManager.GetTactics(C_ECameraType.NewWorld)
    local virCam = camTactics:GetVirtualCamera()
    local body = virCam:GetCinemachineComponent(0)
    self.virCamData = {
      camera = virCam,
      body = body,
      anim = virCam:GetCinemachineComponent(1),
      souOffset = body and body.m_TrackedObjectOffset or nil
    }
    self.animState.alignVertical = 0
    self.loopAudioStartWrap = L_AudioUtil.playSound("Play_SFX_System_UI_Time_TimeStart")
  end
end

function this:update()
  if self.animState.alignVertical > -1 and self.animState.alignVertical < 1 then
    self.bindComponents.mainRootAnimation:Play("anim_timeloop_down")
    self:doAnim_alignVertical()
    self:updateTimeLoop()
  end
  if self.animState.alignVertical >= 0.8 then
    self.animState.upMove = 0.8
    if not self.firstPlayLoop then
      self.loopAudioWrap = L_AudioUtil.playSound("Play_SFX_System_UI_Time_Passing")
      self.firstPlayLoop = true
    end
  end
  if -1 < self.animState.timeLoop and 1 > self.animState.timeLoop then
    self:doAnim_timeLoop()
  elseif self.animState.timeLoop == -1 and 0.8 <= self.animState.upMove then
    self.animState.timeLoop = 0
  end
  if -1 < self.animState.downMove and 1 > self.animState.downMove then
    self.bindComponents.mainRootAnimation:Play("anim_timeloop_out")
    if not self.firstPlayFinish then
      L_AudioUtil.playSound("Play_SFX_System_UI_Time_TimeUp")
      self.firstPlayFinish = true
    end
    self:doAnim_downMove()
  elseif self.animState.downMove == -1 and 1 <= self.animState.timeLoop and 0.8 <= self.animState.upMove then
    self.animState.downMove = 0
  end
  self:updateHander()
end

function this:doAnim_alignVertical()
  self.animState.alignVertical = self.animState.alignVertical + Unity.Time.deltaTime
  if not self.virCamData.anim then
    return
  end
end

function this:doAnim_upMove()
  if not self.virCamData.body then
    return
  end
  local body = self.virCamData.body
  local offset = body.m_TrackedObjectOffset
  local val = Unity.Time.deltaTime * SPEED_MOVE
  offset.y = math.clamp(offset.y + val, nil, MAX_HEIGHT)
  body.m_TrackedObjectOffset = offset
  self.animState.upMove = offset.y / MAX_HEIGHT
end

function this:doAnim_timeLoop()
  local addRate = 240 * Unity.Time.deltaTime / self.offsetMin
  self.animState.timeLoop = math.clamp(self.animState.timeLoop + addRate, 0, 1)
  local val = self.animState.timeLoop * self.offsetMin + self.curMin
  C_GameTime.SetVirTimeWithMinute(val)
  if self.animState.timeLoop == 1 then
  end
  self:updateTimeLoop()
end

function this:doAnim_downMove()
  self.animState.downMove = self.animState.downMove + Unity.Time.deltaTime
  if self.animState.downMove >= 0.8 then
    L_UI:close(self.pageName)
  end
end

function this:updateTimeLoop()
  local curMin = C_GameTime.GetVirMinute()
  local hour = math.floor(curMin / 60)
  local min = math.floor(curMin % 60)
  local format = 10 <= min and "%s%s:%s" or "%s%s:0%s"
  local dayT = ""
  if 24 <= hour and hour < 48 then
    dayT = L_WordsTpl:getValue("ui_timeMessage_11")
    hour = hour - 24
  elseif 48 <= hour then
    dayT = L_WordsTpl:getValue("ui_timeMessage_12")
    hour = hour - 48
  end
  self.bind.txtTimeLoop = string.format(format, dayT, hour, min)
end

function this:enableTimer(bool)
  if self.timer ~= nil then
    if bool == true then
      self.timer:resume()
    else
      self.timer:pause()
    end
  end
end

function this:check(options, callback)
  if AzurWorld.WorldElapseMgr:CanChangeTimeOfDay() then
    return callback(true)
  else
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_time_adjustment_disabled"))
    return callback(false)
  end
end

return this
