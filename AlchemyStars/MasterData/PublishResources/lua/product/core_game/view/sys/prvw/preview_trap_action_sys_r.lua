_class("PreviewTrapActionSystem_Render", ReactiveSystem)
PreviewTrapActionSystem_Render = PreviewTrapActionSystem_Render

function PreviewTrapActionSystem_Render:Constructor(world)
  self._world = world
  self._configService = world:GetService("Config")
end

function PreviewTrapActionSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.PreviewTrapAction)
  local c = Collector:New({group}, {
    "AddedOrRemoved"
  })
  return c
end

function PreviewTrapActionSystem_Render:Filter(entity)
  return true
end

function PreviewTrapActionSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    local boardEntity = entities[i]
    if boardEntity:HasPreviewTrapAction() then
      local previewCmpt = boardEntity:PreviewTrapAction()
      local isShow = previewCmpt:IsShowTrapAction()
      if isShow then
        local listTrapID = previewCmpt:GetTrapEntityList()
        for i = 1, #listTrapID do
          self:_ShowTrapAction(listTrapID[i])
        end
      else
      end
    else
      Log.debug("[Preview] 预览机关攻击范围： 时机不到")
    end
  end
end

function PreviewTrapActionSystem_Render:_ShowTrapAction(trapEntityID)
  local trapEntity = self._world:GetEntityByID(trapEntityID)
  local trapRenderCmpt = trapEntity:TrapRender()
  if #trapRenderCmpt:GetActiveSkillID() > 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UITrapSkillVisible, true, trapEntityID)
  else
    local configService = self._configService
    local trapConfigData = configService:GetTrapConfigData()
    local desc = trapConfigData:GetTrapInnerDesc(trapRenderCmpt:GetTrapID())
    local name = trapConfigData:GetTrapName(trapRenderCmpt:GetTrapID())
    local utilSvc = self._world:GetService("UtilData")
    local skillID = utilSvc:GetTrapPreviewSkillID(trapEntity)
    local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
    if 0 == skillID then
      if trapConfigData:IsShowDescTips(trapRenderCmpt:GetTrapID()) then
        previewActiveSkillService:_ShowDescTips(name, desc)
      end
      return
    else
      local skillConfigData = configService:GetSkillConfigData(skillID, trapEntity)
      local skillPreviewType = skillConfigData:GetSkillPreviewType()
      if SkillPreviewType.Scope == skillPreviewType then
        self:_ShowSkillRange(trapEntity, skillConfigData)
      elseif SkillPreviewType.Tips == skillPreviewType then
        previewActiveSkillService:_ShowSkillTips(skillConfigData)
      elseif SkillPreviewType.ScopeAndTips == skillPreviewType then
        self:_ShowSkillRange(trapEntity, skillConfigData)
        previewActiveSkillService:_ShowSkillTips(skillConfigData)
      elseif SkillPreviewType.TrapDesc == skillPreviewType then
        previewActiveSkillService:_ShowDescTips(name, desc)
      elseif SkillPreviewType.TrapScopeAndTips == skillPreviewType then
        self:_ShowSkillRange(trapEntity, skillConfigData)
        previewActiveSkillService:_ShowDescTips(name, desc)
      elseif SkillPreviewType.PetTrapMoveArrow == skillPreviewType then
        self:_ShowSkillEffectMove(trapEntity, skillConfigData)
        previewActiveSkillService:_ShowDescTips(name, desc)
      end
    end
  end
end

function PreviewTrapActionSystem_Render:_ShowSkillRange(trapEntity, skillConfigData)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local renderEntityService = self._world:GetService("RenderEntity")
  local trapBasePos = trapEntity:GridLocation().Position
  local rangResult = utilScopeSvc:CalcSkillScope(skillConfigData, trapBasePos, trapEntity)
  local utilDataSvc = self._world:GetService("UtilData")
  local skillRangeGridList = rangResult:GetWholeGridRange()
  local skillAttackRange = {}
  for _, gridPos in ipairs(skillRangeGridList) do
    local bPosInBoard = utilDataSvc:IsValidPiecePos(gridPos)
    if bPosInBoard then
      local alreadyInRange = table.icontains(skillAttackRange, gridPos)
      if false == alreadyInRange then
        skillAttackRange[#skillAttackRange + 1] = gridPos
      end
    end
  end
  renderEntityService:CreatePreviewAreaOutlineEntity(skillAttackRange, EntityConfigIDRender.MoveRange)
  Log.debug("[Preview] 预览机关攻击范围： 标示技能范围<" .. skillConfigData:GetSkillName() .. ">")
end

function PreviewTrapActionSystem_Render:_ShowSkillEffectMove(trapEntity, skillConfigData)
  local renderEntityService = self._world:GetService("RenderEntity")
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local entityPoolServiceRender = self._world:GetService("EntityPool")
  local csterID = trapEntity:GetID()
  local skillID = skillConfigData:GetID()
  local skillResultList = utilCalcSvc:CalcSkillTargetEffect(csterID, skillID, SkillEffectType.PetTrapMove)
  local skillAttackRange = {}
  for index, result in ipairs(skillResultList) do
    local posNew = result:GetPosNew()
    local dirNew = result:GetDirNew()
    local previewRange = result:GetPreviewRange()
    local moveType = result:GetMoveType()
    if moveType == PetTrapMoveType.FixedPos or moveType == PetTrapMoveType.FixedPos then
      renderEntityService:CreateMoveRangeArrowEntity(posNew, -dirNew, EntityConfigIDRender.MoveRangeArrow)
    else
      for _, pos in ipairs(previewRange) do
        if not table.intable(skillAttackRange, pos) then
          table.insert(skillAttackRange, pos)
        end
      end
    end
  end
  for _, pos in ipairs(skillAttackRange) do
    local dirNew = pos - skillResultList[1]:GetPosOld()
    renderEntityService:CreateMoveRangeArrowEntity(pos, -dirNew, EntityConfigIDRender.MoveRangeArrow)
  end
end
