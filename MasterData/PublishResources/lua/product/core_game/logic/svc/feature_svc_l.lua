require("battle_ui_active_skill_cannot_cast_reason")
_class("FeatureServiceLogic", BaseService)
FeatureServiceLogic = FeatureServiceLogic

function FeatureServiceLogic:CanEnableFeature()
  if self._world:MatchType() == MatchType.MT_Chess then
    return false
  end
  return true
end

function FeatureServiceLogic:DoInitFeatureList()
  local logicFeatureCmpt = self:GetLogicCmpt()
  local featureCfgDataDic = self:_FindFeatureListCfgDataDic()
  local featureDataList = self._configService:ParseCustomFeatureList(featureCfgDataDic)
  local featureCount = #featureDataList
  Log.info("DoInitFeatureList,count:", featureCount)
  for index, featureParam in ipairs(featureDataList) do
    Log.info("DoInitFeatureList,featureType:", featureParam:GetFeatureType())
    logicFeatureCmpt:AddFeatureData(featureParam:GetFeatureType(), featureParam)
  end
  self:_HandleInitFeatureList()
end

function FeatureServiceLogic:OnPartnerPetJoinCheckFeature(partnerPetEntity)
  local logicFeatureCmpt = self:GetLogicCmpt()
  local petFeatureCfgDataDic = self:_FindFeatureListCfgDataDicOnPet(partnerPetEntity)
  local featureCfgDataDic = {}
  for featureType, cfgData in pairs(petFeatureCfgDataDic) do
    if not self:HasFeatureType(featureType) then
      featureCfgDataDic[featureType] = cfgData
    end
  end
  local featureDataList = self._configService:ParseCustomFeatureList(featureCfgDataDic)
  local featureCount = #featureDataList
  Log.info("OnPartnerPetJoinCheckFeature,count:", featureCount)
  for index, featureParam in ipairs(featureDataList) do
    Log.info("OnPartnerPetJoinCheckFeature,featureType:", featureParam:GetFeatureType())
    logicFeatureCmpt:AddFeatureData(featureParam:GetFeatureType(), featureParam)
    self:_HandleInitFeature(featureParam:GetFeatureType(), featureParam)
  end
end

function FeatureServiceLogic:OnBuffAddFeature(cfgFeatureList)
  local findFeatureDic = {}
  local logicFeatureCmpt = self:GetLogicCmpt()
  if cfgFeatureList then
    local buffFeatures = cfgFeatureList.feature
    if buffFeatures then
      for featureType, featureData in pairs(buffFeatures) do
        if not findFeatureDic[featureType] then
          findFeatureDic[featureType] = featureData
        end
      end
    end
  end
  local finalFeatureDic = {}
  for featureType, featureData in pairs(findFeatureDic) do
    finalFeatureDic[featureType] = featureData
  end
  for k, v in pairs(finalFeatureDic) do
    finalFeatureDic[k] = table.cloneconf(v)
  end
  local buffFeatureCfgDataDic = finalFeatureDic
  local featureCfgDataDic = {}
  for featureType, cfgData in pairs(buffFeatureCfgDataDic) do
    if not self:HasFeatureType(featureType) then
      featureCfgDataDic[featureType] = cfgData
    end
  end
  local featureDataList = self._configService:ParseCustomFeatureList(featureCfgDataDic)
  local featureCount = #featureDataList
  Log.info("OnBuffAddFeature,count:", featureCount)
  for index, featureParam in ipairs(featureDataList) do
    Log.info("OnBuffAddFeature,featureType:", featureParam:GetFeatureType())
    logicFeatureCmpt:AddFeatureData(featureParam:GetFeatureType(), featureParam)
    self:_HandleInitFeature(featureParam:GetFeatureType(), featureParam)
  end
end

function FeatureServiceLogic:_FindFeatureListCfgDataDic()
  local finalForceParamList = {}
  local finalFeatureDic = {}
  local levelConfigData = self._configService:GetLevelConfigData()
  local levelFeatureList = levelConfigData:GetFeatureList()
  if levelFeatureList then
    local levelFeatures = levelFeatureList.feature
    if levelFeatures then
      for featureType, featureData in pairs(levelFeatures) do
        finalFeatureDic[featureType] = featureData
      end
    end
    if levelFeatureList.forceParam then
      local forceParamDic = {}
      for featureType, forceData in pairs(levelFeatureList.forceParam) do
        forceParamDic[featureType] = forceData
      end
      table.insert(finalForceParamList, forceParamDic)
    end
  end
  local petsFeatureDic = {}
  local petsForceParamList = {}
  local petSkinsForceParamList = {}
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamCmpt = teamEntity:Team()
  local teamOrder = teamCmpt:GetTeamOrder()
  for order, petPstID in ipairs(teamOrder) do
    local petEntity = teamCmpt:GetPetEntityByPetPstID(petPstID)
    local matchPet = petEntity:MatchPet():GetMatchPet()
    local petFeatureList = matchPet:GetFeatureList()
    if petFeatureList then
      local petFeatures = petFeatureList.feature
      if petFeatures then
        for featureType, featureData in pairs(petFeatures) do
          if not petsFeatureDic[featureType] then
            petsFeatureDic[featureType] = featureData
          end
        end
      end
      if petFeatureList.forceParam then
        local forceParamDic = {}
        for featureType, forceData in pairs(petFeatureList.forceParam) do
          forceParamDic[featureType] = forceData
        end
        table.insert(petsForceParamList, 1, forceParamDic)
      end
      local skinId = matchPet:GetSkinId()
      local skinCfg = Cfg.cfg_pet_skin[skinId]
      if skinCfg then
        local customParamCfg = skinCfg.InnerCustomParam
        if customParamCfg and customParamCfg.featureCustomParam then
          local featureCustomParamCfg = customParamCfg.featureCustomParam
          local forceParamDic = {}
          for featureType, forceData in pairs(featureCustomParamCfg) do
            forceParamDic[featureType] = forceData
          end
          table.insert(petSkinsForceParamList, 1, forceParamDic)
        end
      end
    end
    local equipRefineFeatureList = matchPet:GetEquipRefineFeatureList()
    if equipRefineFeatureList then
      local petFeatures = equipRefineFeatureList.feature
      if petFeatures then
        for featureType, featureData in pairs(petFeatures) do
          if not petsFeatureDic[featureType] then
            petsFeatureDic[featureType] = featureData
          end
        end
      end
      if equipRefineFeatureList.forceParam then
        local forceParamDic = {}
        for featureType, forceData in pairs(equipRefineFeatureList.forceParam) do
          forceParamDic[featureType] = forceData
        end
        table.insert(petsForceParamList, 1, forceParamDic)
      end
    end
  end
  for featureType, featureData in pairs(petsFeatureDic) do
    finalFeatureDic[featureType] = featureData
  end
  for _, petForceParamDic in ipairs(petsForceParamList) do
    table.insert(finalForceParamList, petForceParamDic)
  end
  for _, petSkinForceParamDic in ipairs(petSkinsForceParamList) do
    table.insert(finalForceParamList, petSkinForceParamDic)
  end
  for k, v in pairs(finalFeatureDic) do
    finalFeatureDic[k] = table.cloneconf(v)
  end
  for _, forceParamDic in ipairs(finalForceParamList) do
    for featureType, forceData in pairs(forceParamDic) do
      if finalFeatureDic[featureType] then
        for key, value in pairs(forceData) do
          finalFeatureDic[featureType][key] = value
        end
      end
    end
  end
  local talentSvc = self._world:GetService("Talent")
  talentSvc:ChangeFeature(finalFeatureDic)
  local initBead = false
  if self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) == MatchType.MT_SeasonMaze then
    local createInfo = self._world.BW_WorldInfo:GetSeasonMazeCreateInfo()
    if createInfo then
      local autoBeadList = createInfo.autobead_list
      if 0 < #autoBeadList then
        initBead = true
      end
    end
  end
  if initBead then
    finalFeatureDic[FeatureType.AutoBeadPowerInfo] = {}
  end
  return finalFeatureDic
end

function FeatureServiceLogic:_FindFeatureListCfgDataDicOnPet(petEntity)
  local finalFeatureDic = {}
  local petsFeatureDic = {}
  local matchPet = petEntity:MatchPet():GetMatchPet()
  local petFeatureList = matchPet:GetFeatureList()
  if petFeatureList then
    local petFeatures = petFeatureList.feature
    if petFeatures then
      for featureType, featureData in pairs(petFeatures) do
        if not petsFeatureDic[featureType] then
          petsFeatureDic[featureType] = featureData
        end
      end
    end
  end
  for featureType, featureData in pairs(petsFeatureDic) do
    finalFeatureDic[featureType] = featureData
  end
  for k, v in pairs(finalFeatureDic) do
    finalFeatureDic[k] = table.cloneconf(v)
  end
  return finalFeatureDic
end

function FeatureServiceLogic:GetLogicCmpt()
  local boardEntity = self._world:GetBoardEntity()
  local logicFeatureCmpt = boardEntity:LogicFeature()
  return logicFeatureCmpt
end

function FeatureServiceLogic:_HandleInitFeatureList()
  local logicFeatureCmpt = self:GetLogicCmpt()
  local featureTypeList = logicFeatureCmpt:GetFeatureTypeList()
  for i, featureType in ipairs(featureTypeList) do
    local featureData = logicFeatureCmpt:GetFeatureData(featureType)
    if featureData then
      self:_HandleInitFeature(featureType, featureData)
    end
  end
end

function FeatureServiceLogic:_HandleInitFeature(featureType, featureData)
  if featureType == FeatureType.Sanity then
    self:_HandleInitFeature_Sanity(featureType, featureData)
  elseif featureType == FeatureType.DayNight then
    self:_HandleInitFeature_DayNight(featureType, featureData)
  elseif featureType == FeatureType.PersonaSkill then
    self:_HandleInitFeature_PersonaSkill(featureType, featureData)
  elseif featureType == FeatureType.Card then
    self:_HandleInitFeature_Card(featureType, featureData)
  elseif featureType == FeatureType.MasterSkill or featureType == FeatureType.MasterSkillRecover or featureType == FeatureType.MasterSkillTeleport or self:IsTalentSkillFeature(featureType) then
    self:_HandleInitFeature_MasterSkill(featureType, featureData)
  elseif featureType == FeatureType.Scan then
    self:_HandleInitFeature_Scan(featureData)
  elseif featureType == FeatureType.TrapCount then
    self:_HandleInitFeature_TrapCount(featureType, featureData)
  elseif self:IsPopStarSkillFeature(featureType) then
    self:_HandleInitFeature_PopStar(featureType, featureData)
  elseif featureType == FeatureType.TrapDefence then
    self:_HandleInitFeature_TrapDefence(featureType, featureData)
  elseif featureType == FeatureType.Shop then
    self:_HandleInitFeature_Shop(featureType, featureData)
  elseif featureType == FeatureType.StepPoint then
    self:_HandleInitFeature_StepPoint(featureType, featureData)
  elseif featureType == FeatureType.BanPetSkill then
    self:_HandleInitFeature_BanPetSkill(featureType, featureData)
  elseif featureType == FeatureType.AlgorithmUpgrade then
    self:_HandleInitFeature_AlgorithmUpgrade(featureData)
  elseif featureType == FeatureType.AutoBeadPowerInfo then
    self:_HandleInitFeature_AutoBeadPowerInfo(featureType, featureData)
  elseif featureType == FeatureType.TetrisGame then
    self:_HandleInitFeature_TetrisGame(featureType, featureData)
  end
