_class("InnerGameHelperRender", Singleton)
InnerGameHelperRender = InnerGameHelperRender

function InnerGameHelperRender:Constructor()
  self._ElementIconAtlas = ResourceManager:GetInstance():SyncLoadAsset("InnerUI.spriteatlas", LoadType.SpriteAtlas)
  self.atlasProperty = ResourceManager:GetInstance():SyncLoadAsset("Property.spriteatlas", LoadType.SpriteAtlas)
end

function InnerGameHelperRender:Dispose()
  if self._ElementIconAtlas then
    self._ElementIconAtlas:Dispose()
    self._ElementIconAtlas = nil
  end
end

function InnerGameHelperRender:GetLifeBarIconByElement(elementType)
  if not self.atlasProperty then
    self.atlasProperty = ResourceManager:GetInstance():SyncLoadAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  end
  local iconName = Cfg.cfg_pet_element[elementType]
  if not iconName then
    Log.fatal("GetConfigIconFailed ElementType:", elementType)
    return
  end
  local sprite = self.atlasProperty.Obj:GetSprite(UIPropertyHelper:GetInstance():GetColorBlindSprite(iconName.Icon .. "_battle"))
  return sprite
end

function InnerGameHelperRender:GetImageFromInnerUI(imageName)
  if not self._ElementIconAtlas then
    self._ElementIconAtlas = ResourceManager:GetInstance():SyncLoadAsset("InnerUI.spriteatlas", LoadType.SpriteAtlas)
  end
  return self._ElementIconAtlas.Obj:GetSprite(imageName)
end

function InnerGameHelperRender:GetGameObject(entity)
  if entity == nil then
    return nil
  end
  local viewCmpt = entity:View()
  if viewCmpt == nil then
    return nil
  end
  local gameObj = viewCmpt:GetGameObject()
  return gameObj
end

function InnerGameHelperRender:SetHpSliderElementIcon(TT, entity, elementType)
  local gameObject = self:GetGameObject(entity)
  if not gameObject then
    Log.fatal("SetHpSliderElementIcon Failed ElementType:", elementType)
    return false
  end
  local uiView = gameObject:GetComponent("UIView")
  local elementIcon = uiView:GetUIComponent("Image", "imgElement")
  if elementIcon and elementType ~= 0 then
    elementIcon.gameObject:SetActive(true)
    elementIcon.sprite = self:GetLifeBarIconByElement(elementType)
  else
    elementIcon.gameObject:SetActive(false)
  end
  local imgBG = uiView:GetUIComponent("Image", "imgBG")
  local eff_glow = uiView:GetGameObject("eff_glow")
  imgBG.gameObject:SetActive(false)
  eff_glow:SetActive(false)
  return true
end

function InnerGameHelperRender:IsUIBannerComplete(TT)
  local uiBannerShow = GameGlobal.UIStateManager():IsShow("UIStoryBanner")
  while uiBannerShow == false do
    uiBannerShow = GameGlobal.UIStateManager():IsShow("UIStoryBanner")
    YIELD(TT)
    if not GameGlobal:GetInstance():IsCoreGameRunning() then
      return
    end
  end
  while uiBannerShow == true do
    uiBannerShow = GameGlobal.UIStateManager():IsShow("UIStoryBanner")
    YIELD(TT)
    if not GameGlobal:GetInstance():IsCoreGameRunning() then
      return
    end
  end
end

function InnerGameHelperRender:SetKeepAnimatorControllerStateOnDisable(casterEntity, bDisable)
  local gameObject = casterEntity:View().ViewWrapper.GameObject
  if not gameObject then
    Log.fatal("[SetKeepAnimatorControllerStateOnDisable] gameObject is Nil")
    return
  end
  local rootGO = gameObject.transform:Find("Root")
  if not rootGO then
    Log.fatal("[SetKeepAnimatorControllerStateOnDisable] rootGO is Nil")
    return
  end
  local animator = rootGO:GetComponent("Animator")
  animator = animator or gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))
  if not animator then
    Log.fatal("[SetKeepAnimatorControllerStateOnDisable] animator is Nil")
    return
  end
  local bData = bDisable or true
  local nOldData = animator.keepAnimatorControllerStateOnDisable
  animator.keepAnimatorControllerStateOnDisable = bData
  return nOldData
