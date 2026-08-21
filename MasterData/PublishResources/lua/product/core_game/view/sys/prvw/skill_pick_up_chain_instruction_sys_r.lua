_class("SkillPickUpChainInstructionSystem_Render", ReactiveSystem)
SkillPickUpChainInstructionSystem_Render = SkillPickUpChainInstructionSystem_Render

function SkillPickUpChainInstructionSystem_Render:Constructor(world)
  self._world = world
end

function SkillPickUpChainInstructionSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpChainInstructionSystem_Render:Filter(entity)
  local previewEntity = self._world:GetPreviewEntity()
  if not previewEntity then
    return false
  end
  local prvwCmpt = previewEntity:PreviewChainSkill()
  local enablePickUp = prvwCmpt:GetPickUpTargetEnalbe()
  if not enablePickUp then
    return false
  end
  local cPickUpTarget = entity:PickUpTarget()
  local skillHandleType = cPickUpTarget:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.ChainInstruction then
    return true
  end
  return false
end

function SkillPickUpChainInstructionSystem_Render:ExecuteEntities(entities)
  local sPreviewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local sPreviewSkill = self._world:GetService("PreviewActiveSkill")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configService = self._world:GetService("Config")
  local pieceService = self._world:GetService("Piece")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local posPickUpSafe = pickUpTargetCmpt:GetCurPickUpGridSafePos()
  if posPickUpSafe then
    local isValid, isGuide = self._world:GetService("Guide"):IsValidGuidePiecePos(posPickUpSafe.x, posPickUpSafe.y)
    if not isValid then
      posPickUpSafe = nil
    elseif isGuide then
      self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
    end
  end
  if posPickUpSafe then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveUIPreviewChainBtnOK, true)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveUIPreviewChainBtnOK, false)
    return
  end
  local teamEntity = self._world:Player():GetPreviewTeamEntity()
  local casterEntity = teamEntity:GetTeamLeaderPetEntity()
  GameGlobal.TaskManager():CoreGameStartTask(self.PlayLeaderPreview, self, casterEntity, posPickUpSafe)
  local petIds, skillIds = sPreviewSkill:GetChianAttackPetIds()
  if petIds and table.count(petIds) > 0 then
    local previewEntity = self._world:GetPreviewEntity()
    previewEntity:ReplacePreviewChainSkill(petIds, skillIds, posPickUpSafe, true)
  end
end

function SkillPickUpChainInstructionSystem_Render:PlayLeaderPreview(TT, casterEntity, posPickUpSafe)
  local sPreviewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local sPreviewSkill = self._world:GetService("PreviewActiveSkill")
  sPreviewSkill:StopPreviewChainSkill(TT)
  local skillPreviewParamInstruction = SkillPreviewParamInstruction:New({})
  local instructionSet = skillPreviewParamInstruction:_ParseInstructionSet(BattleConst.DimensionPreviewInstructionSetId)
  if instructionSet then
    local previewContext = SkillPreviewContext:New(self._world, casterEntity)
    previewContext:SetPickUpPos(posPickUpSafe)
    sPreviewActiveSkill:DoPreviewInstruction(TT, instructionSet, casterEntity, previewContext)
  end
end
