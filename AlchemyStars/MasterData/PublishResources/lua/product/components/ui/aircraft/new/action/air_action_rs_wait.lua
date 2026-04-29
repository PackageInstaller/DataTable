_class("AirAction_RS_Wait", AirActionBase)
AirAction_RS_Wait = AirAction_RS_Wait

function AirAction_RS_Wait:Constructor(pet, main, storyid, storyParam, floor, pointid, randomPointHolder, noMove)
  self._pet = pet
  Log.debug("###[AirAction_RS_Wait] 开启一个随机剧情-id-->", self._pet:TemplateID())
  self._main = main
  self._storyid = storyid
  local cfg = Cfg.cfg_aircraft_pet_stroy_refresh[self._storyid]
  if not cfg then
    Log.error("###[AirAction_RS_Wait]cfg_aircraft_pet_stroy_refresh is nil ! id --> ", self._storyid)
    return
  end
  self._lastTime = cfg.CancelWaitTime * 1000
  self._waitBubble = cfg.HeadBubbleID
  self._randomStoryAreaType = cfg.RandomStoryAreaType
  self._storyParams = storyParam
  self._floor = floor
  self._pointID = pointid
  self._randomPointHolder = randomPointHolder
  if not noMove then
    self._pet:SetFloor(self._floor)
  end
  self._startTime = 0
  self._waiting = true
  self._noMove = noMove
  self._setNavPos = false
end

function AirAction_RS_Wait:Update(deltaTimeMS)
  if not self._noMove and not self._setNavPos then
    local found, hit = UnityEngine.AI.NavMesh.SamplePosition(self._position, nil, 10, 1 << self._floor + 2)
    if found then
      self._pet:SetPosition(hit.position)
    end
    self._pet:NaviObstacle().enabled = true
    self._setNavPos = true
  end
  if self._running then
    self._startTime = self._startTime + deltaTimeMS
    if self._waiting and self._startTime > self._lastTime then
      self._waiting = false
      self._startTime = 0
      self:ReadyStop()
    end
  end
end

function AirAction_RS_Wait:ReadyStop()
  local action_rs_cancel = AirAction_RS_Cancel:New(self._pet, self._main, self._storyid)
  self._pet:StartViceAction(action_rs_cancel)
end

function AirAction_RS_Wait:Start()
  self._running = true
  self._isWaiting = true
  if not self._noMove then
    if self._randomStoryAreaType == 1 then
      local pos = self._storyParams.position
      local rot = self._storyParams.localRotation
      self._pet:NaviObstacle().enabled = false
      self._pet:SetPosition(pos)
      self._pet:SetRotation(rot)
      self._position = pos
      self._pet:Anim_Stand()
    elseif self._storyParams then
      Log.exception("星灵不能在家具上触发剧情", self._pet:TemplateID())
    end
  end
end

function AirAction_RS_Wait:StartWaitBubble()
  if self._waitBubble then
    local waitAction = AirActionFace:New(self._pet, self._waitBubble, nil, self._lastTime)
    self._pet:StartViceAction(waitAction)
    local bubble = waitAction:GetBubbleGameObject()
    if bubble then
      local collider = bubble:GetComponentInChildren(typeof(UnityEngine.BoxCollider))
      if collider then
        self._pet:SetEffectCollider(collider)
      else
        AirError("剧情特效无法获取碰撞器:", self._waitBubble)
      end
    end
  end
end

function AirAction_RS_Wait:IsOver()
  return not self._running
end

function AirAction_RS_Wait:Stop()
  self._running = false
  if self._randomPointHolder and self._pointID then
    self._randomPointHolder:ReleasePoint(self._pointID)
    self._randomPointHolder = nil
    self._pointID = nil
  end
end

function AirAction_RS_Wait:GetPointAndFloor(storyType, RandomStoryPosIDs, RandomStoryFurnitureType)
  if storyType == 1 then
    return self:GetPointAndFloor_NoFurniture(RandomStoryPosIDs)
  else
    local storyParam, floor
    storyParam = RandomStoryFurnitureType
    local furniture = self._main:GetFurnitureByID(storyParam)
    if furniture then
      local pets = furniture:GetPets()
      for _, petid in pairs(pets) do
        local pet = self._main:GetPetByTmpID(petid)
        self._main:RandomActionForPet(pet)
      end
      floor = furniture:Floor()
      Log.debug("###[AirAction_RS_Wait]设置了家具的楼层")
      return storyParam, floor
    else
      Log.debug("###[AirAction_RS_Wait]没有该家具，去甲板触发")
      storyType = 1
      return self:GetPointAndFloor_NoFurniture(RandomStoryPosIDs)
    end
  end
end

function AirAction_RS_Wait:GetPointAndFloor_NoFurniture(RandomStoryPosIDs)
  local storyParam, floor
  local storyParams = RandomStoryPosIDs
  Log.debug("###[AirAction_RS_Wait]检查没用到的剧情点")
  for i = 1, #storyParams do
    local area = storyParams[i][1]
    local pointid = storyParams[i][2]
    local randomPointHolder
    if area == AirRestAreaType.Board3 or area == AirRestAreaType.Board4 then
      randomPointHolder = self._main:GetRandomStoryPointHolder(area)
    else
      local room = self._main:GetRoomByArea(area)
      if room == nil then
        Log.exception("找不到房间：", area)
      end
      randomPointHolder = room:GetRandomStoryPointHolder()
    end
    self._pointID = pointid
    self._randomPointHolder = randomPointHolder
    if not randomPointHolder:CheckPointOccupy(pointid, self._storyid) then
      storyParam = randomPointHolder:GetPoint(pointid, self._storyid)
      floor = randomPointHolder:Floor(pointid)
      Log.debug("###[AirAction_RS_Wait]找到一个点,id", pointid)
      Log.debug("###[AirAction_RS_Wait]找到楼层，", floor)
      break
    end
  end
  if not storyParam or not floor then
    Log.debug("###[AirAction_RS_Wait]检查完毕没找到")
    return
  end
  return storyParam, floor
end

function AirAction_RS_Wait:GetPointAndFloor_ByFurniture(RandomStoryFurnitureType)
end
