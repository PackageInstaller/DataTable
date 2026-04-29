require("ui_teams_cls")

function Teams:InitEightPetsTeams(serverData)
  self.list = {}
  for k, v in pairs(serverData) do
    local team = Team:New()
    team.teamSlotCount = 8
    team:Init(k, v.name, v.pet_list)
    self.list[k] = team
  end
end

function TeamsContext:EightPetsContext()
  if self._eightPetsContext == nil then
    self._eightPetsContext = UIN33EightPetsTeamsContext:New(self)
  end
  return self._eightPetsContext
end

function TeamsContext:ShowDialogUIN33EightPetsTeams(...)
  self:EightPetsContext():InitEightPetsTeamCondition()
  local stateManager = GameGlobal.UIStateManager()
  stateManager:Lock("DoEnterEightPetsTeam")
  stateManager:ShowDialog("UIN33EightPetsTeams", ...)
end

function TeamsContext:HideDialogUIN33EightPetsTeams()
  local stateManager = GameGlobal.UIStateManager()
  stateManager:CloseDialog("UIN33EightPetsTeams")
end

_class("UIN33EightPetsTeamsContext", Object)
UIN33EightPetsTeamsContext = UIN33EightPetsTeamsContext

function UIN33EightPetsTeamsContext:Constructor(teamsContext)
  self._teamsContext = teamsContext
  self._fastTeamPets = {}
  self._fastTeamPetsLookup = {}
  self._andConditions = {}
  self._orConditions = {}
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N33_EIGHT_PETS)
  self._eightComponent = self._localProcess:GetComponent(ECampaignN33EightPetsMissionComponentID.ECAMPAIGN_N33_Eight_Pets_MISSION)
  local componentInfo = self._eightComponent:GetComponentInfo()
  local eightPetsTeam = self._teamsContext.eightPetsTeam
  eightPetsTeam:InitEightPetsTeams(componentInfo.m_formation_info)
end

function UIN33EightPetsTeamsContext:FastTeamPets()
  return self._fastTeamPets
end

function UIN33EightPetsTeamsContext:FastTeamPetsLookup()
  return self._fastTeamPetsLookup
end

function UIN33EightPetsTeamsContext:EightPetsContext()
  local missionModule = GameGlobal.GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  return ctx:EightPetsContext()
end

function UIN33EightPetsTeamsContext:EightPetsFormationItem(teamId)
  local teams = self._teamsContext:Teams()
  local tm = teams:Get(teamId)
  local item = EightPetsFormationItem:New()
  item.name = tm:GetName()
  for k, v in pairs(tm:GetPets()) do
    item.pet_list[k] = v
  end
  return item
end

function UIN33EightPetsTeamsContext:CheckErrorCode(res)
  local componentInfo = self._eightComponent:GetComponentInfo()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  campaignModule:CheckErrorCode(res:GetResult(), componentInfo.m_campaign_id, nil)
end

function UIN33EightPetsTeamsContext:InitEightPetsTeamCondition()
  local context = self:EightPetsContext()
  if self ~= context then
    return context:InitEightPetsTeamCondition()
  end
  self._andConditions = {}
  local param = self._teamsContext:GetParam()
  local eightID = param[4]
  local cfgEight = Cfg.cfg_component_eight_pets_mission[eightID]
  if cfgEight.AndCond == nil then
    return
  end
  local oneLevel = string.split(cfgEight.AndCond, "&")
  for k, v in pairs(oneLevel) do
    local twoLevel = string.split(v, ",")
    for sk, sv in pairs(twoLevel) do
      twoLevel[sk] = tonumber(sv)
    end
    if #twoLevel == 4 and twoLevel[1] == 3901 then
      local testCondition = UIN33EightPetsTeamsProfUpperLimit:New()
      testCondition:SetCondition(twoLevel[3], twoLevel[2])
      table.insert(self._andConditions, testCondition)
    else
      Log.exception("cfg_component_eight_pets_mission.AndCond 八人编队条件未实现 id --> ", eightID, twoLevel[1])
    end
  end
