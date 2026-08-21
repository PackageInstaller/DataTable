_class("PreviewMonsterTrapService", BaseService)
PreviewMonsterTrapService = PreviewMonsterTrapService

function PreviewMonsterTrapService:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
end

function PreviewMonsterTrapService:Initialize()
end

function PreviewMonsterTrapService:Dispose()
end

function PreviewMonsterTrapService:CheckPreviewMonsterAction(posTouch, offset)
  local isTouchMonster, touchMonsterEntityID = self:IsClickMonster(posTouch, offset)
  if isTouchMonster then
    self:ClearPreviewMonster(posTouch)
    self:ClearPreviewTrap(posTouch)
    self:ShowInUIBar(touchMonsterEntityID)
    self:_ShowPreviewMonsterAction(touchMonsterEntityID, posTouch, offset)
    return
  end
  local isTouchTrap, touchTrapEntityID = self:IsClickTrap(posTouch, offset)
  if isTouchTrap then
    self:ClearPreviewMonster(posTouch)
    self:ClearPreviewTrap(posTouch)
    self:_ShowPreviewTrapAction(touchTrapEntityID, posTouch, offset)
    return
  end
  self:ClearMonsterTrapPreview()
end

function PreviewMonsterTrapService:ClearMonsterTrapPreview()
  if self:ClearPreviewMonster() then
    self:HideHideInUIBar()
    return
  end
  if self:ClearPreviewTrap() then
    self:HideHideInUIBar()
    return
  end
end

function PreviewMonsterTrapService:IsClickMonster(touchPosition, offset)
  local previewEnvCmpt = self._world:GetPreviewEntity():PreviewEnv()
  local clickCount = previewEnvCmpt:GetMonsterClickCount()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(group:GetEntities()) do
    local buffView = e:BuffView()
    if e:IsOnGridPosition(touchPosition) then
      if EDITOR then
        local aiDebugModule = GameGlobal.GetModule(AIDebugModule)
        aiDebugModule:SetSelectMonsterID(e:MonsterID():GetMonsterID(), e:GetID())
      end
      if not buffView:HasBuffEffect(BuffEffectType.NotShowBossHP) then
        if e:HasRide() then
          if e:Ride():IsOnlyRiderCanClick() then
            if e:Ride():GetRiderID() == e:GetID() then
              return true, e:GetID()
            end
          else
            local isRider = math.fmod(clickCount, 2) == 0
            if isRider then
              previewEnvCmpt:SetMonsterClickCount(clickCount + 1)
              return true, e:Ride():GetRiderID()
            else
              previewEnvCmpt:SetMonsterClickCount(clickCount + 1)
              return true, e:Ride():GetMountID()
            end
          end
        else
          previewEnvCmpt:SetMonsterClickCount(0)
          return true, e:GetID()
        end
      end
    end
  end
  previewEnvCmpt:SetMonsterClickCount(0)
  return false, nil
end

function PreviewMonsterTrapService:IsClickTrap(posTouch, offset)
  local listFindTrapID = {}
  listFindTrapID = self:_FindTrapByPos(posTouch)
  if table.count(listFindTrapID) > 0 then
    local sortTrapID = self:_SortByTrapLevel(listFindTrapID)
    local configService = self._world:GetService("Config")
    for i = 1, sortTrapID:Size() do
      local sortData = sortTrapID:GetAt(i)
      local entityTrap = sortData:GetTrapEntity()
      local utilSvc = self._world:GetService("UtilData")
      local skillID = utilSvc:GetTrapPreviewSkillID(entityTrap)
      if skillID and 0 < skillID then
        local skillConfigData = configService:GetSkillConfigData(skillID, entityTrap)
        local skillPreviewType = skillConfigData:GetSkillPreviewType()
        if SkillPreviewType.Tips == skillPreviewType or SkillPreviewType.ScopeAndTips == skillPreviewType or SkillPreviewType.TrapActiveSkill == skillPreviewType or SkillPreviewType.TrapDesc == skillPreviewType or SkillPreviewType.TrapScopeAndTips == skillPreviewType or SkillPreviewType.PetTrapMoveArrow == skillPreviewType then
          return true, sortData:GetTrapID()
        end
      else
        local trapConfigData = configService:GetTrapConfigData()
        if trapConfigData:IsShowDescTips(entityTrap:TrapRender():GetTrapID()) then
          return true, sortData:GetTrapID()
        end
      end
    end
  end
  return false, nil
