require("logic_entity_config")
require("render_entity_config")
_class("EntityAssembler", Object)
EntityAssembler = EntityAssembler

function EntityAssembler.AssembleEntityComponents(entity, init_data)
  if type(init_data) ~= "table" then
    local entity_context = EntityCreationContext:New()
    entity_context.entity_config_id = init_data
    EntityAssembler.AssembleEntityComponentsByContext(entity, entity_context)
  else
    EntityAssembler.AssembleEntityComponentsByContext(entity, init_data)
  end
end

function EntityAssembler.AssembleEntityComponentsByContext(entity, entity_context)
  local entity_config
  if entity_context.entity_config_id == 0 then
    entity_config = entity_context.entity_config
  else
    entity_config = LogicEntityConfig[entity_context.entity_config_id]
    if entity_config == nil then
      entity_config = RenderEntityConfig[entity_context.entity_config_id]
    end
  end
  if not entity_config then
    Log.fatal("AssembleEntityComponentsByContext can't find configy id=" .. entity_context.entity_config_id)
    return
  end
  local world = entity:GetOwnerWorld()
  local runPosition = world:GetRunningPosition()
  for k, v in pairs(entity_config.EntityConfigComponents) do
    local funtionName = "Init" .. k .. "Component"
    local cmptName = k .. "Component"
    if not EntityAssembler[funtionName] then
      Log.fatal("AssembleEntityComponentsByContext " .. k .. " missing Init" .. k .. "Component func")
    elseif ComponentFilter:CheckComponent(cmptName, runPosition) then
      EntityAssembler[funtionName](entity, v, entity_context)
    end
  end
end

function EntityAssembler.InitLinkRendererDataComponent(entity, config_data, entity_context)
  entity:AddLinkRendererData()
end

function EntityAssembler.InitBoardComponent(entity, config_data, entity_context)
  entity:AddBoard(nil)
end

function EntityAssembler.InitSkillRangeOutlineComponent(entity, config_data, entity_context)
  entity:AddSkillRangeOutline()
end

function EntityAssembler.InitAssetComponent(entity, config_data, entity_context)
  local asset_type_class = Classes[config_data.AssetType]
  local asset_detail = asset_type_class:New(config_data.ResPath, entity_context.bShow)
  if config_data.ResPath and config_data.ResPath ~= "" then
    entity:ReplaceAsset(asset_detail)
  else
    entity:AddAsset(asset_detail)
  end
end

function EntityAssembler.InitAbilityComponent(entity, config_data, entity_context)
  for i = 1, #config_data do
    local ability_class = Classes[config_data[i].AbilityType]
    local ability = ability_class:New()
    entity:AddAbility(ability)
  end
end

function EntityAssembler.InitAttributesComponent(entity, config_data, entity_context)
  entity:AddAttributes()
  local attributes_cmpt = entity:Attributes()
  for i = 1, #config_data do
    local attribute = config_data[i]
    local modifier = Classes[attribute.AttrModifyType]:New(attribute.DefaultValue)
    attributes_cmpt:SetAttribute(attribute.AttributeName, modifier)
  end
end

function EntityAssembler.InitRenderAttributesComponent(entity, config_data, entity_context)
  entity:AddRenderAttributes()
end

function EntityAssembler.InitCommandReceiverComponent(entity, config_data, entity_context)
  local dispatcher_class = Classes[config_data.DispatcherType]
  local dispatcher = dispatcher_class:New(entity._world)
  entity:AddCommandReceiver(dispatcher)
end

function EntityAssembler.InitCommandSenderComponent(entity, config_data, entity_context)
  local prehandler_class = Classes[config_data.PreHandlerType]
  local preHandler = prehandler_class:New()
  entity:AddCommandSender(preHandler)
end

function EntityAssembler.InitSpawnComponent(entity, config_data, entity_context)
  local spawn_class = Classes[config_data.SpawnRuleType]
  local spawn_rule = spawn_class:New()
  entity:AddSpawn(spawn_rule)
end

