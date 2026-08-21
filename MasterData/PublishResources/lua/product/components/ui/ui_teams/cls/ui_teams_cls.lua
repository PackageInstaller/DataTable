_class("Teams", Object)
Teams = Teams

function Teams:Constructor()
  self.list = {}
end

function Teams:Init(serverData)
  self.list = {}
  for i, v in ipairs(serverData) do
    local team = Team:New()
    team:Init(v.id, v.name, v.pet_list)
    self.list[v.id] = team
  end
end

function Teams:_InitDiffTeams(serverData)
  self.list = {}
  for i, v in ipairs(serverData) do
    local team = Team:New()
    team:Init(v.id, v.name, v.pet_list)
    self.list[v.id] = team
  end
end

function Teams:_InitCampDiffTeams(serverData)
  self.list = {}
  for i, v in ipairs(serverData) do
    local team = Team:New()
    team:Init(v.id, v.name, v.pet_list)
    self.list[v.id] = team
  end
end

function Teams:_InitMazeTeams(serverData)
  self.list = {}
  for i, v in ipairs(serverData) do
    local team = Team:New()
    team:Init(v.id, v.name, v.pet_list)
    self.list[v.id] = team
  end
end

function Teams:_InitAirTeams(serverData)
  self.list = {}
  for i, v in ipairs(serverData) do
    local team = Team:New()
    team:Init(v.id, v.name, v.pet_list)
    self.list[v.id] = team
  end
end

function Teams:_InitSeasonTeams(serverData)
  self.list = {}
  for i, v in ipairs(serverData) do
    local team = Team:New()
    team:Init(v.id, v.name, v.pet_list)
    self.list[v.id] = team
  end
end

function Teams:InitTrailTeams(serverData)
  self.list = {}
  for i, v in ipairs(serverData) do
    local team = Team:New()
    team:Init(v.id, v.name, v.pet_list)
    self.list[v.id] = team
  end
end

function Teams:InitN21CCTeams(serverData, levelIndex)
  self.list = {}
  local team = Team:New()
  if serverData then
    team:Init(serverData.id, serverData.name, serverData.pet_list)
  else
    team:Init(levelIndex, "", {})
  end
  self.list[levelIndex] = team
end

function Teams:InitSailingTeams(serverData, levelIndex)
  self.list = {}
  local team = Team:New()
  if serverData then
    team:Init(levelIndex, "", serverData.pet_list)
  else
    team:Init(levelIndex, "", {})
  end
  self.list[levelIndex] = team
end

function Teams:InitVampireTeams()
  self.list = {}
  local team = Team:New()
  team:Init(1, "", {})
  self.list[1] = team
end

function Teams:_InitSeasonMazeTeams(serverData)
  self.list = {}
  for i, v in ipairs(serverData) do
    local team = Team:New()
    team.teamSlotCount = 8
    team:Init(v.id, v.name, v.pet_list)
    self.list[i] = team
  end
end

function Teams:_InitPopStarTeams(serverData)
  self.list = {}
  for i, v in ipairs(serverData) do
    local team = Team:New()
    team:Init(v.id, v.name, v.pet_list)
    self.list[v.id] = team
  end
end

function Teams:_InitAniPopStarTeams(serverData)
  self.list = {}
  for i, v in ipairs(serverData.fromation_list) do
    local team = Team:New()
    team:Init(v.id, v.name, v.pet_list)
    self.list[v.id] = team
  end
end

function Teams:_InitSeasonOnceTeams(serverData)
  self.list = {}
  for i, v in ipairs(serverData) do
    local team = Team:New()
    team:Init(v.id, v.name, v.pet_list)
    self.list[v.id] = team
  end
end

function Teams:TeamCount()
  return table.count(self.list)
end

function Teams:Get(id)
  return self.list[id]
end