end

function UIN33EightPetsTeamsContext:SetCurrTeamId(teamId)
  local context = self:EightPetsContext()
  if self ~= context then
    return context:SetCurrTeamId(teamId)
  end
  self._teamsContext:SetCurrTeamId(teamId)
  self._eightComponent:SetCurrTeamId(teamId)
  if self._teamsContext:GetTeamOpenerType() == TeamOpenerType.EightPets then
    self._fastTeamPets = {}
    self._fastTeamPetsLookup = {}
    local teams = self._teamsContext:Teams()
    local team = teams:Get(teamId)
    local teamPets = team:GetPets()
    for k, v in pairs(teamPets) do
      self._fastTeamPets[k] = v
      self._fastTeamPetsLookup[v] = v
    end
  end
  for k, v in pairs(self._andConditions) do
    v:ConditionResult()
  end
end

function UIN33EightPetsTeamsContext:UpdateTeam(newTeam)
  local context = self:EightPetsContext()
  if self ~= context then
    return context:UpdateTeam(newTeam)
  end
  local teams = self._teamsContext:Teams()
  teams:UpdateTeam(newTeam)
  for k, v in pairs(self._andConditions) do
    v:ConditionResult()
  end
end

function UIN33EightPetsTeamsContext:UpdateFastTeam(pstidTab)
  local context = self:EightPetsContext()
  if self ~= context then
    return context:UpdateFastTeam(pstidTab)
  end
  local theMaxID = 0
  self._fastTeamPets = {}
  self._fastTeamPetsLookup = {}
  for k, v in pairs(pstidTab) do
    if v.pstid ~= 0 and v.memId ~= nil then
      theMaxID = math.max(theMaxID, v.memId)
      self._fastTeamPets[v.memId] = v.pstid
      self._fastTeamPetsLookup[v.pstid] = v.pstid
    end
  end
  for i = 1, theMaxID do
    if self._fastTeamPets[i] == nil then
      self._fastTeamPets[i] = 0
    end
  end
  for k, v in pairs(self._andConditions) do
    v:ConditionResult()
  end
end

function UIN33EightPetsTeamsContext:TeamConditionTestPet(petPstId, teamSlot)
  local context = self:EightPetsContext()
  if self ~= context then
    return context:TeamConditionTestPet(petPstId, teamSlot)
  end
  for k, v in pairs(self._andConditions) do
    local reason, limit = v:TestPet(petPstId, teamSlot)
    if reason ~= 0 then
      return reason, limit
    end
  end
  return UIN33EightPetsTeamsReason.SUCCESS, 0
end

function UIN33EightPetsTeamsContext:TeamConditionTestBattle()
  local context = self:EightPetsContext()
  return context:TeamConditionTestPet(nil, -1)
end

function UIN33EightPetsTeamsContext:ReNameTT(TT, teamId, newName)
  local context = self:EightPetsContext()
  if self ~= context then
    return context:ReNameTT(TT, teamId, newName)
  end
  local item = self:EightPetsFormationItem(teamId)
  item.name = newName
  local res = AsyncRequestRes:New()
  self._eightComponent:HandleEightPetsChangeFormationReq(TT, res, teamId, item)
  if not res:GetSucc() then
    self:CheckErrorCode(res)
  end
  return res
end

function UIN33EightPetsTeamsContext:UpdateFormationInfoTT(TT, teamId, teamName, pets)
  local context = self:EightPetsContext()
  if self ~= context then
    return context:UpdateFormationInfoTT(TT, teamId, teamName, pets)
  end
  local item = self:EightPetsFormationItem(teamId)
  item.name = teamName
  for k, v in pairs(pets) do
    item.pet_list[k] = v
  end
  local res = AsyncRequestRes:New()
  self._eightComponent:HandleEightPetsChangeFormationReq(TT, res, teamId, item)
  if not res:GetSucc() then
    self:CheckErrorCode(res)
  end
  return res
end
