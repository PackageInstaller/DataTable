_class("TrapServiceRender", BaseService)
TrapServiceRender = TrapServiceRender

function TrapServiceRender:Constructor(world)
  self._trapEffectFun = {}
  self._trapTargetSelector = TrapTargetSelector:New(world)
  self._listTrapTask = {}
  self._offsetDic = {}
  self._offsetDic[1] = Vector2(400, 80)
  self._offsetDic[2] = Vector2(400, -80)
  self._offsetDic[3] = Vector2(-400, 80)
  self._offsetDic[4] = Vector2(-400, -80)
end

function TrapServiceRender:Initialize()
  self._entityRenderService = self._world:GetService("RenderEntity")
end

function TrapServiceRender:_ShowHideTrap(trapEntity, isShow, trapRenderCmpt, playSkillService)
  local showSkillID = trapRenderCmpt:GetShowSkillID()
  local hideSkillID = trapRenderCmpt:GetHideSkillID()
  if isShow then
    if showSkillID and 0 < showSkillID then
      local canPlayShow = trapRenderCmpt:IsTrapCanPlayShowSkill()
      if canPlayShow then
        playSkillService:PlaySkillView(trapEntity, showSkillID)
        trapRenderCmpt:SetTrapCanPlayShowSkill(false)
        trapRenderCmpt:SetTrapCanPlayHideSkill(true)
      end
    else
      trapEntity:SetViewVisible(true)
    end
  elseif hideSkillID and 0 < hideSkillID then
    local canPlayHide = trapRenderCmpt:IsTrapCanPlayHideSkill()
    if canPlayHide then
      playSkillService:PlaySkillView(trapEntity, hideSkillID)
      trapRenderCmpt:SetTrapCanPlayHideSkill(false)
      trapRenderCmpt:SetTrapCanPlayShowSkill(true)
    end
  else
    trapEntity:SetViewVisible(false)
  end
end

function TrapServiceRender:ShowHideTrapAtPos(pos, isShow)
  local playSkillService = self._world:GetService("PlaySkill")
  local utilSvc = self._world:GetService("UtilData")
  if not utilSvc then
    return
  end
  local traps = utilSvc:GetTrapsAtPos(pos)
  for _, e in ipairs(traps) do
    local trapPos = e:GridLocation().Position
    local trapRenderCmpt = e:TrapRender()
    if trapRenderCmpt and (trapRenderCmpt:GetHideUnderAI() or trapRenderCmpt:GetHideUnderTeam()) and not e:HasDeadFlag() then
      self:_ShowHideTrap(e, isShow, trapRenderCmpt, playSkillService)
    end
  end
end

function TrapServiceRender:ShowHideTrapByChainMove(pos, isShow, petEntity)
  local playSkillService = self._world:GetService("PlaySkill")
  local utilSvc = self._world:GetService("UtilData")
  local traps = utilSvc:GetTrapsAtPos(pos)
  for _, e in ipairs(traps) do
    local trapPos = e:GridLocation().Position
    local trapRenderCmpt = e:TrapRender()
    local canHideUnder = false
    local trapIsCurPetRace = self:CanSelectByRaceType(e, petEntity)
    if trapIsCurPetRace then
      canHideUnder = trapRenderCmpt:GetHideUnderTeam()
    else
      canHideUnder = trapRenderCmpt:GetHideUnderAI()
    end
    if trapRenderCmpt and canHideUnder and not e:HasDeadFlag() then
      self:_ShowHideTrap(e, isShow, trapRenderCmpt, playSkillService)
    end
  end
end

function TrapServiceRender:ShowTraps(TT, trapEntityArray, isHideOnBegin)
  local taskIDs = {}
  for _, e in ipairs(trapEntityArray) do
    local tid = GameGlobal.TaskManager():CoreGameStartTask(self.CreateSingleTrapRender, self, e, isHideOnBegin)
    if tid then
      table.insert(taskIDs, tid)
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
    YIELD(TT)
  end
end

function TrapServiceRender:CreateSingleTrapRender(TT, trapEntity, isHideOnBegin)
  local trapConfigData = self._configService:GetTrapConfigData()
  local entityService = self._world:GetService("RenderEntity")
  local trapID = trapEntity:TrapID():GetTrapID()
  local trapData = trapConfigData:GetTrapData(trapID)
  local pos = trapEntity:GetGridPosition()
  local trapRenderCmpt = trapEntity:TrapRender()
  if trapRenderCmpt:IsHasShow() then
    Log.info("TrapServiceRender: trap has shown, entityID = ", trapEntity:GetID())
    return
  end
  trapRenderCmpt:InitByTrapData(trapID, trapData)
  trapRenderCmpt:SetTrapBornRound(BattleStatHelper.GetLevelTotalRoundCount())
  self:_TrapViewAppear(TT, trapEntity, trapData, isHideOnBegin)
  self:_PlaySingleTrapAppearSkill(TT, trapEntity, trapData)
  self:_OnSetGridPieceElement({trapEntity})
  local summoner = trapEntity:GetSummonerEntity()
  local cRenderBattleStat = self._world:RenderBattleStat()
  local playBuffSvc = self._world:GetService("PlayBuff")
  local nt = NTTrapShow:New(trapEntity, summoner)
  if summoner then
    nt:SetIsFirstSummon(not cRenderBattleStat:IsTrapSummonedByCasterBefore(trapID, summoner:GetID()))
  end
  playBuffSvc:PlayBuffView(TT, nt)
  if trapData.TriggerWhileSpawn then
    self:_PlayTriggerWhileSpawn(TT, trapEntity)
  end
  local gridPosition = trapEntity:GetGridPosition()
  if trapRenderCmpt:GetTrapLevel() == 0 then
    self:ShowHideTrapAtPos(gridPosition, false)
  end
  trapRenderCmpt:SetHasShowState(true)
  trapEntity:HP():SetShowHPSliderState(false)
  local trapRenderCmpt = trapEntity:TrapRender()
  local trapData = trapConfigData:GetTrapData(trapRenderCmpt:GetTrapID())
  local hp = trapRenderCmpt:GetTrapCreationResult():GetTrapHP()
  local hpMax = trapRenderCmpt:GetTrapCreationResult():GetTrapHPMax()
  if hp and 0 < hp then
    trapEntity:ReplaceRedAndMaxHP(hp, hpMax)
  end
  if trapData.HPSliderType and trapData.HPSliderType ~= 0 then
    local trap_hpslider_entity = entityService:CreateRenderEntity(EntityConfigIDRender.TrapHPSlider)
    self:_CreateHpSlider(trapEntity, trap_hpslider_entity, trapData)
    self:_CreateBuffInfo(trapEntity, trap_hpslider_entity)
    if trapRenderCmpt:GetTrapType() == TrapType.Protected then
      self:_CreateTrapSkillInfo(trapEntity, trap_hpslider_entity)
    end
  end
  self:_CreateTrapRoundInfo(trapData, trapEntity)
  self:_InitTrapInfoPosition(trapData, trapEntity)
  if summoner then
    cRenderBattleStat:AddTrapIDByCasterEntityID(trapID, summoner:GetID())
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TrapRenderShow, trapRenderCmpt:GetTrapID())
  local areaArray = {}
  if trapData.Area then
    for i, str in ipairs(trapData.Area) do
      local numStr = string.split(str, ",")
      local vec2 = Vector2(tonumber(numStr[1]), tonumber(numStr[2]))
      table.insert(areaArray, vec2)
    end
  else
    table.insert(areaArray, Vector2.zero)
  end
  local ntTrapShowEnd = NTTrapShowEnd:New(trapEntity, summoner, pos, areaArray)
  if summoner then
    ntTrapShowEnd:SetIsFirstSummon(not cRenderBattleStat:IsTrapSummonedByCasterBefore(trapID, summoner:GetID()))
  end
  playBuffSvc:PlayBuffView(TT, ntTrapShowEnd)