function Teams:UpdateTeam(team)
  self.list[team.id] = team
  if GameSingle then
    local save = ""
    for i = 1, 8 do
      if self.list[i] == nil then
        save = save .. "0,0,0,0,0"
      else
        for j = 1, 5 do
          save = save .. self.list[i].pets[j] .. ","
        end
      end
      if i < 8 then
        save = save .. "|"
      end
    end
    PlayerPrefsSetPersonString("SingleUserFormationInfos", save)
  end
end

_class("Team", Object)
Team = Team

function Team:Constructor()
  self.teamSlotCount = 5
  self.id = 0
  self.name = ""
  self.pets = {}
  self.seasonOnceTeam = Teams:New()
  self.seasonOnceTeamId = 1
end

function Team:Init(id, name, pets)
  self.id = id
  self.name = name
  for i = 1, self.teamSlotCount do
    self.pets[i] = pets[i] or 0
  end
end

function Team:UpdateName(name)
  self.name = name
end

function Team:HasPet()
  for i, v in ipairs(self.pets) do
    if 0 < v then
      return true
    end
  end
end

function Team:Swap(slot1, slot2)
  local tmp = self.pets[slot1]
  self.pets[slot1] = self.pets[slot2]
  self.pets[slot2] = tmp
end

function Team:Clone()
  local team = Team:New()
  team.teamSlotCount = self.teamSlotCount
  team:Init(self.id, self.name, self.pets)
  return team
end

function Team:ClearPet()
  for i = 1, self.teamSlotCount do
    self.pets[i] = 0
  end
end

function Team:Get1stPetId()
  for i, v in ipairs(self.pets) do
    if 0 < v then
      return v
    end
  end
end

function Team:GetLeaderPetId()
  if self.pets then
    return self.pets[FormationPetLeaderSeat.LeaderSeat]
  end
end

function Team:GetID()
  return self.id
end

function Team:GetName()
  return self.name
end

function Team:GetPets()
  return self.pets
end

_class("TeamsTeamId", Object)
TeamsTeamId = TeamsTeamId

function TeamsTeamId:Constructor()
  self.teams = {}
  self.teamId = 1
end

_class("TeamsContext", Object)
TeamsContext = TeamsContext

function TeamsContext:Constructor()
  self.teamOpenerType = TeamOpenerType.Stage
  self.param = 0
  self.teams = Teams:New()
  self.towerTeams = nil
  self.towerTeamCeiling = 0
  self.curTeamId = 1
  self.mazeTeam = Teams:New()
  self.mazeTeamId = 1
  self.trailTeam = Teams:New()
  self.trailTeamId = 1
  self.summerTwoTeam = Teams:New()
  self.summerTwoTeamId = 1
  self.airTeam = Teams:New()
  self.airTeamId = 1
  self.worldBossTeam = Teams:New()
  self.worldBossTeamId = 1
  self.n21CCTeam = Teams:New()
  self.n21CCTeamId = 1
  self.sailingTeam = Teams:New()
  self.sailingTeamId = 1
  self.vampireTeam = Teams:New()
  self.vampireTeamId = 1
  self.curSlot = 0
  self.fastSelect = false
  self.tmpTeam = nil
  self.diffTeam = Teams:New()
  self.diffTeamId = 1
  self.campDiffTeam = Teams:New()
  self.campDiffTeamId = 1
  self.eightPetsTeam = Teams:New()
  self.eightPetsTeamId = 1
  self.seasonTeam = Teams:New()
  self.seasonTeamId = 1
  self.popStarTeam = Teams:New()
  self.popStarTeamId = 1
  self.aniPopStarTeam = Teams:New()
  self.aniPopStarTeamId = 1
  self.seasonOnceTeam = Teams:New()
  self.seasonOnceTeamId = 1
  self.seasonMazeTeam = Teams:New()
  self.seasonMazeTeamId = 1
  self._isFightAgain = false
end

function TeamsContext:InitByServerData(serverData)
  self.teams:Init(serverData)
end