end

function InnerGameHelperRender:SetAnimatorControllerTrigger(entity, triggerTable, needUpdate)
  local gameObject = entity:View().ViewWrapper.GameObject
  if not gameObject then
    Log.fatal("[SetAnimatorControllerTrigger] gameObject is Nil")
    return
  end
  local rootGO = gameObject.transform:Find("Root")
  if not rootGO then
    Log.fatal("[SetAnimatorControllerTrigger] rootGO is Nil")
    return
  end
  local animator = rootGO:GetComponent("Animator")
  animator = animator or gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))
  if not animator then
    Log.fatal("[SetAnimatorControllerTrigger] animator is Nil", Log.traceback())
    return
  end
  for i = 1, #triggerTable do
    animator:SetTrigger(triggerTable[i])
  end
  if needUpdate then
    animator:Update(0)
  end
end

function InnerGameHelperRender:SetAnimatorControllerBool(entity, boolTable)
  local gameObject = entity:View().ViewWrapper.GameObject
  if not gameObject then
    Log.fatal("[SetAnimatorControllerBool] gameObject is Nil")
    return
  end
  local rootGO = gameObject.transform:Find("Root")
  if not rootGO then
    Log.fatal("[SetAnimatorControllerBool] rootGO is Nil")
    return
  end
  local animator = rootGO:GetComponent("Animator")
  animator = animator or gameObject:GetComponentInChildren(typeof(UnityEngine.Animator))
  if not animator then
    Log.fatal("[SetAnimatorControllerBool] animator is Nil")
    return
  end
  for param, value in pairs(boolTable) do
    animator:SetBool(param, value)
  end
end

function InnerGameHelperRender.GetMainWorld()
  local gameGlobal = GameGlobal:GetInstance()
  local mainWorld = gameGlobal:GetMainWorld()
  return mainWorld
end

function InnerGameHelperRender.GetTrapCurRoundCanCastSkillCount(trapEntityID)
  local oneRoundLimit = InnerGameHelperRender.GetTrapAttribute(trapEntityID, "OneRoundLimit")
  local castSkillRound = InnerGameHelperRender.GetTrapAttribute(trapEntityID, "CastSkillRound")
  local world = InnerGameHelperRender.GetMainWorld()
  local battleStatCmpt = world:BattleStat()
  local curRound = battleStatCmpt:GetLevelTotalRoundCount()
  for _, round in ipairs(castSkillRound) do
    if round == curRound then
      oneRoundLimit = oneRoundLimit - 1
    end
  end
  return oneRoundLimit
end

function InnerGameHelperRender.GetTrapAttribute(trapEntityID, attribute)
  local world = InnerGameHelperRender.GetMainWorld()
  local e = world:GetEntityByID(trapEntityID)
  local attributesComponent = e:Attributes()
  return attributesComponent:GetAttribute(attribute)
end

function InnerGameHelperRender.GetTrapCanCastSkill(trapEntityID)
  local world = InnerGameHelperRender.GetMainWorld()
  local trapLogic = world:GetService("TrapLogic")
  local e = world:GetEntityByID(trapEntityID)
  local ret = trapLogic:CanCastTrapSkill(e)
  return ret
end

function InnerGameHelperRender.CalcUIPos(trapEntityID)
  local world = InnerGameHelperRender.GetMainWorld()
  local trapRender = world:GetService("TrapRender")
  local e = world:GetEntityByID(trapEntityID)
  local ret = trapRender:CalcUIPos(e)
  return ret
end

function InnerGameHelperRender.GetTrapActiveSkillList(trapEntityID)
  local world = InnerGameHelperRender.GetMainWorld()
  local trapLogic = world:GetService("TrapLogic")
  local e = world:GetEntityByID(trapEntityID)
  local ret = trapLogic:GetTrapActiveSkillList(e)
  return ret
end

function InnerGameHelperRender.GetTrapIsCastSkillByRound(trapEntityID)
  local world = InnerGameHelperRender.GetMainWorld()
  local e = world:GetEntityByID(trapEntityID)
  return e:TrapRender():GetTrapRender_IsCastSkillByRound()
