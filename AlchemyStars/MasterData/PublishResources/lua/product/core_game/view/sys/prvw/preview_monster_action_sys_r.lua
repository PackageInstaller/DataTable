_class("PreviewMonsterActionSystem_Render", ReactiveSystem)
PreviewMonsterActionSystem_Render = PreviewMonsterActionSystem_Render
local PreviewMonsterType = {
  SkillRange = 1,
  SkillRangeWithAttackRange = 2,
  ProSkillRange = 3,
  DeathAreaRange = 4,
  Tips = 5,
  SkillRangeWithArrow = 6
}
_enum("PreviewMonsterType", PreviewMonsterType)

function PreviewMonsterActionSystem_Render:Constructor(world)
  self._world = world
  self._neighbourArray = {
    Vector2(0, 1),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(-1, 0)
  }
  self._arrowResPathDic = {}
  self._arrowResPathDic[ElementType.ElementType_Blue] = "eff_gezi_hybs_yulan_bai.prefab"
  self._arrowResPathDic[ElementType.ElementType_Red] = "eff_gezi_hybs_yulan_bai.prefab"
  self._arrowResPathDic[ElementType.ElementType_Green] = "eff_gezi_hybs_yulan_bai.prefab"
  self._arrowResPathDic[ElementType.ElementType_Yellow] = "eff_gezi_hybs_yulan_bai.prefab"
  self._outlineResPath = "eff_gezi_bossyj_normal.prefab"
  self._outlineProResPath = "eff_gezi_bossyj_pro.prefab"
  self._attackAreaResPath = "eff_gezi_hybs_yulan_honggezi.prefab"
  self._deathAreaResPath = "eff_gezi_bossyj_sj.prefab"
  self._configService = world:GetService("Config")
end

function PreviewMonsterActionSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.PreviewMonsterAction)
  local c = Collector:New({group}, {
    "AddedOrRemoved"
  })
  return c
end

function PreviewMonsterActionSystem_Render:Filter(entity)
  return true
end

function PreviewMonsterActionSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    local boardEntity = entities[i]
    if boardEntity:HasPreviewMonsterAction() then
      local previewCmpt = boardEntity:PreviewMonsterAction()
      local isShow = previewCmpt:IsShowMonsterAction()
      local monsterEntityID = previewCmpt:GetMonsterEntityID()
      if isShow then
        self:_ShowMonsterAction(monsterEntityID, boardEntity)
      else
      end
    else
      Log.debug("[Preview] 预览怪物技能： 时机不到")
    end
  end
end

function PreviewMonsterActionSystem_Render:_ShowMonsterAction(monsterEntityID, boardEntity)
  local monsterEntity = self._world:GetEntityByID(monsterEntityID)
  local buffView = monsterEntity:BuffView()
  if buffView and buffView:HasBuffEffect(BuffEffectType.NotShowPreviewSkill) then
    return
  end
  local cMonsterID = monsterEntity:MonsterID()
  local monsterID = cMonsterID:GetMonsterID()
  local configService = self._configService
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local hybridMode, hybridParam = monsterConfigData:GetHybridSkillPreviewMode(monsterID)
  local utilDataSvc = self._world:GetService("UtilData")
  local hasReplacePreviewSkill = utilDataSvc:IsAIChangePreviewSkillID(monsterEntity)
  if 0 < hybridMode and not hasReplacePreviewSkill then
    self:_StartHybridSkillPreview(monsterEntityID, boardEntity, hybridMode, hybridParam)
  else
    self:_StartPlainSkillPreview(monsterEntityID, boardEntity)
  end
end

function PreviewMonsterActionSystem_Render:_StartPlainSkillPreview(monsterEntityID, boardEntity)
  local monsterEntity = self._world:GetEntityByID(monsterEntityID)
  local utilDataSvc = self._world:GetService("UtilData")
  local monsterSkillID = utilDataSvc:GetAIPreviewSkillID(monsterEntity)
  if 0 == monsterSkillID then
    Log.fatal("[Preview]，怪物技能预览时发现技能编号非法： monsterEntityID = " .. monsterEntityID)
  end
  local skillConfig = BattleSkillCfg(monsterSkillID)
  if not skillConfig or not skillConfig.ViewID then
    Log.fatal("[Preview] 无技能表现，不预览")
    return
  end
  self:_ShowSkillPreview(monsterEntity, monsterSkillID)
end