function TeamsContext:InitTowerTeam(serverData)
  local mapElementPetList = {
    [TowerElementType.TowerElementType_Blue] = serverData.mul_water_pet_lists,
    [TowerElementType.TowerElementType_Red] = serverData.mul_fire_pet_lists,
    [TowerElementType.TowerElementType_Green] = serverData.mul_wood_pet_lists,
    [TowerElementType.TowerElementType_Yellow] = serverData.mul_thunder_pet_lists,
    [TowerElementType.TowerElementType_Difficulty_Blue] = serverData.difficulty_mul_water_pet_lists,
    [TowerElementType.TowerElementType_Difficulty_Red] = serverData.difficulty_mul_fire_pet_lists,
    [TowerElementType.TowerElementType_Difficulty_Green] = serverData.difficulty_mul_wood_pet_lists,
    [TowerElementType.TowerElementType_Difficulty_Yellow] = serverData.difficulty_mul_thunder_pet_lists
  }
  local len = table.count(mapElementPetList)
  if self.towerTeams and table.count(self.towerTeams) == len then
  else
    self.towerTeams = {}
    for element, formation_info_towers in pairs(mapElementPetList) do
      self.towerTeams[element] = TeamsTeamId:New()
    end
  end
  for element, formation_info_towers in pairs(mapElementPetList) do
    local teams = Teams:New()
    local fis = {}
    for _, formation_info_tower in pairs(formation_info_towers) do
      local fi = formation_info:New()
      fi.id = formation_info_tower.id
      fi.name = formation_info_tower.name
      fi.pet_list = formation_info_tower.pet_list
      table.insert(fis, fi)
    end
    teams:Init(fis)
    self.towerTeams[element].teams = teams
  end
end

function TeamsContext:InitMazeTeam(serverData)
  self.mazeTeam:_InitMazeTeams(serverData.fromation_list)
end

function TeamsContext:InitAirTeam(serverData)
  self.airTeam:_InitAirTeams(serverData.tactic_formation_list)
end

function TeamsContext:InitDiffTeam(serverData)
  self.diffTeam:_InitDiffTeams(serverData)
end

function TeamsContext:InitCampDiffTeam(serverData)
  self.campDiffTeam:_InitCampDiffTeams(serverData)
end

function TeamsContext:InitTrailTeam(serverData)
  self.trailTeam:InitTrailTeams(serverData)
end

function TeamsContext:InitWorldBossTeams(serverData)
  self.worldBossTeam:Init(serverData)
end

function TeamsContext:InitSeasonTeam(serverData)
  self.seasonTeam:_InitSeasonTeams(serverData)
end

function TeamsContext:InitSeasonMazeTeam(serverData)
  self.seasonMazeTeam:_InitSeasonMazeTeams(serverData)
end

function TeamsContext:InitPopStarTeam(serverData)
  self.popStarTeam:_InitPopStarTeams(serverData)
end

function TeamsContext:InitAniPopStarTeam(serverData)
  self.aniPopStarTeam:_InitAniPopStarTeams(serverData)
end

function TeamsContext:InitN21CCTeams(serverData, levelIndex)
  self.n21CCTeamId = levelIndex
  self.n21CCTeam:InitN21CCTeams(serverData, levelIndex)
end

function TeamsContext:InitSailingTeams(serverData)
  self.sailingTeamId = 1
  self.sailingTeam:InitSailingTeams(serverData, self.sailingTeamId)
end

function TeamsContext:InitVampireTeams()
  self.vampireTeamId = 1
  self.vampireTeam:InitVampireTeams()
end

function TeamsContext:InitSeasonOnceTeam(serverData)
  self.seasonOnceTeam:_InitSeasonOnceTeams(serverData)
end

function TeamsContext:Init(teamOpenerType, param)
  self.teamOpenerType = teamOpenerType
  self.param = param
end

function TeamsContext:GetTeamOpenerType()
  return self.teamOpenerType
end

