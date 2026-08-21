local UIN33EightPetsTeamsReason = {SUCCESS = 0, ERROR_PROF_UPPER_LIMIT = 1}
_enum("UIN33EightPetsTeamsReason", UIN33EightPetsTeamsReason)
_class("UIN33EightPetsTeamsCondition", Object)
UIN33EightPetsTeamsCondition = UIN33EightPetsTeamsCondition

function UIN33EightPetsTeamsCondition:Constructor()
  self._result = 0
end

function UIN33EightPetsTeamsCondition:CurTeamPets()
  local missionModule = GameGlobal.GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  if ctx:IsFastSelect() then
    local context = ctx:EightPetsContext()
    return context:FastTeamPets()
  else
    local teamId = ctx:GetCurrTeamId()
    local teams = ctx:Teams()
    local team = teams:Get(teamId)
    return team:GetPets()
  end
end

function UIN33EightPetsTeamsCondition:SetCondition(...)
  local params = {
    ...
  }
  self:OnSetCondition(params)
end

function UIN33EightPetsTeamsCondition:OnSetCondition(params)
end

function UIN33EightPetsTeamsCondition:ConditionResult()
end

function UIN33EightPetsTeamsCondition:TestPet(petPstId, teamSlot)
  return UIN33EightPetsTeamsReason.SUCCESS, 0
end

_class("UIN33EightPetsTeamsProfUpperLimit", UIN33EightPetsTeamsCondition)
UIN33EightPetsTeamsProfUpperLimit = UIN33EightPetsTeamsProfUpperLimit

function UIN33EightPetsTeamsProfUpperLimit:OnSetCondition(params)
  self._prof = params[1]
  self._upperLimit = params[2]
end

function UIN33EightPetsTeamsProfUpperLimit:ConditionResult()
  local petModule = GameGlobal.GetModule(PetModule)
  local count = 0
  local pets = self:CurTeamPets()
  for k, v in pairs(pets) do
    local pet = petModule:GetPet(v)
    if pet ~= nil and pet:GetProf() == self._prof then
      count = count + 1
    end
  end
  self._result = count
end

function UIN33EightPetsTeamsProfUpperLimit:TestPet(petPstId, teamSlot)
  local count = self._result
  local missionModule = GameGlobal.GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  local petModule = GameGlobal.GetModule(PetModule)
  local petNew = petModule:GetPet(petPstId)
  if petNew ~= nil and petNew:GetProf() == self._prof then
    local teamPets = self:CurTeamPets()
    local petOld = petModule:GetPet(teamPets[teamSlot])
    if ctx:IsFastSelect() then
      local lookupPets = ctx:EightPetsContext():FastTeamPetsLookup()
      if lookupPets[petPstId] == nil then
        petOld = nil
      else
        petOld = petNew
      end
    end
    if petOld == nil then
      count = count + 1
    else
      if petOld:GetProf() ~= self._prof then
        count = count + 1
      else
      end
    end
  end
  if count > self._upperLimit then
    return UIN33EightPetsTeamsReason.ERROR_PROF_UPPER_LIMIT, self._upperLimit
  end
  return UIN33EightPetsTeamsReason.SUCCESS, self._upperLimit
end
