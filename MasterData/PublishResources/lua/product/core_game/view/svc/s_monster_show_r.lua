_class("MonsterShowRenderService", BaseService)
MonsterShowRenderService = MonsterShowRenderService

function MonsterShowRenderService:Constructor(world)
end

function MonsterShowRenderService:CreateMonsterHPEntity(eMonster)
  local sEntity = self._world:GetService("RenderEntity")
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local cMonsterID = eMonster:MonsterID()
  local monsterId = cMonsterID:GetMonsterID()
  local monsterResPath = monsterConfigData:GetMonsterResPath(monsterId)
  local buffCmpt = eMonster:BuffView()
  local petEID = buffCmpt:GetBuffValue("ChangeModelWithPetIndex")
  if petEID then
    local petEntity = self._world:GetEntityByID(petEID)
    monsterResPath = petEntity:Asset():GetResPath()
  end
  eMonster:ReplaceAsset(NativeUnityPrefabAsset:New(monsterResPath, false))
  local renderEntitySvc = self._world:GetService("RenderEntity")
  renderEntitySvc:ModifyElementMaterial(eMonster)
  local utilDataSvc = self._world:GetService("UtilData")
  local cHP = eMonster:HP()
  local maxhp = utilDataSvc:GetCurrentLogicMaxHP(eMonster)
  local curHP = maxhp
  if utilDataSvc:IsUseCurHPInitRedHP(eMonster) then
    curHP = utilDataSvc:GetCurrentLogicHP(eMonster)
  end
  eMonster:ReplaceRedAndMaxHP(curHP, maxhp)
  local hpOffset = monsterConfigData:GetMonsterHPHeightOffset(monsterId)
  cHP:SetHPOffset(hpOffset)
  if not table.icontains(BattleConst.NotShowHUDHPMonsters, cMonsterID:GetMonsterClassID()) then
    local hpConfigID = 0
    if eMonster:HasBoss() then
      hpConfigID = EntityConfigIDRender.BossHPSlider
    else
      hpConfigID = EntityConfigIDRender.HPSlider
    end
    local eMonsterHP = sEntity:CreateRenderEntity(hpConfigID)
    local resPath = eMonsterHP:Asset():GetResPath()
    eMonsterHP:ReplaceAsset(NativeUnityPrefabAsset:New(resPath, false))
    local go = eMonsterHP:View().ViewWrapper.GameObject
    local uiview = go:GetComponent("UIView")
    local uiRoot = uiview:GetUIComponent("RectTransform", "Root")
    local v2Size = Vector2.zero
    v2Size.x = BattleConst.HUDHPSliderDefaultWidth * monsterConfigData:GetMonsterHUDHPWidthScale(monsterId)
    v2Size.y = uiRoot.sizeDelta.y
    uiRoot.sizeDelta = v2Size
    local redImg = uiview:GetUIComponent("Image", "realRed")
    local spriteRed = uiview:GetUIComponent("Image", "spriteRed")
    local spriteBlue = uiview:GetUIComponent("Image", "spriteBlue")
    local spriteType3 = uiview:GetUIComponent("Image", "spriteType3")
    local hudHPBarType = monsterConfigData:GetMonsterHUDHPBarType(monsterId)
    if hudHPBarType == MonsterHUDHPBarType.Red then
      redImg.sprite = spriteRed.sprite
    elseif hudHPBarType == MonsterHUDHPBarType.Blue then
      redImg.sprite = spriteBlue.sprite
    elseif hudHPBarType == MonsterHUDHPBarType.Purple then
      redImg.sprite = spriteType3.sprite
    end
    local sliderEntityID = eMonsterHP:GetID()
    cHP:SetHPSliderEntityID(sliderEntityID)
    local utilDataSvc = self._world:GetService("UtilData")
    local elementType = utilDataSvc:GetEntityElementPrimaryType(eMonster)
    TaskManager:GetInstance():CoreGameStartTask(InnerGameHelperRender:GetInstance().SetHpSliderElementIcon, InnerGameHelperRender:GetInstance(), eMonsterHP, elementType)
    return eMonsterHP
  end
end

function MonsterShowRenderService:CreateMonsterHPEntities(eMonsters)
  for _, v in ipairs(eMonsters) do
    self:CreateMonsterHPEntity(v)
  end
end

function MonsterShowRenderService:ShowSummonMonster(TT, monsterEntity, summonTransformData, onlyShow)
  self:CreateMonsterHPEntity(monsterEntity)
  local cHP = monsterEntity:HP()
  local eidHPBar = cHP:GetHPSliderEntityID()
  local hpBarEntity = self._world:GetEntityByID(eidHPBar)
  local monsterIDCmpt = monsterEntity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local bodyArea = monsterEntity:BodyArea()
  local summonPos = summonTransformData:GetPosition()
  local summonDir = summonTransformData:GetRotation()
  local sPiece = self._world:GetService("Piece")
  for i, p in ipairs(bodyArea:GetArea()) do
    local pos = p + summonPos
    sPiece:SetPieceAnimDown(pos)
  end
  self:_PlayBornStory(TT, monsterEntity:GetID(), monsterID)
  self:_AttachBornEffect(monsterEntity)
  monsterEntity:SetLocation(summonPos + monsterEntity:GetGridOffset(), summonDir)
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:CreateMonsterAreaOutlineEntity(monsterEntity)
  local buffCmpt = monsterEntity:BuffView()
  local modelPetIndex = buffCmpt:GetBuffValue("ChangeModelWithPetIndex")
  if modelPetIndex then
    monsterEntity:PlayMaterialAnim("common_shadoweff")
  end
  if onlyShow then
    monsterEntity:SetViewVisible(true)
  else
    local showAppearTaskID = self:_PlayMonsterBorn(TT, monsterEntity, summonPos)
    while not TaskHelper:GetInstance():IsTaskFinished(showAppearTaskID) do
      YIELD(TT)
    end
  end
  self:_ShowBossUIHPBar(true)
  if hpBarEntity then
    self:ShowMonsterHPBar(TT, monsterEntity, hpBarEntity)
  end
  self:PlayAppearTriggeredTrap(TT, monsterEntity)
  self:PlayHideTrap(TT, monsterEntity)
end

function MonsterShowRenderService:_MoveEntity(TT, entityWork, worldPos, moveTime)
  if nil == entityWork then
    return
  end
  if not entityWork:View() then
    return
  end
  local trajectoryObject = entityWork:View():GetGameObject()
  local transWork = trajectoryObject.transform
  local easeWork = transWork:DOMove(worldPos, moveTime / 1000, false):SetEase(DG.Tweening.Ease.InOutSine):OnComplete(function()
    entityWork:SetLocation(worldPos)
  end)
  YIELD(TT, moveTime)
  entityWork:SetLocation(worldPos)
end