end

function InnerGameHelperRender.GetUIBuffViewArray(entityID, onBlood)
  local world = GameGlobal:GetInstance():GetMainWorld()
  local entity = world:GetEntityByID(entityID)
  if not entity then
    return {}
  end
  local buffViewComponent = entity:BuffView()
  if buffViewComponent == nil then
    return {}
  end
  local buffViewArray = buffViewComponent:GetBuffViewShowList(onBlood)
  if not buffViewArray or #buffViewArray == 0 then
    return {}
  end
  local arr = {}
  for _, buff in ipairs(buffViewArray) do
    if buff and buff:BuffConfigData():GetBuffShowBuffIcon() then
      table.insert(arr, buff)
    end
  end
  return arr
end

function InnerGameHelperRender.GetBuffViewByPetPstID(petPstID)
  local world = GameGlobal:GetInstance():GetMainWorld()
  local entity
  local group = world:GetGroup(world.BW_WEMatchers.PetPstID)
  local petEntities = group:GetEntities()
  for i, e in ipairs(petEntities) do
    local cPetPstID = e:PetPstID()
    if petPstID == cPetPstID:GetPstID() then
      entity = e
      break
    end
  end
  if not entity then
    return {}
  end
  local buffViewComponent = entity:BuffView()
  if buffViewComponent == nil then
    return {}
  end
  local buffViewArray = buffViewComponent:GetBuffViewInstanceArray()
  return buffViewArray
end

function InnerGameHelperRender.GetBuffValue(petPstID, key)
  local world = GameGlobal:GetInstance():GetMainWorld()
  local entity
  local group = world:GetGroup(world.BW_WEMatchers.PetPstID)
  local petEntities = group:GetEntities()
  for i, e in ipairs(petEntities) do
    local cPetPstID = e:PetPstID()
    if petPstID == cPetPstID:GetPstID() then
      entity = e
      break
    end
  end
  if not entity then
    return
  end
  local buffViewComponent = entity:BuffView()
  if buffViewComponent == nil then
    return
  end
  return buffViewComponent:GetBuffValue(key)
end

function InnerGameHelperRender.IsEntityDead(entityID)
  local world = GameGlobal:GetInstance():GetMainWorld()
  local entity = world:GetEntityByID(entityID)
  return not entity or entity:HasDeadFlag()
end

function InnerGameHelperRender.GetSingleBuffByBuffEffect(entityID, buffEffectType)
  local world = GameGlobal:GetInstance():GetMainWorld()
  local entity = world:GetEntityByID(entityID)
  if not entity then
    return
  end
  local buffViewComponent = entity:BuffView()
  if buffViewComponent == nil then
    return
  end
  local buffViewInstance = buffViewComponent:GetSingleBuffByBuffEffect(buffEffectType)
  return buffViewInstance
end

function InnerGameHelperRender.RemoveBuffViewInstance(entityID, buffViewInstance)
  local world = GameGlobal:GetInstance():GetMainWorld()
  local entity = world:GetEntityByID(entityID)
  if not entity then
    return
  end
  if buffViewInstance then
    entity:RemoveBuffViewInstance(buffViewInstance)
  end
end

function InnerGameHelperRender.GridPos2WorldPos(pos)
  local basePos = Vector3(-4, 0, -3)
  local pieceHeight = 0
  local xOffset = pos.x - 1
  local zOffset = pos.y - 1
  local gridRenderPos = basePos + Vector3(xOffset, pieceHeight, zOffset)
  local camera = GameGlobal:GetInstance():GetMainWorld():MainCamera():Camera()
  local screenPos = camera:WorldToScreenPoint(gridRenderPos)
  return screenPos
end

function InnerGameHelperRender.WorldPos2ScreenPos(worldPos)
  local camera = GameGlobal:GetInstance():GetMainWorld():MainCamera():Camera()
  local screenPos = camera:WorldToScreenPoint(worldPos)
  return screenPos
end

