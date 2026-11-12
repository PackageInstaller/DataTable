local Debug = CS.UnityEngine.Debug
Object = CS.UnityEngine.Object
Sprite = CS.UnityEngine.Sprite
Texture = CS.UnityEngine.Texture
Color = CS.UnityEngine.Color
ColorUtility = CS.UnityEngine.ColorUtility
Transform = CS.UnityEngine.Transform
RectTransform = CS.UnityEngine.RectTransform
GameObject = CS.UnityEngine.GameObject
Vector2 = CS.UnityEngine.Vector2
Vector3 = CS.UnityEngine.Vector3
Quaternion = CS.UnityEngine.Quaternion
NovaAPI = CS.NovaAPI
NovaAPIHotfix = CS.NovaAPIHotfix
CSTimerManager = CS.TimerManager
DOTween = CS.DG.Tweening.DOTween
Sequence = CS.DG.Tweening.DOTween.Sequence
Ease = CS.DG.Tweening.Ease
RotateMode = CS.DG.Tweening.RotateMode
TweenExtensions = CS.TweenExtensions
GameUIUtils = CS.GameUIUtils
local PB = require("pb")
require("functions")
local rapidjson = require("rapidjson")
GameEnum = require("Game.CodeGen.GAME_ENUM_DEFINE")
AllEnum = require("GameCore.Common.AllEnum")
Settings = require("GameCore.Common.Settings")
EventId = require("GameCore.Event.EventId")
EventManager = require("GameCore.Event.EventManager")
PlayerData = require("GameCore.Data.PlayerData")
NetMsgId = require("GameCore.Network.NetMsgId")
HttpNetHandler = require("GameCore.Network.HttpNetHandler")
PanelId = require("GameCore.UI.PanelId")
PanelManager = require("GameCore.UI.PanelManager")
BasePanel = require("GameCore.UI.BasePanel")
BaseCtrl = require("GameCore.UI.BaseCtrl")
RedDotDefine = require("GameCore.RedDot.RedDotDefine")
RedDotManager = require("GameCore.RedDot.RedDotManager")
PopUpManager = require("GameCore.Data.PopUpManager")
local util = require("xlua.util")
async_to_sync = util.async_to_sync
coroutine_call = util.coroutine_call
cs_generator = util.cs_generator
loadpackage = util.loadpackage
auto_id_map = util.auto_id_map
hotfix_ex = util.hotfix_ex
bind = util.bind
createdelegate = util.createdelegate
state = util.state
print_func_ref_by_csharp = util.print_func_ref_by_csharp
cs_coroutine = require("xlua.cs_coroutine")

function IsNull(obj)
  return obj == nil or obj:IsNull()
end

local serpent = require("serpent")

function printLog(str)
  Debug.Log(str)
end

function printWarn(str)
  Debug.LogWarning(str)
end

function printError(str)
  Debug.LogError(str)
end

function printTable(tb)
  if type(tb) == "table" then
    print(serpent.block(tb))
  end
end

function traceback(str)
  Debug.LogError(debug.traceback(str))
end

function timeFormat_MS(value)
  local min = math.floor(value / 60)
  local sec = value - min * 60
  if min < 10 then
    min = "0" .. min
  end
  if sec < 10 then
    sec = "0" .. sec
  end
  return min .. ":" .. sec
end

function timeFormat_HMS(value)
  local hor = math.floor(value / 60 / 60)
  local min = math.floor((value - hor * 60 * 60) / 60)
  local sec = value - hor * 60 * 60 - min * 60
  if hor < 10 then
    hor = "0" .. hor
  end
  if min < 10 then
    min = "0" .. min
  end
  if sec < 10 then
    sec = "0" .. sec
  end
  return hor .. ":" .. min .. ":" .. sec
end

function timeFormat_DHMS(value)
  local day = math.floor(value / 60 / 60 / 24)
  value = value % 86400
  local hor = math.floor(value / 60 / 60)
  local min = math.floor((value - hor * 60 * 60) / 60)
  local sec = value - hor * 60 * 60 - min * 60
  if hor < 10 then
    hor = "0" .. hor
  end
  if min < 10 then
    min = "0" .. min
  end
  if sec < 10 then
    sec = "0" .. sec
  end
  if 0 < day then
    return string.format("%dd %s", day, hor .. ":" .. min .. ":" .. sec)
  else
    return hor .. ":" .. min .. ":" .. sec
  end
end

function timeFormat_Table(value)
  local tbTime = {}
  local day = math.floor(value / 60 / 60 / 24)
  value = value % 86400
  local hour = math.floor(value / 60 / 60)
  local min = math.floor((value - hour * 60 * 60) / 60)
  local sec = value - hour * 60 * 60 - min * 60
  tbTime.day = day
  tbTime.hour = hour
  tbTime.min = min
  tbTime.sec = sec
  return tbTime
end

function GetNextWeekRefreshTime()
  local nCurTimeWithTimeZone = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local tbCurDate = os.date("!*t", nCurTimeWithTimeZone)
  local nCurWeekday = tbCurDate.wday
  nCurWeekday = nCurWeekday == 1 and 7 or nCurWeekday - 1
  local nDays = 7 - nCurWeekday
  local nDailyRefreshOffsetHour = ConfigTable.GetConfigNumber("DailyRefreshOffsetHour")
  if nDailyRefreshOffsetHour > tbCurDate.hour then
    if nCurWeekday == 1 then
      nDays = 0
    else
      nDays = nDays + 1
    end
  end
  local nNextOpenTime = CS.ClientManager.Instance:GetNextRefreshTime(nCurTime)
  if 0 < nDays then
    for i = 1, nDays do
      nCurTime = nNextOpenTime
      nNextOpenTime = CS.ClientManager.Instance:GetNextRefreshTime(nCurTime)
    end
  end
  return nNextOpenTime
end

function FormatNum(num)
  if num <= 0 then
    return 0
  else
    local t1, t2 = math.modf(num)
    if 0 < t2 then
      return num
    else
      return t1
    end
  end
end

function FormatEffectValue(nValue, bPercent, nFormat)
  if type(nValue) == "userdata" then
    nValue = nValue:AsFloat()
  end
  if bPercent then
    nValue = nValue * 100
  end
  if nValue == 0 and bPercent then
    return "0%"
  end
  local sValue
  if nFormat == GameEnum.ValueFormat.Int then
    nValue = math.floor(nValue)
    sValue = string.format("%d", nValue)
  elseif nFormat == GameEnum.ValueFormat.ODP then
    sValue = string.format("%.1f", nValue)
    sValue = sValue:gsub("0+$", "")
  elseif nFormat == GameEnum.ValueFormat.TDP then
    sValue = string.format("%.2f", nValue)
    sValue = sValue:gsub("0+$", "")
  end
  sValue = sValue:gsub("%.$", "")
  if bPercent then
    sValue = sValue .. "%"
  end
  return sValue
end

function FormatWithCommas(nValue)
  local s, integer, decimal = tostring(nValue), "", ""
  local dot = string.find(s, "%.")
  if dot then
    integer = string.sub(s, 1, dot - 1)
    decimal = string.sub(s, dot + 1)
  else
    integer = s
  end
  integer = string.reverse(integer)
  integer = string.gsub(integer, "(%d%d%d)", "%1,")
  integer = string.reverse(integer)
  if string.sub(integer, 1, 1) == "," then
    integer = string.sub(integer, 2)
  end
  if decimal ~= "" then
    return integer .. "." .. decimal
  else
    return integer
  end
end

function indexOfPose(sPose)
  local tbCharPose = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "aa",
    "ab",
    "ac",
    "ad",
    "ae",
    "af",
    "ag",
    "ah",
    "ai",
    "aj",
    "ak",
    "al",
    "am",
    "an",
    "ao",
    "ap",
    "aq",
    "ar",
    "as",
    "at",
    "au",
    "av",
    "aw",
    "ax",
    "ay",
    "az",
    "ba",
    "bb",
    "bc",
    "bd",
    "be",
    "bf",
    "bg",
    "bh",
    "bi",
    "bj",
    "bk",
    "bl",
    "bm",
    "bn",
    "bo",
    "bp",
    "bq",
    "br",
    "bs",
    "bt",
    "bu",
    "bv",
    "bw",
    "bx",
    "by",
    "bz",
    "ca",
    "cb",
    "cc",
    "cd",
    "ce",
    "cf",
    "cg",
    "ch",
    "ci",
    "cj",
    "ck",
    "cl",
    "cm",
    "cn",
    "co",
    "cp",
    "cq",
    "cr",
    "cs",
    "ct",
    "cu",
    "cv",
    "cw",
    "cx",
    "cy",
    "cz"
  }
  local nIdx = table.indexof(tbCharPose, sPose)
  if nIdx < 0 then
    nIdx = 0
  end
  return nIdx
end

function instantiate(...)
  return GameObject.Instantiate(...)
end

function destroy(obj)
  if not obj:IsNull() then
    GameObject.Destroy(obj)
  end
end

function destroyImmediate(obj)
  if not obj:IsNull() then
    GameObject.DestroyImmediate(obj)
  end
end

function luaCoroutineStart(runner, ...)
  return runner:StartCoroutine(util.cs_generator(...))
end

function luaCoroutineStop(runner, coroutine)
  runner:StopCoroutine(coroutine)
end

function delChildren(go)
  if go.transform.childCount > 0 then
    for i = go.transform.childCount, 1, -1 do
      local obj = go.transform:GetChild(i - 1).gameObject
      destroy(obj)
    end
  end
end

function ProcContentWord(sContentWord, bUsePresetColor)
  if bUsePresetColor == nil then
    bUsePresetColor = false
  end
  local tbContent = string.split(sContentWord, "$")
  local sRetContent = tbContent[1]
  for i, v in ipairs(tbContent) do
    if 1 < i then
      local sHeadFourChar = string.sub(v, 1, 4)
      local nWordId = tonumber(sHeadFourChar)
      local sWord
      if type(nWordId) == "number" then
        local data = ConfigTable.GetData("ContentWord", nWordId)
        if data ~= nil then
          sWord = data.Word
        end
      end
      if sWord == nil then
        sWord = "$" .. v
      else
        if bUsePresetColor == true then
          local sColor = ConfigTable.GetData("ContentWord", nWordId).PresetColor or ""
          if sColor ~= "" then
            sWord = string.format("<color=%s>%s</color>", sColor, sWord)
          end
        end
        sWord = string.gsub(v, sHeadFourChar, sWord)
      end
      sRetContent = sRetContent .. sWord
    end
  end
  return sRetContent
end

function GetLanguageIndex(sLan)
  for i, v in ipairs(AllEnum.LanguageInfo) do
    if v[1] == sLan then
      return i
    end
  end
  return 1
end

function GetLanguageByIndex(nIndex)
  local tbLanInfo = AllEnum.LanguageInfo[nIndex]
  if tbLanInfo ~= nil then
    return tbLanInfo[1]
  else
    return AllEnum.Language.CN
  end
end