function MonsterShowRenderService:ShowSummonMonsterFromCage(TT, monsterEntity, summonTransformData, onlyShow, fromCageParam)
  local isFromCage = true
  self:CreateMonsterHPEntity(monsterEntity)
  if isFromCage then
    local delayTime = fromCageParam.cageSummonDelayTime or 1500
    if 0 < delayTime then
      YIELD(TT, 1500)
    end
  end
  local cHP = monsterEntity:HP()
  local eidHPBar = cHP:GetHPSliderEntityID()
  local hpBarEntity = self._world:GetEntityByID(eidHPBar)
  local monsterIDCmpt = monsterEntity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local bodyArea = monsterEntity:BodyArea()
  local summonPos = summonTransformData:GetPosition()
  local summonDir = summonTransformData:GetRotation()
  local sPiece = self._world:GetService("Piece")
  for i, p in ipairs(bodyArea:GetArea()) do
    local pos = p + summonPos
    sPiece:SetPieceAnimDown(pos)
  end
  self:_PlayBornStory(TT, monsterEntity:GetID(), monsterID)
  self:_AttachBornEffect(monsterEntity)
  monsterEntity:SetLocation(summonPos + monsterEntity:GetGridOffset(), summonDir)
  local innerWaitTaskIDList = {}
  if isFromCage then
    local downDis = fromCageParam.cageSummonUnderDis or -2.4
    local moveTime = fromCageParam.cageSummonMoveTime or 1000
    local gridWorldPos = monsterEntity:GetPosition()
    local gridWorldFrom = UnityEngine.Vector3.New()
    gridWorldFrom.x = gridWorldPos.x
    gridWorldFrom.y = gridWorldPos.y + downDis
    gridWorldFrom.z = gridWorldPos.z
    monsterEntity:SetLocation(gridWorldFrom, summonDir)
    local id = TaskManager:GetInstance():CoreGameStartTask(self._MoveEntity, self, monsterEntity, gridWorldPos, moveTime)
    if id then
      table.insert(innerWaitTaskIDList, id)
    end
    local matAnim = fromCageParam.cageSummonMatAnim or "effanim_2802801_call_m"
    monsterEntity:PlayMaterialAnim(matAnim)
  end
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:CreateMonsterAreaOutlineEntity(monsterEntity)
  local buffCmpt = monsterEntity:BuffView()
  local modelPetIndex = buffCmpt:GetBuffValue("ChangeModelWithPetIndex")
  if modelPetIndex then
    monsterEntity:PlayMaterialAnim("common_shadoweff")
  end
  if onlyShow then
    monsterEntity:SetViewVisible(true)
  else
    local showAppearTaskID = self:_PlayMonsterBornFromCage(TT, monsterEntity, summonPos)
    while not TaskHelper:GetInstance():IsTaskFinished(showAppearTaskID) do
      YIELD(TT)
    end
  end
  self:_ShowBossUIHPBar(true)
  if isFromCage then
    local cHP = monsterEntity:HP()
    cHP:SetShowHPSliderState(false)
  elseif hpBarEntity then
    self:ShowMonsterHPBar(TT, monsterEntity, hpBarEntity)
  end
  self:PlayAppearTriggeredTrap(TT, monsterEntity)
  self:PlayHideTrap(TT, monsterEntity)
  while not TaskHelper:GetInstance():IsAllTaskFinished(innerWaitTaskIDList) do
    YIELD(TT)
  end
  if isFromCage and hpBarEntity then
    self:ShowMonsterHPBar(TT, monsterEntity, hpBarEntity)
  end
end

function MonsterShowRenderService:PlayAppearTriggeredTrap(TT, monsterEntity)
  if not monsterEntity:HasAppearTriggerTrap() then
    return
  end
  local cAppearTriggerTrap = monsterEntity:AppearTriggerTrap()
  local tEntities, tResults = cAppearTriggerTrap:GetData()
  local t = {}
  local trapSvc = self._world:GetService("TrapRender")
  for _, eTrap in ipairs(tEntities) do
    trapSvc:PlayTrapTriggerSkill(TT, eTrap, false, monsterEntity)
  end
end

function MonsterShowRenderService:PlayHideTrap(TT, monsterEntity)
  local trapSvc = self._world:GetService("TrapRender")
  local pos = monsterEntity:GetGridPosition()
  local tv2Body = monsterEntity:BodyArea():GetArea()
  for _, v2Body in ipairs(tv2Body) do
    local v2 = pos + v2Body
    trapSvc:ShowHideTrapAtPos(v2, false)
  end
end

function MonsterShowRenderService:ShowMonsters(TT, eMonsters, bornPosList)
  if not eMonsters or table.count(eMonsters) <= 0 then
    Log.fatal("### [ShowMonsters] eMonsters no data")
    return
  end
  local sPlaySkill = self._world:GetService("PlaySkill")
  local sPiece = self._world:GetService("Piece")
  sPlaySkill:ResetWaitFreeList()
  local listWaitTask_ShowMonster = {}
  for i, casterEntity in ipairs(eMonsters) do
    local monsterIDCmpt = casterEntity:MonsterID()
    local monsterID = monsterIDCmpt:GetMonsterID()
    while not casterEntity:View() do
      YIELD(TT)
    end
    local cHP = casterEntity:HP()
    cHP:SetShowHPSliderState(false)
    local bodyArea = casterEntity:BodyArea()
    if not bodyArea then
      Log.exception("[MonsterShow] 怪物没有BodyArea，id:", monsterID)
      return
    end
    local birthPos = casterEntity:GetGridPosition()
    if bornPosList and i <= #bornPosList then
      birthPos = bornPosList[i]
    end
    local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
    if skillEffectResultContainer then
      local teleportEffectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport, 1)
      if teleportEffectResult then
        birthPos = teleportEffectResult:GetPosOld()
      end
    end
    if casterEntity:HasOutsideRegion() then
      local OutsideRegion = casterEntity:OutsideRegion()
      local boardIndex = OutsideRegion:GetBoardIndex()
      local renderBoardEntity = self._world:GetRenderBoardEntity()
      local renderMultiBoardCmpt = renderBoardEntity:RenderMultiBoard()
      local boardRoot = renderMultiBoardCmpt:GetMultiBoardRootGameObject(boardIndex)
      if boardRoot then
        casterEntity:View():GetGameObject().transform.parent = boardRoot.transform
      end
    else
      local gridPos = birthPos
      for i, p in ipairs(bodyArea:GetArea()) do
        local pos = p + gridPos
        sPiece:SetPieceAnimDown(pos)
      end
    end
    self:_PlayBornStory(TT, casterEntity:GetID(), monsterID)
    self:_AttachBornEffect(casterEntity)
    if casterEntity:HasBoss() then
      casterEntity:SetViewVisible(false)
    end
    casterEntity:SetLocation(birthPos + casterEntity:GetGridOffset(), casterEntity:GetGridDirection())
    local renderEntityService = self._world:GetService("RenderEntity")
    renderEntityService:CreateMonsterAreaOutlineEntity(casterEntity)
    local showAppearTaskID = self:_PlayMonsterBorn(TT, casterEntity, birthPos)
    if 0 < showAppearTaskID then
      table.insert(listWaitTask_ShowMonster, showAppearTaskID)
    end
    local buffCmpt = casterEntity:BuffView()
    local modelPetIndex = buffCmpt:GetBuffValue("ChangeModelWithPetIndex")
    if modelPetIndex then
      casterEntity:PlayMaterialAnim("common_shadoweff")
    end
    if casterEntity:HasOutsideRegion() then
      casterEntity:View():GetGameObject().transform.localEulerAngles = Vector3(0, 0, 0)
    end
  end
  local listWaitTask = sPlaySkill:GetWaitFreeList()
  table.appendArray(listWaitTask_ShowMonster, listWaitTask)
  while not TaskHelper:GetInstance():IsAllTaskFinished(listWaitTask_ShowMonster) do
    YIELD(TT)
  end
  for i, casterEntity in ipairs(eMonsters) do
    if casterEntity:HasBoss() then
      casterEntity:SetViewVisible(true)
    end
  end
  for i, casterEntity in ipairs(eMonsters) do
    self:_SyncDamageEffect(casterEntity)
  end
  self:_ShowBossUIHPBar()
  local tTaskIDs = {}
  for _, eMonster in ipairs(eMonsters) do
    local id = TaskManager:GetInstance():CoreGameStartTask(self.PlayAppearTriggeredTrap, self, eMonster)
    if id then
      table.insert(tTaskIDs, id)
    end
    self:PlayHideTrap(TT, eMonster)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(tTaskIDs) do
    YIELD(TT)
  end
end

