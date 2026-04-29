require("play_skill_phase_base_r")
_class("PlaySkillTrainResetElementPhase", PlaySkillPhaseBase)
PlaySkillTrainResetElementPhase = PlaySkillTrainResetElementPhase

function PlaySkillTrainResetElementPhase:PlayFlight(TT, casterEntity, phaseParam)
  local effectParam = phaseParam
  local gridEffectID = effectParam:GetGridEffectID()
  local bestEffectTime = effectParam:GetBestEffectTime()
  local gridIntervalTime = effectParam:GetGridIntervalTime()
  local trapServiceRender = self._world:GetService("TrapRender")
  local castPos = casterEntity:GridLocation().Position
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resetResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ResetGridElement)
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  local resetDataArray = resetResult:GetResetGridData()
  local directType = renderPickUpComponent:GetLastPickUpDirection()
  local gridPosList = self:_SortGridByDirection(resetDataArray, directType)
  local beginIndex, endIndex, step = self:_GetStepAndBegin(directType)
  local tConvertInfo = {}
  local pieceService = self._world:GetService("Piece")
  local svcPlayBuff = self._world:GetService("PlayBuff")
  local svcPlaySkill = self._world:GetService("PlaySkill")
  for index = beginIndex, endIndex, step do
    local dataList = gridPosList[index]
    if dataList then
      for _, data in pairs(dataList) do
        local pos = {
          x = data.m_nX,
          y = data.m_nY
        }
        local nOldGridType = PieceType.None
        local gridEntity = pieceService:FindPieceEntity(pos)
        local pieceCmpt = gridEntity:Piece()
        nOldGridType = pieceCmpt:GetPieceType()
        local pos = Vector2.New(data.m_nX, data.m_nY)
        local targetGridType = data.m_nNewElementType
        GameGlobal.TaskManager():CoreGameStartTask(self:SkillService()._SingleGridEffect, self:SkillService(), gridEffectID, pos, bestEffectTime, targetGridType)
        local flushTraps = resetResult:GetFlushTrapsAt(pos)
        for _, trap in ipairs(flushTraps) do
          trapServiceRender:DestroyTrap(TT, trap)
        end
        local convertInfo = NTGridConvert_ConvertInfo:New(pos, nOldGridType, targetGridType)
        table.insert(tConvertInfo, convertInfo)
      end
    end
    if index ~= endIndex then
      YIELD(TT, gridIntervalTime)
    end
  end
  if 0 < #tConvertInfo then
    local notify = NTGridConvert:New(casterEntity, tConvertInfo)
    notify:SetConvertEffectType(SkillEffectType.ResetGridElement)
    notify.__attackPosMatchRequired = true
    svcPlayBuff:PlayBuffView(TT, notify)
  end
  local finishDelayTime = effectParam:GetFinishDelayTime()
  YIELD(TT, finishDelayTime)
end

function PlaySkillTrainResetElementPhase:_SortGridByDirection(resetGridArray, directionType)
  local girdList = {}
  if directionType == HitBackDirectionType.Up or directionType == HitBackDirectionType.Down then
    for _, data in pairs(resetGridArray) do
      local posY = data.m_nY
      if not girdList[posY] then
        girdList[posY] = {}
      end
      table.insert(girdList[posY], data)
    end
  elseif directionType == HitBackDirectionType.Left or directionType == HitBackDirectionType.Right then
    for _, data in pairs(resetGridArray) do
      local posX = data.m_nX
      if not girdList[posX] then
        girdList[posX] = {}
      end
      table.insert(girdList[posX], data)
    end
  end
  return girdList
end

function PlaySkillTrainResetElementPhase:_GetStepAndBegin(directionType)
  local utilData = self._world:GetService("UtilData")
  local maxLen = utilData:GetCurBoardMaxLen()
  if directionType == HitBackDirectionType.Down or directionType == HitBackDirectionType.Left then
    return maxLen, 1, -1
  elseif directionType == HitBackDirectionType.Up or directionType == HitBackDirectionType.Right then
    return 1, maxLen + 1, 1
  end
end