end

function TrapServiceRender:_TrapViewAppear(TT, trapEntity, trapData, isHideOnBegin)
  local trapRenderCmpt = trapEntity:TrapRender()
  local appearSkillID = trapRenderCmpt:GetAppearSkillID()
  if trapRenderCmpt:IsSkillHadPlay(appearSkillID) then
    Log.info("TrapServiceRender: trap appear skill had play, entityID = ", trapEntity:GetID())
    return
  end
  local boardServiceR = self._world:GetService("BoardRender")
  local pieceServiceR = self._world:GetService("Piece")
  local trapID = trapEntity:TrapID():GetTrapID()
  local pos = trapEntity:GetGridPosition()
  local resPath = trapData.ResPath
  if trapData.TypeParam and trapData.TypeParam.isBrokenGrid then
    local pieceEntity = pieceServiceR:FindPieceEntity(pos)
    local pieceType = pieceEntity:Piece():GetPieceType()
    resPath = boardServiceR:_GetBrokenGridPrefabPath(pieceType)
    resPath = resPath and {resPath}
  end
  if resPath then
    if #resPath == 1 then
      self:_ReplaceAsset(trapEntity, resPath[1], isHideOnBegin)
    else
      local index = math.random(1, #resPath)
      self:_ReplaceAsset(trapEntity, resPath[index], isHideOnBegin)
    end
  else
    Log.error("ShowTrap error resPath is nil, trapID=", trapID, " entityID=", trapEntity:GetID())
  end
  self:CreateTrapHeadShow(trapData, trapEntity)
  local effectService = self._world:GetService("Effect")
  self:_ShowAppearEffect(effectService, trapEntity, trapData.PermanentEffect, 0)
  self:_ShowAppearEffect(effectService, trapEntity, trapData.IdleEffect, 1)
  local areaArray = {}
  if trapData.Area then
    for i, str in ipairs(trapData.Area) do
      local numStr = string.split(str, ",")
      local vec2 = Vector2(tonumber(numStr[1]), tonumber(numStr[2]))
      table.insert(areaArray, vec2)
    end
  else
    table.insert(areaArray, Vector2.zero)
  end
  if trapData.TrapType == TrapType.TerrainAbyss and trapData.GridPieceElement then
    for _, areaPos in ipairs(areaArray) do
      boardServiceR:ReCreateGridEntity(trapData.GridPieceElement, pos + areaPos)
    end
  end
  if trapData.TrapType == TrapType.Wall then
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local renderTrapWallComponent = renderBoardEntity:RenderTrapWall()
    if not renderTrapWallComponent then
      renderBoardEntity:AddRenderTrapWall()
      renderTrapWallComponent = renderBoardEntity:RenderTrapWall()
    end
    local trapRenderCmpt = trapEntity:TrapRender()
    local trapWallPosList = trapRenderCmpt:GetTrapCreationResult():GetTrapWallPosList()
    if trapWallPosList and 0 < table.count(trapWallPosList) then
      for _, trapWallPos in ipairs(trapWallPosList) do
        local trapWall = renderTrapWallComponent:GetTrapWall(trapWallPos)
        if not trapWall then
          local dir = Vector2(0, 0)
          local effectID = BattleConst.TrapWallEffectIDW
          if trapWallPos.x ~= math.ceil(trapWallPos.x) then
            dir = Vector2(1, 0)
            effectID = BattleConst.TrapWallEffectIDL
          end
          local effEntity = effectService:CreateWorldPositionEffect(effectID, trapWallPos)
          renderTrapWallComponent:AddEffectEntity(effEntity:GetID(), trapWallPos)
        end
      end
    end
  end
end

function TrapServiceRender:_OnSetGridPieceElement(eTraps)
  local trapConfigData = self._configService:GetTrapConfigData()
  local boardServiceR = self._world:GetService("BoardRender")
  for _, trapEntity in ipairs(eTraps) do
    local trapID = trapEntity:TrapID():GetTrapID()
    local trapData = trapConfigData:GetTrapData(trapID)
    if trapData.TrapType ~= TrapType.TerrainAbyss then
      local areaArray = {}
      if trapData.Area then
        for i, str in ipairs(trapData.Area) do
          local numStr = string.split(str, ",")
          local vec2 = Vector2(tonumber(numStr[1]), tonumber(numStr[2]))
          table.insert(areaArray, vec2)
        end
      else
        table.insert(areaArray, Vector2.zero)
      end
      local pos = trapEntity:GetGridPosition()
      if trapData.GridPieceElement then
        for _, areaPos in ipairs(areaArray) do
          boardServiceR:ReCreateGridEntity(trapData.GridPieceElement, pos + areaPos)
        end
      end
    end
  end
end

function TrapServiceRender:_CreateHpSlider(trapEntity, eHPBar, trapData)
  eHPBar:SetViewVisible(false)
  local hpCmpt = trapEntity:HP()
  hpCmpt:SetShowHPSliderState(true)
  hpCmpt:SetHPOffset(trapData.HeightOffset)
  local sliderEntityID = eHPBar:GetID()
  hpCmpt:SetHPSliderEntityID(sliderEntityID)
  hpCmpt:SetHPPosDirty(true)
  eHPBar:SetViewVisible(true)
  local go = eHPBar:View().ViewWrapper.GameObject
  local uiview = go:GetComponent("UIView")
  local redImg = uiview:GetUIComponent("Image", "red")
  local spriteRed = uiview:GetUIComponent("Image", "spriteRed")
  local spriteBlue = uiview:GetUIComponent("Image", "spriteBlue")
  local blueHp = trapData.HPSliderColor and trapData.HPSliderColor == 1
  redImg.sprite = blueHp == true and spriteBlue.sprite or spriteRed.sprite
  if trapData.HPSliderType == 2 then
    hpCmpt:SetShowTrapSep(true)
  end
end

function TrapServiceRender:_CreateBuffInfo(trapEntity, eHPBar)
  local hpCmpt = trapEntity:HP()
  local uiHpBuffInfoWidget = hpCmpt:GetUIHpBuffInfoWidget()
  if not uiHpBuffInfoWidget then
    local go = eHPBar:View().ViewWrapper.GameObject
    local uiview = go:GetComponent("UIView")
    local buffRootPath = uiview:GetUIComponent("UISelectObjectPath", "buffRoot")
    if buffRootPath then
      local buffRoot = UICustomWidgetPool:New(self, buffRootPath)
      buffRoot:SpawnObject("UIHPBuffInfo")
      local uiHPBuffInfo = buffRoot:GetAllSpawnList()[1]
      uiHPBuffInfo:SetData(trapEntity:GetID())
      hpCmpt:SetUIHpBuffInfoWidget(buffRoot)
    end
  end
end

function TrapServiceRender:_CreateTrapSkillInfo(trapEntity, eHPBar)
  local trapRenderCmpt = trapEntity:TrapRender()
  if #trapRenderCmpt:GetActiveSkillID() > 0 then
    local go = eHPBar:View().ViewWrapper.GameObject
    local uiview = go:GetComponent("UIView")
    local skillRootPath = uiview:GetUIComponent("UISelectObjectPath", "skillRoot")
    if skillRootPath then
      local skillRoot = UICustomWidgetPool:New(eHPBar, skillRootPath)
      skillRoot:SpawnObject("UITrapSkillInfo")
      skillRoot:GetAllSpawnList()[1]:SetData(trapEntity:GetID())
      local hpCmpt = trapEntity:HP()
      hpCmpt:SetUITrapSkillInfoWidget(skillRoot)
    end
  end
end

function TrapServiceRender:CreateTrapHeadShow(trapData, trapEntity)
  local entityService = self._world:GetService("RenderEntity")
  if trapData.HeadShowType == TrapHeadShowType.HeadShowRound then
    local roundInfoEntity = entityService:CreateRenderEntity(EntityConfigIDRender.HeadTrapRoundInfo)
    roundInfoEntity:ReplaceAsset(NativeUnityPrefabAsset:New("hud_trap_round_info.prefab"))
    roundInfoEntity:AddHUD()
    trapEntity:ReplaceTrapRoundInfoRender(roundInfoEntity:GetID(), trapData.HeadShowType, trapData.ShowParam)
  elseif trapData.HeadShowType == TrapHeadShowType.GridShowRound then
    local roundInfoEntity = entityService:CreateRenderEntity(EntityConfigIDRender.HeadTrapRoundInfo)
    roundInfoEntity:ReplaceAsset(NativeUnityPrefabAsset:New("GridRoundInfo.prefab"))
    trapEntity:ReplaceTrapRoundInfoRender(roundInfoEntity:GetID(), trapData.HeadShowType, trapData.ShowParam)
  elseif trapData.HeadShowType == TrapHeadShowType.HeadShowLevel then
    local roundInfoEntity = entityService:CreateRenderEntity(EntityConfigIDRender.HeadTrapRoundInfo)
    roundInfoEntity:ReplaceAsset(NativeUnityPrefabAsset:New("hud_trap_level_info.prefab"))
    roundInfoEntity:AddHUD()
    trapEntity:ReplaceTrapRoundInfoRender(roundInfoEntity:GetID(), trapData.HeadShowType, trapData.ShowParam)
  elseif trapData.HeadShowType == TrapHeadShowType.GridShowAnim then
    trapEntity:ReplaceTrapRoundInfoRender(nil, trapData.HeadShowType, trapData.ShowParam)
  elseif trapData.HeadShowType == TrapHeadShowType.HeadShowSummonIndex then
    local roundInfoEntity = entityService:CreateRenderEntity(EntityConfigIDRender.HeadTrapRoundInfo)
    roundInfoEntity:ReplaceAsset(NativeUnityPrefabAsset:New("hud_trap_level_info.prefab"))
    roundInfoEntity:AddHUD()
    trapEntity:ReplaceTrapRoundInfoRender(roundInfoEntity:GetID(), trapData.HeadShowType, trapData.ShowParam)
  elseif trapData.ShowParam and trapData.ShowParam.roundTotal then
    trapEntity:ReplaceTrapRoundInfoRender(nil, trapData.HeadShowType, trapData.ShowParam)
  end
end

function TrapServiceRender:_CreateTrapRoundInfo(trapData, trapEntity)
  local attrCmpt = trapEntity:RenderAttributes()
  local roundRender = trapEntity:TrapRoundInfoRender()
  if roundRender then
    local curRound = attrCmpt:GetAttribute("CurrentRound") or 1
    local totalRound = attrCmpt:GetAttribute("TotalRound")
    local last_effect_id = roundRender:GetLastEffectId()
    local inAnimName = roundRender:GetInAnimName()
    local outAnimName = roundRender:GetOutAnimName()
    if last_effect_id then
      local cur_effect_id = last_effect_id - totalRound + 1
      local entityID = roundRender:GetRoundInfoEntityID()
      local entity = self._world:GetEntityByID(entityID)
      if entity then
        self._world:DestroyEntity(entity)
      end
      local effectService = self._world:GetService("Effect")
      local posSummon = trapEntity:GridLocation().Position
      entity = effectService:CreateCommonGridEffect(cur_effect_id, posSummon)
      roundRender:SetRoundInfoEntityID(entity:GetID())
      roundRender:SetEffectID(cur_effect_id)
    elseif inAnimName then
      local roundCount = totalRound - curRound + 1
      self:_PlayRoundCountTrapAnim(trapEntity, roundCount)
    end
  end
end

function TrapServiceRender:_PlayRoundCountTrapAnim(trapEntity, roundCount)
  local roundRender = trapEntity:TrapRoundInfoRender()
  local inAnimName = roundRender:GetInAnimName()
  local outAnimName = roundRender:GetOutAnimName()
  local childCount = roundRender:GetChildCount()
  if trapEntity and trapEntity:View() then
    local gridGameObj = trapEntity:View().ViewWrapper.GameObject
    local goList = {}
    for i = 1, childCount do
      local stringName = "0" .. tostring(i)
      local go = GameObjectHelper.FindChild(gridGameObj.transform, stringName)
      table.insert(goList, go)
    end
    local renderBattleService = self._world:GetService("RenderBattle")
    for i, v in ipairs(goList) do
      if roundCount >= i then
        if roundRender:GetCurChildAnimState(i) ~= true then
          renderBattleService:PlayAnimationByGameObject(v, {inAnimName})
        end
        roundRender:SetCurChildAnimState(i, true)
      else
        if roundRender:GetCurChildAnimState(i) ~= false then
          renderBattleService:PlayAnimationByGameObject(v, {outAnimName})
        end
        roundRender:SetCurChildAnimState(i, false)
      end
    end
  end
end

function TrapServiceRender:_InitTrapInfoPosition(trapData, trapEntity)
  if trapData.HeadShowType == TrapHeadShowType.HeadShowRound then
    local render = trapEntity:TrapRoundInfoRender()
    local round_entity_id = render:GetRoundInfoEntityID()
    local round_entity = self._world:GetEntityByID(round_entity_id)
    self._entityRenderService:SetHudPosition(trapEntity, round_entity, render:GetOffset())
  elseif trapData.HeadShowType == TrapHeadShowType.GridShowRound then
  end
end

function TrapServiceRender:_ReplaceAsset(e, resPath, isHideOnBegin)
  e:ReplaceAsset(NativeUnityPrefabAsset:New(resPath, not isHideOnBegin))
end

function TrapServiceRender:_ShowAppearEffect(effectService, entityWork, listEffectID, nEffectType)
  if nil == listEffectID then
    return
  end
  for _, effectID in ipairs(listEffectID) do
    local effectEntity = effectService:CreateEffect(effectID, entityWork)
    local effectHolderCmpt = entityWork:EffectHolder()
    if effectHolderCmpt ~= nil then
      if 1 == nEffectType then
        effectHolderCmpt:AttachIdleEffect(effectEntity:GetID())
      else
        effectHolderCmpt:AttachPermanentEffect(effectEntity:GetID())
      end
    end
  end
end

function TrapServiceRender:RenderTrapState(TT, destroyType, calcStateTraps)
  local taskIDList = {}
  for _, e in ipairs(calcStateTraps) do
    local trapRenderCmpt = e:TrapRender()
    local taskID = TaskManager:GetInstance():CoreGameStartTask(self.PlayTrapDisappearSkill, self, {e})
    table.insert(taskIDList, taskID)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function TrapServiceRender:ChainMovePlayTrapTrigger(triggerTraps, entityObject)
  local nTrapCount = table.count(triggerTraps)
  if nTrapCount <= 0 then
    return nil
  end
  local listTaskReturn = {}
  for i = 1, nTrapCount do
    local entityTrap = triggerTraps[i]
    local listTaskID = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      self:PlayTrapTriggerSkill(TT, entityTrap, false, entityObject)
    end)
    if listTaskID then
      table.insert(listTaskReturn, listTaskID)
    end
  end
  table.appendArray(self._listTrapTask, listTaskReturn)
  return listTaskReturn