function PreviewMonsterActionSystem_Render:_ShowSkillPreview(monsterEntity, monsterSkillID)
  local skillConfigData = self._configService:GetSkillConfigData(monsterSkillID, monsterEntity)
  local skillPreviewType = skillConfigData:GetSkillPreviewType()
  local skillPreviewParam = skillConfigData:GetSkillPreviewParam()
  local dirCount = 0
  local previewUserCenter, lessMobility, calcMobiUseBlock
  if skillPreviewParam and skillPreviewParam ~= 0 then
    dirCount = skillPreviewParam.Direction
    previewUserCenter = skillPreviewParam.PreviewUserCenter
    lessMobility = skillPreviewParam.LessMobility
    calcMobiUseBlock = skillPreviewParam.CalcMobiUseBlock
  end
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  if SkillPreviewType.Scope == skillPreviewType then
    local utilDataSvc = self._world:GetService("UtilData")
    local configsvc = self._world:GetService("Config")
    local monsterMobility = utilDataSvc:GetAIMobilityConfig(monsterEntity)
    if lessMobility and lessMobility >= monsterMobility then
      local listWalkRange = {
        [1] = monsterEntity:GetGridPosition()
      }
      self:_ShowSkillRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter, lessMobility)
    else
      local listWalkRange = self:_ShowArrow(monsterEntity, lessMobility, calcMobiUseBlock)
      self:_ShowSkillRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter, lessMobility)
    end
  elseif SkillPreviewType.Tips == skillPreviewType then
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
  elseif SkillPreviewType.ScopeAndTips == skillPreviewType then
    local listWalkRange = self:_ShowArrow(monsterEntity, lessMobility)
    self:_ShowSkillRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter)
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
  elseif SkillPreviewType.ReplaceOtherSkillScopeAndTips == skillPreviewType then
    local replaceSkillConfigData = self._configService:GetSkillConfigData(skillPreviewParam.SkillID, monsterEntity)
    local listWalkRange = self:_ShowArrow(monsterEntity, lessMobility)
    self:_ShowSkillRange(monsterEntity, replaceSkillConfigData, listWalkRange, dirCount, previewUserCenter)
    previewActiveSkillService:_ShowSkillTips(replaceSkillConfigData)
  elseif SkillPreviewType.ScopeWithCasterPos == skillPreviewType then
    local listWalkRange = {
      [1] = monsterEntity:GetGridPosition()
    }
    self:_ShowSkillRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter)
  elseif SkillPreviewType.ScopeWithCasterPosAndTips == skillPreviewType then
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
    local casterPos = monsterEntity:GetGridPosition()
    if previewUserCenter then
      for _, v in ipairs(previewUserCenter) do
        if v.x ~= casterPos.x and v.y ~= casterPos.y then
          casterPos = Vector2(v.x, v.y)
          break
        end
      end
    end
    local listWalkRange = {
      [1] = casterPos
    }
    self:_ShowSkillRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter)
  elseif SkillPreviewType.ScopeAndEffectScope == skillPreviewType then
    local effectIndex = skillPreviewParam.effectIndex
    if not effectIndex then
      Log.fatal("Skill Preview Config Failed SkillID:", monsterSkillID)
    end
    self:_ShowSkillRangeWithEffect(effectIndex, skillConfigData, monsterEntity)
  elseif SkillPreviewType.ScopeAndEffectScopeAndTips == skillPreviewType then
    local effectIndex = skillPreviewParam.effectIndex
    if not effectIndex then
      Log.fatal("Skill Preview Config Failed SkillID:", monsterSkillID)
    end
    self:_ShowSkillRangeWithEffect(effectIndex, skillConfigData, monsterEntity)
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
  elseif SkillPreviewType.ScopeAndTipsAndMoveParam == skillPreviewType then
    self:_ShowArrowPreviewParam(monsterEntity, skillPreviewParam)
    local listWalkRange = {}
    self:_ShowSkillRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter)
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
  elseif SkillPreviewType.ScopeCanConfig == skillPreviewType then
    if table.icontains(skillPreviewParam, PreviewMonsterType.SkillRange) then
      local listWalkRange = {}
      self:_ShowSkillRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter)
    end
    if table.icontains(skillPreviewParam, PreviewMonsterType.DeathAreaRange) then
      self:_ShowDeathRange(monsterEntity, skillConfigData)
    end
    if table.icontains(skillPreviewParam, PreviewMonsterType.Tips) then
      previewActiveSkillService:_ShowSkillTips(skillConfigData)
    end
    if table.icontains(skillPreviewParam, PreviewMonsterType.SkillRangeWithAttackRange) then
      local listWalkRange = {
        [1] = monsterEntity:GetGridPosition()
      }
      self:_SkillRangeWithAttackRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter)
    end
    if table.icontains(skillPreviewParam, PreviewMonsterType.SkillRangeWithArrow) then
      local listWalkRange = self:_ShowArrowCheckBlock(monsterEntity)
      self:_SkillRangeWithAttackRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter)
    end
  elseif SkillPreviewType.ScopeSilverGrid == skillPreviewType then
    local listWalkRange = self:_ShowArrow(monsterEntity)
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
    self:_ShowSkillRangeAsSilverGrid(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter)
  elseif SkillPreviewType.ScopeAndTipsAndArrowWithMoveParam == skillPreviewType then
    local listWalkRange = self:_ShowArrowWithMoveParam(monsterEntity, skillPreviewParam)
    self:_ShowSkillRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter)
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
  elseif SkillPreviewType.N29DrillerMoveAttack == skillPreviewType then
    self:_ShowDrillerMoveAttack(monsterEntity, skillConfigData)
  elseif SkillPreviewType.TeleportRangeAndDamageRange == skillPreviewType then
    local damageAreaSkillConfigData = self._configService:GetSkillConfigData(skillPreviewParam.DamageScopeSkillID, monsterEntity)
    local listWalkRange = self:_ShowArrowPreviewParamSub(monsterEntity, skillPreviewParam.TeleportScope)
    self:_ShowSkillRange(monsterEntity, damageAreaSkillConfigData, listWalkRange, dirCount, previewUserCenter)
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
  elseif SkillPreviewType.Crab == skillPreviewType then
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
    self:_ShowCrabMoveAttack(monsterEntity, skillConfigData)
  elseif SkillPreviewType.MoveGroupScope == skillPreviewType then
    self:_ShowMonsterGroupMoveAttack(monsterEntity, skillConfigData)
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
  elseif SkillPreviewType.ShowSelectMonsterScopeAndTips == skillPreviewType then
    self:_ShowShowSelectMonsterScopeAndTips(monsterEntity, skillConfigData, skillPreviewParam)
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
  end
end

function PreviewMonsterActionSystem_Render:_StartHybridSkillPreview(monsterEntityID, boardEntity, mode, param)
  local entity = self._world:GetEntityByID(monsterEntityID)
  local curParam
  local buffView = entity:BuffView()
  if buffView then
    curParam = buffView:GetBuffValue("HybridSkillPreviewParam")
  end
  curParam = curParam or param
  local cPrvwMstrAct = boardEntity:PreviewMonsterAction()
  local tid
  if mode == MonsterActionHybridPreviewMode.Carousel then
    tid = self:_HybridPreview_Carousel(entity, curParam)
  elseif mode == MonsterActionHybridPreviewMode.RoundBasedCarousel then
    local utilDataSvc = self._world:GetService("UtilData")
    local roundCount = utilDataSvc:GetEntityAIRuntimeData(entity, "RoundCount")
    if not roundCount or roundCount <= 0 then
      roundCount = 0
    end
    roundCount = roundCount + 1
    tid = self:_HybridPreview_RoundBasedCarousel(entity, curParam, roundCount)
  elseif mode == MonsterActionHybridPreviewMode.TotalRoundBasedCarousel then
    local roundCount = BattleStatHelper.GetLevelTotalRoundCount()
    if roundCount > #param then
      roundCount = roundCount % #param
      if roundCount == 0 then
        roundCount = #param
      end
    end
    tid = self:_HybridPreview_RoundBasedCarousel(entity, curParam, roundCount)
  elseif mode == MonsterActionHybridPreviewMode.AlphaFixedByRound then
    self:_HybridPreview_AlphaFixedByRound(entity, curParam)
  elseif mode == MonsterActionHybridPreviewMode.N34BossStateCarousel then
    tid = self:_HybridPreview_N34BossStateCarousel(entity, curParam)
  elseif mode == MonsterActionHybridPreviewMode.StateCarousel then
    tid = self:_HybridPreview_StateCarousel(entity, curParam)
  end
  if type(tid) == "number" then
    cPrvwMstrAct:SetPreviewTaskID(tid)
  end
