_class("HomelandEventManager", Object)
HomelandEventManager = HomelandEventManager

function HomelandEventManager:Constructor()
  self._saveStoryID = nil
  self._saveStoryFinishEvent = nil
end

function HomelandEventManager:Init(homelandClient)
  self._common_dis_r = Cfg.cfg_homeland_global.StoryPointAreaR.IntValue or 5
  self._common_dis_n = Cfg.cfg_homeland_global.StoryStandDistance.IntValue or 3
  self._homeModule = GameGlobal.GetModule(HomelandModule)
  self._uiHomeModule = GameGlobal.GetUIModule(HomelandModule)
  self._homelandClient = homelandClient
  self._storyRoot = nil
  self._storyRoot = UnityEngine.GameObject.Find("HomeStoryRoot")
  if not self._storyRoot then
    self._req = ResourceManager:GetInstance():SyncLoadAsset("HomeStoryRoot.prefab", LoadType.GameObject)
    self._storyRoot = self._req.Obj
  end
  self._storyRoot:SetActive(true)
  self:ReSetStoryRoot()
  self._mainCameraTr = self._storyRoot.transform:Find("StoryMainCamera")
  self._mainCamera = self._mainCameraTr.gameObject
  self:ShowStoryCamera(false)
  self:HideAllCamera()
  self:GetAllWaitStory()
  self:AddListener()
end

function HomelandEventManager:AddListener()
  self.StopStoryHandler = GameHelper:GetInstance():CreateCallback(self.RemoveStory, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.HomeLandEventChange, self.StopStoryHandler)
end

function HomelandEventManager:RemoveStory(idList)
  if idList and next(idList) then
    for _, id in pairs(idList) do
      self:StopStory(id)
    end
  end
end

function HomelandEventManager:RemoveListener()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HomeLandEventChange, self.StopStoryHandler)
end

function HomelandEventManager:ReplyPetBe(pstid, type)
  if not self._replyPets then
    self._replyPets = {}
  end
  self._replyPets[pstid] = type
end

function HomelandEventManager:GetReplyType(pstid)
  if self._replyPets and self._replyPets[pstid] then
    local _type = self._replyPets[pstid]
    self._replyPets[pstid] = nil
    return _type
  end
end