function EntityAssembler.InitViewComponent(entity, config_data, entity_context)
end

function EntityAssembler.InitLocationComponent(entity, config_data, entity_context)
  local pos = config_data.Pos
  local dir = config_data.Dir
  if entity_context.entity_runtime_data and entity_context.entity_runtime_data.birth_pos then
    pos = entity_context.entity_runtime_data.birth_pos
  end
  if entity_context.entity_runtime_data and entity_context.entity_runtime_data.birth_dir then
    dir = entity_context.entity_runtime_data.birth_dir
  end
  entity:SetLocation(Vector3(pos[1], pos[2], pos[3]), Vector3(dir[1], dir[2], dir[3]))
end

function EntityAssembler.InitMainFSMComponent(entity, config_data, entity_context)
  entity:AddMainFSM(entity, config_data.MainFSMConfigID)
end

function EntityAssembler.InitGridLocationComponent(entity, config_data, entity_context)
  local pos = config_data.Pos
  local dir = config_data.Dir
  local offset = config_data.Offset
  if entity_context.entity_runtime_data and entity_context.entity_runtime_data.birth_pos then
    pos = entity_context.entity_runtime_data.birth_pos
  end
  if entity_context.entity_runtime_data and entity_context.entity_runtime_data.birth_dir then
    dir = entity_context.entity_runtime_data.birth_dir
  end
  if pos and dir then
    entity:SetGridLocation(Vector2(pos[1], pos[2]), Vector2(dir[1], dir[2]))
  elseif offset then
    entity:SetGridOffset(Vector2(offset[1], offset[2]))
  end
end

function EntityAssembler.InitPieceComponent(entity, config_data, entity_context)
  entity:AddPiece(PieceType[config_data.Type])
end

function EntityAssembler.InitPieceFakeComponent(entity, config_data, entity_context)
  entity:AddPieceFake(PieceType[config_data.Type])
end

function EntityAssembler.InitConnectPiecesComponent(entity, config_data, entity_context)
  entity:AddConnectPieces({}, PieceType.None)
end

function EntityAssembler.InitBodyAreaComponent(entity, config_data, entity_context)
  if not config_data then
    return
  end
  local vecs = {}
  for i, v in ipairs(config_data) do
    local vec = Vector2(v[1], v[2])
    table.insert(vecs, vec)
  end
  entity:AddBodyArea(vecs)
end

function EntityAssembler.InitChainPathComponent(entity, config_data, entity_context)
  entity:AddChainPath({}, PieceType.None)
end

function EntityAssembler.InitMoveFSMComponent(entity, config_data, entity_context)
  local fsm_id = config_data.FSMID
  entity:AddMoveFSM(fsm_id, entity:GetID())
end

function EntityAssembler.InitAnimatorController(entity, config_data, entity_context)
  entity:AddAnimatorController()
end

function EntityAssembler.InitPetComponent(entity, config_data, entity_context)
  entity:AddPet()
end

function EntityAssembler.InitLinkLineIndexComponent(entity, config_data, entity_context)
  entity:AddLinkLineIndex(0)
end

function EntityAssembler.InitSkillInfoComponent(entity, config_data, entity_context)
  local normal_skill_config_id = config_data.NormalSkillConfigID
  local chain_skill_config_id = config_data.ChainSkillConfigID
  local super_skill_config_id = config_data.SuperSkillConfigID
  local extra_skill_config_id_list = config_data.ExtraActiveSkillConfigIDList
  local variant_skill_config_info = config_data.VariantActiveSkillConfigInfo
  entity:AddSkillInfo(normal_skill_config_id, chain_skill_config_id, super_skill_config_id, extra_skill_config_id_list, variant_skill_config_info)
end

function EntityAssembler._NewAILogic(entity, aiLogicID, entity_context)
  local aiLogic
  if aiLogicID then
    local aiGenInfo = AIGenInfo:New(entity_context.world, entity, aiLogicID)
    aiLogic = CustomLogicFactory.Static_CreateLogic(aiGenInfo)
  end
  return aiLogic
end