function GetLanguageSurfixByIndex(nIndex)
  local tbLanInfo = AllEnum.LanguageInfo[nIndex]
  if tbLanInfo ~= nil then
    return tbLanInfo[3]
  else
    return "_cn"
  end
end

function GetAvgLuaRequireRoot(nIndex)
  local sFolderSurfix = GetLanguageSurfixByIndex(nIndex) .. "/"
  local sRootPath = "Game/UI/Avg/" .. sFolderSurfix
  if AVG_EDITOR == true and NovaAPI.IsRuntimeWindowsPlayer() == true then
    sRootPath = "/../../../../" .. sFolderSurfix
  end
  return sRootPath
end

function ProcAvgTextContent(sContent, nLanguageIndex)
  local nIndex = PlayerData.Base:GetPlayerSex() == true and 2 or 1
  if nLanguageIndex == nil then
    nLanguageIndex = GetLanguageIndex(Settings.sCurrentTxtLanguage)
  end
  if nLanguageIndex < 1 or nLanguageIndex > #AllEnum.LanguageInfo then
    nLanguageIndex = 1
  end
  sContent = ProcContentWord(sContent, true)
  sContent = string.gsub(sContent, "==RT==", "\n")
  sContent = string.gsub(sContent, "==PLAYER_NAME==", PlayerData.Base:GetPlayerNickName())
  local AvgUIText = require(GetAvgLuaRequireRoot(nLanguageIndex) .. "Preset/AvgUIText")
  local mapSex = AvgUIText.SEX
  for k, v in pairs(mapSex) do
    sContent = string.gsub(sContent, k, v[nIndex])
  end
  return sContent
end

function ProcAvgTextContentFallback(sTextLan, sVoLan, bIsMale, sCN_F, sCN_M, sJP_F, sJP_M)
  if sCN_F == nil then
    sCN_F = ""
  end
  if sCN_M == nil then
    sCN_M = ""
  end
  if sJP_F == nil then
    sJP_F = ""
  end
  if sJP_M == nil then
    sJP_M = ""
  end
  local sContent = ""
  local tbFallback
  if sTextLan == AllEnum.Language.CN then
    tbFallback = {sCN_F}
    if bIsMale == true then
      table.insert(tbFallback, sCN_M)
    end
    if sVoLan == AllEnum.Language.JP then
      table.insert(tbFallback, sJP_F)
      if bIsMale == true then
        table.insert(tbFallback, sJP_M)
      end
    end
  elseif sTextLan == AllEnum.Language.JP then
    tbFallback = {sJP_F}
    if MULTI_LANGUAGE_GENDER_TEXT_COMPATIBLE == true and sJP_F == "" then
      table.insert(tbFallback, sCN_F)
    end
    if bIsMale == true then
      table.insert(tbFallback, sJP_M)
      if MULTI_LANGUAGE_GENDER_TEXT_COMPATIBLE == true and sJP_M == "" then
        table.insert(tbFallback, sCN_M)
      end
    end
  elseif sTextLan == AllEnum.Language.TW or sTextLan == AllEnum.Language.EN or sTextLan == AllEnum.Language.KR then
    tbFallback = {sJP_F}
    if bIsMale == true then
      table.insert(tbFallback, sJP_M)
    end
    if sVoLan == AllEnum.Language.CN then
      table.insert(tbFallback, sCN_F)
      if bIsMale == true then
        table.insert(tbFallback, sCN_M)
      end
    end
    if MULTI_LANGUAGE_GENDER_TEXT_COMPATIBLE == true and sVoLan == AllEnum.Language.JP and sJP_F == "" and sJP_M == "" then
      table.insert(tbFallback, sCN_F)
      if bIsMale == true then
        table.insert(tbFallback, sCN_M)
      end
    end
  end
  if type(tbFallback) == "table" then
    local n = #tbFallback
    for i = n, 1, -1 do
      local s = tbFallback[i]
      if type(s) == "string" and s ~= "" then
        sContent = s
        break
      end
    end
  end
  return sContent
end

function AdjustMainRoleAvgCharId(sAvgCharId)
  if sAvgCharId == nil then
    sAvgCharId = "avg3_100"
  end
  local tbMainRoleAvgCharId = {"avg3_100", "avg3_101"}
  local nIdx = table.indexof(tbMainRoleAvgCharId, sAvgCharId)
  if 0 < nIdx then
    local nIndex = PlayerData.Base:GetPlayerSex() == true and 2 or 1
    return tbMainRoleAvgCharId[nIndex]
  else
    return sAvgCharId
  end
end

function CalcTextAnimDuration(sContent, nLanguageIndex, bIsBB)
  local tbInterval = {
    0.03,
    0.03,
    0.03,
    0.01,
    0.03
  }
  local tbIntervalForBB = {
    0.25,
    0.25,
    0.25,
    0.083,
    0.25
  }
  local nInterval = bIsBB == true and tbIntervalForBB[nLanguageIndex] or tbInterval[nLanguageIndex]
  if nInterval == nil then
    nInterval = bIsBB == true and tbIntervalForBB[1] or tbInterval[1]
  end
  local sPureContent = string.gsub(sContent, "<.->", "")
  sPureContent = string.gsub(sPureContent, "\n", "")
  local nDuration = string.utf8len(sPureContent) * nInterval
  return nDuration
end

function Avg_ProcRes_M_F(sName)
  local nLen = string.len(sName)
  local surfix = string.sub(sName, nLen - 2, nLen)
  if surfix == "_MP" or surfix == "_FP" then
    if PlayerData.Base:GetPlayerSex() == true then
      surfix = "_MP"
    else
      surfix = "_FP"
    end
    sName = string.sub(sName, 1, nLen - 3) .. surfix
    return sName
  else
    return sName
  end
end

function Avg_ProcEnquotes(s)
  s = string.gsub(s, "\\", "")
  s = string.gsub(s, "'", "\\'")
  s = string.gsub(s, "\"", "\\\"")
  return s
end

function Avg_ProcContactsIcon_M_F(sIcon)
  local tb = {
    "Icon/Head/head_9100_S",
    "Icon/Head/head_9101_S"
  }
  if table.indexof(tb, sIcon) > 0 then
    local nIndex = PlayerData.Base:GetPlayerSex() == true and 2 or 1
    return tb[nIndex]
  else
    return sIcon
  end
end

function decodeJson(sJson)
  local tbData = {}
  if type(sJson) == "string" and sJson ~= "" then
    tbData = rapidjson.decode(sJson)
    if tbData == nil then
      tbData = {}
      printError("json文本配置格式有误，该文本为：" .. sJson)
    end
  end
  return tbData
end

function IsStartsWith(str, start)
  return string.sub(str, 1, string.len(start)) == start
end

function UFT8ToUnicode(convertStr)
  if type(convertStr) ~= "string" then
    return convertStr
  end
  local resultDec = 0
  local i = 1
  local num1 = string.byte(convertStr, i)
  if num1 ~= nil then
    local tempVar1, tempVar2 = 0, 0
    if 0 <= num1 and num1 <= 127 then
      tempVar1 = num1
      tempVar2 = 0
    elseif num1 & 224 == 192 then
      local t1 = 0
      local t2 = 0
      t1 = num1 & 31
      i = i + 1
      num1 = string.byte(convertStr, i)
      t2 = num1 & 63
      tempVar1 = t2 | (t1 & 3) << 6
      tempVar2 = t1 >> 2
    elseif num1 & 240 == 224 then
      local t1 = 0
      local t2 = 0
      local t3 = 0
      t1 = num1 & 31
      i = i + 1
      num1 = string.byte(convertStr, i)
      t2 = num1 & 63
      i = i + 1
      num1 = string.byte(convertStr, i)
      t3 = num1 & 63
      tempVar1 = (t2 & 3) << 6 | t3
      tempVar2 = t1 << 4 | t2 >> 2
    end
    resultDec = tempVar2 * 256 + tempVar1
  end
  return resultDec
end

function AddKrParticle(str, nParticleIdx)
  local function is_korean(cp)
    return 4352 <= cp and cp <= 4607 or 12592 <= cp and cp <= 12687 or 44032 <= cp and cp <= 55215 or 43360 <= cp and cp <= 43391 or 55216 <= cp and cp <= 55295
  end
  
  local function is_al(cp)
    return 65 <= cp and cp <= 90 or 97 <= cp and cp <= 122
  end
  
  local start = utf8.offset(str, -1)
  local lastChar = string.sub(str, start)
  local codePoint = utf8.codepoint(lastChar)
  if is_korean(codePoint) then
    local modResult = (codePoint - 44032) % 28
    if modResult == 0 then
      local charTag = AllEnum.KrTags["1"][nParticleIdx]
      if charTag ~= nil then
        str = str .. charTag
      end
    else
      local charTag = AllEnum.KrTags["2"][nParticleIdx]
      if charTag ~= nil then
        str = str .. charTag
      end
    end
  elseif is_al(codePoint) then
    local charTag = AllEnum.KrTags[1][nParticleIdx]
    if charTag ~= nil then
      str = str .. charTag
    end
  end
  return str
end

function ParseLanguageParam(sParam)
  local param, lang, num = sParam:match("^(.-)_([a-zA-Z]+)(%d+)$")
  if not param then
    return sParam, nil, nil
  end
  return param, lang, tonumber(num)
end

function LanguagePost(sLang, nIdx, sStr)
  if sLang == "kr" and nIdx ~= nil then
    return AddKrParticle(sStr, nIdx)
  end
  return sStr
end

function RefreshRemainTime(endTime, txtComp)
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local remainTime = endTime - curTime
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  NovaAPI.SetTMPText(txtComp, sTimeStr)
  return remainTime
end

local function DecodeChangeInfo(mapChangeInfo)
  local mapDecodedChangeInfo = {}
  if type(mapChangeInfo) ~= "table" then
    return mapDecodedChangeInfo
  end
  if mapChangeInfo.Props == nil then
    return mapDecodedChangeInfo
  end
  for nIndex, mapGoogleProtobufAny in ipairs(mapChangeInfo.Props) do
    if mapGoogleProtobufAny.type_url == "" or mapGoogleProtobufAny.type_url == nil then
      printError("ChangeInfo 格式错误")
      return mapDecodedChangeInfo
    end
    local tbSubUrl = string.split(mapGoogleProtobufAny.type_url, "/")
    local sProtoMsgName = tbSubUrl[2]
    local mapDecodedData = PB.decode(sProtoMsgName, mapGoogleProtobufAny.value)
    if mapDecodedChangeInfo[sProtoMsgName] == nil then
      mapDecodedChangeInfo[sProtoMsgName] = {}
    end
    table.insert(mapDecodedChangeInfo[sProtoMsgName], mapDecodedData)
  end
  return mapDecodedChangeInfo
end

local function OpenReceiveByChangeInfo(mapChangeInfo, callback, sTip, nTitleType, mapNpc)
  local mapReward = PlayerData.Item:ProcessRewardChangeInfo(mapChangeInfo)
  UTILS.OpenReceiveByReward(mapReward, callback, sTip, nTitleType, mapNpc)
end