function HomelandEventManager:GetAllWaitStory()
  self._succStoryList = {}
  self._miniMapAll = {}
  self._miniMapAdd = {}
  local info = self._homeModule:GetHomeLandEventInfo()
  local events = info.trigger_event_list
  local e_count = 0
  if events then
    e_count = table.count(events)
  end
  Log.debug("###[HomelandEventManager] 服务器已经触发事件数量=", e_count)
  for waitStory, time in pairs(events) do
    local cfg = Cfg.cfg_homeland_event[waitStory]
    if not cfg then
      Log.error("###[HomelandEventManager] cfg is nil ! id --> ", waitStory)
    else
      local succ, pet = self:StartStory(waitStory, cfg)
      if succ then
        local data = {}
        data.pet = pet
        data.id = waitStory
        table.insert(self._succStoryList, data)
        table.insert(self._miniMapAll, waitStory)
      end
    end
  end
  local newEventTriggerList, newEventTriggerCount = self._uiHomeModule:GetEventInfo()
  local n_e_count = 0
  if newEventTriggerList then
    n_e_count = table.count(newEventTriggerList)
  end
  Log.debug("###[HomelandEventManager] 服务器本次触发事件数量=", n_e_count)
  local newTriggerCount = 0
  local triggerSuccList = {}
  self._eventTipsList = {}
  local startTriggerNewEvent = true
  local uiHomeModule = GameGlobal.GetUIModule(HomelandModule)
  local saveList = uiHomeModule:SaveStoryList()
  local s_count = 0
  if saveList and next(saveList) then
    s_count = table.count(saveList)
    for i = 1, #saveList do
      local id = saveList[i]
      if not table.icontains(newEventTriggerList, id) and not events[id] then
        table.insert(newEventTriggerList, id)
        newEventTriggerCount = newEventTriggerCount + 1
      end
    end
  end
  Log.debug("###[HomelandEventManager] 客户端强制触发事件数量=", s_count)
  for i = 1, #newEventTriggerList do
    if newTriggerCount >= newEventTriggerCount then
      break
    end
    local startSucc = false
    local pet
    local waitStory = newEventTriggerList[i]
    local cfg = Cfg.cfg_homeland_event[waitStory]
    if not cfg then
      Log.error("###[HomelandEventManager] cfg is nil ! id --> ", waitStory)
    else
      startSucc, pet = self:StartStory(waitStory, cfg)
    end
    if startSucc then
      if startTriggerNewEvent then
        table.insert(triggerSuccList, waitStory)
        newTriggerCount = newTriggerCount + 1
        local data = {}
        data.id = waitStory
        data.pet = pet
        table.insert(self._eventTipsList, data)
      end
      local data = {}
      data.pet = pet
      data.id = waitStory
      table.insert(self._succStoryList, data)
      table.insert(self._miniMapAdd, waitStory)
    else
      Log.debug("###[HomelandEventManager] [", waitStory, "] 剧情触发失败！")
    end
  end
  startTriggerNewEvent = false
  if triggerSuccList and 0 < #triggerSuccList then
    GameGlobal.TaskManager():StartTask(self._TriggerEventsReq, self, triggerSuccList)
  end
  Log.debug("###[HomelandEventManager] 一共触发了[", #self._succStoryList, "]个事件")
end

function HomelandEventManager:SendStoryEventTip()
  if self._eventTipsList and next(self._eventTipsList) then
    local cfgs = Cfg.cfg_homeland_event({})
    for i = 1, #self._eventTipsList do
      local id = self._eventTipsList[i].id
      local pet = self._eventTipsList[i].pet
      local cfg = cfgs[id]
      if cfg then
        local face = cfg.EventTipIcon or "Norm"
        local pstid = pet:PstID()
        local icon = HelperProxy:GetInstance():HomeGetBody(pstid, face)
        local tex
        if cfg.EventTipTex then
          tex = StringTable.Get(cfg.EventTipTex)
        else
          local petName = pet:PetName()
          tex = StringTable.Get("str_homeland_pet_story_event_tips", petName)
        end
        local param = {}
        param[1] = icon
        param[2] = tex
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUIHomeEventTips, UIHomeEventTipsType.PetBody, param)
      end
    end
    self._eventTipsList = {}
  end
  if next(self._miniMapAll) then
    for i = 1, #self._miniMapAll do
      local id = self._miniMapAll[i]
      local type = HomelandMimimapIconMarkType.Pet
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnInitMinimapIconMark, type, id)
    end
  end
  if next(self._miniMapAdd) then
    for i = 1, #self._miniMapAdd do
      local id = self._miniMapAdd[i]
      local type = HomelandMimimapIconMarkType.Pet
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnAddMinimapIconMark, type, id)
    end
  end
end

function HomelandEventManager:_TriggerEventsReq(TT, triggerSuccList)
  self._homeModule:HandleClientTriggerEventReq(TT, triggerSuccList)
end

function HomelandEventManager:GetStoryList()
  return self._succStoryList
end

function HomelandEventManager:StopStory(id)
  local removeIdx
  for i = 1, #self._succStoryList do
    local data = self._succStoryList[i]
    if data.id == id then
      removeIdx = i
      break
    end
  end
  if removeIdx then
    local data = self._succStoryList[removeIdx]
    local pet = data.pet
    local behavior = pet:GetPetBehavior()
    behavior:ChangeBehavior(HomelandPetBehaviorType.Free)
    pet:SetStoryID(nil)
    pet:SetOccupied(HomelandPetOccupiedType.None)
    table.remove(self._succStoryList, removeIdx)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnRemoveMinimapIconMark, HomelandMimimapIconMarkType.Pet, id)
  else
    Log.debug("###[HomelandEventManager] stop a nil story ! id --> ", id)
  end
end