end

function PreviewMonsterActionSystem_Render:_HybridPreview_Carousel(entity, param)
  local cMonsterID = entity:MonsterID()
  local monsterID = cMonsterID:GetMonsterID()
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local monsterSkill = monsterConfigData:GetMonsterSkillIDs(monsterID)
  local skillRow = param[1][1]
  local tipSkillIndex = param[2][1]
  local skills = monsterSkill[skillRow]
  if not skills then
    return
  end
  if tipSkillIndex and 0 < tipSkillIndex then
    local skillConfigData = self._configService:GetSkillConfigData(skills[tipSkillIndex], entity)
    local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
  end
  return TaskManager:GetInstance():CoreGameStartTask(self._TaskFnCarousel, self, skills, entity)
end

function PreviewMonsterActionSystem_Render:_HybridPreview_RoundBasedCarousel(entity, param, roundCount)
  if roundCount > #param then
    roundCount = 1
  end
  local skillGroup = param[roundCount]
  if not skillGroup or #skillGroup <= 0 then
    return
  end
  return TaskManager:GetInstance():CoreGameStartTask(self._TaskFnCarousel, self, skillGroup, entity)
end

function PreviewMonsterActionSystem_Render:_TaskFnCarousel(TT, tSkillID, casterEntity)
  local renderEntityService = self._world:GetService("RenderEntity")
  local currentSkillIndex = 1
  while true do
    local monsterSkillID = tSkillID[currentSkillIndex]
    self:_ShowSkillPreview(casterEntity, monsterSkillID)
    local skillConfigData = self._configService:GetSkillConfigData(monsterSkillID, casterEntity)
    local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
    previewActiveSkillService:_ShowSkillTips(skillConfigData)
    YIELD(TT, BattleConst.PreviewMonsterInternal)
    renderEntityService:DestroyMonsterPreviewAreaOutlineEntity()
    self._world:GetService("PreviewActiveSkill"):_RevertAllConvertElement(true)
    currentSkillIndex = currentSkillIndex % #tSkillID + 1
  end
end

function PreviewMonsterActionSystem_Render:_CalcMoveArrowDir(monsterPos, bodyArea, targetPos)
  local x = 0
  local y = 0
  local onTheRight = true
  local onTheLeft = true
  local onTheTop = true
  local onTheBottom = true
  for _, bodyAreaPos in ipairs(bodyArea) do
    local curAreaPos = monsterPos + bodyAreaPos
    if targetPos.x >= curAreaPos.x then
      onTheLeft = false
    end
    if targetPos.x <= curAreaPos.x then
      onTheRight = false
    end
    if targetPos.y >= curAreaPos.y then
      onTheBottom = false
    end
    if targetPos.y <= curAreaPos.y then
      onTheTop = false
    end
  end
  if onTheLeft then
    x = 1
  elseif onTheRight then
    x = -1
  end
  if onTheTop then
    y = -1
  elseif onTheBottom then
    y = 1
  end
  return Vector2(x, y)
end

