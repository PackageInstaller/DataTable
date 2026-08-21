require("persona_skill_system")
_class("ClientPersonaSkillSystem_Render", PersonaSkillSystem)
ClientPersonaSkillSystem_Render = ClientPersonaSkillSystem_Render

function ClientPersonaSkillSystem_Render:_DoRenderPreFeatureSkillStart(TT)
  self._world:MainCamera():EnableEffectCamera(true)
  local playSkillService = self._world:GetService("PlaySkill")
  playSkillService:ResetWaitFreeList()
end

function ClientPersonaSkillSystem_Render:_DoRenderNotifyFeatureSkillStart(TT, teamEntity, casterEntity)
end

function ClientPersonaSkillSystem_Render:_DoRenderWaitPlaySkillTaskFinish(TT)
  local playSkillService = self._world:GetService("PlaySkill")
  local listWaitTask = playSkillService:GetWaitFreeList()
  self:_WaitTasksEnd(TT, listWaitTask)
end

function ClientPersonaSkillSystem_Render:_DoRenderWaitTeleportFinish(TT, listTrapTrigger, teamEntity, casterEntity)
  local sPlaySkillInstruction = self._world:GetService("PlaySkillInstruction")
  local listTrapTask = sPlaySkillInstruction:PlayTrapTrigger(TT, teamEntity, listTrapTrigger)
  self:_WaitTasksEnd(TT, listTrapTask)
end

function ClientPersonaSkillSystem_Render:_DoRenderResetPieceAnim(TT, teamEntity, casterEntity)
  local pieceService = self._world:GetService("Piece")
  pieceService:RefreshPieceAnim()
  pieceService:RefreshMonsterAreaOutLine(TT)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ResetGridElement)
  local playBuffService = self._world:GetService("PlayBuff")
  if result then
    local array = result:GetResetGridData()
    playBuffService:PlayBuffView(TT, NTResetGridElement:New(array, casterEntity))
    playBuffService:PlayBuffView(TT, NTResetGridFlushTrap:New())
  end
end

function ClientPersonaSkillSystem_Render:_DoRenderResetPreview(TT, teamEntity, casterEntity)
  local previewConvertElementCmpt = casterEntity:PreviewConvertElement()
  if previewConvertElementCmpt ~= nil then
    previewConvertElementCmpt:SetTempConvertElementDic({})
  else
    Log.notice("Clear Convert Element no cmpt")
  end
end

function ClientPersonaSkillSystem_Render:_DoRenderNotifyFeatureSkillFinish(TT, teamEntity, casterEntity, featureType, skillID)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTFeatureSkillAttackEnd:New(featureType, skillID))
end

function ClientPersonaSkillSystem_Render:_DoRenderShowAfterFeatureSkill(TT, teamEntity, casterEntity)
  local playSkillService = self._world:GetService("PlaySkill")
  playSkillService:ShowPlayerEntity(teamEntity)
  self._world:MainCamera():EnableEffectCamera(false)
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  previewActiveSkillService:StopDarkScreenImmediately()
end

function ClientPersonaSkillSystem_Render:_DoRenderPlayFeatureSkill(isFinalAttack, teamEntity, casterEntity)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local result = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.FeatureAttack)
  local skillResult = result:GetSkillResult()
  local skillID = result:GetL2RFeatureAttackResult_SkillID()
  local playSkillService = self._world:GetService("PlaySkill")
  local configService = self._world:GetService("Config")
  local skinId = 1
  local skillConfigData = configService:GetSkillConfigData(skillID, casterEntity)
  local skillPhaseArray = skillConfigData:GetSkillPhaseArray(skinId)
  casterEntity:SkillRoutine():ClearSkillRoutine()
  casterEntity:SkillRoutine():SetResultContainer(skillResult)
  self:_CheckFreezeTime(casterEntity, isFinalAttack)
  local waitTaskID = playSkillService:StartSkillRoutine(casterEntity, skillPhaseArray, skillID)
  return waitTaskID
end

function ClientPersonaSkillSystem_Render:_CheckFreezeTime(casterEntity, isFinalAttack)
  if not isFinalAttack then
    return
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local targetIDArray = scopeResult:GetTargetIDs()
  if table.count(targetIDArray) <= 0 then
    return
  end
  skillEffectResultContainer:SetFinalAttack(true)
end

function ClientPersonaSkillSystem_Render:_DoRenderMonsterDead(TT, teamEntity, casterEntity)
  local sMonsterShowRender = self._world:GetService("MonsterShowRender")
  sMonsterShowRender:DoAllMonsterDeadRender(TT)
end

function ClientPersonaSkillSystem_Render:_DoRenderResetPickUp()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  pickUpTargetCmpt:Reset()
end

function ClientPersonaSkillSystem_Render:_DoRenderFeatureSkillEnd(TT, teamEntity, casterEntity)
  if casterEntity then
    casterEntity:RemoveRenderPickUpComponent()
  end
end
