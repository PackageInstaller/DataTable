local FishgingStatus = {
  None = 0,
  Throw = 1,
  Fishing = 2,
  Bite = 3,
  FishDecoupling = 4,
  FishSuccess = 5,
  Finish = 6
}
_enum("FishgingStatus", FishgingStatus)
local FishingPositionType = {
  None = 0,
  Normal = 1,
  WishingCoin = 2,
  RareFishing = 3,
  PetFishing = 4
}
_enum("FishingPositionType", FishingPositionType)
local FishgingAnimation = {
  FishThrowSuccess = 0,
  FishThrowFailure = 1,
  FishIdle = 2,
  FishPowerChange = 3,
  FishPowerGreate = 4,
  PersonPowerGreat = 5,
  DecouplingFishPowerGreat = 6,
  DecouplingPersonPowerGreat = 7,
  FishSuccess = 8,
  FishCancel = 9,
  FishFailure = 10,
  CancelFishing = 11
}
_enum("FishgingAnimation", FishgingAnimation)
local FishgingFailureReason = {
  TimeOut = 1,
  PersonPowerGreat = 2,
  FishPowerGreat = 3
}
_enum("FishgingFailureReason", FishgingFailureReason)
_class("HomelandFishing", Object)
HomelandFishing = HomelandFishing

function HomelandFishing:Constructor()
  self._guideModule = GameGlobal.GetModule(GuideModule)
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  self._homelandClient = homeLandModule:GetClient()
  self._dicRareFishing = {}
  self:RegisterStatus()
end

function HomelandFishing:HomelandClient()
  return self._homelandClient
end