function PreviewMonsterActionSystem_Render:_CalcMonsterMoveRange_Han(monsterEntity, bBase, bFilterInvalid, lessMobility, calcMobiUseBlock)
  local monsterBasePos = monsterEntity:GridLocation().Position
  local bodyAreaCmpt = monsterEntity:BodyArea()
  local monsterBodyArea = bodyAreaCmpt:GetArea()
  local nBodyAreaCount = 0
  if bBase then
    nBodyAreaCount = 1
  else
    nBodyAreaCount = #monsterBodyArea
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local configsvc = self._world:GetService("Config")
  local monsterMobility = utilDataSvc:GetAIMobilityConfig(monsterEntity)
  local monsterID = monsterEntity:MonsterID():GetMonsterID()
  local monsterConfigData = configsvc:GetMonsterConfigData()
  local canMove = monsterConfigData:CanMove(monsterID)
  local canTurn = monsterConfigData:CanTurn(monsterID)
  local listWalkRange
  if lessMobility then
    monsterMobility = monsterMobility - lessMobility
  end
  if canMove then
    if 0 < monsterMobility then
      local cbFilter = Callback:New(1, utilDataSvc.IsPosAccessibleMonsterMove, utilDataSvc)
      local monsterBlockData = monsterEntity:MonsterID():GetMonsterBlockData()
      listWalkRange = ComputeScopeRange.ComputeRange_PreviewWithStepAndBlock(monsterBasePos, monsterBodyArea, bBase, monsterMobility, monsterBlockData, cbFilter)
    else
      return {monsterBasePos}
    end
  else
    listWalkRange = ComputeScopeRange.ComputeBodyArea(monsterBasePos, nBodyAreaCount, 0)
  end
  local listReturn = {}
  local utilDataSvc = self._world:GetService("UtilData")
  for key, value in pairs(listWalkRange) do
    local posWalk = value:GetPos()
    local isBlocked = false
    if bFilterInvalid then
      isBlocked = utilDataSvc:IsPosBlock(posWalk, monsterEntity:MonsterID():GetMonsterBlockData())
      if isBlocked then
        local posPlayer = self._world:Player():GetPreviewTeamEntity():GetGridPosition()
        if posPlayer == posWalk or utilDataSvc:GetMonsterAtPos(posWalk) then
          isBlocked = false
        end
      end
      if isBlocked and bBase and table.icontains(monsterBodyArea, posWalk - monsterBasePos) then
        isBlocked = false
      end
    else
      isBlocked = utilDataSvc:IsValidPiecePos(posWalk)
    end
    if false == isBlocked then
      listReturn[#listReturn + 1] = posWalk
    end
  end
  return listReturn
end

function PreviewMonsterActionSystem_Render:_GetSkillRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter, lessMobility)
  local monsterBasePos = monsterEntity:GridLocation().Position
  local textPos
  if previewUserCenter then
    for _, v in ipairs(previewUserCenter) do
      if v.x ~= monsterBasePos.x and v.y ~= monsterBasePos.y then
        monsterBasePos = Vector2(v.x, v.y)
        textPos = monsterBasePos
        break
      end
    end
  end
  local nSkillScopeType = skillConfigData:GetSkillScopeType()
  local bOnlyBaseMoveRange = true
  if SkillScopeType.NRowsMColumns == nSkillScopeType then
    bOnlyBaseMoveRange = false
  end
  local monsterBaseMoveRange
  if nil == listWalkRange then
    monsterBaseMoveRange = self:_CalcMonsterMoveRange_Han(monsterEntity, bOnlyBaseMoveRange, true, lessMobility)
  else
    local bodyArea = monsterEntity:BodyArea():GetArea()
    if bOnlyBaseMoveRange and table.count(bodyArea) > 1 and SkillPreviewType.ScopeWithCasterPos ~= skillConfigData:GetSkillPreviewType() and SkillPreviewType.ScopeWithCasterPosAndTips ~= skillConfigData:GetSkillPreviewType() and SkillPreviewType.ScopeAndTipsAndArrowWithMoveParam ~= skillConfigData:GetSkillPreviewType() then
      monsterBaseMoveRange = self:_CalcMonsterMoveRange_Han(monsterEntity, bOnlyBaseMoveRange, true, lessMobility)
    else
      monsterBaseMoveRange = listWalkRange
    end
  end
  if false == table.icontains(monsterBaseMoveRange, monsterBasePos) then
    monsterBaseMoveRange[#monsterBaseMoveRange + 1] = monsterBasePos
  end
  local casterDirList = {}
  if dirCount == 4 then
    casterDirList = {
      Vector2(0, 1),
      Vector2(0, -1),
      Vector2(1, 0),
      Vector2(-1, 0)
    }
  elseif dirCount == 8 then
    casterDirList = {
      Vector2(0, 1),
      Vector2(0, -1),
      Vector2(1, 0),
      Vector2(-1, 0),
      Vector2(1, 1),
      Vector2(1, -1),
      Vector2(-1, 1),
      Vector2(-1, -1)
    }
  else
    casterDirList = {}
  end
  local skillAttackRange = {}
  for _, movePos in pairs(monsterBaseMoveRange) do
    if 0 < #casterDirList then
      for k, dir in pairs(casterDirList) do
        local range = self:_CreatePreviewRange(skillConfigData, movePos, monsterEntity, dir)
        for _, gridPos in pairs(range) do
          local alreadyInRange = table.icontains(skillAttackRange, gridPos)
          if not alreadyInRange then
            skillAttackRange[#skillAttackRange + 1] = gridPos
          end
        end
      end
    else
      local range = self:_CreatePreviewRange(skillConfigData, movePos, monsterEntity)
      for _, gridPos in pairs(range) do
        local alreadyInRange = table.icontains(skillAttackRange, gridPos)
        if not alreadyInRange then
          skillAttackRange[#skillAttackRange + 1] = gridPos
        end
      end
    end
  end
  return skillAttackRange
end

function PreviewMonsterActionSystem_Render:_ShowSkillRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter, lessMobility)
  local renderEntityService = self._world:GetService("RenderEntity")
  local skillAttackRange = self:_GetSkillRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter, lessMobility)
  renderEntityService:CreatePreviewAreaOutlineEntity(skillAttackRange, EntityConfigIDRender.MoveRange)
  Log.debug("[Preview] 预览怪物技能： 标示技能范围<" .. skillConfigData:GetSkillName() .. ">")
end

function PreviewMonsterActionSystem_Render:_GetSkillRangeWithAttackRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter, lessMobility)
  local nSkillScopeType = skillConfigData:GetSkillScopeType()
  local bOnlyBaseMoveRange = true
  if SkillScopeType.NRowsMColumns == nSkillScopeType then
    bOnlyBaseMoveRange = false
  end
  local casterDirList = {}
  if dirCount == 4 then
    casterDirList = {
      Vector2(0, 1),
      Vector2(0, -1),
      Vector2(1, 0),
      Vector2(-1, 0)
    }
  elseif dirCount == 8 then
    casterDirList = {
      Vector2(0, 1),
      Vector2(0, -1),
      Vector2(1, 0),
      Vector2(-1, 0),
      Vector2(1, 1),
      Vector2(1, -1),
      Vector2(-1, 1),
      Vector2(-1, -1)
    }
  else
    casterDirList = {}
  end
  local skillAttackRange = {}
  if 0 < #casterDirList then
    for i, movePos in ipairs(listWalkRange) do
      for k, dir in pairs(casterDirList) do
        local range = self:_CreatePreviewRangeUseAttackRange(skillConfigData, movePos, monsterEntity, dir)
        for _, gridPos in pairs(range) do
          local alreadyInRange = table.icontains(skillAttackRange, gridPos)
          if not alreadyInRange then
            skillAttackRange[#skillAttackRange + 1] = gridPos
          end
        end
      end
    end
  else
    for i, movePos in ipairs(listWalkRange) do
      local range = self:_CreatePreviewRangeUseAttackRange(skillConfigData, movePos, monsterEntity)
      for _, gridPos in pairs(range) do
        local alreadyInRange = table.icontains(skillAttackRange, gridPos)
        if not alreadyInRange then
          skillAttackRange[#skillAttackRange + 1] = gridPos
        end
      end
    end
  end
  return skillAttackRange
end

function PreviewMonsterActionSystem_Render:_CreatePreviewRangeUseAttackRange(skillConfigData, movePos, monsterEntity, dir)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillAttackRange = {}
  local rangResult
  local utilDataSvc = self._world:GetService("UtilData")
  rangResult = utilDataSvc:GetAISkillScopeResult(monsterEntity)
  rangResult = rangResult or utilScopeSvc:CalcSkillScope(skillConfigData, movePos, monsterEntity, dir)
  skillAttackRange = rangResult:GetAttackRange()
  return skillAttackRange
end

function PreviewMonsterActionSystem_Render:_SkillRangeWithAttackRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter, lessMobility)
  local renderEntityService = self._world:GetService("RenderEntity")
  local skillAttackRange = self:_GetSkillRangeWithAttackRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter, lessMobility)
  renderEntityService:CreatePreviewAreaOutlineEntity(skillAttackRange, EntityConfigIDRender.MoveRange)
  Log.debug("[Preview] 预览怪物技能： 标示技能范围<" .. skillConfigData:GetSkillName() .. ">")