end

function TrapServiceRender:CanSelectByRaceType(trap, target)
  return self._trapTargetSelector:CanSelectTarget(trap, target)
end

function TrapServiceRender:PlayTrapTriggerSkill(TT, trapEntity, playGroupTrap, triggerEntity)
  local playSkillService = self._world:GetService("PlaySkill")
  local playBuffSvc = self._world:GetService("PlayBuff")
  local configService = self._world:GetService("Config")
  local cTrapRender = trapEntity:TrapRender()
  local triggerSkillContainer = cTrapRender:GetTriggerSkillResultContainer()
  if triggerSkillContainer then
    trapEntity:SkillRoutine():SetResultContainer(triggerSkillContainer)
  end
  local utilSvc = self._world:GetService("UtilData")
  local fakeTriggerSkillId = utilSvc:GetTrapFakeTriggerSkillID(trapEntity)
  local skillResult = trapEntity:SkillRoutine():GetResultContainer()
  local triggerSkillId = skillResult:GetSkillID()
  Log.debug("PlayTrapTriggerSkill() triggerSkillId=", triggerSkillId, " triggerEngity=", triggerEntity:GetID())
  local isSuperGrid = trapEntity:TrapRender():GetTrapRender_IsSuperGrid()
  local isPoorGrid = trapEntity:TrapRender():GetTrapRender_IsPoorGrid()
  local pos = trapEntity:GetGridPosition()
  
  local function DOStartSkillRoutine(TT, e, skillId, fakeSkillID)
    local ntSkillID = skillId
    if fakeSkillID then
      ntSkillID = fakeSkillID
    end
    playBuffSvc:PlayBuffView(TT, NTTrapSkillStart:New(e, ntSkillID, triggerEntity))
    if not isFakeSkill then
      playSkillService:PlaySkillViewSync(TT, e, skillId)
    end
    playBuffSvc:PlayBuffView(TT, NTTrapSkillEnd:New(e, ntSkillID, triggerEntity))
  end
  
  if triggerSkillId and 0 < triggerSkillId then
    DOStartSkillRoutine(TT, trapEntity, triggerSkillId, fakeTriggerSkillId)
  end
  if playGroupTrap then
    local traps = self:GetGroupTrap(trapEntity)
    if traps and 0 < table.count(traps) then
      for _, e in ipairs(traps) do
        local skillId = e:TrapRender():GetTriggerSkillID()
        if skillId then
          DOStartSkillRoutine(TT, e, skillId)
        end
      end
    end
  end
  if isSuperGrid then
    local nt = NTSuperGridTriggerEnd:New(pos)
    self._world:GetService("PlayBuff"):PlayBuffView(TT, nt)
  end
  if isPoorGrid then
    local nt = NTPoorGridTriggerEnd:New(pos)
    self._world:GetService("PlayBuff"):PlayBuffView(TT, nt)
  end