function HomelandFishing:Init()
  local buildManager = self._homelandClient:BuildManager()
  local characterManager = self._homelandClient:CharacterManager()
  self._characterController = characterManager:MainCharacterController()
  local area = buildManager:GetHomeArea():GetArea()
  local points = {}
  for i = 1, area.RiverPoints.Count do
    local p = area.RiverPoints[i - 1]
    points[i] = Vector2(p.x, p.z)
  end
  points[#points + 1] = points[1]
  self._buildPoly = BuildPoly:New(points)
  local wishBuilding
  local buildings = buildManager:GetBuildings()
  for k, v in pairs(buildings) do
    if v:GetBuildType() == ArchitectureSubType.Wishing_Pool then
      wishBuilding = v
      break
    end
  end
  if wishBuilding then
    local triggerRoot = wishBuilding._transform:Find("FishingArea")
    if triggerRoot then
      local points = {}
      for i = 0, triggerRoot.childCount - 1 do
        local p = triggerRoot:GetChild(i).position
        points[i + 1] = Vector2(p.x, p.z)
      end
      points[#points + 1] = points[1]
      self._wishBuildingPoly = BuildPoly:New(points)
    end
  end
  self._characterManager = self._homelandClient:CharacterManager()
  if self._addFishingPositionCallback == nil then
    self._addFishingPositionCallback = GameHelper:GetInstance():CreateCallback(self.AddFishingPosition, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishingAddFishingPosition, self._addFishingPositionCallback)
  end
  if self._hideFishPositionCallback == nil then
    self._hideFishPositionCallback = GameHelper:GetInstance():CreateCallback(self.HideFishingPos, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishMatchReady, self._hideFishPositionCallback)
  end
  if self._showFishPositionCallback == nil then
    self._showFishPositionCallback = GameHelper:GetInstance():CreateCallback(self.ShowFishingPos, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishMatchEnd, self._showFishPositionCallback)
  end
  if self._removeFishingPositionCallback == nil then
    self._removeFishingPositionCallback = GameHelper:GetInstance():CreateCallback(self.RemoveFishingPosition, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishingRemoveFishingPosition, self._removeFishingPositionCallback)
  end
  if self._onHomelandFunctionUnlock == nil then
    self._onHomelandFunctionUnlock = GameHelper:GetInstance():CreateCallback(self.OnHomelandFunctionUnlock, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.HomeLandFunctionUnlock, self._onHomelandFunctionUnlock)
  end
  if self._refreshFishingPositionCallback == nil then
    self._refreshFishingPositionCallback = GameHelper:GetInstance():CreateCallback(self.RefreshFishingPosition, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishingRefreshFishingPosition, self._refreshFishingPositionCallback)
  end
  if self._fishMatchStartCallback == nil then
    self._fishMatchStartCallback = GameHelper:GetInstance():CreateCallback(self.FishMatchStart, self)
    GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.FishMatchStart, self._fishMatchStartCallback)
  end
  self._fishingPosition = {}
  self:RefreshFishingPosition()
end

function HomelandFishing:RegisterStatus()
  self._status = {}
  local throw = HomelandFishingStatusThrowThrow:New()
  throw:Init(self)
  self._status[FishgingStatus.Throw] = throw
  local fishing = HomelandFishingStatusFishing:New()
  fishing:Init(self)
  self._status[FishgingStatus.Fishing] = fishing
  local bite = HomelandFishingStatusBite:New()
  bite:Init(self)
  self._status[FishgingStatus.Bite] = bite
  local decoupling = HomelandFishingStatusDecoupling:New()
  decoupling:Init(self)
  self._status[FishgingStatus.FishDecoupling] = decoupling
  local success = HomelandFishingStatusSuccess:New()
  success:Init(self)
  self._status[FishgingStatus.FishSuccess] = success
  local finish = HomelandFishingStatusFinish:New()
  finish:Init(self)
  self._status[FishgingStatus.Finish] = finish
end

function HomelandFishing:Update()
  if not self._currentStatus then
    return
  end
  if self._currentStatus == FishgingStatus.Bite and self._guideModule:IsGuideProcessKey("guide_fishing") then
    self:RereshFishLinePos()
    return
  end
  local status = self._status[self._currentStatus]
  status:Update(UnityEngine.Time.deltaTime)
  self:RereshFishLinePos()
  self:_RereshFishLinePos_Pet()
end

function HomelandFishing:Destroy()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  if self._fishPositionTimerHandler then
    GameGlobal.Timer():CancelEvent(self._fishPositionTimerHandler)
    self._fishPositionTimerHandler = nil
  end
  if self._currentStatus then
    local status = self._status[self._currentStatus]
    if status then
      status:Exit()
    end
    self._currentStatus = nil
  end
  for k, v in pairs(self._status) do
    v:Destroy()
  end
  self._status = nil
  if self._addFishingPositionCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishingAddFishingPosition, self._addFishingPositionCallback)
    self._addFishingPositionCallback = nil
  end
  if self._removeFishingPositionCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishingRemoveFishingPosition, self._removeFishingPositionCallback)
    self._removeFishingPositionCallback = nil
  end
  if self._onHomelandFunctionUnlock then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HomeLandFunctionUnlock, self._onHomelandFunctionUnlock)
    self._onHomelandFunctionUnlock = nil
  end
  if self._refreshFishingPositionCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishingRefreshFishingPosition, self._refreshFishingPositionCallback)
    self._refreshFishingPositionCallback = nil
  end
  if self._fishMatchStartCallback then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.FishMatchStart, self._fishMatchStartCallback)
    self._fishMatchStartCallback = nil
  end
  if self._fishingPosition then
    for k, v in pairs(self._fishingPosition) do
      if v then
        if v.obj then
          v.obj:Dispose()
        end
        self:DestroyFishPositionTrace(k)
      end
    end
    self._fishingPosition = nil
  end
  self:DestroyFloat()
end

function HomelandFishing:FsmExit()
  if self._status then
    for k, v in pairs(self._status) do
      v:FsmExist()
    end
  end
end