local function OpenReceiveByDisplayItem(tbItem, mapChangeInfo, callback, sTip, nTitleType, mapNpc)
  local mapTrans = PlayerData.Item:ProcessTransChangeInfo(mapChangeInfo)
  local tbReward, tbSpReward = PlayerData.Item:ProcessRewardDisplayItem(tbItem, mapTrans)
  local mapReward = {
    tbReward = tbReward,
    tbSpReward = tbSpReward,
    tbSrc = mapTrans.tbSrc,
    tbDst = mapTrans.tbDst
  }
  UTILS.OpenReceiveByReward(mapReward, callback, sTip, nTitleType, mapNpc)
end

local function OpenReceiveByReward(mapReward, callback, sTip, nTitleType, mapNpc)
  local bOverflow = PlayerData.State:GetMailOverflow()
  
  local function open_mail()
    if bOverflow then
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        sContent = ConfigTable.GetUIText("Mail_Overflow_Tip"),
        callbackConfirm = callback
      })
      PlayerData.State:SetMailOverflow(false)
    elseif callback then
      callback()
    end
  end
  
  local function open_trans()
    local tbSrc, tbDst = {}, {}
    local mapOverTrans = PlayerData.Item:GetFragmentsOverflow()
    if mapOverTrans and mapOverTrans.tbSrc and #mapOverTrans.tbSrc > 0 then
      for _, v in ipairs(mapOverTrans.tbSrc) do
        table.insert(tbSrc, v)
      end
      for _, v in ipairs(mapOverTrans.tbDst) do
        table.insert(tbDst, v)
      end
    end
    if mapReward and mapReward.tbSrc and #mapReward.tbSrc > 0 then
      for _, v in ipairs(mapReward.tbSrc) do
        table.insert(tbSrc, v)
      end
      for _, v in ipairs(mapReward.tbDst) do
        table.insert(tbDst, v)
      end
    end
    if 0 < #tbDst and 0 < #tbSrc then
      EventManager.Hit(EventId.OpenPanel, PanelId.ReceiveAutoTrans, tbSrc, tbDst, open_mail)
    else
      open_mail()
    end
  end
  
  local function open_normal()
    if mapReward and mapReward.tbReward and #mapReward.tbReward > 0 then
      if mapNpc then
        EventManager.Hit(EventId.OpenPanel, PanelId.ReceivePropsNPC, mapReward.tbReward, mapNpc, open_trans, nTitleType)
      else
        EventManager.Hit(EventId.OpenPanel, PanelId.ReceivePropsTips, mapReward.tbReward, open_trans, sTip, nTitleType)
      end
    else
      open_trans()
    end
  end
  
  if mapReward and mapReward.tbSpReward and #mapReward.tbSpReward > 0 then
    EventManager.Hit(EventId.OpenPanel, PanelId.ReceiveSpecialReward, mapReward.tbSpReward, open_normal)
  else
    open_normal()
  end
end

local strLengthConfig = {
  {
    tbRange = {
      {11904, 12255},
      {13312, 19903},
      {19968, 40959}
    },
    sType = "中文",
    nCount = 2
  },
  {
    tbRange = {
      {4352, 4607},
      {12592, 12687},
      {44032, 55215}
    },
    sType = "韩文",
    nCount = 2
  },
  {
    tbRange = {
      {12352, 12543},
      {12784, 12799}
    },
    sType = "日文",
    nCount = 2
  },
  {
    tbRange = {
      {65280, 65519}
    },
    sType = "全角符号",
    nCount = 2
  }
}

local function GetParamStrLen(sParam)
  sParam = string.gsub(sParam, "</?[^>]+>", "")
  local nLength = 0
  local nIndex = 1
  while true do
    local curByte = string.byte(sParam, nIndex)
    local byteCount = 1
    if 239 < curByte then
      byteCount = 4
    elseif 223 < curByte then
      byteCount = 3
    elseif 128 < curByte then
      byteCount = 2
    elseif curByte == 10 then
      byteCount = 1
    else
      byteCount = 1
    end
    local subStr = string.sub(sParam, nIndex, nIndex + byteCount - 1)
    local charUnicodeNum = UFT8ToUnicode(subStr)
    local bContains = false
    local nAddCount = 1
    for _, v in ipairs(strLengthConfig) do
      local tbRange = v.tbRange
      for _, range in ipairs(tbRange) do
        if charUnicodeNum >= range[1] and charUnicodeNum <= range[2] then
          bContains = true
          nAddCount = v.nCount
          break
        end
      end
      if bContains then
        break
      end
    end
    nLength = nLength + nAddCount
    nIndex = nIndex + byteCount
    if nIndex > #sParam then
      break
    end
  end
  return nLength
end

local function ParseByteString(sByte)
  return {
    string.byte(sByte, 1, -1)
  }
end

local function IsBitSet(tbByte, nIndex)
  local nGroup64 = math.ceil(nIndex / 64) - 1
  local nIndexInGroup64 = nIndex - nGroup64 * 64
  local nGroup8 = math.ceil(nIndexInGroup64 / 8) - 1
  local nIndexInGroup8 = nIndexInGroup64 - nGroup8 * 8
  local nByteTableIndex = 8 - nGroup8 + nGroup64 * 8
  if not tbByte[nByteTableIndex] then
    return false
  end
  return 1 << nIndexInGroup8 - 1 & tbByte[nByteTableIndex] > 0
end

local function SetBit(tbByte, nIndex)
  assert(1 <= nIndex and nIndex % 1 == 0, "nIndex must be a positive integer")
  local nGroup64 = math.ceil(nIndex / 64) - 1
  local nIndexInGroup64 = nIndex - nGroup64 * 64
  local nGroup8 = math.ceil(nIndexInGroup64 / 8) - 1
  local nIndexInGroup8 = nIndexInGroup64 - nGroup8 * 8
  local nByteTableIndex = 8 - nGroup8 + nGroup64 * 8
  for nByteIndex = 1, (nGroup64 + 1) * 8 do
    if tbByte[nByteIndex] == nil then
      tbByte[nByteIndex] = 0
    end
  end
  local nMask = 1 << nIndexInGroup8 - 1
  tbByte[nByteTableIndex] = tbByte[nByteTableIndex] | nMask
end

local function GetBuildAttributeId(nGroupId, nLevel)
  return nGroupId * 100000 + nLevel
end

local function GetCharacterAttributeId(nCharId, nAdvance, nLevel)
  return nCharId * 100000 + nAdvance * 1000 + nLevel
end

local function GetDiscAttributeId(nGroupId, nPhase, nLevel)
  return nGroupId * 1000 + nPhase * 100 + nLevel
end

local function GetSoldierTempleteAttrId(nTemplateId, nStar)
  return nTemplateId * 1000 + nStar * 10 + 1
end

local function GetDiscExtraAttributeId(nGroupId, nStar)
  return nGroupId * 10 + nStar
end

local function GetPotentialId(nCharId, nIndex)
  return 500000 + nCharId * 100 + nIndex
end

local function ParseNoBrokenDesc(sDesc)
  if Settings.sCurrentTxtLanguage == AllEnum.Language.EN or Settings.sCurrentTxtLanguage == AllEnum.Language.KR then
    return sDesc
  else
    return "<nobr>" .. sDesc .. "</nobr>"
  end
end

