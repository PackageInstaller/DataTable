require("_base_run_data")
_class("TestRobotElementalRunData", TestRobotRunData)
TestRobotElementalRunData = TestRobotElementalRunData

function TestRobotElementalRunData:Constructor()
  self._randomTeam = false
  self._currentTestTeamBuildID = 0
  self._finishedTestTeamBuildIDs = {}
  self._isPetRequired = {}
  self._isPetDisabled = {}
  self._permanentlyTestPetTemplateIDs = {}
  self._permanentlyDisabledPetTemplateIDs = {}
end

function TestRobotElementalRunData:IsRandomTeam()
  return self._randomTeam
end

function TestRobotElementalRunData:GetPetPstIDs()
  return self._petPstIDs
end

function TestRobotElementalRunData:ParseLevelData()
end

function TestRobotElementalRunData:ParseTeamData(rawargs)
  local queryCfg = Cfg.cfg_level_test_team_build({
    MissionID = self:GetMissionID()
  })
  local config = queryCfg and queryCfg[1] or nil
  config = config or Cfg.cfg_level_test_team_build[-1]
  if config then
    local tmodule = GameGlobal.GetModule(TestRobotModule)
    tmodule:Log("select test team build ID: ", config.ID)
    self._currentTestTeamBuildID = config.ID
  end
  if rawargs == "*" then
    self._randomTeam = true
    return
  end
  local split = string.split(rawargs, "%$")
  for index, rawPet in ipairs(split) do
    local petSplit = string.split(rawPet, ",")
    if #petSplit ~= 7 then
      Log.exception(self._className, "bad pet status: ", rawPet)
      self._manager:PrintLog(self._className, "bad pet status: ", rawPet)
      return
    end
    local param = {}
    for _, s in ipairs(petSplit) do
      table.insert(param, tonumber(s))
    end
    local petBuildData = TestRobotPetBuildData:New(table.unpack(param))
    self:AddPet(petBuildData)
  end
end

function TestRobotElementalRunData:GeneratePetPstID()
  local petPstIds = {
    0,
    0,
    0,
    0,
    0
  }
  local petModule = GameGlobal.GetModule(PetModule)
  for index, petBuildData in ipairs(self._currentTeamBuild) do
    local matchPet = petModule:GetPetByTemplateId(petBuildData:GetTemplateID())
    local pstId = matchPet:GetPstID()
    petPstIds[index] = pstId
  end
  self._petPstIDs = petPstIds
  return self._petPstIDs
end

function TestRobotElementalRunData:GeneratePetTemplateID()
  local petTemplateIds = {
    0,
    0,
    0,
    0,
    0
  }
  local petModule = GameGlobal.GetModule(PetModule)
  for index, petBuildData in ipairs(self._currentTeamBuild) do
    petTemplateIds[index] = petBuildData:GetTemplateID()
  end
  return petTemplateIds
end

function TestRobotElementalRunData:SetPermanentlyTestPet(t)
  for _, templateID in ipairs(t) do
    self._isPetRequired[templateID] = true
    if not table.icontains(self._permanentlyTestPetTemplateIDs, templateID) then
      table.insert(self._permanentlyTestPetTemplateIDs, templateID)
    end
  end
end

function TestRobotElementalRunData:GetPermanentlyRequiredPetList()
  return self._permanentlyTestPetTemplateIDs
end

function TestRobotElementalRunData:IsPetRequired(templateID)
  return self._isPetRequired[templateID]
end

function TestRobotElementalRunData:SetPermanentlyDisabledPet(t)
  for _, templateID in ipairs(t) do
    self._isPetDisabled[templateID] = true
    if not table.icontains(self._permanentlyDisabledPetTemplateIDs, templateID) then
      table.insert(self._permanentlyDisabledPetTemplateIDs, templateID)
    end
  end
end

function TestRobotElementalRunData:GetPermanentlyDisabledPetList()
  return self._permanentlyDisabledPetTemplateIDs
end

function TestRobotElementalRunData:IsPetDisabled(templateID)
  return self._isPetDisabled[templateID] or TestConst.TemperoryDisabledPet[templateID]
end

function TestRobotElementalRunData:SetPetPoolOptions(v)
  self._petPoolOptions = v
end

function TestRobotElementalRunData:GetPetPoolOptions()
  return self._petPoolOptions or SmokeTestTeamBuildPoolOptions:New()
end