function HomelandFishing:SwitchStatus(statuType, param)
  if statuType == nil then
    return
  end
  if self._currentStatus == statuType then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeFishingStatus, self._currentStatus)
    return
  end
  local status
  if self._currentStatus then
    status = self._status[self._currentStatus]
    if status then
      status:Exit()
    end
  end
  self._currentStatus = statuType
  status = self._status[self._currentStatus]
  if status then
    status:Enter(param)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeFishingStatus, self._currentStatus)
end

function HomelandFishing:FishMatchStart()
  self._isRiverFishing = true
end

function HomelandFishing:IsRiverFishing()
  return self._isRiverFishing
end

function HomelandFishing:ExitHomeland()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function HomelandFishing:EnterFishing(isRiverFishing)
  if self._currentStatus ~= nil and self._currentStatus ~= FishgingStatus.None then
    return
  end
  self._isRiverFishing = isRiverFishing
  self:SwitchStatus(FishgingStatus.Throw)
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1, TimerTriggerCount.Infinite, function()
    self:Update()
  end)
end

function HomelandFishing:ExistFishing()
  if self._currentStatus == FishgingStatus.None or self._currentStatus == nil then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetInteractPointUIStatus, true)
  self:FsmExit()
  self:SwitchStatus(FishgingStatus.None)
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function HomelandFishing:IsInRiver(pos)
  if self._buildPoly:Contains(pos) then
    return true
  end
  if self._wishBuildingPoly and self._wishBuildingPoly:Contains(pos) then
    return true
  end
  return false
end

function HomelandFishing:OnHomelandFunctionUnlock(functionType)
  if functionType == HomelandUnlockType.E_HOMELAND_UNLOCK_FISHING_UI then
    self:RefreshMapIcons()
  end
end