function EntityAssembler.InitNewAIComponent(entity, config_data, entity_context)
  entity:InitAI(nil, 0, 0, AITargetType.Normal)
end

function EntityAssembler.InitMonsterAttackRangeComponent(entity, config_data, entity_context)
  entity:AddMonsterAttackRange(config_data.entityConfigID)
end

function EntityAssembler.InitHPComponent(entity, config_data, entity_context)
  local offset = Vector3(0, 0, 0)
  offset.x = config_data.HPOffset[1]
  offset.y = config_data.HPOffset[2]
  offset.z = config_data.HPOffset[3]
  entity:AddHP(config_data.MaxHP, config_data.MaxHP, config_data.MaxHP, offset)
end

function EntityAssembler.InitEntityTypeComponent(entity, config_data, entity_context)
  entity:AddEntityType(EntityType[config_data.Type])
end

function EntityAssembler.InitBlockFlagComponent(entity, config_data, entity_context)
  entity:AddBlockFlag(0)
end

function EntityAssembler.InitSkillPetAttackDataComponent(entity, config_data, entity_context)
  entity:AddSkillPetAttackData()
end

function EntityAssembler.InitLinkageInfoComponent(entity, config_data, entity_context)
  local linkTextOffsetList = {
    config_data.LinkTextOffset,
    config_data.LinkTextOffsetPopStarPro
  }
  local attackRateOffset = config_data.AttackRate
  local maxCount = config_data.MaxCount
  entity:AddLinkageInfo(linkTextOffsetList, attackRateOffset, maxCount)
end

function EntityAssembler.InitPreviewEnvComponent(entity, config_data, entity_context)
  entity:AddPreviewEnv()
end

function EntityAssembler.InitPreviewChainSkillRangeComponent(entity, config_data, entity_context)
  entity:AddPreviewChainSkillRange()
end

function EntityAssembler.InitChainPreviewMonsterBehaviorComponent(entity, config_data, entity_context)
  entity:AddChainPreviewMonsterBehavior()
end

function EntityAssembler.InitLinkageNumComponent(entity, config_data, entity_context)
  entity:AddLinkageNum(config_data.LinkageNumOffset)
end

function EntityAssembler.InitLinkLineRenderComponent(entity, config_data, entity_context)
  entity:AddLinkLineRender()
end

function EntityAssembler.InitGridEffectComponent(entity, config_data, entity_context)
  entity:AddGridEffect(config_data.GridEffectType)
end

function EntityAssembler.InitBoardColliderComponent(entity, config_data, entity_context)
  entity:AddBoardCollider()
end

function EntityAssembler.InitElementComponent(entity, config_data, entity_context)
  entity:AddElement(ElementType[config_data.PrimaryType], ElementType[config_data.SecondaryType])
end

function EntityAssembler.InitSkillRoutineComponent(entity, config_data, entity_context)
  entity:AddSkillRoutine()
end

function EntityAssembler.InitSkillRoutineHolderComponent(entity, config_data, entity_context)
  entity:AddSkillRoutineHolder()
end

function EntityAssembler.InitBuffComponent(entity, config_data, entity_context)
  entity:AddBuffComponent()
end

function EntityAssembler.InitTeamComponent(entity, config_data, entity_context)
  entity:AddTeam()
end

function EntityAssembler.InitPetPstIDComponent(entity, config_data, entity_context)
  entity:AddPetPstID()
end

function EntityAssembler.InitTrapComponent(entity, config_data, entity_context)
  entity:AddTrap()
end

function EntityAssembler.InitSkillTipsComponent(entity, config_data, entity_context)
  entity:AddSkillTips("SkillNameID", "SkillDescID")
end

function EntityAssembler.InitHUDComponent(entity, config_data, entity_context)
  entity:AddHUD()
end

function EntityAssembler.InitEffectHolderComponent(entity, config_data, entity_context)
  entity:AddEffectHolder()
end

function EntityAssembler.InitEffectLineRendererComponent(entity, config_data, entity_context)
  entity:AddEffectLineRenderer()
end

