_class("AirAnimRoomOperate", Object)
AirAnimRoomOperate = AirAnimRoomOperate

function AirAnimRoomOperate:Constructor(main, operate, spaceID, onFinish)
  self._main = main
  self._operation = operate
  self._spaceID = spaceID
  self._onFinish = onFinish
  self._player = EZTL_Player:New()
end

function AirAnimRoomOperate:Play()
  AirLog("开始房间门动画，spaceID:", self._spaceID, "，操作类型:", self._operation)
  self._main:ClearCurrentRoom()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftShowRoomUI, nil)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, true, "AirAnimRoomOperate")
  local room = self._main:GetRoomBySpaceID(self._spaceID)
  local door = self._main:GetDoorBySpaceID(self._spaceID)
  if not room then
    Log.exception("找不到房间，无法做动画：", self._spaceID, "，操作类型：", self._operation)
  end
  if not door then
    Log.exception("找不到门，无法做动画：", self._spaceID, "，操作类型：", self._operation)
  end
  self._main:FocusRoomToAnimate(room, nil, 700)
  local tls = {}
  self._main:SetOneRoomUIActive(self._spaceID, false)
  tls[#tls + 1] = EZTL_Wait:New(700, "先等0.7s，相机聚焦到房间")
  if self._operation == AircraftDoorAnim.BuildRoom then
    tls[#tls + 1] = EZTL_Callback:New(function()
      door:Open()
    end, "建造，开门动画")
    tls[#tls + 1] = EZTL_Wait:New(1750, "开门动画等1.5s")
  elseif self._operation == AircraftDoorAnim.TearDown then
    tls[#tls + 1] = EZTL_Callback:New(function()
      door:Close()
    end, "拆除，关门动画")
    tls[#tls + 1] = EZTL_Wait:New(1750, "关门动画等1.5s")
  elseif self._operation == AircraftDoorAnim.LevelUp then
    tls[#tls + 1] = EZTL_Callback:New(function()
      door:Close()
    end, "升级，关门动画")
    tls[#tls + 1] = EZTL_Wait:New(2000, "关门动画之后等2s")
    tls[#tls + 1] = EZTL_Callback:New(function()
      door:Open()
    end, "开门动画")
    tls[#tls + 1] = EZTL_Wait:New(1750, "开门动画等1.5s")
  elseif self._operation == AircraftDoorAnim.LevelDown then
    tls[#tls + 1] = EZTL_Callback:New(function()
      door:Close()
    end, "降级，关门动画")
    tls[#tls + 1] = EZTL_Wait:New(2000, "关门动画之后等2s")
    tls[#tls + 1] = EZTL_Callback:New(function()
      door:Open()
    end, "开门动画")
    tls[#tls + 1] = EZTL_Wait:New(1750, "开门动画等1.5s")
  end
  tls[#tls + 1] = EZTL_Callback:New(function()
    if self._operation == AircraftDoorAnim.BuildRoom then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideBuildAirRoom, self._spaceID)
    end
    if self._operation ~= AircraftDoorAnim.TearDown then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftShowRoomUI, self._spaceID)
      self._main:SelectSpace(self._spaceID, false)
      door:AnimStop()
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftUILock, false, "AirAnimRoomOperate")
    self._main:SetOneRoomUIActive(self._spaceID, true)
    if self._onFinish then
      self._onFinish()
    end
    AirLog("房间门动画结束")
  end, "最后显示房间ui，解锁屏幕")
  local tl = EZTL_Sequence:New(tls, "房间操作动画，串行")
  self._player:Play(tl)
end
