local AvgPlayController = class("AvgPlayController", ControllerBase)
local TaskEnum = require("Game.Task.TaskEnum")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function AvgPlayController:ctor()
end

function AvgPlayController:OnInit()
  self.__onRecvNewAvgTask = BindCallback(self, self.OnRecvNewAvgTask)
  MsgCenter:AddListener(eMsgEventId.TaskReceived, self.__onRecvNewAvgTask)
  self._unPlayedMainSectorDic = {}
end

function AvgPlayController:InitAllAvgPlayed(avgGroup)
  if avgGroup == nil then
    self.avgPlayedDic = {}
  else
    self.avgPlayedDic = avgGroup.data
  end
  self:_RefreshUnPlayedMainSectorDic()
end

function AvgPlayController:RecordAvgPlayed(avgId)
  if self.avgPlayedDic == nil then
    error("avgPlayedDic is not initialize")
    return
  end
  local avgCfg = ConfigData.story_avg[avgId]
  if avgCfg == nil then
    error("Cant get avgCfg, avgId = " .. tostring(avgId))
    return
  end
  self.avgPlayedDic[avgCfg.group_id] = true
  self:_RefreshUnPlayedMainSectorDicWithId(avgId)
  self:UpdateMainAvgState(avgId)
  local unlockDic = ConfigData.sector.avgUnlockDic[avgId]
  if unlockDic ~= nil then
    for id, checkerTypeId in pairs(unlockDic) do
      if checkerTypeId == CheckerTypeId.CompleteStage then
        PlayerDataCenter.sectorStage:UpdateSctStageItemState(id)
      elseif checkerTypeId == CheckerTypeId.CompleteAvg then
        self:UpdateMainAvgState(id)
      end
    end
  end
  MsgCenter:Broadcast(eMsgEventId.AVGLogicPlayed, avgId)
end

function AvgPlayController:ReqAvgComplete(avgId)
  if self:IsAvgPlayed(avgId) then
    return
  end
  self:RecordAvgPlayed(avgId)
  NetworkManager:GetNetwork(NetworkTypeID.Avg):CS_AVG_Complete(avgId, 0, nil)
end

function AvgPlayController:TryPlayTaskAvg(param1, callBack, onlyAvgCallBack)
  local avgCfg = self:CheckTaskAvgPlayable(param1)
  if avgCfg ~= nil then
    ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(avgCfg.script_id, avgCfg.id, callBack)
  elseif not onlyAvgCallBack and callBack ~= nil then
    callBack()
  end
end

function AvgPlayController:TryPlayAvg(avgTriggerType, place, param1, param2, callBack)
  if ExplorationManager.epCtrl ~= nil and ExplorationManager.epCtrl.autoCtrl:IsAutoModeRunning() then
    if callBack ~= nil then
      callBack()
    end
    return
  end
  local avgCfg = self:CkeckAvgPlayable(avgTriggerType, place, param1, param2)
  if avgCfg ~= nil then
    ControllerManager:GetController(ControllerTypeId.Avg, true):StartAvg(avgCfg.script_id, nil, callBack)
    return true
  elseif callBack ~= nil then
    callBack()
  end
end

function AvgPlayController:CheckTaskAvgPlayable(param1)
  local taskIdDic = ConfigData.story_avg.avgTaskParamDic[param1]
  if taskIdDic == nil then
    return
  end
  for taskId, avgId in pairs(taskIdDic) do
    local avgCfg = self:CkeckAvgPlayable(eAvgTriggerType.AvgTask, taskId, param1)
    if avgCfg ~= nil then
      return avgCfg
    end
  end
end

function AvgPlayController:CkeckAvgPlayable(avgTriggerType, place, param1, param2)
  local avgCfg = self:TryGetAvgCfg(avgTriggerType, place, param1, param2)
  if avgCfg == nil then
    return
  end
  if self:IsAvgPlayed(avgCfg.id) then
    return
  end
  if not self:IsAvgUnlock(avgCfg.id) then
    return
  end
  if avgCfg.type == eAvgTriggerType.AvgTask then
    local taskData = PlayerDataCenter.allTaskData.taskDatas[avgCfg.set_place]
    if taskData == nil or taskData:CheckComplete() then
      return
    end
  end
  return avgCfg
end

