require("common_async_base")
_class("Cartridge_BuildTeam", Common_AsyncBase)
Cartridge_BuildTeam = Cartridge_BuildTeam

function Cartridge_BuildTeam:Constructor(_, teamIndex)
  self._teamIndex = teamIndex or TestConst.MissionTeamIndex
end

function Cartridge_BuildTeam:TaskFunc(TT, result)
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
  if runData:GetExperienceVersion() == 2 then
    local petPstIDs = runData:GeneratePetPstID()
    local missionModule = GameGlobal.GetModule(MissionModule)
    missionModule:UpdateMainFormationInfo(TT, TestConst.MissionTeamIndex, TestConst.MissionTeamName, petPstIDs)
  else
    self._manager:AsyncGM_UnlockAllRoom(TT, result)
    local petPstIDs = runData:GeneratePetPstID()
    local aircraftModule = GameGlobal.GetModule(AircraftModule)
    local res, reply = aircraftModule:RequestChangeTacticFormationInfo(TT, TestConst.MissionTeamIndex, TestConst.MissionTeamName, petPstIDs)
    if not res:GetSucc() then
      Log.exception("aircraftModule:RequestChangeTacticFormationInfo failed: ", reply.ret)
      return
    end
  end
  self.m_nLogicResult = 1
end
