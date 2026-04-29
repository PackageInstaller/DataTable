require("wait_input_chain_system")
_class("ClientWaitInputChainSystem_Render", WaitInputChainSystem)
ClientWaitInputChainSystem_Render = ClientWaitInputChainSystem_Render

function ClientWaitInputChainSystem_Render:_DoRenderPieceAnimation(TT)
  local piece_service = self._world:GetService("Piece")
  if piece_service then
    piece_service:RefreshPieceAnim()
    piece_service:RefreshMonsterAreaOutLine(TT)
  end
end

function ClientWaitInputChainSystem_Render:_ShowUI(TT)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideUIPreviewChain, true)
end

function ClientWaitInputChainSystem_Render:_PlayPreview(TT, teamEntity)
  local sPreviewSkill = self._world:GetService("PreviewActiveSkill")
  local sPreviewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  sPreviewSkill:StartPreviewFocusEffect()
  local casterEntity = teamEntity:GetTeamLeaderPetEntity()
  local skillPreviewParamInstruction = SkillPreviewParamInstruction:New({})
  local instructionSet = skillPreviewParamInstruction:_ParseInstructionSet(BattleConst.DimensionPreviewInstructionSetIdPrepare)
  if instructionSet then
    local previewContext = SkillPreviewContext:New(self._world, casterEntity)
    local scopeParam = SkillPreviewScopeParam:New({
      TargetType = SkillTargetType.Monster,
      ScopeType = SkillScopeType.FullScreen,
      ScopeCenterType = SkillScopeCenterType.CasterPos,
      OnlyCanMove = false
    })
    scopeParam:SetScopeParamData(0)
    local scopeResult = utilScopeSvc:CalcScopeResult(scopeParam, casterEntity)
    previewContext:SetScopeResult(scopeResult:GetAttackRange())
    local targetIDList = utilScopeSvc:SelectSkillTarget(casterEntity, SkillTargetType.Monster, scopeResult)
    previewContext:SetTargetEntityIDList(targetIDList)
    sPreviewActiveSkill:DoPreviewInstruction(TT, instructionSet, casterEntity, previewContext)
    Log.debug(self._className, "instruction set fin: BattleConst.DimensionPreviewInstructionSetIdPrepare == ", BattleConst.DimensionPreviewInstructionSetIdPrepare)
  else
    Log.error(self._className, "Cannot parse instruction set: BattleConst.DimensionPreviewInstructionSetIdPrepare == ", BattleConst.DimensionPreviewInstructionSetIdPrepare)
  end
end

function ClientWaitInputChainSystem_Render:_DoRenderBeforePickUp()
  local previewEntity = self._world:GetPreviewEntity()
  local prvwCmpt = previewEntity:PreviewChainSkill()
  prvwCmpt:SetPickUpTargetEnalbe(true)
end