end

function TrapServiceRender:PlayTrapTriggerSkillTasks(TT, traps, playGroupTrap, triggerEntity)
  if traps and 0 < #traps then
    for _, trapEntity in ipairs(traps) do
      self:PlayTrapTriggerSkill(TT, trapEntity, playGroupTrap, triggerEntity)
    end
  end
end

function TrapServiceRender:_PlayTransferTrapDestroy(TT, transferOldEntityID)
  local taskIds = {}
  if not transferOldEntityID then
    return
  end
  local transferOldEntity = self._world:GetEntityByID(transferOldEntityID)
  if not transferOldEntity then
    return
  end
  local playSkillService = self._world:GetService("PlaySkill")
  local transferOldEntityRender = transferOldEntity:TrapRender()
  local skillId = transferOldEntityRender:GetDieSkillID()
  local hadPlayDead = transferOldEntityRender:GetHadPlayDead()
  if not hadPlayDead and skillId and 0 < skillId then
    local res = transferOldEntity:SkillRoutine():GetResultContainer("TrapDieSkill")
    transferOldEntity:SkillRoutine():SetResultContainer(res)
    local taskId = playSkillService:PlaySkillView(transferOldEntity, skillId)
    if taskId then
      table.insert(taskIds, taskId)
    end
    transferOldEntityRender:SetHadPlayDead()
  end
  if taskIds then
    while not TaskHelper:GetInstance():IsAllTaskFinished(taskIds) do
      YIELD(TT)
    end
  end
  self:DestroyTrap(TT, transferOldEntity)
end