end

function PreviewMonsterTrapService:ClearPreviewMonster()
  local reBoard = self._world:GetRenderBoardEntity()
  if EDITOR then
    local aiDebugModule = GameGlobal.GetModule(AIDebugModule)
    aiDebugModule:ClearSelectMonsterID()
  end
  if reBoard:HasPreviewMonsterAction() then
    local previewCmpt = reBoard:PreviewMonsterAction()
    if previewCmpt:IsShowMonsterAction() then
      local entityID = previewCmpt:GetMonsterEntityID()
      local e = self._world:GetEntityByID(entityID)
      Log.notice("Entity ID:", e:GetID(), "GridPosition:", tostring(e:GridLocation().Position))
      reBoard:ReplacePreviewMonsterAction(false, entityID)
      self:_HidePreviewMonster(entityID, reBoard)
      return true
    end
  end
  return false
end

function PreviewMonsterTrapService:HidePreviewTrap()
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:DestroyMonsterPreviewAreaOutlineEntity()
  self._world:GetService("PreviewActiveSkill"):_RevertAllConvertElement(true)
  local prvwActiveSkillSvc = self._world:GetService("PreviewActiveSkill")
  prvwActiveSkillSvc:HideSkillTips()
end

function PreviewMonsterTrapService:ClearPreviewTrap()
  local reBoard = self._world:GetRenderBoardEntity()
  if reBoard:HasPreviewTrapAction() then
    local previewCmpt = reBoard:PreviewTrapAction()
    if previewCmpt:IsShowTrapAction() then
      reBoard:ReplacePreviewTrapAction()
      previewCmpt:ShowTrapAction(false)
      self:HidePreviewTrap()
      return true
    end
  end
  return false
end

function PreviewMonsterTrapService:_ShowPreviewMonsterAction(monsterEntityID, touchPosition, offset)
  local reBoard = self._world:GetRenderBoardEntity()
  reBoard:ReplacePreviewMonsterAction(true, monsterEntityID)
  local previewCmpt = reBoard:PreviewMonsterAction()
  previewCmpt:SetTouchPosition(touchPosition, offset)
end

function PreviewMonsterTrapService:_ShowPreviewTrapAction(trapEntityID, touchPosition, offset)
  local reBoard = self._world:GetRenderBoardEntity()
  if not reBoard:HasPreviewTrapAction() then
    reBoard:AddPreviewTrapAction()
  end
  reBoard:ReplacePreviewTrapAction()
  local previewCmpt = reBoard:PreviewTrapAction()
  previewCmpt:ShowTrapAction(true)
  previewCmpt:SetTrapPreviewData(trapEntityID, touchPosition, offset)
end