end

function FeatureServiceLogic:IsPopStarSkillFeature(featureType)
  if featureType == FeatureType.PopStar or featureType == FeatureType.PopStar1 or featureType == FeatureType.PopStar2 or featureType == FeatureType.PopStar3 or featureType == FeatureType.PopStar4 or featureType == FeatureType.PopStar5 or featureType == FeatureType.PopStar6 or featureType == FeatureType.PopStar7 or featureType == FeatureType.PopStar8 or featureType == FeatureType.PopStar9 or featureType == FeatureType.PopStar10 then
    return true
  end
  return false
end

function FeatureServiceLogic:IsTalentSkillFeature(featureType)
  if featureType == FeatureType.TalentSkill1 or featureType == FeatureType.TalentSkill2 or featureType == FeatureType.TalentSkill3 or featureType == FeatureType.TalentSkill4 or featureType == FeatureType.TalentSkill5 then
    return true
  end
  return false
end

function FeatureServiceLogic:HasFeatureType(featureType)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local featureData = logicFeatureCmpt:GetFeatureData(featureType)
    if featureData then
      return true
    end
  end
  return false
end

function FeatureServiceLogic:GetFeatureData(featureType)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local featureData = logicFeatureCmpt:GetFeatureData(featureType)
    return featureData
  end
end

function FeatureServiceLogic:GetFeatureTypeList()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local featureTypeList = logicFeatureCmpt:GetFeatureTypeList()
    return featureTypeList
  end
end

function FeatureServiceLogic:DoFeatureOnRoundEnter(incRound)
  self:_CheckFeatureSanOnRoundEnter()
  self:_CheckFeatureDayNightOnRoundEnter()
  local skillFeatureTypes = {
    FeatureType.PersonaSkill,
    FeatureType.MasterSkill,
    FeatureType.MasterSkillRecover,
    FeatureType.MasterSkillTeleport,
    FeatureType.TrapDefence,
    FeatureType.TalentSkill1,
    FeatureType.TalentSkill2,
    FeatureType.TalentSkill3,
    FeatureType.TalentSkill4,
    FeatureType.TalentSkill5
  }
  for index, featureType in ipairs(skillFeatureTypes) do
    self:_CheckFeatureSkillOnRoundEnter(featureType, incRound)
  end
end

function FeatureServiceLogic:DoFeatureOnRoundEnterEarly(incRound)
  self:_CheckFeatureStepPointOnRoundEnterEarly(incRound)
end

function FeatureServiceLogic:_HandleInitFeature_Sanity(featureType, featureData)
  local param = featureData
  local boardEntity = self._world:GetBoardEntity()
  local boardAttr = boardEntity:Attributes()
  if boardAttr then
    local enterValue = param:GetEnterSanValue()
    boardAttr:Modify("San", enterValue)
    local maxValue = param:GetMaxSanValue()
    boardAttr:Modify("SanMax", maxValue)
    Log.info("_HandleInitFeature_Sanity,enterValue:", enterValue)
    local sanityParam = param:GetSanityParam()
    local words = sanityParam.wordList
    local gameStartBuffs = {}
    self:_SanityInitWords(words, gameStartBuffs)
  end
end

function FeatureServiceLogic:_CheckFeatureSanOnRoundEnter()
  local battleStatCmpt = self._world:BattleStat()
  if not battleStatCmpt:IsFirstRound() then
    local sanData = self:GetFeatureData(FeatureType.Sanity)
    if sanData then
      local delVal = sanData:GetRoundDelValue()
      if delVal then
        local curVal, oldVal, realModifyValue, debtVal, modifyTimes = self:DecreaseSanValue(delVal)
        self._world:GetService("Trigger"):Notify(NTSanValueChange:New(curVal, oldVal, debtVal, modifyTimes))
        local l2rSvc = self._world:GetService("L2R")
        l2rSvc:L2RSanRoundDecrease(curVal, oldVal, realModifyValue, debtVal, modifyTimes)
      end
    end
  else
    local sanData = self:GetFeatureData(FeatureType.Sanity)
    if sanData then
      local curSan = self:GetSanValue()
      local debtVal = 0
      local modifyTimes = 0
      self._world:GetService("Trigger"):Notify(NTSanValueChange:New(curSan, curSan, debtVal, modifyTimes))
      local l2rSvc = self._world:GetService("L2R")
      l2rSvc:L2RSanRoundDecrease(curSan, curSan, 0, debtVal, modifyTimes)
    end
  end
end

function FeatureServiceLogic:_SanityInitWords(words, gameStartBuffs)
  if words == nil or #words == 0 then
    return
  end
  local buffLogic = self._world:GetService("BuffLogic")
  for _, wordID in ipairs(words) do
    local cfg = Cfg.cfg_word_buff[wordID]
    if cfg == nil then
      Log.fatal("word not found: ", wordID)
      return
    end
    for _, id in ipairs(cfg.BuffID) do
      Log.notice("[Sanity] 初始化词缀，", wordID, "挂buff: ", id)
      local ret = buffLogic:AddBuffByTargetType(id, cfg.BuffTargetType, cfg.BuffTargetParam)
      for _, inst in ipairs(ret) do
        gameStartBuffs[#gameStartBuffs + 1] = {
          inst:Entity(),
          inst:BuffSeq()
        }
      end
    end
  end
end

function FeatureServiceLogic:SetSanValue(sanValue)
  local finalSan = sanValue
  local maxSan = self:GetSanMaxValue()
  local minSan = self:GetSanMinValue()
  if finalSan > maxSan then
    finalSan = maxSan
  end
  if minSan > finalSan then
    finalSan = minSan
  end
  local boardEntity = self._world:GetBoardEntity()
  local boardAttr = boardEntity:Attributes()
  if boardAttr then
    boardAttr:Modify("San", finalSan)
    Log.info("SetSanValue,sanValue:", finalSan)
  end
end

function FeatureServiceLogic:_RecordModifySanTimes()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:RecordModifySanTimes()
  end
end

function FeatureServiceLogic:ModifySanValue(modifyValue)
  if 0 <= modifyValue then
    return self:IncreaseSanValue(modifyValue)
  else
    return self:DecreaseSanValue(-modifyValue)
  end
end

function FeatureServiceLogic:IncreaseSanValue(increaseValue)
  local oldSan = self:GetSanValue()
  local maxSan = self:GetSanMaxValue()
  local minSan = self:GetSanMinValue()
  local realModifyValue = increaseValue
  local finalSan = oldSan + increaseValue
  if maxSan < finalSan then
    finalSan = maxSan
  end
  if minSan > finalSan then
    finalSan = minSan
  end
  realModifyValue = finalSan - oldSan
  self:SetSanValue(finalSan)
  local debtVal = 0
  local modifyTimes = self:_RecordModifySanTimes()
  return finalSan, oldSan, realModifyValue, debtVal, modifyTimes
end

function FeatureServiceLogic:DecreaseSanValue(decreaseValue)
  local oldSan = self:GetSanValue()
  local minSan = self:GetSanMinValue()
  local realModifyValue = decreaseValue
  local finalSan = oldSan - decreaseValue
  local debtVal = 0
  if minSan > finalSan then
    debtVal = minSan - finalSan
    finalSan = minSan
  end
  realModifyValue = finalSan - oldSan
  self:SetSanValue(finalSan)
  local modifyTimes = self:_RecordModifySanTimes()
  return finalSan, oldSan, realModifyValue, debtVal, modifyTimes
end

function FeatureServiceLogic:GetSanValue()
  local boardEntity = self._world:GetBoardEntity()
  local boardAttr = boardEntity:Attributes()
  if boardAttr then
    local sanValue = boardAttr:GetAttribute("San")
    return sanValue
  end
end

function FeatureServiceLogic:GetSanMaxValue()
  local boardEntity = self._world:GetBoardEntity()
  local boardAttr = boardEntity:Attributes()
  if boardAttr then
    local maxSanValue = boardAttr:GetAttribute("SanMax")
    return maxSanValue
  end
  return 100
end

function FeatureServiceLogic:SetSanMaxValue(value)
  local boardEntity = self._world:GetBoardEntity()
  local boardAttr = boardEntity:Attributes()
  if boardAttr then
    boardAttr:Modify("SanMax", value)
    Log.info("SetSanMaxValue,SanMaxValue:", value)
  end
end

function FeatureServiceLogic:GetSanMinValue()
  local featureData = self:GetFeatureData(FeatureType.Sanity)
  if featureData then
    local minVal = featureData:GetMinSanValue()
    return minVal
  end
  return 0
end

