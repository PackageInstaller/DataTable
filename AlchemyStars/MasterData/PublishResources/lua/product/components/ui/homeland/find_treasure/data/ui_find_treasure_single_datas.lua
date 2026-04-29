_class("UIFindTreasureSingleData", Object)
UIFindTreasureSingleData = UIFindTreasureSingleData

function UIFindTreasureSingleData:Constructor(singleId, isSpecial, count)
  self._singleId = singleId
  self._isSpecialSingle = isSpecial
  self._count = count
end

function UIFindTreasureSingleData:GetSingleId()
  return self._singleId
end

function UIFindTreasureSingleData:IsSpecialSingle()
  return self._isSpecialSingle
end

function UIFindTreasureSingleData:GetCount()
  return self._count
end

_class("UIFindTreasureSingleDatas", Object)
UIFindTreasureSingleDatas = UIFindTreasureSingleDatas

function UIFindTreasureSingleDatas:Constructor(singleId)
  self._cfg = self:GetCfg()
  local primaryCount, seniorCount = HomelandFindTreasureConst.GetSingleCount()
  local primaryId = self._cfg.PrimaryEquipID
  self._normalSingleData = UIFindTreasureSingleData:New(primaryId, false, primaryCount)
  local seniorId = self._cfg.SeniorEquipID
  self._specialSingleData = UIFindTreasureSingleData:New(seniorId, true, seniorCount)
end

function UIFindTreasureSingleDatas:GetCfg()
  return HomelandFindTreasureConst.GetSingleCfg()
end

function UIFindTreasureSingleDatas:GetNormalSingleCount()
  return self._normalSingleData:GetCount()
end

function UIFindTreasureSingleDatas:GetSpecialSingleCount()
  return self._specialSingleData:GetCount()
end

function UIFindTreasureSingleDatas:GetCanUseSingleData()
  if self._specialSingleData:GetCount() > 0 then
    return self._specialSingleData
  end
  if 0 < self._normalSingleData:GetCount() then
    return self._normalSingleData
  end
  return nil
end

function UIFindTreasureSingleDatas:GetMaxNormalSingleCount()
  return self._cfg.PrimaryEquipMaxNum
end

function UIFindTreasureSingleDatas:GetMaxSpecialSingleCount()
  return self._cfg.SeniorEquipMaxNum
end

function UIFindTreasureSingleDatas:GetNextSingleTime()
  return HomelandFindTreasureConst.GetNextSingleTime()
end

function UIFindTreasureSingleDatas:IsSingleFull()
  if HomelandFindTreasureConst.IsGameActivityEnd() then
    return true
  end
  return self._specialSingleData:GetCount() >= self:GetMaxSpecialSingleCount() and self._normalSingleData:GetCount() >= self:GetMaxNormalSingleCount()
end

function UIFindTreasureSingleDatas:GetSingleTimeStr()
  if self:IsSingleFull() then
    return StringTable.Get("str_homeland_find_treasure_single_full_tips")
  end
  local time, moreThanDay = self:GetNextSingleTime()
  return self:GetTimeStr(time, moreThanDay)
end

function UIFindTreasureSingleDatas:GetTimeStr(seconds, moreThanDay)
  if seconds < 0 then
    seconds = 0
  end
  local timeStr = ""
  local day = math.floor(seconds / 3600 / 24)
  local leftStr = ""
  if moreThanDay then
    leftStr = "str_homeland_find_treasure_time_tips"
  else
    leftStr = "str_homeland_find_treasure_time_oneday_tips"
  end
  if 0 < day then
    seconds = seconds - day * 3600 * 24
    local hour = math.floor(seconds / 3600)
    timeStr = StringTable.Get("str_homeland_find_treasure_day", day)
    if 0 < hour then
      timeStr = timeStr .. StringTable.Get("str_homeland_find_treasure_hour", hour)
    end
  elseif 60 <= seconds then
    local hour = math.floor(seconds / 3600)
    seconds = seconds - hour * 3600
    if 0 < hour then
      timeStr = StringTable.Get("str_homeland_find_treasure_hour", hour)
    end
    local minus = math.floor(seconds / 60)
    if 0 < minus then
      timeStr = timeStr .. StringTable.Get("str_homeland_find_treasure_minus", minus)
    elseif minus <= 0 then
      timeStr = timeStr .. StringTable.Get("str_homeland_find_treasure_less_one_minus")
    end
  else
    timeStr = StringTable.Get("str_homeland_find_treasure_less_one_minus")
  end
  return StringTable.Get(leftStr, timeStr)
end
