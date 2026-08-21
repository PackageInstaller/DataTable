_class("HomelandFindTreasureNPC", Object)
HomelandFindTreasureNPC = HomelandFindTreasureNPC

function HomelandFindTreasureNPC:Constructor(findTreasureManager)
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  self._homelandClient = homeLandModule:GetClient()
  self._interactPointManager = self._homelandClient:InteractPointManager()
  self._findTreasureManager = findTreasureManager
  local characterManager = self._homelandClient:CharacterManager()
  self._characterTran = characterManager:GetCharacterTransform()
  self._rotateSpeed = HomelandFindTreasureConst.GetNPCRotateTime()
  self._timer = 0
  self:CreateModel()
  self:RefreshInteractPoint()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapAddIcon, HomelandMapIconType.FindTreasureNPC, 0, self._transform, self)
end

function HomelandFindTreasureNPC:SetStatusStatus(status)
  if self._npcGo then
    self._npcGo:SetActive(status)
  end
end

function HomelandFindTreasureNPC:Update(deltaTime)
  if not self._targetDir or self._npcGo == nil then
    return
  end
  self._timer = self._timer + deltaTime
  local tran = self._npcGo.transform
  tran.rotation = Quaternion.Lerp(tran.rotation, self._targetDir, self._timer / self._rotateSpeed)
  if self._timer >= self._rotateSpeed and self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function HomelandFindTreasureNPC:Destroy()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapRemoveIcon, HomelandMapIconType.FindTreasureNPC, 0)
  self:ResetInteractPoint()
  if self._npcRreq then
    self._homelandClient:CharacterManager():UnRegisterNpc(self._npcGO)
    self._npcRreq:Dispose()
    self._npcRreq = nil
    self._npcGo = nil
  end
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function HomelandFindTreasureNPC:CreateModel()
  self._npcRreq = ResourceManager:GetInstance():SyncLoadAsset(HomelandFindTreasureConst.GetNPCAsset(), LoadType.GameObject)
  self._npcGo = self._npcRreq.Obj
  self._npcGo:SetActive(true)
  self._transform = self._npcGo.transform
  self._transform.position = HomelandFindTreasureConst.GetNPCPosition()
  self._homelandClient:CharacterManager():RegisterNpc(self._npcGo)
  self._homelandClient:Home3DUIManager():AddNameBoard(self._transform:Find("NameRoot"), "N17_base_npc_treasure", "str_homeland_npc_find_treasure")
end

function HomelandFindTreasureNPC:StartRotation()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  local playerPos = self._characterTran.position
  local npcPos = self._npcGo.transform.position
  local targetDir = playerPos - npcPos
  targetDir.y = 0
  self._targetDir = Quaternion.LookRotation(targetDir)
  self._timer = 0
  self._timerHandler = GameGlobal.Timer():AddEventTimes(1, TimerTriggerCount.Infinite, function()
    self:Update(UnityEngine.Time.deltaTime)
  end)
end

function HomelandFindTreasureNPC:RefreshInteractPoint()
  if not self._transform then
    return
  end
  self._interactParent = self._transform:Find("Interact")
  if not self._interactParent then
    return
  end
  self._interactPoints = {}
  for i = 0, self._interactParent.childCount - 1 do
    local interactPoint = self._interactParent:GetChild(i)
    local name = interactPoint.name
    local cfgs = Cfg.cfg_building_interact_point({PointName = name})
    if cfgs and 0 < table.count(cfgs) then
      local cfg = cfgs[1]
      self._interactPoints[#self._interactPoints + 1] = self._interactPointManager:AddBuildInteractPoint(self, i, cfg.ID)
    end
  end
end

function HomelandFindTreasureNPC:ResetInteractPoint()
  if not self._interactPoints then
    return
  end
  if self._interactPoints then
    for i = 1, #self._interactPoints do
      self._interactPointManager:RemoveBuildInteractPoint(self._interactPoints[i])
      self._interactpos = {}
    end
  end
end

function HomelandFindTreasureNPC:GetInteractPosition(index)
  if not self._interactParent then
    return
  end
  if self._interactpos == nil then
    self._interactpos = {}
  end
  if self._interactpos[index] == nil then
    local tran = self._interactParent:GetChild(index)
    self._interactpos[index] = tran.position
  end
  return self._interactpos[index]
end

function HomelandFindTreasureNPC:Interact(pointType, index)
  if pointType == InteractPointType.FindTreasure then
    self:StartRotation()
    self:ShowDialog("UIFindTreasureInteractMain")
  end
end

function HomelandFindTreasureNPC:ShowDialog(name, ...)
  GameGlobal.UIStateManager():ShowDialog(name, ...)
end

function HomelandFindTreasureNPC:GetInteractRedStatus(pointType, index)
  return false
end