function EntityAssembler.InitPreviewBrightGridComponent(entity, config_data, entity_context)
  entity:AddPreviewBrightGrid()
end

function EntityAssembler.InitMonsterIDComponent(entity, config_data, entity_context)
  entity:AddMonsterID()
end

function EntityAssembler.InitChessPetComponent(entity, config_data, entity_context)
  entity:AddChessPet()
end

function EntityAssembler.InitActiveSkillComponent(entity, config_data, entity_context)
  entity:AddActiveSkill()
end

function EntityAssembler.InitFeatureSkillComponent(entity, config_data, entity_context)
  entity:AddFeatureSkill()
end

function EntityAssembler.InitPickUpTargetComponent(entity, config_data, entity_context)
  entity:AddPickUpTarget()
end

function EntityAssembler.InitDamageWarningAreaElementComponent(entity, config_data, entity_context)
  entity:AddDamageWarningAreaElement(0)
end

function EntityAssembler.InitGuidePathComponent(entity, config_data, entity_context)
  entity:AddGuidePath({})
end

function EntityAssembler.InitGuidePreviewLinkLineComponent(entity, config_data, entity_context)
  entity:AddGuidePreviewLinkLine()
end

function EntityAssembler.InitGuideWeakPathComponent(entity, config_data, entity_context)
  entity:AddGuideWeakPath({})
end

function EntityAssembler.InitGuideFingerComponent(entity, config_data, entity_context)
  entity:AddGuideFinger()
end

function EntityAssembler.InitGuideSpotComponent(entity, config_data, entity_context)
  entity:AddGuideSpot()
end

function EntityAssembler.InitGuideLinkLineComponent(entity, config_data, entity_context)
  entity:AddGuideLinkLine()
end

function EntityAssembler.InitGuideWeakLinkLineComponent(entity, config_data, entity_context)
  entity:AddGuideWeakLinkLine()
end

function EntityAssembler.InitGuidePieceComponent(entity, config_data, entity_context)
  entity:AddGuidePiece()
end

function EntityAssembler.InitBoardOutlineComponent(entity, config_data, entity_context)
  entity:AddBoardOutline()
end

function EntityAssembler.InitGhostComponent(entity, config_data, entity_context)
  entity:AddGhost()
end

function EntityAssembler.InitGuideGhostComponent(entity, config_data, entity_context)
  entity:AddGuideGhost()
end

function EntityAssembler.InitPickUpArrowComponent(entity, config_data, entity_context)
  entity:AddPickUpArrow()
end

function EntityAssembler.InitLegacyAnimationComponent(entity, config_data, entity_context)
  entity:AddLegacyAnimation()
end

function EntityAssembler.InitSkillContextComponent(entity, config_data, entity_context)
  entity:AddSkillContext()
end

function EntityAssembler.InitEditorInfoComponent(entity, config_data, entityentity_context)
  entity:AddEditorInfo()
end

function EntityAssembler.InitDeadMarkComponent(entity, config_data, entityentity_context)
  entity:AddDeadMark()
end

function EntityAssembler.InitRenderStateComponent(entity, config_data, entityentity_context)
  entity:AddRenderState()
end

function EntityAssembler.InitAIRecorderComponent(entity, config_data, entityentity_context)
  entity:AddAIRecorder()
end

function EntityAssembler.InitAttackAreaComponent(entity, config_data, entity_context)
  entity:AddAttackArea(config_data.Type)
end

function EntityAssembler.InitPreviewChainSkillComponent(entity, config_data, entity_context)
  entity:AddPreviewChainSkill()
end

function EntityAssembler.InitPreviewLinkLineComponent(entity, config_data, entity_context)
  entity:AddPreviewLinkLine()
end

function EntityAssembler.InitPreviewPuzzleComponent(entity, config_data, entity_context)
  entity:AddPreviewPuzzle()
end

function EntityAssembler.InitWaveDataComponent(entity, config_data, entity_context)
  entity:AddWaveData()
end

function EntityAssembler.InitMatchPetComponent(entity, config_data, entity_context)
  entity:AddMatchPet()
