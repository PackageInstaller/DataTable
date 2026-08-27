local ConditionListener = class("ConditionListener")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ConditionListenerDic = {
  [CheckerTypeId.PlayerLevel] = require("Game.Common.CheckCondition.ConditonListener.Listener.PlayerLevelListerner"),
  [CheckerTypeId.CompleteTask] = require("Game.Common.CheckCondition.ConditonListener.Listener.CompleteTaskListerner"),
  [CheckerTypeId.CompleteStage] = require("Game.Common.CheckCondition.ConditonListener.Listener.CompleteStageListerner"),
  [CheckerTypeId.CompleteAvg] = require("Game.Common.CheckCondition.ConditonListener.Listener.CompleteAvgListerner"),
  [CheckerTypeId.MinHeroStar] = require("Game.Common.CheckCondition.ConditonListener.Listener.HeroMinRankListener"),
  [CheckerTypeId.TimeRange] = require("Game.Common.CheckCondition.ConditonListener.Listener.TimeRangeListerner"),
  [CheckerTypeId.CharDungeonConsume] = require("Game.Common.CheckCondition.ConditonListener.Listener.CharDungeonConsumeListerner"),
  [CheckerTypeId.ActivityOpen] = require("Game.Common.CheckCondition.ConditonListener.Listener.ActivityOpenListerner"),
  [CheckerTypeId.SectorStagePassTm] = require("Game.Common.CheckCondition.ConditonListener.Listener.SectorUnlockPassTimeListerner")
}

function ConditionListener:ctor()
  self.__listeningConditonDic = {}
  self.__dataListDic = {}
  self.__runningFuncDic = {}
  self.__onConditonStateChange = BindCallback(self, self.OnConditonStateChange)
  self.__removeCCLSingleConditon = BindCallback(self, self.RemoveCCLSingleConditon)
end

function ConditionListener:AddConditionChangeListener(listenerId, callback, ...)
  if self.__listeningConditonDic[listenerId] ~= nil then
    error("can't set same condition listernerId:" .. tonumber(listenerId))
    return
  end
  local conditonTypeDic, curIsUnlock = self:__AddConditionInternal(listenerId, ...)
  self.__listeningConditonDic[listenerId] = {
    callback = callback,
    conditonTypeDic = conditonTypeDic,
    curIsUnlock = curIsUnlock
  }
  self:__OnAddConditonOver(conditonTypeDic)
end

function ConditionListener:RemoveConditionChangeListener(listenerId)
  local removeConditonData = self.__listeningConditonDic[listenerId]
  self.__listeningConditonDic[listenerId] = nil
  if removeConditonData ~= nil then
    for conditonTypeId, _ in pairs(removeConditonData.conditonTypeDic) do
      if self.__dataListDic[conditonTypeId] ~= nil then
        self.__dataListDic[conditonTypeId][listenerId] = nil
        if table.count(self.__dataListDic[conditonTypeId]) < 1 then
          self.__dataListDic[conditonTypeId] = nil
          if self.__runningFuncDic[conditonTypeId] ~= nil then
            self.__runningFuncDic[conditonTypeId]:Delete()
            self.__runningFuncDic[conditonTypeId] = nil
          end
        end
      end
    end
    self:__OnAddConditonOver(removeConditonData.conditonTypeDic)
  end
end

function ConditionListener:OnConditonStateChange(updateConditonTypeId)
  local conditionDataListDic = self.__dataListDic[updateConditonTypeId]
  if conditionDataListDic ~= nil then
    for listenerId, conditionDataList in pairs(conditionDataListDic) do
      local isUnlock = true
      for index, paramGoup in ipairs(conditionDataList) do
        local conditonTypeId = paramGoup[1]
        local checker = CheckerGlobalConfig[conditonTypeId]
        local isThisConditonUnlock = checker.Checker.ParamsCheck(paramGoup)
        isUnlock = isUnlock and isThisConditonUnlock
      end
      local listenerData = self.__listeningConditonDic[listenerId]
      if listenerData.curIsUnlock ~= isUnlock then
        listenerData.curIsUnlock = isUnlock
        listenerData.callback(listenerId, isUnlock)
      end
    end
    local condition = self.__runningFuncDic[updateConditonTypeId]
    if condition ~= nil and condition.CheckOutTimeCondition ~= nil then
      condition:CheckOutTimeCondition(conditionDataListDic)
    end
  end
  self:__OnAddConditonOver({
    [updateConditonTypeId] = true
  })