function TrapServiceRender:_PlaySingleTrapAppearSkill(TT, e, trapData)
  local taskIds = {}
  if not e:HasView() then
    YIELD(TT)
  end
  local playSkillService = self._world:GetService("PlaySkill")
  local trapCmpt = e:TrapRender()
  local transferTrapEntityID = trapCmpt:GetTrapCreationResult():GetTransferTrapID()
  self:_PlayTransferTrapDestroy(TT, transferTrapEntityID)
  local replaceTrapId = trapCmpt:GetTrapCreationResult():GetReplaceTrapID()
  if replaceTrapId then
    local replaceTrap = self._world:GetEntityByID(replaceTrapId)
    if replaceTrap then
      local replaceTrapRender = replaceTrap:TrapRender()
      local skillId = replaceTrapRender:GetDieSkillID()
      local hadPlayDead = replaceTrapRender:GetHadPlayDead()
      if not hadPlayDead and skillId and 0 < skillId then
        local res = replaceTrap:SkillRoutine():GetResultContainer("TrapDieSkill")
        replaceTrap:SkillRoutine():SetResultContainer(res)
        local taskId = playSkillService:PlaySkillView(replaceTrap, skillId)
        if taskId then
          table.insert(taskIds, taskId)
        end
        replaceTrapRender:SetHadPlayDead()
      end
      if taskIds then
        while not TaskHelper:GetInstance():IsAllTaskFinished(taskIds) do
          YIELD(TT)
        end
      end
      self:DestroyTrap(TT, replaceTrap)
    end
  end
  local outsideRegion = e:OutsideRegion()
  if outsideRegion then
    local boardIndex = outsideRegion:GetBoardIndex()
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local renderMultiBoardCmpt = renderBoardEntity:RenderMultiBoard()
    local boardRoot = renderMultiBoardCmpt:GetMultiBoardRootGameObject(boardIndex)
    if boardRoot then
      local gameObject = e:View():GetGameObject()
      gameObject.transform.parent = boardRoot.transform
      gameObject.transform.localEulerAngles = Vector3(0, 0, 0)
    end
  end
  local showParam = trapData.ShowParam
  local dir = e:GetGridDirection()
  local forceDirection = false
  if showParam then
    local randomRotationOnBoard = tonumber(showParam.RandomRotationOnBoard)
    if randomRotationOnBoard then
      randomRotationOnBoard = randomRotationOnBoard * 200
      dir = Vector3.New(math.random(0, randomRotationOnBoard) * 0.01 - 1, 0, math.random(0, randomRotationOnBoard) * 0.01 - 1)
      forceDirection = true
    end
  end
  e:SetLocation(e:GetGridPosition() + e:GetGridOffset(), dir, forceDirection)
  e:SetViewVisible(true)
  self:OnCheckTrapViewSetPieceExtraLayer(e, e:GetGridPosition())
  local skillId = trapCmpt:GetAppearSkillID()
  if skillId and 0 < skillId and not trapCmpt:IsSkillHadPlay(skillId) then
    local appearSkillContainer = e:TrapRender():GetAppearSkillResultContainer()
    if appearSkillContainer then
      e:SkillRoutine():SetResultContainer(appearSkillContainer)
    end
    local taskId = playSkillService:PlaySkillView(e, skillId)
    trapCmpt:SetHadPlaySkill(skillId)
    if taskId then
      table.insert(taskIds, taskId)
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIds) do
    YIELD(TT)
  end
end

function TrapServiceRender:_PlayTriggerWhileSpawn(TT, e)
  local cTrapRender = e:TrapRender()
  local triggerSkillContainer = cTrapRender:GetTriggerSkillResultContainer()
  local triggerEntity = cTrapRender:GetTriggerSkillTriggeredEntity()
  if triggerSkillContainer and triggerEntity then
    self:PlayTrapTriggerSkill(TT, e, true, triggerEntity)
  end
end

function TrapServiceRender:PlayTrapAppearSkill(TT, traps)
  local taskIds = {}
  if not traps or table.count(traps) <= 0 then
    return taskIds
  end
  local playSkillService = self._world:GetService("PlaySkill")
  for _, e in ipairs(traps) do
    if not e:HasView() then
      YIELD(TT)
    end
    local trapCmpt = e:TrapRender()
    local transferTrapEntityID = trapCmpt:GetTrapCreationResult():GetTransferTrapID()
    self:_PlayTransferTrapDestroy(TT, transferTrapEntityID)
    local replaceTrapId = trapCmpt:GetTrapCreationResult():GetReplaceTrapID()
    if replaceTrapId then
      local replaceTrap = self._world:GetEntityByID(replaceTrapId)
      if replaceTrap then
        local replaceTrapRender = replaceTrap:TrapRender()
        local skillId = replaceTrapRender:GetDieSkillID()
        local hadPlayDead = replaceTrapRender:GetHadPlayDead()
        if not hadPlayDead and skillId and 0 < skillId then
          local res = replaceTrap:SkillRoutine():GetResultContainer("TrapDieSkill")
          replaceTrap:SkillRoutine():SetResultContainer(res)
          local taskId = playSkillService:PlaySkillView(replaceTrap, skillId)
          if taskId then
            table.insert(taskIds, taskId)
          end
          replaceTrapRender:SetHadPlayDead()
        end
        table.appendArray(self._listTrapTask, taskIds)
        if taskIds then
          while not TaskHelper:GetInstance():IsAllTaskFinished(taskIds) do
            YIELD(TT)
          end
        end
        self:DestroyTrap(TT, replaceTrap)
      end
    end
    local outsideRegion = e:OutsideRegion()
    if outsideRegion then
      local boardIndex = outsideRegion:GetBoardIndex()
      local renderBoardEntity = self._world:GetRenderBoardEntity()
      local renderMultiBoardCmpt = renderBoardEntity:RenderMultiBoard()
      local boardRoot = renderMultiBoardCmpt:GetMultiBoardRootGameObject(boardIndex)
      if boardRoot then
        local gameObject = e:View():GetGameObject()
        gameObject.transform.parent = boardRoot.transform
        gameObject.transform.localEulerAngles = Vector3(0, 0, 0)
      end
    end
    e:SetLocation(e:GetGridPosition() + e:GetGridOffset(), e:GetGridDirection())
    e:SetViewVisible(true)
    local skillId = trapCmpt:GetAppearSkillID()
    if skillId and 0 < skillId and not trapCmpt:IsSkillHadPlay(skillId) then
      local appearSkillContainer = e:TrapRender():GetAppearSkillResultContainer()
      if appearSkillContainer then
        e:SkillRoutine():SetResultContainer(appearSkillContainer)
      end
      local taskId = playSkillService:PlaySkillView(e, skillId)
      trapCmpt:SetHadPlaySkill(skillId)
      if taskId then
        table.insert(taskIds, taskId)
      end
    end
  end
  table.appendArray(self._listTrapTask, taskIds)
  if taskIds then
    while not TaskHelper:GetInstance():IsAllTaskFinished(taskIds) do
      YIELD(TT)
    end
  end
  local triggerWhileSpawnTaskID = {}
  for _, e in ipairs(traps) do
    local cTrapRender = e:TrapRender()
    local triggerSkillContainer = cTrapRender:GetTriggerSkillResultContainer()
    local triggerEntity = cTrapRender:GetTriggerSkillTriggeredEntity()
    if triggerSkillContainer and triggerEntity then
      local id = GameGlobal.TaskManager():CoreGameStartTask(self.PlayTrapTriggerSkill, self, e, true, triggerEntity)
      if id then
        table.insert(triggerWhileSpawnTaskID, id)
      end
    end
  end
  table.appendArray(self._listTrapTask, triggerWhileSpawnTaskID)
  while not TaskHelper:GetInstance():IsAllTaskFinished(triggerWhileSpawnTaskID) do
    YIELD(TT)
  end
  for _, e in ipairs(traps) do
    e:TrapRender():SetAppearSkillResultContainer()
    e:TrapRender():SetTriggerSkillResultContainer()
    e:TrapRender():SetTriggerSkillTriggeredEntity()
  end
  return taskIds