function HomelandFishing:RefreshFishingPosition()
  if self._fishPositionTimerHandler then
    GameGlobal.Timer():CancelEvent(self._fishPositionTimerHandler)
    self._fishPositionTimerHandler = nil
  end
  self._fishPositionRefreshTime = 0
  local dicLookup = {}
  local fishingPositioninfo = self._homelandModule:GetFishingPostionData()
  if fishingPositioninfo then
    for k, v in pairs(fishingPositioninfo) do
      dicLookup[v.fishing_position_id] = v.fishing_position_id
      self:AddFishingPosition(v.fishing_position_id, FishingPositionType.Normal)
      if v.next_refresh_time and 0 < v.next_refresh_time and v.next_refresh_time < self._fishPositionRefreshTime then
        self._fishPositionRefreshTime = v.next_refresh_time
      end
    end
  end
  local wishCoinPosition = self._homelandModule:GetWishingCoinPostionData()
  if wishCoinPosition then
    for k, v in pairs(wishCoinPosition) do
      dicLookup[v] = v
      self:AddFishingPosition(v, FishingPositionType.WishingCoin)
    end
  end
  for k, v in pairs(self._dicRareFishing) do
    v:RefreshCurrentState()
  end
  local rarePosition = self._homelandModule:GetAllRareFishingPosition()
  local rareClue = self._homelandModule:GetAllRareFishingClue()
  local rareCfgs = Cfg.cfg_homeland_rare_clue
  if rarePosition then
    for _, v in pairs(rarePosition) do
      dicLookup[v] = v
      for k, clue in pairs(rareClue) do
        if clue.rare_fishing_position ~= 0 then
          local fishClue = k
          local data = rareCfgs({ID = fishClue})
          for _, rareFishClue in pairs(data) do
            local posionType = rareFishClue.type
            if posionType == 1 then
              self:AddFishingPosition(v, FishingPositionType.RareFishing)
            else
              self:AddFishingPosition(v, FishingPositionType.PetFishing)
            end
          end
        end
      end
    end
  end
  local removeList = {}
  for k, v in pairs(self._fishingPosition) do
    local find = false
    if v then
      find = dicLookup[k] ~= nil
    end
    if not find then
      removeList[#removeList + 1] = k
    end
  end
  for i = 1, #removeList do
    self:RemoveFishingPosition(removeList[i])
  end
  if self._fishPositionRefreshTime > 0 then
    self._fishPositionTimerHandler = GameGlobal.Timer():AddEventTimes(1, TimerTriggerCount.Infinite, function()
      local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
      local nowTime = svrTimeModule:GetServerTime() / 1000
      if nowTime >= self._fishPositionRefreshTime then
        GameGlobal.TaskManager():StartTask(self.LoadFishingPositionData, self)
      end
    end)
  end
end

function HomelandFishing:DestroyFishPositionTrace(positionId)
  local cfg = HomelandFishingConst.GetFishingPositionCfg(positionId)
  if cfg == nil or cfg.TraceId == nil then
    return
  end
  local homelandTraceManager = self._homelandClient:GetHomelandTraceManager()
  homelandTraceManager:DisposeTrace(cfg.TraceId, nil)
end

function HomelandFishing:CreateFishPositionTrace(positionId, position)
  local cfg = HomelandFishingConst.GetFishingPositionCfg(positionId)
  if cfg == nil or cfg.TraceId == nil then
    return
  end
  local homelandTraceManager = self._homelandClient:GetHomelandTraceManager()
  homelandTraceManager:StartTrace(cfg.TraceId, nil, position)
end

function HomelandFishing:LoadFishingPositionData(TT)
  self._homelandModule:ApplyFishPostionData(TT)
  self:RefreshFishingPosition()
end

function HomelandFishing:PositionType2MapIconType(fishingPositionType)
  local homelandMapIconType = 0
  if fishingPositionType == FishingPositionType.Normal then
    homelandMapIconType = HomelandMapIconType.FishingPoint
  elseif fishingPositionType == FishingPositionType.WishingCoin then
    homelandMapIconType = HomelandMapIconType.WishCoinPoint
  elseif fishingPositionType == FishingPositionType.RareFishing then
    homelandMapIconType = HomelandMapIconType.RareFishingPoint
  elseif fishingPositionType == FishingPositionType.PetFishing then
    homelandMapIconType = HomelandMapIconType.PetFishingPoint
  else
    homelandMapIconType = 0
  end
  return homelandMapIconType
end

function HomelandFishing:AddFishingPosition(positionId, fishingPositionType)
  if not self._fishingPosition then
    self._fishingPosition = {}
  end
  if self._fishingPosition[positionId] then
    return
  end
  local fnGetFishingPositionCfg = HomelandFishingConst.GetFishingPositionCfg
  local homelandMapIconType = self:PositionType2MapIconType(fishingPositionType)
  if homelandMapIconType == FishingPositionType.None then
    return
  end
  local cfg = fnGetFishingPositionCfg(positionId)
  if not cfg then
    return
  end
  local t = {}
  t.obj = nil
  t.type = fishingPositionType
  if cfg.Model then
    local req = ResourceManager:GetInstance():SyncLoadAsset(cfg.Model .. ".prefab", LoadType.GameObject)
    local go = req.Obj
    go:SetActive(true)
    local transform = go.transform
    local position = self._homelandModule:GetFishingPositionRandomPosition(positionId)
    transform.position = position
    t.obj = req
    self._fishingPosition[positionId] = t
    self:CreateFishPositionTrace(positionId, position)
    if self._homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_FISHING_UI) then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapAddIcon, homelandMapIconType, positionId, transform, positionId)
    end
  else
    self._fishingPosition[positionId] = t
  end
end