function TeamsContext:CheckTeamOpenerType(openerType)
  return self.teamOpenerType == openerType
end

function TeamsContext:GetParam()
  return self.param
end

function TeamsContext:SetTowerContext(ceiling, element, layerID)
  self.towerTeamCeiling = ceiling
  if 4 < element then
    self.towerElement = element - 4
  else
    self.towerElement = element
  end
  self.towerLayerID = layerID
end

function TeamsContext:GetTowerTeamCeiling()
  return self.towerTeamCeiling
end

function TeamsContext:GetTowerElement()
  return self.towerElement
end

function TeamsContext:GetTowerLayerID()
  return self.towerLayerID
end

function TeamsContext:InitTeamMemberSelect(curSlot)
  self.curSlot = curSlot
  self.fastSelect = false
  if self.teamOpenerType == TeamOpenerType.Tower then
    local teamId = self:GetTowerTeamId(self.towerElement)
    self.tmpTeam = self:GetTowerTeam():Get(teamId)
  elseif self.teamOpenerType == TeamOpenerType.Maze then
    self.tmpTeam = self.mazeTeam:Get(self.mazeTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.Trail then
    self.tmpTeam = self.trailTeam:Get(self.trailTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.Sailing then
    self.tmpTeam = self.sailingTeam:Get(self.sailingTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.Vampire then
    self.tmpTeam = self.vampireTeam:Get(self.vampireTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.WorldBoss then
    self.tmpTeam = self.worldBossTeam:Get(self.worldBossTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.N21CC then
    self.tmpTeam = self.n21CCTeam:Get(self.n21CCTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.Air then
    self.tmpTeam = self.airTeam:Get(self.airTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.Diff then
    self.tmpTeam = self.diffTeam:Get(self.diffTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.Camp_Diff then
    self.tmpTeam = self.campDiffTeam:Get(self.campDiffTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.EightPets then
    self.tmpTeam = self.eightPetsTeam:Get(self.eightPetsTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.Season then
    self.tmpTeam = self.seasonTeam:Get(self.seasonTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.PopStarPro then
    self.tmpTeam = self.popStarTeam:Get(self.popStarTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.AniPopStar then
    self.tmpTeam = self.aniPopStarTeam:Get(self.aniPopStarTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.SeasonOnceMission then
    self.tmpTeam = self.seasonOnceTeam:Get(self.seasonOnceTeamId):Clone()
  elseif self.teamOpenerType == TeamOpenerType.SeasonMaze then
    self.tmpTeam = self.seasonMazeTeam:Get(self.seasonMazeTeamId):Clone()
  else
    local curTeamId = self:GetCurrTeamId()
    self.tmpTeam = self.teams:Get(curTeamId):Clone()
  end
end

function TeamsContext:InitTeamFastSelect()
  self:InitTeamMemberSelect(-1)
  self.fastSelect = true
end

function TeamsContext:IsFastSelect()
  return self.fastSelect
end

function TeamsContext:ClearFastSelect()
  self.fastSelect = false
end

function TeamsContext:Teams()
  if self.teamOpenerType == TeamOpenerType.Tower then
    local now_type = self.towerElement
    if 4 < now_type then
      self.towerElement = self.towerElement - 4
    end
    local teamId = self:GetTowerTeamId(self.towerElement)
    local team = self:GetTowerTeam():Get(teamId)
    local teams = self:RawGetTowerTeam(self.towerElement)
    teams:UpdateTeam(team)
    return teams
  elseif self.teamOpenerType == TeamOpenerType.Maze then
    return self:GetMazeTeam()
  elseif self.teamOpenerType == TeamOpenerType.Air then
    return self.airTeam
  elseif self.teamOpenerType == TeamOpenerType.Trail then
    return self.trailTeam
  elseif self.teamOpenerType == TeamOpenerType.Sailing then
    return self.sailingTeam
  elseif self.teamOpenerType == TeamOpenerType.Vampire then
    return self.vampireTeam
  elseif self.teamOpenerType == TeamOpenerType.WorldBoss then
    return self.worldBossTeam
  elseif self.teamOpenerType == TeamOpenerType.N21CC then
    return self.n21CCTeam
  elseif self.teamOpenerType == TeamOpenerType.Diff then
    return self.diffTeam
  elseif self.teamOpenerType == TeamOpenerType.Camp_Diff then
    return self.campDiffTeam
  elseif self.teamOpenerType == TeamOpenerType.EightPets then
    return self.eightPetsTeam
  elseif self.teamOpenerType == TeamOpenerType.Season then
    return self.seasonTeam
  elseif self.teamOpenerType == TeamOpenerType.PopStarPro then
    return self.popStarTeam
  elseif self.teamOpenerType == TeamOpenerType.AniPopStar then
    return self.aniPopStarTeam
  elseif self.teamOpenerType == TeamOpenerType.SeasonOnceMission then
    return self.seasonOnceTeam
  elseif self.teamOpenerType == TeamOpenerType.SeasonMaze then
    return self.seasonMazeTeam
  else
    return self.teams
  end
end

function TeamsContext:GetTowerTeam()
  local teams = self:RawGetTowerTeam(self.towerElement)
  local clone = Teams:New()
  for id, team in pairs(teams.list) do
    local cTeam = Team:New()
    cTeam.id = team.id
    cTeam.name = team.name
    cTeam.teamSlotCount = team.teamSlotCount
    cTeam.pets = {}
    for i = 1, #team.pets do
      if i > self.towerTeamCeiling then
        cTeam.pets[i] = 0
      else
        cTeam.pets[i] = team.pets[i]
      end
    end
    clone.list[id] = cTeam
  end
  return clone
end

function TeamsContext:RawGetTowerTeam(element)
  local teamsTeamId = self.towerTeams[element]
  local teams = teamsTeamId.teams
  return teams
end

function TeamsContext:GetTowerTeamId(element)
  local teamsTeamId = self.towerTeams[element]
  return teamsTeamId.teamId
end

function TeamsContext:SetTowerTeamId(element, teamId)
  local teamsTeamId = self.towerTeams[element]
  teamsTeamId.teamId = teamId
end

function TeamsContext:GetMazeTeam()
  return self.mazeTeam
end

function TeamsContext:GetAirTeam()
  return self.airTeam
end

function TeamsContext:GetSeasonMazeTeam()
  return self.seasonMazeTeam
end

function TeamsContext:GetCurrTeamId()
  if self.teamOpenerType == TeamOpenerType.Maze then
    return self.mazeTeamId
  elseif self.teamOpenerType == TeamOpenerType.Air then
    return self.airTeamId
  elseif self.teamOpenerType == TeamOpenerType.Tower then
    local teamId = self:GetTowerTeamId(self.towerElement)
    return teamId
  elseif self.teamOpenerType == TeamOpenerType.Trail then
    local key = self:GetCurrTrailTeamIdKey()
    local teamId = UnityEngine.PlayerPrefs.GetInt(key, self.trailTeamId)
    return teamId
  elseif self.teamOpenerType == TeamOpenerType.Sailing then
    return self.sailingTeamId
  elseif self.teamOpenerType == TeamOpenerType.Vampire then
    return self.vampireTeamId
  elseif self.teamOpenerType == TeamOpenerType.WorldBoss then
    return self.worldBossTeamId
  elseif self.teamOpenerType == TeamOpenerType.N21CC then
    return self.n21CCTeamId
  elseif self.teamOpenerType == TeamOpenerType.Diff then
    return self.diffTeamId
  elseif self.teamOpenerType == TeamOpenerType.Camp_Diff then
    return self.campDiffTeamId
  elseif self.teamOpenerType == TeamOpenerType.EightPets then
    return self.eightPetsTeamId
  elseif self.teamOpenerType == TeamOpenerType.Season then
    return self.seasonTeamId
  elseif self.teamOpenerType == TeamOpenerType.PopStarPro then
    return self.popStarTeamId
  elseif self.teamOpenerType == TeamOpenerType.AniPopStar then
    return self.aniPopStarTeamId
  elseif self.teamOpenerType == TeamOpenerType.SeasonOnceMission then
    return self.seasonOnceTeamId
  elseif self.teamOpenerType == TeamOpenerType.SeasonMaze then
    return self.seasonMazeTeamId
  else
    local key = self:GetCurrTeamIdKey()
    local teamId = UnityEngine.PlayerPrefs.GetInt(key, self.curTeamId)
    return teamId
  end
end

function TeamsContext:SetCurrTeamId(teamId)
  if self.teamOpenerType == TeamOpenerType.Maze then
    self.mazeTeamId = teamId
  elseif self.teamOpenerType == TeamOpenerType.Air then
    self.airTeamId = teamId
  elseif self.teamOpenerType == TeamOpenerType.Tower then
    self:SetTowerTeamId(self.towerElement, teamId)
  elseif self.teamOpenerType == TeamOpenerType.WorldBoss then
  elseif self.teamOpenerType == TeamOpenerType.N21CC then
  elseif self.teamOpenerType == TeamOpenerType.Diff then
  elseif self.teamOpenerType == TeamOpenerType.Sailing then
  elseif self.teamOpenerType == TeamOpenerType.Vampire then
  elseif self.teamOpenerType == TeamOpenerType.Trail then
    local key = self:GetCurrTrailTeamIdKey()
    UnityEngine.PlayerPrefs.SetInt(key, teamId)
    self.trailTeamId = teamId
  elseif self.teamOpenerType == TeamOpenerType.Camp_Diff then
  elseif self.teamOpenerType == TeamOpenerType.EightPets then
    self.eightPetsTeamId = teamId
  elseif self.teamOpenerType == TeamOpenerType.Season then
    self.seasonTeamId = teamId
  elseif self.teamOpenerType == TeamOpenerType.PopStarPro then
    self.popStarTeamId = teamId
  elseif self.teamOpenerType == TeamOpenerType.AniPopStar then
    self.aniPopStarTeamId = teamId
  elseif self.teamOpenerType == TeamOpenerType.SeasonOnceMission then
    self.seasonOnceTeamId = teamId
  elseif self.teamOpenerType == TeamOpenerType.SeasonMaze then
    self.seasonMazeTeamId = teamId
  else
    local key = self:GetCurrTeamIdKey()
    UnityEngine.PlayerPrefs.SetInt(key, teamId)
    self.curTeamId = teamId
  end
end

function TeamsContext:GetCurrTeamIdKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "CurrTeamId"
  return key
end

function TeamsContext:GetCurrTrailTeamIdKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "CurrTrailTeamId"
  return key
end

function TeamsContext:GetCurrSummerTwoTeamIdKey()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  local key = pstId .. "CurrSummerTwoTeamId"
  return key
end

function TeamsContext:ShowDialogUITeams(isState, ...)
  local teamsName = "UITeams"
  local stateType = UIStateType.UITeams
  local stageId = 0
  if self.teamOpenerType == TeamOpenerType.Stage then
    stageId = self.param
  elseif self.teamOpenerType == TeamOpenerType.ExtMission then
    stageId = self.param[2]
  elseif self.teamOpenerType == TeamOpenerType.Trail then
    stageId = self.param
  elseif self.teamOpenerType == TeamOpenerType.Sailing then
    stageId = self.param[2]
  elseif self.teamOpenerType == TeamOpenerType.Vampire then
    stageId = self.param[1]
  elseif self.teamOpenerType == TeamOpenerType.Campaign then
    stageId = self.param[1]
  elseif self.teamOpenerType == TeamOpenerType.LostLand then
    stageId = self.param
  elseif self.teamOpenerType == TeamOpenerType.Conquest then
    stageId = self.param[1]
  elseif self.teamOpenerType == TeamOpenerType.WorldBoss then
    stageId = self.param[1]
  elseif self.teamOpenerType == TeamOpenerType.N21CC then
    stageId = self.param[1]
  elseif self.teamOpenerType == TeamOpenerType.Air then
    stageId = self.param[1]
  elseif self.teamOpenerType == TeamOpenerType.Diff then
    stageId = self.param[2]
  elseif self.teamOpenerType == TeamOpenerType.Camp_Diff then
    stageId = self.param[2]
  elseif self.teamOpenerType == TeamOpenerType.Season then
    stageId = self.param[1]
  elseif self.teamOpenerType == TeamOpenerType.PopStarPro then
    stageId = self.param[1]
  elseif self.teamOpenerType == TeamOpenerType.AniPopStar then
    stageId = self.param[1]
  elseif self.teamOpenerType == TeamOpenerType.SeasonOnceMission then
    stageId = self.param[1]
  elseif self.teamOpenerType == TeamOpenerType.SeasonMaze then
    stageId = self.param[1]
    teamsName = "UISeasonMazePetsTeams"
  end
  if DiscoveryStage.IsGuideStageId(stageId) then
    teamsName = "UITeamsGuide"
    stateType = UIStateType.UITeamsGuide
  end
  if isState then
    GameGlobal.UIStateManager():SwitchState(stateType, ...)
  else
    GameGlobal.UIStateManager():ShowDialog(teamsName, ...)
  end
end

function TeamsContext:GetTeamCount()
  local teamCount = 4
  if self.teamOpenerType == TeamOpenerType.WorldBoss or self.teamOpenerType == TeamOpenerType.Diff or self.teamOpenerType == TeamOpenerType.N21CC or self.teamOpenerType == TeamOpenerType.Sailing or self.teamOpenerType == TeamOpenerType.Vampire or self.teamOpenerType == TeamOpenerType.Camp_Diff then
    teamCount = 1
  elseif self.teamOpenerType == TeamOpenerType.Tower or self.teamOpenerType == TeamOpenerType.Trail then
    teamCount = 4
  elseif self.teamOpenerType == TeamOpenerType.Maze or self.teamOpenerType == TeamOpenerType.Air then
    teamCount = 8
  else
    teamCount = Cfg.cfg_global.FormationCount.IntValue
    if teamCount > self.teams:TeamCount() then
      teamCount = self.teams:TeamCount()
    end
  end
  return teamCount
end

function TeamsContext:ReqTowerChangeMulFormationInfo(TT, team)
  local module = GameGlobal.GetModule(TowerModule)
  local nId = self:GetTowerLayerID()
  local reqTeamInfo = each_tower_formation_info:New()
  reqTeamInfo.id = team.id
  reqTeamInfo.name = team.name
  reqTeamInfo.pet_list = team.pets
  local res, data = module:ReqTowerChangeMulFormationInfo(TT, nId, reqTeamInfo)
  return res, data
end

function TeamsContext:SetFightAgain(isFightAgain)
  self._isFightAgain = isFightAgain
end

function TeamsContext:GetFightAgain()
  return self._isFightAgain
end

TeamOpenerType = {
  Main = 0,
  Stage = 1,
  ExtMission = 3,
  SmallMap = 4,
  ResInstance = 5,
  Maze = 6,
  Tower = 7,
  ReFight = 8,
  Trail = 9,
  Campaign = 10,
  LostLand = 11,
  Conquest = 12,
  BlackFist = 13,
  WorldBoss = 14,
  Air = 15,
  Diff = 16,
  N21CC = 17,
  Sailing = 18,
  Vampire = 19,
  Camp_Diff = 20,
  Season = 21,
  PopStarPro = 22,
  SeasonMaze = 23,
  SeasonOnceMission = 100,
  AniPopStar = 997,
  EightPets = 998,
  NONE = 999
}