function HomelandEventManager:StartStory(id, cfg)
  Log.debug("###[HomelandEventManager] 开启一个剧情[", id, "]")
  local waitTypes = cfg.WaitType
  local startSucc = false
  local homePet
  local petid = cfg.PetID
  if self._succStoryList and #self._succStoryList > 0 then
    for i = 1, #self._succStoryList do
      local data = self._succStoryList[i]
      local pet = data.pet
      local storyid = data.id
      local _petid = pet:TemplateID()
      if _petid == petid then
        Log.debug("###[HomelandEventManager] 剧情[", id, "]触发失败,该星灵[", _petid, "]已经在触发一个剧情[", storyid, "]了")
        return false
      end
    end
  end
  local typeIdx = 1
  for i = 1, #waitTypes do
    local waitType = waitTypes[i]
    if waitType == 1 then
      startSucc, homePet = self:Action_Point(cfg, id)
    elseif waitType == 2 then
      startSucc, homePet = self:Action_Walk(cfg, id)
    elseif waitType == 3 then
      startSucc, homePet = self:Action_Furniture(cfg, typeIdx, id)
      typeIdx = typeIdx + 1
    elseif waitType == 4 then
      startSucc, homePet = self:Action_FurniturePoint(cfg, typeIdx, id)
      typeIdx = typeIdx + 1
    end
    if startSucc then
      return startSucc, homePet
    end
  end
  return startSucc, homePet
end

function HomelandEventManager:Action_Point(cfg, id)
  local petid = cfg.PetID
  local waitPos = cfg.StandPos
  local waitRot = cfg.StandRot
  local posArr = {}
  for i = 1, #waitPos do
    local pos = Vector3(waitPos[i][1], waitPos[i][2], waitPos[i][3])
    posArr[i] = pos
  end
  local canStart = false
  local startIdx = 1
  for i = 1, #posArr do
    local pos = posArr[i]
    local _canStart = self:CheckPosCanStand(pos, nil, 0)
    if _canStart then
      startIdx = i
      canStart = true
      break
    end
  end
  local startPos
  local startRot = Vector3(0, 0, 0)
  if canStart then
    startPos = posArr[startIdx]
    if waitRot[startIdx] then
      startRot = Vector3(waitRot[startIdx][1], waitRot[startIdx][2], waitRot[startIdx][3])
    end
  else
    local checkPos = posArr[startIdx]
    local hit = UnityEngine.AI.NavMeshHit:New()
    local _canStart, hit = self:CheckPosCanStand(checkPos, hit, self._common_dis_r)
    if _canStart then
      startPos = hit.position
      canStart = true
      if waitRot[startIdx] then
        startRot = Vector3(waitRot[startIdx][1], waitRot[startIdx][2], waitRot[startIdx][3])
      end
    else
      Log.debug("###[HomelandEventManager] 剧情触发失败，因为没有点,id[", id, "]")
    end
  end
  local homePet
  if canStart then
    homePet = self._homelandClient:PetManager():GetPetSync(petid)
    if homePet then
      homePet:SetOccupied(HomelandPetOccupiedType.StoryWaiting)
      homePet:SetStoryID(id)
      local petBehavior = homePet:GetPetBehavior()
      petBehavior:ChangeBehavior(HomelandPetBehaviorType.StoryWaitingStand)
      local currentBe = petBehavior:GetCurBehavior()
      local succ = currentBe:TriggerSucc(startPos, startRot, id)
      if not succ then
        canStart = false
        Log.debug("###[HomelandEventManager] 定点剧情触发失败,id[", id, "]")
        homePet:SetOccupied(HomelandPetOccupiedType.None)
        petBehavior:RandomBehavior()
      end
    else
      canStart = false
      Log.debug("###[HomelandEventManager] 剧情触发失败，因为没有星灵,id[", id, "]")
    end
  end
  return canStart, homePet
end

