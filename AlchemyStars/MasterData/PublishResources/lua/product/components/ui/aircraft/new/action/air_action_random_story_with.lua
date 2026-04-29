_class("AirActionRandomStoryWith", AirActionBase)
AirActionRandomStoryWith = AirActionRandomStoryWith

function AirActionRandomStoryWith:Constructor(pet, main, storyid, storyParam, floor, pointid, randomPointHolder, noMove)
  self._pet = pet
  self._main = main
  self._storyid = storyid
  local cfg = Cfg.cfg_aircraft_pet_stroy_refresh[self._storyid]
  if not cfg then
    Log.error("###[AirAction_RS_Wait_with]cfg_aircraft_pet_stroy_refresh is nil ! id --> ", self._storyid)
    return
  end
  self._lastTime = cfg.CancelWaitTime
  self._randomStoryAreaType = cfg.RandomStoryAreaType
  self._storyParams = storyParam
  self._floor = floor
  if not noMove then
    self._pet:SetFloor(self._floor)
  end
  self._noMove = noMove
end

function AirActionRandomStoryWith:Start()
  self._running = true
  self._isWaiting = true
  if not self._noMove then
    if self._randomStoryAreaType == 1 then
      self._pet:Anim_Stand()
      local pos = self._storyParams.position
      local rot = self._storyParams.localRotation
      self._pet:NaviObstacle().enabled = false
      self._setNavPos = pos
      self._pet:SetPosition(pos)
      self._pet:SetRotation(rot)
    elseif self._storyParams then
      Log.exception("星灵不能在家具上触发跟随剧情", self._pet:TemplateID())
    end
  end
end

function AirActionRandomStoryWith:Update(deltaTimeMS)
  if self._running and self._setNavPos then
    local found, hit = UnityEngine.AI.NavMesh.SamplePosition(self._setNavPos, nil, 10, 1 << self._floor + 2)
    if found then
      self._pet:SetPosition(hit.position)
    end
    self._pet:NaviObstacle().enabled = true
    self._setNavPos = nil
  end
end

function AirActionRandomStoryWith:IsOver()
  return not self._running
end

function AirActionRandomStoryWith:Stop()
  self._running = false
end

function AirActionRandomStoryWith:GetPointAndFloor(storyType, RandomStoryPosIDs, RandomStoryFurnitureType)
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
      Log.debug("###[AirAction_RS_Wait_with]设置了家具的楼层")
      return storyParam, floor
    else
      Log.debug("###[AirAction_RS_Wait_with]没有该家具，去甲板触发")
      storyType = 1
      return self:GetPointAndFloor_NoFurniture(RandomStoryPosIDs)
    end
  end
end

function AirActionRandomStoryWith:GetPointAndFloor_NoFurniture(RandomStoryPosIDs)
  local storyParam, floor
  local storyParams = RandomStoryPosIDs
  for i = 1, #storyParams do
    local area = storyParams[i][1]
    local pointid = storyParams[i][2]
    local randomPointHolder
    if area == AirRestAreaType.Board3 or area == AirRestAreaType.Board4 then
      randomPointHolder = self._main:GetRandomStoryPointHolder(area)
    else
      local room = self._main:GetRoomByArea(area)
      randomPointHolder = room:GetRandomStoryPointHolder()
    end
    if not randomPointHolder:CheckPointOccupy(pointid, self._storyid) then
      storyParam = randomPointHolder:GetPoint(pointid, self._storyid)
      floor = randomPointHolder:Floor(pointid)
      Log.debug("###[AirAction_RS_Wait_with]找到一个点,id", pointid)
      Log.debug("###[AirAction_RS_Wait_with]找到楼层，", floor)
      break
    end
  end
  if not storyParam or not floor then
    Log.debug("###rrrrr检查完毕没找到")
    return
  end
  return storyParam, floor
end

function AirActionRandomStoryWith:GetPointAndFloor_ByFurniture(RandomStoryFurnitureType)
end
