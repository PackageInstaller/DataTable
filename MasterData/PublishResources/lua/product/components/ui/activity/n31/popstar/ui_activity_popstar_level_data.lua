local UIActivityPopStarLevelType = {Normal = 1, Challenge = 2}
_enum("UIActivityPopStarLevelType", UIActivityPopStarLevelType)
_class("UIActivityPopStarLevelTask", Object)
UIActivityPopStarLevelTask = UIActivityPopStarLevelTask

function UIActivityPopStarLevelTask:Constructor(cfg, progress, isComplete)
  self._id = cfg.ID
  self._progress = progress
  self._total = cfg.KillNum
  if self._progress > self._total then
    self._progress = self._total
  end
  self._isComplete = isComplete
  self._rewards = {}
  for i = 1, #cfg.Rewards do
    local reward = {}
    reward[1] = cfg.Rewards[i][1]
    reward[2] = cfg.Rewards[i][2] or 0
    self._rewards[#self._rewards + 1] = reward
  end
end

function UIActivityPopStarLevelTask:GetId()
  return self._id
end

function UIActivityPopStarLevelTask:GetRewards()
  return self._rewards
end

function UIActivityPopStarLevelTask:GetProgress()
  return self._progress
end

function UIActivityPopStarLevelTask:GetTotal()
  return self._total
end

function UIActivityPopStarLevelTask:IsComplete()
  return self._isComplete
end

_class("PopStarSuggestTeamData", Object)
PopStarSuggestTeamData = PopStarSuggestTeamData

function PopStarSuggestTeamData:Constructor(team, teamName)
  self._team = team
  self._name = StringTable.Get(teamName)
end

function PopStarSuggestTeamData:GetName()
  return self._name
end

function PopStarSuggestTeamData:GetTeam()
  return self._team
end

function PopStarSuggestTeamData:IsSame(team)
  if team == nil then
    return false
  end
  local findCount = 0
  for i = 1, #self._team do
    local find = false
    for j = 1, #team do
      if self._team[i] == team[j] then
        find = true
        findCount = findCount + 1
        break
      end
    end
    if find == false then
      return false
    end
  end
  if findCount == #self._team then
    return true
  end
  return false
end

_class("UIActivityPopStarLevelData", Object)
UIActivityPopStarLevelData = UIActivityPopStarLevelData

function UIActivityPopStarLevelData:Constructor(cfg, campaign, component, componentInfo)
  self._campaign = campaign
  self._component = component
  self._componentInfo = componentInfo
  self._missionId = cfg.MissionID
  self.needMissionId = cfg.NeedMissionId
  self._levelType = UIActivityPopStarLevelType.Normal
  if cfg.Type == 2 then
    self._levelType = UIActivityPopStarLevelType.Challenge
  end
  local missionCfg = Cfg.cfg_popstar_mission[self._missionId]
  self._name = StringTable.Get(missionCfg.Name)
  self._des = StringTable.Get(missionCfg.Desc)
  self._levelDetailIcon = missionCfg.DetailIcon
  self._passReward = self:GetRewardsByDropId(missionCfg.FirstDropId)
  self._threeStarReward = self:GetRewardsByDropId(missionCfg.ThreeStarDropId)
  self._bestScore = self._componentInfo.m_max_score
  self._star = 0
  self._isopen = false
  self._isComplete = false
  if self:IsLevePass(self._missionId) then
    local missionInfo = self._componentInfo.m_pass_mission_info[self._missionId]
    if missionInfo.star == 1 then
      self._star = 1
    elseif missionInfo.star == 3 then
      self._star = 2
    elseif missionInfo.star == 7 then
      self._star = 3
    end
    self._isopen = true
    self._isComplete = true
  else
    local needMissionId = cfg.NeedMissionId
    if needMissionId <= 0 or self:IsLevePass(needMissionId) then
      self._isopen = true
    end
  end
  self._team = {}
  for i = 1, 5 do
    self._team[i] = 0
  end
  if cfg.Team then
    for i = 1, #cfg.Team do
      self._team[i] = cfg.Team[i]
    end
  end
  if self._levelType == UIActivityPopStarLevelType.Challenge then
    local petList = self._componentInfo.formation_pet_list
    if petList then
      for i = 1, #petList do
        self._team[i] = petList[i]
      end
    end
  end
  self._suggestTeams = {}
  local suggestTeams = cfg.SuggestTeam
  if suggestTeams then
    for i = 1, #suggestTeams do
      local team = {}
      for j = 1, #suggestTeams[i] do
        team[#team + 1] = suggestTeams[i][j]
      end
      self._suggestTeams[#self._suggestTeams + 1] = PopStarSuggestTeamData:New(team, cfg.SuggestTeamName[i])
    end
  end
  self._tasks = {}
  if self._levelType == UIActivityPopStarLevelType.Challenge then
    local componentConfigId = component:GetComponentCfgId()
    local cfgs = Cfg.cfg_component_popstar_mission_reward({ComponentID = componentConfigId})
    local sortCfgs = {}
    for k, v in pairs(cfgs) do
      sortCfgs[#sortCfgs + 1] = v
    end
    for i = 1, #sortCfgs do
      local cfg = sortCfgs[i]
      local isComplete = self._componentInfo.m_received[cfg.EntiesID] ~= nil
      self._tasks[#self._tasks + 1] = UIActivityPopStarLevelTask:New(cfg, self._bestScore, isComplete)
    end
    table.sort(self._tasks, function(a, b)
      local aComplete = a:IsComplete()
      local bComplete = b:IsComplete()
      if aComplete == bComplete then
        return a:GetId() < b:GetId()
      end
      if not aComplete then
        return true
      end
      return false
    end)
  end
end

function UIActivityPopStarLevelData:IsActivityOpen()
  if not self._campaign:CheckComponentOpen(ECampaignN31CenterComponentID.ECAMPAIGN_N31Center_POPSTAR_MISSION) then
    local result = self._campaign:CheckComponentOpenClientError(ECampaignN31CenterComponentID.ECAMPAIGN_N31Center_POPSTAR_MISSION)
    self._campaign:CheckErrorCode(result, nil, nil)
    GameGlobal.UIStateManager():CloseDialog("UIPopStarTeam")
    GameGlobal.UIStateManager():CloseDialog("UIPopStarChallengeLevelDetail")
    GameGlobal.UIStateManager():CloseDialog("UIPopStarTeamSuggest")
    GameGlobal.UIStateManager():CloseDialog("UIPopStarNormalLevelDetail")
    return false
  end
  return true
end

function UIActivityPopStarLevelData:GetRewardsByDropId(id)
  if not id then
    return {}
  end
  local cfgs = Cfg.cfg_drop({DropID = id})
  local rewards = {}
  for k, v in pairs(cfgs) do
    local reward = {}
    reward[1] = v.AssetID
    reward[2] = v.MaxCount
    rewards[#rewards + 1] = reward
  end
  return rewards
end

function UIActivityPopStarLevelData:IsLevePass(missionId)
  return self._componentInfo.m_pass_mission_info[missionId] ~= nil
end

function UIActivityPopStarLevelData:GetSuggestTeams()
  return self._suggestTeams
end

function UIActivityPopStarLevelData:AddTeamPet(id)
  if id <= 0 then
    return false
  end
  for i = 1, #self._team do
    if 0 >= self._team[i] then
      self._team[i] = id
      return true
    end
  end
  return false
end

function UIActivityPopStarLevelData:RemoveTeamPet(id)
  if id <= 0 then
    return
  end
  for i = 1, #self._team do
    if self._team[i] == id then
      self._team[i] = 0
    end
    if self._team[i] == 0 and i < #self._team then
      self._team[i] = self._team[i + 1]
      self._team[i + 1] = 0
    end
  end
end

function UIActivityPopStarLevelData:TeamHasPet(id)
  if id <= 0 then
    return false
  end
  for i = 1, #self._team do
    if self._team[i] == id then
      return true
    end
  end
  return false
end

function UIActivityPopStarLevelData:GetName()
  return self._name
end

function UIActivityPopStarLevelData:GetDes()
  return self._des
end

function UIActivityPopStarLevelData:GetlevelDetailIcon()
  return self._levelDetailIcon
end

function UIActivityPopStarLevelData:GetStar()
  return self._star
end

function UIActivityPopStarLevelData:IsThreeStarRewardComplete()
  return self._star >= 3
end

function UIActivityPopStarLevelData:IsOpen()
  return self._isopen
end

function UIActivityPopStarLevelData:GetTeam()
  return self._team
end

function UIActivityPopStarLevelData:GetPassReward()
  return self._passReward
end

function UIActivityPopStarLevelData:GetThreeStarReward()
  return self._threeStarReward
end

function UIActivityPopStarLevelData:GetLevelType()
  return self._levelType
end

function UIActivityPopStarLevelData:GetTasks()
  return self._tasks
end

function UIActivityPopStarLevelData:GetBestScore()
  return self._bestScore
end

function UIActivityPopStarLevelData:IsComplete()
  return self._isComplete
end

function UIActivityPopStarLevelData:UpdateTeam(TT)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local team = {}
  for i = 1, #self._team do
    if self._team[i] > 0 then
      team[#team + 1] = self._team[i]
    end
  end
  self._component:HandlePopStarChangeFormation(TT, res, team)
  if res:GetSucc() then
    return true
  end
  return false
end

function UIActivityPopStarLevelData:TeamClone()
  local team = {}
  for i = 1, #self._team do
    team[i] = self._team[i]
  end
  return team
end

function UIActivityPopStarLevelData:UseTeam(team)
  self._team = {}
  for i = 1, 5 do
    self._team[#self._team + 1] = 0
  end
  for i = 1, #team do
    self._team[i] = team[i]
  end
end

function UIActivityPopStarLevelData:EnterBattle(TT)
  local isEmpty = true
  for i = 1, #self._team do
    if self._team[i] > 0 then
      isEmpty = false
      break
    end
  end
  if isEmpty then
    ToastManager.ShowToast(StringTable.Get("str_n31_popstar_tishi_1"))
    return
  end
  local game = GameGlobal.GetModule(GameMatchModule)
  local is_challenge = false
  if self._levelType == UIActivityPopStarLevelType.Challenge then
    is_challenge = true
  end
  local params = {
    self._missionId,
    self._component:GetCampaignMissionComponentId(),
    self._component:GetCampaignMissionParamKeyMap(),
    is_challenge
  }
  local info = game:GetMatchCreateInfo(MatchType.MT_PopStar, params)
  local res = game:StartMatchTask(TT, MatchType.MT_PopStar, 1, info)
  if not res:GetSucc() then
    ToastManager.ShowToast(game:GetErrorMsg(res:GetResult()))
  end
end