function FeatureServiceLogic:CalcActiveSkillSanCost(casterEntity, skillID, context)
  local triggerParamTypeBool = {}
  local cfgsvc = self._world:GetService("Config")
  local skillcfg = cfgsvc:GetSkillConfigData(skillID)
  local logicSanVal = self:GetSanValue()
  local requireVal = 0
  local requireHPVal = 0
  local hpConvertVal = 0
  local triggerExtraParam = skillcfg:GetSkillTriggerExtraParam()
  if not triggerExtraParam then
    return requireVal, requireHPVal
  end
  if triggerExtraParam[SkillTriggerTypeExtraParam.SanValue] then
    triggerParamTypeBool[SkillTriggerTypeExtraParam.SanValue] = true
    requireVal = triggerExtraParam[SkillTriggerTypeExtraParam.SanValue]
    if logicSanVal < requireVal and triggerExtraParam[SkillTriggerTypeExtraParam.DecreaseHPPercentAsSan] then
      triggerParamTypeBool[SkillTriggerTypeExtraParam.DecreaseHPPercentAsSan] = true
      local rate = triggerExtraParam[SkillTriggerTypeExtraParam.DecreaseHPPercentAsSan]
      hpConvertVal = requireVal - logicSanVal
      requireHPVal = hpConvertVal / rate * 0.01
      requireVal = logicSanVal
    end
  end
  if triggerExtraParam[SkillTriggerTypeExtraParam.SanByScopeGridCounts] then
    triggerParamTypeBool[SkillTriggerTypeExtraParam.SanByScopeGridCounts] = true
    local valPerGrid = triggerExtraParam[SkillTriggerTypeExtraParam.SanByScopeGridCounts]
    local scopeGridCount = context.scopeGridCount or 0
    requireVal = scopeGridCount * valPerGrid
    if logicSanVal < requireVal and triggerExtraParam[SkillTriggerTypeExtraParam.DecreaseHPPercentAsSan] then
      triggerParamTypeBool[SkillTriggerTypeExtraParam.DecreaseHPPercentAsSan] = true
      local rate = triggerExtraParam[SkillTriggerTypeExtraParam.DecreaseHPPercentAsSan]
      hpConvertVal = requireVal - logicSanVal
      requireHPVal = hpConvertVal / rate * 0.01
      requireVal = logicSanVal
    end
  end
  if triggerExtraParam[SkillTriggerTypeExtraParam.SanChangeByRoundCastTimes] then
    triggerParamTypeBool[SkillTriggerTypeExtraParam.SanChangeByRoundCastTimes] = true
    local baseVal = triggerExtraParam[SkillTriggerTypeExtraParam.SanValue]
    local modVal = triggerExtraParam[SkillTriggerTypeExtraParam.SanChangeByRoundCastTimes]
    local battleStatCmpt = self._world:BattleStat()
    local pstid = 0
    if casterEntity and casterEntity:PetPstID() then
      pstid = casterEntity:PetPstID():GetPstID()
    end
    local curRoundCastTimes = 0
    if 0 < pstid then
      curRoundCastTimes = battleStatCmpt:GetCurRoundDoActiveSkillTimes(pstid)
    end
    requireVal = baseVal + modVal * curRoundCastTimes
    if logicSanVal < requireVal and triggerExtraParam[SkillTriggerTypeExtraParam.DecreaseHPPercentAsSan] then
      triggerParamTypeBool[SkillTriggerTypeExtraParam.DecreaseHPPercentAsSan] = true
      local rate = triggerExtraParam[SkillTriggerTypeExtraParam.DecreaseHPPercentAsSan]
      hpConvertVal = requireVal - logicSanVal
      requireHPVal = hpConvertVal / rate * 0.01
      requireVal = logicSanVal
    end
  end
  if triggerExtraParam[SkillTriggerTypeExtraParam.SanMinLimit] then
    triggerParamTypeBool[SkillTriggerTypeExtraParam.SanMinLimit] = true
    requireVal = triggerExtraParam[SkillTriggerTypeExtraParam.SanMinLimit]
  end
  return requireVal, requireHPVal, hpConvertVal, triggerParamTypeBool
end

function FeatureServiceLogic:IsActiveSkillCanCast(casterEntity, skillID, context)
  local logicSanVal = self:GetSanValue()
  if not logicSanVal then
    return false
  end
  local requireVal, requireHPPercent, _hpConvertVal, isTriggerParamUsed = self:CalcActiveSkillSanCost(casterEntity, skillID, context)
  local result = logicSanVal >= requireVal
  if not result then
    local firstFailedReason = SkillTriggerTypeExtraParam.SanValue
    if not isTriggerParamUsed[SkillTriggerTypeExtraParam.SanValue] and isTriggerParamUsed[SkillTriggerTypeExtraParam.SanByScopeGridCounts] then
      firstFailedReason = BattleUIActiveSkillCannotCastReason.SanByScopeGridCounts
    end
    return result, firstFailedReason
  end
  if 0 < requireHPPercent then
    local utilData = self._world:GetService("UtilData")
    local hp = utilData:GetCurrentLogicHP(casterEntity)
    local maxhp = utilData:GetCurrentLogicMaxHP(casterEntity)
    local requireHPVal = maxhp * requireHPPercent
    result = result and hp > requireHPVal
    if not result then
      return result, BattleUIActiveSkillCannotCastReason.DecreaseHPPercentAsSan
    end
  end
  local cfgsvc = self._world:GetService("Config")
  local skillcfg = cfgsvc:GetSkillConfigData(skillID)
  local triggerExtraParam = skillcfg:GetSkillTriggerExtraParam()
  if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.SanNotFull] then
    local logicMaxSan = self:GetSanMaxValue()
    result = result and logicMaxSan > logicSanVal - requireVal
    if not result then
      return result, BattleUIActiveSkillCannotCastReason.SanNotFull
    end
  end
  if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.CardNotFull] then
    result = result and self:CanAddCard()
    if not result then
      return result, BattleUIActiveSkillCannotCastReason.CardNotFull
    end
  end
  if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.SanMaxLimit] then
    local logicMaxSan = self:GetSanMaxValue()
    local limit = tonumber(triggerExtraParam[SkillTriggerTypeExtraParam.SanMaxLimit])
    result = result and logicMaxSan > limit
    if not result then
      return result, BattleUIActiveSkillCannotCastReason.SanMaxLimit
    end
  end
  if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.SanMinLimit] then
    local limit = tonumber(triggerExtraParam[SkillTriggerTypeExtraParam.SanMinLimit])
    result = result and logicSanVal > limit
    if not result then
      return result, BattleUIActiveSkillCannotCastReason.SanMinLimit
    end
  end
  return result
end

function FeatureServiceLogic:_HandleInitFeature_DayNight(featureType, featureData)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local enterState = featureData:GetEnterState()
    logicFeatureCmpt:SetDayNightData(FeatureDayNightState.Day, featureData:GetLastRound(FeatureDayNightState.Day))
  end
end

function FeatureServiceLogic:_CheckFeatureDayNightOnRoundEnter()
  local battleStatCmpt = self._world:BattleStat()
  local featureData = self:GetFeatureData(FeatureType.DayNight)
  if featureData then
    local logicFeatureCmpt = self:GetLogicCmpt()
    if logicFeatureCmpt then
      local ignoreFirstRoundCheck = logicFeatureCmpt:GetDayNightIgnoreFirstRoundCheck()
      if ignoreFirstRoundCheck or not battleStatCmpt:IsFirstRound() then
        local curState, oldState, restRound = self:_DecreaseDayNightRound(1)
        if curState ~= oldState then
          self._world:GetService("Trigger"):Notify(NTDayNightStateChange:New(curState, oldState))
        end
        local l2rSvc = self._world:GetService("L2R")
        l2rSvc:L2RDayNightRoundChange(curState, oldState, restRound)
      else
        local enterState = featureData:GetEnterState()
        local oldState, oldRestRound = logicFeatureCmpt:GetDayNightData()
        if enterState ~= oldState then
          local curState = enterState
          local restRound = featureData:GetLastRound(curState)
          logicFeatureCmpt:SetDayNightData(curState, restRound)
          self._world:GetService("Trigger"):Notify(NTDayNightStateChange:New(curState, oldState))
          local l2rSvc = self._world:GetService("L2R")
          l2rSvc:L2RDayNightRoundChange(curState, oldState, restRound)
        end
      end
    end
  end
end

function FeatureServiceLogic:ModifyDayNightData(newState, restRound)
  local logicFeatureCmpt = self:GetLogicCmpt()
  local oldState, oldRestRound = logicFeatureCmpt:GetDayNightData()
  logicFeatureCmpt:SetDayNightData(newState, restRound)
  logicFeatureCmpt:SetDayNightIgnoreFirstRoundCheck(true)
  if newState ~= oldState then
    self._world:GetService("Trigger"):Notify(NTDayNightStateChange:New(newState, oldState))
  end
  Log.debug("Feature logic,buff modify dayNight, oldState:", oldState, " newState:", newState, " restRound:", restRound)
  return oldState, newState, restRound
end

function FeatureServiceLogic:_DecreaseDayNightRound(decRound)
  local logicFeatureCmpt = self:GetLogicCmpt()
  local oldState, oldRestRound = logicFeatureCmpt:GetDayNightData()
  local restRound = oldRestRound - decRound
  local curState = oldState
  if restRound <= 0 then
    if oldState == FeatureDayNightState.Day then
      curState = FeatureDayNightState.Night
    else
      curState = FeatureDayNightState.Day
    end
    local featureData = self:GetFeatureData(FeatureType.DayNight)
    if featureData then
      restRound = featureData:GetLastRound(curState)
    end
  end
  logicFeatureCmpt:SetDayNightData(curState, restRound)
  return curState, oldState, restRound
end

function FeatureServiceLogic:GetCurDayNightState()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local curState, restRound = logicFeatureCmpt:GetDayNightData()
    return curState
  end
end

function FeatureServiceLogic:_HandleInitFeature_PersonaSkill(featureType, featureData)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local personaSkill = featureData:GetPersonaSkillID()
    logicFeatureCmpt:SetFeatureSkillID(FeatureType.PersonaSkill, personaSkill)
    local entityService = self._world:GetService("LogicEntity")
    local skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.PersonaSkillHolder)
    if skillHolder then
      local holderID = skillHolder:GetID()
      logicFeatureCmpt:SetFeatureSkillHolderID(FeatureType.PersonaSkill, holderID)
      local attack, p5PetCount = self:_HandlePersonaPetsInfo()
      local firstElement = ElementType.ElementType_Green
      local secondElement = ElementType.ElementType_Green
      local attributeCmpt = skillHolder:Attributes()
      attributeCmpt:SetSimpleAttribute("Element", firstElement)
      attributeCmpt:Modify("Attack", attack)
      skillHolder:ReplaceElement(firstElement, secondElement)
      logicFeatureCmpt:SetPersonaPetCount(p5PetCount)
    end
    self:SetFeatureSkillCurPower(FeatureType.PersonaSkill, 0, 1)
  end
end

function FeatureServiceLogic:_HandlePersonaPetsInfo()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamCmpt = teamEntity:Team()
  local teamOrder = teamCmpt:GetTeamOrder()
  local topAttack = 1
  local personPetCount = 0
  for order, petPstID in ipairs(teamOrder) do
    local petEntity = teamCmpt:GetPetEntityByPetPstID(petPstID)
    local matchPet = petEntity:MatchPet():GetMatchPet()
    local petFeatureList = matchPet:GetFeatureList()
    if petFeatureList then
      local petFeatures = petFeatureList.feature
      if petFeatures and petFeatures[FeatureType.PersonaSkill] then
        local attack = matchPet:GetPetAttack()
        if topAttack < attack then
          topAttack = attack
        end
        personPetCount = personPetCount + 1
      end
    end
  end
  return topAttack, personPetCount
end

function FeatureServiceLogic:GetPersonaPetCount()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetPersonaPetCount()
  end
  return 1
