require("common_async_base")
_class("Tower_BuildTeam", Common_AsyncBase)
Tower_BuildTeam = Tower_BuildTeam

function Tower_BuildTeam:Constructor(_, teamIndex)
  self._teamIndex = teamIndex or TestConst.MissionTeamIndex
end

local elementTypeMap = {
  [ElementType.ElementType_Blue] = PieceType.Blue,
  [ElementType.ElementType_Red] = PieceType.Red,
  [ElementType.ElementType_Green] = PieceType.Green,
  [ElementType.ElementType_Yellow] = PieceType.Yellow,
  [5] = PieceType.Blue,
  [6] = PieceType.Red,
  [7] = PieceType.Green,
  [8] = PieceType.Yellow
}

function Tower_BuildTeam:TaskFunc(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
  local petPoolOptions = SmokeTestTeamBuildPoolOptions:New()
  local towerElementType = runData:GetTowerElementType()
  local pieceType = elementTypeMap[towerElementType]
  petPoolOptions:SetForcePetMainElement(pieceType)
  runData:SetPetPoolOptions(petPoolOptions)
  if runData:IsRandomTeam() then
    if not self._manager:BuildRandomTeam(runData, petPoolOptions) then
      self.m_nLogicResult = 2
      return
    end
  else
    self._manager:AsyncBuildTowerTeamByRunData(TT, self._teamIndex, result)
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
  local reqTeamInfo = each_tower_formation_info:New()
  reqTeamInfo.id = 1
  reqTeamInfo.name = "TEST"
  reqTeamInfo.pet_list = petPstIds
  local module = GameGlobal.GetModule(TowerModule)
  for i = 1, 3 do
    local updateFormationResult = module:ReqTowerChangeMulFormationInfo(TT, runData:GetMissionID(), reqTeamInfo)
    if updateFormationResult:GetSucc() then
      result:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      result:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      self.m_nLogicResult = 1
      return
    else
      result:SetCustomData("result", updateFormationResult.m_result)
    end
  end
  result:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  result:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self.m_nLogicResult = 3
end