function MonsterShowRenderService:_PlayMonsterBorn(TT, casterEntity, bornPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local nAppearSkillID = utilDataSvc:GetAppearSkillId(casterEntity)
  if nAppearSkillID and not utilDataSvc:IsArchivedBattle() then
    return self:_ShowAppearSkill(casterEntity, nAppearSkillID)
  else
    if not casterEntity:HasOutsideRegion() then
      self:_ShowBornEffect(casterEntity, bornPos)
    end
    casterEntity:SetViewVisible(true)
    local hpCmpt = casterEntity:HP()
    local hpSliderID = hpCmpt:GetHPSliderEntityID()
    local hpSliderEntity = self._world:GetEntityByID(hpSliderID)
    self:ShowMonsterHPBar(TT, casterEntity, hpSliderEntity)
  end
  return -1
end

function MonsterShowRenderService:_PlayMonsterBornFromCage(TT, casterEntity, bornPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local nAppearSkillID = utilDataSvc:GetAppearSkillId(casterEntity)
  if nAppearSkillID and not utilDataSvc:IsArchivedBattle() then
    return self:_ShowAppearSkill(casterEntity, nAppearSkillID)
  else
    casterEntity:SetViewVisible(true)
    local hpCmpt = casterEntity:HP()
    local hpSliderID = hpCmpt:GetHPSliderEntityID()
    local hpSliderEntity = self._world:GetEntityByID(hpSliderID)
    self:ShowMonsterHPBar(TT, casterEntity, hpSliderEntity)
  end
  return -1
end

function MonsterShowRenderService:_PlayBornStory(TT, casterEntityID, monsterTemplateID)
  local sInnerStory = self._world:GetService("InnerStory")
  sInnerStory:CheckMonsterShowAndDeadStoryTips(StoryMonsterShowType.AfterShow, monsterTemplateID, casterEntityID)
  if sInnerStory:CheckMonsterShowAndDeadStoryBanner(StoryShowType.BeginMonsterShow, monsterTemplateID) then
    InnerGameHelperRender:GetInstance():IsUIBannerComplete(TT)
  end
end

function MonsterShowRenderService:_AttachBornEffect(casterEntity)
  local sEffect = self._world:GetService("Effect")
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local monsterIDCmpt = casterEntity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local permanentEffectArray = monsterConfigData:GetMonsterPermanentEffectID(monsterID)
  self:_ShowAppearEffect(sEffect, casterEntity, permanentEffectArray, 0)
  local idleEffectArray = monsterConfigData:GetMonsterIdleEffectID(monsterID)
  self:_ShowAppearEffect(sEffect, casterEntity, idleEffectArray, 1)
  local archEffCom = casterEntity:ArchivedEffect()
  if archEffCom then
    self:_ShowAppearEffect(sEffect, casterEntity, archEffCom.EffectIDs, 2)
  end
  self:_CreateEntityEliteEffect(casterEntity, monsterID)
end

function MonsterShowRenderService:_SyncDamageEffect(casterEntity)
  if not casterEntity:HasMonsterID() then
    return
  end
  if not casterEntity:MonsterID():GetDamageSyncMonsterID() then
    return
  end
  local lineEffectID = casterEntity:MonsterID():GetDamageSyncEffect()
  if not lineEffectID then
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local damageSyncEntityList = utilDataSvc:FindSyncMonsterTargetList(casterEntity)
  local effectService = self._world:GetService("Effect")
  local effectLineRenderer = casterEntity:EffectLineRenderer()
  if not effectLineRenderer then
    casterEntity:AddEffectLineRenderer()
    effectLineRenderer = casterEntity:EffectLineRenderer()
  end
  local effectHolderCmpt = casterEntity:EffectHolder()
  if not effectHolderCmpt then
    casterEntity:AddEffectHolder()
    effectHolderCmpt = casterEntity:EffectHolder()
  end
  for i, entity in ipairs(damageSyncEntityList) do
    if not entity:HasDeadMark() then
      local effect = effectService:CreateGridEffectWithEffectHolder(lineEffectID, casterEntity:GetGridPosition(), casterEntity)
      effect:SetPosition(Vector3(0, 0, 0))
      effectHolderCmpt:AttachPermanentEffect(effect:GetID())
      local go = effect:View():GetGameObject()
      local renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
      for i = 0, renderers.Length - 1 do
        local line = renderers[i]
        if line then
          line.gameObject:SetActive(true)
        end
      end
      local attackerViewRoot = casterEntity:View().ViewWrapper.GameObject.transform
      local attackRoot = GameObjectHelper.FindChild(attackerViewRoot, "Hit")
      attackRoot = attackRoot or GameObjectHelper.FindChild(attackerViewRoot, "Root")
      local defenderViewRoot = entity:View().ViewWrapper.GameObject.transform
      local defenderRoot = GameObjectHelper.FindChild(defenderViewRoot, "Hit")
      defenderRoot = defenderRoot or GameObjectHelper.FindChild(defenderViewRoot, "Root")
      effectLineRenderer:InitEffectLineRenderer(casterEntity:GetID(), attackRoot, defenderRoot, attackerViewRoot, renderers, effect:GetID())
      effectLineRenderer:SetEffectLineRendererShow(casterEntity:GetID(), true)
      effectLineRenderer:SetIgnoreEntityViewRootPos(true)
      effectLineRenderer:SetTargetEntityID(entity:GetID())
    end
  end
end

function MonsterShowRenderService:_ShowBornEffect(casterEntity, bornPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local sEffect = self._world:GetService("Effect")
  local randomSvc = self._world:GetService("RandomRender")
  local nAppearSkillID = utilDataSvc:GetAppearSkillId(casterEntity)
  if not nAppearSkillID then
    local elementType = utilDataSvc:GetEntityElementPrimaryType(casterEntity)
    local nDefaultEffId = sEffect:GetMonsterShowEffIdByEntity(casterEntity, elementType, casterEntity:HasBoss())
    if table.intable(BattleConst.MonsterBornEffectList, nDefaultEffId) then
      local audioId = BattleConst.MonsterBornAudioList[randomSvc:RenderRand(1, table.count(BattleConst.MonsterBornAudioList))]
      AudioHelperController.PlayInnerGameSfx(audioId)
    end
    if nDefaultEffId then
      local gridLocCmpt = casterEntity:GridLocation()
      local offset = gridLocCmpt:GetGridOffset()
      local effectPos = bornPos + offset
      sEffect:CreateWorldPositionEffect(nDefaultEffId, effectPos)
    end
  end
end

function MonsterShowRenderService:_ShowAppearSkill(casterEntity, nAppearSkillID)
  if nAppearSkillID and 0 < nAppearSkillID then
    local monsterClassId = casterEntity:MonsterID():GetMonsterClassID()
    local hpCmpt = casterEntity:HP()
    local hpSliderID = hpCmpt:GetHPSliderEntityID()
    local hpSliderEntity = self._world:GetEntityByID(hpSliderID)
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._PlayAppearSkill, self, casterEntity, hpSliderEntity, nAppearSkillID)
    return taskID
  end
  return -1
end

function MonsterShowRenderService:_ShowBossUIHPBar(isSummon)
  local bossIds = SortedArray:New(Algorithm.COMPARE_CUSTOM, self.SortBosses)
  local gMonster = self._world:GetGroup(self._world.BW_WEMatchers.Boss)
  local eBossList = gMonster:GetEntities()
  local isWorldBoss = false
  local worldBossData = {}
  local utilDataSvc = self._world:GetService("UtilData")
  local monsterConfigData = self._configService:GetMonsterConfigData()
  if eBossList and table.count(eBossList) > 0 then
    for i, v in ipairs(eBossList) do
      local bossCmpt = v:Boss()
      if not bossCmpt:IsHasShow() then
        bossCmpt:SetShowState(true)
        local cMonsterId = v:MonsterID()
        local monsterId = cMonsterId:GetMonsterID()
        local sepHPList = v:HP():GetHPLockSepList()
        local percent = v:HP():GetRedHP() / v:HP():GetMaxHP()
        local hasInit = v:HP():IsInitWorldBoss()
        local worldBossCurHPImageID = 0
        local worldBossPreHPImageID = 0
        if not v:HasDeadFlag() and cMonsterId:IsWorldBoss() and not hasInit then
          local stage, imageData = monsterConfigData:GetWorldBossConfig(monsterId)
          isWorldBoss = true
          v:HP():InitWorldBossHPData(stage, imageData)
          v:HP():SetWorldBossState(true)
          worldBossCurHPImageID = v:HP():GetCurStageImage()
          worldBossPreHPImageID = v:HP():GetPreStageImage()
        end
        local hasInitMultiHP = v:HP():IsInitMultiHP()
        local multiHPStageData
        if not v:HasDeadFlag() and cMonsterId:IsMultiHPMonster() and not hasInitMultiHP then
          multiHPStageData = monsterConfigData:GetMonsterMultiHealth(monsterId)
          v:HP():InitMultiHPData(multiHPStageData)
        end
        local buffView = v:BuffView()
        if not v:HasDeadFlag() and not buffView:HasBuffEffect(BuffEffectType.NotShowBossHP) then
          local hpBarType
          if v:MonsterID():IsEliteMonster() then
            hpBarType = HPBarType.EliteBoss
          else
            hpBarType = HPBarType.Boss
          end
          local bossUIHPBarType = monsterConfigData:GetBossUIHPType(monsterId)
          v:MonsterID():SetUIBossHPBarType(bossUIHPBarType)
          local hpEnergyBuffEffectType = utilDataSvc:GetEntityBuffValue(v, "HPEnergyBuffEffectType")
          local hpEnergyVal = 0
          local maxHPEnergyVal = 0
          if hpEnergyBuffEffectType then
            hpEnergyVal = utilDataSvc:GetBuffLayer(v, hpEnergyBuffEffectType)
            local bvinst = InnerGameHelperRender.GetSingleBuffByBuffEffect(v:GetID(), hpEnergyBuffEffectType)
            if bvinst then
              maxHPEnergyVal = bvinst:BuffConfigData():GetMaxLayerCount()
            end
            maxHPEnergyVal = math.max(hpEnergyVal, maxHPEnergyVal)
          end
          if not v:HasDeadFlag() and cMonsterId:IsMultiHPMonster() then
            hpEnergyVal = #multiHPStageData - 1
            maxHPEnergyVal = #multiHPStageData - 1
          end
          local elementType
          if isSummon then
            elementType = v:Element():GetPrimaryType()
          end
          local id = {
            pstId = v:GetID(),
            tplId = monsterId,
            isVice = self:IsViceBoss(v),
            sepHPList = sepHPList,
            percent = percent,
            worldBossCurImageID = worldBossCurHPImageID,
            worldBossPreImageID = worldBossPreHPImageID,
            HPBarType = hpBarType,
            hpEnergyVal = hpEnergyVal,
            maxHPEnergyVal = maxHPEnergyVal,
            curElement = elementType,
            UIBossHPType = bossUIHPBarType
          }
          if isWorldBoss and 0 < bossIds:Size() then
          else
            bossIds:Insert(id)
          end
        end
      end
    end
  end
  local gMonsters = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local eMonsterList = gMonsters:GetEntities()
  if eMonsterList and table.count(eMonsterList) > 0 then
    for i, v in ipairs(eMonsterList) do
      local cMonsterId = v:MonsterID()
      local monsterId = cMonsterId:GetMonsterID()
      local sepHPList = v:HP():GetHPLockSepList()
      local buffView = v:BuffView()
      if not v:HasDeadFlag() and buffView:HasBuffEffect(BuffEffectType.CurShowBossHP) then
        local hpBarType
        if v:MonsterID():IsEliteMonster() then
          hpBarType = HPBarType.EliteBoss
        else
          hpBarType = HPBarType.Boss
        end
        local bossUIHPBarType = monsterConfigData:GetBossUIHPType(monsterId)
        v:MonsterID():SetUIBossHPBarType(bossUIHPBarType)
        local hpEnergyBuffEffectType = utilDataSvc:GetEntityBuffValue(v, "HPEnergyBuffEffectType")
        local hpEnergyVal = 0
        local maxHPEnergyVal = 0
        if hpEnergyBuffEffectType then
          hpEnergyVal = utilDataSvc:GetBuffLayer(v, hpEnergyBuffEffectType)
          local bvinst = InnerGameHelperRender.GetSingleBuffByBuffEffect(v:GetID(), hpEnergyBuffEffectType)
          if bvinst then
            maxHPEnergyVal = bvinst:BuffConfigData():GetMaxLayerCount()
          end
          maxHPEnergyVal = math.max(hpEnergyVal, maxHPEnergyVal)
        end
        local elementType
        if isSummon then
          elementType = v:Element():GetPrimaryType()
        end
        local id = {
          pstId = v:GetID(),
          tplId = monsterId,
          isVice = self:IsViceBoss(v),
          sepHPList = sepHPList,
          entity = v,
          HPBarType = hpBarType,
          hpEnergyVal = hpEnergyVal,
          maxHPEnergyVal = maxHPEnergyVal,
          curElement = elementType,
          UIBossHPType = bossUIHPBarType
        }
        bossIds:Insert(id)
      end
    end
  end
  if bossIds:Size() == 1 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowBossHp, bossIds, isWorldBoss)
  end
end

function MonsterShowRenderService.SortBosses(id1, id2)
  local tplId1 = id1.tplId
  local tplId2 = id2.tplId
  if tplId1 < tplId2 then
    return 1
  elseif tplId1 > tplId2 then
    return -1
  else
    return 0
  end
end

function MonsterShowRenderService:IsViceBoss(e)
  local cMonsterId = e:MonsterID()
  local templateId = cMonsterId:GetMonsterID()
  local list = Cfg.cfg_global.vice_boss_template_id_list.ArrayValue
  return table.icontains(list, templateId)
end

function MonsterShowRenderService:_ShowAppearEffect(effectService, entityWork, listEffectID, nEffectType)
  if nil == listEffectID then
    return
  end
  for _, effectID in ipairs(listEffectID) do
    local effectEntity = effectService:CreateEffect(effectID, entityWork)
    local effectHolderCmpt = entityWork:EffectHolder()
    if effectHolderCmpt ~= nil then
      if 1 == nEffectType then
        effectHolderCmpt:AttachIdleEffect(effectEntity:GetID())
      elseif 0 == nEffectType then
        effectHolderCmpt:AttachPermanentEffect(effectEntity:GetID())
      elseif 2 == nEffectType then
        effectHolderCmpt:AttachEffectByEffectID(effectID, effectEntity:GetID())
      end
    end
  end
end

function MonsterShowRenderService:_PlayAppearSkill(TT, casterEntity, hpBarEntity, skillID)
  local sPlaySkill = self._world:GetService("PlaySkill")
  local taskId = sPlaySkill:PlaySkillView(casterEntity, skillID)
  while not TaskHelper:GetInstance():IsTaskFinished(taskId) do
    YIELD(TT)
  end
  self:ShowMonsterHPBar(TT, casterEntity, hpBarEntity)
end

function MonsterShowRenderService:ShowMonsterHPBar(TT, monsterEntity, hpBarEntity)
  local buffViewCmpt = monsterEntity:BuffView()
  if buffViewCmpt then
    local lockHPList = buffViewCmpt:GetBuffValue("LockHPList")
    if lockHPList then
      monsterEntity:ReplaceInitHPLockSepList(lockHPList)
    end
  end
  local cMonsterID = monsterEntity:MonsterID()
  local monsterId = cMonsterID:GetMonsterID()
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local cfgMonsterClass = monsterConfigData:GetMonsterClass(monsterId)
  local isHPBarEnabled = cfgMonsterClass.IsHPBarEnabled ~= false
  local hasOutsideRegion = monsterEntity:HasOutsideRegion()
  if isHPBarEnabled and not hasOutsideRegion then
    local cHP = monsterEntity:HP()
    cHP:SetShowHPSliderState(true)
    monsterEntity:ReplaceHPComponent()
  end
  local hpCmpt = monsterEntity:HP()
  local uiHpBuffInfoWidget = hpCmpt:GetUIHpBuffInfoWidget()
  if hpBarEntity and not uiHpBuffInfoWidget then
    if hpBarEntity:HasView() then
      local go = hpBarEntity:View().ViewWrapper.GameObject
      local uiview = go:GetComponent("UIView")
      local buffRootPath = uiview:GetUIComponent("UISelectObjectPath", "buffRoot")
      if buffRootPath then
        local buffRoot = UICustomWidgetPool:New(self, buffRootPath)
        buffRoot:SpawnObjects("UIHPBuffInfo", 1)
        local uiHPBuffInfo = buffRoot:GetAllSpawnList()[1]
        uiHPBuffInfo:SetData(monsterEntity:GetID())
        hpCmpt:SetUIHpBuffInfoWidget(buffRoot)
      end
    else
      local monsterId = 0
      local monsterIDCmpt = monsterEntity:MonsterID()
      if monsterIDCmpt then
        monsterId = monsterIDCmpt:GetMonsterID()
      end
      local gridPos = monsterEntity:GetGridPosition()
      Log.error("MonsterShowRenderService:ShowMonsterHPBar hpBarEntity has no view, monster eId: ", monsterEntity:GetID(), " monsterId: ", monsterId, " pos: ", Vector2.Pos2Index(gridPos))
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateAntiActiveSkill, monsterEntity:GetID())
  local sPlayBuff = self._world:GetService("PlayBuff")
  local buffViewComponent = monsterEntity:BuffView()
  if buffViewComponent then
    local viewIns = buffViewComponent:GetBuffViewInstanceArray()
    for _, inst in ipairs(viewIns) do
      local context = inst:GetBuffViewContext()
      if context and context.isMonsterBornBuff then
        sPlayBuff:PlayAddBuff(TT, inst)
      end
    end
  end
  sPlayBuff:PlayBuffView(TT, NTMonsterShow:New(monsterEntity))