end

function PreviewMonsterActionSystem_Render:_ShowSkillRangeAsSilverGrid(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter)
  local skillAttackRange = self:_GetSkillRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter)
  local rsvcPreviewActive = self._world:GetService("PreviewActiveSkill")
  rsvcPreviewActive:DoConvert(skillAttackRange, "Silver")
end

function PreviewMonsterActionSystem_Render:_FilerSkillRange(skillRange)
  local skillAttackRange = {}
  local utilDataSvc = self._world:GetService("UtilData")
  for _, gridPos in ipairs(skillRange) do
    if utilDataSvc:IsValidPiecePos(gridPos) and not utilDataSvc:IsPosBlock(gridPos, BlockFlag.Skill | BlockFlag.SkillSkip) then
      skillAttackRange[#skillAttackRange + 1] = gridPos
    end
  end
  return skillAttackRange
end

function PreviewMonsterActionSystem_Render:_CreatePreviewRange(skillConfigData, movePos, monsterEntity, dir)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillAttackRange = {}
  local rangResult
  local utilDataSvc = self._world:GetService("UtilData")
  rangResult = utilDataSvc:GetAISkillScopeResult(monsterEntity)
  rangResult = rangResult or utilScopeSvc:CalcSkillScope(skillConfigData, movePos, monsterEntity, dir)
  skillAttackRange = self:_FilerSkillRange(rangResult:GetWholeGridRange())
  return skillAttackRange
end

function PreviewMonsterActionSystem_Render:_ShowArrowCheckBlock(monsterEntity, lessMobility, calcMobiUseBlock)
  local renderEntityService = self._world:GetService("RenderEntity")
  local monsterPos = monsterEntity:GridLocation().Position
  local bodyAreaCmpt = monsterEntity:BodyArea()
  local bodyArea = bodyAreaCmpt:GetArea()
  local block
  local monsterRaceType = monsterEntity:MonsterID():GetMonsterRaceType()
  if monsterRaceType == MonsterRaceType.Land then
    block = BlockFlag.MonsterLand
  elseif monsterRaceType == MonsterRaceType.Fly then
    block = BlockFlag.MonsterFly
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local elementType = utilDataSvc:GetEntityElementPrimaryType(monsterEntity)
  local monsterMoveRange = self:_CalcMonsterMoveRange_Han(monsterEntity, false, true, lessMobility, calcMobiUseBlock)
  local retRange = {}
  for i, pos in ipairs(monsterMoveRange) do
    if not utilDataSvc:IsPosBlock(pos, block) then
      table.insert(retRange, pos)
    end
  end
  for _, targetPos in ipairs(retRange) do
    if false == self:_IsPosInMine(targetPos, monsterPos, bodyArea) then
      local arrowDir = self:_CalcMoveArrowDir(monsterPos, bodyArea, targetPos)
      renderEntityService:CreateMoveRangeArrowEntity(targetPos, arrowDir, EntityConfigIDRender.MoveRangeArrow)
    end
  end
  Log.debug("[Preview] 预览怪物技能： 标示行动范围<三角箭头>>")
  return retRange
end

function PreviewMonsterActionSystem_Render:_ShowArrow(monsterEntity, lessMobility, calcMobiUseBlock)
  local renderEntityService = self._world:GetService("RenderEntity")
  local monsterPos = monsterEntity:GridLocation().Position
  local bodyAreaCmpt = monsterEntity:BodyArea()
  local bodyArea = bodyAreaCmpt:GetArea()
  local utilDataSvc = self._world:GetService("UtilData")
  local elementType = utilDataSvc:GetEntityElementPrimaryType(monsterEntity)
  local monsterMoveRange = self:_CalcMonsterMoveRange_Han(monsterEntity, false, true, lessMobility, calcMobiUseBlock)
  for _, targetPos in ipairs(monsterMoveRange) do
    if false == self:_IsPosInMine(targetPos, monsterPos, bodyArea) then
      local arrowDir = self:_CalcMoveArrowDir(monsterPos, bodyArea, targetPos)
      renderEntityService:CreateMoveRangeArrowEntity(targetPos, arrowDir, EntityConfigIDRender.MoveRangeArrow)
    end
  end
  Log.debug("[Preview] 预览怪物技能： 标示行动范围<三角箭头>>")
  return monsterMoveRange
end

function PreviewMonsterActionSystem_Render:_ShowArrowPreviewParam(monsterEntity, skillPreviewParam)
  local arrowPosList = {}
  local monsterPos = monsterEntity:GetGridPosition()
  local bodyArea = monsterEntity:BodyArea():GetArea()
  local scopeType = skillPreviewParam.scopeType
  local scopeParam = skillPreviewParam.scopeParam
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local utilData = self._world:GetService("UtilData")
  local renderEntityService = self._world:GetService("RenderEntity")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(scopeType, scopeParam, monsterPos, bodyArea)
  local attackRange = scopeResult:GetAttackRange()
  for _, pos in pairs(attackRange) do
    if utilData:IsValidPiecePos(pos) then
      table.insert(arrowPosList, pos)
    end
  end
  for _, targetPos in ipairs(arrowPosList) do
    if false == self:_IsPosInMine(targetPos, monsterPos, bodyArea) then
      local arrowDir = self:_CalcMoveArrowDir(monsterPos, bodyArea, targetPos)
      renderEntityService:CreateMoveRangeArrowEntity(targetPos, arrowDir, EntityConfigIDRender.MoveRangeArrow)
    end
  end
end

function PreviewMonsterActionSystem_Render:_ShowArrowPreviewParamSub(monsterEntity, skillPreviewParam)
  local arrowPosList = {}
  local monsterPos = monsterEntity:GetGridPosition()
  local bodyArea = monsterEntity:BodyArea():GetArea()
  local scopeType = skillPreviewParam.scopeType
  local scopeParam = skillPreviewParam.scopeParam
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local utilData = self._world:GetService("UtilData")
  local renderEntityService = self._world:GetService("RenderEntity")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(scopeType, scopeParam, monsterPos, bodyArea, monsterEntity:GetGridDirection(), SkillTargetType.Team, monsterPos, monsterEntity)
  local attackRange = scopeResult:GetAttackRange()
  for _, pos in pairs(attackRange) do
    if utilData:IsValidPiecePos(pos) then
      table.insert(arrowPosList, pos)
    end
  end
  for _, targetPos in ipairs(arrowPosList) do
    if false == self:_IsPosInMine(targetPos, monsterPos, bodyArea) then
      local arrowDir = self:_CalcMoveArrowDir(monsterPos, bodyArea, targetPos)
      renderEntityService:CreateMoveRangeArrowEntity(targetPos, arrowDir, EntityConfigIDRender.MoveRangeArrow)
    end
  end
  return arrowPosList
end

function PreviewMonsterActionSystem_Render:_ShowArrowWithMoveParam(monsterEntity, skillPreviewParam)
  local arrowPosList = {}
  local moveOffsetList = {}
  local canMovePosList = {}
  local monsterPos = monsterEntity:GetGridPosition()
  local bodyArea = monsterEntity:BodyArea():GetArea()
  local moveOffsetPosList = skillPreviewParam.moveOffsetPosList
  if moveOffsetPosList then
    for _, v in ipairs(moveOffsetPosList) do
      local offset = Vector2(v.x, v.y)
      table.insert(moveOffsetList, offset)
      local movePos = monsterPos + offset
      if movePos.x >= skillPreviewParam.minX and movePos.x <= skillPreviewParam.maxX then
        table.insert(canMovePosList, movePos)
      end
    end
  end
  local utilData = self._world:GetService("UtilData")
  for _, offset in ipairs(moveOffsetList) do
    for _, bodyPos in ipairs(bodyArea) do
      local offsetBodyPos = offset + bodyPos
      if not table.icontains(bodyArea, offsetBodyPos) then
        local pos = monsterPos + offsetBodyPos
        if utilData:IsValidPiecePos(pos) and not table.icontains(arrowPosList, pos) then
          table.insert(arrowPosList, pos)
        end
      end
    end
  end
  local renderEntityService = self._world:GetService("RenderEntity")
  for _, targetPos in ipairs(arrowPosList) do
    if false == self:_IsPosInMine(targetPos, monsterPos, bodyArea) then
      local arrowDir = self:_CalcMoveArrowDir(monsterPos, bodyArea, targetPos)
      renderEntityService:CreateMoveRangeArrowEntity(targetPos, arrowDir, EntityConfigIDRender.MoveRangeArrow)
    end
  end
  return canMovePosList
end

function PreviewMonsterActionSystem_Render:_IsPosInMine(targetPos, basePos, bodyArea)
  for i = 1, #bodyArea do
    local posWork = basePos + bodyArea[i]
    if targetPos == posWork then
      return true
    end
  end
  return false
end

function PreviewMonsterActionSystem_Render:_ShowSkillRangeWithEffect(effectIndex, skillConfigData, monsterEntity)
  local effectParam = skillConfigData:GetSkillEffectByIndex(effectIndex)
  effectParam:GetSkillEffectScopeType()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local casterPos = monsterEntity:GetGridPosition()
  local effectScopeResult = utilScopeSvc:CalcSkillEffectScopeResult(effectParam, casterPos, monsterEntity)
  local effectScopeRange = effectScopeResult:GetWholeGridRange()
  local skillScopeRange = self:_CreatePreviewRange(skillConfigData, casterPos, monsterEntity)
  local normalRange = {}
  for _, pos in ipairs(skillScopeRange) do
    if not table.Vector2Include(effectScopeRange, pos) then
      table.insert(normalRange, pos)
    end
  end
  local renderEntityService = self._world:GetService("RenderEntity")
  for _, gridPos in pairs(effectScopeRange) do
    renderEntityService:CreateAreaEntityFromEntityPool(gridPos, EntityConfigIDRender.MoveRangeGrid)
  end
  renderEntityService:CreatePreviewAreaOutlineEntity(effectScopeRange, EntityConfigIDRender.MoveRangePro)
  renderEntityService:CreatePreviewAreaOutlineEntity(normalRange, EntityConfigIDRender.MoveRange)
end

function PreviewMonsterActionSystem_Render:_ShowDeathRange(monsterEntity, skillConfigData)
  local casterPos = monsterEntity:GetGridPosition()
  local range = self:_CreatePreviewRange(skillConfigData, casterPos, monsterEntity)
  local renderEntityService = self._world:GetService("RenderEntity")
  for _, pos in ipairs(range) do
    renderEntityService:CreateDeathRangeEntity(pos, EntityConfigIDRender.DeathArea)
  end
end

function PreviewMonsterActionSystem_Render:_GetSkillListByRoundCount(entity)
  local utilDataSvc = self._world:GetService("UtilData")
  local roundCount = utilDataSvc:GetEntityAIRuntimeData(entity, "RoundCount")
  if not roundCount or roundCount <= 0 then
    roundCount = 0
  end
  roundCount = roundCount + 1
  local cMonsterID = entity:MonsterID()
  local monsterID = cMonsterID:GetMonsterID()
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local skillIDs = monsterConfigData:GetMonsterSkillIDs(monsterID)
  if roundCount > #skillIDs then
    roundCount = 1
  end
  local skillGroup = skillIDs[roundCount]
  if not skillGroup or #skillGroup <= 0 then
    return
  end
  return roundCount, skillGroup
end

function PreviewMonsterActionSystem_Render:_HybridPreview_AlphaFixedByRound(entity, param)
  local roundCount, skillIDGroup = self:_GetSkillListByRoundCount(entity)
  local trapID = param[1][1]
  local monsterClassID = param[2][1]
  local skillID = skillIDGroup[1]
  if roundCount == AIAlphaRoundCount.First then
    skillID = self:_CalcSkillIDByTrapInRangeAndRideState(entity, trapID, monsterClassID, skillIDGroup)
  elseif roundCount == AIAlphaRoundCount.Second then
    skillID = self:_CalcSkillIDByRideState(entity, skillIDGroup)
  end
  self:_ShowSkillPreview(entity, skillID)
end

function PreviewMonsterActionSystem_Render:_CheckRideState(entity)
  if entity:HasRide() then
    local rideCmpt = entity:Ride()
    local mountID = rideCmpt:GetMountID()
    local mountEntity = self._world:GetEntityByID(mountID)
    if mountEntity then
      if mountEntity:HasMonsterID() then
        return AIRideStateType.RideOnMonster
      elseif mountEntity:HasTrapID() then
        return AIRideStateType.RideOnTrap
      end
    end
  end
  return AIRideStateType.NoRide
end

function PreviewMonsterActionSystem_Render:_CalcSkillIDByTrapInRangeAndRideState(entity, trapID, monsterClassID, skillIDGroup)
  local skillID = skillIDGroup[AIEntityInTargetRangeType.NoRideInRange]
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local targetType = skillConfigData:GetSkillTargetType()
  local casterPos = entity:GetGridPosition()
  local casterDir = entity:GetGridDirection()
  local skillScopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, casterPos, entity, casterDir)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local targetEntityIDList = targetSelector:DoSelectSkillTarget(entity, SkillTargetType.MonsterTrap, skillScopeResult, skillID)
  local trapEntityIDs = {}
  for _, targetID in ipairs(targetEntityIDList) do
    local targetEntity = self._world:GetEntityByID(targetID)
    if targetEntity:HasTrapID() and targetEntity:TrapID():GetTrapID() == trapID then
      table.insert(trapEntityIDs, targetID)
      if targetEntity:HasRide() and targetEntity:Ride():GetRiderID() == entity:GetID() then
        return skillIDGroup[AIEntityInTargetRangeType.RideOnTrapInRange]
      end
    end
    if targetEntity:HasMonsterID() and targetEntity:MonsterID():GetMonsterClassID() == monsterClassID and targetEntity:HasRide() and targetEntity:Ride():GetRiderID() == entity:GetID() then
      return skillIDGroup[AIEntityInTargetRangeType.RideOnMonsterInRange]
    end
  end
  if 0 < #trapEntityIDs then
    return skillID
  end
  return skillIDGroup[AIEntityInTargetRangeType.NotInRange]
