_class("AircraftScheduleManager", Object)
AircraftScheduleManager = AircraftScheduleManager

function AircraftScheduleManager:Constructor(aircraftMain)
  self._main = aircraftMain
  self._scheduleTimeMIN = 600000
  self._scheduleTimeMAX = 1200000
  self._scheduleTime = math.random(self._scheduleTimeMIN, self._scheduleTimeMAX)
  self._scheduleTimer = 0
end

function AircraftScheduleManager:Init()
end

function AircraftScheduleManager:ReSchedule()
  local allPet = Cfg.cfg_aircraft_pet({})
  local workingPets = {}
  local _module = GameGlobal.GetModule(AircraftModule)
  local spaces = Cfg.cfg_aircraft_space({})
  for i = 1, #spaces do
    local roomData = _module:GetRoom(i)
    if roomData then
      local pets = roomData:GetPets()
      if pets and 0 < #pets then
        for _, pet in ipairs(pets) do
          workingPets[pet:GetTemplateID()] = true
        end
      end
    end
  end
  local petModule = GameGlobal.GetModule(PetModule)
  local pets = {}
  for _, cfg in pairs(allPet) do
    local tmpID = cfg.ID
    local petInBag = petModule:GetPetByTemplateId(tmpID)
    local bindPet = petModule:GetBindPet(tmpID)
    if petInBag and self._main:IsRestPet(tmpID) then
      pets[#pets + 1] = tmpID
    end
  end
  if next(pets) == nil then
    Log.fatal("[AircraftSchedule] 没有可进入娱乐区的星灵")
  end
  pets = table.shuffle(pets)
  local queue = AircraftQueue:New()
  for _, id in ipairs(pets) do
    queue:Enqueue(id)
  end
  self:SetQueueAndInitPets(queue)
end

function AircraftScheduleManager:SetQueueAndInitPets(queue)
  self._queue = queue
  local count = self._queue:Count()
  local rooms = self._main:GetAllRestRoom()
  for i = 1, count do
    local allFull = true
    for _, room in ipairs(rooms) do
      if not room:IsBelongPetFull() then
        allFull = false
        break
      end
    end
    if allFull then
      break
    end
    local petId = self._queue:Dequeue()
    local exist = self._main:GetPetByTmpID(petId) ~= nil
    if not exist then
      local found = false
      for _, room in ipairs(rooms) do
        local cfg = Cfg.cfg_aircraft_pet[petId]
        local tag = room:GetRoomTag()
        if table.icontains(cfg.RoomTag, tag) and not room:IsBelongPetFull() then
          local pet, sp = self._main:AddPet(petId)
          if pet == nil then
            pet = self._main:GetPetByTmpID(petId)
            if pet then
              if sp then
                Log.debug("###[AircraftScheduleManager] sp 的星灵已在，petid:", petId, ",sp星灵:", sp)
              else
                Log.exception("[AircraftSchedule] 该星灵已存在：", petId, "，state:", pet:GetState())
              end
            else
            end
          else
            AirLog("星灵进入娱乐房间：", petId, "，房间：", tag)
            self._main:RandomInitActionForPet(pet)
            room:PetIn(petId)
            pet:SetBelongArea(room:Area())
            found = true
            break
          end
        end
      end
      if not found then
        self._queue:Enqueue(petId)
      end
    end
  end
end

function AircraftScheduleManager:_scheduleOnce()
  local now = self._main:Time()
  local canLeave = self._main:GetPets(function(_pet)
    local pet = _pet
    if not self._main:IsRestPet(pet:TemplateID()) then
      return false
    end
    local state = pet:GetState()
    local enterTime = pet:GetEnterTime()
    if enterTime and now - enterTime < 1200000 then
      return false
    end
    if state == AirPetState.Selected or state == AirPetState.WaitingElevator or state == AirPetState.InElevator or state == AirPetState.Leaving or state == AirPetState.Working or state == AirPetState.Testing or state == AirPetState.Social or pet:IsGiftPet() or pet:IsVisitPet() then
      return false
    end
    return true
  end)
  if #canLeave < 1 then
    AirLog("没有可离开的星灵")
    return
  end
  local count = math.random(1, 2)
  AirLog(count, "个星灵离开娱乐区")
  local leave = {}
  if count < #canLeave then
    for i = 1, count do
      local idx = math.random(i, #canLeave)
      local temp = canLeave[idx]
      canLeave[idx] = canLeave[i]
      canLeave[i] = temp
      leave[i] = temp
    end
  else
    leave = canLeave
  end
  local enterIDs = {}
  for i = 1, count do
    local id = self._queue:Dequeue()
    if id == nil then
      AirLog("当前队列中已没有星灵，不可进入")
      break
    end
    enterIDs[#enterIDs + 1] = id
  end
  if 0 < #enterIDs then
    local delay = 0
    local pos = self._main:ExitPosition()
    for _, id in ipairs(enterIDs) do
      AirLog("1个星灵开始进入风船休闲区:", id)
      local pet, sp = self._main:AddPet(id)
      if pet then
        pet:SetFloor(1)
        local action = AirActionPetEnter:New(pet, pos, delay)
        pet:SetEnterTime(self._main:Time())
        pet:StartMainAction(action)
        delay = delay + 1000
      elseif sp then
        Log.debug("###[AircraftScheduleManager] sp 的星灵已在，petid:", id, ",sp星灵:", sp)
      end
    end
  end
  for _, pet in ipairs(leave) do
    local action = AirActionMoveToLeave:New(pet, self._main)
    pet:StartMainAction(action)
    AirLog("星灵开始离开风船：", pet:TemplateID())
  end
end

function AircraftScheduleManager:Enqueue(temID)
  if self._queue:Contains(temID) then
    Log.exception("[AircraftSchedule] 严重错误，队列中已包含该星灵：", temID)
    return
  end
  self._queue:Enqueue(temID)
end

function AircraftScheduleManager:Update(deltaTimeMS)
  self._scheduleTimer = self._scheduleTimer + deltaTimeMS
  if self._scheduleTimer > self._scheduleTime then
    self._scheduleTime = math.random(self._scheduleTimeMIN, self._scheduleTimeMAX)
    self._scheduleTimer = 0
    self:_scheduleOnce()
  end
end

function AircraftScheduleManager:Dispose()
end

function AircraftScheduleManager:TryRemoveInQueue(petID)
  self._queue:RemoveFirst(function(item)
    return item == petID
  end)
end

function AircraftScheduleManager:GetQueue()
  local ids = {}
  self._queue:ForEach(function(id)
    ids[#ids + 1] = id
  end)
  return ids
end

function AircraftScheduleManager:SetQueue(queue)
  self._queue = queue
end

function AircraftScheduleManager:PushInQueue(id)
  self._queue:Enqueue(id)
end

function AircraftScheduleManager:Reset()
  self._scheduleTime = math.random(self._scheduleTimeMIN, self._scheduleTimeMAX)
  self._scheduleTimer = 0
end