end

function MonsterShowRenderService:CreateInternalRefreshMonster(TT, eTrapList, eMonsterList, showInterval)
  local taskIDList = {}
  if eTrapList and table.count(eTrapList) > 0 then
    local trapServiceRender = self._world:GetService("TrapRender")
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(trapServiceRender.ShowTraps, trapServiceRender, eTrapList)
    table.insert(taskIDList, taskID)
  end
  if eMonsterList and table.count(eMonsterList) > 0 then
    self:CreateMonsterHPEntities(eMonsterList)
    for _, e in ipairs(eMonsterList) do
      local monsterId = e:MonsterID():GetMonsterID()
      if e:HasBoss() then
        GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideBossComing, true, monsterId)
        YIELD(TT, 2000)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.ShowHideBossComing, false)
      end
    end
    for _, e in ipairs(eMonsterList) do
      local monsterTaskID = TaskManager:GetInstance():CoreGameStartTask(self.ShowMonsters, self, {e})
      table.insert(taskIDList, monsterTaskID)
      if showInterval and 0 < showInterval then
        YIELD(TT, showInterval)
      end
    end
  end
  if table.count(taskIDList) > 0 then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIInternalRefreshMonster)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function MonsterShowRenderService:CreateMonsterEffect(entity, monsterID)
  local effectHolderCmpt = entity:EffectHolder()
  if not effectHolderCmpt then
    return
  end
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local permanentEffectArray = monsterConfigData:GetMonsterPermanentEffectID(monsterID)
  local sEffect = self._world:GetService("Effect")
  if permanentEffectArray then
    for _, effectID in ipairs(permanentEffectArray) do
      local effectEntity = sEffect:CreateEffect(effectID, entity)
      effectHolderCmpt:AttachPermanentEffect(effectEntity:GetID())
    end
  end
  local idleEffectArray = monsterConfigData:GetMonsterIdleEffectID(monsterID)
  if idleEffectArray then
    for _, effectID in ipairs(idleEffectArray) do
      local effectEntity = sEffect:CreateEffect(effectID, entity)
      effectHolderCmpt:AttachIdleEffect(effectEntity:GetID())
    end
  end
  self:_CreateEntityEliteEffect(entity, monsterID)
