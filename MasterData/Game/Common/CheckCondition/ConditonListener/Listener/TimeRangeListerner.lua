local TimeRangeListerner = class("TimeRangeListerner")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local checkerTypeId = CheckerTypeId.TimeRange

function TimeRangeListerner:ctor()
  self.__checker = CheckerGlobalConfig[checkerTypeId]
  self.__latestTm = math.maxinteger
  self.__timerId = nil
end

function TimeRangeListerner:InitListener(onConditonChangeCallback, removeConditonFunc)
  self.onConditonChangeCallback = onConditonChangeCallback
  self.removeConditonFunc = removeConditonFunc
end

function TimeRangeListerner:AddNewCondition(conditonDataDic)
  self.__latestTm = math.maxinteger
  local curTimeStamp = PlayerDataCenter.timestamp
  for listenerId, conditonDataList in pairs(conditonDataDic) do
    for index = #conditonDataList, 1, -1 do
      local paramGoup = conditonDataList[index]
      local unlock = self.__checker.Checker.ParamsCheck(paramGoup)
      local startTm, endTm = self:GetConversionTime(paramGoup)
      if not unlock then
        if curTimeStamp > startTm then
        elseif startTm < self.__latestTm then
          self.__latestTm = startTm
        end
      elseif endTm < 0 then
      elseif endTm < self.__latestTm then
        self.__latestTm = endTm
      end
    end
  end
  self:StartCoditonJudge()
end

function TimeRangeListerner:GetConversionTime(paramGoup)
  return paramGoup[2], paramGoup[3]
end

function TimeRangeListerner:StartCoditonJudge()
  self:StopCoditonJudge()
  if self.__latestTm ~= nil and self.__latestTm ~= math.maxinteger then
    self.__timerId = TimerManager:StartTimer(1, function()
      if PlayerDataCenter.timestamp > self.__latestTm then
        self:StopCoditonJudge()
        self.onConditonChangeCallback(checkerTypeId)
      end
    end, self, false)
  end
end

function TimeRangeListerner:StopCoditonJudge()
  if self.__timerId ~= nil then
    TimerManager:StopTimer(self.__timerId)
    self.__timerId = nil
  end
end

function TimeRangeListerner:CheckOutTimeCondition(conditonDataDic)
  local curTimeStamp = PlayerDataCenter.timestamp
  for listenerId, conditonDataList in pairs(conditonDataDic) do
    for index = #conditonDataList, 1, -1 do
      local paramGoup = conditonDataList[index]
      local unlock = self.__checker.Checker.ParamsCheck(paramGoup)
      local startTm, endTm = self:GetConversionTime(paramGoup)
      if not unlock then
        if curTimeStamp > startTm then
          self.removeConditonFunc(checkerTypeId, listenerId, index)
        end
      elseif endTm < 0 then
        self.removeConditonFunc(checkerTypeId, listenerId, index)
      end
    end
  end
end

function TimeRangeListerner:Delete()
  self:StopCoditonJudge()
end

return TimeRangeListerner