end

function PreviewMonsterActionSystem_Render:_CalcSkillIDByRideState(entity, skillIDGroup)
  local rideState = self:_CheckRideState(entity)
  local skillID = skillIDGroup[rideState]
  return skillID
end

function PreviewMonsterActionSystem_Render:_ShowDrillerMoveAttack(monsterEntity, skillConfigData)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local renderEntityService = self._world:GetService("RenderEntity")
  local casterPos = monsterEntity:GetGridPosition()
  local casterDir = monsterEntity:GetGridDirection()
  local skillScopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, casterPos, monsterEntity, casterDir)
  local walkPosList = skillScopeResult:GetAttackRange()
  local wholeRange = skillScopeResult:GetWholeGridRange()
  local lastMovePos = casterPos
  for _, movePos in ipairs(walkPosList) do
    if movePos ~= casterPos then
      local arrowDir = self:_CalcMoveArrowDir(lastMovePos, {
        Vector2(0, 0)
      }, movePos)
      renderEntityService:CreateMoveRangeArrowEntity(movePos, arrowDir, EntityConfigIDRender.MoveRangeArrow)
      lastMovePos = movePos
    end
  end
  renderEntityService:CreatePreviewAreaOutlineEntity(wholeRange, EntityConfigIDRender.MoveRange)