function AvgPlayController:TryGetAvgCfg(avgTriggerType, place, param1, param2)
  local triggerCfg = ConfigData.story_avg.triggerTypeDic[avgTriggerType]
  if triggerCfg == nil then
    return
  end
  local triggerParam1Cfg = triggerCfg[place]
  if triggerParam1Cfg == nil then
    return
  end
  local triggerParam2Cfg = triggerParam1Cfg[param1 or 0]
  if triggerParam2Cfg == nil then
    return
  end
  local avgId = triggerParam2Cfg[param2 or 0]
  if avgId == nil then
    return
  end
  local avgCfg = ConfigData.story_avg[avgId]
  if avgCfg == nil then
    error("Cant get avgCfg, avgId = " .. tostring(avgId))
    return
  end
  return avgCfg
end

function AvgPlayController:GetMainAvgPara2Num(place, param1)
  local para1Dic = ConfigData.story_avg.mainLineAvgPara2NumDic[place]
  if para1Dic == nil then
    return 0
  end
  local para2Num = para1Dic[param1]
  return para2Num or 0
end

function AvgPlayController:IsAvgPlayed(avgId)
  local avgCfg = ConfigData.story_avg[avgId]
  if avgCfg == nil then
    error("Cant get avgCfg, avgId = " .. tostring(avgId))
    return true
  end
  if self.avgPlayedDic == nil then
    error("avgPlayedDic is not initialize")
    return true
  end
  if self.avgPlayedDic[avgCfg.group_id] ~= nil then
    return true
  end
end

function AvgPlayController:OnRecvNewAvgTask(newTaskDataList)
  local avgTaskList
  for k, taskData in ipairs(newTaskDataList) do
    if taskData.stcData.type == TaskEnum.eTaskType.AvgTask then
      if avgTaskList == nil then
        avgTaskList = {}
      end
      table.insert(avgTaskList, taskData)
    end
  end
  if avgTaskList == nil then
    return
  end
  for k, taskData in ipairs(avgTaskList) do
    local avgId = taskData.stcData.story
    local story2guide_condition = taskData.stcData.story2guide_condition
    local avgCfg = ConfigData.story_avg[avgId]
    if avgCfg == nil then
      error("Can't find avgCfg, avgId = " .. tostring(avgId))
    elseif not self:IsAvgPlayed(avgId) and self:IsAvgUnlock(avgCfg.id) then
      self:TryPlayTaskAvg(0, function()
        if 0 < story2guide_condition then
          GuideManager:TryTriggerGuide(story2guide_condition)
        end
      end, true)
    end
  end
end

function AvgPlayController:IsAvgUnlock(avgId)
  local avgCfg = ConfigData.story_avg[avgId]
  if avgCfg == nil then
    error("Can't find avgCfg, avgId = " .. tostring(avgId))
    return true
  end
  return CheckCondition.CheckLua(avgCfg.pre_condition, avgCfg.pre_para1, avgCfg.pre_para2)
end

function AvgPlayController:GetAvgUnlockInfo(avgId)
  local avgCfg = ConfigData.story_avg[avgId]
  if avgCfg == nil then
    error("Can't find avgCfg, avgId = " .. tostring(avgId))
    return
  end
  return CheckCondition.GetUnlockInfoLua(avgCfg.pre_condition, avgCfg.pre_para1, avgCfg.pre_para2)
end

function AvgPlayController:GetPreUnlockSectorStage(avgId)
  local avgCfg = ConfigData.story_avg[avgId]
  if avgCfg == nil then
    error("Can't find avgCfg, avgId = " .. tostring(avgId))
    return nil
  end
  for i, preCondition in ipairs(avgCfg.pre_condition) do
    if preCondition == CheckerTypeId.CompleteStage then
      return avgCfg.pre_para1[i]
    end
  end
  return nil
end

function AvgPlayController:_RefreshUnPlayedMainSectorDic()
  self._unPlayedMainSectorDic = {}
  local avgSectorDic = ConfigData.story_avg.mainAvgDic
  for sectorId, diffcultyDic in pairs(avgSectorDic) do
    for diffcultyId, list in pairs(diffcultyDic) do
      if self._unPlayedMainSectorDic[sectorId] == nil then
        self._unPlayedMainSectorDic[sectorId] = {}
      end
      self._unPlayedMainSectorDic[sectorId][diffcultyId] = #list
    end
  end
  for avgGroupId, _ in pairs(self.avgPlayedDic) do
    local groupList = ConfigData.story_avg.avgGroupDic[avgGroupId]
    if groupList ~= nil then
      for k, avgId in ipairs(groupList) do
        self:_RefreshUnPlayedMainSectorDicWithId(avgId)
      end
    end
  end