function InnerGameHelperRender.UICheckIsFifthPet(petPstID)
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  local shareDataSvc = mainWorld:GetService("UtilData")
  return shareDataSvc:IsFifthPetInTeamOrder(petPstID)
end

function InnerGameHelperRender.UICheckIsFourthPet(petPstID)
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  local shareDataSvc = mainWorld:GetService("UtilData")
  return shareDataSvc:IsFourthPetInTeamOrder(petPstID)
end

function InnerGameHelperRender.UICheckIsEndPet(petPstID)
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  local shareDataSvc = mainWorld:GetService("UtilData")
  return shareDataSvc:IsFourthOrEightPetInTeamOrder(petPstID)
end

function InnerGameHelperRender.UISetUIPetAccumulateNum(petPstID, num)
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  local svc = mainWorld:GetService("AutoTest")
  if svc then
    svc:WriteBlackBoard_Test("UIPetAccNum_" .. petPstID, num)
  end
end

function InnerGameHelperRender.UISetUIPetPassiveSkillBuffLayerNum(petPstID, num)
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  local svc = mainWorld:GetService("AutoTest")
  if svc then
    svc:WriteBlackBoard_Test("UIPetBuffLayerNum_" .. petPstID, num)
  end
end

function InnerGameHelperRender.UISetHPBuffIcon(entityID, t)
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  local svc = mainWorld:GetService("AutoTest")
  if svc then
    svc:WriteBlackBoard_Test("UIHPBuff_" .. entityID, t)
  end
end

function InnerGameHelperRender.UISetHPLayerShieldCount(entityID, count)
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  local svc = mainWorld:GetService("AutoTest")
  if svc then
    svc:WriteBlackBoard_Test("UIHPLayerShieldCount_" .. entityID, count)
  end
end

function InnerGameHelperRender._FindLevelByEliteID()
  local eliteIDList = {
    100101,
    100102,
    100103,
    100401
  }
  local eliteMonsterIDList = InnerGameHelperRender._FindEliteMonsterIDList(eliteIDList)
  local refreshMonsterIDList = InnerGameHelperRender._FindRefreshMonsterIDList(eliteMonsterIDList)
  local refreshIDList = InnerGameHelperRender._FindRefreshIDList(refreshMonsterIDList)
  local waveIDList = InnerGameHelperRender._FindWaveIDList(refreshIDList)
  local levelIDList = InnerGameHelperRender._FindLevelIDList(waveIDList)
end