local function SubDesc(str, nLevel, nCompareLevel, mapLinkParam)
  local ConfigData = require("GameCore.Data.ConfigData")
  
  local function SubDescLink(originStr, mapParam)
    if originStr == nil or originStr == "" then
      return ""
    end
    local mapWord = {}
    for word in string.gmatch(originStr, "##.-#%d%d%d%d#") do
      if mapWord[word] == nil then
        local sWordId = string.match(word, "%d%d%d%d")
        local nWordId = tonumber(sWordId)
        if nWordId == nil then
          printError("词条 id 错误:" .. sWordId)
          mapWord[word] = sWordId
        else
          local mapWordData = ConfigTable.GetData("Word", nWordId)
          if mapWordData == nil or mapWordData.Icon == "" then
            printError("该词条 id 找不到数据:" .. sWordId)
            if mapWordData and mapWordData.Icon == "" then
              printError("该词条 id 找不到Icon:" .. sWordId)
            end
            mapWord[word] = string.format("<color=#FF0000>%s</color>", sWordId)
          elseif mapWordData.Type == GameEnum.wordLinkType.Word then
            mapWord[word] = string.format("<color=#%s><link=\"%d\"><u>%s</u>%s</link></color>", mapWordData.Color, mapWordData.Id, mapWordData.Title, mapWordData.TitleIcon)
          elseif mapWordData.Type == GameEnum.wordLinkType.Potential then
            if mapParam == nil or mapParam.nCharId == nil then
              printError("该<潜能>词条 id 找不到角色:" .. sWordId)
              mapWord[word] = string.format("<color=#FF0000>%s</color>", sWordId)
            else
              local nPotentialId = GetPotentialId(mapParam.nCharId, tonumber(mapWordData.Param1))
              local mapItemCfg = ConfigTable.GetData_Item(nPotentialId)
              local sTitle = mapItemCfg and mapItemCfg.Title or mapWordData.Title
              mapWord[word] = string.format("<color=#%s><link=\"%d\"><u>%s</u></link></color>", mapWordData.Color, mapWordData.Id, sTitle)
            end
          end
        end
      end
    end
    for word, finalStr in pairs(mapWord) do
      originStr = string.gsub(originStr, word, finalStr)
    end
    return originStr
  end
  
  local function ParseHitDamageDesc(nHitDamageId, nHitDamageLevel)
    local mapDamage = ConfigTable.GetData_HitDamage(nHitDamageId)
    if not mapDamage then
      return string.format("<color=#BD3059>该 hit damage id 找不到数据:%s</color>", nHitDamageId)
    end
    local nPercent = mapDamage.SkillPercentAmend[nHitDamageLevel]
    local nAbs = mapDamage.SkillAbsAmend[nHitDamageLevel]
    if not nPercent or not nAbs then
      return string.format("<color=#BD3059>该技能等级在 HitDamage 表中找不到数据, hit damage id:%d, level:%d</color>", nHitDamageId, nHitDamageLevel)
    end
    nPercent = nPercent * ConfigData.IntFloatPrecision
    nPercent = FormatNum(nPercent)
    nAbs = FormatNum(nAbs)
    local sPercent = nPercent == 0 and "" or tostring(nPercent) .. "%%"
    local sAbs = nAbs == 0 and "" or tostring(nAbs)
    if nPercent ~= 0 and nAbs ~= 0 then
      return sPercent .. "+" .. sAbs
    else
      return sPercent .. sAbs
    end
  end
  
  local function GetValueKey(nDataId, nType, nValueLevel)
    local ret = nDataId
    if nType == GameEnum.levelTypeData.Exclusive or nType == GameEnum.levelTypeData.SkillSlot then
      ret = nDataId + nValueLevel * 10
    elseif nType == GameEnum.levelTypeData.OutfitPromote then
    else
      if nType == GameEnum.levelTypeData.OutfifBreak then
      else
      end
    end
    return ret
  end
  
  local function ParseEffectDesc(nEffectId, nEffectLevel, nShowType)
    local mapEffectCfgData = ConfigTable.GetData_Effect(nEffectId)
    if mapEffectCfgData == nil then
      return string.format("<color=#BD3059>该EffectId找不到数据:%s</color>", nEffectId)
    end
    local nValueKey = GetValueKey(nEffectId, mapEffectCfgData.levelTypeData, nEffectLevel)
    local mapEffectValueData = ConfigTable.GetData("EffectValue", nValueKey)
    if mapEffectValueData == nil then
      return string.format("<color=#BD3059>该EffectId和等级找不到Value数据:%s，%s</color>", nEffectId, nEffectLevel)
    end
    local sValue = mapEffectValueData.EffectTypeParam1
    local nValue = tonumber(sValue)
    if nValue == nil then
      return string.format("<color=#BD3059>该EffectValueId配置的数据不支持显示:%s</color>", nValueKey)
    end
    nValue = math.abs(nValue)
    if nShowType == 1 then
      nValue = nValue * 100
      return nValue .. "%%"
    end
    return tostring(nValue)
  end
  
  local function ParseOnceDesc(nOnceId, nOnceLevel, nShowType)
    local mapCfgData = ConfigTable.GetData("OnceAdditionalAttribute", nOnceId)
    if mapCfgData == nil then
      return string.format("<color=#BD3059>该OnceAdditionalAttributeId找不到数据:%s</color>", nOnceId)
    end
    local nValueKey = GetValueKey(nOnceId, mapCfgData.levelTypeData, nOnceLevel)
    local mapValueData = ConfigTable.GetData("OnceAdditionalAttributeValue", nValueKey)
    if mapValueData == nil then
      return string.format("<color=#BD3059>该OnceAdditionalAttributeId和等级找不到Value数据:%s，%s，%s</color>", nOnceId, nOnceLevel, nValueKey)
    end
    local nValue = mapValueData.Value1 * ConfigData.IntFloatPrecision
    nValue = math.abs(nValue)
    if nShowType == 1 then
      nValue = nValue * 100
      return nValue .. "%%"
    end
    return tostring(nValue)
  end
  
  local function ParseShieldDesc(nShieldId, nShieldLevel, nShowType)
    local mapCfgData = ConfigTable.GetData("Shield", nShieldId)
    if mapCfgData == nil then
      return string.format("<color=#BD3059>该ShieldId找不到数据:%s</color>", nShieldId)
    end
    local nValueKey = GetValueKey(nShieldId, mapCfgData.levelTypeData, nShieldLevel)
    local mapValueData = ConfigTable.GetData("ShieldValue", nValueKey)
    if mapValueData == nil then
      return string.format("<color=#BD3059>该ShieldId和等级找不到Value数据:%s，%s</color>", nShieldId, nShieldLevel)
    end
    local nValue = mapValueData.ReferenceScale
    nValue = nValue * ConfigData.IntFloatPrecision
    nValue = math.abs(nValue)
    if nShowType == 1 then
      nValue = nValue * 100
      return nValue .. "%%"
    end
    return tostring(nValue)
  end
  
  local function ParseSriptDesc(nSriptId, nSriptLevel, nShowType)
    local mapCfgData = ConfigTable.GetData("ScriptParameter", nSriptId)
    if mapCfgData == nil then
      return string.format("<color=#BD3059>该SriptId找不到数据:%s</color>", nSriptId)
    end
    local nValueKey = GetValueKey(nSriptId, mapCfgData.levelTypeData, nSriptLevel)
    local mapValueData = ConfigTable.GetData("ScriptParameterValue", nValueKey)
    if mapValueData == nil then
      return string.format("<color=#BD3059>该SriptId和等级找不到Value数据:%s，%s</color>", nSriptId, nSriptLevel)
    end
    local nValue = mapValueData.CommonData
    nValue = nValue * ConfigData.IntFloatPrecision
    nValue = math.abs(nValue)
    if nShowType == 1 then
      nValue = nValue * 100
      return nValue .. "%%"
    end
    return tostring(nValue)
  end
  
  local linkStr = SubDescLink(str, mapLinkParam)
  if nLevel == nil then
    return linkStr
  end
  local mapWord = {}
  for word in string.gmatch(linkStr, "&.-&") do
    local paramStr = string.gsub(word, "&", "")
    print(paramStr)
    local tbParam = string.split(paramStr, ",")
    local sTable = tbParam[1]
    local sKey = tbParam[2]
    local sShowType = tbParam[3]
    local nShowType = tonumber(sShowType)
    if nShowType == nil then
      nShowType = 0
    end
    if sTable == nil or sKey == nil then
      mapWord[word] = string.format("<color=#BD3059>配置错误，无法读取对应表名和ID：%s</color>", word)
    else
      local nKey = tonumber(sKey)
      if nKey == nil then
        mapWord[word] = string.format("<color=#BD3059>表ID配置错误，无法转为number：%s</color>", word)
      elseif sTable == "HitDamage" then
        local subStr = ParseHitDamageDesc(nKey, nLevel)
        if nCompareLevel ~= nil then
          local sCompareStr = ParseHitDamageDesc(nKey, nCompareLevel)
          if nLevel < nCompareLevel then
            subStr = string.format("%s<color=#8cac59>(%s↑)</color>", subStr, sCompareStr)
          else
            subStr = string.format("%s<color=#e74470>(%s↓)</color>", subStr, sCompareStr)
          end
        end
        mapWord[word] = subStr
      elseif sTable == "Effect" then
        local subStr = ParseEffectDesc(nKey, nLevel, nShowType)
        if nCompareLevel ~= nil then
          local sCompareStr = ParseEffectDesc(nKey, nCompareLevel, nShowType)
          if nLevel < nCompareLevel then
            subStr = string.format("%s<color=#8cac59>(%s↑)</color>", subStr, sCompareStr)
          else
            subStr = string.format("%s<color=#e74470>(%s↓)</color>", subStr, sCompareStr)
          end
        end
        mapWord[word] = subStr
      elseif sTable == "Once" then
        local subStr = ParseOnceDesc(nKey, nLevel, nShowType)
        if nCompareLevel ~= nil then
          local sCompareStr = ParseOnceDesc(nKey, nCompareLevel, nShowType)
          if nLevel < nCompareLevel then
            subStr = string.format("%s<color=#8cac59>(%s↑)</color>", subStr, sCompareStr)
          else
            subStr = string.format("%s<color=#e74470>(%s↓)</color>", subStr, sCompareStr)
          end
        end
        mapWord[word] = subStr
      elseif sTable == "Shield" then
        local subStr = ParseShieldDesc(nKey, nLevel, nShowType)
        if nCompareLevel ~= nil then
          local sCompareStr = ParseShieldDesc(nKey, nCompareLevel, nShowType)
          if nLevel < nCompareLevel then
            subStr = string.format("%s<color=#8cac59>(%s↑)</color>", subStr, sCompareStr)
          else
            subStr = string.format("%s<color=#e74470>(%s↓)</color>", subStr, sCompareStr)
          end
        end
        mapWord[word] = subStr
      elseif sTable == "Script" then
        local subStr = ParseSriptDesc(nKey, nLevel, nShowType)
        if nCompareLevel ~= nil then
          local sCompareStr = ParseSriptDesc(nKey, nCompareLevel, nShowType)
          if nLevel < nCompareLevel then
            subStr = string.format("%s<color=#8cac59>(%s↑)</color>", subStr, sCompareStr)
          else
            subStr = string.format("%s<color=#e74470>(%s↓)</color>", subStr, sCompareStr)
          end
        end
        mapWord[word] = subStr
      else
        mapWord[word] = string.format("<color=#BD3059>未支持的表名：%s</color>", word)
      end
    end
  end
  for word, finalStr in pairs(mapWord) do
    linkStr = string.gsub(linkStr, word, finalStr)
  end
  return ParseNoBrokenDesc(linkStr)
end

