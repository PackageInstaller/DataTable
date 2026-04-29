_class("AircraftStoryPointHolder", Object)
AircraftStoryPointHolder = AircraftStoryPointHolder

function AircraftStoryPointHolder:Constructor(trans, floor)
  self._point = {}
  if trans == nil then
    Log.fatal("###父节点空")
  end
  if trans.childCount > 0 then
    for i = 1, trans.childCount do
      local point = trans:GetChild(i - 1)
      point.gameObject:SetActive(false)
      local id = tonumber(point.name)
      self._point[id] = {}
      self._point[id].storyid = 0
      self._point[id].floor = floor
      local aircraftStorySmallPointHolder = AircraftStorySmallPointHolder:New(point, floor)
      self._point[id].points = aircraftStorySmallPointHolder
    end
  else
    Log.debug("###AircraftStoryPointHolder:AddPoint --> trans.childCount <= 0 ! name --> ", trans.name)
  end
end

function AircraftStoryPointHolder:GetPoint(id, storyid)
  if self._point[id] then
    local point2storyid = self._point[id].storyid
    if point2storyid ~= 0 and point2storyid ~= storyid then
      Log.fatal("###[RandomStory]该剧情点已被[", point2storyid, "]占用,无法提供给[", storyid, "]")
      return nil
    end
    self._point[id].storyid = storyid
    local aircraftStorySmallPointHolder = self._point[id].points
    local petCount = 1
    local cfg_random_story = Cfg.cfg_aircraft_pet_stroy_refresh[storyid]
    if cfg_random_story.EnterTriggerNeedPetsArray and 0 < table.count(cfg_random_story.EnterTriggerNeedPetsArray) then
      petCount = table.count(cfg_random_story.EnterTriggerNeedPetsArray) + 1
      Log.debug("###[AircraftStoryPointHolder] 获得多任务剧情人数 coutn --> ", petCount)
    end
    local point = aircraftStorySmallPointHolder:GetPoint(petCount)
    return point
  end
  Log.fatal("###[RandomStory]点不够用了，点id--", id, "|剧情id--", storyid)
  return nil
end

function AircraftStoryPointHolder:Floor(id)
  return self._point[id].floor
end

function AircraftStoryPointHolder:CheckPointOccupy(id, storyid)
  local occupy
  if self._point[id].storyid ~= 0 then
    if self._point[id].storyid == storyid then
      occupy = false
    else
      occupy = true
    end
  else
    occupy = false
  end
  return occupy
end

function AircraftStoryPointHolder:ReleasePoint(id)
  self._point[id].storyid = 0
  self._point[id].points:ReleasePoint()
end

function AircraftStoryPointHolder:ReleaseAll()
  for idx, point in pairs(self._point) do
    point.storyid = 0
    point.points:ReleasePoint()
  end
end
