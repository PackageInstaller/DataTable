local format = string.format
local isEditor = CS.UnityEngine.Application.isEditor
local isUseLuaBundle = CS.Z1Client.LuaBehaviour.UseBundleLua()
local TYPEOF_TMP_Text = typeof(CS.TMPro.TMP_Text)
local LangDataTableMgr = CS.LangDataTableMgr
local isUseLangCsv = CS.FrameWork.Z1Const.IsUseLangCSV and CS.FrameWork.Z1Const.IsUseLangCSV() or false
isUseLangCsv = isUseLangCsv and ApplicationUtils.IsWindowsOrEditor()
local LangTable = {}
local TextGameObjAndTimeMap = {}
local TextIdAndTimeMap = {}
local LangKeyPattern = "%a+_.+_%a+"
local LangTextTables = {}

function LangTable.Init()
end

function LangTable.ParseTextCfg(configStr)
  if not configStr then
    return
  end
  if not string.contains(configStr, "|") then
    return nil, configStr
  end
  local strArr = string.split(configStr, "|")
  if #strArr <= 0 then
    return
  end
  if 1 ~= string.find(strArr[1], LangKeyPattern) then
    return nil, configStr
  end
  return strArr[1], strArr[2]
end

local function GetTextByKeyFromCsv(key)
  local keyArr = string.split(key, "_")
  if #keyArr <= 0 then
    return
  end
  local func = keyArr[1]
  local configName = format("Text_%s", func)
  local langDataTable = LangDataTableMgr.Instance:GetTable(configName)
  if not langDataTable then
    return nil, true
  end
  do return langDataTable.GetText, langDataTable end
  return langDataTable.GetText, langDataTable, key
end

local function GetTextByKey(key, langCode)
  if not key then
    return
  end
  local currLang = langCode or DataCenter.gameData.CurrTextLanguage
  if isUseLangCsv and "JP" == currLang and LangDataTableMgr and LangDataTableMgr.Instance.IsValid then
    do return GetTextByKeyFromCsv end
    return GetTextByKeyFromCsv, key, nil, nil, nil, nil, nil, nil
  end
  if "CN" == currLang then
    return nil, true
  end
  local keyArr = string.split(key, "_")
  if #keyArr <= 0 then
    return
  end
  local func = keyArr[1]
  local configName
  if not isUseLuaBundle or isEditor then
    configName = format("Config.Text_%s.Text_%s", currLang, func)
  else
    configName = format("Text_%s.Text_%s", currLang, func)
  end
  local textConfig = LangTextTables[configName]
  if not textConfig then
    local ret, textCfg = pcall(require, configName)
    if not ret then
      return nil, true
    end
    textConfig = textCfg
  end
  LangTextTables[configName] = textConfig
  if not textConfig or not textConfig[key] then
    return nil, true
  end
  return textConfig[key] and textConfig[key].Text
end

local function IsOriginLang()
  local currLang = DataCenter.gameData.CurrTextLanguage
  local originLang = DataCenter.gameData.OriginLang
  return currLang and currLang == originLang
end

local function ReturnLangText(text, langKey)
  text = text or ""
  LangTable.InsertTextAndKey(text, langKey)
  if langKey then
    text = StrUtils.ReplacePlayerNamePlaceholder(text)
  end
  return text
end

function LangTable.Text(configStr, _, langCode)
  if not configStr then
    return ""
  end
  if langCode then
    error("LangTable.Text langCode  参数已经废弃")
  end
  if DT.LanguageConfig[configStr] and "Frenzy" ~= configStr then
    configStr = DT.LanguageConfig[configStr].CN
  end
  local key, content = LangTable.ParseTextCfg(configStr)
  if not langCode and (not key or IsOriginLang()) then
    do return ReturnLangText, content end
    return ReturnLangText, content, key, nil, nil, nil, nil
  end
  local text, noTranlate = GetTextByKey(key, langCode)
  if noTranlate and ApplicationUtils.IsEditor() and StrUtils.IsContainChinese(content) then
    Logger.Error("检测到未翻译文本:" .. content)
  end
  if text then
    do return ReturnLangText, text end
    return ReturnLangText, text, key, nil, nil
  end
  local currLang = langCode or DataCenter.gameData.CurrTextLanguage
  if isUseLangCsv and "JP" == currLang and LangDataTableMgr and LangDataTableMgr.Instance.IsValid then
    local cxt_lang = LangDataTableMgr.Instance:GetLangText(content)
    if cxt_lang then
      return ReturnLangText(cxt_lang, key), key
    end
  end
  do return ReturnLangText, content end
  return ReturnLangText, content, key, key
end