end

function TrapServiceRender:PlayTrapDisappearSkill(TT, traps)
  local taskIds = {}
  if not traps or table.count(traps) <= 0 then
    return taskIds
  end
  local playSkillService = self._world:GetService("PlaySkill")
  for _, e in ipairs(traps) do
    local cTrap = e:TrapRender()
    local skillId = cTrap:GetDisappearSkillID()
    local deadMarkCmpt = e:DeadMark()
    local deadNotPlayDisappear = cTrap:GetDeadNotPlayDisappear()
    local canPlayDisappear = true
    if deadNotPlayDisappear == 1 and deadMarkCmpt and deadMarkCmpt:GetDeadCasterID() ~= nil then
      canPlayDisappear = false
    end
    if skillId and 0 < skillId and canPlayDisappear then
      local taskId = playSkillService:PlaySkillView(e, skillId)
      if taskId then
        table.insert(taskIds, taskId)
      end
    end
    local dieSkillID = cTrap:GetDieSkillID()
    if 0 < dieSkillID and skillId == 0 then
      local taskId = self:PlayTrapDieSkill(TT, {e})
      table.insert(taskIds, taskId)
    end
  end
  if taskIds then
    while not TaskHelper:GetInstance():IsAllTaskFinished(taskIds) do
      YIELD(TT)
    end
  end
  self:DestroyTrapList(TT, traps)
  return taskIds
end

function TrapServiceRender:RenderPlayTrapsDie(TT, traps)
  local deadTraps = {}
  for _, e in pairs(traps) do
    if e:HasDeadFlag() then
      table.insert(deadTraps, e)
    end
  end
  if not deadTraps or table.count(deadTraps) <= 0 then
    return
  end
  local taskId = self:PlayTrapDieSkill(TT, deadTraps)
  JOIN(TT, taskId)
end

function TrapServiceRender:PlayTrapPreChainSkill(trapIds)
  local sPlaySkill = self._world:GetService("PlaySkill")
  local taskIds = {}
  for i, id in ipairs(trapIds) do
    local e = self._world:GetEntityByID(id)
    local cTrap = e:TrapRender()
    if cTrap then
      local skillId = cTrap:GetPreChainSkillID()
      if skillId and 0 < skillId then
        local taskId = sPlaySkill:PlaySkillView(e, skillId)
        table.insert(taskIds, taskId)
      end
    end
  end
  return taskIds
end

function TrapServiceRender:DestroyTrapList(TT, es, bForce)
  if not es then
    return
  end
  for i, e in ipairs(es) do
    self:DestroyTrap(TT, e, bForce)
  end
end

function TrapServiceRender:DestroyTrap(TT, entityWork, bForce)
  if not entityWork then
    return
  end
  local trapRenderCmpt = entityWork:TrapRender()
  if not trapRenderCmpt then
    return
  end
  if not bForce and trapRenderCmpt:GetTrapType() == TrapType.Protected then
    return
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  local ntTrapDeadStart = NTTrapDeadStart:New(entityWork)
  local ntTrapDead = NTTrapDead:New(entityWork)
  local ownEntity = entityWork:GetSummonerEntity()
  if ownEntity then
    ntTrapDeadStart:SetOwnerEntity(ownEntity)
    ntTrapDead:SetOwnerEntity(ownEntity)
  end
  playBuffSvc:PlayBuffView(TT, ntTrapDeadStart)
  playBuffSvc:PlayBuffView(TT, ntTrapDead)
  self:DestoryHPSlider(entityWork)
  self:DestroyTrapRoundInfoRender(entityWork)
  local fxsvc = self._world:GetService("Effect")
  fxsvc:ClearEntityEffect(entityWork)
  entityWork:SetViewVisible(false)
  trapRenderCmpt:SetHadPlayDestroy()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TrapRenderDestroy, trapRenderCmpt:GetTrapID())
end

function TrapServiceRender:PlayTrapDieSkill(TT, traps, donotPlayDie)
  local taskIds = {}
  if not traps or table.count(traps) <= 0 then
    return taskIds
  end
  if not donotPlayDie then
    local dieTrapList = {}
    local playSkillService = self._world:GetService("PlaySkill")
    for _, e in ipairs(traps) do
      local trapRenderCmpt = e:TrapRender()
      local hadPlayDead = trapRenderCmpt:GetHadPlayDead()
      if not hadPlayDead then
        local skillId = trapRenderCmpt:GetDieSkillID()
        if skillId and 0 < skillId then
          local res = e:SkillRoutine():GetResultContainer("TrapDieSkill")
          e:SkillRoutine():SetResultContainer(res)
          local taskId = playSkillService:PlaySkillView(e, skillId)
          if taskId then
            table.insert(taskIds, taskId)
          end
        end
        trapRenderCmpt:SetHadPlayDead()
        local renderPos = e:GetRenderGridPosition()
        if trapRenderCmpt:GetTrapLevel() == 0 then
          self:ShowHideTrapAtPos(renderPos, true)
        end
        table.insert(dieTrapList, e)
      end
    end
    table.appendArray(self._listTrapTask, taskIds)
    if taskIds then
      while not TaskHelper:GetInstance():IsAllTaskFinished(taskIds) do
        YIELD(TT)
      end
    end
    self:DestroyTrapList(TT, dieTrapList)
  else
    for _, e in ipairs(traps) do
      local trapRenderCmpt = e:TrapRender()
      trapRenderCmpt:SetHadPlayDead()
    end
    self:DestroyTrapList(TT, traps)
  end
  return taskIds
end

