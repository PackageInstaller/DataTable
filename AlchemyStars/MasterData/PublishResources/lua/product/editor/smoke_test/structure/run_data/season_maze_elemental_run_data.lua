_class("ElementalSeasonMazeRunData", TestRobotElementalRunData)
ElementalSeasonMazeRunData = ElementalSeasonMazeRunData

function ElementalSeasonMazeRunData:ParseLevelData(rawargs)
  local args = string.split(rawargs, ",")
  self._missionID = tonumber(args[1])
  self._componentID = tonumber(args[2])
end

function ElementalSeasonMazeRunData:GetMissionID()
  return self._missionID
end

function ElementalSeasonMazeRunData:GetComponentID()
  return self._componentID
end

function ElementalSeasonMazeRunData:GetComponentConfigID()
  return self._componentID
end

function ElementalSeasonMazeRunData:GeneratePetPstID()
  local petPstIds = {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  }
  local petModule = GameGlobal.GetModule(PetModule)
  for index, petBuildData in ipairs(self._currentTeamBuild) do
    local matchPet = petModule:GetPetByTemplateId(petBuildData:GetTemplateID())
    local templateID = matchPet:GetTemplateID()
    petPstIds[index] = templateID
  end
  self._petPstIDs = petPstIds
  return self._petPstIDs
end