local function ParseDesc(mapDescConfig, nCompareLevelType, nCompareLevel, bSimple, nOverrideLevel, mapLinkParam)
  if mapDescConfig == nil then
    printError("解析描述失败!")
    return ""
  end
  local ConfigData = require("GameCore.Data.ConfigData")
  local str = bSimple and mapDescConfig.BriefDesc or mapDescConfig.Desc
  
  local function GetValueKey(nDataId, nType, nValueLevel)
    return nDataId + nValueLevel * 10
  end
  
  local function TryAddMaxMark(mapValueTable, levelTypeData, nLevel, nId, sParameter)
    if levelTypeData == GameEnum.levelTypeData.Exclusive then
      local sMark = ConfigTable.GetUIText("Potential_ValueMax_HInt")
      local nValue1 = GetValueKey(nId, levelTypeData, 1)
      local nValue9 = GetValueKey(nId, levelTypeData, 9)
      local nValue = GetValueKey(nId, levelTypeData, nLevel)
      local mapValueData = mapValueTable[nValue]
      local mapValueData1 = mapValueTable[nValue1]
      local mapValueData9 = mapValueTable[nValue9]
      if mapValueData == nil or mapValueData1 == nil or mapValueData9 == nil then
        return
      end
      local sValue = mapValueData[sParameter]
      local sValue1 = mapValueData1[sParameter]
      local sValue9 = mapValueData9[sParameter]
      if sValue ~= sValue1 and sValue == sValue9 then
        return sMark
      end
    end
    return
  end
  
  local function SubDescLink(originStr, mapParam)
    if originStr == nil or originStr == "" then
      return ""
    end
    local mapWord = {}
    for word in string.gmatch(originStr, "##.-#%d%d%d%d#") do
      if mapWord[word] == nil then
        local sWordId = string.match(word, "%d%d%d%d")
        local nWordId = tonumber(sWordId)
        if nWordId == nil then
          printError("词条 id 错误:" .. sWordId)
          mapWord[word] = sWordId
        else
          local mapWordData = ConfigTable.GetData("Word", nWordId)
          if mapWordData == nil or mapWordData.Icon == "" then
            printError("该词条 id 找不到数据:" .. sWordId)
            if mapWordData and mapWordData.Icon == "" then
              printError("该词条 id 找不到Icon:" .. sWordId)
            end
            mapWord[word] = string.format("<color=#FF0000>%s</color>", sWordId)
          elseif mapWordData.Type == GameEnum.wordLinkType.Word then
            mapWord[word] = string.format("<color=#%s><link=\"%d\"><u>%s</u>%s</link></color>", mapWordData.Color, mapWordData.Id, mapWordData.Title, mapWordData.TitleIcon)
          elseif mapWordData.Type == GameEnum.wordLinkType.Potential then
            if mapParam == nil or mapParam.nCharId == nil then
              printError("该<潜能>词条 id 找不到角色:" .. sWordId)
              mapWord[word] = string.format("<color=#FF0000>%s</color>", sWordId)
            else
              local nPotentialId = GetPotentialId(mapParam.nCharId, tonumber(mapWordData.Param1))
              local mapItemCfg = ConfigTable.GetData_Item(nPotentialId)
              local sTitle = mapItemCfg and mapItemCfg.Title or mapWordData.Title
              mapWord[word] = string.format("<color=#%s><link=\"%d\"><u>%s</u></link></color>", mapWordData.Color, mapWordData.Id, sTitle)
            end
          end
        end
      end
    end
    for word, finalStr in pairs(mapWord) do
      originStr = string.gsub(originStr, word, finalStr)
    end
    return originStr
  end
  
  local linkStr = SubDescLink(str, mapLinkParam)
  
  local function ParseHitDamageDesc(nHitDamageId, nHitDamageLevel)
    local sDesc = ""
    local mapDamage = ConfigTable.GetData_HitDamage(nHitDamageId)
    if not mapDamage then
      sDesc = string.format("<color=#BD3059>该 hit damage id 找不到数据:%s</color>", nHitDamageId)
      return sDesc
    end
    local levelType = mapDamage.levelTypeData
    if levelType == GameEnum.levelTypeData.BreakCount then
      if nHitDamageLevel < 1 then
        nHitDamageLevel = 1 or nHitDamageLevel
      end
    elseif levelType == GameEnum.levelTypeData.None then
      nHitDamageLevel = 1
    end
    local nPercent = mapDamage.SkillPercentAmend[nHitDamageLevel]
    local nAbs = mapDamage.SkillAbsAmend[nHitDamageLevel]
    if not nPercent or not nAbs then
      sDesc = string.format("<color=#BD3059>该技能等级在 HitDamage 表中找不到数据, hit damage id:%d, level:%d</color>", nHitDamageId, nHitDamageLevel)
      return sDesc
    end
    nPercent = nPercent * ConfigData.IntFloatPrecision
    nPercent = FormatNum(nPercent)
    nAbs = FormatNum(nAbs)
    local sPercent = nPercent == 0 and "" or tostring(nPercent) .. "%%"
    local sAbs = nAbs == 0 and "" or tostring(nAbs)
    if nPercent ~= 0 and nAbs ~= 0 then
      sDesc = sPercent .. "+" .. sAbs
    else
      sDesc = sPercent .. sAbs
    end
    return sDesc
  end
  
  local function FormatValueShow(sValue, sShowType, sEnumType)
    if sShowType == "Text" then
      return sValue
    elseif sShowType == "Enum" then
      sEnumType = tostring(sEnumType)
      if sEnumType ~= nil then
        local tbEnum = CacheTable.GetData("_EnumDesc", sEnumType)
        if tbEnum ~= nil then
          local nEnumValue = tonumber(sValue)
          if nEnumValue ~= nil then
            if tbEnum[nEnumValue] then
              return ConfigTable.GetUIText(tbEnum[nEnumValue])
            else
              printError(sEnumType .. "枚举未找到值:" .. nEnumValue)
              return nil
            end
          else
            printError("枚举值填写错误:" .. sValue)
            return nil
          end
        else
          printError("枚举类型填写错误:" .. sEnumType)
          return nil
        end
      else
        printError("枚举类型未填写")
        return nil
      end
    else
      local nValue = tonumber(sValue)
      if nValue ~= nil then
        local isIntFloat = sShowType == "10K" or sShowType == "10KPct" or sShowType == "10KHdPct"
        local isPercent = sShowType == "Pct" or sShowType == "HdPct" or sShowType == "10KPct" or sShowType == "10KHdPct"
        local multiHundred = sShowType == "HdPct" or sShowType == "10KHdPct"
        nValue = isIntFloat and nValue * ConfigData.IntFloatPrecision or nValue
        nValue = multiHundred and nValue * 100 or nValue
        nValue = math.abs(nValue)
        nValue = clearFloat(nValue)
        local integer, decimal = math.modf(nValue)
        sValue = decimal < 0.01 and tostring(integer) or tostring(nValue)
        sValue = isPercent and sValue .. "%%" or sValue
        return sValue
      else
        return nil
      end
    end
  end
  
  local function ParseLevelUpDesc(sTable, nId, nLevel, sParameter, sShowType, sEnumType)
    local sDesc, sErrorInfo
    local mapCfgData = DataTable[sTable]
    if mapCfgData ~= nil then
      local sValueTable = sTable .. "Value"
      local mapValueCfgData = DataTable[sValueTable]
      if mapValueCfgData ~= nil then
        local mapData = mapCfgData[nId]
        if mapData ~= nil then
          local nValueId = GetValueKey(nId, mapData.levelTypeData, nLevel)
          local mapValueData = mapValueCfgData[nValueId]
          if mapValueData ~= nil then
            local sValue = mapValueData[sParameter]
            if sValue ~= nil then
              local sMark = TryAddMaxMark(mapValueCfgData, mapData.levelTypeData, nLevel, nId, sParameter)
              sDesc = FormatValueShow(sValue, sShowType, sEnumType)
              if sDesc == nil then
                sErrorInfo = string.format("<color=#BD3059>%s表中该ValueId配置的数据解析失败:%s</color>", sValueTable, nValueId)
              elseif sMark ~= nil then
                sDesc = sDesc .. sMark
              end
            else
              sErrorInfo = string.format("<color=#BD3059>%s表中没有该字段:%s</color>", sValueTable, sParameter)
            end
          else
            sErrorInfo = string.format("<color=#BD3059>%s表中该Id找不到数据:%s</color>", sValueTable, nValueId)
          end
        else
          sErrorInfo = string.format("<color=#BD3059>%s表中该Id找不到数据:%s</color>", sTable, nId)
        end
      else
        sErrorInfo = string.format("<color=#BD3059>找不到该配置表:%s</color>", sValueTable)
      end
    else
      sErrorInfo = string.format("<color=#BD3059>找不到该配置表:%s</color>", sTable)
    end
    if sErrorInfo ~= nil and sErrorInfo ~= "" then
      printError(sErrorInfo)
      sDesc = sErrorInfo
    end
    if sDesc == nil then
      printError("描述解析失败")
      sDesc = ""
    end
    return sDesc
  end
  
  local function ParseNoLevelUpDesc(sTable, nId, sParameter, sShowType, sEnumType)
    local sDesc, sErrorInfo
    local mapCfgData = DataTable[sTable]
    if mapCfgData ~= nil then
      local mapData = mapCfgData[nId]
      if mapData ~= nil then
        local sValue = mapData[sParameter]
        if sValue ~= nil then
          sDesc = FormatValueShow(sValue, sShowType, sEnumType)
          if sDesc == nil then
            sErrorInfo = string.format("<color=#BD3059>%s表中该Id配置的数据解析失败:%s</color>", sTable, nId)
          end
        else
          sErrorInfo = string.format("<color=#BD3059>%s表中没有该字段:%s</color>", sTable, sParameter)
        end
      else
        sErrorInfo = string.format("<color=#BD3059>%s表中该Id找不到数据:%s</color>", sTable, nId)
      end
    else
      sErrorInfo = string.format("<color=#BD3059>找不到该配置表:%s</color>", sTable)
    end
    if sErrorInfo ~= nil and sErrorInfo ~= "" then
      printError(sErrorInfo)
      sDesc = sErrorInfo
    end
    if sDesc == nil then
      printError("描述解析失败")
      sDesc = ""
    end
    return sDesc
  end
  
  local mapWord = {}
  for word in string.gmatch(linkStr, "&.-&") do
    local sParameterKeyOrigin = string.gsub(word, "&", "")
    local sParameterKey, lang, langIdx = ParseLanguageParam(sParameterKeyOrigin)
    local paramStr = mapDescConfig[sParameterKey]
    local tbParam = string.split(paramStr, ",")
    local sTable = tbParam[1]
    local sParseType = tbParam[2]
    local sKey = tbParam[3]
    local sParameter = tbParam[4]
    local sShowType = tbParam[5]
    local sEnumType = tbParam[6]
    if sTable == nil or sKey == nil then
      mapWord[word] = string.format("<color=#BD3059>配置错误，无法读取对应表名和ID：%s</color>", word)
    else
      local mapCfgData = DataTable[sTable]
      if mapCfgData ~= nil then
        local nKey = tonumber(sKey)
        if nKey == nil then
          mapWord[word] = string.format("<color=#BD3059>表ID配置错误，无法转为number：%s</color>", word)
        else
          local mapData = mapCfgData[nKey]
          if mapData ~= nil then
            local nLevel = 1
            nOverrideLevel = tonumber(nOverrideLevel)
            if mapData.levelTypeData == GameEnum.levelTypeData.Exclusive then
              nLevel = UTILS.QueryLevelInfo(mapData.LevelData, mapData.levelTypeData, mapData.LevelData)
            else
              local nCharId = tonumber(string.sub(sKey, 1, 3))
              nLevel = UTILS.QueryLevelInfo(nCharId, mapData.levelTypeData, mapData.LevelData, mapData.MainOrSupport)
            end
            if (mapData.levelTypeData == GameEnum.levelTypeData.Exclusive or mapData.levelTypeData == GameEnum.levelTypeData.Note or mapData.levelTypeData == GameEnum.levelTypeData.SoldierLevel) and nOverrideLevel ~= nil then
              nLevel = nOverrideLevel
            end
            if nCompareLevelType == GameEnum.levelTypeData.SoldierLevel and mapData.levelTypeData == GameEnum.levelTypeData.SkillSlot and nOverrideLevel ~= nil then
              nLevel = nOverrideLevel
            end
            if sParseType == "DamageNum" and sTable == "HitDamage" then
              local subStr = ParseHitDamageDesc(nKey, nLevel)
              subStr = LanguagePost(lang, langIdx, subStr)
              if nCompareLevelType ~= nil and mapData.levelTypeData == nCompareLevelType and nCompareLevel ~= nil then
                local sCompareStr = ParseHitDamageDesc(nKey, nCompareLevel)
                sCompareStr = LanguagePost(lang, langIdx, sCompareStr)
                if subStr ~= sCompareStr then
                  if nCompareLevel > nLevel then
                    subStr = string.format("%s<color=#8cac59>(%s↑)</color>", subStr, sCompareStr)
                  else
                    subStr = string.format("%s<color=#e74470>(%s↓)</color>", subStr, sCompareStr)
                  end
                end
              end
              mapWord[word] = subStr
            elseif sParseType == "LevelUp" then
              local subStr = ParseLevelUpDesc(sTable, nKey, nLevel, sParameter, sShowType, sEnumType)
              subStr = LanguagePost(lang, langIdx, subStr)
              if nCompareLevelType ~= nil and mapData.levelTypeData == nCompareLevelType and nCompareLevel ~= nil then
                local sCompareStr = ParseLevelUpDesc(sTable, nKey, nCompareLevel, sParameter, sShowType, sEnumType)
                sCompareStr = LanguagePost(lang, langIdx, sCompareStr)
                if subStr ~= sCompareStr then
                  if nCompareLevel > nLevel then
                    subStr = string.format("%s<color=#8cac59>(%s↑)</color>", subStr, sCompareStr)
                  else
                    subStr = string.format("%s<color=#e74470>(%s↓)</color>", subStr, sCompareStr)
                  end
                end
              end
              mapWord[word] = subStr
            elseif sParseType == "NoLevel" then
              local str = ParseNoLevelUpDesc(sTable, nKey, sParameter, sShowType, sEnumType)
              str = LanguagePost(lang, langIdx, str)
              mapWord[word] = str
            end
          else
            mapWord[word] = string.format("<color=#BD3059>%s表中该Id找不到数据:%s</color>", sTable, nKey)
          end
        end
      else
        mapWord[word] = string.format("<color=#BD3059>找不到该配置表:%s</color>", sTable)
      end
    end
  end
  for word, finalStr in pairs(mapWord) do
    linkStr = string.gsub(linkStr, word, finalStr)
  end
  return ParseNoBrokenDesc(linkStr)
