require("play_skill_phase_base_r")
_class("PlaySkillConvertElementPhase", PlaySkillPhaseBase)
PlaySkillConvertElementPhase = PlaySkillConvertElementPhase

function PlaySkillConvertElementPhase:PlayFlight(TT, casterEntity, phaseParam)
  local convertElementParam = phaseParam
  local gridEffectID = convertElementParam:GetGridEffectID()
  local bestEffectTime = convertElementParam:GetBestEffectTime()
  local finishDelayTime = convertElementParam:GetFinishDelayTime()
  local notifyPreview = convertElementParam:GetNotifyPreview()
  local convertSource = SkillEffectType.ConvertGridElement
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local convertResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ConvertGridElement)
  if not convertResult then
    convertResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ManualConvert)
    convertSource = SkillEffectType.ManualConvert
  end
  if not convertResult then
    return
  end
  local gridData = convertResult:GetTargetGridArray()
  local targetGridType = convertResult:GetTargetElementType()
  local tConvertInfo = {}
  local pieceService = self._world:GetService("Piece")
  local playSkillService = self._world:GetService("PlaySkill")
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local tnConvertTaskID = {}
  for k, pos in pairs(gridData) do
    local oldGridType = PieceType.None
    local gridEntity = pieceService:FindPieceEntity(pos)
    local pieceCmpt = gridEntity:Piece()
    oldGridType = pieceCmpt:GetPieceType()
    local convertInfo = NTGridConvert_ConvertInfo:New(pos, oldGridType, targetGridType)
    table.insert(tConvertInfo, convertInfo)
    local tid = GameGlobal.TaskManager():CoreGameStartTask(self:SkillService()._SingleGridEffect, self:SkillService(), gridEffectID, pos, bestEffectTime, targetGridType)
    if notifyPreview == 1 then
      env:SetPieceType(pos, targetGridType)
    end
    table.insert(tnConvertTaskID, tid)
  end
  YIELD(TT, finishDelayTime)
  local svcPlayBuff = self._world:GetService("PlayBuff")
  while not TaskHelper:GetInstance():IsAllTaskFinished(tnConvertTaskID) do
    YIELD(TT)
  end
  local nt = NTGridConvert:New(casterEntity, tConvertInfo)
  nt:SetConvertEffectType(convertSource)
  svcPlayBuff:PlayBuffView(TT, nt)
end
