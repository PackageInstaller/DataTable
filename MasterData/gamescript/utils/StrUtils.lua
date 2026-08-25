local TYPEOF_TMP_Text = typeof(CS.TMPro.TMP_Text)
local TempVector2 = CS.UnityEngine.Vector2(0, 0)
local StrUtils = System.NewClass("StrUtils")
StrUtils.prefixSymbolFuncMap = {
  ["$"] = function(str)
    do return string.format("%.2f", tonumber(str) * 100):gsub("%.?0+$", "").gsub, string.format("%.2f", tonumber(str) * 100):gsub("%.?0+$", ""), "%.$" end
    return string.format("%.2f", tonumber(str) * 100):gsub("%.?0+$", "").gsub, string.format("%.2f", tonumber(str) * 100):gsub("%.?0+$", ""), "%.$", ""
  end
}
StrUtils.WordsEffectType = {
  Color = {tag = "color", needValue = true},
  Link = {tag = "link", needValue = true},
  SkillLink = {tag = "link", needValue = true},
  StateLink = {tag = "link", needValue = true},
  Bold = {tag = "b", needValue = false},
  Italic = {tag = "i", needValue = false},
  Size = {tag = "size", needValue = true},
  Img = {tag = "sprite"},
  DelLine = {tag = "s", needValue = false},
  Shake = {tag = "shake", needValue = false}
}
StrUtils.RomeNumer = {
  [0] = "O",
  [1] = "I",
  [2] = "II",
  [3] = "III",
  [4] = "IV",
  [5] = "V",
  [6] = "VI",
  [7] = "VII",
  [8] = "VIII",
  [9] = "IX",
  [10] = "X"
}
local LangVideoPathMap = {
  TW = {
    ["Logo/Video_Logo_Rgb.mp4"] = "Logo/Video_Logo_Rgb_TW.mp4",
    ["Logo/Video_Logo_Alpha.mp4"] = "Logo/Video_Logo_Alpha_TW.mp4",
    ["Logo/Video_Logo_Rgb2.mp4"] = "Logo/Video_Logo_Rgb2_TW.mp4",
    ["Logo/Video_Logo_Alpha2.mp4"] = "Logo/Video_Logo_Alpha2_TW.mp4"
  },
  HK = {
    ["Logo/Video_Logo_Rgb.mp4"] = "Logo/Video_Logo_Rgb_TW.mp4",
    ["Logo/Video_Logo_Alpha.mp4"] = "Logo/Video_Logo_Alpha_TW.mp4",
    ["Logo/Video_Logo_Rgb2.mp4"] = "Logo/Video_Logo_Rgb2_TW.mp4",
    ["Logo/Video_Logo_Alpha2.mp4"] = "Logo/Video_Logo_Alpha2_TW.mp4"
  },
  EN = {
    ["Logo/Video_Logo_Rgb.mp4"] = "Logo/Video_Logo_Rgb_ENG.mp4",
    ["Logo/Video_Logo_Alpha.mp4"] = "Logo/Video_Logo_Alpha_ENG.mp4",
    ["Logo/Video_Logo_Rgb2.mp4"] = "Logo/Video_Logo_Rgb2_ENG.mp4",
    ["Logo/Video_Logo_Alpha2.mp4"] = "Logo/Video_Logo_Alpha2_ENG.mp4"
  }
}

function StrUtils.ReplacePlayerNamePlaceholder(str)
  if not str or "" == str then
    return str
  end
  local playerNamePattern = "%player%"
  if string.find(str, playerNamePattern, 0, true) then
    local DataCenter = require("Data.DataCenter")
    local playerName = DataCenter.playerData.DRole.name or "玩家-未登录"
    if playerName then
      str = string.replace(str, playerNamePattern, playerName, true)
    end
  end
  return str
end

function StrUtils.ReplaceAvgContent(str, isReplaceChange)
  str = LT.Text(str)
  str = StrUtils.ReplaceAvgGenderWord(str)
  isReplaceChange = nil == isReplaceChange and true
  if isReplaceChange then
    str = string.replace(str, "<Change>", "", true)
  end
  local erosionEmojCount = 4
  for i = 1, erosionEmojCount do
    local searchColorPattern = string.format("@%d", i) .. "<(%w+%.%w+)>"
    local colorKeyPairs = string.match(str, searchColorPattern)
    local colorTag
    local emojPattern = string.format("@%d", i)
    local emojReplace = string.format("<sprite=\"UI_Story_Confuse_%s\" index=0>", i)
    if colorKeyPairs then
      local colorInfoArr = string.split(colorKeyPairs, ".")
      if colorInfoArr and colorInfoArr[1] then
        local colorTid = colorInfoArr[1]
        local colorType = colorInfoArr[2] or CommonDefine.ColorType.Normal
        local colorHexCode = ColorUtils.GetColorHexCode(colorTid, colorType)
        colorTag = string.format("color=%s", colorHexCode)
        emojPattern = string.format("%s<%s>", emojPattern, colorKeyPairs)
        emojReplace = string.format("<sprite=\"UI_Story_Confuse_%s\" index=0 %s>", i, colorTag)
      end
    end
    str = string.replace(str, emojPattern, emojReplace, true)
  end
  return str
end

StrUtils.AppellationPattern = {
  ["%heorshe%"] = "heorshe",
  ["%himorher%"] = "himorher",
  ["%hisorher%"] = "hisorher",
  ["%brotherorsister1%"] = "brotherorsister1",
  ["%brotherorsister2%"] = "brotherorsister2",
  ["%sirormadam%"] = "sirormadam",
  ["%lordorlady%"] = "lordorlady",
  ["{Male=(.-)%s*,%s*Female=(.-)}"] = function(maleStr, femaleStr)
    return PlayerDataUtils.IsMale() and maleStr or femaleStr
  end
}

function StrUtils.ReplaceAvgGenderWord(str)
  local LT = require("System.LangTable")
  local GenderDataUtils = require("Data.GenderDataUtils")
  local genderItem = GenderDataUtils.GetGenderCfgByRoleData()
  genderItem = nil ~= genderItem and genderItem or GenderDataUtils.GetGenderCfgByKey(CommonDefine.GenderID.Boy)
  for pattern, replaceStr in pairs(StrUtils.AppellationPattern) do
    if type(replaceStr) == "function" then
      str = string.gsub(str, pattern, replaceStr)
    elseif string.find(str, pattern, 0, true) then
      local langkey = genderItem[replaceStr]
      str = string.replace(str, pattern, LT.Text(langkey), true)
    end
  end
  return str
end

local effectLinkGroup = {"StateLink", "SkillLink"}