end

function EntityAssembler.InitMonsterAreaOutlineComponent(entity, config_data, entity_context)
  entity:AddMonsterAreaOutLineComponent()
end

function EntityAssembler.InitLogicPickUpComponent(entity, config_data, entity_context)
  entity:AddLogicPickUp()
end

function EntityAssembler.InitLogicChainPathComponent(entity, config_data, entity_context)
  entity:AddLogicChainPath()
end

function EntityAssembler.InitPreviewChainSelectPetComponent(entity, config_data, entity_context)
  entity:AddPreviewChainSelectPet()
end

function EntityAssembler.InitLogicRoundTeamComponent(entity, config_data, entity_context)
  entity:AddLogicRoundTeam()
end

function EntityAssembler.InitPreviewChainPathComponent(entity, config_data, entity_context)
  entity:AddPreviewChainPath()
end

function EntityAssembler.InitTrapRenderComponent(entity, config_data, entity_context)
  entity:AddTrapRender()
end

function EntityAssembler.InitPetShadowRenderComponent(entity, config_data, entity_context)
  entity:AddPetShadowRender()
end

function EntityAssembler.InitRenderBoardComponent(entity, config_data, entity_context)
  entity:AddRenderBoard()
end

function EntityAssembler.InitBuffViewComponent(entity, config_data, entity_context)
  entity:AddBuffView()
end

function EntityAssembler.InitRenderChainPathComponent(entity, config_data, entity_context)
  entity:AddRenderChainPath()
end

function EntityAssembler.InitRenderRoundTeamComponent(entity, config_data, entity_context)
  entity:AddRenderRoundTeam()
end

function EntityAssembler.InitLogicResultComponent(entity, config_data, entity_context)
  entity:AddLogicResult()
end

function EntityAssembler.InitTrapIDComponent(entity, config_data, entity_context)
  entity:AddTrapID()
end

function EntityAssembler.InitDropAssetComponent(entity, config_data, entity_context)
  entity:AddDropAsset()
end

function EntityAssembler.InitBulletTimeComponent(entity, config_data, entity_context)
  entity:AddBulletTime()
end

function EntityAssembler.InitEffectAttachedComponent(entity, config_data, entity_context)
  entity:AddEffectAttached()
end

function EntityAssembler.InitAffixDataComponent(entity, config_data, entity_context)
  entity:AddAffixData()
end

function EntityAssembler.InitCurseTowerComponent(entity, config_data, entity_context)
  entity:AddCurseTower()
end

function EntityAssembler.InitCutsceneMonsterComponent(entity, config_data, entity_context)
  entity:AddCutsceneMonster()
end

function EntityAssembler.InitCutscenePlayerComponent(entity, config_data, entity_context)
  entity:AddCutscenePlayer()
end

function EntityAssembler.InitBackUpMaterialComponent(entity, config_data, entity_context)
  entity:AddBackUpMaterial()
end

function EntityAssembler.InitAlignmentComponent(entity, config_data, entity_context)
  entity:AddAlignment(config_data.AlignmentType)
end

function EntityAssembler.InitGameTurnComponent(entity, config_data, entity_context)
  entity:AddGameTurn(config_data.gameTurnType)
end

function EntityAssembler.InitPickUpChessResultComponent(entity, config_data, entity_context)
  entity:AddPickUpChessResult()
end

function EntityAssembler.InitChessPetRenderComponent(entity, config_data, entity_context)
  entity:AddChessPetRender()
end

function EntityAssembler.InitLogicChessPathComponent(entity, config_data, entity_context)
  entity:AddLogicChessPath()
end

function EntityAssembler.InitRenderChessPathComponent(entity, config_data, entity_context)
  entity:AddRenderChessPath()
end

function EntityAssembler.InitPreviewChessPetComponent(entity, config_data, entity_context)
  entity:AddPreviewChessPet()
end

function EntityAssembler.InitLogicFeatureComponent(entity, config_data, entity_context)
  entity:AddLogicFeature()