function HomelandFishing:RemoveFishingPosition(positionId)
  if not self._fishingPosition then
    self._fishingPosition = {}
  end
  if not self._fishingPosition[positionId] then
    return
  end
  local t = self._fishingPosition[positionId]
  if t.obj then
    t.obj:Dispose()
  end
  if self._homelandModule:CheckFunctionUnlock(HomelandUnlockType.E_HOMELAND_UNLOCK_FISHING_UI) then
    local homelandMapIconType = self:PositionType2MapIconType(t.type)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapRemoveIcon, homelandMapIconType, positionId)
  end
  self:DestroyFishPositionTrace(positionId)
  self._fishingPosition[positionId] = nil
end

function HomelandFishing:GetFishingPosition(pos)
  if not self._fishingPosition then
    return self:GetDefaultFishingPosition(), FishingPositionType.Normal
  end
  for k, v in pairs(self._fishingPosition) do
    local cfg = HomelandFishingConst.GetFishingPositionCfg(k)
    if cfg == nil then
      Log.error("HomelandFishing:GetFishingPosition error ", k)
    end
    local position = self._homelandModule:GetFishingPositionRandomPosition(k)
    local distance = Vector3.Distance(pos, position)
    if distance <= cfg.Range / 1000 then
      return k, v.type
    end
  end
  return self:GetDefaultFishingPosition(), FishingPositionType.Normal
end

function HomelandFishing:GetDefaultFishingPosition()
  return HomelandFishingConst.GetDefaultFishingPosition()
end

function HomelandFishing:RefreshMapIcons()
  if self._fishingPosition then
    for k, v in pairs(self._fishingPosition) do
      if v and v.obj then
        local transform = v.obj.Obj.transform
        local homelandMapIconType = self:PositionType2MapIconType(v.type)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapAddIcon, homelandMapIconType, k, transform, k)
      end
    end
  end
end

function HomelandFishing:HideFishingPos(positionId)
  if not self._fishPosList then
    self._fishPosList = {}
  end
  if not self._fishingPosition then
    return
  end
  for i, v in pairs(self._fishingPosition) do
    local t = {}
    t.posID = i
    t.type = v.type
    self:RemoveFishingPosition(i)
    table.insert(self._fishPosList, t)
  end
end

function HomelandFishing:ShowFishingPos()
  if not self._fishPosList then
    return
  end
  for i, v in pairs(self._fishPosList) do
    self:AddFishingPosition(v.posID, v.type)
  end
  table.clear(self._fishPosList)
end

function HomelandFishing:SetFishRodStatus(status)
  self:InitFishRod(status)
  self:InitFishLine(status)
  if not status then
    self:DestroyFloat()
  end
end

function HomelandFishing:InitFishRod(status)
  local findTreasureManager = self._homelandClient:FindTreasureManager()
  if findTreasureManager and findTreasureManager:IsFindingTreasure() then
    return
  end
  if status then
    local fishrod = HomelandFishingConst.GetCurrentFishRod()
    local model = fishrod:GetModelName()
    self._fishRodgo = self._characterController:AttachModel(model, fishrod:GetAttachPath())
    if self._fishRodgo then
      self._fishRodAnim = self._fishRodgo:GetComponentInChildren(typeof(UnityEngine.Animator))
      self._fishRodgo:SetActive(false)
    end
  else
    self._characterController:ReleaseAttachedModel()
    self._fishRodgo = nil
    self._fishRodAnim = nil
  end
end

function HomelandFishing:PlayFishRodAnimation(name)
  if self._fishRodgo then
    self._fishRodgo:SetActive(true)
  end
  if self._fishRodAnim then
    self._fishRodAnim:SetTrigger(name)
  end
end

function HomelandFishing:PlayFishRodAnimationLoop(name)
  if self._fishRodgo then
    self._fishRodgo:SetActive(true)
  end
  if self._fishRodAnim then
    self._fishRodAnim:SetBool(name, true)
  end
end

function HomelandFishing:StopFishRodyAnimationLoop(name)
  if self._fishRodgo then
    self._fishRodgo:SetActive(true)
  end
  if self._fishRodAnim then
    self._fishRodAnim:SetBool(name, false)
  end
end