end

function AvgPlayController:_RefreshUnPlayedMainSectorDicWithId(avgId)
  local avgCfg = ConfigData.story_avg[avgId]
  if avgCfg == nil then
    return
  end
  if avgCfg.sectorId == nil or self._unPlayedMainSectorDic[avgCfg.sectorId] == nil then
    return
  end
  local diffcultyDic = self._unPlayedMainSectorDic[avgCfg.sectorId]
  if avgCfg.difficulty == nil or diffcultyDic[avgCfg.difficulty] == nil then
    return
  end
  local count = diffcultyDic[avgCfg.difficulty] - 1
  if 0 < count then
    diffcultyDic[avgCfg.difficulty] = count
    return
  end
  diffcultyDic[avgCfg.difficulty] = nil
  if table.count(diffcultyDic) == 0 then
    self._unPlayedMainSectorDic[avgCfg.sectorId] = nil
  end
end

function AvgPlayController:IsPlayedAllMainAvg(sectorId, difficulty, checkAvgId, isCheckPreSector, isNeedAvgUnlock)
  local function SectorAvgCompleteCheckFunc(id, diff, checkId)
    local avgList = ConfigData.story_avg.mainAvgDic[id]
    
    if avgList == nil then
      error(" mainAvgDic sector Miss id: " .. tostring(id))
      return 0
    end
    avgList = avgList[diff]
    if avgList == nil then
      error(" mainAvgDic difficulty Miss id: " .. tostring(diff))
      return 0
    end
    for _, avgId in ipairs(avgList) do
      if not (not isNeedAvgUnlock or self:IsAvgUnlock(avgId)) or avgId == checkId then
        break
      end
      if not self:IsAvgPlayed(avgId) then
        return avgId
      end
    end
    return 0
  end
  
  if isCheckPreSector then
    for _, preSectorId in ipairs(ConfigData.sector.id_sort_list) do
      if preSectorId < sectorId then
        break
      end
      if self._unPlayedMainSectorDic[preSectorId] ~= nil and 0 < (self._unPlayedMainSectorDic[preSectorId][difficulty] or 0) then
        return SectorAvgCompleteCheckFunc(preSectorId, difficulty, checkAvgId)
      end
    end
  end
  if self._unPlayedMainSectorDic[sectorId] == nil then
    return 0
  end
  if (self._unPlayedMainSectorDic[sectorId][difficulty] or 0) == 0 then
    return 0
  end
  return SectorAvgCompleteCheckFunc(sectorId, difficulty, checkAvgId)
end

function AvgPlayController:IsPlayedAllMainAvg4AllAvgSector(sectorId, checkAvgId, isNeedAvgUnlock)
  local avgIds = ConfigData.story_avg.sectorAvgDic[sectorId]
  if avgIds == nil then
    error(" sectorAvgDic Miss id: " .. tostring(sectorId))
    return 0
  end
  for _, avgId in ipairs(avgIds) do
    if not (not isNeedAvgUnlock or self:IsAvgUnlock(avgId)) or avgId == checkAvgId then
      break
    end
    if not self:IsAvgPlayed(avgId) then
      return avgId
    end
  end
  return 0
end

function AvgPlayController:UpdateMainAvgState(avgId)
  local avgCfg = ConfigData.story_avg[avgId]
  if avgCfg == nil then
    error("Cant get avgCfg, avgId = " .. tostring(avgId))
    return
  end
  if avgCfg.type ~= eAvgTriggerType.MainAvg and avgCfg.type ~= eAvgTriggerType.AvgSector then
    return
  end
  if avgCfg.type == eAvgTriggerType.MainAvg then
    local stageCfg = ConfigData.sector_stage[avgCfg.set_place]
    if stageCfg == nil then
      error("Cant find sector_stage cfg, id = " .. tostring(avgCfg.set_place))
      return
    end
    MsgCenter:Broadcast(eMsgEventId.OnMainAvgStateChange, stageCfg.sector, stageCfg.difficulty, avgId)
  else
    MsgCenter:Broadcast(eMsgEventId.OnMainAvgStateChange, avgCfg.set_place, 1, avgId)
  end
end

function AvgPlayController:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskReceived, self.__onRecvNewAvgTask)
end

return AvgPlayController