function LangTable.Textf(configStr, ...)
  local _, key
  if ApplicationUtils.is_editor_mode() or ApplicationUtils.IsWindows() then
    _, key = LangTable.ParseTextCfg(configStr)
  end
  local text = LangTable.Text(configStr) or ""
  if string.find(text, "%{s.*%}") then
    text = StrUtils.Format(text, ...)
    LangTable.InsertTextAndKey(text, key)
    return text
  end
  LangTable.InsertTextAndKey(text, key)
  return text
end

function LangTable.InsertTextAndKey(text, key)
  if not ApplicationUtils.is_editor_mode() and not ApplicationUtils.IsWindows() then
    return
  end
  if text and key then
    TextIdAndTimeMap[text] = TextIdAndTimeMap[text] or {}
    local isNew = true
    for _, v in pairs(TextIdAndTimeMap[text]) do
      if v.key == key then
        isNew = false
        v.time = TimerManager.totalTime
        break
      end
    end
    if isNew then
      table.insert(TextIdAndTimeMap[text], {
        key = key,
        time = TimerManager.totalTime
      })
    end
  end
end

function LangTable.GetComma()
  local curLang = DataCenter.gameData.CurrTextLanguage
  return curLang == CommonDefine.Lang.EN and "," or "、"
end

local DescJoinSpaceLangMap = {
  EN = true,
  PT = true,
  ES = true,
  FR = true,
  DE = true,
  IT = true,
  RU = true,
  TR = true
}

function LangTable.NeedJoinSpaceBetweenDesc()
  local curLang = DataCenter and DataCenter.gameData and DataCenter.gameData.CurrTextLanguage
  return curLang and DescJoinSpaceLangMap[curLang] or false
end

function LangTable.GetDescJoinSeparator()
  if LangTable.NeedJoinSpaceBetweenDesc() then
    return "<space=0.2em>"
  end
  return ""
end

function LangTable.JoinWesternDescSegment(desc, segment)
  if not segment or "" == segment then
    return desc or ""
  end
  desc = desc or ""
  segment = string.gsub(segment, "^[.:;。．%s]+", "")
  if "" == segment then
    return desc
  end
  if "" ~= desc then
    local lastChar = StrUtils.GetUtf8LastChar(desc)
    local secondLastChar = StrUtils.GetUtf8SecondLastChar(desc)
    if "." == lastChar or ":" == lastChar or ";" == lastChar or "。" == lastChar or "．" == lastChar then
      if " " ~= secondLastChar then
        desc = desc .. " "
      end
    elseif " " ~= lastChar then
      desc = desc .. " "
    end
  end
  return desc .. segment
end

function LangTable._RecordTextGo(textGo, text, ...)
  if textGo and text then
    local textComp = textGo:GetComponent(TYPEOF_TMP_Text)
    TextGameObjAndTimeMap[textGo] = {
      text = text,
      time = TimerManager.totalTime,
      params = {
        ...
      },
      overflow = textComp and textComp.overflowMode
    }
  end
end

LangTable.RecordTextGo = LangTable._RecordTextGo

function LangTable.CheckTextGoValid(textGo)
end

function LangTable.ShowLangKey()
  if not LangTable._binder then
    LangTable._binder = Binder.new()
  end
  
  function LangTable.RecordTextGo()
  end
  
  local cacheTable = {}
  local textExtra = {banKeywordBtn = true}
  for textGo, data in pairs(TextGameObjAndTimeMap) do
    if not IsNil(textGo) then
      if data.overflow then
        local textComp = textGo:GetComponent(TYPEOF_TMP_Text)
        textComp.overflowMode = CS.TMPro.TextOverflowModes.Overflow
      end
      local idAndTimeList = TextIdAndTimeMap[data.text] or cacheTable
      if 1 == #idAndTimeList then
        LangTable._binder:SetText(textGo, LangTable.GetShortKey(idAndTimeList[1].key), nil, nil, textExtra)
      else
        local textTime = data.time
        local bestKey
        local bestDelta = math.huge
        for _, v in ipairs(idAndTimeList) do
          local delta = math.abs(textTime - v.time)
          if bestDelta > delta then
            bestDelta = delta
            bestKey = v.key
          end
        end
        if not bestKey and #idAndTimeList > 0 then
          bestKey = idAndTimeList[1].key
        end
        if bestKey then
          LangTable._binder:SetText(textGo, LangTable.GetShortKey(bestKey), nil, nil, textExtra)
        end
      end
    end
  end
  LangTable.RecordTextGo = LangTable._RecordTextGo
end

function LangTable.GetShortKey(key)
  local shortInfo = DT.KeyShortName[key]
  return shortInfo and shortInfo.ShortName or key .. " "
end

