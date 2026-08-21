require("common_async_base")
_class("Tale_BuildTeam", Common_AsyncBase)
Tale_BuildTeam = Tale_BuildTeam

function Tale_BuildTeam:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local petPoolOptions = SmokeTestTeamBuildPoolOptions:New()
  if runData:IsRandomTeam() then
    local isTeamBuilt = self._manager:BuildRandomTeam(runData, petPoolOptions)
    if not isTeamBuilt then
      self.m_nLogicResult = 2
      return
    end
  end
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  for _, petData in ipairs(runData:GetCurrentTeamBuild()) do
    local cmdAddPet = string.format("add_asset %s %d 1", LocalDB.GetString("OpenIdTest"), petData:GetTemplateID())
    self:Log(self, "GMCommand: ", cmdAddPet)
    local addPetResult = gmproxy:SendCmdTask(TT, cmdAddPet)
    if addPetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      self.m_nLogicResult = 3
      return
    end
    local cmdChangePet = petData:GenerateGMCommand()
    self:Log(self, "GMCommand: ", cmdChangePet)
    local changePetResult = gmproxy:SendCmdTask(TT, cmdChangePet)
    if changePetResult.m_call_err ~= CallResultType.Normal then
      Log.exception(self._className, "GM command failed: ", cmdAddPet)
      self.m_nLogicResult = 3
      return
    end
  end
  local petPstIDs = runData:GeneratePetPstID()
  local talePetModule = GameGlobal.GetModule(TalePetModule)
  local res = talePetModule:UpdateMainFormationInfo(TT, TestConst.MissionTeamIndex, TestConst.MissionTeamName, petPstIDs)
  if not res:GetSucc() then
    Log.exception(self._className, "update team formation failed. ")
    self.m_nLogicResult = 3
    return
  end
  self.m_nLogicResult = 1
end