end

local function ParseDiscDesc(originStr, mapSkill, mapSkillNext, nLayer, mapLinkParam)
  originStr = UTILS.SubDesc(originStr, nil, nil, mapLinkParam)
  local mapWord = {}
  for word in string.gmatch(originStr, "{[0-9]*}") do
    if mapWord[word] == nil then
      local nCurLayer = nLayer
      local sWordId = string.sub(word, 2, #word - 1)
      local nWordId = tonumber(sWordId)
      if nWordId == nil then
        printError("wordId error:" .. sWordId)
        mapWord[word] = sWordId
      else
        local fieldName = "Param" .. nWordId
        if nCurLayer then
          local nMaxStringCount = #mapSkill[fieldName]
          if nCurLayer > nMaxStringCount then
            nCurLayer = nMaxStringCount
          end
          for k, v in ipairs(mapSkill[fieldName]) do
            if nCurLayer == k then
              mapWord[word] = v
            end
          end
        elseif mapSkillNext and mapSkill[fieldName] ~= mapSkillNext[fieldName] then
          mapWord[word] = mapSkill[fieldName] .. "<color=#8cac59>(" .. mapSkillNext[fieldName] .. "↑)</color>"
        else
          mapWord[word] = mapSkill[fieldName]
        end
        if not mapWord[word] then
          mapWord[word] = "{未找到参数配置}"
        end
        mapWord[word] = string.gsub(mapWord[word], "%%", "%%%%")
      end
    end
  end
  for word, finalStr in pairs(mapWord) do
    originStr = string.gsub(originStr, word, finalStr)
  end
  return ParseNoBrokenDesc(originStr)
end

local function ParseParamDesc(originStr, mapCfg, mapCfgNext, mapLinkParam, sColor)
  originStr = UTILS.SubDesc(originStr, nil, nil, mapLinkParam)
  local mapWord = {}
  for word in string.gmatch(originStr, "{[0-9]*}") do
    if mapWord[word] == nil then
      local sWordId = string.sub(word, 2, #word - 1)
      local nWordId = tonumber(sWordId)
      if nWordId == nil then
        printError("wordId error:" .. sWordId)
        mapWord[word] = sWordId
      else
        local fieldName = "Param" .. nWordId
        if mapCfgNext and mapCfg[fieldName] ~= mapCfgNext[fieldName] then
          mapWord[word] = mapCfg[fieldName] .. "<color=#8cac59>(" .. mapCfgNext[fieldName] .. "↑)</color>"
        elseif sColor then
          mapWord[word] = "<color=" .. sColor .. ">" .. mapCfg[fieldName] .. "</color>"
        else
          mapWord[word] = mapCfg[fieldName]
        end
        if not mapWord[word] then
          mapWord[word] = "{未找到参数配置}"
        end
        mapWord[word] = string.gsub(mapWord[word], "%%", "%%%%")
      end
    end
  end
  for word, finalStr in pairs(mapWord) do
    originStr = string.gsub(originStr, word, finalStr)
  end
  return ParseNoBrokenDesc(originStr)
end

local function ParseRewardItemCount(tbReward)
  if nil == tbReward then
    return -1
  end
  if #tbReward < 3 then
    printError("物品数量配置错误，应有至少3个参数")
    return -1
  end
  if #tbReward == 3 then
    return tbReward[2]
  elseif 3 < #tbReward then
    local countTxt = tbReward[2] .. "~" .. tbReward[3]
    return countTxt
  end
  return -1
end

local function QueryLevelInfo(nId, nType, nParam1, nParam2)
  local ret
  ret = PlayerData.StarTower:QueryLevelInfo(nId, nType, nParam1, nParam2)
  if ret == nil then
    ret = PlayerData.Char:QueryLevelInfo(nId, nType, nParam1, nParam2)
  end
  return ret
end

local function ParseLevelQuestTargetDesc(originStr, mapTarget)
  local mapSkillType = {
    [GameEnum.LevelQuestTargetType.CastSkill] = true,
    [GameEnum.LevelQuestTargetType.CastSkillEnd] = true
  }
  local mapWord = {}
  for word in string.gmatch(originStr, "{Param" .. "[0-9]*}") do
    if mapWord[word] == nil then
      local fieldName = string.sub(word, 2, #word - 1)
      local sParam = mapTarget[fieldName]
      if mapTarget.QuestType == GameEnum.LevelQuestTargetType.KillMonster and fieldName == "Param2" or mapTarget.QuestType == GameEnum.LevelQuestTargetType.KillMonsterByDamageTag and fieldName == "Param3" then
        local nMonsterId = tonumber(sParam)
        local sMonsterName = sParam
        if nMonsterId then
          local monsterData = ConfigTable.GetData("Monster", nMonsterId)
          if monsterData then
            local monsterSkin = ConfigTable.GetData("MonsterSkin", monsterData.FAId)
            if monsterSkin then
              local monsterManual = ConfigTable.GetData("MonsterManual", monsterSkin.MonsterManual)
              if monsterManual then
                sMonsterName = monsterManual.Name
              end
            end
          end
        end
        sParam = sMonsterName
      elseif mapSkillType[mapTarget.QuestType] and fieldName == "Param2" then
        local nSkillId = tonumber(sParam)
        local sSkillName = sParam
        if nSkillId then
          local mapCfg = ConfigTable.GetData("Skill", nSkillId)
          if mapCfg then
            sSkillName = mapCfg.Title
          end
        end
        sParam = sSkillName
      end
      mapWord[word] = "<color=#2be1f1>" .. sParam .. "</color>"
    end
    if not mapWord[word] then
      mapWord[word] = "{未找到参数配置}"
    end
    mapWord[word] = string.gsub(mapWord[word], "%%", "%%%%")
  end
  for word, finalStr in pairs(mapWord) do
    originStr = string.gsub(originStr, word, finalStr)
  end
  return originStr
end

local function GetLevelQuestTargetProcess(mapTarget, nCur)
  local mapSkipProcess = {
    [GameEnum.LevelQuestTargetType.ReceiveTriggerOpId] = true,
    [GameEnum.LevelQuestTargetType.Null] = true,
    [GameEnum.LevelQuestTargetType.RecoverEnergy] = true,
    [GameEnum.LevelQuestTargetType.KillAllMonster] = true
  }
  if mapSkipProcess[mapTarget.QuestType] then
    return ""
  end
  if nCur then
    return "<color=#2be1f1>(" .. nCur .. "/" .. mapTarget.Param1 .. ")</color>"
  else
    return "<color=#2be1f1>(0/" .. mapTarget.Param1 .. ")</color>"
  end
end

local function GetBezierPointByT(beginPos, handlePos, endPos, deltaTime)
  local pow = (1 - deltaTime) ^ 2
  local x = pow * beginPos.x + 2 * deltaTime * (1 - deltaTime) * handlePos.x + deltaTime * deltaTime * endPos.x
  local y = pow * beginPos.y + 2 * deltaTime * (1 - deltaTime) * handlePos.y + deltaTime * deltaTime * endPos.y
  local z = pow * beginPos.z + 2 * deltaTime * (1 - deltaTime) * handlePos.z + deltaTime * deltaTime * endPos.z
  return x, y, z
end

local _
_, Red_Unable = ColorUtility.TryParseHtmlString("#BD3059")
_, Blue_Normal = ColorUtility.TryParseHtmlString("#264278")
_, Blue_Dark = ColorUtility.TryParseHtmlString("#3B62AE")
_, White_Normal = ColorUtility.TryParseHtmlString("#FAFAFA")
_, White_Dark = ColorUtility.TryParseHtmlString("#2d4257")
_, Gray_Dark = ColorUtility.TryParseHtmlString("#505c67")

local function AddEffect(nCharId, nEffectId, nLevel, nUseCount)
  if nUseCount == nil then
    nUseCount = 0
  end
  local mapEftCfgData = ConfigTable.GetData_Effect(nEffectId)
  if mapEftCfgData == nil then
    printError("Effect Id missing" .. nEffectId)
    return nil
  end
  local nEffectValueId = nEffectId
  if mapEftCfgData.levelTypeData ~= GameEnum.levelTypeData.None then
    nEffectValueId = nEffectValueId + nLevel * 10
  end
  local mapEftValueData = ConfigTable.GetData("EffectValue", nEffectValueId)
  if mapEftValueData == nil then
    printError("EffectValue Id missing" .. nEffectValueId)
    return nil
  end
  local nEftRemainTimes = -1
  if mapEftValueData.TakeEffectLimit ~= 0 then
    nEftRemainTimes = mapEftValueData.TakeEffectLimit - nUseCount
    if nEftRemainTimes <= 0 then
      printLog("效果次数已用完:" .. nEffectId)
      return nil
    end
  end
  local nEffectUid = safe_call_cs_func(CS.AdventureModuleHelper.SetActorEffect, nCharId, nEffectId, nEftRemainTimes, 0)
  return nEffectUid
end

local function AddFateCardEft(nCharId, nEffectId, nRemainCount)
  if nRemainCount == 0 then
    printLog("效果次数已用完:" .. nEffectId)
    return nil
  end
  local nEffectUid = safe_call_cs_func(CS.AdventureModuleHelper.SetActorEffect, nCharId, nEffectId, nRemainCount, 0)
  return nEffectUid
end

local function AddBuildEffect(mapCharEffect, mapDiscEffect, mapNoteEffect)
  local retCharEffect = {}
  local retDiscEffect = {}
  local retNoteEffect = {}
  for nCharId, mapEffect in pairs(mapCharEffect) do
    if mapEffect[AllEnum.EffectType.Affinity] ~= nil then
      for _, nEffectId in ipairs(mapEffect[AllEnum.EffectType.Affinity]) do
        if retCharEffect[AllEnum.EffectType.Affinity] == nil then
          retCharEffect[AllEnum.EffectType.Affinity] = {}
        end
        if retCharEffect[AllEnum.EffectType.Affinity][nEffectId] == nil then
          retCharEffect[AllEnum.EffectType.Affinity][nEffectId] = {}
        end
        local nEftUid = UTILS.AddEffect(nCharId, nEffectId, 0, 0)
        table.insert(retCharEffect[AllEnum.EffectType.Affinity][nEffectId], nEftUid)
      end
    end
    if mapEffect[AllEnum.EffectType.Talent] ~= nil then
      for _, nEffectId in ipairs(mapEffect[AllEnum.EffectType.Talent]) do
        if retCharEffect[AllEnum.EffectType.Talent] == nil then
          retCharEffect[AllEnum.EffectType.Talent] = {}
        end
        if retCharEffect[AllEnum.EffectType.Talent][nEffectId] == nil then
          retCharEffect[AllEnum.EffectType.Talent][nEffectId] = {}
        end
        local nEftUid = UTILS.AddEffect(nCharId, nEffectId, 0, 0)
        table.insert(retCharEffect[AllEnum.EffectType.Talent][nEffectId], nEftUid)
      end
    end
    if mapEffect[AllEnum.EffectType.Potential] ~= nil then
      for nPotentialId, tbPotentialData in pairs(mapEffect[AllEnum.EffectType.Potential]) do
        for _, nEffectId in ipairs(tbPotentialData[1]) do
          if retCharEffect[AllEnum.EffectType.Potential] == nil then
            retCharEffect[AllEnum.EffectType.Potential] = {}
          end
          if retCharEffect[AllEnum.EffectType.Potential][nEffectId] == nil then
            retCharEffect[AllEnum.EffectType.Potential][nEffectId] = {}
          end
          local nEftUid = UTILS.AddEffect(nCharId, nEffectId, tbPotentialData[2], 0)
          table.insert(retCharEffect[AllEnum.EffectType.Potential][nEffectId], nEftUid)
        end
      end
    end
    if mapEffect[AllEnum.EffectType.Equipment] ~= nil then
      for _, nEffectId in ipairs(mapEffect[AllEnum.EffectType.Equipment]) do
        if retCharEffect[AllEnum.EffectType.Equipment] == nil then
          retCharEffect[AllEnum.EffectType.Equipment] = {}
        end
        if retCharEffect[AllEnum.EffectType.Equipment][nEffectId] == nil then
          retCharEffect[AllEnum.EffectType.Equipment][nEffectId] = {}
        end
        local nEftUid = UTILS.AddEffect(nCharId, nEffectId, 0, 0)
        table.insert(retCharEffect[AllEnum.EffectType.Equipment][nEffectId], nEftUid)
      end
    end
    if mapDiscEffect ~= nil then
      for nDiscTid, tbDiscEffectId in pairs(mapDiscEffect) do
        if retDiscEffect[nDiscTid] == nil then
          retDiscEffect[nDiscTid] = {}
        end
        for _, mapEft in ipairs(tbDiscEffectId) do
          if retDiscEffect[nDiscTid][mapEft[1]] == nil then
            retDiscEffect[nDiscTid][mapEft[1]] = {}
          end
          local nEftUid = UTILS.AddEffect(nCharId, mapEft[1], mapEft[2], 0)
          table.insert(retDiscEffect[nDiscTid][mapEft[1]], nEftUid)
        end
      end
    end
    if mapNoteEffect ~= nil then
      for nNoteId, tbNoteEffectId in pairs(mapNoteEffect) do
        if retNoteEffect[nNoteId] == nil then
          retNoteEffect[nNoteId] = {}
        end
        for _, mapEft in ipairs(tbNoteEffectId) do
          if retNoteEffect[nNoteId][mapEft[1]] == nil then
            retNoteEffect[nNoteId][mapEft[1]] = {}
          end
          local nEftUid = UTILS.AddEffect(nCharId, mapEft[1], mapEft[2], 0)
          table.insert(retNoteEffect[nNoteId][mapEft[1]], nEftUid)
        end
      end
    end
  end
  return retCharEffect, retDiscEffect, retNoteEffect
end

local function RemoveEffect(nEftUid, nCharId)
  safe_call_cs_func(CS.AdventureModuleHelper.RemoveActorEffect, nCharId, nEftUid)
end

local function GetBattleSamples(sFileName)
  if sFileName == nil or sFileName == "" then
    traceback("【战报】传入的 fileName 为空")
    return
  end
  local lstBattleSamples = CS.AdventureModuleHelper.GetBattleSamples(sFileName)
  local tbSamples = {}
  if lstBattleSamples ~= nil then
    local nCount = lstBattleSamples.Count - 1
    
    local function csList2Table(list)
      if list == nil then
        return {}
      end
      local nLstCount = list.Count - 1
      local ret = {}
      for i = 0, nLstCount do
        table.insert(ret, list[i])
      end
      return ret
    end
    
    for i = 0, nCount do
      local mapSample = {}
      mapSample.FromSrcAtk = lstBattleSamples[i].fromSrcAtk
      mapSample.FromPerkIntensityRatio = lstBattleSamples[i].fromPerkIntensityRatio
      mapSample.FromSlotDmgRatio = lstBattleSamples[i].fromSlotDmgRatio
      mapSample.FromEE = lstBattleSamples[i].fromEE
      mapSample.FromGenDmgRatio = lstBattleSamples[i].fromGenDmgRatio
      mapSample.FromDmgPlus = lstBattleSamples[i].fromDmgPlus
      mapSample.FromCritRatio = lstBattleSamples[i].fromCritRatio
      mapSample.FromFinalDmgRatio = lstBattleSamples[i].fromFinalDmgRatio
      mapSample.FromFinalDmgPlus = lstBattleSamples[i].fromFinalDmgPlus
      mapSample.ToErAmend = lstBattleSamples[i].toErAmend
      mapSample.ToDefAmend = lstBattleSamples[i].toDefAmend
      mapSample.ToRcdSlotDmgRatio = lstBattleSamples[i].toRcdSlotDmgRatio
      mapSample.ToEERCD = lstBattleSamples[i].toEERCD
      mapSample.ToGenDmgRcdRatio = lstBattleSamples[i].toGenDmgRcdRatio
      mapSample.ToDmgPlusRcd = lstBattleSamples[i].toDmgPlusRcd
      mapSample.Dmg = lstBattleSamples[i].dmg
      mapSample.CritRate = lstBattleSamples[i].critRate
      mapSample.Hp = lstBattleSamples[i].maxHP
      mapSample.Log = {}
      table.insert(tbSamples, mapSample)
    end
  end
  return tbSamples
end

local function GetCharDamageResult(tbCharId)
  local tbResult = {}
  for i = 1, #tbCharId do
    local nCharId = tbCharId[i]
    local nDamage = CS.AdventureModuleHelper.GetCharacterDamage(nCharId, false)
    local actorInfo = {}
    actorInfo.nCharId = nCharId
    actorInfo.nDamage = nDamage
    table.insert(tbResult, actorInfo)
  end
  return tbResult
end

local function ClickItemGridWithTips(nTid, transform, bOnlyItemTips, bShowDepot, bShowJumpto, nHasCount)
  local mapItemCfgData = ConfigTable.GetData_Item(nTid)
  if mapItemCfgData == nil then
    return
  end
  if mapItemCfgData.Type == GameEnum.itemType.Disc then
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscSample, nTid)
    return
  elseif mapItemCfgData.Type == GameEnum.itemType.Char then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, nTid, {nTid}, true)
    return
  end
  if bOnlyItemTips then
    local mapData = {
      nTid = nTid,
      bShowDepot = bShowDepot,
      bShowJumpto = bShowJumpto,
      nHasCount = nHasCount
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, transform, mapData)
  else
    local mapData = {
      nTid = nTid,
      bShowDepot = bShowDepot,
      bShowJumpto = bShowJumpto,
      nHasCount = nHasCount
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, transform, mapData)
  end
end

local function CheckIsTipsPanel(nPanelId)
  local tbAllTipsPanelId = {
    PanelId.ItemTips,
    PanelId.PerkTips,
    PanelId.SkillTips,
    PanelId.BtnTips,
    PanelId.MonsterTips,
    PanelId.EquipmentTips,
    PanelId.DiscSkillTips,
    PanelId.DescTips
  }
  return table.indexof(tbAllTipsPanelId, nPanelId) > 0
end

local function ClickWordLink(link, sWordId, mapLinkParam)
  local nWordId = tonumber(sWordId)
  local mapWordData = ConfigTable.GetData("Word", nWordId)
  if mapWordData == nil then
    if sWordId == nil then
      printError("sWordId为空")
      return
    end
    printError("wordId error:" .. sWordId)
    return
  end
  if mapWordData.Type == GameEnum.wordLinkType.Word then
    local mapData = {
      nPerkId = 0,
      nCount = 0,
      bWordTip = true,
      sWordId = sWordId
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.PerkTips, link, mapData)
  elseif mapWordData.Type == GameEnum.wordLinkType.Potential then
    if mapLinkParam == nil or mapLinkParam.nCharId == nil then
      printError("该<潜能>词条 id 找不到角色:" .. sWordId)
      return
    else
      local nPotentialId = GetPotentialId(mapLinkParam.nCharId, tonumber(mapWordData.Param1))
      EventManager.Hit(EventId.OpenPanel, PanelId.PotentialDetail, nPotentialId, mapLinkParam.nLevel, mapLinkParam.nAddLv)
    end
  end
end

local function build_priority(selected, default_priority)
  local priority = {}
  local selected_map = {}
  for _, field in ipairs(selected) do
    table.insert(priority, field)
    selected_map[field] = true
  end
  for _, field in ipairs(default_priority) do
    if not selected_map[field] then
      table.insert(priority, field)
    end
  end
  return priority
end

local function compare_roles(a, b, sort_priority, bOrder)
  for i, field in ipairs(sort_priority) do
    local va, vb = a[field], b[field]
    if va ~= nil and vb ~= nil and va ~= vb then
      if field == "Rare" or field == "nRarity" then
        if i == 1 and bOrder then
          return va > vb
        else
          return va < vb
        end
      elseif i == 1 and bOrder or field == "EET" or field == "nEET" then
        return va < vb
      else
        return va > vb
      end
    end
  end
  return false
end

local function compare_roles_SetFavoriteTop(a, b, sort_priority, bOrder)
  local a_isFavorite = a.IsFavorite or false
  local b_isFavorite = b.IsFavorite or false
  if a_isFavorite ~= b_isFavorite then
    return a_isFavorite and not b_isFavorite
  end
  for i, field in ipairs(sort_priority) do
    local va, vb = a[field], b[field]
    if va ~= nil and vb ~= nil and va ~= vb then
      if field == "Rare" or field == "nRarity" then
        if i == 1 and bOrder then
          return va > vb
        else
          return va < vb
        end
      elseif i == 1 and bOrder or field == "EET" or field == "nEET" then
        return va < vb
      else
        return va > vb
      end
    end
  end
  return false
end

local function SortByPriority(items, selected_fields, default_priority, bOrder, bSetFavoriteTop)
  local sort_priority = build_priority(selected_fields, default_priority)
  if bSetFavoriteTop then
    table.sort(items, function(a, b)
      return compare_roles_SetFavoriteTop(a, b, sort_priority, bOrder)
    end)
  else
    table.sort(items, function(a, b)
      return compare_roles(a, b, sort_priority, bOrder)
    end)
  end
end

local function GetDayRefreshTimeOffset()
  local nNewDayTime = ConfigTable.GetConfigNumber("DailyRefreshOffsetHour") or 5
  if 24 < nNewDayTime then
    nNewDayTime = nNewDayTime % 24
  end
  return nNewDayTime
end

local function SDK_Logout()
  local SDKManager = CS.SDKManager.Instance
  if SDKManager:IsSDKInit() ~= true then
    return
  end
  SDKManager:SwitchAccount()
end

local function SDK_ShowAgreement()
  local SDKManager = CS.SDKManager.Instance
  if SDKManager:IsSDKInit() ~= true then
    return
  end
  local agreements = {}
  local sChannel = NovaAPI.GetClientChannel()
  if sChannel == "CN_Bilibili" or sChannel == "CN" or sChannel == "KOL" then
    table.insert(agreements, "user_agreement")
    table.insert(agreements, "privacy_agreement")
    table.insert(agreements, "child_privacy_agreement")
  else
    table.insert(agreements, "user_agreement")
    table.insert(agreements, "privacy_agreement")
    table.insert(agreements, "minors_shop_agreement")
  end
  SDKManager.SDK:ShowAgreement(agreements)
end

local ServerChannel_CN = {
  [1] = "cn_android_official",
  [2] = "cn_ios_official",
  [4] = "cn_android_bilibili",
  [8] = "cn_harmony_official",
  [16] = "cn_pc_official",
  [32] = "cn_pc_bilibili"
}
local ServerChannel_JP = {
  [1] = "jp_android_official",
  [2] = "jp_ios_official",
  [4] = "jp_android_onestore",
  [8] = "jp_pc_official"
}
local ServerChannel_US = {
  [1] = "us_android_official",
  [2] = "us_ios_official",
  [4] = "us_android_onestore",
  [8] = "us_pc_official",
  [128] = "us_pc_steam"
}
local ServerChannel_KR = {
  [1] = "kr_android_official",
  [2] = "kr_ios_official",
  [4] = "kr_android_onestore",
  [8] = "kr_pc_official"
}
local ServerChannel_TW = {
  [1] = "tw_android_official",
  [2] = "tw_ios_official",
  [4] = "tw_android_onestore",
  [8] = "tw_pc_official"
}

local function GetChannelConfigList()
  local resultList
  local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
  if clientPublishRegion == CS.ClientPublishRegion.CN then
    resultList = ServerChannel_CN
  elseif clientPublishRegion == CS.ClientPublishRegion.JP then
    resultList = ServerChannel_JP
  elseif clientPublishRegion == CS.ClientPublishRegion.US then
    resultList = ServerChannel_US
  elseif clientPublishRegion == CS.ClientPublishRegion.KR then
    resultList = ServerChannel_KR
  else
    if clientPublishRegion == CS.ClientPublishRegion.TW then
      resultList = ServerChannel_TW
    else
    end
  end
  return resultList
end

local function CheckChannel(channel)
  local fullChannnel = CS.ClientConfig.FullClientPublishChannelName
  local channelList = GetChannelConfigList()
  if channelList == nil then
    return false
  end
  local strChannel = channelList[channel]
  if strChannel == nil then
    return false
  end
  local tbClient = string.split(fullChannnel, "_")
  local tbServer = string.split(strChannel, "_")
  if tbClient[2] == nil or tbServer[2] == nil or tbClient[2] ~= tbServer[2] then
    return false
  end
  if tbClient[3] == "taptap" then
    tbClient[3] = "official"
  end
  if string.match(tbClient[3], "test") then
    tbClient[3] = "official"
  end
  if tbClient[3] == nil or tbServer[3] == nil or tbClient[3] ~= tbServer[3] then
    return false
  end
  return true
end

local function CheckChannelList(channelList)
  local sCurClientPublishRegion = CS.ClientConfig.ClientPublishRegion
  if sCurClientPublishRegion == CS.ClientPublishRegion.Other then
    return true
  end
  for i = 0, channelList.Count - 1 do
    if CheckChannel(channelList[i]) then
      return true
    end
  end
  return false
end

local function CheckChannelList_Notice(channelList)
  local sCurClientPublishRegion = CS.ClientConfig.ClientPublishRegion
  if sCurClientPublishRegion == CS.ClientPublishRegion.Other then
    return true
  end
  for _, channel in ipairs(channelList) do
    if CheckChannel(channel) then
      return true
    end
  end
  return false
end

local function VersionCompare(v1, v2, num)
  local v1List = string.split(v1, ".")
  local v2List = string.split(v2, ".")
  for i = 1, num do
    if i > #v1List or i > #v2List then
      if #v1List < #v2List then
        return -1
      elseif #v1List > #v2List then
        return 1
      else
        return 0
      end
    end
    local v1_num = tonumber(v1List[i]) or 0
    local v2_num = tonumber(v2List[i]) or 0
    if v1_num > v2_num then
      return 1
    elseif v1_num < v2_num then
      return -1
    end
  end
  return 0
end

local function GetBBSUrl()
  local result = false
  local url = ""
  local sChannel = NovaAPI.GetClientChannel()
  if sChannel == "CN" or sChannel == "CN_Taptap" then
    result = true
    url = "https://bbs-stellasora.yostar.net/"
  elseif sChannel == "CN_TEST_1" then
    result = true
    url = "https://staging-bbs.yostar.net/"
  end
  return result, url
end

local function GetToolBoxUrl()
  local result = false
  local url = ""
  local sChannel = NovaAPI.GetClientChannel()
  local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
  if clientPublishRegion == CS.ClientPublishRegion.CN then
    if sChannel == "CN" or sChannel == "CN_Bilibili" or sChannel == "CN_Taptap" then
      result = true
      url = "https://toolbox-stellasora.yostar.cn"
    else
      result = true
      url = "https://staging-web-toolbox-stellasora.yostar.cn"
    end
  elseif clientPublishRegion == CS.ClientPublishRegion.TW then
    if sChannel == "TW" then
      result = true
      url = "https://toolbox-stellasora.stargazer-games.com"
    else
      result = true
      url = "https://staging-web-toolbox-stellasora.stargazer-games.com"
    end
  elseif clientPublishRegion == CS.ClientPublishRegion.JP then
    if sChannel == "JP" then
      result = true
      url = "https://toolbox.stellasora.jp"
    else
      result = true
      url = "https://staging-web-toolbox.stellasora.jp"
    end
  elseif clientPublishRegion == CS.ClientPublishRegion.US then
    if sChannel == "EN" then
      result = true
      url = "https://toolbox.stellasora.global"
    else
      result = true
      url = "https://staging-web-toolbox.stellasora.global"
    end
  elseif clientPublishRegion == CS.ClientPublishRegion.KR then
    if sChannel == "KR" then
      result = true
      url = "https://toolbox.stellasora.kr"
    else
      result = true
      url = "https://staging-web-toolbox.stellasora.kr"
    end
  end
  return result, url
end

local function GetExchangeCodeUrl()
  local result = false
  local url = ""
  local sChannel = NovaAPI.GetClientChannel()
  local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
  if clientPublishRegion == CS.ClientPublishRegion.CN then
  elseif clientPublishRegion == CS.ClientPublishRegion.TW then
    if sChannel == "TW" then
      result = true
      url = "https://stellasora.stargazer-games.com/redemption?type=webview"
    else
      result = true
      url = "https://staging-web-stellasora.stargazer-games.com/redemption?type=webview"
    end
  elseif clientPublishRegion == CS.ClientPublishRegion.JP then
    if sChannel == "JP" then
      result = true
      url = "https://stellasora.jp/serial_code?type=webview"
    else
      result = true
      url = "https://staging-web.stellasora.jp/serial_code?type=webview"
    end
  elseif clientPublishRegion == CS.ClientPublishRegion.US then
    if sChannel == "EN" then
      result = true
      url = "https://stellasora.global/gift?type=webview"
    else
      result = true
      url = "https://staging-web.stellasora.global/gift?type=webview"
    end
  elseif clientPublishRegion == CS.ClientPublishRegion.KR then
    if sChannel == "KR" then
      result = true
      url = "https://stellasora.kr/gift?type=webview"
    else
      result = true
      url = "https://staging-web.stellasora.kr/gift?type=webview"
    end
  end
  return result, url
end

local function GenerateManageredResourceId(nPanelId, nResId)
  nPanelId = math.abs(nPanelId)
  nResId = math.abs(nResId)
  local sum = nPanelId * 1000000.0 + nResId
  if sum >= math.maxinteger then
    sum = 1
    Debug.LogError("id exceeds max integer")
  end
  return -math.abs(sum)
end

_G.UTILS = {
  DecodeChangeInfo = DecodeChangeInfo,
  OpenReceiveByChangeInfo = OpenReceiveByChangeInfo,
  OpenReceiveByDisplayItem = OpenReceiveByDisplayItem,
  OpenReceiveByReward = OpenReceiveByReward,
  GetParamStrLen = GetParamStrLen,
  ParseByteString = ParseByteString,
  IsBitSet = IsBitSet,
  SetBit = SetBit,
  GetBuildAttributeId = GetBuildAttributeId,
  GetCharacterAttributeId = GetCharacterAttributeId,
  GetDiscAttributeId = GetDiscAttributeId,
  GetDiscExtraAttributeId = GetDiscExtraAttributeId,
  GetSoldierTempleteAttrId = GetSoldierTempleteAttrId,
  GetPotentialId = GetPotentialId,
  SubDesc = SubDesc,
  ParseDesc = ParseDesc,
  ParseDiscDesc = ParseDiscDesc,
  ParseParamDesc = ParseParamDesc,
  ParseLevelQuestTargetDesc = ParseLevelQuestTargetDesc,
  GetLevelQuestTargetProcess = GetLevelQuestTargetProcess,
  ParseRewardItemCount = ParseRewardItemCount,
  GetBezierPointByT = GetBezierPointByT,
  AddEffect = AddEffect,
  AddFateCardEft = AddFateCardEft,
  AddBuildEffect = AddBuildEffect,
  RemoveEffect = RemoveEffect,
  GetBattleSamples = GetBattleSamples,
  GetCharDamageResult = GetCharDamageResult,
  ClickItemGridWithTips = ClickItemGridWithTips,
  QueryLevelInfo = QueryLevelInfo,
  SDK_Logout = SDK_Logout,
  SDK_ShowAgreement = SDK_ShowAgreement,
  ParseNoBrokenDesc = ParseNoBrokenDesc,
  CheckIsTipsPanel = CheckIsTipsPanel,
  ClickWordLink = ClickWordLink,
  CheckChannelList = CheckChannelList,
  VersionCompare = VersionCompare,
  SortByPriority = SortByPriority,
  GetDayRefreshTimeOffset = GetDayRefreshTimeOffset,
  GetBBSUrl = GetBBSUrl,
  GetToolBoxUrl = GetToolBoxUrl,
  GetExchangeCodeUrl = GetExchangeCodeUrl,
  CheckChannelList_Notice = CheckChannelList_Notice,
  AddKrParticle = AddKrParticle,
  LanguagePost = LanguagePost,
  ParseLanguageParam = ParseLanguageParam,
  RefreshRemainTime = RefreshRemainTime,
  GenerateManageredResourceId = GenerateManageredResourceId
}
