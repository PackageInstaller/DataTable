_class("HomelandFindTreasure", Object)
HomelandFindTreasure = HomelandFindTreasure

function HomelandFindTreasure:Constructor(findTreasureManager, posId)
  self._posId = posId
  self._findTreasureManager = findTreasureManager
  self._gameData = HomelandFindTreasureConst.GetGameData()
  self._pause = true
  self._complete = true
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local characterManager = homelandClient:CharacterManager()
  self._playerTran = characterManager:GetCharacterTransform()
  self._characterController = characterManager:MainCharacterController()
  local cfg = Cfg.cfg_homeland_find_treasure_const[1]
  self._triggerDistance = cfg.FindTreasureMinDistance / 1000
  self._treasureShowDis = HomelandFindTreasureConst.GetTreasureShowDis()
  self:CreateTreasure()
end

function HomelandFindTreasure:AttachModel()
  local model = HomelandFindTreasureConst.GetNPCBackpackModel()
  local attachPath = HomelandFindTreasureConst.GetNPCBackpackModelAttachPath()
  self._backpack = self._characterController:AttachModel(model, attachPath)
end

function HomelandFindTreasure:Start()
  self._pause = false
  self._complete = false
  self._timer = 0
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1, TimerTriggerCount.Infinite, function()
    self:Update(UnityEngine.Time.deltaTime)
  end)
  return self._gameData
end

function HomelandFindTreasure:Update(deltaTime)
  if self._pause then
    return
  end
  if self._complete then
    return
  end
  self._timer = self._timer + deltaTime
  self._gameData:AddGameTime(deltaTime)
  if self._timer >= self._gameData:GetGameTotalTime() then
    self:Failure()
    return
  end
  if self._treasureTran and self._playerTran then
    local dis = Vector3.Distance(self._playerTran.position, self._treasureTran.position)
    if dis > self._treasureShowDis then
      if self._treasureGo then
        self._treasureGo:SetActive(false)
      end
    elseif self._treasureGo then
      self._treasureGo:SetActive(true)
    end
    if dis <= self._triggerDistance then
      self:Success()
    end
  end
end

function HomelandFindTreasure:Destroy()
  self._characterController:ReleaseAttachedModel()
  self._backpack = nil
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:ReleaseTreasureModel()
  self._characterController:SetLocation(HomelandFindTreasureConst.GetOriginalPosition(), HomelandFindTreasureConst.GetOriginalRotation())
end

function HomelandFindTreasure:ReleaseTreasureModel()
  if self._treasureReq then
    self._treasureReq:Dispose()
    self._treasureReq = nil
    self._treasureGo = nil
    self._treasureTran = nil
  end
end

function HomelandFindTreasure:Pause()
  self._pause = true
end

function HomelandFindTreasure:Resume()
  self._pause = false
end

function HomelandFindTreasure:Failure()
  self._complete = true
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FindTreasureFailure)
end

function HomelandFindTreasure:Success()
  self._complete = true
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FindTreasureSuccess)
end

function HomelandFindTreasure:CreateTreasure()
  local model = self._gameData:GetModel()
  self:ReleaseTreasureModel()
  self._treasureReq = ResourceManager:GetInstance():SyncLoadAsset(model, LoadType.GameObject)
  self._treasureGo = self._treasureReq.Obj
  self._treasureGo:SetActive(true)
  self._treasureTran = self._treasureGo.transform
  self._treasureTran.position = self:CreateTreasurePosition()
end

function HomelandFindTreasure:CreateTreasurePosition()
  local cfg = Cfg.cfg_homeland_location[self._posId]
  return Vector3(cfg.Position[1] / 1000, cfg.Position[2] / 1000, cfg.Position[3] / 1000)
end

function HomelandFindTreasure:GetTreasurePosition()
  return self._treasureTran.position
end