function PreviewMonsterTrapService:ShowInUIBar(entityID)
  local utilDataSvc = self._world:GetService("UtilData")
  local entity = self._world:GetEntityByID(entityID)
  if self:IsNeedShowUIHPBar(entityID) then
    local HPCmpt = entity:HP()
    local maxHP = HPCmpt:GetMaxHP()
    local HP = HPCmpt:GetRedHP()
    local hpPercent = HP / maxHP
    local shieldValue = HPCmpt:GetShieldValue()
    local templateID, hpBarType, elementType
    local sepHPList = entity:HP():GetHPLockSepList()
    local sepHpUnlockedList = entity:HP():GetHPLockUnlockedIndexList()
    local showCurseHp = HPCmpt:GetShowCurseHp()
    local curseHpVal = HPCmpt:GetCurseHpValue()
    local isWorldBoss = false
    local worldBossCurHPImageID = 0
    local worldBossPreHPImageID = 0
    local worldBossCurStageHpPercent = 0
    local worldBossTotalDamage = 0
    local worldBossCurStage = 0
    local UIBossHPType = BossUIHPType.Normal
    if entity:MonsterID() then
      templateID = entity:MonsterID():GetMonsterID()
      local cMonsterId = entity:MonsterID()
      if cMonsterId:IsWorldBoss() then
        isWorldBoss = true
        local hpCmpt = entity:HP()
        worldBossCurHPImageID = hpCmpt:GetCurStageImage()
        worldBossPreHPImageID = hpCmpt:GetPreStageImage()
        worldBossCurStageHpPercent = 1 - hpCmpt:GetCurStageHPPercent()
        worldBossTotalDamage = BattleStatHelper.GetMonsterBeHitDamageValue(entityID)
        worldBossCurStage = hpCmpt:GetCurStage()
      end
      local monsterConfigData = self._configService:GetMonsterConfigData()
      UIBossHPType = monsterConfigData:GetBossUIHPType(templateID)
      if entity:HasBoss() then
        if entity:MonsterID():IsEliteMonster() then
          hpBarType = HPBarType.EliteBoss
        else
          hpBarType = HPBarType.Boss
        end
      elseif entity:MonsterID():IsEliteMonster() then
        hpBarType = HPBarType.EliteMonster
      else
        hpBarType = HPBarType.NormalMonster
      end
      elementType = utilDataSvc:GetEntityAttributeByName(entity, "Element")
    end
    if entity:TrapID() then
      templateID = entity:TrapID():GetTrapID()
      hpBarType = HPBarType.Trap
    end
    local greyVal = utilDataSvc:GetEntityBuffValue(entity, "GreyHPValue") or 0
    local hpEnergyBuffEffectType = utilDataSvc:GetEntityBuffValue(entity, "HPEnergyBuffEffectType")
    local hpEnergyVal = 0
    local maxHPEnergyVal = 0
    if hpEnergyBuffEffectType then
      hpEnergyVal = utilDataSvc:GetBuffLayer(entity, hpEnergyBuffEffectType)
      local bvinst = InnerGameHelperRender.GetSingleBuffByBuffEffect(entityID, hpEnergyBuffEffectType)
      if bvinst then
        maxHPEnergyVal = bvinst:BuffConfigData():GetMaxLayerCount()
      end
      maxHPEnergyVal = math.max(hpEnergyVal, maxHPEnergyVal)
    end
    local info = {
      pstId = entityID,
      tplId = templateID,
      HPBarType = hpBarType,
      sepHPList = sepHPList,
      sepHpUnlockedList = sepHpUnlockedList,
      entity = entity,
      percent = hpPercent,
      hP = HP,
      HP = HP,
      maxHP = maxHP,
      shieldValue = shieldValue,
      curElement = elementType,
      attack = utilDataSvc:GetEntityAttack(entity) or 0,
      greyVal = greyVal,
      hpEnergyVal = hpEnergyVal,
      maxHPEnergyVal = maxHPEnergyVal,
      showCurseHp = showCurseHp,
      curseHpVal = curseHpVal,
      isWorldBoss = isWorldBoss,
      worldBossCurImageID = worldBossCurHPImageID,
      worldBossPreImageID = worldBossPreHPImageID,
      worldBossCurStageHpPercent = worldBossCurStageHpPercent,
      worldBossTotalDamage = worldBossTotalDamage,
      worldBossCurStage = worldBossCurStage,
      UIBossHPType = UIBossHPType
    }
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PreviewMonsterReplaceHPBar, info)
  end
end

function PreviewMonsterTrapService:HideHideInUIBar()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.RevokePreviewMonsterReplaceHPBar)
end

function PreviewMonsterTrapService:_HidePreviewMonster(monsterEntityID, boardEntity)
  local previewCmpt = boardEntity:PreviewMonsterAction()
  previewCmpt:KillPreviewTask()
  local renderEntityService = self._world:GetService("RenderEntity")
  local entityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterAttackRange)
  renderEntityService:DestroyMonsterPreviewAreaOutlineEntity()
  local previewActiveSkillSvc = self._world:GetService("PreviewActiveSkill")
  self._world:GetService("MonsterShowRender"):MonsterGridAnimDown()
  local previewActiveSkillSvc = self._world:GetService("PreviewActiveSkill")
  previewActiveSkillSvc:HideSkillTips()
  self:_RemoveMonsterAttackText(monsterEntityID)
  local monsterEntity = self._world:GetEntityByID(monsterEntityID)
  if monsterEntity then
    local resContainer = monsterEntity:SkillRoutine():GetResultContainer()
    if resContainer then
      resContainer:Clear()
    end
  end
