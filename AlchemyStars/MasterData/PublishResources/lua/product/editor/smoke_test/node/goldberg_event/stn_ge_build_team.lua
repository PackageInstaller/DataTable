require("stn_mission_build_team")
_class("GoldbergEvent_BuildTeam", Mission_BuildTeam)
GoldbergEvent_BuildTeam = GoldbergEvent_BuildTeam

function GoldbergEvent_BuildTeam:Constructor(_, teamIndex)
  self._teamIndex = teamIndex or TestConst.MissionTeamIndex
end

function GoldbergEvent_BuildTeam:TaskFunc(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
  local configID = runData:GetComponentConfigID()
  local overrideMode = TestConst.GoldbergEventBuildTeamModeOverride[configID]
  if not overrideMode then
    GoldbergEvent_BuildTeam.super.TaskFunc(self, TT, result)
    return
  end
  if overrideMode == 1 then
    local campaignID = 1066
    local cfg_campaign = Cfg.cfg_campaign[campaignID]
    cfg_campaign.BeginTime = "2022-08-17 04:00:00"
    while GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.UIMain do
      YIELD(TT, 100)
    end
    self:BuildTeamN21(TT, result)
  elseif overrideMode == 2 then
    local campaignID = 5020
    local cfg_campaign = Cfg.cfg_campaign[campaignID]
    cfg_campaign.BeginTime = "2022-08-17 04:00:00"
    while GameGlobal.UIStateManager():CurUIStateType() ~= UIStateType.UIMain do
      YIELD(TT, 100)
    end
    self:BuildTeamCN4CC(TT, result)
  end
end

function GoldbergEvent_BuildTeam:BuildTeamN21(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
  local petPoolOptions = SmokeTestTeamBuildPoolOptions:New()
  if runData:IsRandomTeam() then
    if not self._manager:BuildRandomTeam(runData, petPoolOptions) then
      self.m_nLogicResult = 2
      return
    end
  else
    self._manager:AsyncBuildTeamByRunData(TT, self._teamIndex, result)
    if result:IsErrorOccured() then
      self.m_nLogicResult = 3
      return
    else
      self.m_nLogicResult = 1
      return
    end
  end
  local currentTeamPetBuildData = runData:GetCurrentTeamBuild()
  self._manager:PreparePetsByBuildDataList(TT, currentTeamPetBuildData, result)
  if result:IsErrorOccured() then
    self.m_nLogicResult = 3
    return
  end
  local petPstIds = runData:GeneratePetPstID()
  local missionModule = GameGlobal.GetModule(MissionModule)
  for i = 1, 3 do
    local updateFormationResult = UIActivityN21CCConst.SaveTeamInfo(TT, 1, "", petPstIds)
    if updateFormationResult then
      result:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      result:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      self.m_nLogicResult = 1
      return
    else
      result:SetCustomData("result", false)
    end
  end
  result:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  result:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self.m_nLogicResult = 3
  Log.exception(self._className, "UIActivityN21CCConst.SaveTeamInfo failed, result: ", tostring(result:GetCustomData("result")))
end

function GoldbergEvent_BuildTeam:BuildTeamCN4CC(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
  local petPoolOptions = SmokeTestTeamBuildPoolOptions:New()
  if runData:IsRandomTeam() then
    if not self._manager:BuildRandomTeam(runData, petPoolOptions) then
      self.m_nLogicResult = 2
      return
    end
  else
    self._manager:AsyncBuildTeamByRunData(TT, self._teamIndex, result)
    if result:IsErrorOccured() then
      self.m_nLogicResult = 3
      return
    else
      self.m_nLogicResult = 1
      return
    end
  end
  local currentTeamPetBuildData = runData:GetCurrentTeamBuild()
  self._manager:PreparePetsByBuildDataList(TT, currentTeamPetBuildData, result)
  if result:IsErrorOccured() then
    self.m_nLogicResult = 3
    return
  end
  local petPstIds = runData:GeneratePetPstID()
  local missionModule = GameGlobal.GetModule(MissionModule)
  for i = 1, 3 do
    local updateFormationResult = UIActivityN4CCHelper.SaveTeamInfo(TT, 1, "", petPstIds)
    if updateFormationResult then
      result:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      result:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      self.m_nLogicResult = 1
      return
    else
      result:SetCustomData("result", false)
    end
  end
  result:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  result:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self.m_nLogicResult = 3
  Log.exception(self._className, "UIActivityN4CCHelper.SaveTeamInfo failed, result: ", tostring(result:GetCustomData("result")))
end
