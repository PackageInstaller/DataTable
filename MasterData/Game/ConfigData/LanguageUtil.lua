LanguageUtil = {}

function LanguageUtil.GetLocaleText(idx)
  if type(idx) ~= "number" then
    return idx
  end
  return ConfigData.locale_text[idx]
end

local defaultLanguageRule = {unitStr = 147, num = 10000}
local unitRule = {
  [eLanguageType.EN_US] = {unitStr = 147, num = 1000}
}
local textWriterSpeed = {
  [eLanguageType.ZH_CN] = 1,
  [eLanguageType.ZH_TW] = 1,
  [eLanguageType.EN_US] = 1.5,
  [eLanguageType.JA_JP] = 1,
  [eLanguageType.KO_KR] = 1
}

function LanguageUtil.GetWriterSpeed()
  local languageInt = LanguageUtil.LanguageInt
  local speed = textWriterSpeed[languageInt] or 1
  return speed
end

function LanguageUtil.GetNum2UnitStr(num, n)
  local finStr = ""
  local float
  local languageInt = LanguageUtil.LanguageInt
  local rule = unitRule[languageInt]
  if rule == nil then
    rule = defaultLanguageRule
  end
  if num >= rule.num then
    float = GetPreciseDecimalStr(num / rule.num, n)
    finStr = float .. ConfigData:GetTipContent(rule.unitStr)
  else
    finStr = tostring(num)
  end
  return tostring(finStr)
end

local RomanNumber = {
  "I",
  "II",
  "III",
  "IV",
  "V",
  "VI",
  "VII",
  "VIII",
  "IX",
  "X"
}

function LanguageUtil.GetRomanNumber(number)
  return RomanNumber[number] or tostring(number)
end

if IsInVerify then
  LanguageUtil.LanguageInt = 0
  IsInVerify = nil
else
  LanguageUtil.LanguageInt = CS.LanguageGlobal.GetLanguageInt()
end
