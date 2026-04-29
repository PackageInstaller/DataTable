_class("AircraftSocialManager", Object)
AircraftSocialManager = AircraftSocialManager
local SOCIAL_DISPATCH = true
local SOCIAL_OPEN = true
local CHECK_TIME = 300000

function AircraftSocialManager:Constructor(aircraftMain)
  self.m_AirMain = aircraftMain
  self.m_Areas = {}
  self.m_Executors = {}
  self.m_SerializeIng = false
  self:InitFilter()
  self:InitMatcher()
  self:AddListener()
  self:InitParams()
  self.m_SocialCamNearby = false
end

function AircraftSocialManager:InitParams()
  local open = Cfg.cfg_aircraft_const.aircraft_social_open
  SOCIAL_OPEN = open and open.IntValue or 1
  if SOCIAL_OPEN == 1 then
    SOCIAL_OPEN = true
  else
    SOCIAL_OPEN = false
  end
  local time = Cfg.cfg_aircraft_const.aircraft_social_check_time
  CHECK_TIME = time and time.IntValue or 300000
end

function AircraftSocialManager:AddListener()
  self.cb = GameHelper:GetInstance():CreateCallback(self.ExecuteSocialAction, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.AirForceTriggerSocialAction, self.cb)
end

function AircraftSocialManager:RemoveListener()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.AirForceTriggerSocialAction, self.cb)
end

function AircraftSocialManager:Dispose()
  self:RemoveListener()
  self:DisposeExecutors(false)
  self:StopTimer()
end

function AircraftSocialManager:DisposeExecutors(needRandom)
  if self.m_Executors then
    for _, e in ipairs(self.m_Executors) do
      e:Dispose(needRandom, true)
    end
  end
  self.m_Executors = {}
end

function AircraftSocialManager:StartTimer()
  self.timer = GameGlobal.Timer():AddEventTimes(CHECK_TIME, TimerTriggerCount.Infinite, self.CheckTrigger, self)
  self:CheckTrigger()
end

function AircraftSocialManager:CheckTrigger()
  if self.m_SerializeIng == true then
    return
  end
  local pets = self.m_AirMain:GetPets(function(_pet)
    local pet = _pet
    if pet:IsAlive() then
      local state = pet:GetState()
      if state ~= AirPetState.Wandering then
        return false
      end
      local can = self:Filter(pet)
      return true
    end
  end, true)
  if pets and 1 < #pets then
    local areas = self:Match(pets)
    if areas and 0 < #areas then
      self:Dispatch(areas)
    end
  end
end

function AircraftSocialManager:StopTimer()
  if self.timer then
    GameGlobal.Timer():CancelEvent(self.timer)
    self.timer = nil
  end
end

function AircraftSocialManager:Init()
  if not SOCIAL_OPEN then
    return
  end
  self:StartTimer()
end

function AircraftSocialManager:Update(deltaTimeMS)
end

function AircraftSocialManager:InitFilter()
  self.filters = {
    SocialWeightFilter:New(),
    AreaFilter:New()
  }
end

function AircraftSocialManager:InitMatcher()
  self.matchers = {
    InitAreaMatcher:New(),
    RelationMatcher:New(),
    AddLibMatcher:New(),
    FilterLibMatcher:New(),
    FilterLibPetMatcher:New(),
    FilterAreaMatcher:New(),
    InitLibMakerMatcher:New()
  }
end

function AircraftSocialManager:Filter(pet)
  local count = 0
  for _, filter in ipairs(self.filters) do
    local can = filter:Filter(pet)
    if can then
      count = count + 1
    end
  end
  return count == #self.filters
end

local AirRestAreaTypeName = {
  [AirRestAreaType.RestRoom] = "休息室",
  [AirRestAreaType.CoffeeHouse] = "咖啡厅",
  [AirRestAreaType.Bar] = "酒吧",
  [AirRestAreaType.EntertainmentRoom] = "娱乐室",
  [AirRestAreaType.Board3] = "3层甲板",
  [AirRestAreaType.Board4] = "4层甲板",
  [AirRestAreaType.CenterRoom] = "主控室"
}