end

function PreviewMonsterActionSystem_Render:_HybridPreview_N34BossStateCarousel(entity, param)
  local groupIndex = N34BossStateType.NotArrive
  local buffViewCmpt = entity:BuffView()
  if buffViewCmpt and buffViewCmpt:HasBuffEffect(BuffEffectType.Palsy) then
    groupIndex = N34BossStateType.Palsy
  else
    local utilData = self._world:GetService("UtilData")
    local buffValue = utilData:GetEntityBuffValue(entity, BattleConst.N34BossArriveBuffValueKey)
    if buffValue then
      groupIndex = N34BossStateType.Arrived
    end
  end
  local skillGroup = param[groupIndex]
  if not skillGroup or #skillGroup <= 0 then
    return
  end
  return TaskManager:GetInstance():CoreGameStartTask(self._TaskFnCarousel, self, skillGroup, entity)
end

function PreviewMonsterActionSystem_Render:_HybridPreview_StateCarousel(entity, param)
  local groupIndex = 1
  local curState = 1
  local buffView = entity:BuffView()
  if buffView then
    curState = buffView:GetBuffValue("HybridSkillPreviewState") or 1
  end
  groupIndex = curState
  local skillGroup = param[groupIndex]
  if not skillGroup or #skillGroup <= 0 then
    return
  end
  return TaskManager:GetInstance():CoreGameStartTask(self._TaskFnCarousel, self, skillGroup, entity)
end

function PreviewMonsterActionSystem_Render:_ShowCrabMoveAttack(monsterEntity, skillConfigData)
  local monsterPos = monsterEntity:GetGridPosition()
  local monsterDir = monsterEntity:GetGridDirection()
  local bodyArea = monsterEntity:BodyArea():GetArea()
  local arrowPosList = {}
  local skillAttackRange = {}
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local skillTargetType = skillConfigData:GetSkillTargetType()
  local scopeType = skillConfigData:GetSkillScopeType()
  local scopeParam = skillConfigData:GetSkillScopeParam()
  local scopeParamPreview = table.cloneconf(scopeParam)
  scopeParamPreview[5] = 0
  local scopeResult = scopeCalculator:ComputeScopeRange(scopeType, scopeParamPreview, monsterPos, bodyArea, monsterDir, skillTargetType, monsterPos, monsterEntity)
  for _, pos in ipairs(scopeResult:GetAttackRange()) do
    if monsterDir.x ~= 0 then
      if pos.x == monsterPos.x then
        table.insert(arrowPosList, pos)
      else
        table.insert(skillAttackRange, pos)
      end
    elseif monsterDir.y ~= 0 then
      if pos.y == monsterPos.y then
        table.insert(arrowPosList, pos)
      else
        table.insert(skillAttackRange, pos)
      end
    end
  end
  local renderEntityService = self._world:GetService("RenderEntity")
  local posPlayer = self._world:Player():GetPreviewTeamEntity():GetGridPosition()
  table.removev(arrowPosList, posPlayer)
  local showArrowPosList = {}
  for _, targetPos in ipairs(arrowPosList) do
    for _, bodyPos in ipairs(bodyArea) do
      local posWork = targetPos + bodyPos
      if not table.icontains(showArrowPosList, posWork) then
        table.insert(showArrowPosList, posWork)
      end
    end
  end
  for _, targetPos in ipairs(showArrowPosList) do
    if false == self:_IsPosInMine(targetPos, monsterPos, bodyArea) then
      local arrowDir = self:_CalcMoveArrowDir(monsterPos, bodyArea, targetPos)
      renderEntityService:CreateMoveRangeArrowEntity(targetPos, arrowDir, EntityConfigIDRender.MoveRangeArrow)
    end
  end
  renderEntityService:CreatePreviewAreaOutlineEntity(skillAttackRange, EntityConfigIDRender.MoveRange)