function LangTable.ShowOrigText()
  if not LangTable._binder then
    LangTable._binder = Binder.new()
  end
  
  function LangTable.RecordTextGo()
  end
  
  for textGo, data in pairs(TextGameObjAndTimeMap) do
    if not IsNil(textGo) then
      if data.overflow then
        local textComp = textGo:GetComponent(TYPEOF_TMP_Text)
        textComp.overflowMode = data.overflow
      end
      LangTable._binder:SetText(textGo, data.text, table.unpack(data.params))
    end
  end
  LangTable.RecordTextGo = LangTable._RecordTextGo
end

function LangTable.TextEn(key)
  if not DT.LanguageConfig[key] then
    return key
  end
  local content = DT.LanguageConfig[key].en
  return content
end

function LangTable.IsSame(key1, key2)
  return LangTable.Text(key1) == LangTable.Text(key2)
end

function LangTable.ReplaceUnicodeSpace(content)
  if not content then
    return content
  end
  local startIndex, endIndex = string.find(content, "<.->", 1)
  if not startIndex or not endIndex then
    do return string.gsub, content, " " end
    return string.gsub, content, " ", " ", nil, nil, nil, nil
  end
  local beginIndex = 1
  local stringList = {}
  while startIndex and endIndex do
    local str1 = string.sub(content, beginIndex, startIndex - 1) or ""
    str1 = string.gsub(str1, " ", " ")
    table.insert(stringList, str1)
    local str2 = string.sub(content, startIndex, endIndex)
    table.insert(stringList, str2)
    beginIndex = endIndex + 1
    startIndex, endIndex = string.find(content, "<.->", endIndex + 1)
  end
  local str = string.sub(content, beginIndex, -1)
  str = string.gsub(str, " ", " ")
  table.insert(stringList, str)
  content = table.concat(stringList)
  return content
end

local function ReplaceChineseSpecialChar_TH(desc)
  local replacements = {
    [" "] = "<space=0.1em>",
    ["「"] = "<space=0.1em>\127<space=0.1em>",
    ["」"] = "<space=0.1em><space=0.1em>"
  }
  for pattern, replacement in pairs(replacements) do
    desc = string.gsub(desc, pattern, replacement)
  end
  return desc
end

local function ReplaceChineseSpecialChar(desc)
  local replacements = {
    ["「"] = "⎾",
    ["」"] = "⏌"
  }
  for pattern, replacement in pairs(replacements) do
    desc = string.gsub(desc, pattern, replacement)
  end
  return desc
end

local ChineseSpecialCharTable = {TH = ReplaceChineseSpecialChar_TH, DE = ReplaceChineseSpecialChar}

function LangTable.ReplaceSpecialChineseChar(content)
  if not LangTable.IsEndofWithChinesePeriod() then
    content = string.gsub(content, "。", ".")
    content = string.gsub(content, "：", ":")
    content = string.gsub(content, "，", ",")
    if DataCenter.gameData.CurrTextLanguage == cd.Lang.EN then
      content = string.gsub(content, "-", "–")
    else
      content = string.gsub(content, "-", "−")
    end
  end
  local currTextLanguage = DataCenter.gameData.CurrTextLanguage
  local func = currTextLanguage and ChineseSpecialCharTable[currTextLanguage] or nil
  if not func then
    return content
  end
  do return func end
  return func, content
end

function LangTable.IsEndofWithChinesePeriod()
  local currTextLanguage = DataCenter.gameData.CurrTextLanguage
  return "CN" == currTextLanguage or "TW" == currTextLanguage or "HK" == currTextLanguage or "JP" == currTextLanguage or "KR" == currTextLanguage
end

function LangTable.DescEndsWithSentencePunctuation(desc)
  if not desc or "" == desc then
    return true
  end
  local endings = {
    "。",
    ".",
    "？",
    "?",
    "！",
    "!"
  }
  for _, ending in ipairs(endings) do
    if desc:sub(-#ending) == ending then
      return true
    end
  end
  return false
end

function LangTable.EnsureDescEndsWithPeriod(desc)
  if not desc or "" == desc then
    return desc or ""
  end
  desc = string.gsub(desc, "%s+$", "")
  if LangTable.DescEndsWithSentencePunctuation(desc) then
    return desc
  end
  if LangTable.IsEndofWithChinesePeriod() then
    return desc .. "。"
  end
  return desc .. "."
end

function LangTable.PanelText(key)
  local panelTextInfo = DT.PanelText[key]
  return panelTextInfo and LT.Text(panelTextInfo.Content) or ""
end

function LangTable.TipsText(key)
  local tipsInfo = DT.TipsType[key]
  return tipsInfo and LT.Text(tipsInfo.Desc) or ""
end

return LangTable