function InnerGameHelperRender._FindEliteMonsterIDList(eliteIDList)
  local eliteMonsterIDList = {}
  local monsterList = Cfg.cfg_monster()
  for _, monsterConfig in pairs(monsterList) do
    if monsterConfig.EliteID then
      for _, eliteID in pairs(monsterConfig.EliteID) do
        local contain = table.icontains(eliteIDList, eliteID)
        if contain then
          eliteMonsterIDList[#eliteMonsterIDList + 1] = monsterConfig.ID
          Log.fatal("eliteID:", eliteID, " FindLevel_monsterID：", monsterConfig.ID)
        end
      end
    end
  end
  return eliteMonsterIDList
end

function InnerGameHelperRender._FindRefreshMonsterIDList(eliteMonsterIDList)
  local refreshMonsterIDList = {}
  local refreshMonster = Cfg.cfg_refresh_monster()
  for _, refreshMonsterConfig in pairs(refreshMonster) do
    if refreshMonsterConfig.MonsterIDList then
      for _, monsterID in pairs(refreshMonsterConfig.MonsterIDList) do
        local contain = table.icontains(eliteMonsterIDList, monsterID)
        if contain then
          refreshMonsterIDList[#refreshMonsterIDList + 1] = refreshMonsterConfig.ID
          Log.fatal("monsterID:", monsterID, " FindLevel_refreshMonsterID：", refreshMonsterConfig.ID)
        end
      end
    end
  end
  return refreshMonsterIDList
end

function InnerGameHelperRender._FindRefreshIDList(refreshMonsterIDList)
  local refreshIDList = {}
  local refresh = Cfg.cfg_refresh()
  for _, refreshConfig in pairs(refresh) do
    if refreshConfig.MonsterRefreshIDList then
      for _, monsterRefreshID in pairs(refreshConfig.MonsterRefreshIDList) do
        local contain = table.icontains(refreshMonsterIDList, monsterRefreshID)
        if contain then
          refreshIDList[#refreshIDList + 1] = refreshConfig.ID
          Log.fatal("monsterRefreshID:", monsterRefreshID, " FindLevel_refreshMonsterID：", refreshConfig.ID)
        end
      end
    end
  end
  return refreshIDList
end

function InnerGameHelperRender._FindWaveIDList(refreshIDList)
  local waveIDList = {}
  local wave = Cfg.cfg_monster_wave()
  for _, waveConfig in pairs(wave) do
    local contain = table.icontains(refreshIDList, waveConfig.WaveBeginRefreshID)
    if contain then
      waveIDList[#waveIDList + 1] = waveConfig.ID
      Log.fatal("RefreshID:", waveConfig.WaveBeginRefreshID, " FindLevel_waveID：", waveConfig.ID)
    end
    if waveConfig.WaveInternalRefresh then
      for _, refreshConfigList in pairs(waveConfig.WaveInternalRefresh) do
        local contain = table.icontains(refreshIDList, refreshConfigList.refreshID)
        if contain then
          waveIDList[#waveIDList + 1] = waveConfig.ID
          Log.fatal("refreshID:", refreshConfigList.refreshID, " FindLevel_refreshMonsterID：", waveConfig.ID)
        end
      end
    end
  end
  return waveIDList
end

function InnerGameHelperRender._FindLevelIDList(waveIDList)
  local levelIDList = {}
  local levelDic = {}
  local level = Cfg.cfg_level()
  for _, levelConfig in pairs(level) do
    if levelConfig.MonsterWave then
      for _, waveCfgID in pairs(levelConfig.MonsterWave) do
        local contain = table.icontains(waveIDList, waveCfgID)
        if contain then
          levelDic[levelConfig.ID] = true
        end
      end
    end
  end
  for levelID, v in pairs(levelDic) do
    levelIDList[#levelIDList + 1] = levelID
    Log.fatal(" FindLevel_levelConfigID ", levelID)
  end
  return levelIDList
end

function InnerGameHelperRender:IsTrapCovered(trapID, petPstId)
  local world = InnerGameHelperRender.GetMainWorld()
  local trapServiceLogic = world:GetService("TrapLogic")
  if not trapServiceLogic then
    return false
  end
  local isOverlap = trapServiceLogic:IsTrapCovered(trapID, petPstId)
  return isOverlap
end

function InnerGameHelperRender.IsDoneCompleteCondition(...)
  local world = InnerGameHelperRender.GetMainWorld()
  local lsvcComplete = world:GetService("CompleteCondition")
  return lsvcComplete:IsDoneCompleteCondition(...)
end

function InnerGameHelperRender.IsPetSilence(petPstID)
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  local shareDataSvc = mainWorld:GetService("UtilData")
  return shareDataSvc:IsSilenceState(petPstID)
end

function InnerGameHelperRender.IsPuzzleState()
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  local shareDataSvc = mainWorld:GetService("UtilData")
  return shareDataSvc:IsPuzzleState()
end

function InnerGameHelperRender.GetEntityAttribute(entityID, attribute)
  local world = InnerGameHelperRender.GetMainWorld()
  local e = world:GetEntityByID(entityID)
  if not e then
    return
  end
  local attributesComponent = e:Attributes()
  return attributesComponent:GetAttribute(attribute)
end

function InnerGameHelperRender.UICurrentTeamOrderRequestFinished()
  local renderStat = InnerGameHelperRender.GetMainWorld():RenderBattleStat()
  renderStat:MarkCurrentTeamOrderRequestFinished()
  local renderBattleService = GameGlobal:GetInstance():GetMainWorld():GetService("RenderBattle")
  renderBattleService:TryPopNextChangeTeamOrderView()
end

function InnerGameHelperRender.GetLocalMatchPetByTemplateID(tid)
  local utilData = InnerGameHelperRender.GetMainWorld():GetService("UtilData")
  return utilData:GetLocalMatchPetByTemplateID(tid)
end

function InnerGameHelperRender.IsTrapSummonCountLimit(trapEntityID)
  local world = InnerGameHelperRender.GetMainWorld()
  local trapLogic = world:GetService("TrapLogic")
  local e = world:GetEntityByID(trapEntityID)
  local ret = trapLogic:IsSummonCountLimit(e)
  return ret
end

function InnerGameHelperRender.GetPopStarStageInfo()
  local world = InnerGameHelperRender.GetMainWorld()
  local popStarSvc = world:GetService("PopStarLogic")
  return popStarSvc:GetPopStarStageInfo()
end

function InnerGameHelperRender.GetPopStarCurScore()
  local world = InnerGameHelperRender.GetMainWorld()
  local popStarSvc = world:GetService("PopStarLogic")
  return popStarSvc:GetPopGridNum()
end

function InnerGameHelperRender.GetPopStarStageBuffIDList()
  local world = InnerGameHelperRender.GetMainWorld()
  local buffSvc = world:GetService("BuffLogic")
  return buffSvc:GetPopStarStageBuffIDList()
end

function InnerGameHelperRender.GetPopStarRankEffUIWorldPos()
  local world = InnerGameHelperRender.GetMainWorld()
  local pieceSvc = world:GetService("Piece")
  local pieceEntity = pieceSvc:FindPieceEntity(Vector2(5, 5))
  local worldPos = pieceEntity:View():GetGameObject().transform.position
  local popStarRSvc = world:GetService("PopStarRender")
  local ret = popStarRSvc:CalcUIWorldPos(worldPos + Vector3(0, 0.5, 0))
  return ret
end

function InnerGameHelperRender.UIGetCurGlobalUnscaledCoundDownTime()
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  if mainWorld then
    local shareDataSvc = mainWorld:GetService("UtilData")
    return shareDataSvc:GetCurGlobalUnscaledCoundDownTime()
  end
  return 0
end

function InnerGameHelperRender.GetDamageStatisticsInfo()
  local world = InnerGameHelperRender.GetMainWorld()
  if not world then
    return
  end
  local battleDamageStatisticsServiceLogic = world:GetService("BattleDamageStatisticsLogic")
  local damageStatisticsInfo = battleDamageStatisticsServiceLogic:GetDamageStatisticsInfo()
  return damageStatisticsInfo
end

function InnerGameHelperRender.GetMonsterHPMaxStatistics()
  local world = InnerGameHelperRender.GetMainWorld()
  if not world then
    return
  end
  local battleDamageStatisticsServiceLogic = world:GetService("BattleDamageStatisticsLogic")
  local monsterHPMaxStatistics = battleDamageStatisticsServiceLogic:GetMonsterHPMaxStatistics()
  return monsterHPMaxStatistics
end

function InnerGameHelperRender.GetMonsterKilledCount()
  local world = InnerGameHelperRender.GetMainWorld()
  if not world then
    return
  end
  local battleStatCmpt = world:BattleStat()
  local monsterKilledCount = battleStatCmpt:GetMonsterKilledCount()
  return monsterKilledCount
end

function InnerGameHelperRender.GetMonsterKilledCountByMonsterID(monsterID)
  local world = InnerGameHelperRender.GetMainWorld()
  if not world then
    return
  end
  local battleStatCmpt = world:BattleStat()
  local monsterKilledCount = battleStatCmpt:GetMonsterKilledCountByMonsterID(monsterID)
  return monsterKilledCount
end

function InnerGameHelperRender.SetGlobalOutLine(state)
  local world = InnerGameHelperRender.GetMainWorld()
  if not world then
    return
  end
  world:GetService("RenderBattle"):SetGlobalOutLine(state)
end

function InnerGameHelperRender.IsPetHasBeCastExtraChainFlag(petPstID)
  local world = InnerGameHelperRender.GetMainWorld()
  if not world then
    return
  end
  return world:GetService("UtilData"):IsHasExtraChainFlag(petPstID)
end

function InnerGameHelperRender.CanCastByExtraPower(skillConfigData)
  local canCast = true
  if skillConfigData then
    local triggerExtraParam = skillConfigData:GetSkillTriggerExtraParam()
    if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.CostFeatureStepPoint] then
      local paramStepPoint = triggerExtraParam[SkillTriggerTypeExtraParam.CostFeatureStepPoint]
      if paramStepPoint then
        local curStepPoint = FeatureServiceHelper.GetCurStepPoint()
        if paramStepPoint <= curStepPoint then
        else
          canCast = false
        end
      end
    end
  end
  return canCast
end

function InnerGameHelperRender.GetFeatureSkillCurPower(featureType)
  return FeatureServiceHelper.GetFeatureSkillCurPower(featureType)
end

function InnerGameHelperRender.GetRelicCounter(relicID)
  local world = InnerGameHelperRender.GetMainWorld()
  local popStarProSvc = world:GetService("PopStarProLogic")
  return popStarProSvc:GetRelicCounter(relicID)
end

function InnerGameHelperRender.GetLocalMatchPets()
  local world = InnerGameHelperRender.GetMainWorld()
  if not world then
    return
  end
  return world:BattleWorldEnterData():GetLocalMatchPets()
end

function InnerGameHelperRender.GetRemoteMatchPets()
  local world = InnerGameHelperRender.GetMainWorld()
  if not world then
    return
  end
  return world:BattleWorldEnterData():GetRemoteMatchPets()
end

function InnerGameHelperRender.GetFeatureAUActiveRelics()
  return FeatureServiceHelper.GetFeatureAUActiveRelics()
end

function InnerGameHelperRender.GetFeatureAUOverloadEnergyInfo()
  return FeatureServiceHelper.GetFeatureAUOverloadEnergyInfo()
end

function InnerGameHelperRender.InnerGamePlayPetVoid(audioID, casterEntity)
  local world = InnerGameHelperRender.GetMainWorld()
  if not world then
    return
  end
  if not casterEntity:HasPetPstID() then
    return
  end
  local buffLogicSvc = world:GetService("BuffLogic")
  local replaceVoiceID = buffLogicSvc:GetReplacePetVoiceID()
  replaceVoiceID = replaceVoiceID or audioID
  AudioHelperController.PlayInnerGameVoiceByAudioId(replaceVoiceID)
end

function InnerGameHelperRender.InnerGamePlayPetUIVoice(filed, petResId, notRand, bLoginVoice, voiceSkinID, click)
  local world = InnerGameHelperRender.GetMainWorld()
  if not world then
    return
  end
  local buffLogicSvc = world:GetService("BuffLogic")
  local replaceVoiceID = buffLogicSvc:GetReplacePetVoiceID()
  local pm = GameGlobal.GetModule(PetAudioModule)
  pm:PlayPetAudio(filed, petResId, notRand, bLoginVoice, voiceSkinID, click, replaceVoiceID)
end

function InnerGameHelperRender.GetCurAutoBeadPowerInfo()
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  local shareDataSvc = mainWorld:GetService("UtilData")
  return shareDataSvc:GetCurAutoBeadPowerInfo()
end

function InnerGameHelperRender.GetAutoBeadList()
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  local shareDataSvc = mainWorld:GetService("UtilData")
  return shareDataSvc:GetAutoBeadList()
end

function InnerGameHelperRender.GetHPShieldType(entityID)
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  if mainWorld then
    local buffSvc = mainWorld:GetService("BuffLogic")
    return buffSvc:GetEntityHPShieldType(entityID)
  end
end

function InnerGameHelperRender.GetFeatureTetrisInfo()
  return FeatureServiceHelper.GetFeatureTetrisInfo()
end

function InnerGameHelperRender.GetFeatureAlchemyLevelMax()
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  if mainWorld then
    local boardEntity = mainWorld:GetBoardEntity()
    local logicFeatureCmpt = boardEntity:LogicFeature()
    local alchemyLevelMax = logicFeatureCmpt:GetAlchemyLevelMax()
    return alchemyLevelMax
  end
end

function InnerGameHelperRender.IsPet1702361ActiveSkillPreview()
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  local shareDataSvc = mainWorld:GetService("UtilData")
  return shareDataSvc:IsPet1702361ActiveSkillPreview()
end