function AircraftSocialManager:Match(pets)
  local areas = self.matchers[1]:Match(pets, self.m_AirMain)
  Log.error("社交匹配@@@第1阶段：初始化所有区域和人")
  Log.error("社交匹配@@@1.当前区域个数", #areas)
  for index, area in ipairs(areas) do
    self.log1 = ""
    self.log1 = self.log1 .. "社交匹配@@@1.区域类型:" .. AirRestAreaTypeName[area:GetRestAreaType()] .. "  "
    for index, pet in pairs(area:GetPets()) do
      self.log1 = self.log1 .. pet:PetName() .. ","
    end
    Log.error(self.log1)
  end
  for index = 2, #self.matchers do
    areas = self.matchers[index]:Match(areas, self.m_AirMain)
    Log.error("社交匹配@@@第", index, "阶段：", self.matchers[index]._className)
    Log.error("社交匹配@@@", index, ".当前区域个数", #areas)
    for _, area in ipairs(areas) do
      self.log2 = ""
      self.log2 = self.log2 .. "社交匹配@@@", index, ".区域类型:" .. AirRestAreaTypeName[area:GetRestAreaType()] .. "  "
      for _, pet in pairs(area:GetPets()) do
        self.log2 = self.log2 .. pet:PetName() .. ","
      end
      Log.error(self.log2)
    end
  end
  return areas
end

function AircraftSocialManager:Dispatch(areas)
  if not SOCIAL_DISPATCH then
    return
  end
  for key, area in pairs(areas) do
    area:SetAllPetSocialState()
    local executor = AirGroupActionExecutor:New(self.m_AirMain, area, function(executor)
      if executor then
        executor:Dispose(true)
        table.removev(self.m_Executors, executor)
      end
    end)
    table.insert(self.m_Executors, executor)
  end
end

function AircraftSocialManager:DecodeFinish()
  self.m_SerializeIng = false
  local removeIndex = {}
  for index, area in ipairs(self.m_Areas) do
    local remove = area:InitLibMaker(true)
    if remove then
      table.insert(removeIndex, index)
    end
  end
  if 0 < #removeIndex then
    for i = #removeIndex, 1, -1 do
      table.remove(self.m_Areas, removeIndex[i])
    end
  end
  self:Dispatch(self.m_Areas)
end

function AircraftSocialManager:ExecuteSocialAction(_pet)
  self.m_SerializeIng = true
  local pet = _pet
  if not pet then
    return
  end
  local airSocialActionType = pet:GetSocialActionType()
  local round = pet:GetSocialRound()
  local pointHolderIndex = pet:GetSocialPointHolderIndex()
  local furnitureKey = pet:GetSocialFurnitureKey()
  local restType = pet:GetSocialAreaType()
  local allPetCount = pet:GetSocialPetCount()
  local area = AirHelper.GetArea(pet, self.m_Areas, self.m_AirMain, restType)
  area:AddPet(pet:TemplateID(), pet)
  area:AddLib(airSocialActionType)
  if furnitureKey and not area:GetFurniture() then
    local furniture = self.m_AirMain:GetFurnitureByKey(furnitureKey)
    area:SetFurniture(furniture)
  end
  area:SetSocialRound(round)
  area:SetSocialPointHolderIndex(pointHolderIndex)
  area:SetSocialPetCount(allPetCount)
end

function AircraftSocialManager:StopSocialByPet(targetPet)
  if targetPet and targetPet:GetState() == AirPetState.Social then
    local targetExecutor = false
    for index, group in ipairs(self.m_Executors) do
      local pets = group:GetPets()
      for key, pet in pairs(pets) do
        if pet == targetPet then
          targetExecutor = group
          break
        end
      end
    end
    if targetExecutor then
      local log = ""
      local pets = targetExecutor:GetPets()
      for index, pet in pairs(pets) do
        if pet ~= targetPet then
          self.m_AirMain:RandomActionForPet(pet)
          log = log .. pet:TemplateID() .. "，"
        end
      end
      targetExecutor:Dispose(false)
      table.removev(self.m_Executors, targetExecutor)
      AirLog("1个星灵打断社交行为:", targetPet:TemplateID(), "，其余星灵：", log)
    end
  end
end

function AircraftSocialManager:StopSocialByFurniture(furID)
  local needRemove = {}
  for index, group in ipairs(self.m_Executors) do
    local targetFur = group:GetAreaFurniture()
    if targetFur and targetFur:InstanceID() == furID then
      needRemove[#needRemove + 1] = group
    end
  end
  for _, group in ipairs(needRemove) do
    for index, pet in pairs(group:GetPets()) do
      self.m_AirMain:RandomActionForPet(pet)
    end
    group:Dispose(false)
    table.removev(self.m_Executors, group)
  end
end

function AircraftSocialManager:SetCamNearbyState(state)
  self.m_SocialCamNearby = state
end

function AircraftSocialManager:GetCamNearbyState()
  return self.m_SocialCamNearby
end

function AircraftSocialManager:OnPetDestroy(pet)
  self:StopSocialByPet(pet)
end

function AircraftSocialManager:GetSocialGroupPets(pet)
  if pet and pet:GetState() == AirPetState.Social then
    local targetExecutor
    for index, group in ipairs(self.m_Executors) do
      local pets = group:GetPets()
      for key, p in pairs(pets) do
        if p:TemplateID() == pet:TemplateID() then
          return pets
        end
      end
    end
  end
end

function AircraftSocialManager:OnFurnitureActionStart(pet, fur, action)
end

function AircraftSocialManager:OnFurnitureActionStop()
end