function HomelandFishing:InitFishLine(status)
  if status then
    if self._fishRodgo then
      self._fishLine = self._fishRodgo.transform:Find("Line"):GetComponent("LineRenderer")
      self._fishLineFirstPointTran = self._fishRodgo.transform:Find("hl_tool_5012001/Bone_all/Dummy_5012001/Dummy001/Bone0001/Bone002/Bone003/Bone004/Bone005/Bone006/Bone007")
    end
  else
    self._fishLine = nil
  end
end

function HomelandFishing:CreateFloat(pos)
  self:DestroyFloat()
  self._fishingFloat = HomelandFishingFloat:New(FishgingFloatType.Main, pos)
end

function HomelandFishing:DestroyFloat()
  if self._fishingFloat then
    self._fishingFloat:Release()
    self._fishingFloat = nil
  end
end

function HomelandFishing:FishBite()
  Log.error("鱼咬钩")
end

function HomelandFishing:RereshFishLinePos()
  if self._fishLine and self._fishingFloat and self._fishLineFirstPointTran then
    self._fishLine.positionCount = 2
    if self._fishLineFirstPointTran then
      self._fishLine:SetPosition(0, self._fishLineFirstPointTran.position)
      self._fishLine:SetPosition(1, self._fishingFloat:GetFloatPosition())
    end
  end
end

function HomelandFishing:GetRareFishing(rareId)
  local rareFishing = self._dicRareFishing[rareId]
  if rareFishing == nil then
    rareFishing = HomelandRareFishing:New(rareId, self)
    self._dicRareFishing[rareId] = rareFishing
  end
  return rareFishing
end

function HomelandFishing:StartFishTools(pet, fishLine, fishLineFirstPointTran)
  self:StopFishTools()
  local power = math.random(30, 70) / 100
  local result, floatPosition = self:_IsThrowSuccess(pet, power)
  self._fishTools.fishFloat = HomelandFishingFloat:New(FishgingFloatType.Pet, floatPosition)
  self._fishTools.fishLine = fishLine
  self._fishTools.fishLineFirstPointTran = fishLineFirstPointTran
end

function HomelandFishing:StopFishTools()
  self._fishTools = self._fishTools or {}
  if self._fishTools.fishFloat then
    self._fishTools.fishFloat:Release()
    self._fishTools.fishFloat = nil
  end
end

function HomelandFishing:DestroyFishTools()
  self:StopFishTools()
  self._fishTools = {}
end

function HomelandFishing:SetFishToolsShow(isShow)
  local fishFloat = self._fishTools.fishFloat
  if fishFloat then
  end
  local fishLine = self._fishTools.fishLine
  if fishLine then
    fishLine.gameObject:SetActive(isShow)
  end
end

function HomelandFishing:_RereshFishLinePos_Pet()
  if not self._fishTools then
    return
  end
  local fishLine = self._fishTools.fishLine
  local fishLineFirstPointTran = self._fishTools.fishLineFirstPointTran
  local fishFloat = self._fishTools.fishFloat
  if fishLine and fishFloat and fishLineFirstPointTran then
    fishLine.gameObject:SetActive(true)
    fishLine.positionCount = 2
    fishLine:SetPosition(0, fishLineFirstPointTran.position)
    fishLine:SetPosition(1, fishFloat:GetFloatPosition())
  elseif fishLine then
    fishLine.gameObject:SetActive(false)
  end
end

function HomelandFishing:_IsThrowSuccess(pet, power)
  local minDistance = HomelandFishingConst.GetThrowMinDistance()
  local maxDistance = HomelandFishingConst.GetThrowMaxDistance()
  local distance = minDistance + (maxDistance - minDistance) * power
  local transform = pet:AgentTransform()
  local pos = transform.position + transform:TransformDirection(Vector3(0, 0, distance))
  return self:IsInRiver(Vector2(pos.x, pos.z)), pos
end