end

function ConditionListener:__AddConditionInternal(listenerId, ...)
  local paramNum = select("#", ...)
  if paramNum == 0 then
    print("[CheckCondition] not args")
    return
  end
  local para1 = select(1, ...)
  local length = #para1
  for i = 2, paramNum do
    local para = select(i, ...)
    local len = #para
    if 0 < len and len ~= length then
      print("[CheckCondition] args length is different")
      return
    end
  end
  local conditonTypeDic = {}
  local curIsUnlock = true
  for i = 1, length do
    local index = 1
    local paramGoup = {}
    for paraIndex = 1, paramNum do
      local para = select(paraIndex, ...)
      if 0 < #para then
        paramGoup[index] = para[i]
        index = index + 1
      end
    end
    local conditonTypeId = paramGoup[1]
    local checker = CheckerGlobalConfig[conditonTypeId]
    if checker == nil then
      error("Checker is nil  id:" .. tostring(conditonTypeId))
      return
    end
    if not checker.Checker.LengthCheck(paramGoup) then
      error("Checker LengthCheck error id:" .. tostring(conditonTypeId))
      return
    end
    if curIsUnlock and curIsUnlock then
      curIsUnlock = checker.Checker.ParamsCheck(paramGoup)
    end
    if self.__dataListDic[conditonTypeId] == nil then
      self.__dataListDic[conditonTypeId] = {}
    end
    if self.__dataListDic[conditonTypeId][listenerId] == nil then
      self.__dataListDic[conditonTypeId][listenerId] = {}
    end
    table.insert(self.__dataListDic[conditonTypeId][listenerId], paramGoup)
    conditonTypeDic[conditonTypeId] = true
  end
  return conditonTypeDic, curIsUnlock
end

function ConditionListener:__OnAddConditonOver(conditonTypeDic)
  for conditonTypeId, _ in pairs(conditonTypeDic) do
    if self.__runningFuncDic[conditonTypeId] == nil then
      local listener = ConditionListenerDic[conditonTypeId]
      if listener ~= nil then
        self.__runningFuncDic[conditonTypeId] = listener.New()
        self.__runningFuncDic[conditonTypeId]:InitListener(self.__onConditonStateChange, self.__removeCCLSingleConditon)
      else
        error(string.format("not have conditonTypeId:%s's listener class", tostring(conditonTypeId)))
      end
    end
    local funcInstance = self.__runningFuncDic[conditonTypeId]
    local conditonDataList = self.__dataListDic[conditonTypeId]
    if conditonDataList == nil then
      return
    end
    funcInstance:AddNewCondition(conditonDataList)
  end
end

function ConditionListener:RemoveCCLSingleConditon(conditonTypeId, listenerId, index)
  local dataList = self.__dataListDic[conditonTypeId][listenerId]
  if dataList == nil then
    return
  end
  table.remove(dataList, index)
  if #dataList < 1 then
    self.__dataListDic[conditonTypeId][listenerId] = nil
    if 1 > table.count(self.__dataListDic[conditonTypeId]) then
      self.__dataListDic[conditonTypeId] = nil
      if self.__runningFuncDic[conditonTypeId] ~= nil then
        self.__runningFuncDic[conditonTypeId]:Delete()
        self.__runningFuncDic[conditonTypeId] = nil
      end
    end
  end
end

function ConditionListener:IsDuplicationKey(listenerId)
  return self.__listeningConditonDic[listenerId] ~= nil
end

function ConditionListener:Delete()
  for _, funcInstance in pairs(self.__runningFuncDic) do
    funcInstance:Delete()
  end
  self.__runningFuncDic = {}
  self.__listeningConditonDic = {}
  self.__dataListDic = {}
end

return ConditionListener
