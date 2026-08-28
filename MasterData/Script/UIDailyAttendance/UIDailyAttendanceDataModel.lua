local DataModel = {
  NowYear = 0,
  NowMonth = -1,
  NowDay = -1,
  NowMonthSignInCount = 0,
  TotalSignInCount = 0,
  CurSelectMonth = -1,
  CurSelectDay = -1,
  RewardCfg = {},
  TotalSignRewardCfg = {},
  TotalSignDayRecord = {},
  MonthCardReward = {},
  RemainMonthCardDayCount = -1,
  AllRoleBirthRecord = {},
  CurSelectBirthDayRoleIdx = -1,
  SignInData = {},
  isAutoShow = false,
  SignType = {
    NotTime = 1,
    NoSign = 2,
    Signed = 3,
    CanSign = 4
  },
  IsPanelClosing = false
}
local MonthDayCount = {
  [1] = 31,
  [2] = 28,
  [3] = 31,
  [4] = 30,
  [5] = 31,
  [6] = 30,
  [7] = 31,
  [8] = 31,
  [9] = 30,
  [10] = 31,
  [11] = 30,
  [12] = 31
}

local function GetPositiveNumber(num)
  num = tonumber(num)
  if num and 0 < num then
    return num
  end
  return nil
end

local function AddRoleBirthRecord(month, day, info)
  month = GetPositiveNumber(month)
  day = GetPositiveNumber(day)
  if not (month and day and info) or not GetPositiveNumber(info.birthdayCake) then
    return false
  end
  if not DataModel.AllRoleBirthRecord[month] then
    DataModel.AllRoleBirthRecord[month] = {}
  end
  if not DataModel.AllRoleBirthRecord[month][day] then
    DataModel.AllRoleBirthRecord[month][day] = {}
  end
  info.birthdayCake = GetPositiveNumber(info.birthdayCake)
  table.insert(DataModel.AllRoleBirthRecord[month][day], info)
  return true
end

function DataModel.SetJsonData(json)
  local data = Json.decode(json)
  DataModel.isAutoShow = data.isAutoShow
end

function DataModel.GetNowTime()
  local lgTimeTable = TimeUtil:GetLogicServerDayTable()
  DataModel.NowYear = lgTimeTable.year
  DataModel.NowMonth = lgTimeTable.month
  DataModel.NowDay = lgTimeTable.day
end

function DataModel.InitData()
  DataModel.UpdateSignInData()
  DataModel.GetNowTime()
  DataModel.RewardCfg = {}
  DataModel.TotalSignRewardCfg = {}
  DataModel.TotalSignDayRecord = {}
  local signCfg = PlayerData:GetFactoryData("40100008")
  for i = 1, 31 do
    DataModel.RewardCfg[i] = signCfg.signList[i]
  end
  for i = 1, 3 do
    table.insert(DataModel.TotalSignRewardCfg, signCfg.totalSignList[i])
    table.insert(DataModel.TotalSignDayRecord, signCfg.totalSignList[i].date)
  end
  DataModel.MonthCardReward = {}
  local monthCardCfg = PlayerData:GetFactoryData("11400018")
  DataModel.MonthCardReward = monthCardCfg.monthList
  DataModel.GetMonthCardRemainTime()
  DataModel.AllRoleBirthRecord = {}
  local roleList = PlayerData:GetFactoryData(80900001).unitList
  for i, data in ipairs(roleList) do
    local cfg = PlayerData:GetFactoryData(data.id)
    if cfg then
      local birthdayDateRecord = {}
      local birthdayList = cfg.birthdayList or {}
      for j, birthData in ipairs(birthdayList) do
        local month = GetPositiveNumber(birthData.birthdayMonth)
        local day = GetPositiveNumber(birthData.birthdayDay)
        if AddRoleBirthRecord(month, day, {
          roleId = cfg.id,
          birthdayCake = birthData.birthdayCake,
          birthFace = birthData.birthFace,
          birthdayMessage = birthData.birthdayMessage
        }) then
          birthdayDateRecord[month .. "_" .. day] = true
        end
      end
      if cfg.birthdayCake > 0 then
        local month, day
        month = GetPositiveNumber(cfg.birthdayMonth)
        day = GetPositiveNumber(cfg.birthdayDay)
        if month and day and not birthdayDateRecord[month .. "_" .. day] then
          AddRoleBirthRecord(month, day, {
            roleId = cfg.id,
            birthdayCake = cfg.birthdayCake,
            birthFace = cfg.birthFace,
            birthdayMessage = cfg.birthdayMessage
          })
        end
      end
    end
  end
  DataModel.TotalSignInCount = 144
  DataModel.NowMonthSignInCount = DataModel.GetMonthTotalSignCount(DataModel.NowMonth)
end

function DataModel.UpdateSignInData()
  DataModel.SignInData = {}
  local signData = PlayerData.ServerData.monthly_sign
  for month, dayData in pairs(signData) do
    DataModel.SignInData[tonumber(month)] = {}
    for day, data in pairs(dayData) do
      DataModel.SignInData[tonumber(month)][tonumber(day)] = data
    end
  end
end

function DataModel.GetMonthTotalSignCount(month)
  month = month or DataModel.NowMonth
  if month > DataModel.NowMonth then
    return 0
  end
  if not DataModel.SignInData[month] then
    return 0
  end
  if DataModel.NowYear == 2024 and DataModel.NowMonth == 6 then
    return table.count(DataModel.SignInData[month]) + 12 or 12
  else
    return table.count(DataModel.SignInData[month]) or 0
  end
end

