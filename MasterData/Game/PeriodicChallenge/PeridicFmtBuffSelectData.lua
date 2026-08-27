local PeridicFmtBuffSelectData = class("PeridicFmtBuffSelectData")

function PeridicFmtBuffSelectData.CreateFmtBuffByWc(id, wcCfg, serverCfg)
  local data = PeridicFmtBuffSelectData.New()
  data._buffDic = {}
  table.merge(data._buffDic, serverCfg.initBuffId)
  table.merge(data._buffDic, serverCfg.assistBuffId)
  data._assistBuffIdDic = serverCfg.assistBuffId
  data._buffGroup = wcCfg.buffGroup
  data._explorationBuffDic = serverCfg.exploreBuffId
  data._groupOrder = wcCfg.groupOrder
  data._groupNameDic = wcCfg.group_name
  data._baseRecommandPower = ConfigData.game_config.weeklyRecommandPower[id] or 0
  data._rateRecommandPower = ConfigData.game_config.weeklyRecommandPowerEffectRate or 0
  data._buffScoreValueDic = ConfigData.weekly_challenge_warning
  data._enemyPowerRatePerLevel = ConfigData.game_config.wcEnemyPowerRatePerLevel
  data._title = ConfigData:GetTipContent(13005)
  data._intro = ConfigData:GetTipContent(TipContent.WeeklyDebuffIntro)
  data._isShowEmenyPower = true
  data:__CalculateBuffSum()
  return data
end

function PeridicFmtBuffSelectData.CreateFmtBuffByBlackHole(dungeonId, dungeonBHData)
  local data = PeridicFmtBuffSelectData.New()
  local bHDunCfg = ConfigData.activity_blackhole_dungeon[dungeonId]
  data._buffDic = {}
  table.merge(data._buffDic, bHDunCfg.init_buff_id)
  table.merge(data._buffDic, bHDunCfg.assist_buff)
  data._assistBuffIdDic = bHDunCfg.assist_buff
  data._buffGroup = bHDunCfg.buffGroup
  data._groupOrder = bHDunCfg.groupOrder
  data._groupNameDic = bHDunCfg.group_name
  data._baseRecommandPower = 0
  data._rateRecommandPower = 0
  data._buffScoreValueDic = ConfigData.weekly_challenge_warning
  data._enemyPowerRatePerLevel = 0
  data._title = ConfigData:GetTipContent(7504)
  data._intro = ConfigData:GetTipContent(dungeonBHData:GetBuffSelectIntroId())
  data:__CalculateBuffSum()
  return data
end

function PeridicFmtBuffSelectData.CreateFmtBuffByCommonHardLevel(dungeonId)
  local data = PeridicFmtBuffSelectData.New()
  local hardDunStageCfg = ConfigData.activity_hard_dungeon_stage[dungeonId]
  data._buffDic = {}
  table.merge(data._buffDic, hardDunStageCfg.init_buff_id)
  table.merge(data._buffDic, hardDunStageCfg.assist_buff)
  data._assistBuffIdDic = hardDunStageCfg.assist_buff
  data._buffGroup = hardDunStageCfg.buffGroup
  data._groupOrder = hardDunStageCfg.groupOrder
  data._groupNameDic = hardDunStageCfg.group_name
  data._baseRecommandPower = 0
  data._rateRecommandPower = 0
  data._buffScoreValueDic = ConfigData.weekly_challenge_warning
  data._enemyPowerRatePerLevel = 0
  data._title = ConfigData:GetTipContent(hardDunStageCfg.buffrule_title)
  data._intro = ConfigData:GetTipContent(hardDunStageCfg.buffrule_des)
  data:__CalculateBuffSum()
  return data
end

function PeridicFmtBuffSelectData.CreateFmtBuffByADC(adcData, dungeonId)
  local data = PeridicFmtBuffSelectData.New()
  local adcDunCfg = adcData:GetADCDungeonCfg()[dungeonId]
  data._buffDic = {}
  table.merge(data._buffDic, adcDunCfg.init_buff_id)
  table.merge(data._buffDic, adcDunCfg.assist_buff)
  data._assistBuffIdDic = adcDunCfg.assist_buff
  data._buffGroup = adcDunCfg.buffGroup
  data._groupOrder = adcDunCfg.groupOrder
  data._groupNameDic = adcDunCfg.group_name
  data._baseRecommandPower = 0
  data._rateRecommandPower = 0
  data._buffScoreValueDic = ConfigData.weekly_challenge_warning
  data._enemyPowerRatePerLevel = 0
  data._title = adcData:GetActivityName()
  data._intro = ConfigData:GetTipContent(8416)
  data:__CalculateBuffSum()
  return data
end

function PeridicFmtBuffSelectData.CreateFmtBuffByBrotato(stageId)
  local data = PeridicFmtBuffSelectData.New()
  local cfg = ConfigData.brotato_challenge[stageId]
  if cfg == nil then
    error("brotato_challenge[" .. stageId .. "]没有配置")
    return
  end
  data._buffDic = {}
  table.merge(data._buffDic, cfg.init_buff_id)
  table.merge(data._buffDic, cfg.assist_buff)
  data._assistBuffIdDic = cfg.assist_buff
  data._buffGroup = cfg.buffGroup
  data._groupOrder = cfg.groupOrder
  data._groupNameDic = cfg.group_name
  data._baseRecommandPower = cfg.base_recommand_power
  data._rateRecommandPower = cfg.rate_recommand_power * 1.0E-4
  data._buffScoreValueDic = ConfigData.weekly_challenge_warning
  data._enemyPowerRatePerLevel = cfg.enemy_rate_perlevel * 1.0E-4
  data._title = ConfigData:GetTipContent(13012)
  data._intro = ConfigData:GetTipContent(8416)
  data._isShowEmenyPower = true
  data:__CalculateBuffSum()
  return data