end

function FeatureServiceLogic:_HandleInitFeature_Card(featureType, featureData)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local cardSkillDic = featureData:GetCardSkillDic()
    logicFeatureCmpt:SetCardSkillDic(cardSkillDic)
    local cardMax = featureData:GetCardMax()
    logicFeatureCmpt:SetCardMax(cardMax)
    local entityService = self._world:GetService("LogicEntity")
    local skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.PersonaSkillHolder)
    if skillHolder then
      local holderID = skillHolder:GetID()
      logicFeatureCmpt:SetFeatureSkillHolderID(FeatureType.Card, holderID)
      local firstElement = ElementType.ElementType_Green
      local secondElement = ElementType.ElementType_Green
      local attack = self:_HandleCardPetsInfo()
      local attributeCmpt = skillHolder:Attributes()
      attributeCmpt:SetSimpleAttribute("Element", firstElement)
      attributeCmpt:Modify("Attack", attack)
      skillHolder:ReplaceElement(firstElement, secondElement)
    end
    self:SetFeatureSkillCurPower(FeatureType.Card, 0, 1)
    local initCardNum = featureData:GetInitCardNum()
    if initCardNum and 0 < initCardNum then
      local needNum = initCardNum
      local initCardList = featureData:GetInitCardList()
      if initCardList then
        for _, cardType in ipairs(initCardList) do
          if cardType >= FeatureCardType.MIN and cardType <= FeatureCardType.MAX then
            needNum = needNum - 1
            if needNum < 0 then
              break
            end
            self:AddCard(cardType)
          end
        end
      end
      if 0 < needNum then
        local randomSvc = self._world:GetService("RandomLogic")
        for i = 1, needNum do
          local cardType = randomSvc:LogicRand(FeatureCardType.MIN, FeatureCardType.MAX)
          self:AddCard(cardType)
        end
      end
    end
  end
end

function FeatureServiceLogic:_HandleCardPetsInfo()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamCmpt = teamEntity:Team()
  local teamOrder = teamCmpt:GetTeamOrder()
  local topAttack = 1
  for order, petPstID in ipairs(teamOrder) do
    local petEntity = teamCmpt:GetPetEntityByPetPstID(petPstID)
    local matchPet = petEntity:MatchPet():GetMatchPet()
    local petFeatureList = matchPet:GetFeatureList()
    if petFeatureList then
      local petFeatures = petFeatureList.feature
      if petFeatures and petFeatures[FeatureType.Card] then
        local attack = matchPet:GetPetAttack()
        if topAttack < attack then
          topAttack = attack
        end
      end
    end
  end
  return topAttack
end

function FeatureServiceLogic:AddCard(cardType)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt and logicFeatureCmpt:CanAddCard() then
    logicFeatureCmpt:AddCard(cardType)
  end
end

function FeatureServiceLogic:CanAddCard()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:CanAddCard()
  end
  return false
end

function FeatureServiceLogic:GetCards()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetCards()
  end
  return {}
end

function FeatureServiceLogic:GetCurCardCount()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetCurCardCount()
  end
  return 0
end

function FeatureServiceLogic:CostCard(cardList)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:CostCard(cardList)
  end
  return {}
end

function FeatureServiceLogic:CostCardByType(compositionType)
  local cardList = self:GetCostCardListByType(compositionType)
  self:CostCard(cardList)
end

function FeatureServiceLogic:GetCostCardListByType(compositionType)
  local quickDic = {
    [FeatureCardCompositionType.ABC] = {
      1,
      2,
      3
    },
    [FeatureCardCompositionType.AAA] = {
      1,
      1,
      1
    },
    [FeatureCardCompositionType.BBB] = {
      2,
      2,
      2
    },
    [FeatureCardCompositionType.CCC] = {
      3,
      3,
      3
    },
    [FeatureCardCompositionType.AAB] = {
      1,
      1,
      2
    },
    [FeatureCardCompositionType.AAC] = {
      1,
      1,
      3
    },
    [FeatureCardCompositionType.BBA] = {
      1,
      2,
      2
    },
    [FeatureCardCompositionType.BBC] = {
      2,
      2,
      3
    },
    [FeatureCardCompositionType.CCA] = {
      1,
      3,
      3
    },
    [FeatureCardCompositionType.CCB] = {
      2,
      3,
      3
    }
  }
  return quickDic[compositionType] or {}
end

function FeatureServiceLogic:IsCardEnoughToCost(compositionType)
  local cards = self:GetCards()
  local cost = self:GetCostCardListByType(compositionType)
  local costDic = {}
  for _, cardType in ipairs(cost) do
    if costDic[cardType] then
      costDic[cardType] = costDic[cardType] + 1
    else
      costDic[cardType] = 1
    end
  end
  local enough = true
  for cardType, count in pairs(costDic) do
    if cards[cardType] and count <= cards[cardType] then
    else
      enough = false
      break
    end
  end
  return enough
end

function FeatureServiceLogic:CaclCardCompositionType(cardList)
  local quickDic = {
    [123] = FeatureCardCompositionType.ABC,
    [111] = FeatureCardCompositionType.AAA,
    [222] = FeatureCardCompositionType.BBB,
    [333] = FeatureCardCompositionType.CCC,
    [112] = FeatureCardCompositionType.AAB,
    [113] = FeatureCardCompositionType.AAC,
    [122] = FeatureCardCompositionType.BBA,
    [223] = FeatureCardCompositionType.BBC,
    [133] = FeatureCardCompositionType.CCA,
    [233] = FeatureCardCompositionType.CCB
  }
  local comType = FeatureCardCompositionType.NONE
  if cardList and 3 <= #cardList then
    local sortedCard = {}
    for i, cardType in ipairs(cardList) do
      table.insert(sortedCard, cardType)
    end
    table.sort(sortedCard)
    local dicKey = sortedCard[1] * 100 + sortedCard[2] * 10 + sortedCard[3]
    local resType = quickDic[dicKey]
    if resType then
      comType = resType
    end
  end
  return comType
end

function FeatureServiceLogic:RecordDrawCard(teamEntityID, curRound, cardType)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:RecordDrawCard(teamEntityID, curRound, cardType)
  end
  return
end

function FeatureServiceLogic:GetDrawCardTimes(teamEntityID, round)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetDrawCardTimes(teamEntityID, round)
  end
  return
end

function FeatureServiceLogic:GetNextDrawFixedCard()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if not teamEntity then
    return
  end
  local teamEntityID = teamEntity:GetID()
  local curTimes = self:GetDrawCardTimes(teamEntityID)
  if not curTimes then
    return
  end
  local nextTimes = curTimes + 1
  local featureData = self:GetFeatureData(FeatureType.Card)
  if featureData then
    local cardType = featureData:GetFixedDrawCard(nextTimes)
    if cardType and cardType >= FeatureCardType.MIN and cardType <= FeatureCardType.MAX then
      return cardType
    end
  end
  return
end

function FeatureServiceLogic:HasEnoughSameCard(count)
  local depot = self:GetCards()
  if depot then
    for cardType, cardCount in pairs(depot) do
      if count <= cardCount then
        return true
      end
    end
  end
  return false
end

function FeatureServiceLogic:SetAutoFightFirstRoundDrawCardEnough(teamEntityID, bEnough)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:SetAutoFightFirstRoundDrawCardEnough(teamEntityID, bEnough)
  end
  return
end

function FeatureServiceLogic:GetAutoFightFirstRoundDrawCardEnough(teamEntityID)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetAutoFightFirstRoundDrawCardEnough(teamEntityID)
  end
  return true
end

function FeatureServiceLogic:GetAvailableCardSkillList()
  local skillCheckSeq = {
    FeatureCardCompositionType.AAA,
    FeatureCardCompositionType.BBB,
    FeatureCardCompositionType.CCC,
    FeatureCardCompositionType.ABC,
    FeatureCardCompositionType.AAB,
    FeatureCardCompositionType.AAC,
    FeatureCardCompositionType.BBA,
    FeatureCardCompositionType.BBC,
    FeatureCardCompositionType.CCA,
    FeatureCardCompositionType.CCB
  }
  local featureData = self:GetFeatureData(FeatureType.Card)
  if not featureData then
    return {}
  end
  local skillList = {}
  local cardSkillDic = featureData:GetCardSkillDic()
  for _, comType in ipairs(skillCheckSeq) do
    local skillID = cardSkillDic[comType]
    if skillID then
      local canCast = self:_CheckFeatureSkillCastCondition_Card(skillID)
      if canCast then
        table.insert(skillList, skillID)
      end
    end
  end
  return skillList
end

function FeatureServiceLogic:GetRandomDrawCardWeight(teamEntityID)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetRandomDrawCardWeight(teamEntityID)
  end
end

function FeatureServiceLogic:_HandleInitFeature_MasterSkill(featureType, featureData)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local masterSkill = featureData:GetMasterSkillID()
    logicFeatureCmpt:SetFeatureSkillID(featureType, masterSkill)
    local entityService = self._world:GetService("LogicEntity")
    local skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.PersonaSkillHolder)
    if skillHolder then
      local holderID = skillHolder:GetID()
      logicFeatureCmpt:SetFeatureSkillHolderID(featureType, holderID)
      local attack = 100
      local firstElement = ElementType.ElementType_Green
      local secondElement = ElementType.ElementType_Green
      local attributeCmpt = skillHolder:Attributes()
      attributeCmpt:SetSimpleAttribute("Element", firstElement)
      attributeCmpt:Modify("Attack", attack)
      skillHolder:ReplaceElement(firstElement, secondElement)
    end
    self:SetFeatureSkillCurPower(featureType, 0, 1)
  end
end

function FeatureServiceLogic:_HandleInitFeature_PopStar(featureType, featureData)
  local popStarProSvc = self:GetService("PopStarProLogic")
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local masterSkill = featureData:GetMasterSkillID()
    logicFeatureCmpt:SetFeatureSkillID(featureType, masterSkill)
    local entityService = self._world:GetService("LogicEntity")
    local skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.PersonaSkillHolder)
    if skillHolder then
      local holderID = skillHolder:GetID()
      logicFeatureCmpt:SetFeatureSkillHolderID(featureType, holderID)
      local attack = 100
      local firstElement = ElementType.ElementType_Green
      local secondElement = ElementType.ElementType_Green
      local attributeCmpt = skillHolder:Attributes()
      attributeCmpt:SetSimpleAttribute("Element", firstElement)
      attributeCmpt:Modify("Attack", attack)
      skillHolder:ReplaceElement(firstElement, secondElement)
    end
    local power = popStarProSvc:GetInitFeaturePower(featureType, featureData)
    local isReady = self:IsPopStarProFeatureReady(power, masterSkill)
    self:SetFeatureSkillCurPower(featureType, power, isReady)
  end