end

function EntityAssembler.InitRenderFeatureComponent(entity, config_data, entity_context)
  entity:AddRenderFeature()
end

function EntityAssembler.InitSyncMoveWithTeamComponent(entity, config_data, entity_context)
  entity:AddSyncMoveWithTeam()
end

function EntityAssembler.InitRenderSyncMoveWithTeamComponent(entity, config_data, entity_context)
  entity:AddRenderSyncMoveWithTeam()
end

function EntityAssembler.InitTrapAreaElementComponent(entity, config_data, entity_context)
  entity:AddTrapAreaElement()
end

function EntityAssembler.InitBoardMultiComponent(entity, config_data, entity_context)
  entity:AddBoardMulti(nil)
end

function EntityAssembler.InitRenderMultiBoardComponent(entity, config_data, entity_context)
  entity:AddRenderMultiBoard()
end

function EntityAssembler.InitOutsideRegionComponent(entity, config_data, entity_context)
  entity:AddOutsideRegion(nil)
end

function EntityAssembler.InitPetRenderComponent(entity, config_data, entity_context)
  entity:AddPetRender(nil)
end

function EntityAssembler.InitMonsterRenderComponent(entity, config_data, entity_context)
  entity:AddMonsterRender(nil)
end

function EntityAssembler.InitAuraRangeComponent(entity, config_data, entity_context)
  entity:AddAuraRange()
end

function EntityAssembler.InitShareSkillResultComponent(entity, config_data, entity_context)
  entity:AddShareSkillResult()
end

function EntityAssembler.InitLogicPartnerComponent(entity, config_data, entity_context)
  entity:AddLogicPartner()
end

function EntityAssembler.InitRenderPartnerComponent(entity, config_data, entity_context)
  entity:AddRenderPartner()
end

function EntityAssembler.InitTalentComponent(entity, config_data, entity_context)
  entity:AddTalent()
end

function EntityAssembler.InitOffBoardMonsterComponent(entity, config_data, entity_context)
  entity:AddOffBoardMonster(nil)
end

function EntityAssembler.InitMirageComponent(entity, config_data, entity_context)
  entity:AddMirage()
end

function EntityAssembler.InitMoveScopeRecordComponent(entity, config_data, entity_context)
  entity:AddMoveScopeRecord()
end

function EntityAssembler.InitEquipRefineComponent(entity, config_data, entity_context)
  entity:AddEquipRefine()
end

function EntityAssembler.InitRenderPerformanceByAgentComponent(entity, config_data, entity_context)
  entity:AddRenderPerformanceByAgent()
end

function EntityAssembler.InitBoardSpliceComponent(entity, config_data, entity_context)
  entity:AddBoardSplice(nil)
end

function EntityAssembler.InitRenderBoardSpliceComponent(entity, config_data, entity_context)
  entity:AddRenderBoardSplice(nil)
end

function EntityAssembler.InitPopStarPickUpResultComponent(entity, config_data, entity_context)
  entity:AddPopStarPickUpResult()
end

function EntityAssembler.InitPopStarLogicComponent(entity, config_data, entity_context)
  entity:AddPopStarLogic()
end

function EntityAssembler.InitBoardPushComponent(entity, config_data, entity_context)
  entity:AddBoardPush(nil)
end

function EntityAssembler.InitRenderBoardPushComponent(entity, config_data, entity_context)
  entity:AddRenderBoardPush(nil)
end

function EntityAssembler.InitUnscaledCountDownRenderComponent(entity, config_data, entity_context)
  entity:AddUnscaledCountDownRender()
end

function EntityAssembler.InitUnscaledCountDownLogicComponent(entity, config_data, entity_context)
  entity:AddUnscaledCountDownLogic()
end

function EntityAssembler.InitLogicAutoBeadComponent(entity, config_data, entity_context)
  entity:AddLogicAutoBead()
end

function EntityAssembler.InitSkillAutoBeadAttackDataComponent(entity, config_data, entity_context)
  entity:AddSkillAutoBeadAttackData()
end