function StrUtils.CheckContainsEffectLink(str)
  if not str or "" == str then
    return false
  end
  for _, linkName in pairs(effectLinkGroup) do
    if string.contains(str, linkName) then
      return true
    end
  end
  for richKey, _ in StrUtils.GmatchWordsEffectTag(str) do
    if StrUtils.IsWordsEffectStateOrSkillKeywordKey(richKey) then
      return true
    end
  end
  return false
end

function StrUtils.Format(str, ...)
  if not str or "" == str then
    return
  end
  local argsNum = select("#", ...)
  if argsNum <= 0 then
    return str
  end
  for i = 1, argsNum do
    local arg = select(i, ...)
    if type(arg) == "string" then
      arg = LT.Text(arg)
    end
    local replaceStr = "%{s" .. i .. "%}"
    if string.find(arg, "%%") then
      arg = string.gsub(arg, "%%", "%%%%")
    end
    str = string.gsub(str, replaceStr, arg)
  end
  return str
end

function StrUtils.RemoveRichEffect(str)
  local pattern = "<(.-):(.-)>"
  local replacement = "%2"
  local result = string.gsub(str, pattern, replacement)
  return result
end

function StrUtils.RestoreSpaceTag(text)
  local result = text
  local space_tags = {}
  local searchFrom = 1
  while true do
    local startIdx, endIdx, val = string.find(result, "<space=([%w%.%-]+)>", searchFrom)
    if not startIdx then
      break
    end
    table.insert(space_tags, {
      index = startIdx,
      value = val,
      tag = "<space=" .. val .. ">"
    })
    searchFrom = endIdx + 1
  end
  local cleared = StrUtils.RemoveRichEffect(text)
  if 0 == #space_tags then
    return cleared
  end
  local PH = "\001\016__SPC__\017"
  local replaced = text
  for _, info in ipairs(space_tags) do
    replaced = replaced:gsub("<space=" .. info.value .. ">", PH .. info.value .. PH, 1)
  end
  local removed = StrUtils.RemoveRichEffect(replaced)
  local restore_pattern = PH .. "([%w%.%-]+)" .. PH
  local restored = removed:gsub(restore_pattern, function(spcval)
    return "<space=" .. spcval .. ">"
  end)
  return restored
end

function StrUtils.ClearRichText(str)
  local reg = "(<.-:)"
  for effect in string.gmatch(str, reg) do
    str = string.replace(str, effect, "")
    str = string.gsub(str, ">", "", 1)
  end
  return str
end

function StrUtils.RemoveAvgHtmlTag(input)
  input = input:gsub("<color=[^>]+>", "")
  input = input:gsub("</color>", "")
  return input
end