function HomelandEventManager:Action_Walk(cfg, id)
  local petid = cfg.PetID
  local type = cfg.WalkType
  local canStart = false
  local homePet
  if type == 1 or type == 2 then
    homePet = self._homelandClient:PetManager():GetPetSync(petid)
    if homePet then
      canStart = true
      homePet:SetOccupied(HomelandPetOccupiedType.StoryWaiting)
      homePet:SetStoryID(id)
      local petBehavior = homePet:GetPetBehavior()
      petBehavior:ChangeBehavior(HomelandPetBehaviorType.StoryWaitingWalk)
      local currentBe = petBehavior:GetCurBehavior()
      local succ = currentBe:TriggerSucc(type, cfg)
      if not succ then
        canStart = false
        Log.debug("###[HomelandEventManager] 散步剧情触发失败,id[", id, "]")
        homePet:SetOccupied(HomelandPetOccupiedType.None)
        petBehavior:RandomBehavior()
      end
    else
      Log.debug("###[HomelandEventManager] 剧情触发失败，因为没有星灵,id[", id, "]")
    end
  else
  end
  return canStart, homePet
end

function HomelandEventManager:Action_Furniture(cfg, idx, id)
  local furnitureTypes = cfg.BuildType
  local furnitureType = furnitureTypes[idx]
  furnitureType = furnitureType or furnitureTypes[1]
  local interactIDs = cfg.InteractID
  local interactID = interactIDs[idx]
  interactID = interactID or interactIDs[1] or nil
  local petid = cfg.PetID
  local canStart = false
  local homePet
  local furniture = self:GetFurnitureWithType(furnitureType)
  if furniture then
    homePet = self._homelandClient:PetManager():GetPetSync(petid)
    if homePet then
      canStart = true
      homePet:SetOccupied(HomelandPetOccupiedType.StoryWaiting)
      homePet:SetStoryID(id)
      local petBehavior = homePet:GetPetBehavior()
      petBehavior:ChangeBehavior(HomelandPetBehaviorType.StoryWaitingBuild)
      local args = {
        furniture = furniture,
        interactID = interactID,
        id = id
      }
      local currentBe = petBehavior:GetCurBehavior()
      petBehavior:SetStoryBehaviorArgs(args, function(furniture, interactID, id)
        local succC = currentBe:TriggerSucc(furniture, interactID, id)
        if not succC then
          Log.debug("###[HomelandEventManager] 回调交互剧情触发失败,id[", id, "]")
          homePet:SetOccupied(HomelandPetOccupiedType.None)
          petBehavior:RandomBehavior()
        end
      end)
      local succ = currentBe:TriggerSucc(furniture, interactID, id)
      if not succ then
        canStart = false
        Log.debug("###[HomelandEventManager] 交互剧情触发失败,id[", id, "]")
        homePet:SetOccupied(HomelandPetOccupiedType.None)
        petBehavior:RandomBehavior()
      end
    else
      Log.debug("###[HomelandEventManager] 剧情触发失败，因为没有星灵,id[", id, "]")
    end
  else
    Log.debug("###[HomelandEventManager] 剧情触发失败，因为没有家具,id[", id, "]")
  end
  return canStart, homePet
end