end

function MonsterShowRenderService:DoAllMonsterDeadRender(TT, wait)
  local monsterDeadGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadFlag)
  if not monsterDeadGroup or table.count(monsterDeadGroup) <= 0 then
    return
  end
  local utilData = self._world:GetService("UtilData")
  local entityIDs = {}
  for _, e in ipairs(monsterDeadGroup:GetEntities()) do
    table.insert(entityIDs, e:GetID())
  end
  local isDeadEntitySummoner = {}
  for _, e in ipairs(monsterDeadGroup:GetEntities()) do
    if e:HasSummoner() and table.intable(entityIDs, e:Summoner():GetSummonerEntityID()) then
      table.insert(isDeadEntitySummoner, e)
    end
  end
  local deadTaskArray = {}
  for _, e in ipairs(monsterDeadGroup:GetEntities()) do
    if not table.intable(isDeadEntitySummoner, e) then
      local curDeadTaskID = TaskManager:GetInstance():CoreGameStartTask(self._DoOneMonsterDead, self, e)
      deadTaskArray[#deadTaskArray + 1] = curDeadTaskID
    end
  end
  if wait == nil or wait == true then
    while not TaskHelper:GetInstance():IsAllTaskFinished(deadTaskArray) do
      YIELD(TT)
    end
  end
  local deadTaskArraySecond = {}
  for _, e in ipairs(isDeadEntitySummoner) do
    local curDeadTaskID = TaskManager:GetInstance():CoreGameStartTask(self._DoOneMonsterDead, self, e)
    deadTaskArraySecond[#deadTaskArraySecond + 1] = curDeadTaskID
  end
  if wait == nil or wait == true then
    while not TaskHelper:GetInstance():IsAllTaskFinished(deadTaskArraySecond) do
      YIELD(TT)
    end
  end
end

function MonsterShowRenderService:_DoDeleteDeadSyncDamageEffect(deadEntity)
  local entities = self._world:GetGroupEntities(self._world.BW_WEMatchers.EffectLineRenderer)
  for i, entity in ipairs(entities) do
    local effectLineRenderer = entity:EffectLineRenderer()
    local targetEntityID = effectLineRenderer:GetTargetEntityID()
    if targetEntityID and targetEntityID == deadEntity:GetID() then
      effectLineRenderer:SetEffectLineRendererShow(entity:GetID(), false)
      effectLineRenderer:SetEffectLineActive(entity:GetID(), false)
    end
  end
end

function MonsterShowRenderService:_DoOneMonsterDead(TT, monsterEntity)
  if monsterEntity:MonsterID() == nil then
    return
  end
  if monsterEntity == nil or monsterEntity:HasShowDeath() then
    return
  end
  monsterEntity:AddShowDeath()
  local visible = monsterEntity:IsViewVisible()
  if not visible then
  end
  local monsterIDCmpt = monsterEntity:MonsterID()
  local doppelgangerValue = monsterIDCmpt:GetDoppelgangerValue()
  local isDoppelganger = doppelgangerValue == 1
  local playSkillService = self._world:GetService("PlaySkill")
  local deathTimeLen = self:_CalcDeathTimeLength(monsterEntity)
  self:_DoDeleteDeadSyncDamageEffect(monsterEntity)
  if monsterEntity:HasEffectLineRenderer() then
    monsterEntity:RemoveEffectLineRenderer()
  end
  if monsterEntity:TrailEffectEx() then
    local viewWrapper = monsterEntity:View().ViewWrapper
    local trailEffectExCmpt = viewWrapper.GameObject.transform:Find("Root").gameObject:GetComponent(typeof(TrailsFX.TrailEffectEx))
    if trailEffectExCmpt then
      UnityEngine.Object.Destroy(trailEffectExCmpt)
    end
    monsterEntity:RemoveTrailEffectEx()
  end
  local dropCmpt = monsterEntity:DropAsset()
  if dropCmpt then
    self:PlayMonsterDrop(TT, dropCmpt:GetDropAsset())
  end
  self:_DestroyEffectAndWarnging(monsterEntity)
  local dropSkillTaskID = 0
  local utilDataSvc = self._world:GetService("UtilData")
  local dropSkillId = utilDataSvc:GetDropSkill(monsterEntity)
  if dropSkillId and 0 < dropSkillId then
    dropSkillTaskID = playSkillService:PlaySkillView(monsterEntity, dropSkillId)
  end
  local sPlayBuff = self._world:GetService("PlayBuff")
  sPlayBuff:PlayBuffView(TT, NTMonsterDeadStart:New(monsterEntity))
  monsterEntity:ReplaceRedHPAndWhitHP(0)
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local monsterIDCmpt = monsterEntity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local deadSkillTaskID = 0
  local deadSkillId = monsterConfigData:GetMonsterDeathSkillID(monsterID)
  if isDoppelganger then
    deadSkillId = 0
  end
  if deadSkillId and 0 < deadSkillId then
    deadSkillTaskID = playSkillService:PlaySkillView(monsterEntity, deadSkillId)
  end
  if deadSkillTaskID then
    while not TaskHelper:GetInstance():IsTaskFinished(deadSkillTaskID) do
      YIELD(TT)
    end
  end
  local deadTriggerParam = "Death"
  if isDoppelganger then
    deadTriggerParam = ""
  end
  monsterEntity:SetAnimatorControllerTriggers({deadTriggerParam})
  local isSyncAnim = self:_IsDeathAudioSyncAnimation(monsterEntity)
  if isSyncAnim then
    self:_PlayMonsterDeathAudio(monsterEntity)
  end
  if not isSyncAnim then
    self:_PlayMonsterDeathAudio(monsterEntity)
  end
  local deadEffectWaitTime = 1
  if isDoppelganger then
    deadEffectWaitTime = 0
  end
  local deadEffectEntityIDList = self:_PlayDeadEffect(TT, monsterEntity)
  YIELD(TT, deadEffectWaitTime * 1000)
  if monsterEntity == nil then
    Log.fatal("monster entity is nil")
  end
  if monsterEntity:View() == nil then
    Log.fatal("DoMonsterDead, monster View is nil")
    local showDeathCmpt = monsterEntity:ShowDeath()
    if showDeathCmpt then
      showDeathCmpt:SetShowDeathEnd(true)
    end
    return
  end
  local sTrapRender = self._world:GetService("TrapRender")
  local boardServiceRender = self._world:GetService("BoardRender")
  local curPos = boardServiceRender:GetRealEntityGridPos(monsterEntity)
  local workPos = curPos - monsterEntity:GridLocation():GetGridOffset()
  local bodyArea = monsterEntity:BodyArea():GetArea()
  local pieceService = self._world:GetService("Piece")
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:DestroyMonsterAreaOutLineEntity(monsterEntity)
  local utilDataSvc = self._world:GetService("UtilData")
  local gameFsmStateID = utilDataSvc:GetCurMainStateID()
  for _, p in ipairs(bodyArea) do
    local pos = workPos + p
    if gameFsmStateID ~= GameStateID.PickUpChainSkillTarget and gameFsmStateID ~= GameStateID.ChainAttack then
      local curPieceAnim = pieceService:GetPieceAnimation(pos)
      if curPieceAnim == "Down" then
        pieceService:SetPieceAnimUp(pos)
      end
    end
    sTrapRender:ShowHideTrapAtPos(pos, true)
  end
  local cHP = monsterEntity:HP()
  local sliderEntityID = monsterEntity:HP():GetHPSliderEntityID()
  local sliderEntity = self._world:GetEntityByID(sliderEntityID)
  if sliderEntity then
    cHP:WidgetPoolCleanup()
    self._world:DestroyEntity(sliderEntity)
    local uiHpBuffInfoWidget = cHP:GetUIHpBuffInfoWidget()
    if uiHpBuffInfoWidget then
      local uiHPBuffInfo = uiHpBuffInfoWidget:GetAllSpawnList()[1]
      uiHPBuffInfo:OnOnwerEntityDead()
    end
  else
    Log.fatal("[_DoOneMonsterDead] sliderEntity is nil!   monsterEntityID=", monsterEntity:GetID(), " sliderEntityID ", sliderEntityID, "  Log.traceback()", Log.traceback())
    local hpGroup = self._world:GetGroup(self._world.BW_WEMatchers.HP)
    for _, e in ipairs(hpGroup:GetEntities()) do
      if e:IsViewVisible() then
        Log.fatal("[_DoOneMonsterDead] hud IsViewVisible()   HPEntityID=", e:GetID())
      end
    end
  end
  if dropSkillTaskID then
    while not TaskHelper:GetInstance():IsTaskFinished(dropSkillTaskID) do
      YIELD(TT)
    end
  end
  sPlayBuff:PlayBuffView(TT, NTMonsterDead:New(monsterEntity))
  sPlayBuff:PlayBuffView(TT, NTMonsterDeadEnd:New(monsterEntity))
  sPlayBuff:RemoveAllBuff(TT, monsterEntity)
  if monsterEntity:HasBoss() then
    self._world:EventDispatcher():Dispatch(GameEventType.HideBossHp, monsterEntity:GetID())
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIMonsterDeadCountUpdate)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UISpecificMonsterDeadCountUpdate, monsterID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIUpdateKillMoreThanPetMonster, monsterEntity:GetID())
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    if isDoppelganger then
    else
      YIELD(TT, 2000)
    end
    self:_PostDeadEffect(monsterEntity)
    monsterEntity:SetViewVisible(false)
    local fxsvc = self._world:GetService("Effect")
    fxsvc:ClearEntityEffect(monsterEntity)
    local showDeathCmpt = monsterEntity:ShowDeath()
    if showDeathCmpt then
      showDeathCmpt:SetShowDeathEnd(true)
    end
  end)
