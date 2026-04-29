require("play_skill_phase_base_r")
_class("PlaySkillScopeForwardNoAttackPhase", PlaySkillPhaseBase)
PlaySkillScopeForwardNoAttackPhase = PlaySkillScopeForwardNoAttackPhase

function PlaySkillScopeForwardNoAttackPhase:PlayFlight(TT, casterEntity, phaseParam)
  local scopeForwardParam = phaseParam
  local gridEffectID = scopeForwardParam:GetGridEffectID()
  local bestEffectTime = scopeForwardParam:GetBestEffectTime()
  local gridIntervalTime = scopeForwardParam:GetGridIntervalTime()
  local hasConvert = scopeForwardParam:HasConvert()
  local effectDirection = scopeForwardParam:GetEffectDirection()
  local castPos = casterEntity:GridLocation().Position
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local convertResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ConvertGridElement)
  local targetGridType = convertResult:GetTargetElementType()
  local gridDataArray = convertResult:GetTargetGridArray()
  local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
  local pickUpGridPos = pickUpGridArray[1]
  local targetGirdList, f, maxGridCount = InnerGameSortGridHelperRender:SortGridWithCenterPos(gridDataArray, pickUpGridPos)
  local pieceService = self._world:GetService("Piece")
  local tConvertInfo = {}
  local tnConvertTaskID = {}
  local tidHitTask = {}
  for i = 1, maxGridCount do
    for dir = 1, 9 do
      local t = targetGirdList[dir]
      local gridIndex = i
      if 0 < gridIndex and gridIndex <= #t.gridList then
        local gridPos = t.gridList[gridIndex]
        local oldGridType = PieceType.None
        local gridEntity = pieceService:FindPieceEntity(gridPos)
        local pieceCmpt = gridEntity:Piece()
        oldGridType = pieceCmpt:GetPieceType()
        local convertInfo = NTGridConvert_ConvertInfo:New(gridPos, oldGridType, targetGridType)
        table.insert(tConvertInfo, convertInfo)
        local tid = GameGlobal.TaskManager():CoreGameStartTask(self:SkillService()._SingleGridEffect, self:SkillService(), gridEffectID, gridPos, bestEffectTime, targetGridType)
        table.insert(tnConvertTaskID, tid)
      end
    end
    if i ~= maxGridCount then
      YIELD(TT, gridIntervalTime)
    end
  end
  local finishDelayTime = scopeForwardParam:GetFinishDelayTime()
  YIELD(TT, finishDelayTime)
  local playSkillService = self._world:GetService("PlaySkill")
  local svcPlayBuff = self._world:GetService("PlayBuff")
  while not TaskHelper:GetInstance():IsAllTaskFinished(tnConvertTaskID) do
    YIELD(TT)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(tidHitTask) do
    YIELD(TT)
  end
  local nt = NTGridConvert:New(casterEntity, tConvertInfo)
  nt:SetConvertEffectType(SkillEffectType.ConvertGridElement)
  svcPlayBuff:PlayBuffView(TT, nt)
end
