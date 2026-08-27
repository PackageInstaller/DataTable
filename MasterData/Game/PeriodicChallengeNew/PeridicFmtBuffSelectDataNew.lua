local PeridicFmtBuffSelectDataNew = class("PeridicFmtBuffSelectDataNew")

function PeridicFmtBuffSelectDataNew.CreateFmtBuffNewByEnvSelect(diffculty)
  local data = PeridicFmtBuffSelectDataNew.New()
  local groupId = ConfigData.act_general_ep_difficulty[diffculty].buff_group_id
  local groupCfg = ConfigData.act_general_ep_buff_group[groupId]
  if groupCfg == nil then
    error("act_general_ep_buff_group[" .. groupId .. "]没有配置")
    return
  end
  data.addBaseRate = ConfigData.act_general_ep_difficulty[diffculty].infinite_coe
  data.groupCfg = groupCfg
  data._positiveBuffIdDic = {}
  data._BuffCfgDic = {}
  data._buffScoreValueDic = ConfigData.weekly_challenge_warning
  local buffDic = ConfigData.act_general_ep_origin_buff[groupId]
  for id, cfg in pairs(buffDic) do
    data._BuffCfgDic[id] = cfg
    if cfg.buff_type == 1 then
      data._positiveBuffIdDic[id] = true
    end
  end
  data._title = ConfigData:GetTipContent(groupCfg.title_id)
  data._intro = ConfigData:GetTipContent(groupCfg.rule_id)
  return data
end

function PeridicFmtBuffSelectDataNew:GetIsHaveTaskComplete()
  local isComplete = false
  for id, cfg in pairs(self._BuffCfgDic) do
    if cfg.unlock_task ~= 0 then
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(cfg.unlock_task, true)
      isComplete = isComplete or not taskData:IsPickedTaskReward() and taskData:CheckComplete()
    end
  end
  return isComplete
end

function PeridicFmtBuffSelectDataNew:GetBaseAddRate()
  return self.addBaseRate or 0
end

function PeridicFmtBuffSelectDataNew:GetGroupCfg()
  return self.groupCfg
end

function PeridicFmtBuffSelectDataNew:SetSelectCallback(selectSaveFunc)
  self._selectSaveFunc = selectSaveFunc
end

function PeridicFmtBuffSelectDataNew:SetDefaultSelect(buffDic)
  local buffIds = {}
  for k, _ in pairs(buffDic) do
    if self._buffDic[k] ~= nil or self._assistBuffIdDic[k] ~= nil then
      table.insert(buffIds, k)
    end
  end
  self:SetFmtBuffSelect(buffIds)
end

function PeridicFmtBuffSelectDataNew:IsPositiveBuff(buffId)
  return self._positiveBuffIdDic ~= nil and self._positiveBuffIdDic[buffId] ~= nil
end

function PeridicFmtBuffSelectDataNew:SetFmtBuffSelect(buffIds)
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

function PeridicFmtBuffSelectDataNew:GetMaxSelectBuff()
  return self.groupCfg.buff_max + self.groupCfg.debuff_max
end

function PeridicFmtBuffSelectDataNew:GetFmtBuffSelect()
  return self._lastBuffSelects
end

function PeridicFmtBuffSelectDataNew:GetFmtAllBuffCfg()
  return self._BuffCfgDic
end

function PeridicFmtBuffSelectDataNew:GetFmtBuffEffect(buffId)
  if self._BuffCfgDic[buffId] ~= nil then
    return self._BuffCfgDic[buffId].inifinite_coe
  end
  return 0
end

function PeridicFmtBuffSelectDataNew:IsFmtEffectBuff(buffId)
  if self._buffDic[buffId] ~= nil then
    return true
  end
  if self._explorationBuffDic ~= nil then
    return self._explorationBuffDic[buffId] ~= nil
  end
  return false
end

function PeridicFmtBuffSelectDataNew:GetFmtBuffCurAddScoreRate()
  return self._curScore
end

function PeridicFmtBuffSelectDataNew:GetFmtBuffTitle()
  return self._title
end

function PeridicFmtBuffSelectDataNew:GetFmtBuffIntro()
  return self._intro
end

function PeridicFmtBuffSelectDataNew:GetBuffScoreWarningValue(level)
  local warnValueCfg = self._buffScoreValueDic[level]
  if warnValueCfg ~= nil then
    return warnValueCfg.warning_level
  end
  return math.maxinteger
end

return PeridicFmtBuffSelectDataNew