function TrapServiceRender:DestoryHPSlider(e)
  local cHP = e:HP()
  if cHP then
    cHP:ResetHP(0, cHP:GetMaxHP())
    cHP:WidgetPoolCleanup()
    local sliderEntityID = cHP:GetHPSliderEntityID()
    local sliderEntity = self._world:GetEntityByID(sliderEntityID)
    if sliderEntity then
      self._world:DestroyEntity(sliderEntity)
    end
  end
end

function TrapServiceRender:DestroyTrapRoundInfoRender(e)
  local render = e:TrapRoundInfoRender()
  if render then
    local eId = render:GetRoundInfoEntityID()
    local eRound = self._world:GetEntityByID(eId)
    if eRound then
      self._world:DestroyEntity(eRound)
      e:RemoveTrapRoundInfoRender()
    end
  end
end

function TrapServiceRender:IsTrapViewTaskOver()
  if nil == self._listTrapTask then
    return true
  end
  return TaskHelper:GetInstance():IsAllTaskFinished(self._listTrapTask)
end

function TrapServiceRender:ClearTrapViewTask()
  self._listTrapTask = {}
end

function TrapServiceRender:PlayAllTrapDead(TT)
  local deadTraps = {}
  local deadGroup = self._world:GetGroup(self._world.BW_WEMatchers.DeadFlag)
  for _, e in ipairs(deadGroup:GetEntities()) do
    if e:HasTrapID() and e:TrapRender():GetTrapType() ~= TrapType.BombByHitBack then
      table.insert(deadTraps, e)
    end
  end
  if table.count(deadTraps) <= 0 then
    return
  end
  local taskId = self:PlayTrapDieSkill(TT, deadTraps)
  JOIN(TT, taskId)
end

function TrapServiceRender:PlayOneTrapDead(TT, trapEntity)
  if not trapEntity:HasDeadFlag() then
    return
  end
  local taskId = self:PlayTrapDieSkill(TT, {trapEntity})
  JOIN(TT, taskId)
end

function TrapServiceRender:CanDestroyAtOnce(e)
  local trapRenderCmpt = e:TrapRender()
  if not trapRenderCmpt then
    return false
  end
  if trapRenderCmpt:GetTrapType() == TrapType.Protected then
    return false
  end
  if e:HasDeadFlag() then
    return true
  end
  return false
end

function TrapServiceRender:IsRuneTrap(e)
  if not e:HasTrapRender() then
    return false
  end
  local trapRenderCmpt = e:TrapRender()
  local trapEffectType = trapRenderCmpt:GetTrapRenderEffectType()
  if trapEffectType == TrapEffectType.RuneChange then
    return true
  end
  return false
end

function TrapServiceRender:CalcUIPos(trapEntity)
  local trapRenderCmpt = trapEntity:TrapRender()
  if trapRenderCmpt:GetTrapRender_IsAircraftCore() then
    return Vector3(310, 80, 0)
  end
  local guideModule = GameGlobal.GetModule(GuideModule)
  if trapRenderCmpt:GetTrapRender_IsCastSkillByRound() and guideModule:GuideInProgress() then
    return Vector3(-100, 0, 0)
  end
  local camera = self._world:MainCamera():Camera()
  local inputCmpt = self._world:Input()
  local inputPos = inputCmpt:GetTouchBeginPosition()
  inputPos = inputPos or trapEntity:Location():GetPosition()
  local screenPos = camera:WorldToScreenPoint(inputPos)
  local areaIndex = self:_CalcAreaIndex(screenPos, camera)
  local baseOffset = self._offsetDic[areaIndex]
  local areaOffset = Vector2(baseOffset.x, baseOffset.y)
  local baseWidth = 1920
  local baseHeight = 1080
  local adaptWidth = UnityEngine.Screen.width * areaOffset.x / baseWidth
  local adaptHeight = UnityEngine.Screen.height * areaOffset.y / baseHeight
  areaOffset.x = adaptWidth
  areaOffset.y = adaptHeight
  local targetScreenPos = areaOffset + screenPos
  local sw = ResolutionManager.ScreenWidth()
  local rw = ResolutionManager.RealWidth()
  local rh = ResolutionManager.RealHeight()
  local factor = rw / sw
  local sx, sy = targetScreenPos.x * factor - rw / 2, targetScreenPos.y * factor - rh / 2
  targetScreenPos = Vector2(sx, sy)
  return targetScreenPos
end

function TrapServiceRender:_CalcAreaIndex(screenPos, camera)
  local halfPixelWidth = camera.pixelWidth / 2
  local halfPixelHeight = camera.pixelHeight / 2
  local areaIndex = 0
  if halfPixelWidth >= screenPos.x then
    if halfPixelHeight >= screenPos.y then
      areaIndex = 1
    else
      areaIndex = 2
    end
  elseif halfPixelHeight >= screenPos.y then
    areaIndex = 3
  else
    areaIndex = 4
  end
  return areaIndex
end

function TrapServiceRender:GetGroupTrap(eTrapRender)
  local cTrap = eTrapRender:TrapRender()
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local traps = {}
  local triggerTargetTrapID = cTrap:GetGroupTriggerTrapID()
  for _, trapEntity in ipairs(trapGroup:GetEntities()) do
    local cTrapInGroup = trapEntity:TrapRender()
    if eTrapRender:GetID() ~= trapEntity:GetID() and cTrap:GetGroupID() ~= 0 and cTrapInGroup:GetGroupID() ~= 0 and cTrap:GetGroupID() == cTrapInGroup:GetGroupID() and (not triggerTargetTrapID or triggerTargetTrapID == cTrapInGroup:GetTrapID()) then
      table.insert(traps, trapEntity)
    end
  end
  return traps
end

function TrapServiceRender:UpdateTrapGridRound()
  local effectService = self._world:GetService("Effect")
  local groupEntityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.TrapRoundInfoRender)
  for i, e in ipairs(groupEntityList) do
    self:UpdateTrapExistShow(e)
  end
end

function TrapServiceRender:_UpdateTrapGridShowRound(entity, reInit)
  local effectService = self._world:GetService("Effect")
  local roundRenderCmpt = entity:TrapRoundInfoRender()
  local attrCmpt = entity:RenderAttributes()
  local curRound = attrCmpt:GetAttribute("CurrentRound") or 1
  local totalRound = attrCmpt:GetAttribute("TotalRound")
  local pos = entity:GridLocation().Position
  local last_effect_id = roundRenderCmpt:GetLastEffectId()
  local cur_effect_id = last_effect_id - totalRound + curRound
  if reInit then
  end
  local pre_effect_id = roundRenderCmpt:GetEffectID()
  if pre_effect_id == nil then
    roundRenderCmpt:SetEffectID(last_effect_id - totalRound + 1)
    return
  end
  if reInit or pre_effect_id ~= cur_effect_id and pre_effect_id ~= last_effect_id then
    local entityID = roundRenderCmpt:GetRoundInfoEntityID()
    local entity = self._world:GetEntityByID(entityID)
    if entity then
      self._world:DestroyEntity(entity)
    end
    entity = effectService:CreateCommonGridEffect(cur_effect_id, pos)
    roundRenderCmpt:SetRoundInfoEntityID(entity:GetID())
    roundRenderCmpt:SetEffectID(cur_effect_id)
  end