function HomelandEventManager:Action_FurniturePoint(cfg, idx, id)
  local petid = cfg.PetID
  local waitPoss = cfg.BuildDis
  local waitPos = waitPoss[idx]
  waitPos = waitPos or waitPoss[1]
  local waitRots = cfg.BuildRot
  local waitRot = waitRots[idx]
  waitRot = waitRot or waitRots[1]
  local furnitureTypes = cfg.BuildType
  local furnitureType = furnitureTypes[idx]
  furnitureType = furnitureType or furnitureTypes[1]
  local furniture = self:GetFurnitureWithType(furnitureType)
  if not furniture then
    Log.debug("###[HomelandEventManager] 触发失败，没有家具,type-->", furnitureType)
    return
  end
  local pos = furniture:Pos()
  local rotY = furniture:RotY()
  local rot = Quaternion.Euler(0, rotY, 0)
  local dir = rot * Vector3(0, 0, 1)
  local tmp_n
  if waitPos then
    tmp_n = waitPos
  else
    tmp_n = self._common_dis_n
  end
  local tmpPos = pos + dir * tmp_n
  local tmpCanStart = self:CheckPosCanStand(tmpPos, nil, 0)
  local homePet
  local canStart = false
  local startRot, startPos
  if tmpCanStart then
    startPos = tmpPos
  else
    local hit = UnityEngine.AI.NavMeshHit:New()
    tmpCanStart, hit = self:CheckPosCanStand(tmpPos, hit, self._common_dis_r)
    if tmpCanStart then
      startPos = hit.position
    end
  end
  if startPos then
    homePet = self._homelandClient:PetManager():GetPetSync(petid)
    if homePet then
      canStart = true
      startRot = Quaternion.LookRotation(pos)
      if waitRot then
        local _rotOffset = Vector3(waitRot[1], waitRot[2], waitRot[3])
        local _eular = startRot:ToEulerAngles()
        startRot = _eular + _rotOffset
      end
      homePet:SetOccupied(HomelandPetOccupiedType.StoryWaiting)
      homePet:SetStoryID(id)
      local petBehavior = homePet:GetPetBehavior()
      petBehavior:ChangeBehavior(HomelandPetBehaviorType.StoryWaitingBuildStand)
      local currentBe = petBehavior:GetCurBehavior()
      local succ = currentBe:TriggerSucc(startPos, startRot, id)
      if not succ then
        canStart = false
        Log.debug("###[HomelandEventManager] 家具旁站立剧情触发失败,id[", id, "]")
        homePet:SetOccupied(HomelandPetOccupiedType.None)
        petBehavior:RandomBehavior()
      end
    else
      Log.debug("###[HomelandEventManager] 剧情触发失败，因为没有星灵,id[", id, "]")
    end
  end
  return canStart, homePet
end

function HomelandEventManager:GetFurnitureWithType(type)
  local buildMgr = self._homelandClient:BuildManager()
  local buildings = buildMgr:GetBuildingsFilter(function(building)
    if building._cfgID == type then
      return true
    end
    return false
  end)
  local buildingCount = table.count(buildings)
  if buildingCount <= 0 then
    Log.debug("###[HomelandEventManager] buildingCount <= 0 ! id -- ", type)
    return
  end
  return buildings[1]
end

function HomelandEventManager:CheckPosCanStand(pos, hit, dis)
  local _canStart, _hit = UnityEngine.AI.NavMesh.SamplePosition(pos, hit, dis, UnityEngine.AI.NavMesh.AllAreas)
  return _canStart, _hit
end

function HomelandEventManager:HideAllCamera()
end

function HomelandEventManager:ShowStoryCamera(show)
  self._mainCamera:SetActive(show)
end

function HomelandEventManager:GetStoryRoot()
  return self._storyRoot
end

function HomelandEventManager:SetStoryRoot(pos, rot, scale)
  self._storyRoot.transform.localPosition = pos
  self._storyRoot.transform.localScale = scale
  self._storyRoot.transform.rotation = rot
end

function HomelandEventManager:ReSetStoryRoot()
  self._storyRoot.transform.localPosition = Vector3(1, 1, 1)
  self._storyRoot.transform.localScale = Vector3(1, 1, 1)
  self._storyRoot.transform.rotation = Quaternion.identity
end

function HomelandEventManager:GetStoryCamera()
  return self._mainCameraTr
end

function HomelandEventManager:Update(deltaTimeMS)
end

function HomelandEventManager:Dispose()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.CloseHomeStory)
  if self._req then
    self._req:Dispose()
    self._req = nil
  end
  self:RemoveListener()
end

function HomelandEventManager:SetFinishStoryID(id)
  self._saveStoryID = id
end

function HomelandEventManager:GetFinishStoryID()
  local saveId = self._saveStoryID
  self._saveStoryID = nil
  return saveId
end

function HomelandEventManager:SetFinishStoryEvent(fnFinishEvent)
  self._saveStoryFinishEvent = fnFinishEvent
end

function HomelandEventManager:InvokeFinishStoryEvent()
  if self._saveStoryFinishEvent == nil then
    return
  end
  local fnEvent = self._saveStoryFinishEvent
  self._saveStoryFinishEvent = nil
  fnEvent()
end