end

function PreviewMonsterTrapService:_RemoveMonsterAttackText(monsterEntityID)
  local monsterEntity = self._world:GetEntityByID(monsterEntityID)
  local holderCmp = monsterEntity:EffectHolder()
  if not holderCmp then
    return
  end
  local idDic = holderCmp:GetEffectIDEntityDic()
  local entityList = idDic[BattleConst.MonsterAttackRangeTextEffect]
  if entityList then
    for k, entityId in pairs(entityList) do
      local entity = self._world:GetEntityByID(entityId)
      if entity then
        self._world:DestroyEntity(entity)
      end
    end
    idDic[BattleConst.MonsterAttackRangeTextEffect] = nil
  end
end

function PreviewMonsterTrapService:IsNeedShowUIHPBar(entityID)
  local entity = self._world:GetEntityByID(entityID)
  if entity:HasBoss() then
    return true
  else
    return entity:HasHP() and entity:HP():IsShowHPSlider()
  end
end

function PreviewMonsterTrapService:_FindTrapByPos(posTouch)
  local listFindTrapID = {}
  local teTrap = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  for _, eTrap in ipairs(teTrap) do
    if eTrap:TrapRender():IsHasShow() and eTrap:IsViewVisible() then
      local cBodyArea = eTrap:BodyArea()
      local tv2Relative = cBodyArea and cBodyArea:GetArea() or {
        Vector2.zero
      }
      local v2GridPos = eTrap:GetGridPosition()
      for __, v2Relative in ipairs(tv2Relative) do
        if posTouch == v2GridPos + v2Relative then
          table.insert(listFindTrapID, eTrap:GetID())
        end
      end
    end
  end
  return listFindTrapID
end

function PreviewMonsterTrapService:_SortByTrapLevel(listTrapEntityID)
  local sortTrapID = SortedArray:New(Algorithm.COMPARE_CUSTOM, SortData_TrapLevel.CompareByTrapLevel)
  for i = 1, #listTrapEntityID do
    sortTrapID:Insert(SortData_TrapLevel:New(self._world, listTrapEntityID[i]))
  end
  return sortTrapID
end

_class("SortData_TrapLevel", Object)
SortData_TrapLevel = SortData_TrapLevel

function SortData_TrapLevel:Constructor(world, nEntityID)
  self.m_entityTrap = world:GetEntityByID(nEntityID)
  self.m_nTrapID = nEntityID
end

function SortData_TrapLevel:GetTrapID()
  return self.m_nTrapID
end

function SortData_TrapLevel:GetTrapEntity()
  return self.m_entityTrap
end

function SortData_TrapLevel.CompareByTrapLevel(sortDataA, sortDataB)
  local entityA = sortDataA:GetTrapEntity()
  local trapRenderA = entityA:TrapRender()
  local entityB = sortDataB:GetTrapEntity()
  local trapRenderB = entityB:TrapRender()
  local showLevelA = trapRenderA:GetTrapShowLevel()
  local showLevelB = trapRenderB:GetTrapShowLevel()
  if showLevelA ~= BattleConst.TrapShowLevelDefault or showLevelB ~= BattleConst.TrapShowLevelDefault then
    return showLevelA - showLevelB
  end
  local nTrapLevelA = trapRenderA:GetTrapLevel()
  local nTrapLevelB = trapRenderB:GetTrapLevel()
  return nTrapLevelA - nTrapLevelB
end

function PreviewMonsterTrapService:ShowPreviewTrap(trapEntityID, touchPosition, offset)
  self:_ShowPreviewTrapAction(trapEntityID, touchPosition, offset)
end

function PreviewMonsterTrapService:CheckPreviewTrapAction(posTouch, offset)
  local isTouchTrap, touchTrapEntityID = self:IsClickTrap(posTouch, offset)
  if isTouchTrap then
    self:ClearPreviewMonster(posTouch)
    self:ClearPreviewTrap(posTouch)
    self:_ShowPreviewTrapAction(touchTrapEntityID, posTouch, offset)
    return
  end
  self:ClearMonsterTrapPreview()
end