function DataModel.GetMonthCardRemainTime()
  DataModel.RemainMonthCardDayCount = -1
  if PlayerData.ServerData.monthly_card and PlayerData.ServerData.monthly_card["11400018"] then
    local diff = TimeUtil:GetMonthCardRemainTime()
    if 0 < diff then
      local time = TimeUtil:SecondToTable(diff)
      DataModel.RemainMonthCardDayCount = time.day
    end
  end
end

function DataModel.GetNowMonthSignInCount()
  return DataModel.GetMonthTotalSignCount(DataModel.NowMonth)
end

function DataModel.GetMonthDayCount(month)
  if month ~= 2 then
    return MonthDayCount[month]
  else
    local time = os.date("*t", PlayerData.ServerData.server_now)
    if time.year % 4 == 0 and time.year % 100 ~= 0 or time.year % 100 == 0 and time.year % 400 == 0 then
      return 29
    else
      return 28
    end
  end
end

function DataModel.GetDaySignType()
  local isYesterday = TimeUtil:IsLogicYesterday()
  local selectDayTimeStamp = os.time({
    year = DataModel.NowYear,
    month = DataModel.CurSelectMonth,
    day = DataModel.CurSelectDay,
    hour = 5,
    min = 0,
    sec = 0
  }) + TimeUtil:GetLocalTimeZone() * 3600
  local curDayStamp = TimeUtil:GetFutureTimeStampByUTC(isYesterday and -1 or 0, 5)
  if selectDayTimeStamp > curDayStamp then
    return DataModel.SignType.NotTime
  elseif selectDayTimeStamp < curDayStamp then
    return DataModel.GetDayDailyIsSigned() and DataModel.SignType.Signed or DataModel.SignType.NoSign
  else
    return DataModel.GetDayDailyIsSigned() and DataModel.SignType.Signed or DataModel.SignType.CanSign
  end
end

function DataModel.GetRemainMonthCardDayCount()
  if DataModel.RemainMonthCardDayCount < 0 then
    return -1
  end
  local isYesterday = TimeUtil:IsLogicYesterday()
  local selectDayTimeStamp = os.time({
    year = DataModel.NowYear,
    month = DataModel.CurSelectMonth,
    day = DataModel.CurSelectDay,
    hour = 5,
    min = 0,
    sec = 0
  }) + TimeUtil:GetLocalTimeZone() * 3600
  local curDayStamp = TimeUtil:GetFutureTimeStampByUTC(isYesterday and -1 or 0, 5, 0, 0)
  local deltaTime = selectDayTimeStamp - curDayStamp
  if deltaTime < 0 then
    return -1
  end
  local deltaDay = TimeUtil:SecondToTable(deltaTime).day or 0
  return DataModel.RemainMonthCardDayCount - deltaDay
end

function DataModel.GetDayDailyIsSigned(month, day)
  month = month or DataModel.CurSelectMonth
  day = day or DataModel.CurSelectDay
  if not DataModel.SignInData[month] then
    return false
  end
  if not DataModel.SignInData[month][day] then
    return false
  end
  return DataModel.SignInData[month][day].day
end

function DataModel.GetDayMonthIsSigned(month, day)
  month = month or DataModel.CurSelectMonth
  day = day or DataModel.CurSelectDay
  if not DataModel.SignInData[month] then
    return false
  end
  if not DataModel.SignInData[month][day] then
    return false
  end
  return DataModel.SignInData[month][day].m_card
end

function DataModel.GetTotalSignInCount()
  return DataModel.TotalSignInCount
end

function DataModel.CheckHaveRoleBirthday(month, day)
  month = month or DataModel.CurSelectMonth
  day = day or DataModel.CurSelectDay
  if DataModel.AllRoleBirthRecord[month] == nil then
    return false
  end
  if DataModel.AllRoleBirthRecord[month][day] == nil then
    return false
  end
  return table.count(DataModel.AllRoleBirthRecord[month][day]) > 0
end

function DataModel.GetRoleBirthdayList(month, day)
  month = month or DataModel.CurSelectMonth
  day = day or DataModel.CurSelectDay
  if DataModel.CheckHaveRoleBirthday(month, day) then
    return DataModel.AllRoleBirthRecord[month][day] or {}
  end
  return {}
end

function DataModel.GetRoleBirthdayIdList(month, day)
  local birthList = DataModel.GetRoleBirthdayList(month, day)
  local roleIdList = {}
  for i, birthData in ipairs(birthList) do
    local roleId = type(birthData) == "table" and birthData.roleId or birthData
    if roleId then
      table.insert(roleIdList, tostring(roleId))
    end
  end
  return roleIdList
end

function DataModel.IsSelectedFuture()
  local isYesterday = TimeUtil:IsLogicYesterday()
  local selectDayTimeStamp = os.time({
    year = DataModel.NowYear,
    month = DataModel.CurSelectMonth,
    day = DataModel.CurSelectDay,
    hour = 5,
    min = 0,
    sec = 0
  }) + TimeUtil:GetLocalTimeZone() * 3600
  local curDayStamp = TimeUtil:GetFutureTimeStampByUTC(isYesterday and -1 or 0, 5)
  return selectDayTimeStamp > curDayStamp
end

function DataModel.GetRedState()
  local timeTable = TimeUtil:GetLogicServerDayTable()
  local month = timeTable.month
  local day = timeTable.day
  local isDaySigned = true
  if not PlayerData.ServerData.monthly_sign then
    PlayerData.ServerData.monthly_sign = {}
  end
  if not PlayerData.ServerData.monthly_sign[tostring(month)] or not PlayerData.ServerData.monthly_sign[tostring(month)][tostring(day)] then
    isDaySigned = false
  else
    isDaySigned = PlayerData.ServerData.monthly_sign[tostring(month)][tostring(day)].day
  end
  return not isDaySigned
end

return DataModel