end

function FeatureServiceLogic:CanCastPopStarProFeature(skillConfigData)
  local canCast = true
  if skillConfigData then
    local triggerExtraParam = skillConfigData:GetSkillTriggerExtraParam()
    if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.CostRoundCount] then
      local roundCount = triggerExtraParam[SkillTriggerTypeExtraParam.CostRoundCount]
      if roundCount then
        local battleStatCmpt = self._world:BattleStat()
        if roundCount > battleStatCmpt:GetLevelLeftRoundCount() then
          canCast = false
        end
      end
    end
  end
  return canCast
end

function FeatureServiceLogic:IsPopStarProFeatureReady(curPower, skillID)
  local skillConfigData = self._configService:GetSkillConfigData(skillID)
  local costLegendPower = skillConfigData:GetSkillTriggerParam()
  if curPower >= costLegendPower then
    return 1
  end
  return 0
end

function FeatureServiceLogic:GetPopStarProFeatureInfoList()
  local featureDic = {}
  local featureComponent = self:GetLogicCmpt()
  if not featureComponent then
    return featureDic
  end
  local typeList = featureComponent:GetFeatureTypeList()
  for _, type in ipairs(typeList) do
    if self:IsPopStarSkillFeature(type) then
      local power, ready = featureComponent:GetFeatureSkillCurPower(type)
      featureDic[type] = power
    end
  end
  return featureDic
end

function FeatureServiceLogic:OnBuffRemoveFeature(featureType)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if self:HasFeatureType(featureType) then
    logicFeatureCmpt:RemoveFeatureData(featureType)
  end
  self._world:EventDispatcher():Dispatch(GameEventType.RemoveFeature, featureType)
end

function FeatureServiceLogic:_HandleInitFeature_TrapDefence(featureType, featureData)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local masterSkill = featureData:GetMasterSkillID()
    logicFeatureCmpt:SetFeatureSkillID(featureType, masterSkill)
    local entityService = self._world:GetService("LogicEntity")
    local skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.PersonaSkillHolder)
    if skillHolder then
      local holderID = skillHolder:GetID()
      logicFeatureCmpt:SetFeatureSkillHolderID(featureType, holderID)
      local attack = 100
      local firstElement = ElementType.ElementType_Green
      local secondElement = ElementType.ElementType_Green
      local attributeCmpt = skillHolder:Attributes()
      attributeCmpt:SetSimpleAttribute("Element", firstElement)
      attributeCmpt:Modify("Attack", attack)
      skillHolder:ReplaceElement(firstElement, secondElement)
    end
    self:SetFeatureSkillCurPower(featureType, 999, 0)
  end
end

function FeatureServiceLogic:_HandleInitFeature_Scan(featureData)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if not logicFeatureCmpt then
    Log.error("FeatureServiceLogic: no LogicFeatureComponent found")
    return
  end
  logicFeatureCmpt:InitScanFeature(featureData:GetSummonTrapSkillID(), featureData:GetForceMovementSkillID(), featureData:GetSummonScanTrapSkillID(), featureData:GetEmptySkillID())
end

function FeatureServiceLogic:_HandleInitFeature_TrapCount(featureType, featureData)
end

function FeatureServiceLogic:_CheckFeatureSkillOnRoundEnter(featureType, incRound)
  local battleStatCmpt = self._world:BattleStat()
  if not battleStatCmpt:IsFirstRound() then
    local featureData = self:GetFeatureData(featureType)
    if featureData then
      local curPower, curReady = self:GetFeatureSkillCurPower(featureType)
      if curPower and curReady and curReady == 0 and incRound then
        local logicFeatureCmpt = self:GetLogicCmpt()
        if logicFeatureCmpt then
          local delayChangePowerValue = self:GetFeatureSkillDelayModifyPower(featureType)
          if delayChangePowerValue and delayChangePowerValue ~= 0 then
            curPower = curPower + delayChangePowerValue
            self:SetFeatureSkillDelayModifyPower(featureType, 0)
          end
          local lastDoFeatureSkillRound = logicFeatureCmpt:GetLastDoFeatureSkillRound(featureType)
          local curRound = battleStatCmpt:GetLevelTotalRoundCount()
          if lastDoFeatureSkillRound then
            if 1 < curRound - lastDoFeatureSkillRound then
              curPower = curPower - 1
            end
          elseif incRound then
            curPower = curPower - 1
          end
        end
        if curPower < 0 then
          curPower = 0
        end
        if curPower == 0 then
          curReady = 1
        end
        self:SetFeatureSkillCurPower(featureType, curPower, curReady)
        self._world:EventDispatcher():Dispatch(GameEventType.PersonaPowerChange, featureType, curPower, curReady)
      end
    end
  end
end

function FeatureServiceLogic:SetFeatureSkillCurPower(featureType, power, ready)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:SetFeatureSkillCurPower(featureType, power, ready)
  end
end

function FeatureServiceLogic:GetFeatureSkillCurPower(featureType)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetFeatureSkillCurPower(featureType)
  end
  return nil
end

function FeatureServiceLogic:SetFeatureSkillDelayModifyPower(featureType, delayModifyPower)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:SetFeatureSkillDelayModifyPower(featureType, delayModifyPower)
  end
end

function FeatureServiceLogic:GetFeatureSkillDelayModifyPower(featureType)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetFeatureSkillDelayModifyPower(featureType)
  end
  return 0
end

function FeatureServiceLogic:BuffChangeFeatureSkillPower(featureType, modifyValue)
  if self:IsPopStarSkillFeature(featureType) then
    return self:_BuffChangeFeatureSkillPowerForPopStar(featureType, modifyValue)
  end
  local battleStatCmpt = self._world:BattleStat()
  local featureData = self:GetFeatureData(featureType)
  if featureData then
    local curPower, curReady = self:GetFeatureSkillCurPower(featureType)
    if curPower and 0 < curPower and modifyValue and modifyValue ~= 0 then
      local logicFeatureCmpt = self:GetLogicCmpt()
      if logicFeatureCmpt then
        local lastDoFeatureSkillRound = logicFeatureCmpt:GetLastDoFeatureSkillRound(featureType)
        local curRound = battleStatCmpt:GetLevelTotalRoundCount()
        if lastDoFeatureSkillRound then
          if 0 < curRound - lastDoFeatureSkillRound then
            curPower = curPower + modifyValue
          else
            local oldDelayModifyPower = self:GetFeatureSkillDelayModifyPower(featureType)
            local curDelayModifyPower = oldDelayModifyPower + modifyValue
            self:SetFeatureSkillDelayModifyPower(featureType, curDelayModifyPower)
            return
          end
        else
          curPower = curPower + modifyValue
        end
      end
      if curPower < 0 then
        curPower = 0
      end
      if curPower == 0 then
        curReady = 1
      end
      self:SetFeatureSkillCurPower(featureType, curPower, curReady)
      return featureType, curPower, curReady
    end
  end
end

function FeatureServiceLogic:_BuffChangeFeatureSkillPowerForPopStar(featureType, modifyValue)
  local featureData = self:GetFeatureData(featureType)
  if featureData then
    local curPower, curReady = self:GetFeatureSkillCurPower(featureType)
    if curPower and modifyValue and modifyValue ~= 0 then
      local logicFeatureCmpt = self:GetLogicCmpt()
      if logicFeatureCmpt then
        curPower = curPower + modifyValue
      end
      if curPower < 0 then
        curPower = 0
      end
      local maxPower = featureData:GetMaxPowerLimit()
      if maxPower and curPower > maxPower then
        curPower = maxPower
      end
      local skillID = featureData:GetMasterSkillID()
      curReady = self:IsPopStarProFeatureReady(curPower, skillID)
      self:SetFeatureSkillCurPower(featureType, curPower, curReady)
      return featureType, curPower, curReady
    end
  end
end

function FeatureServiceLogic:CheckFeatureSkillCastCondition(featureType, skillID, selectInfo)
  local log = {
    tostring(BattleConst.Kick),
    tostring(skillID)
  }
  if not BattleConst.Kick then
    return true, log
  end
  if FeatureType.PersonaSkill == featureType or FeatureType.MasterSkill == featureType or FeatureType.MasterSkillRecover == featureType or FeatureType.MasterSkillTeleport == featureType or FeatureType.TrapDefence == featureType or self:IsTalentSkillFeature(featureType) then
    local localSkillID = self:GetFeatureSkillID(featureType)
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(localSkillID)
    if localSkillID ~= skillID then
      return false, log, BattleUIActiveSkillCannotCastReason.NotReady
    end
    local curPower, ready = self:GetFeatureSkillCurPower(featureType)
    if ready == 0 then
      return false, log, BattleUIActiveSkillCannotCastReason.NotReady
    end
    if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
    else
      if curPower ~= 0 then
        return false, log, BattleUIActiveSkillCannotCastReason.NotReady
      end
      local triggerExtraParam = skillConfigData:GetSkillTriggerExtraParam()
      if triggerExtraParam and triggerExtraParam[SkillTriggerTypeExtraParam.CostFeatureStepPoint] then
        local paramStepPoint = triggerExtraParam[SkillTriggerTypeExtraParam.CostFeatureStepPoint]
        if paramStepPoint then
          if self:HasFeatureType(FeatureType.StepPoint) then
            local curStepPoint = self:GetCurStepPoint()
            if paramStepPoint <= curStepPoint then
            else
              return false, log, BattleUIActiveSkillCannotCastReason.NotEnoughFeatureStepPoint
            end
          else
            return false, log, BattleUIActiveSkillCannotCastReason.NotEnoughFeatureStepPoint
          end
        end
      end
    end
  elseif self:IsPopStarSkillFeature(featureType) then
    local localSkillID = self:GetFeatureSkillID(featureType)
    if localSkillID ~= skillID then
      return false, log, BattleUIActiveSkillCannotCastReason.NotReady
    end
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(localSkillID)
    local legendPower, ready = self:GetFeatureSkillCurPower(featureType)
    if ready == 0 then
      return false, log, BattleUIActiveSkillCannotCastReason.NotReady
    end
    if skillConfigData:GetSkillTriggerType() == SkillTriggerType.LegendEnergy then
      local costLegendPower = skillConfigData:GetSkillTriggerParam()
      if legendPower < costLegendPower then
        return false, log, BattleUIActiveSkillCannotCastReason.NotReady
      end
      if not self:CanCastPopStarProFeature(skillConfigData) then
        return false, log, BattleUIActiveSkillCannotCastReason.NotEnoughRound
      end
    else
      return false, log, BattleUIActiveSkillCannotCastReason.NotReady
    end
  elseif FeatureType.Card == featureType then
    return self:_CheckFeatureSkillCastCondition_Card(skillID, log)
  elseif FeatureType.Shop == featureType then
    return self:_CheckFeatureSkillCastCondition_Shop(skillID, selectInfo, log)
  end
  return true, log