function TestRobotElementalRunData:GetUntestedPets()
  local queryCondition = {Formal = 1}
  local petPoolOptions = self:GetPetPoolOptions()
  if petPoolOptions.forcePetMainElement then
    queryCondition.FirstElement = petPoolOptions.forcePetMainElement
  end
  local rawEnabledPets = Cfg.cfg_pet(queryCondition)
  local filteredEnabledPets = {}
  local bindGroupInfo = {}
  local currentTeamBuild = self:GetCurrentTeamBuild()
  local skipPetID = {}
  for _, data in ipairs(currentTeamBuild) do
    local tid = data:GetTemplateID()
    table.insert(skipPetID, tid)
    local conf = Cfg.cfg_pet[tid]
    if conf.BinderPetID then
      bindGroupInfo[conf.BinderPetID] = {
        conf.BinderIndex
      }
    end
  end
  for _, petConfig in ipairs(rawEnabledPets) do
    if self:IsPetDisabled(petConfig.ID) then
      Log.info(self._className, "pet disabled: ", petConfig.ID)
    elseif not self:GetPetBuildData(petConfig.ID) then
      if petConfig.BinderPetID then
        if bindGroupInfo[petConfig.BinderPetID] then
          goto lbl_81
        end
        bindGroupInfo[petConfig.BinderPetID] = {
          petConfig.BinderIndex
        }
      end
      table.insert(filteredEnabledPets, petConfig)
    end
    ::lbl_81::
  end
  return filteredEnabledPets
end

function TestRobotElementalRunData:GetCurrentTestTeamBuildID()
  return self._currentTestTeamBuildID
end

function TestRobotElementalRunData:IsTestBuildIDFinished(val)
  return table.icontains(self._finishedTestTeamBuildIDs, val)
end

function TestRobotElementalRunData:MarkCurrentTestTeamBuildIDFinished()
  table.insert(self._finishedTestTeamBuildIDs, self._currentTestTeamBuildID)
end

function TestRobotElementalRunData:ChangeCurrentTestTeamBuildID(val)
  table.insert(self._finishedTestTeamBuildIDs, self._currentTestTeamBuildID)
  self._currentTestTeamBuildID = val
end

_class("TestRobotElementalMissionRunData", TestRobotElementalRunData)
TestRobotElementalMissionRunData = TestRobotElementalMissionRunData

function TestRobotElementalMissionRunData:ParseLevelData(rawargs)
  local missionID = tonumber(rawargs)
  if not Cfg.cfg_mission[missionID] then
    Log.exception(self._className, "bad mission id: ", tostring(rawargs))
    self._manager:PrintLog(self._className, "bad mission id: ", tostring(rawargs))
    return
  end
  local c = Cfg.cfg_mission[missionID]
  if c.Type == 3 then
    Log.exception(self._className, "mission is not a battle", tostring(rawargs))
    self._manager:PrintLog(self._className, "mission is not a battle", tostring(rawargs))
    return
  end
  self._missionID = missionID
end

_class("TestRobotElementalMazeRunData", TestRobotElementalRunData)
TestRobotElementalMazeRunData = TestRobotElementalMazeRunData

function TestRobotElementalMazeRunData:SetCurrentTeamPstIDList(petPstIds)
  self._currentTeamPstIDList = petPstIds
end

function TestRobotElementalMazeRunData:GetCurrentTeamPstIDList()
  return self._currentTeamPstIDList
end

_class("TestRobotElementalAniPopStarRunData", TestRobotElementalRunData)
TestRobotElementalAniPopStarRunData = TestRobotElementalAniPopStarRunData

function TestRobotElementalAniPopStarRunData:SetCurrentTeamPstIDList(petPstIds)
  self._currentTeamPstIDList = petPstIds
end

function TestRobotElementalAniPopStarRunData:ParseLevelData(rawarg)
  local s = string.split(rawarg, ",")
  self:SetHardID(tonumber(s[1]))
end

function TestRobotElementalAniPopStarRunData:GetCurrentTeamPstIDList()
  return self._currentTeamPstIDList
end

function TestRobotElementalAniPopStarRunData:SetHardID(id)
  self._hardId = id
end

function TestRobotElementalAniPopStarRunData:GetHardID()
  return self._hardId
end

function TestRobotElementalAniPopStarRunData:GetMissionID()
  local prefix = 27000
  return prefix + self._hardId
end