end

function PeridicFmtBuffSelectData:SetSelectCallback(selectSaveFunc)
  self._selectSaveFunc = selectSaveFunc
end

function PeridicFmtBuffSelectData:SetDefaultSelect(buffDic)
  local buffIds = {}
  for k, _ in pairs(buffDic) do
    if self._buffDic[k] ~= nil or self._assistBuffIdDic[k] ~= nil then
      table.insert(buffIds, k)
    end
  end
  self:SetFmtBuffSelect(buffIds)
end

function PeridicFmtBuffSelectData:__CalculateBuffSum()
  self._buffSum = 0
  local groupMaxVlaueDic = {}
  for buffId, value in pairs(self._buffDic) do
    if not (value <= 0) then
      local groupId = self._buffGroup[buffId]
      if groupId == nil then
        self._buffSum = self._buffSum + value
      elseif groupMaxVlaueDic[groupId] == nil or value > groupMaxVlaueDic[groupId] then
        groupMaxVlaueDic[groupId] = value
      end
    end
  end
  for _, value in pairs(groupMaxVlaueDic) do
    self._buffSum = self._buffSum + value
  end
  if self._explorationBuffDic ~= nil then
    for _, value in pairs(self._explorationBuffDic) do
      if 0 < value then
        self._buffSum = self._buffSum + value
      end
    end
  end
end

function PeridicFmtBuffSelectData:SetFmtBuffSelect(buffIds)
  self._curScore = 0
  self._lastBuffSelects = buffIds
  if self._lastBuffSelects == nil then
    return
  end
  for _, buffId in ipairs(self._lastBuffSelects) do
    self._curScore = self._curScore + self:GetFmtBuffEffect(buffId)
  end
  if self._selectSaveFunc ~= nil then
    local buffDic = {}
    for _, buffId in ipairs(buffIds) do
      buffDic[buffId] = true
    end
    self._selectSaveFunc(buffDic)
  end
end

function PeridicFmtBuffSelectData:GetFmtBuffSelect()
  return self._lastBuffSelects
end

function PeridicFmtBuffSelectData:GetFmtAllBuff()
  return self._buffDic
end

function PeridicFmtBuffSelectData:GetFmtBuffEffect(buffId)
  if self._buffDic[buffId] ~= nil then
    return self._buffDic[buffId]
  end
  if self._explorationBuffDic == nil then
    return 0
  end
  return self._explorationBuffDic[buffId] or 0
end

function PeridicFmtBuffSelectData:IsFmtEffectBuff(buffId)
  if self._buffDic[buffId] ~= nil then
    return true
  end
  if self._explorationBuffDic ~= nil then
    return self._explorationBuffDic[buffId] ~= nil
  end
  return false
end

function PeridicFmtBuffSelectData:GetFmtBuffHighestSum()
  return self._buffSum
end

function PeridicFmtBuffSelectData:IsFmtBuffAssis(buffId)
  return self._assistBuffIdDic ~= nil and self._assistBuffIdDic[buffId] ~= nil
end

function PeridicFmtBuffSelectData:GetFmtBuffGroupId(buffId)
  return self._buffGroup[buffId] or 0
end

function PeridicFmtBuffSelectData:GetFmtBuffGroupOrder()
  return self._groupOrder
end

function PeridicFmtBuffSelectData:GetFmtBuffGroupName(groupId)
  if self._groupNameDic == nil then
    return ""
  end
  return self._groupNameDic[groupId] or ""
end

function PeridicFmtBuffSelectData:GetFmtBuffRecomPowerBase()
  return self._baseRecommandPower
end

function PeridicFmtBuffSelectData:GetFmtBuffRecomPowerRate()
  return self._rateRecommandPower
end

function PeridicFmtBuffSelectData:GetFmtBuffCurAddScoreRate()
  return self._curScore
end

function PeridicFmtBuffSelectData:GetFmtBuffTitle()
  return self._title
end

function PeridicFmtBuffSelectData:GetFmtBuffIntro()
  return self._intro
end

function PeridicFmtBuffSelectData:GetBuffScoreWarningValue(level)
  local warnValueCfg = self._buffScoreValueDic[level]
  if warnValueCfg ~= nil then
    return warnValueCfg.warning_level
  end
  return math.maxinteger
end

function PeridicFmtBuffSelectData:GetBuffEmenyPower(layer, level)
  local layerRate = 1 + layer * self._rateRecommandPower
  local enemyRate = 1 + (level - 1) * self._enemyPowerRatePerLevel
  return math.floor(self._baseRecommandPower * layerRate * enemyRate)
end

function PeridicFmtBuffSelectData:IsShowEmenyPowerInFmtBuff()
  return self._isShowEmenyPower
end

return PeridicFmtBuffSelectData