end

function TrapServiceRender:UpdateTrapExistShow(entity, reInit)
  local roundRenderCmpt = entity:TrapRoundInfoRender()
  if not roundRenderCmpt then
    return
  end
  if roundRenderCmpt:GetHeadShowType() == TrapHeadShowType.GridShowRound then
    self:_UpdateTrapGridShowRound(entity, reInit)
  elseif roundRenderCmpt:GetHeadShowType() == TrapHeadShowType.GridShowAnim then
    self:_UpdateTrapGridShowAnim(entity)
  end
end

function TrapServiceRender:_UpdateTrapGridShowAnim(entity)
  local attrCmpt = entity:RenderAttributes()
  local curRound = attrCmpt:GetAttribute("CurrentRound") or 1
  local totalRound = attrCmpt:GetAttribute("TotalRound")
  local roundRender = entity:TrapRoundInfoRender()
  local inAnimName = roundRender:GetInAnimName()
  if inAnimName then
    local roundCount = totalRound - curRound + 1
    self:_PlayRoundCountTrapAnim(entity, roundCount)
  end
end

function TrapServiceRender:UpdateAllTrapSummonIndex()
  local effectService = self._world:GetService("Effect")
  local groupEntityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.TrapRoundInfoRender)
  for i, e in ipairs(groupEntityList) do
    self:UpdateTrapSummonIndex(e)
  end
end

function TrapServiceRender:UpdateTrapSummonIndex(entity)
  local roundRenderCmpt = entity:TrapRoundInfoRender()
  if roundRenderCmpt:GetHeadShowType() == TrapHeadShowType.HeadShowSummonIndex then
    self:_UpdateTrapSummonIndex(entity)
  end
end

function TrapServiceRender:_UpdateTrapSummonIndex(entity)
  local utilDataSvc = self._world:GetService("UtilData")
  local trapRenderCmpt = entity:TrapRender()
  local trapID = trapRenderCmpt:GetTrapID()
  local trapEntityID = entity:GetID()
  local entityIDList = utilDataSvc:GetSummonMeantimeLimitEntityID(trapID)
  local curIndex = 1
  for index, recordEntityID in ipairs(entityIDList) do
    if trapEntityID == recordEntityID then
      curIndex = index
      break
    end
  end
  local roundRender = entity:TrapRoundInfoRender()
  local round_entity_id = roundRender:GetRoundInfoEntityID()
  local round_entity = self._world:GetEntityByID(round_entity_id)
  local num = curIndex
  local go = round_entity:View().ViewWrapper.GameObject
  local uiview = go:GetComponent("UIView")
  if uiview and num then
    local numText = uiview:GetUIComponent("UILocalizationText", "LevelNumText")
    if numText then
      numText:SetText(num)
    end
  end
  roundRender:SetIsShow(true)
  round_entity:SetViewVisible(true)
  local renderEntityService = self._world:GetService("RenderEntity")
  renderEntityService:SetHudPosition(entity, round_entity, roundRender:GetOffset())
end

function TrapServiceRender:IsPieceExtraLayerTrap(trapEntity)
  local trapRenderCmpt = trapEntity:TrapRender()
  if not trapRenderCmpt then
    return false
  end
  local isSuperGrid = trapRenderCmpt:GetTrapRender_IsSuperGrid()
  local isPoorGrid = trapRenderCmpt:GetTrapRender_IsPoorGrid()
  local isLockedGrid = trapRenderCmpt:GetTrapRender_IsLockedGrid()
  local isBrokenGrid = trapRenderCmpt:GetTrapRender_IsBrokenGrid()
  if isSuperGrid or isPoorGrid or isLockedGrid or isBrokenGrid then
    return true
  end
  return false
end

function TrapServiceRender:OnCheckTrapViewSetPieceExtraLayer(trapEntity, pos)
  if not trapEntity:View() then
    return
  end
  local isPieceExtraLayerTrap = self:IsPieceExtraLayerTrap(trapEntity)
  if isPieceExtraLayerTrap == false then
    return
  end
  local pieceServiceRender = self._world:GetService("Piece")
  local pieceEntity = pieceServiceRender:FindPieceEntity(pos)
  if not pieceEntity then
    return
  end
  local trapObj = trapEntity:View().ViewWrapper.GameObject
  if not trapObj or tostring(trapObj) == "null" then
    return
  end
  if APPVER_LAYERORDER then
    local tLayerOrderComponent = trapObj.gameObject:GetComponentInChildren(typeof(TLayerOrderComponent))
    if tLayerOrderComponent then
      UnityEngine.GameObject.Destroy(tLayerOrderComponent)
    end
  end
  local pieceComponent = pieceEntity:Piece()
  local extraLayerTransform = pieceComponent:OnGetLayerTransform("ExtraLayer")
  trapObj.transform.parent = extraLayerTransform
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT)
    if trapObj and tostring(trapObj) ~= "null" and trapObj.transform and trapObj.transform.localPosition ~= Vector3(0, 0, 0) then
      trapObj.transform.localPosition = Vector3(0, 0, 0)
    end
  end)
end

function TrapServiceRender:OnTakeOutTrapFormPiece(pos)
  local utilSvc = self._world:GetService("UtilData")
  local traps = utilSvc:GetTrapsAtPos(pos)
  if not traps then
    return
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  for index, trapEntity in ipairs(traps) do
    local isPieceExtraLayerTrap = self:IsPieceExtraLayerTrap(trapEntity)
    if trapEntity:View() then
      local trapObj = trapEntity:View().ViewWrapper.GameObject
      if isPieceExtraLayerTrap and trapObj.transform.parent ~= nil then
        trapObj.transform.parent = nil
        local renderPos = boardServiceRender:GridPos2RenderPos(pos)
        renderPos = Vector3(renderPos.x, 0.01, renderPos.z)
        trapObj.transform.position = renderPos
        if APPVER_LAYERORDER then
          local tLayerOrderComponent = trapObj.gameObject:GetComponent(typeof(TLayerOrderComponent))
          tLayerOrderComponent = tLayerOrderComponent or trapObj.gameObject:AddComponent(typeof(TLayerOrderComponent))
          if tLayerOrderComponent then
            tLayerOrderComponent:SetSortLayer("GeziEffect")
          end
        end
      end
    end
  end
end

function TrapServiceRender:OnGiveBackTrapToPiece(pos)
  local utilSvc = self._world:GetService("UtilData")
  local traps = utilSvc:GetTrapsAtPos(pos)
  if not traps then
    return
  end
  for index, trapEntity in ipairs(traps) do
    self:OnCheckTrapViewSetPieceExtraLayer(trapEntity, pos)
  end
end