end

function MonsterShowRenderService:_CalcDeathTimeLength(monsterEntity)
  local deadAnimName = "death"
  local viewCmpt = monsterEntity:View()
  if viewCmpt == nil then
    return 0
  end
  local monsterObj = viewCmpt:GetGameObject()
  local animTimeLen = GameObjectHelper.GetActorAnimationLength(monsterObj, deadAnimName)
  animTimeLen = animTimeLen * 1000
  if animTimeLen <= 0 then
    Log.fatal("animTimeLen is zero ", animTimeLen, " actor", monsterObj.name)
  end
  return animTimeLen
end

function MonsterShowRenderService:_DestroyEffectAndWarnging(monsterEntity)
  local sEffect = self._world:GetService("Effect")
  local monsterClassId = monsterEntity:MonsterID():GetMonsterClassID()
  if not table.icontains(BattleConst.DeadDontDestroyEffectMonsterClassIDList, monsterClassId) then
    sEffect:DestroyStaticEffect(monsterEntity)
  end
  Log.notice("MonsterDead TemplateID:", monsterEntity:MonsterID():GetMonsterID(), " EntityID:", monsterEntity:GetID())
  local entityPoolSvcR = self._world:GetService("EntityPool")
  local warningAreaGroup = self._world:GetGroup(self._world.BW_WEMatchers.DamageWarningAreaElement)
  local destroyList = {}
  local entityID = monsterEntity:GetID()
  for _, areaEntity in ipairs(warningAreaGroup:GetEntities()) do
    if areaEntity:DamageWarningAreaElement():GetOwnerEntityID() == entityID then
      destroyList[#destroyList + 1] = areaEntity
    end
  end
  for i = 1, #destroyList do
    local entity = destroyList[i]
    local cmpt = entity:DamageWarningAreaElement()
    cmpt:ClearOwnerEntityID()
    local entityConfigID = cmpt:GetEntityConfigID()
    if entityConfigID then
      entityPoolSvcR:DestroyCacheEntity(entity, entityConfigID)
    else
      entityPoolSvcR:DestroyCacheEntity(entity, EntityConfigIDRender.WarningArea)
    end
    cmpt:ClearOwnerEntityID()
  end
end

function MonsterShowRenderService:PlayMonsterDrop(TT, drop)
  if not drop then
    return
  end
  local playSkillService = self._world:GetService("PlaySkill")
  playSkillService:DoDropAnimation(drop.Drops, drop.Pos)
end

function MonsterShowRenderService:_IsDeathAudioSyncAnimation(deadMonsterEntity)
  local cMonsterID = deadMonsterEntity:MonsterID()
  if not cMonsterID then
    return false
  end
  local monsterID = cMonsterID:GetMonsterID()
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local isSyncAnim = monsterConfigData:DeathAudioSyncAnimation(monsterID)
  return isSyncAnim
end

function MonsterShowRenderService:_PlayMonsterDeathAudio(deadMonsterEntity)
  local monsterIDCmpt = deadMonsterEntity:MonsterID()
  if monsterIDCmpt == nil then
    return false
  end
  local monsterID = monsterIDCmpt:GetMonsterID()
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local deathAudioID = monsterConfigData:GetDeathAudioID(monsterID)
  if deathAudioID == nil then
    deathAudioID = CriAudioIDConst.SouncCoreGameMonsterDeath
  end
  AudioHelperController.PlayInnerGameSfx(deathAudioID)
end

function MonsterShowRenderService:_PlayDeadEffect(TT, deadMonsterEntity)
  local deadEffectEntityIDList = {}
  local monsterIDCmpt = deadMonsterEntity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local doppelgangerValue = monsterIDCmpt:GetDoppelgangerValue()
  local isDoppelganger = doppelgangerValue == 1
  if isDoppelganger then
    local effectService = self._world:GetService("Effect")
    local renderPos = deadMonsterEntity:GetRenderGridPosition() + deadMonsterEntity:GridLocation():GetGridOffset()
    local effectEntity = effectService:CreateWorldPositionEffect(BattleConst.MonsterDeadEffectDoppelganger, renderPos)
    deadEffectEntityIDList[#deadEffectEntityIDList + 1] = effectEntity:GetID()
  else
    local monsterConfigData = self._configService:GetMonsterConfigData()
    local monsterDeadType = monsterConfigData:GetDeathShowType(monsterID)
    local deathEffectID
    if monsterDeadType == DeathShowType.DissolveLight then
      deadMonsterEntity:NewPlayDeadLight()
      deathEffectID = BattleConst.MonsterDeadEffectLight
    elseif monsterDeadType == DeathShowType.DissolveDark then
      deadMonsterEntity:NewPlayDeadDark()
      deathEffectID = BattleConst.MonsterDeadEffectDark
    else
      deathEffectID = monsterConfigData:GetDeathShowEffectID(monsterID)
    end
    if deathEffectID then
      local effectService = self._world:GetService("Effect")
      if type(deathEffectID) == "number" then
        deathEffectID = {deathEffectID}
      end
      for i, effID in ipairs(deathEffectID) do
        local effectEntity = effectService:CreateEffect(effID, deadMonsterEntity)
        deadEffectEntityIDList[#deadEffectEntityIDList + 1] = effectEntity:GetID()
      end
    end
  end
  if deadMonsterEntity == nil then
    Log.fatal("entity is dead---------------------")
  end
  local innerStoryService = self._world:GetService("InnerStory")
  innerStoryService:CheckMonsterShowAndDeadStoryTips(StoryMonsterShowType.BeginDeadAnimation, monsterID, deadMonsterEntity:GetID())
  if innerStoryService:CheckMonsterShowAndDeadStoryBanner(StoryShowType.AfterMonsterDead, monsterID) then
    InnerGameHelperRender:GetInstance():IsUIBannerComplete(TT)
  end
  return deadEffectEntityIDList
end

function MonsterShowRenderService:_PostDeadEffect(deadMonsterEntity)
  deadMonsterEntity:StopMaterialAnimLayer(MaterialAnimLayer.Death)
end

function MonsterShowRenderService:PlaySpawnInWave(TT, traps, monsters, showInterval)
  self:CreateInternalRefreshMonster(TT, traps, monsters, showInterval)
end

function MonsterShowRenderService:PullDownNotLoadHighMonsters()
  local g = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(g:GetEntities()) do
    local monsterClassId = e:MonsterID():GetMonsterClassID()
    if table.icontains(BattleConst.NotLoadHighMonsters, monsterClassId) then
      e:SetPosition(e:GetGridPosition() + e:GetGridOffset())
      local cHP = e:HP()
      if cHP then
        cHP:SetShowHPSliderState(false)
      end
    end
  end
end

function MonsterShowRenderService:DoOneMonsterFeatureDead(TT, monsterEntity)
  if monsterEntity:MonsterID() == nil then
    return
  end
  if monsterEntity == nil or monsterEntity:HasShowDeath() then
    return
  end
  monsterEntity:AddShowDeath()
  local visible = monsterEntity:IsViewVisible()
  if not visible then
  end
  if monsterEntity:HasEffectLineRenderer() then
    monsterEntity:RemoveEffectLineRenderer()
  end
  self:_DestroyEffectAndWarnging(monsterEntity)
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local monsterIDCmpt = monsterEntity:MonsterID()
  local sTrapRender = self._world:GetService("TrapRender")
  local boardServiceRender = self._world:GetService("BoardRender")
  local curPos = boardServiceRender:GetRealEntityGridPos(monsterEntity)
  local workPos = curPos - monsterEntity:GridLocation():GetGridOffset()
  local bodyArea = monsterEntity:BodyArea():GetArea()
  local pieceService = self._world:GetService("Piece")
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:DestroyMonsterAreaOutLineEntity(monsterEntity)
  local utilDataSvc = self._world:GetService("UtilData")
  local gameFsmStateID = utilDataSvc:GetCurMainStateID()
  for _, p in ipairs(bodyArea) do
    local pos = workPos + p
    if gameFsmStateID ~= GameStateID.PickUpChainSkillTarget and gameFsmStateID ~= GameStateID.ChainAttack then
      local curPieceAnim = pieceService:GetPieceAnimation(pos)
      if curPieceAnim == "Down" then
        pieceService:SetPieceAnimUp(pos)
      end
    end
    sTrapRender:ShowHideTrapAtPos(pos, true)
  end
  local cHP = monsterEntity:HP()
  local sliderEntityID = monsterEntity:HP():GetHPSliderEntityID()
  local sliderEntity = self._world:GetEntityByID(sliderEntityID)
  if sliderEntity then
    cHP:WidgetPoolCleanup()
    self._world:DestroyEntity(sliderEntity)
    local uiHpBuffInfoWidget = cHP:GetUIHpBuffInfoWidget()
    if uiHpBuffInfoWidget then
      local uiHPBuffInfo = uiHpBuffInfoWidget:GetAllSpawnList()[1]
      uiHPBuffInfo:OnOnwerEntityDead()
    end
  end
  local sPlayBuff = self._world:GetService("PlayBuff")
  sPlayBuff:RemoveAllBuff(TT, monsterEntity)
  monsterEntity:SetViewVisible(false)
  local fxsvc = self._world:GetService("Effect")
  fxsvc:ClearEntityEffect(monsterEntity)
  local showDeathCmpt = monsterEntity:ShowDeath()
  showDeathCmpt:SetShowDeathEnd(true)
end

function MonsterShowRenderService:MonsterGridAnimDown()
  local sPiece = self._world:GetService("Piece")
  local globalMonsterGroup = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  local monsterPosList = {}
  for _, e in ipairs(globalMonsterGroup) do
    if not e:HasDeadMark() and not e:HasOutsideRegion() then
      local bodyArea = e:BodyArea()
      local gridPos = e:GetGridPosition()
      for i, p in ipairs(bodyArea:GetArea()) do
        local pos = p + gridPos
        table.insert(monsterPosList, pos)
      end
    end
  end
  local env = self._world:GetPreviewEntity():PreviewEnv()
  local pieceTable = env:GetAllPieceType()
  for x, columnDic in pairs(pieceTable) do
    for y, curGridType in pairs(columnDic) do
      local curGridPos = Vector2(x, y)
      if not table.Vector2Include(monsterPosList, curGridPos) then
        sPiece:SetPieceAnimNormal(curGridPos, true)
      else
        sPiece:SetPieceAnimDown(curGridPos)
      end
    end
  end
end

function MonsterShowRenderService:PlayOneMonsterSpDead(TT, monsterEntity)
  if monsterEntity:MonsterID() == nil then
    return
  end
  if monsterEntity == nil or monsterEntity:HasShowDeath() then
    return
  end
  monsterEntity:AddShowDeath()
  local playSkillService = self._world:GetService("PlaySkill")
  if monsterEntity:HasEffectLineRenderer() then
    monsterEntity:RemoveEffectLineRenderer()
  end
  if monsterEntity:TrailEffectEx() then
    local viewWrapper = monsterEntity:View().ViewWrapper
    local trailEffectExCmpt = viewWrapper.GameObject.transform:Find("Root").gameObject:GetComponent(typeof(TrailsFX.TrailEffectEx))
    if trailEffectExCmpt then
      UnityEngine.Object.Destroy(trailEffectExCmpt)
    end
    monsterEntity:RemoveTrailEffectEx()
  end
  local dropCmpt = monsterEntity:DropAsset()
  if dropCmpt then
    self:PlayMonsterDrop(TT, dropCmpt:GetDropAsset())
  end
  self:_DestroyEffectAndWarnging(monsterEntity)
  local dropSkillTaskID = 0
  local utilDataSvc = self._world:GetService("UtilData")
  local dropSkillId = utilDataSvc:GetDropSkill(monsterEntity)
  if dropSkillId and 0 < dropSkillId then
    dropSkillTaskID = playSkillService:PlaySkillView(monsterEntity, dropSkillId)
  end
  local sPlayBuff = self._world:GetService("PlayBuff")
  sPlayBuff:PlayBuffView(TT, NTMonsterDeadStart:New(monsterEntity))
  monsterEntity:ReplaceRedHPAndWhitHP(0)
  local monsterConfigData = self._configService:GetMonsterConfigData()
  local monsterIDCmpt = monsterEntity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local innerStoryService = self._world:GetService("InnerStory")
  innerStoryService:CheckMonsterShowAndDeadStoryTips(StoryMonsterShowType.BeginDeadAnimation, monsterID, monsterEntity:GetID())
  if innerStoryService:CheckMonsterShowAndDeadStoryBanner(StoryShowType.AfterMonsterDead, monsterID) then
    InnerGameHelperRender:GetInstance():IsUIBannerComplete(TT)
  end
  YIELD(TT, 1000)
  if monsterEntity == nil then
    Log.fatal("monster entity is nil")
  end
  local sTrapRender = self._world:GetService("TrapRender")
  local boardServiceRender = self._world:GetService("BoardRender")
  local curPos = boardServiceRender:GetRealEntityGridPos(monsterEntity)
  local workPos = curPos - monsterEntity:GridLocation():GetGridOffset()
  local bodyArea = monsterEntity:BodyArea():GetArea()
  local pieceService = self._world:GetService("Piece")
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:DestroyMonsterAreaOutLineEntity(monsterEntity)
  local utilDataSvc = self._world:GetService("UtilData")
  local gameFsmStateID = utilDataSvc:GetCurMainStateID()
  for _, p in ipairs(bodyArea) do
    local pos = workPos + p
    if gameFsmStateID ~= GameStateID.PickUpChainSkillTarget and gameFsmStateID ~= GameStateID.ChainAttack then
      local curPieceAnim = pieceService:GetPieceAnimation(pos)
      if curPieceAnim == "Down" then
        pieceService:SetPieceAnimUp(pos)
      end
    end
    sTrapRender:ShowHideTrapAtPos(pos, true)
  end
  local cHP = monsterEntity:HP()
  local sliderEntityID = monsterEntity:HP():GetHPSliderEntityID()
  local sliderEntity = self._world:GetEntityByID(sliderEntityID)
  if sliderEntity then
    cHP:WidgetPoolCleanup()
    self._world:DestroyEntity(sliderEntity)
    local uiHpBuffInfoWidget = cHP:GetUIHpBuffInfoWidget()
    if uiHpBuffInfoWidget then
      local uiHPBuffInfo = uiHpBuffInfoWidget:GetAllSpawnList()[1]
      uiHPBuffInfo:OnOnwerEntityDead()
    end
  else
    Log.fatal("[PlayOneMonsterDeadBySPEffect] sliderEntity is nil!   monsterEntityID=", monsterEntity:GetID(), " sliderEntityID ", sliderEntityID, "  Log.traceback()", Log.traceback())
    local hpGroup = self._world:GetGroup(self._world.BW_WEMatchers.HP)
    for _, e in ipairs(hpGroup:GetEntities()) do
      if e:IsViewVisible() then
        Log.fatal("[PlayOneMonsterDeadBySPEffect] hud IsViewVisible()   HPEntityID=", e:GetID())
      end
    end
  end
  if dropSkillTaskID then
    while not TaskHelper:GetInstance():IsTaskFinished(dropSkillTaskID) do
      YIELD(TT)
    end
  end
  sPlayBuff:PlayBuffView(TT, NTMonsterDead:New(monsterEntity))
  sPlayBuff:PlayBuffView(TT, NTMonsterDeadEnd:New(monsterEntity))
  sPlayBuff:RemoveAllBuff(TT, monsterEntity)
  if monsterEntity:HasBoss() then
    self._world:EventDispatcher():Dispatch(GameEventType.HideBossHp, monsterEntity:GetID())
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIMonsterDeadCountUpdate)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UISpecificMonsterDeadCountUpdate, monsterID)
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT, 2000)
    self:_PostDeadEffect(monsterEntity)
    monsterEntity:SetViewVisible(false)
    local fxsvc = self._world:GetService("Effect")
    fxsvc:ClearEntityEffect(monsterEntity)
    local showDeathCmpt = monsterEntity:ShowDeath()
    showDeathCmpt:SetShowDeathEnd(true)
  end)
