require("common_async_base")
_class("Cartridge_EnterBattle", Common_AsyncBase)
Cartridge_EnterBattle = Cartridge_EnterBattle

function Cartridge_EnterBattle:TaskFunc(TT, status)
  local runData = self._manager:GetMissionRunData()
  if runData:GetExperienceVersion() == 2 then
    self:N8TaskFunc(TT, status)
  else
    self:AircraftTaskFunc(TT, status)
  end
end

function Cartridge_EnterBattle:AircraftTaskFunc(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  self._manager:AsyncGM_TacticIgnoreFightLimit(TT, status)
  if status:IsErrorOccured() then
    return
  end
  local runData = self.m_pManager:GetMissionRunData()
  local cartridgeID = runData:GetCartridgeID()
  local addCartridgeResult = AsyncOperationStatusData:New()
  self._manager:AsyncGM_AddAsset(TT, addCartridgeResult, cartridgeID, 1)
  if addCartridgeResult:IsFinished() and addCartridgeResult:IsErrorOccured() then
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local items = itemModule:GetItemByTempId(cartridgeID)
  local luckyItem
  for k, v in pairs(items) do
    luckyItem = v
    break
  end
  if not luckyItem then
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  local aircraftModule = GameGlobal.GetModule(AircraftModule)
  local cartridgeStageIndex = runData:GetCartridgeStageIndex()
  local cartridgePstID = luckyItem:GetID()
  local matchComID, paramKetMap = aircraftModule:GetCartridgeMatchParam(cartridgeStageIndex, cartridgePstID)
  local param = {
    runData:GetMissionID(),
    matchComID,
    paramKetMap
  }
  local matchType = MatchType.MT_Campaign
  if matchComID == ECampaignMissionComponentId.ECampaignMissionComponentId_AircraftBlackfist then
    matchType = MatchType.MT_BlackFist
  end
  local game = GameGlobal.GetModule(GameMatchModule)
  local createInfo = game:GetMatchCreateInfo(matchType, param)
  for i = 1, 3 do
    local res = game:StartMatchTask(TT, matchType, TestConst.MissionTeamIndex, createInfo)
    if res:GetSucc() then
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      return
    end
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self._manager:Exception_DeclareExceptionThrew("对局创建失败")
end

function Cartridge_EnterBattle:N8TaskFunc(TT, status)
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.IN_PROGRESS)
  local runData = self.m_pManager:GetMissionRunData()
  local cartridgeID = runData:GetCartridgeID()
  local addCartridgeResult = AsyncOperationStatusData:New()
  self._manager:AsyncGM_AddAsset(TT, addCartridgeResult, cartridgeID, 1)
  if addCartridgeResult:IsFinished() and addCartridgeResult:IsErrorOccured() then
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  local items = itemModule:GetItemByTempId(cartridgeID)
  local luckyItem
  for k, v in pairs(items) do
    luckyItem = v
    break
  end
  if not luckyItem then
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  local aircraftModule = GameGlobal.GetModule(AircraftModule)
  local cartridgeStageIndex = runData:GetCartridgeStageIndex()
  local cartridgePstID = luckyItem:GetID()
  local matchComID, paramKetMap = aircraftModule:GetCartridgeMatchParam(cartridgeStageIndex, cartridgePstID)
  local matchType = MatchType.MT_Campaign
  if matchComID == ECampaignMissionComponentId.ECampaignMissionComponentId_SimulatorBlackfist then
    matchType = MatchType.MT_BlackFist
  end
  local param = {
    runData:GetMissionID(),
    matchComID,
    {
      [ECampaignMissionParamKey.ECampaignMissionParamKey_ComCfgId] = runData:GetN8ComponentID(),
      [ECampaignMissionParamKey.ECampaignMissionParamKey_CSHardId] = runData:GetCartridgeStageIndex(),
      [ECampaignMissionParamKey.ECampaignMissionParamKey_CartridgePstId] = cartridgePstID
    }
  }
  local game = GameGlobal.GetModule(GameMatchModule)
  local createInfo = game:GetMatchCreateInfo(matchType, param)
  for i = 1, 3 do
    local res = game:StartMatchTask(TT, matchType, TestConst.MissionTeamIndex, createInfo)
    if res:GetSucc() then
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      return
    end
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self._manager:Exception_DeclareExceptionThrew("对局创建失败")
end