end

function PreviewMonsterActionSystem_Render:_ShowMonsterGroupMoveAttack(monsterEntity, skillConfigData)
  local monsterIDCmpt = monsterEntity:MonsterID()
  local groupID = monsterIDCmpt:GetMoveGroupID()
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local sameGroupMonsterList = utilCalcSvc:FindMonsterByMoveGroupID(groupID)
  local monsterPos = monsterEntity:GetGridPosition()
  local monsterDir = monsterEntity:GetGridDirection()
  local bodyArea = table.clone(monsterEntity:BodyArea():GetArea())
  for i, monster in ipairs(sameGroupMonsterList) do
    if monsterEntity:GetID() ~= monster:GetID() then
      local pos = monster:GetGridPosition()
      local area = pos - monsterPos
      table.insert(bodyArea, area)
      utilCalcSvc:RemoveEntityBlockFlag(monster, monster:GetGridPosition())
    end
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local skillTargetType = skillConfigData:GetSkillTargetType()
  local scopeType = skillConfigData:GetSkillScopeType()
  local scopeParam = skillConfigData:GetSkillScopeParam()
  local scopeParamPreview = table.cloneconf(scopeParam)
  local utilDataSvc = self._world:GetService("UtilData")
  local monsterMobility = utilDataSvc:GetAIMobilityConfig(monsterEntity)
  local configSvc = self._world:GetService("Config")
  local monsterConfigData = configSvc:GetMonsterConfigData()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local canMove = monsterConfigData:CanMove(monsterID)
  local listWalkRangeList
  if canMove and 0 < monsterMobility then
    local cbFilter = Callback:New(1, utilDataSvc.IsPosAccessibleMonsterMove, utilDataSvc)
    local monsterBlockData = monsterEntity:MonsterID():GetMonsterBlockData()
    listWalkRangeList = ComputeScopeRange.ComputeRange_PreviewWithStepAndBlock(monsterPos, bodyArea, true, monsterMobility, monsterBlockData, cbFilter)
  end
  local listWalkRange = {}
  for key, value in pairs(listWalkRangeList) do
    local posWalk = value:GetPos()
    local isBlocked = false
    isBlocked = utilDataSvc:IsPosBlock(posWalk, monsterEntity:MonsterID():GetMonsterBlockData())
    if isBlocked then
      local posPlayer = self._world:Player():GetPreviewTeamEntity():GetGridPosition()
      if posPlayer == posWalk or utilDataSvc:GetMonsterAtPos(posWalk) then
        isBlocked = false
      end
    end
    if false == isBlocked then
      listWalkRange[#listWalkRange + 1] = posWalk
    end
  end
  local casterDirList = {
    Vector2(0, 1),
    Vector2(0, -1),
    Vector2(1, 0),
    Vector2(-1, 0)
  }
  local skillAttackRange = {}
  for i, movePos in ipairs(listWalkRange) do
    for k, dir in pairs(casterDirList) do
      local scopeResult = scopeCalculator:ComputeScopeRange(scopeType, scopeParamPreview, movePos, bodyArea, dir, skillTargetType, movePos, monsterEntity)
      local range = self:_FilerSkillRange(scopeResult:GetWholeGridRange())
      table.Vector2Append(skillAttackRange, range, skillAttackRange)
    end
  end
  local renderEntityService = self._world:GetService("RenderEntity")
  for _, monster in ipairs(sameGroupMonsterList) do
    if monster:GetID() ~= monsterEntity:GetID() then
      utilCalcSvc:SetEntityBlockFlag(monster, monster:GetGridPosition())
    end
  end
  renderEntityService:CreatePreviewAreaOutlineEntity(skillAttackRange, EntityConfigIDRender.MoveRange)
end

function PreviewMonsterActionSystem_Render:_ShowShowSelectMonsterScopeAndTips(monsterEntity, skillConfigData, skillPreviewParam)
  local monsterClassID = skillPreviewParam.monsterClassID
  local moveScopeType = skillPreviewParam.moveScopeType
  local moveScopeParam = skillPreviewParam.moveScopeParam
  local attackScopeType = skillPreviewParam.attackScopeType
  local attackScopeParam = skillPreviewParam.attackScopeParam
  local skillTargetType = skillConfigData:GetSkillTargetType()
  local monsterEntityList = {}
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    if table.icontains(monsterClassID, monsterEntity:MonsterID():GetMonsterClassID()) then
      table.insert(monsterEntityList, monsterEntity)
    end
  end
  if table.count(monsterEntityList) == 0 then
    return
  end
  local renderEntityService = self._world:GetService("RenderEntity")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  for _, monsterEntity in ipairs(monsterEntityList) do
    local monsterPos = monsterEntity:GetGridPosition()
    local monsterDir = monsterEntity:GetGridDirection()
    local bodyArea = monsterEntity:BodyArea():GetArea()
    local moveScopeResult = scopeCalculator:ComputeScopeRange(moveScopeType, moveScopeParam, monsterPos, bodyArea, monsterDir, skillTargetType, monsterPos, monsterEntity)
    local attackScopeResult = scopeCalculator:ComputeScopeRange(attackScopeType, attackScopeParam, monsterPos, bodyArea, monsterDir, skillTargetType, monsterPos, monsterEntity)
    local arrowPosList = moveScopeResult:GetAttackRange()
    local skillAttackRange = attackScopeResult:GetAttackRange()
    local posPlayer = self._world:Player():GetPreviewTeamEntity():GetGridPosition()
    table.removev(arrowPosList, posPlayer)
    for _, targetPos in ipairs(arrowPosList) do
      if false == self:_IsPosInMine(targetPos, monsterPos, bodyArea) then
        local arrowDir = self:_CalcMoveArrowDir(monsterPos, bodyArea, targetPos)
        renderEntityService:CreateMoveRangeArrowEntity(targetPos, arrowDir, EntityConfigIDRender.MoveRangeArrow)
      end
    end
    renderEntityService:CreatePreviewAreaOutlineEntity(skillAttackRange, EntityConfigIDRender.MoveRange)
  end
end