end

function MonsterShowRenderService:_CreateEntityEliteEffect(entity, monsterID)
  local effectHolderCmpt = entity:EffectHolder()
  if not effectHolderCmpt then
    return
  end
  local effectSvc = self._world:GetService("Effect")
  local monsterIDCmpt = entity:MonsterID()
  if not monsterIDCmpt then
    return
  end
  local isEliteMonster = monsterIDCmpt:IsEliteMonster()
  if isEliteMonster then
    local eliteIDs = monsterIDCmpt:GetEliteIDArray()
    local effIDList = self:GetEliteEffectIDList(entity, eliteIDs)
    for _, id in ipairs(effIDList) do
      local effectEntity = effectSvc:CreateEffect(id, entity)
      effectHolderCmpt:AttachPermanentEffect(effectEntity:GetID())
      effectHolderCmpt:AddEliteEffID(id, effectEntity:GetID())
    end
  end
end

function MonsterShowRenderService:GetEliteEffectIDList(entity, eliteIDArray)
  local effIDList = {}
  local monsterIDCmpt = entity:MonsterID()
  if not monsterIDCmpt then
    return effIDList
  end
  local monsterID = monsterIDCmpt:GetMonsterID()
  local bodyAreaCount = entity:BodyArea():GetAreaCount()
  local eliteEffIDList = {}
  for _, eliteID in ipairs(eliteIDArray) do
    local cfgElite = Cfg.cfg_monster_elite[eliteID]
    if cfgElite and cfgElite.EffectID then
      table.insert(eliteEffIDList, cfgElite.EffectID)
    end
  end
  if 0 < #eliteEffIDList then
    for _, effIDStr in ipairs(eliteEffIDList) do
      local effIDStrList = string.split(effIDStr, ",")
      if effIDStrList and #effIDStrList == 2 then
        local effectID = tonumber(effIDStrList[1])
        if bodyAreaCount ~= 1 then
          effectID = tonumber(effIDStrList[2])
        end
        if not table.icontains(effIDList, effectID) then
          table.insert(effIDList, effectID)
        end
      end
    end
  else
    local monsterConfigData = self._configService:GetMonsterConfigData()
    local disableEliteEffect = monsterConfigData:IsDisableEliteEffect(monsterID)
    if not disableEliteEffect then
      local effectID = BattleConst.EliteMonsterPermanentEffectBodyArea1
      if bodyAreaCount == 4 then
        effectID = BattleConst.EliteMonsterPermanentEffectBodyArea4
      end
      table.insert(effIDList, effectID)
    end
  end
  return effIDList
