_class("UIS4TradeHelper", Object)
UIS4TradeHelper = UIS4TradeHelper

function UIS4TradeHelper.ChooseOption(optionDataTb)
  for _, optionData in pairs(optionDataTb) do
    local randomNum = math.random(0, 100)
    local success = randomNum < optionData.percent
    optionData.isSuccess = success
  end
  return optionDataTb
end

function UIS4TradeHelper.GetTradeOptionData(optionID, index)
  local optionCfg = Cfg.cfg_component_business_option[optionID]
  local valueType, value, percent = 0, 0, 0
  if optionCfg.Boatload ~= 0 then
    valueType = 1
    value = optionCfg.Boatload
    percent = optionCfg.Odds
  else
    for i, v in pairs(optionCfg.ProValue) do
      if v ~= 0 then
        valueType = i + 1
        value = v
        percent = optionCfg.Odds
        break
      end
    end
  end
  local optionData = TradeOptionData:New(optionID, valueType, value, percent, index)
  return optionData
end

function UIS4TradeHelper.GetRemainTime(time)
  local day, hour, minute
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  local timestring = ""
  if 0 < day then
    timestring = day .. StringTable.Get("str_activity_common_day") .. hour .. StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    timestring = hour .. StringTable.Get("str_activity_common_hour") .. minute .. StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    timestring = minute .. StringTable.Get("str_activity_common_minute")
  else
    timestring = StringTable.Get("str_activity_common_less_minute")
  end
  return string.format(StringTable.Get("str_activity_common_over"), timestring)
end