function StrUtils.DumpStringBytes(str, maxLen)
  if not str then
    return "nil"
  end
  local limit = math.min(#str, maxLen or 64)
  local parts = {}
  for i = 1, limit do
    parts[#parts + 1] = string.format("%02X", string.byte(str, i))
  end
  if limit < #str then
    parts[#parts + 1] = "..."
  end
  do return table.concat, parts end
  return table.concat, parts, " ", nil, #parts + 1, string.format("%02X", string.byte(str, i)), "%02X", string.byte(str, i)
end

function StrUtils.GetUtf8LastChar(str)
  if not str or "" == str then
    return ""
  end
  local start = utf8.offset(str, -1)
  if not start then
    return ""
  end
  do return string.sub, str end
  return string.sub, str, start
end

function StrUtils.GetUtf8CharBeforeByteIndex(str, byteIndex)
  if not (str and byteIndex) or byteIndex <= 1 then
    return ""
  end
  local charStart = utf8.offset(str, -1, byteIndex)
  if not charStart then
    return ""
  end
  do return string.sub, str, charStart end
  return string.sub, str, charStart, byteIndex - 1
end

function StrUtils.GetUtf8SecondLastChar(str)
  if not str or "" == str then
    return ""
  end
  local lastStart = utf8.offset(str, -1)
  if not lastStart or lastStart <= 1 then
    return ""
  end
  do return StrUtils.GetUtf8CharBeforeByteIndex, str end
  return StrUtils.GetUtf8CharBeforeByteIndex, str, lastStart
end

function StrUtils.ToWesternNoBreakNameText(text)
  if not text or "" == text or not LangTable.NeedJoinSpaceBetweenDesc() then
    return text or ""
  end
  if string.find(text, "<", 1, true) then
    return text
  end
  do return string.gsub, text, " " end
  return string.gsub, text, " ", " ", true
end

function StrUtils.ReplaceWesternParamBoundarySpace(desc, value)
  if not desc or "" == desc or not LangTable.NeedJoinSpaceBetweenDesc() then
    return desc
  end
  local valueStr = tostring(value or "")
  if "" == valueStr then
    return desc
  end
  local escapedValue = string.gsub(valueStr, "([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
  local nbsp = " "
  local result = desc
  result = string.gsub(result, " " .. escapedValue .. " ", nbsp .. valueStr .. nbsp)
  result = string.gsub(result, " " .. escapedValue .. "([%.,:;%)%]%}%?!])", nbsp .. valueStr .. "%1")
  result = string.gsub(result, "([%(%[%{])" .. escapedValue .. " ", "%1" .. valueStr .. nbsp)
  result = string.gsub(result, "([%+%-]?%d+)%(%s*([%+%-]?%d+/%d+)%s*%)", "<nobr>%1(%2)</nobr>")
  return result
end

function StrUtils.CleanupWesternDescText(str)
  if not str or "" == str or not LangTable.NeedJoinSpaceBetweenDesc() then
    return str
  end
  str = string.gsub(str, "%s*<DerivativeCardKeywords_%d+:%s*>", "")
  str = string.gsub(str, "%.%s*,%s*", ". ")
  str = string.gsub(str, "%s+$", "")
  return str
end

function StrUtils.IsWordsEffectStateOrSkillKeywordKey(configKey)
  local cfg = configKey and DT.WordsEffectConfig[configKey]
  if not cfg then
    return false
  end
  local stateLink = cfg.StateLink
  local skillLink = cfg.SkillLink
  if stateLink and 0 ~= stateLink and "" ~= stateLink then
    return true
  end
  if skillLink and 0 ~= skillLink and "" ~= skillLink then
    return true
  end
  return false
end

local function CollapseRepeatedPeriods(input)
  if not string.find(input, ".", 1, true) and not string.find(input, "。", 1, true) and not string.find(input, "．", 1, true) then
    return input
  end
  local result = {}
  local chars = {}
  for _, code in utf8.codes(input) do
    table.insert(chars, utf8.char(code))
  end
  local periodSet = {
    ["."] = true,
    ["。"] = true,
    ["．"] = true
  }
  local i = 1
  local charCount = #chars
  while i <= charCount do
    local c = chars[i]
    if periodSet[c] then
      local startIdx = i
      local periodCount = 1
      local j = i + 1
      while charCount >= j do
        local nextC = chars[j]
        if periodSet[nextC] then
          periodCount = periodCount + 1
          j = j + 1
        elseif nextC:match("%s") then
          local k = j + 1
          while charCount >= k and chars[k]:match("%s") do
            k = k + 1
          end
          if charCount >= k and periodSet[chars[k]] then
            periodCount = periodCount + 1
            j = k + 1
          else
            break
          end
        else
          break
        end
      end
      if periodCount >= 3 then
        for k = startIdx, j - 1 do
          table.insert(result, chars[k])
        end
      elseif periodCount >= 2 then
        table.insert(result, ". ")
      else
        table.insert(result, c)
      end
      if periodCount >= 2 then
        local k = j
        while charCount >= k and chars[k]:match("%s") do
          k = k + 1
        end
        if charCount >= k and "<" == chars[k] then
          i = k
        else
          i = j
        end
      else
        i = i + 1
      end
    else
      table.insert(result, c)
      i = i + 1
    end
  end
  do return table.concat end
  return table.concat, result, result, c, k + 1, chars[k], chars[k], "%s", table.insert, result, chars[k]
end

function StrUtils.EnsureWesternSpaceAfterPeriodBeforeKeyword(str)
  if not str or "" == str or not LangTable.NeedJoinSpaceBetweenDesc() then
    return str
  end
  str = CollapseRepeatedPeriods(str)
  local punctSet = {
    ["."] = true,
    [":"] = true,
    [";"] = true,
    ["。"] = true,
    ["．"] = true
  }
  local result = str
  local index = 1
  while index <= #result do
    local startIndex, endIndex = StrUtils.FindNextWordEffectTag(result, index)
    if not startIndex then
      break
    end
    if startIndex > 1 then
      local prevChar = StrUtils.GetUtf8CharBeforeByteIndex(result, startIndex)
      if punctSet[prevChar] and result:sub(startIndex, startIndex) ~= " " then
        local effectStr = result:sub(startIndex + 1, endIndex - 1)
        local richKey = string.match(effectStr, "^([%w_]+):")
        if StrUtils.IsWordsEffectStateOrSkillKeywordKey(richKey) then
          result = result:sub(1, startIndex - 1) .. " " .. result:sub(startIndex)
          endIndex = endIndex + 1
        end
      end
    end
    index = endIndex + 1
  end
  return result
end

function StrUtils.SetWordEffectStr(str, parseWordEffectFunc)
  str = str or ""
  str = StrUtils.EnsureWesternSpaceAfterPeriodBeforeKeyword(str)
  if string.find(str, "%%", 0, true) then
    str = string.gsub(str, "%%%%", "%%")
  end
  local index = 1
  if not string.find(str, "<", 0, true) or not string.find(str, ">", 0, true) then
    return str
  end
  local wordsEffectConfig = DT.WordsEffectConfig
  local startIndex, endIndex = StrUtils.FindNextWordEffectTag(str, index)
  while startIndex do
    local effect = string.sub(str, startIndex, endIndex)
    local effectStr = string.match(effect, "%<(.+)>")
    local nextIndex = endIndex + 1
    if effectStr then
      local strArr = string.split(effectStr, ":")
      local configKey, text = strArr[1], strArr[2]
      if #strArr > 2 then
        for i = 3, #strArr do
          text = text .. ":" .. strArr[i]
        end
      end
      local innerText = text or ""
      if string.find(innerText, "<", 1, true) and string.find(innerText, ">", 1, true) then
        innerText = StrUtils.SetWordEffectStr(innerText, parseWordEffectFunc)
      end
      local richText
      local needReplace = false
      if configKey == CommonDefine.AwakerName then
        local tid = tonumber(innerText)
        if tid then
          richText = AwakerDataUtils.GetAwakerName(tid) or ""
          needReplace = true
        end
      elseif wordsEffectConfig[configKey] then
        local okRich
        okRich, richText = pcall(StrUtils.GetWordsEffectRichText, configKey, innerText, parseWordEffectFunc)
        if not okRich or "string" ~= type(richText) then
          Logger.Warn("StrUtils.SetWordEffectStr GetWordsEffectRichText failed key=%s err=%s", tostring(configKey), tostring(richText))
          richText = effect
        end
        needReplace = true
      end
      if needReplace then
        local prefixStr = string.sub(str, 1, startIndex - 1)
        local suffixStr = string.sub(str, endIndex + 1, #str)
        str = string.format("%s%s%s", prefixStr, richText, suffixStr)
        nextIndex = startIndex + #richText
      end
    end
    startIndex, endIndex = StrUtils.FindNextWordEffectTag(str, nextIndex)
  end
  do return StrUtils.CleanupWesternDescText end
  return StrUtils.CleanupWesternDescText, str, startIndex + #richText, StrUtils.FindNextWordEffectTag(str, nextIndex)
end

function StrUtils.FindNextWordEffectTag(str, index)
  local searchIndex = index or 1
  while searchIndex <= #str do
    local startIndex = string.find(str, "<", searchIndex, true)
    if not startIndex then
      return nil, nil
    end
    local balancedStart, balancedEnd = string.find(str, "%b<>", startIndex)
    if not balancedEnd then
      Logger.Warn("StrUtils.FindNextWordEffectTag skip unclosed tag str=%s startIndex=%s", tostring(str), tostring(startIndex))
      return nil, nil
    end
    if balancedStart == startIndex then
      return startIndex, balancedEnd
    end
    searchIndex = startIndex + 1
  end
  return nil, nil
end

function StrUtils.GmatchWordsEffectTag(str)
  local index = 1
  return function()
    if not str or "" == str then
      return nil
    end
    local startIndex, endIndex = StrUtils.FindNextWordEffectTag(str, index)
    while startIndex do
      local effectStr = string.sub(str, startIndex + 1, endIndex - 1)
      index = endIndex + 1
      local richKey, id = string.match(effectStr, "^([%w_]+):(.*)$")
      if richKey then
        return richKey, id
      end
      startIndex, endIndex = StrUtils.FindNextWordEffectTag(str, index)
    end
    return nil
  end
end

function StrUtils.SafeSetWordEffectStr(str, parseWordEffectFunc)
  local rawStr = str or ""
  local ok, result = pcall(StrUtils.SetWordEffectStr, rawStr, parseWordEffectFunc)
  if ok and type(result) == "string" then
    return result
  end
  Logger.Warn("StrUtils.SafeSetWordEffectStr failed str=%s err=%s", tostring(rawStr), tostring(result))
  return rawStr
end

function StrUtils.ToHtmlStringRGB(color)
  local r = math.max(math.min(255, math.floor(color.r * 255 + 0.5)), 0)
  local g = math.max(math.min(255, math.floor(color.g * 255 + 0.5)), 0)
  local b = math.max(math.min(255, math.floor(color.b * 255 + 0.5)), 0)
  do return string.format, "%02X%02X%02X", r, g end
  return string.format, "%02X%02X%02X", r, g, b
end

function StrUtils.GetConfuseText(textGo, showStr)
  if not textGo then
    do return StrUtils.Fix2ConfuseText end
    return StrUtils.Fix2ConfuseText, showStr, nil, nil, nil
  end
  local textComp = StrUtils.GetTextComp(textGo)
  local colorHex = string.format("color=#%s", StrUtils.ToHtmlStringRGB(textComp.color))
  do return StrUtils.Fix2ConfuseText, showStr end
  return StrUtils.Fix2ConfuseText, showStr, colorHex
end

function StrUtils.GetTextComp(owner)
  return owner:GetComponent(typeof(CS.TMPro.TMP_Text)) or owner:GetComponent(typeof(CS.UnityEngine.UI.Text))
end

function StrUtils.Fix2ConfuseText(str, colorHex)
  str = str or ""
  if string.find(str, "%%", 0, true) then
    str = string.gsub(str, "%%%%", "%%")
  end
  local index = 1
  if not string.find(str, "<", 0, true) or not string.find(str, ">", 0, true) then
    local cnt, strConcat = StrUtils.GetStringLength(str)
    do return StrUtils.ReplaceConfuse_TMP, cnt, colorHex end
    return StrUtils.ReplaceConfuse_TMP, cnt, colorHex, strConcat, nil, nil, nil, nil, nil, nil, nil
  end
  local startIndex, endIndex = string.find(str, "%b<>", index)
  while startIndex do
    index = startIndex + 1
    local effect = string.sub(str, startIndex, endIndex)
    local effectStr = string.match(effect, "%<(.+)>")
    if not effectStr then
      startIndex, endIndex = string.find(str, "%b<>", index)
    else
      local strArr = string.split(effectStr, ":")
      local text = strArr[2]
      if #strArr > 2 then
        for i = 3, #strArr do
          text = text .. ":" .. strArr[i]
        end
      end
      if nil == text then
        text = ""
      end
      str = string.gsub(str, effect, text)
      startIndex, endIndex = string.find(str, "%b<>", index)
    end
  end
  local cnt, strConcat = StrUtils.GetStringLength(str)
  do return StrUtils.ReplaceConfuse_TMP, cnt, colorHex end
  return StrUtils.ReplaceConfuse_TMP, cnt, colorHex, strConcat, "%b<>", index, text .. ":" .. strArr[i], ":", strArr[i]
end

StrUtils.ConfuseTMP = {s = "@5", n = "@7"}

function StrUtils.ReplaceConfuse_TMP(cnt, colorHex, strConcat)
  if cnt <= 0 then
    return ""
  end
  colorHex = colorHex or ""
  local newStr = ""
  for i = 1, cnt do
    local sFigure = string.sub(strConcat, i, i)
    newStr = string.format("%s%s", newStr, StrUtils.ConfuseTMP[sFigure])
  end
  for _, value in pairs(StrUtils.ConfuseTMP) do
    local key = string.gsub(value, "@", "")
    local emojReplace = string.format("<sprite=\"UI_Story_Confuse_%s\" index=0 %s>", key, colorHex)
    newStr = string.replace(newStr, value, emojReplace, true)
  end
  return newStr
end

function StrUtils.GetStringLength(inputstr)
  if not inputstr or type(inputstr) ~= "string" or #inputstr <= 0 then
    return 0
  end
  local length = 0
  local i = 1
  local strConcat = ""
  while true do
    local curByte = string.byte(inputstr, i)
    local byteCount = 1
    if curByte > 239 then
      byteCount = 4
      strConcat = strConcat .. "s"
    elseif curByte > 223 then
      byteCount = 3
      strConcat = strConcat .. "s"
    elseif curByte > 128 then
      byteCount = 2
      strConcat = strConcat .. "s"
    else
      byteCount = 1
      strConcat = strConcat .. "n"
    end
    i = i + byteCount
    length = length + 1
    if i > #inputstr then
      break
    end
  end
  return length, strConcat
end

function StrUtils.IsContainChinese(str)
  for i = 1, #str do
    local byte = string.byte(str, i)
    if byte >= 19968 and byte <= 40869 then
      return true
    end
  end
  return false
end

function StrUtils.TruncateUtf8String(s, n)
  local dropping = string.byte(s, n + 1)
  if not dropping then
    return s
  end
  if dropping >= 128 and dropping < 192 then
    do return StrUtils.TruncateUtf8String, s end
    return StrUtils.TruncateUtf8String, s, n - 1, nil
  end
  do return string.sub, s, 1 end
  return string.sub, s, 1, n
end

function StrUtils.TruncateChineseString(str, len)
  local utf8len = 0
  local totalLen = 0
  local i = 1
  while len > utf8len and i <= #str do
    local byte = string.byte(str, i)
    if byte > 0 and byte <= 127 then
      totalLen = totalLen + 1
      utf8len = utf8len + 1
    elseif byte >= 194 and byte <= 223 then
      totalLen = totalLen + 2
      utf8len = utf8len + 1
      i = i + 1
    elseif byte >= 224 and byte <= 239 then
      totalLen = totalLen + 3
      utf8len = utf8len + 1
      i = i + 2
    elseif byte >= 240 and byte <= 244 then
      totalLen = totalLen + 4
      utf8len = utf8len + 1
      i = i + 3
    end
    i = i + 1
  end
  if totalLen < #str then
    return StrUtils.TruncateUtf8String(str, totalLen) .. "..."
  else
    return str
  end
end

StrUtils.CHAR_TRUNCATE_LANGS = {
  CN = true,
  TW = true,
  JP = true,
  KR = true,
  TH = true,
  BN = true,
  DE = true
}

function StrUtils.TruncateTextForDisplay(str, maxLen)
  if not str or 0 == #str then
    return str
  end
  local DataCenter = require("Data.DataCenter")
  local langCode = DataCenter.gameData.CurrTextLanguage
  if StrUtils.CHAR_TRUNCATE_LANGS[langCode] then
    return str
  end
  local truncated = StrUtils.TruncateChineseString(str, maxLen)
  if truncated == str then
    return str
  end
  local plain = truncated:sub(1, -4)
  local lastSpace = plain:find(" [^ ]*$")
  if lastSpace then
    return plain:sub(1, lastSpace - 1) .. "..."
  end
  return truncated
end

function StrUtils.IsRichTextConfig(configKey)
  local config = DT.WordsEffectConfig[configKey]
  return config
end

local linkKeys = {
  "Link",
  "SkillLink",
  "StateLink"
}

function StrUtils.GetWordEffectKeys(config)
  local keys = {}
  for k, v in pairs(config) do
    if table.contains(linkKeys, k) then
      table.insert(keys, 1, k)
    else
      table.insert(keys, k)
    end
  end
  return keys
end

function StrUtils.GetWordsEffectRichText(configKey, text, parseWordEffectFunc)
  local config = DT.WordsEffectConfig[configKey]
  local effect = text or ""
  if config then
    local keys = StrUtils.GetWordEffectKeys(config)
    effect = text or "val"
    for _, key in ipairs(keys) do
      local value = config[key]
      if nil ~= value and 0 ~= value and "" ~= value then
        local effectCfg = StrUtils.WordsEffectType[key]
        if effectCfg then
          if "Img" == key then
            local preStr = string.format("<%s=\"%s\" name=\"%s\">", effectCfg.tag, config.ImgPath, value)
            effect = preStr .. effect
          elseif table.contains(linkKeys, key) then
            local strArr = string.split(effect, "#")
            local seg1 = strArr[1] or ""
            local seg2 = strArr[2] or ""
            if "Link" ~= key then
              seg1 = StrUtils.ToWesternNoBreakNameText(seg1)
            end
            if "Url" == value then
              local linkText = string.format("Url:%s", seg2)
              effect = string.format("<link=\"%s\"><u>%s</u></link>", linkText, seg1)
            else
              effect = string.format("<link=\"%s:%s\"><u>%s</u></link>", key, value, seg1)
            end
          else
            local preStr
            if effectCfg.needValue then
              if "Color" == key then
                local colorHexStr = StrUtils.GetWordsEffectColor(config)
                value = colorHexStr and colorHexStr or value
              end
              preStr = string.format("<%s=%s>", effectCfg.tag, value)
            else
              preStr = string.format("<%s>", effectCfg.tag)
            end
            local suffix = string.format("</%s>", effectCfg.tag)
            effect = preStr .. effect .. suffix
          end
        elseif parseWordEffectFunc then
          effect = effect .. parseWordEffectFunc(config, key, value, effect)
        end
      end
    end
  end
  return effect
end

function StrUtils.ParseLinkEffect(cfgName, orgStr)
  if nil == orgStr or type(orgStr) ~= "string" then
    return ""
  end
  cfgName = cfgName or ""
  local strArr = string.split(orgStr, "#")
  local showName, cfgId, extra, fieldName
  if string.find(orgStr, "^#") then
    fieldName, cfgId, extra = strArr[2], strArr[3], strArr[4]
    showName = ""
    local linkCfg = DT[cfgName]
    if linkCfg then
      local cfg = linkCfg[cfgId] or linkCfg[tonumber(cfgId) or 0]
      if not cfg then
        Logger.Error("cfg ==  %s", tostring(cfgId))
      else
        showName = fieldName and cfg[fieldName] or ""
      end
    end
  else
    showName, cfgId, extra = strArr[1] or "", strArr[2], strArr[3]
  end
  showName = showName or ""
  cfgId = cfgId or ""
  extra = extra or ""
  local linkText = string.format("%s#%s#%s#%s", cfgName, showName, cfgId, extra)
  local output = string.format("<link=\"%s\"><u>%s</u></link>", linkText, showName)
  return output
end

function StrUtils.SplitString(str, delimiter, n)
  local result = {}
  if nil == str or type(str) ~= "string" then
    return result
  end
  local count = 0
  local delimiterCount = 0
  for token in string.gmatch(str, "[^" .. delimiter .. "]+") do
    if n > delimiterCount then
      table.insert(result, token)
    else
      result[#result] = result[#result] .. delimiter .. token
    end
    count = count + 1
    delimiterCount = delimiterCount + 1
    if count == n then
      delimiterCount = 0
    end
  end
  return result
end

function StrUtils.GetLinkInfo(linkText)
  local emptyRet = {
    linkKey = nil,
    cfgName = nil,
    showContent = nil
  }
  if nil == linkText or type(linkText) ~= "string" or "" == linkText then
    return emptyRet
  end
  local strArr = StrUtils.SplitString(linkText, ":", 1)
  if not strArr or #strArr < 2 then
    return emptyRet
  end
  local linkKey, cfgName, showContent = strArr[1], strArr[2]
  if string.contains(linkText, "Url") then
    linkKey = nil
    cfgName = strArr[1]
    showContent = strArr[2]
  end
  return {
    linkKey = linkKey,
    cfgName = cfgName,
    showContent = showContent
  }
end

StrUtils.ColorIdMap = nil

function StrUtils.GetColorConfig(colorIdStr)
  if not StrUtils.ColorIdMap then
    StrUtils.ColorIdMap = {}
    for id, cfg in pairs(DT.ColorConfig) do
      if cfg then
        StrUtils.ColorIdMap[cfg.ColorID] = id
      end
    end
  end
  local id = StrUtils.ColorIdMap[colorIdStr]
  local config = DT.ColorConfig[id]
  if not config then
    Logger.Info("找不到颜色表, colorIdStr=%s, id=%s", colorIdStr, id)
  end
  return config
end

function StrUtils.GetWordsEffectColor(config)
  local colorArr = string.split(config.Color, ",")
  local colorType = CommonDefine.ColorType.Light
  if #colorArr > 1 then
    colorType = colorArr[2]
  end
  local colorCfg = StrUtils.GetColorConfig(colorArr[1])
  if not colorCfg then
    return
  end
  local colorHexStr
  if colorType == CommonDefine.ColorType.Light then
    colorHexStr = colorCfg.Light
  else
    colorHexStr = colorCfg.Dark
  end
  return colorHexStr
end

function StrUtils.GetGreenText(text)
  local color = CommonDefine.TextColorDefine.Green
  do return StrUtils.GetColorText, text end
  return StrUtils.GetColorText, text, color
end

function StrUtils.GetRedText(text)
  local color = CommonDefine.TextColorDefine.Red
  do return StrUtils.GetColorText, text end
  return StrUtils.GetColorText, text, color
end

function StrUtils.GetColorText(text, color)
  do return string.format, "<color=%s>%s</color>", color end
  return string.format, "<color=%s>%s</color>", color, text
end

function StrUtils.GetCostStr(cost, isEnough)
  local key = isEnough and "Shop1" or "Shop3"
  do return StrUtils.GetWordsEffectRichText, key end
  return StrUtils.GetWordsEffectRichText, key, cost
end

function StrUtils.FindLast(s, pattern, plain)
  local curr = 0
  repeat
    local next = s:find(pattern, curr + 1, plain)
    if next then
      curr = next
    end
  until not next
  if curr > 0 then
    return curr
  end
end

function StrUtils.ParseImgNumber(num, imgEffectName, toParseEffect)
  local currNum = num
  local numberArr = {}
  while currNum > 0 do
    table.insert(numberArr, currNum % 10)
    currNum = math.floor(currNum / 10)
  end
  local result = ""
  if 1 == #numberArr then
    table.insert(numberArr, 0)
  end
  for i = #numberArr, 1, -1 do
    result = result .. string.format("<%s%d:>", imgEffectName, numberArr[i])
  end
  if toParseEffect then
    result = StrUtils.SetWordEffectStr(result)
  end
  return result
end

function StrUtils.ParseEmojiNumber(num, emojiName)
  local numbers = {}
  local numStr = tostring(math.floor(num))
  for i = 1, #numStr do
    local char = string.sub(numStr, i, i)
    if "-" == char then
      char = "11"
    end
    table.insert(numbers, string.format("<sprite=\"%s\" index=%s>", emojiName, char))
  end
  do return table.concat end
  return table.concat, numbers, 1, math.floor(num)
end

function StrUtils.ConvertHexToRGB(str)
  local r = tonumber(string.sub(str, 2, 3), 16) / 255
  local g = tonumber(string.sub(str, 4, 5), 16) / 255
  local b = tonumber(string.sub(str, 6, 7), 16) / 255
  return r, g, b
end

function StrUtils.NumberConvert(num, showDemicalNum)
  if type(num) ~= "number" then
    return num
  end
  if not showDemicalNum or 0 == showDemicalNum or type("number" ~= showDemicalNum) then
    showDemicalNum = 0
  end
  local demicalNum = 10 ^ showDemicalNum
  if num >= 100000 then
    if num > 99999999 then
      num = 99999999
    end
    do return string.format, "%dK" end
    return string.format, "%dK", math.floor(num * demicalNum / 1000) / demicalNum, num * demicalNum / 1000
  end
  do return math.floor end
  return math.floor, num, math.floor(num * demicalNum / 1000) / demicalNum, num * demicalNum / 1000
end

function StrUtils.CheckAppendVideoLangSuffix(videoName)
  if not videoName then
    return
  end
  local DataCenter = require("Data.DataCenter")
  local langCode = DataCenter.gameData.CurrTextLanguage
  if "CN" ~= langCode then
    local strArr = string.split(videoName, ".")
    if #strArr > 1 then
      local name = string.format("%s_%s", strArr[1], langCode)
      for i = 2, #strArr do
        name = name .. "." .. strArr[i]
      end
      local fileName = string.format("/Video/%s", name)
      local persistentFileName = string.format("/_game_data_/DownLoad/Video/%s", name)
      local persistentFilePath = Utils.GetApplicationPersistenDataPath() .. persistentFileName
      local streamingAssetsFilePath = CS.UnityEngine.Application.streamingAssetsPath .. fileName
      local fileInfoPersistPath = CS.System.IO.FileInfo(persistentFilePath)
      local fileInfoSAPath = CS.System.IO.FileInfo(streamingAssetsFilePath)
      if fileInfoPersistPath.Exists or fileInfoSAPath.Exists then
        videoName = name
      elseif LangVideoPathMap[langCode] and LangVideoPathMap[langCode][videoName] then
        videoName = LangVideoPathMap[langCode][videoName]
      elseif LangVideoPathMap.EN[videoName] then
        videoName = LangVideoPathMap.EN[videoName]
      end
    end
  end
  return videoName
end

function StrUtils.GetMediaPathType(videoName)
  videoName = StrUtils.CheckAppendVideoLangSuffix(videoName)
  local persistentFileName = string.format("/_game_data_/DownLoad/Video/%s", videoName)
  local returnString = Utils.GetApplicationPersistenDataPath() .. persistentFileName
  local fileInfo = CS.System.IO.FileInfo(returnString)
  Logger.Info("videoName: ", videoName, "fileInfo.Exists: ", fileInfo.Exists)
  local MediaPathType = CS.RenderHeads.Media.AVProVideo.MediaPathType
  if fileInfo.Exists then
    return MediaPathType.RelativeToPersistentDataFolder, string.sub(persistentFileName, 2)
  end
  return MediaPathType.RelativeToStreamingAssetsFolder, "Video/" .. videoName
end

function StrUtils.GetVideoUrl(videoName)
  videoName = StrUtils.CheckAppendVideoLangSuffix(videoName)
  local fileName = string.format("/Video/%s", videoName)
  local persistentFileName = string.format("/_game_data_/DownLoad/Video/%s", videoName)
  local returnString = Utils.GetApplicationPersistenDataPath() .. persistentFileName
  local fileInfo = CS.System.IO.FileInfo(returnString)
  Logger.Info("returnString: ", returnString)
  Logger.Info("fileInfo.Exists: ", fileInfo.Exists)
  if fileInfo.Exists then
    return returnString
  end
  return CS.UnityEngine.Application.streamingAssetsPath .. fileName
end

function StrUtils.VideoExist(videoName)
  videoName = StrUtils.CheckAppendVideoLangSuffix(videoName)
  local fileName = string.format("/Video/%s", videoName)
  local persistentFileName = string.format("/_game_data_/DownLoad/Video/%s", videoName)
  local returnString = Utils.GetApplicationPersistenDataPath() .. persistentFileName
  local fileInfo = CS.System.IO.FileInfo(returnString)
  local fileInfo2 = CS.System.IO.FileInfo(CS.UnityEngine.Application.streamingAssetsPath .. fileName)
  return fileInfo.Exists or fileInfo2.Exists
end

function StrUtils.UrlDecode(str)
  str = string.gsub(str, "+", " ")
  str = string.gsub(str, "%%(%x%x)", function(h)
    do return string.char, tonumber(h, 16) end
    return string.char, tonumber(h, 16)
  end)
  return str
end

function StrUtils.Utf8ByteCount(byteValue)
  if byteValue < 0 or byteValue > 255 then
    return
  end
  if byteValue <= 127 then
    return 1
  elseif byteValue >= 192 and byteValue <= 223 then
    return 2
  elseif byteValue >= 224 and byteValue <= 239 then
    return 3
  elseif byteValue >= 240 and byteValue <= 247 then
    return 4
  end
end

function StrUtils.GetCharLen(str)
  local lenInByte = #str
  local charCount = 0
  local i = 1
  while lenInByte >= i do
    local curByte = string.byte(str, i)
    local byteCount = StrUtils.Utf8ByteCount(curByte)
    i = i + byteCount
    charCount = charCount + (1 == byteCount and 1 or 2)
  end
  return charCount
end

function StrUtils.GetNameLengthRange()
  local nameLength = DT.GetOriginalConstant("NameLengthRange")
  if not nameLength or #nameLength < 2 then
    return 0, 0
  end
  local nameLengthMin, nameLengthMax = nameLength[1], nameLength[2]
  return nameLengthMin, nameLengthMax
end

function StrUtils.SubStr(str, len)
  local lenInByte = #str
  local charCount = 0
  local i = 1
  while lenInByte >= i do
    local byteCount = 1
    local curByte = string.byte(str, i)
    byteCount = StrUtils.Utf8ByteCount(curByte)
    charCount = charCount + (1 == byteCount and 1 or 2)
    if len < charCount then
      do return string.sub, str, 1 end
      return string.sub, str, 1, i - 1
    end
    i = i + byteCount
  end
  return str
end

function StrUtils.Utf8SafeSub(str, startByte, endByte)
  local byteStart = 1
  local charIndex = 0
  local result = ""
  for p, c in utf8.codes(str) do
    charIndex = charIndex + 1
    local charLen = utf8.char(c):len()
    if startByte <= byteStart and endByte >= byteStart then
      result = result .. utf8.char(c)
    end
    byteStart = byteStart + charLen
    if endByte < byteStart then
      break
    end
  end
  return result
end

function StrUtils.IsCnJpAlphaNum(str)
  local k = 1
  local isLegal = true
  while k <= #str do
    local c = string.byte(str, k)
    isLegal = false
    if c >= 48 and c <= 57 or c >= 65 and c <= 90 or c >= 97 and c <= 122 then
      isLegal = true
    elseif c >= 228 and c <= 233 then
      local c1 = string.byte(str, k + 1)
      local c2 = string.byte(str, k + 2)
      if c1 and c2 then
        local a1, a2, a3, a4 = 128, 191, 128, 191
        if 228 == c then
          a1 = 184
        elseif 233 == c then
          a2, a4 = 190, 190 ~= c1 and 191 or 165
        end
        if c1 >= a1 and c1 <= a2 and c2 >= a3 and c2 <= a4 then
          isLegal = true
        end
      end
    elseif 227 == c then
      local c1 = string.byte(str, k + 1)
      local c2 = string.byte(str, k + 2)
      if c1 and c2 then
        local utf8CodeValue = c * 256 * 256 + c1 * 256 + c2
        if utf8CodeValue >= 14909568 and utf8CodeValue <= 14910111 then
          isLegal = true
        elseif utf8CodeValue >= 14910112 and utf8CodeValue <= 14910399 then
          isLegal = true
        elseif utf8CodeValue >= 14911408 and utf8CodeValue <= 14911423 then
          isLegal = true
        end
      end
    end
    if not isLegal then
      return false
    end
    k = k + StrUtils.Utf8ByteCount(c)
  end
  return true
end

function StrUtils.SplitAnnounce(str)
  do return string.split, str end
  return string.split, str, "\n"
end

function StrUtils.SplitTitleAndContent(str)
  local tResult = {}
  if not string.match(str, "<Title:[^<>]+>") then
    table.insert(tResult, {content = str})
  else
    StrUtils._ParseTitleAndContent(tResult, str)
  end
  return tResult
end

function StrUtils._ParseTitleAndContent(tResult, str)
  local data
  for line in string.gmatch(str, [[

?([^
]+)
?]]) do
    local content = string.sub(line, 2, -2)
    local splits = string.split(content, ":")
    local tag = splits and splits[1]
    if "Title" == tag then
      data = {}
      table.remove(splits, 1)
      data.title = table.concat(splits, ":")
      table.insert(tResult, data)
    elseif not data then
    elseif "Image" == tag then
      data.image = value
    else
      if not data.contentTbl then
        data.contentTbl = {}
      end
      table.insert(data.contentTbl, line)
    end
  end
  for _, v in ipairs(tResult) do
    if v.contentTbl then
      v.content = table.concat(v.contentTbl, "\n")
    end
  end
end

function StrUtils.CheckDescContainKeywords(str)
  str = StrUtils.SetWordEffectStr(str)
  str = LT.ReplaceUnicodeSpace(str)
  str = StrUtils.ReplaceAvgContent(str)
  do return StrUtils.CheckContainsEffectLink end
  return StrUtils.CheckContainsEffectLink, str
end

function StrUtils.SearchByKeyStr(keyStr, text)
  local rst = false
  if not keyStr or not text then
    return rst
  end
  local pattern = "(.-)" .. keyStr .. "(.-)"
  local _, matchStart, matchEnd, capture1, capture2 = string.find(text, pattern)
  if matchStart then
    rst = true
  end
  return rst
end

function StrUtils.CopyToClipboard(content)
  if content and type(content) ~= "string" and type(content) ~= "number" then
    return
  end
  content = content and tostring(content) or ""
  CS.UnityEngine.GUIUtility.systemCopyBuffer = content
end

function StrUtils.PasteFromClipboard()
  local pasteText = ""
  if CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor then
    if not CS.Sirenix.Utilities.Editor.Clipboard:IsEmpty() then
      pasteText = CS.Sirenix.Utilities.Editor.Clipboard:Paste()
    end
  else
    pasteText = CS.UnityEngine.GUIUtility.systemCopyBuffer
  end
  return pasteText
end

function StrUtils.GetValidCharCount(str)
  local count = 0
  local charClose = "<"
  local charOpen = ">"
  local isCountEnable = true
  for i = 1, #str do
    local c = str[i]
    if c == charClose then
      isCountEnable = false
    end
    if c == charOpen then
      isCountEnable = true
    end
    if isCountEnable then
      count = count + 1
    end
  end
  return count
end

function StrUtils.GetPrefabNameFromPath(prefabPath)
  local rst = string.match(prefabPath, ".-([^/]+)%.prefab$")
  return rst
end

local DEFAULT_LINE_SPACE_OFFSET = 8
local lineSpaceOffsets = {
  CN = 2,
  TW = 2,
  RU = 8
}

function StrUtils.GetLineSpaceOffset()
  return lineSpaceOffsets[DataCenter.gameData.CurrTextLanguage] or DEFAULT_LINE_SPACE_OFFSET
end

function StrUtils.GetPreferredHeight(textGo, expandHeight)
  if IsNil(textGo) then
    return 0
  end
  local tmp = textGo:GetComponent(TYPEOF_TMP_Text)
  if tmp and tmp.textInfo then
    tmp:ForceMeshUpdate()
    local lineCount = tmp.textInfo.lineCount
    local fontSpacing = tmp.lineSpacing / 100 * tmp.fontSize
    local linedHeight = 0
    for i = 0, lineCount - 1 do
      linedHeight = linedHeight + tmp.textInfo.lineInfo[i].lineHeight
    end
    linedHeight = linedHeight + fontSpacing * (lineCount - 1)
    local preferredHeight = tmp.preferredHeight
    local height = math.max(linedHeight, preferredHeight)
    return height + (expandHeight or 0)
  end
  return 0
end

function StrUtils.SetPreferredHeight(textGo, expandHeight)
  if IsNil(textGo) then
    return 0
  end
  local height = StrUtils.GetPreferredHeight(textGo, expandHeight)
  local sizeDelta = textGo.transform.sizeDelta
  TempVector2.x = sizeDelta.x
  TempVector2.y = height
  textGo.transform.sizeDelta = TempVector2
  return TempVector2.y or 0
end

function StrUtils.SetPreferredWidth(textGo, expandWidth)
  if IsNil(textGo) then
    return 0
  end
  local tmp = textGo:GetComponent(TYPEOF_TMP_Text)
  if tmp then
    tmp:ForceMeshUpdate()
    local preferredWidth = tmp.preferredWidth
    local sizeDelta = textGo.transform.sizeDelta
    TempVector2.x = preferredWidth + (expandWidth or 0)
    TempVector2.y = sizeDelta.y
    textGo.transform.sizeDelta = TempVector2
  end
  return TempVector2.x or 0
end

function StrUtils.SetPreferedWidthFontSize(textGo, maxFontSize, appointWidth)
  local tmp = textGo:GetComponent(TYPEOF_TMP_Text)
  if tmp then
    local preferredWidth = tmp.preferredWidth
    local textCompWidth = appointWidth or textGo.transform.sizeDelta.x
    maxFontSize = maxFontSize or tmp.fontSize
    if preferredWidth > textCompWidth then
      tmp.fontSize = textCompWidth / preferredWidth * maxFontSize
    else
      tmp.fontSize = maxFontSize
    end
  end
end

function StrUtils.SetChildTextPreferredFontSize(gameObj)
  local tmps = gameObj:GetComponentsInChildren(TYPEOF_TMP_Text)
  for i = 0, tmps.Length - 1 do
    local tmp = tmps[i]
    StrUtils.SetPreferedWidthFontSize(tmp.gameObject)
  end
end

function StrUtils.CapitalizeFirstLetter(str)
  if nil == str or "" == str then
    return str
  end
  local first_char = str:match("(%a)")
  if first_char then
    local capitalized_char = first_char:upper()
    do return str.gsub, str, first_char, capitalized_char end
    return str.gsub, str, first_char, capitalized_char, 1
  else
    return str
  end
end

local function split(inputstr, sep)
  if nil == sep then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

function StrUtils.SplitMapNodeCfgEffect2Field(effect2)
  local result = {}
  local parts = split(effect2, ";")
  for _, part in ipairs(parts) do
    if string.find(part, ",") then
      for _, subpart in ipairs(split(part, ",")) do
        table.insert(result, subpart)
      end
    else
      table.insert(result, part)
    end
  end
  return result
end

function StrUtils.GetPercentNum(numVal, percentFormat)
  local percentPartFormat = percentFormat or "%.2f%%"
  local percentage = numVal * 100
  if math.floor(percentage) == percentage then
    return tostring(math.floor(percentage)) .. "%"
  else
    do return string.format, percentPartFormat end
    return string.format, percentPartFormat, percentage
  end
end

function StrUtils.SplitLineText(contentTmpComp)
  local textInfo = contentTmpComp.textInfo
  local firstLineStartIndex = textInfo.lineInfo[0].firstCharacterIndex
  local firstLineEndIndex = textInfo.lineInfo[0].lastCharacterIndex
  local splitStr = UIUtils.SubStringUTF8(contentTmpComp.text, firstLineStartIndex, firstLineEndIndex - firstLineStartIndex + 1)
  local secondLineStartIndex = textInfo.lineInfo[1].firstCharacterIndex + 1
  local remainStr = UIUtils.SubStringUTF8(contentTmpComp.text, secondLineStartIndex)
  return splitStr, remainStr
end

function StrUtils.ReplaceToErrCode(str, charIndex, maxReplaceCount)
  local tagRanges = {}
  local charPos = 1
  for pos, code in utf8.codes(str) do
    local char = utf8.char(code)
    if "<" == char then
      local rightBytePos = string.find(str, ">", pos)
      if rightBytePos then
        local rightCharPos = charPos
        for p, _ in utf8.codes(str) do
          if p <= rightBytePos then
            rightCharPos = rightCharPos + 1
          else
            break
          end
        end
        rightCharPos = rightCharPos - 1
        table.insert(tagRanges, {left = charPos, right = rightCharPos})
      end
    end
    charPos = charPos + 1
  end
  for _, range in ipairs(tagRanges) do
    if charIndex >= range.left and charIndex <= range.right then
      charIndex = range.right + 1
      break
    end
  end
  local result = ""
  local currentCharIndex = 0
  local inTag = false
  local tagStartByte
  local strUTF8Len = utf8.len(str)
  maxReplaceCount = maxReplaceCount or strUTF8Len
  local replaceCount = 0
  for pos, code in utf8.codes(str) do
    currentCharIndex = currentCharIndex + 1
    local char = utf8.char(code)
    if charIndex > currentCharIndex then
      result = result .. char
    elseif currentCharIndex == charIndex then
      if "<" == char then
        inTag = true
        tagStartByte = pos
        result = result .. char
      else
        if maxReplaceCount > replaceCount then
          result = result .. string.char(math.random(65, 90))
        end
        replaceCount = replaceCount + 1
      end
    elseif "<" == char then
      inTag = true
      tagStartByte = pos
      result = result .. char
    elseif ">" == char then
      if inTag then
        result = result .. string.sub(str, tagStartByte, pos)
        inTag = false
        tagStartByte = nil
      else
        result = result .. string.char(math.random(65, 90))
      end
    elseif inTag then
    else
      if maxReplaceCount > replaceCount then
        result = result .. string.char(math.random(65, 90))
      end
      replaceCount = replaceCount + 1
    end
  end
  if inTag and tagStartByte then
    result = result .. string.sub(str, tagStartByte)
  end
  return result
end

return StrUtils