end

function MonsterShowRenderService:RemoveMonsterWeak(ownerEntity)
  if not ownerEntity:HasRenderMonsterWeak() then
    return
  end
  local monsterWeakRCmpt = ownerEntity:RenderMonsterWeak()
  local weakList = monsterWeakRCmpt:GetMonsterWeakList()
  for _, infoList in pairs(weakList) do
    for effID, _ in pairs(infoList) do
      local effectEntity = self._world:GetEntityByID(effID)
      self._world:DestroyEntity(effectEntity)
    end
  end
  ownerEntity:RemoveRenderMonsterWeak()
end

function MonsterShowRenderService:ShowMonsterWeak(targetEntity, weakResults)
  local renderMonsterWeakComponent = targetEntity:RenderMonsterWeak()
  if not renderMonsterWeakComponent then
    targetEntity:AddRenderMonsterWeak()
    renderMonsterWeakComponent = targetEntity:RenderMonsterWeak()
  end
  local effectService = self:GetService("Effect")
  local effectHolderCmpt = targetEntity:EffectHolder()
  if not effectHolderCmpt then
    targetEntity:AddEffectHolder()
    effectHolderCmpt = targetEntity:EffectHolder()
  end
  if weakResults and table.count(weakResults) > 0 then
    for _, weak in ipairs(weakResults) do
      local monsterWeakData = weak
      local key = monsterWeakData:GetKey()
      local effectID = BattleConst.MonsterWeakEffectID
      local effectDir = Vector2(0, 0)
      if string.find(tostring(key), tostring(WeakEdgeType.WeakUp)) then
        effectDir = Vector3(0, 0, 0)
      elseif string.find(tostring(key), tostring(WeakEdgeType.WeakDown)) then
        effectDir = Vector3(0, 180, 0)
      elseif string.find(tostring(key), tostring(WeakEdgeType.WeakRight)) then
        effectDir = Vector3(0, 90, 0)
      elseif string.find(tostring(key), tostring(WeakEdgeType.WeakLeft)) then
        effectDir = Vector3(0, -90, 0)
      end
      local edgePosList = monsterWeakData:GetEdgePosList()
      local edgeCount = table.count(edgePosList)
      local effectCenterPos = Vector3(0, 0, 0)
      local gridOffset = targetEntity:GridLocation():GetGridOffset()
      for _, edgePos in ipairs(edgePosList) do
        effectCenterPos = Vector3(effectCenterPos.x + edgePos.x - gridOffset.x, 0, effectCenterPos.z + edgePos.y - gridOffset.y)
      end
      effectCenterPos = Vector3(effectCenterPos.x / edgeCount, 0, effectCenterPos.z / edgeCount)
      local effEntity = effectService:CreateEffect(effectID, targetEntity)
      local cView = effEntity:View()
      local gameObject = cView:GetGameObject()
      local gameObjectRoot = gameObject.transform:Find("root1")
      if gameObjectRoot then
        gameObjectRoot.transform.localPosition = effectCenterPos
        gameObjectRoot.transform.localEulerAngles = effectDir
        local lineRoot = gameObjectRoot.transform:Find("line")
        if lineRoot then
          lineRoot.transform.localScale = Vector3(edgeCount, 1, 1)
        end
      end
      local anim = gameObject:GetComponentInChildren(typeof(UnityEngine.Animation))
      if anim then
        anim:PlayQueued(BattleConst.MonsterWeakEffectBirth)
        anim:PlayQueued(BattleConst.MonsterWeakEffectIdle)
      end
      effectHolderCmpt:AttachPermanentEffect(effEntity:GetID())
      renderMonsterWeakComponent:AddEffectEntity(key, effEntity:GetID(), effectCenterPos)
    end
  end
end