end

function FeatureServiceLogic:_CheckFeatureSkillCastCondition_Card(skillID, log)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  if skillConfigData then
    local triggerExtraParam = skillConfigData:GetSkillTriggerExtraParam()
    if triggerExtraParam then
      local cardCostType = triggerExtraParam[SkillTriggerTypeExtraParam.CardCost]
      if cardCostType then
        if self:IsCardEnoughToCost(cardCostType) then
          local tarPetNotHasBuffParam = triggerExtraParam[SkillTriggerTypeExtraParam.CardTarPetNotHasBuff]
          if tarPetNotHasBuffParam then
            if not (0 < #tarPetNotHasBuffParam) then
              goto lbl_116
            end
            local tarPetType = tarPetNotHasBuffParam[1]
            local checkBuffList = {}
            local totalParam = #tarPetNotHasBuffParam
            for i = 2, totalParam do
              local buffEffect = tarPetNotHasBuffParam[i]
              table.insert(checkBuffList, buffEffect)
            end
            local tarPet
            if tarPetType == FeatureTarPetSelectType.TeamLeader then
              local teamEntity = self._world:Player():GetCurrentTeamEntity()
              if teamEntity then
                local teamLeader = teamEntity:Team():GetTeamLeaderEntity()
                tarPet = teamLeader
              end
            elseif tarPetType == FeatureTarPetSelectType.TeamTail then
              local teamEntity = self._world:Player():GetCurrentTeamEntity()
              if teamEntity then
                local cTeam = teamEntity:Team()
                local teamOrder = cTeam:GetTeamOrder()
                local finalIndex = #teamOrder
                local lastPetPstID = teamOrder[finalIndex]
                local lastPetEntity = cTeam:GetPetEntityByPetPstID(lastPetPstID)
                tarPet = lastPetEntity
              end
            end
            if not tarPet then
              goto lbl_116
            end
            local hasBuff = false
            local utilData = self._world:GetService("UtilData")
            for i, buffEffect in ipairs(checkBuffList) do
              hasBuff = utilData:HasBuffEffect(tarPet, buffEffect)
              if hasBuff then
                break
              end
            end
            if hasBuff then
              return false, log, BattleUIActiveSkillCannotCastReason.CardTarPetHasBuff
            end
          else
            return true, log
          end
          ::lbl_116::
          return true, log
        else
          return false, log, BattleUIActiveSkillCannotCastReason.CardNotEnough
        end
      end
    end
  end
  return false, log, BattleUIActiveSkillCannotCastReason.NotReady
end

function FeatureServiceLogic:OnFeatureSkillCast(featureType, skillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  if FeatureType.PersonaSkill == featureType or FeatureType.MasterSkill == featureType or FeatureType.MasterSkillRecover == featureType or FeatureType.MasterSkillTeleport == featureType or FeatureType.TrapDefence == featureType or self:IsTalentSkillFeature(featureType) then
    local MaxPower = skillConfigData:GetSkillTriggerParam()
    local cdOff = self:GetAllFeatureSkillCdOff()
    local specificCdOff = self:GetSpecificFeatureSkillCdOff(featureType)
    MaxPower = MaxPower + cdOff + specificCdOff
    if MaxPower < 0 then
      MaxPower = 0
    end
    local battleStatCmpt = self._world:BattleStat()
    local round = battleStatCmpt:GetLevelTotalRoundCount()
    self:SetLastDoFeatureSkillRound(featureType, round)
    self:SetFeatureSkillCurPower(featureType, MaxPower, 0)
  elseif FeatureType.Card == featureType then
    if skillConfigData then
      local triggerExtraParam = skillConfigData:GetSkillTriggerExtraParam()
      if triggerExtraParam then
        local cardCostType = triggerExtraParam[SkillTriggerTypeExtraParam.CardCost]
        if cardCostType then
          self:CostCardByType(cardCostType)
          self._world:EventDispatcher():Dispatch(GameEventType.FeatureUIRefreshCardNum)
        end
      end
    end
  elseif self:IsPopStarSkillFeature(featureType) then
    local costLegendPower = skillConfigData:GetSkillTriggerParam()
    local legendPower, isReady = self:GetFeatureSkillCurPower(featureType)
    legendPower = legendPower - costLegendPower
    if legendPower <= 0 then
      legendPower = 0
    end
    isReady = self:IsPopStarProFeatureReady(legendPower, skillID)
    self:SetFeatureSkillCurPower(featureType, legendPower, isReady)
    self._world:EventDispatcher():Dispatch(GameEventType.PersonaPowerChange, featureType, legendPower, isReady)
  elseif FeatureType.Shop == featureType then
  end
end

function FeatureServiceLogic:SetLastDoFeatureSkillRound(featureType, round)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:SetLastDoFeatureSkillRound(featureType, round)
  end
end

function FeatureServiceLogic:GetLastDoFeatureSkillRound(featureType)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetLastDoFeatureSkillRound(featureType)
  end
end

function FeatureServiceLogic:GetFeatureSkillID(featureType)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local skillID = logicFeatureCmpt:GetFeatureSkillID(featureType)
    return skillID
  end
  return nil
end

function FeatureServiceLogic:GetFeatureSkillHolderEntityID(featureType)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local holderID = logicFeatureCmpt:GetFeatureSkillHolderID(featureType)
    if holderID then
      return holderID
    end
  end
  return nil
end

function FeatureServiceLogic:GetFeatureSkillHolderEntity(featureType)
  local holderID = self:GetFeatureSkillHolderEntityID(featureType)
  if holderID then
    local skillHolder = self._world:GetEntityByID(holderID)
    return skillHolder
  end
  return nil
end

function FeatureServiceLogic:SetAllFeatureSkillCdOff(cdOff)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:SetAllFeatureSkillCdOff(cdOff)
  end
end

function FeatureServiceLogic:GetAllFeatureSkillCdOff()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetAllFeatureSkillCdOff()
  end
  return 0
end

function FeatureServiceLogic:SetSpecificFeatureSkillCdOff(featureType, cdOff)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:SetSpecificFeatureSkillCdOff(featureType, cdOff)
  end
end

function FeatureServiceLogic:GetSpecificFeatureSkillCdOff(featureType)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetSpecificFeatureSkillCdOff(featureType)
  end
  return 0
end

function FeatureServiceLogic:GetShopSelectedCellList()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetShopSelectedCellList()
  end
  return {}
end

function FeatureServiceLogic:GetShopCoinCount()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetShopCoinCount()
  end
  return 0
end

function FeatureServiceLogic:AddShopCoinCount(addVal)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:AddShopCoinCount(addVal)
  end
end

function FeatureServiceLogic:GetShopOverMaxCoinCount()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local curCount = logicFeatureCmpt:GetShopCoinCount()
    local maxUseCount = -1
    local featureData = logicFeatureCmpt:GetFeatureData(FeatureType.Shop)
    if featureData then
      local unlockParam = featureData:GetUnlockParam()
      if 2 <= #unlockParam then
        local lastUnlockBarParam = unlockParam[#unlockParam]
        maxUseCount = lastUnlockBarParam[#lastUnlockBarParam]
      end
    end
    if 0 < maxUseCount then
      local overCount = curCount - maxUseCount
      overCount = math.max(0, overCount)
      return overCount
    end
  end
  return 0
end

function FeatureServiceLogic:GetShopOverMaxCoinCountAddAttackParam()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local featureData = logicFeatureCmpt:GetFeatureData(FeatureType.Shop)
    if featureData then
      local addParam = featureData:GetAddAttackParam()
      if addParam then
        return addParam
      end
    end
  end
  return 0
end

function FeatureServiceLogic:_HandleInitFeature_Shop(featureType, featureData)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local entityService = self._world:GetService("LogicEntity")
    local skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.PersonaSkillHolder)
    if skillHolder then
      local holderID = skillHolder:GetID()
      logicFeatureCmpt:SetFeatureSkillHolderID(FeatureType.Shop, holderID)
      local firstElement = ElementType.ElementType_Green
      local secondElement = ElementType.ElementType_Green
      local attack = 100
      local attributeCmpt = skillHolder:Attributes()
      attributeCmpt:SetSimpleAttribute("Element", firstElement)
      attributeCmpt:Modify("Attack", attack)
      skillHolder:ReplaceElement(firstElement, secondElement)
    end
    local enterCoinCount = featureData:GetEnterCoinCount()
    logicFeatureCmpt:AddShopCoinCount(enterCoinCount)
  end
end

function FeatureServiceLogic:_ShopGetCellGroupID(cellID, featureData)
  local groupDataList = featureData:GetGroupDataList()
  local groupID = 0
  for groupIndex, groupData in ipairs(groupDataList) do
    if 0 < groupID then
      break
    end
    for groupSubIndex, cellData in ipairs(groupData) do
      if cellData.CellID == cellID then
        groupID = groupIndex
        break
      end
    end
  end
  return groupID
end

function FeatureServiceLogic:_CheckFeatureSkillCastCondition_Shop(skillID, selectInfo, log)
  local isCheckPass = false
  local curCoinCount = self:GetShopCoinCount()
  local curSelectedList = self:GetShopSelectedCellList()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local featureData = logicFeatureCmpt:GetFeatureData(FeatureType.Shop)
    if featureData then
      local groupDataList = featureData:GetGroupDataList()
      if selectInfo then
        local hasSameGroup = false
        local hasSameCell = false
        local groupFinded = {}
        local cellFinded = {}
        for index, cellID in ipairs(selectInfo) do
          local groupIndex = self:_ShopGetCellGroupID(cellID, featureData)
          if cellFinded[cellID] then
            hasSameCell = true
          else
            cellFinded[cellID] = true
          end
          if groupFinded[groupIndex] then
            hasSameGroup = true
          else
            groupFinded[groupIndex] = true
          end
        end
        if not hasSameCell and not hasSameCell then
          local hasCanNotSelectCell = false
          for index, value in ipairs(selectInfo) do
            local canSelect = self:_FeatureShopCellCanSelect(value, featureData, curCoinCount, curSelectedList)
            if not canSelect then
              hasCanNotSelectCell = true
              break
            end
          end
          if not hasCanNotSelectCell then
            isCheckPass = true
          end
        end
      end
    end
  end
  if isCheckPass then
    return true, log
  else
    return false, log, BattleUIActiveSkillCannotCastReason.NotReady
  end
end

function FeatureServiceLogic:_FeatureShopCellCanSelect(cellID, featureData, curCoinCount, curSelectedList)
  if table.icontains(curSelectedList, cellID) then
    return false
  end
  local petTemplateID = 1602181
  local utilData = self._world:GetService("UtilData")
  local matchPet = utilData:GetLocalMatchPetByTemplateID(petTemplateID)
  local curEquipLv = 0
  if matchPet then
    curEquipLv = matchPet:GetEquipLv()
  end
  local groupDataList = featureData:GetGroupDataList()
  local unlockParam = featureData:GetUnlockParam()
  local groupID = 0
  local groupCellIndex = 0
  local otherCellInSameGroup = 0
  local needEquipLv = 0
  for groupIndex, groupData in ipairs(groupDataList) do
    if 0 < groupID then
      break
    end
    for groupSubIndex, cellData in ipairs(groupData) do
      if cellData.CellID == cellID then
        groupID = groupIndex
        groupCellIndex = groupSubIndex
        if cellData.NeedEquipLevel then
          needEquipLv = cellData.NeedEquipLevel
        end
        break
      end
    end
  end
  if curEquipLv < needEquipLv then
    return false
  end
  local groupData = groupDataList[groupID]
  if groupData then
    for groupSubIndex, cellData in ipairs(groupData) do
      if cellData.CellID == cellID then
      else
        otherCellInSameGroup = cellData.CellID
      end
    end
  else
    return false
  end
  local stage = 1
  if table.icontains(curSelectedList, otherCellInSameGroup) then
    stage = 2
  end
  local curStageUnlockParam = unlockParam[stage]
  if curStageUnlockParam then
    local unlockCount = curStageUnlockParam[groupID]
    if curCoinCount < unlockCount then
      return false
    end
  else
    return false
  end
  return true
end

function FeatureServiceLogic:HandleCastSkillSelectInfo(featureType, skillID, selectInfo)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt and featureType == FeatureType.Shop then
    logicFeatureCmpt:SetShopRecentSelectedCellList(selectInfo)
    logicFeatureCmpt:AddShopSelectedCellList(selectInfo)
  end
end

function FeatureServiceLogic:GetShopRecentSelectedCellList()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetShopRecentSelectedCellList()
  end
  return {}
end

function FeatureServiceLogic:GetShopUIHadSeeUnlockCellList()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetShopUIHadSeeUnlockCellList()
  end
  return {}
end

function FeatureServiceLogic:SetShopUIHadSeeUnlockCellList(unlockCellList)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:SetShopUIHadSeeUnlockCellList(unlockCellList)
  end
end

function FeatureServiceLogic:GetShopCellData(shopData, cellID)
  local groupDataList = shopData:GetGroupDataList()
  for i = 1, #groupDataList do
    local curGroupDataList = groupDataList[i]
    for j = 1, #curGroupDataList do
      if curGroupDataList[j].CellID == cellID then
        return curGroupDataList[j]
      end
    end
  end
end

function FeatureServiceLogic:GetAvailableShopSkill()
  local shopData = self:GetFeatureData(FeatureType.Shop)
  if shopData then
    local petTemplateID = 1602181
    local skillID = shopData:GetSkillID()
    local curSelectList = {}
    local selectedCellList = self:GetShopSelectedCellList()
    local curCoinCount = self:GetShopCoinCount()
    local unlockParam = shopData:GetUnlockParam()
    local unlockParamCount = table.count(unlockParam)
    local showPageIndex = 1
    if 1 < unlockParamCount then
      local firstSelectCount = 0
      if table.icontains(selectedCellList, 1) or table.icontains(selectedCellList, 2) then
        firstSelectCount = firstSelectCount + 1
      end
      if table.icontains(selectedCellList, 3) or table.icontains(selectedCellList, 4) then
        firstSelectCount = firstSelectCount + 1
      end
      if table.icontains(selectedCellList, 5) or table.icontains(selectedCellList, 6) then
        firstSelectCount = firstSelectCount + 1
      end
      if firstSelectCount == 3 then
        showPageIndex = 2
      end
    end
    local curUnlockParam = unlockParam[showPageIndex]
    local curStage = #curUnlockParam
    for i = 1, #curUnlockParam do
      if curCoinCount <= curUnlockParam[i] then
        curStage = i
        break
      end
    end
    local petTemplateID = 1602181
    local utilData = self._world:GetService("UtilData")
    local matchPet = utilData:GetLocalMatchPetByTemplateID(petTemplateID)
    local curEquipLv = matchPet:GetEquipLv()
    local canSelectInfo = {}
    local selectedGroupList = {}
    local eachGroupCellCount = 2
    for i = 1, 6 do
      local curCellData = self:GetShopCellData(shopData, i)
      local equipLevelLimit = curCellData.NeedEquipLevel or 0
      local groupIndex = math.floor((i - 1) / eachGroupCellCount) + 1
      local unlockNeedCount = curUnlockParam[groupIndex]
      local hadInvest = table.icontains(selectedCellList, i)
      local isLock = not hadInvest and (curEquipLv < equipLevelLimit or curCoinCount < unlockNeedCount and curStage == 1)
      local cantSelect = self:_ShopGetCurCellCantSelect(i, unlockParamCount, showPageIndex, selectedCellList) or curCoinCount < unlockNeedCount
      if hadInvest or isLock or cantSelect then
      elseif not table.icontains(selectedGroupList, groupIndex) then
        table.insert(canSelectInfo, i)
        table.insert(selectedGroupList, groupIndex)
      end
    end
    if 0 < #canSelectInfo then
      return skillID, canSelectInfo
    end
  end
  return
end

function FeatureServiceLogic:_ShopGetCurCellCantSelect(cellID, unlockParamCount, showPageIndex, selectedCellList)
  if unlockParamCount == 2 and showPageIndex == 2 then
    return false
  end
  local targetCellID = 1
  if cellID == 1 then
    targetCellID = 2
  elseif cellID == 2 then
    targetCellID = 1
  elseif cellID == 3 then
    targetCellID = 4
  elseif cellID == 4 then
    targetCellID = 3
  elseif cellID == 5 then
    targetCellID = 6
  elseif cellID == 6 then
    targetCellID = 5
  end
  local targetCellHadInvest = table.icontains(selectedCellList, targetCellID)
  if targetCellHadInvest then
    return true
  end
  return false
end

function FeatureServiceLogic:_HandleInitFeature_StepPoint(featureType, featureData)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local initStepPoint = featureData:GetInitStepPoint()
    local maxStepPoint = featureData:GetMaxStepPoint()
    local recoverStepPoint = featureData:GetRecoverStepPoint()
    logicFeatureCmpt:InitStepPointParam(initStepPoint, maxStepPoint, recoverStepPoint)
  end
end

function FeatureServiceLogic:_CheckFeatureStepPointOnRoundEnterEarly(incRound)
  if not self:HasFeatureType(FeatureType.StepPoint) then
    return
  end
  local battleStatCmpt = self._world:BattleStat()
  local isGameBegin = incRound and battleStatCmpt:IsFirstRound()
  if not isGameBegin then
    local recoverStepPoint = self:GetRecoverStepPoint()
    local delVal = recoverStepPoint
    if delVal then
      local oldVal = self:GetCurStepPoint()
      self:ChangeCurStepPoint(recoverStepPoint)
      local curVal = self:GetCurStepPoint()
      local l2rSvc = self._world:GetService("L2R")
      l2rSvc:L2RStepPointRoundChange(curVal, oldVal)
    end
  else
    local stepData = self:GetFeatureData(FeatureType.StepPoint)
    if stepData then
      local curVal = self:GetCurStepPoint()
      local l2rSvc = self._world:GetService("L2R")
      l2rSvc:L2RStepPointRoundChange(curVal, curVal)
    end
  end
end

function FeatureServiceLogic:GetCurStepPoint()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetCurStepPoint()
  end
end

function FeatureServiceLogic:ChangeCurStepPoint(addVal)
  if not self:HasFeatureType(FeatureType.StepPoint) then
    return
  end
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:ChangeCurStepPoint(addVal)
  end
end

function FeatureServiceLogic:ChangeMaxStepPoint(addVal)
  if not self:HasFeatureType(FeatureType.StepPoint) then
    return
  end
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:ChangeMaxStepPoint(addVal)
  end
end

function FeatureServiceLogic:GetMaxStepPoint()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetMaxStepPoint()
  end
end

function FeatureServiceLogic:ChangeRecoverStepPoint(addVal)
  if not self:HasFeatureType(FeatureType.StepPoint) then
    return
  end
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:ChangeRecoverStepPoint(addVal)
  end
end

function FeatureServiceLogic:GetRecoverStepPoint()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetRecoverStepPoint()
  end
end

function FeatureServiceLogic:OnMovePathDone(chainPath)
  if self:HasFeatureType(FeatureType.StepPoint) and self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
    local costPoint = #chainPath - 1
    costPoint = costPoint * -1
    costPoint = math.min(0, costPoint)
    local oldVal = self:GetCurStepPoint()
    self:ChangeCurStepPoint(costPoint)
    local curVal = self:GetCurStepPoint()
    local costVal = oldVal - curVal
    self:RecordRecentMoveCostStepPoint(costVal)
    local l2RSvc = self._world:GetService("L2R")
    l2RSvc:L2RStepPointMoveCost(curVal, oldVal)
    local triggerSvc = self._world:GetService("Trigger")
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    local ntFeatureStepPointMoveCost = NTFeatureStepPointMoveCost:New(teamEntity, curVal, oldVal, costVal)
    triggerSvc:Notify(ntFeatureStepPointMoveCost)
  end
end

function FeatureServiceLogic:RecordRecentMoveCostStepPoint(costVal)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:RecordRecentMoveCostStepPoint(costVal)
  end
end

function FeatureServiceLogic:GetRecentMoveCostStepPoint()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetRecentMoveCostStepPoint()
  end
end

function FeatureServiceLogic:DoFeatureOnRoleMoveEnter()
  if not self:HasFeatureType(FeatureType.StepPoint) or self._world:LinkLineType() == ELinkLineType.ELLT_LINE_NoElementCostStep then
  end
end

function FeatureServiceLogic:_HandleInitFeature_BanPetSkill(featureType, featureData)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local entityService = self._world:GetService("LogicEntity")
    local skillHolder = entityService:CreateLogicEntity(EntityConfigIDConst.PersonaSkillHolder)
    if skillHolder then
      local holderID = skillHolder:GetID()
      logicFeatureCmpt:SetFeatureSkillHolderID(FeatureType.BanPetSkill, holderID)
      local firstElement = ElementType.ElementType_Green
      local secondElement = ElementType.ElementType_Green
      local attack = 100
      local attributeCmpt = skillHolder:Attributes()
      attributeCmpt:SetSimpleAttribute("Element", firstElement)
      attributeCmpt:Modify("Attack", attack)
      skillHolder:ReplaceElement(firstElement, secondElement)
    end
  end
end

function FeatureServiceLogic:OnGetAutoFightCastBanPetSkillID()
  local featureData = self:GetFeatureData(FeatureType.BanPetSkill)
  if not featureData then
    return
  end
  local skillCD = featureData:GetSkillCD()
  local logicFeatureCmpt = self:GetLogicCmpt()
  local castRoundList = logicFeatureCmpt:GetBanPetSkillCastRoundList()
  local castLastRound = logicFeatureCmpt:GetBanPetSkillCastLastRound()
  local battleStatCmpt = self._world:BattleStat()
  local levelRound = battleStatCmpt:GetLevelTotalRoundCount()
  if levelRound == castLastRound then
    return
  end
  local curRound = levelRound % 3
  local skillID = self:_OnGetAutoFightCastBanPetSkillIDByRound(featureData, curRound)
  local curSkillRoundList = castRoundList[skillID] or {}
  local lastCastRound = -1
  if 0 < #curSkillRoundList then
    lastCastRound = curSkillRoundList[#curSkillRoundList]
  end
  local normalSkillEnable = skillCD < levelRound - lastCastRound
  if normalSkillEnable == false then
    curRound = curRound - 1
    if curRound == -1 then
      curRound = 2
    end
    skillID = self:_OnGetAutoFightCastBanPetSkillIDByRound(featureData, curRound)
  end
  return skillID
end

function FeatureServiceLogic:_OnGetAutoFightCastBanPetSkillIDByRound(featureData, curRound)
  local skillID = 0
  if curRound == 1 then
    skillID = featureData:GetBanNormalSkillID()
  elseif curRound == 2 then
    skillID = featureData:GetBanActiveSkillID()
  elseif curRound == 0 then
    skillID = featureData:GetBanChainSkillID()
  end
  return skillID
end

function FeatureServiceLogic:_HandleInitFeature_AutoBeadPowerInfo(featureType, featureData)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
  end
end

function FeatureServiceLogic:_HandleInitFeature_Alchemy(featureType, featureData)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
  end
end

function FeatureServiceLogic:AddAlchemyAP(ap)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:AddAlchemyAP(ap)
    if self:IsAlchemyLevelUP() then
      return self:DoAlchemyLevelUP()
    end
  end
end

function FeatureServiceLogic:GetAlchemyLevel()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetAlchemyLevel()
  end
end

function FeatureServiceLogic:GetAlchemyAP()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetAlchemyAP()
  end
end

function FeatureServiceLogic:DoAlchemyLevelUP()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt and self:IsAlchemyLevelUP() then
    local buffSvcL = self._world:GetService("BuffLogic")
    local featureData = logicFeatureCmpt:GetFeatureData(FeatureType.Alchemy)
    local dataList = featureData:GetAllData()
    local curAP = logicFeatureCmpt:GetAlchemyAP()
    local curLevel = logicFeatureCmpt:GetAlchemyLevel()
    local alchemyLevelMax = logicFeatureCmpt:GetAlchemyLevelMax()
    local retBuffInsList = {}
    for _, data in ipairs(dataList) do
      if curAP >= data:GetAP() and curLevel < data:GetLevel() and alchemyLevelMax >= data:GetLevel() then
        local buffList = data:GetBuffList()
        for _, buffData in ipairs(buffList) do
          local addBuffInsList = buffSvcL:AddBuffByTargetType(buffData.BuffID, buffData.BuffTargetType, buffData.BuffTargetParam)
          table.appendArray(retBuffInsList, addBuffInsList)
        end
        logicFeatureCmpt:SetAlchemyLevel(data:GetLevel())
      end
    end
    return retBuffInsList
  end
end

function FeatureServiceLogic:IsAlchemyLevelUP()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local featureData = logicFeatureCmpt:GetFeatureData(FeatureType.Alchemy)
    local dataList = featureData:GetAllData()
    local curAP = logicFeatureCmpt:GetAlchemyAP()
    local curLevel = logicFeatureCmpt:GetAlchemyLevel()
    local alchemyLevelMax = logicFeatureCmpt:GetAlchemyLevelMax()
    for _, data in ipairs(dataList) do
      if curAP >= data:GetAP() and curLevel < data:GetLevel() and alchemyLevelMax >= data:GetLevel() then
        return true
      end
    end
  end
end

function FeatureServiceLogic:_HandleInitFeature_TetrisGame(featureType, featureData)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:InitTetris(featureData:GetDefaultTetris(), featureData:GetDefaultTetris(), featureData:GetDefaultCostPower())
  end
end

function FeatureServiceLogic:SetTetrisIndex(tetrisIndex)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local tetrisData = self:GetFeatureData(FeatureType.TetrisGame)
    local allTetrisList = tetrisData:GetTetrisList()
    local tetrisType = allTetrisList[tetrisIndex]
    logicFeatureCmpt:SetTetrisType(tetrisIndex, tetrisType)
    Log.fatal("SetTetrisIndex Index:", tetrisIndex, "Type:", tetrisType)
    return tetrisType
  end
end

function FeatureServiceLogic:RandomTetrisIndex(needPower, needMainColorCount)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local tetrisData = self:GetFeatureData(FeatureType.TetrisGame)
    local allTetrisList = tetrisData:GetTetrisList()
    local tetrisIndex
    local lockType = logicFeatureCmpt:GetTetrisLock()
    if needPower then
      if not self:SubTetrisPower() then
        Log.fatal("RandomTetrisIndex power no enough")
        return
      end
      local curCostPower = self:GetTetrisCostPower()
      curCostPower = curCostPower + tetrisData:GetClickCostPower()
      self:SetTetrisCostPower(curCostPower)
    end
    if logicFeatureCmpt:GetTetrisLock() then
      tetrisIndex = logicFeatureCmpt:GetTetrisIndex()
      if needMainColorCount then
        self:AddTetrisMainColorCount(1)
      end
    else
      local randomSvcL = self._world:GetService("RandomLogic")
      tetrisIndex = randomSvcL:BoardLogicRand(1, #allTetrisList)
    end
    local tetrisType = self:SetTetrisIndex(tetrisIndex)
    Log.fatal("LockType:", lockType, " RandomTetrisIndex:", tetrisIndex, " TetrisType:", tetrisType)
    if not logicFeatureCmpt:GetTetrisLock() then
      local triggerSvc = self._world:GetService("Trigger")
      local nt = NTRandomTetrisEnd:New(nil, tetrisIndex, tetrisType)
      triggerSvc:Notify(nt)
    end
    return tetrisIndex, tetrisType
  end
end

function FeatureServiceLogic:GetTetrisIndex()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetTetrisIndex()
  end
end

function FeatureServiceLogic:GetTetrisType()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetTetrisType()
  end
end

function FeatureServiceLogic:TurnTetrisDir()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local tetrisData = self:GetFeatureData(FeatureType.TetrisGame)
    local allTetrisDir = tetrisData:GetDirList()
    local tetrisDirIndex = logicFeatureCmpt:GetTetrisDirIndex()
    local nextDirIndex = tetrisDirIndex + 1
    local nextDir = self:SetTetrisDirIndex(nextDirIndex)
    Log.info("TurnTetrisDir NextDirIndex:", nextDirIndex, " TetrisDir:", nextDir)
    return allTetrisDir[nextDirIndex], nextDirIndex
  end
end

function FeatureServiceLogic:SetTetrisDirIndex(newDirIndex)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    if not newDirIndex then
      return
    end
    local tetrisData = self:GetFeatureData(FeatureType.TetrisGame)
    local allTetrisDir = tetrisData:GetDirList()
    if newDirIndex > #allTetrisDir then
      newDirIndex = 1
    end
    local nextDir = allTetrisDir[newDirIndex]
    logicFeatureCmpt:SetTetrisDir(newDirIndex, nextDir)
    Log.info("SetTetrisDirIndex NewDirIndex:", newDirIndex, " TetrisDir:", nextDir)
    return nextDir
  end
end

function FeatureServiceLogic:GetTetrisDirIndex()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetTetrisDirIndex()
  end
end

function FeatureServiceLogic:AddTetrisMainColorCount(count)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local tetrisData = self:GetFeatureData(FeatureType.TetrisGame)
    local maxMainColorCount = tetrisData:GetMainColorMaxCount()
    local curMainColorCount = logicFeatureCmpt:GetTetrisMainColorCount()
    curMainColorCount = curMainColorCount + count
    if maxMainColorCount < curMainColorCount then
      curMainColorCount = maxMainColorCount
    end
    self:SetTetrisMainColorCount(curMainColorCount)
  end
end

function FeatureServiceLogic:SetTetrisMainColorCount(count)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:SetTetrisMainColorCount(count)
  end
end

function FeatureServiceLogic:GetTetrisMainColorCount()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetTetrisMainColorCount()
  end
end

function FeatureServiceLogic:ClearTetrisMainColorCount()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:SetTetrisMainColorCount(0)
  end
end

function FeatureServiceLogic:GetTetrisDir()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetTetrisDir()
  end
end

function FeatureServiceLogic:SubTetrisPower()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local curPower = self:GetTetrisPower()
    local costPower = self:GetTetrisCostPower()
    local newPower = curPower - costPower
    if newPower < 0 then
      return false
    end
    Log.info("Tetris SubTetrisPower CurPower:", curPower, " CostPower:", costPower, " NewPower:", newPower)
    self:SetTetrisPower(newPower)
    return true
  end
end

function FeatureServiceLogic:GetTetrisCostPower()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local costPower = logicFeatureCmpt:GetTetrisCostPower()
    return costPower
  end
end

function FeatureServiceLogic:SetTetrisCostPower(costPower)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:SetTetrisCostPower(costPower)
  end
end

function FeatureServiceLogic:GetTetrisPower()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetTetrisPower()
  end
end

function FeatureServiceLogic:SetTetrisPower(power)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    local tetrisData = self:GetFeatureData(FeatureType.TetrisGame)
    if power > tetrisData:GetMaxShowPower() then
      power = tetrisData:GetMaxShowPower()
    end
    logicFeatureCmpt:SetTetrisPower(power)
    return power
  end
end

function FeatureServiceLogic:GetTetrisLock()
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    return logicFeatureCmpt:GetTetrisLock()
  end
end

function FeatureServiceLogic:SetTetrisLock(state)
  local logicFeatureCmpt = self:GetLogicCmpt()
  if logicFeatureCmpt then
    logicFeatureCmpt:SetTetrisLock(state)
  end
end
