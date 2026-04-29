_class("HelperProxy", Singleton)
HelperProxy = HelperProxy

function HelperProxy:Constructor()
  self._common_lua_helper = CommonLuaHelper:New()
  self._config_table = {}
  self._log_level = self:_GetLogLevel()
  self._curlanguage = ""
  Log.loglevel = self._log_level
  self._debug = nil
  self._levelExpTable = nil
  self._maxLevel = nil
  self.tag2size = {
    [RoleHeadTag.QTag] = Vector2(190, 160),
    [RoleHeadTag.Person] = Vector2(216, 138),
    [RoleHeadTag.Camp] = Vector2(216, 138)
  }
  self.frame2scale = {
    [RoleHeadFrameSizeType.Size1] = 0.5,
    [RoleHeadFrameSizeType.Size2] = 0.56,
    [RoleHeadFrameSizeType.Size3] = 0.6,
    [RoleHeadFrameSizeType.Size4] = 0.65,
    [RoleHeadFrameSizeType.Size5] = 0.7,
    [RoleHeadFrameSizeType.Size6] = 1,
    [RoleHeadFrameSizeType.Size7] = 0.8
  }
end

function HelperProxy:GetLuaHelper()
  return self._common_lua_helper
end

function HelperProxy:GetConfig(key, default_value)
  local va = self._config_table[key]
  if va == nil then
    va = self._common_lua_helper:GetConfig(key, default_value)
    self._config_table[key] = va
    return va
  else
    return va
  end
end

function HelperProxy:GetGameVersion()
  local gameVer = HelperProxy:GetInstance():GetConfig("GameVersion", "none")
  if gameVer == "none" then
    local IsUSA = HelperProxy:GetInstance():GetConfig("IsUSA", "false")
    if IsUSA == "true" then
      gameVer = GameVersionType.USA
    else
      gameVer = GameVersionType.INTL
    end
  end
  return gameVer
end

function HelperProxy:ReportException(exceMsg)
  if _G.APPVER1100 then
    local traceback_info = debug.traceback()
    self._common_lua_helper:ReportException(exceMsg, traceback_info)
  else
    Log.exception("ReportException error version ")
  end
end

function HelperProxy:_GetLogLevel()
  local strlevel = self:GetConfig("DebugLogLevel", "Debug")
  if EngineGameHelper.IsDevelopmentBuild() or EDITOR then
  else
    strlevel = self:GetConfig("ReleaseLogLevel", "None")
  end
  local nlevel = Log.loglevel_table[strlevel]
  return nlevel
end

function HelperProxy:ReportException(exceMsg)
  if _G.APPVER1100 and Log.loglevel == ELogLevel.None then
    local traceback_info = debug.traceback()
    local roleModule = GameGlobal.GetModule(RoleModule)
    local pstId = roleModule:GetPstId()
    local l_zone_id = roleModule:GetZoneIdType()
    exceMsg = exceMsg .. pstId .. "_" .. l_zone_id
    self._common_lua_helper:ReportException(exceMsg, traceback_info)
  end
end

function HelperProxy:GetEditorShowId()
  local show = self:GetConfig("EditorShowId", "false")
  return show
end

function HelperProxy:GetLanguage()
  if self._curlanguage == "" then
    self._curlanguage = self._common_lua_helper:GetLanguage()
  end
  return self._curlanguage
end

function HelperProxy:FormatGold(count)
  if 99999999 < count then
    local c = math.modf(count / 100000)
    local str = tostring(c * 0.1) .. "M"
    return str
  else
    return tostring(count)
  end
end

function HelperProxy:Format9999W(count)
  if 99999999 < count then
    local c = math.modf(count / 100000)
    local str = tostring(c * 0.1) .. "M"
    return str
  else
    return tostring(count)
  end
end

function HelperProxy:Format9999(count)
  if 9999 < count then
    return "9999+"
  else
    return tostring(count)
  end
end

function HelperProxy:Format999(count)
  if 999 < count then
    return "999+"
  else
    return tostring(count)
  end
end

function HelperProxy:FormatItemCount(count)
  if 1000000 <= count then
    local c = math.modf(count / 100000)
    local str = tostring(c * 0.1) .. "M"
    return str
  elseif 100000 <= count then
    local c = math.modf(count / 100)
    local str = tostring(c * 0.1) .. "K"
    return str
  else
    return tostring(count)
  end
end

function HelperProxy:pairsByKeys(tab)
  local a = {}
  for n in pairs(tab) do
    a[#a + 1] = n
  end
  table.sort(a)
  local i = 0
  return function()
    i = i + 1
    return a[i], tab[a[i]]
  end
end

function HelperProxy:PairsByKeys(tab, Com)
  local a = {}
  for n in pairs(tab) do
    a[#a + 1] = n
  end
  table.sort(a, Com)
  local i = 0
  return function()
    i = i + 1
    return a[i], tab[a[i]]
  end
end

function HelperProxy:IsTaskFinished(taskID)
  local task = TaskManager:GetInstance():FindTask(taskID)
  if task ~= nil then
    return false
  else
    return true
  end
end

function HelperProxy:ResidentTimeString()
  return "2100-01-01 12:00:00"
end

function HelperProxy:FormatDateTime(strValue)
  return os.time(self:GetTimeTable(strValue))
end

function HelperProxy:FormatGMTDateTime(strValue)
  return self:FormatDateTime((_utc2Local(self:GetTimeTable(strValue))))
end

function HelperProxy:GetTimeTable(strValue)
  local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
  local runyear, runmonth, runday, runhour, runminute, runseconds = string.match(strValue, pattern)
  return {
    year = runyear,
    month = runmonth,
    day = runday,
    hour = runhour,
    min = runminute,
    sec = runseconds
  }
end

function HelperProxy:FormatTime(seconds)
  if seconds <= 0 then
    return "00:00:00"
  elseif seconds < 86400 then
    return os.date("!%X", seconds)
  elseif 360000 <= seconds then
    return "99:59:59"
  else
    local _sec = seconds % 60
    local minute = math.floor(seconds / 60)
    local _min = minute % 60
    local _hour = math.floor(minute / 60)
    return string.format("%02d:%02d:%02d", _hour, _min, _sec)
  end
end

function HelperProxy:FormatTime_2(seconds)
  if seconds <= 0 then
    return "00:00:00"
  else
    local _sec = seconds % 60
    local minute = math.floor(seconds / 60)
    local _min = minute % 60
    local _hour = math.floor(minute / 60)
    return string.format("%02d:%02d:%02d", _hour, _min, _sec)
  end
end

function HelperProxy:FormatTime_3(seconds, numHexColor)
  if not seconds then
    return nil
  end
  if seconds < 0 then
    if numHexColor then
      return StringTable.Get("str_prediction_left_time_m", self:FormatNumWithColor(0, numHexColor))
    else
      return StringTable.Get("str_prediction_left_time_m", 0)
    end
  elseif seconds < 60 then
    return StringTable.Get("str_activity_common_less_minute")
  elseif seconds < 3600 then
    local min = math.floor(seconds / 60)
    if numHexColor then
      return StringTable.Get("str_prediction_left_time_m", self:FormatNumWithColor(min, numHexColor))
    else
      return StringTable.Get("str_prediction_left_time_m", min)
    end
  elseif seconds < 86400 then
    if seconds % 3600 == 0 then
      if numHexColor then
        return StringTable.Get("str_dispatch_room_task_detail_hour", self:FormatNumWithColor(seconds / 3600, numHexColor))
      else
        return StringTable.Get("str_dispatch_room_task_detail_hour", seconds / 3600)
      end
    end
    local hour = math.floor(seconds / 3600)
    local min = math.floor(seconds % 3600 / 60)
    if numHexColor then
      return StringTable.Get("str_prediction_left_time_h_m", self:FormatNumWithColor(hour, numHexColor), self:FormatNumWithColor(min, numHexColor))
    else
      return StringTable.Get("str_prediction_left_time_h_m", hour, min)
    end
  else
    local day = math.floor(seconds / 86400)
    local hour = math.floor(seconds % 86400 / 3600)
    if numHexColor then
      return StringTable.Get("str_prediction_left_time_d_h", self:FormatNumWithColor(day, numHexColor), self:FormatNumWithColor(hour, numHexColor))
    else
      return StringTable.Get("str_prediction_left_time_d_h", day, hour)
    end
  end
end

function HelperProxy:FormatNumWithColor(num, hexColor)
  if not num then
    return nil
  end
  local r = string.format("<color=%s>%d</color>", hexColor, num)
  return r
end

function HelperProxy:SortPosByCenterPosDistance(centerPos, posList)
  local function get_index(c, p)
    if p.x - c.x == 0 and 0 < p.y - c.y then
      return 1
    end
    if p.x - c.x > 0 and 0 < p.y - c.y then
      return 2
    end
    if p.x - c.x > 0 and p.y - c.y == 0 then
      return 3
    end
    if p.x - c.x > 0 and 0 > p.y - c.y then
      return 4
    end
    if p.x - c.x == 0 and 0 > p.y - c.y then
      return 5
    end
    if p.x - c.x < 0 and 0 > p.y - c.y then
      return 6
    end
    if p.x - c.x < 0 and p.y - c.y == 0 then
      return 7
    end
    if p.x - c.x < 0 and 0 < p.y - c.y then
      return 8
    end
    return 1
  end
  
  local function cmp_fun(p1, p2)
    local dis1 = Vector2.Distance(centerPos, p1)
    local dis2 = Vector2.Distance(centerPos, p2)
    if dis1 == dis2 then
      return get_index(centerPos, p1) < get_index(centerPos, p2)
    else
      return dis1 < dis2
    end
  end
  
  table.sort(posList, cmp_fun)
  return posList
end

function HelperProxy:SortPosByCenterPosDistanceFar(centerPos, posList)
  local function get_index(c, p)
    if p.x - c.x == 0 and 0 < p.y - c.y then
      return 1
    end
    if p.x - c.x > 0 and 0 < p.y - c.y then
      return 2
    end
    if p.x - c.x > 0 and p.y - c.y == 0 then
      return 3
    end
    if p.x - c.x > 0 and 0 > p.y - c.y then
      return 4
    end
    if p.x - c.x == 0 and 0 > p.y - c.y then
      return 5
    end
    if p.x - c.x < 0 and 0 > p.y - c.y then
      return 6
    end
    if p.x - c.x < 0 and p.y - c.y == 0 then
      return 7
    end
    if p.x - c.x < 0 and 0 < p.y - c.y then
      return 8
    end
    return 1
  end
  
  local function cmp_fun(p1, p2)
    local dis1 = Vector2.Distance(centerPos, p1)
    local dis2 = Vector2.Distance(centerPos, p2)
    if dis1 == dis2 then
      return get_index(centerPos, p1) < get_index(centerPos, p2)
    else
      return dis1 > dis2
    end
  end
  
  table.sort(posList, cmp_fun)
  return posList
end

function HelperProxy:SortPosByCenterPosDistanceAnticlockwise(centerPos, posList)
  local function get_index(c, p)
    if p.x - c.x == 0 and 0 < p.y - c.y then
      return 8
    end
    if p.x - c.x > 0 and 0 < p.y - c.y then
      return 7
    end
    if p.x - c.x > 0 and p.y - c.y == 0 then
      return 6
    end
    if p.x - c.x > 0 and 0 > p.y - c.y then
      return 5
    end
    if p.x - c.x == 0 and 0 > p.y - c.y then
      return 4
    end
    if p.x - c.x < 0 and 0 > p.y - c.y then
      return 3
    end
    if p.x - c.x < 0 and p.y - c.y == 0 then
      return 2
    end
    if p.x - c.x < 0 and 0 < p.y - c.y then
      return 1
    end
    return 8
  end
  
  local function cmp_fun(p1, p2)
    local dis1 = Vector2.Distance(centerPos, p1)
    local dis2 = Vector2.Distance(centerPos, p2)
    if dis1 == dis2 then
      return get_index(centerPos, p1) < get_index(centerPos, p2)
    else
      return dis1 < dis2
    end
  end
  
  table.sort(posList, cmp_fun)
  return posList
end

local function get_index(c, p)
  if p.x - c.x == 0 and 0 < p.y - c.y then
    return 1
  end
  if p.x - c.x > 0 and p.y - c.y == 0 then
    return 2
  end
  if p.x - c.x == 0 and 0 > p.y - c.y then
    return 3
  end
  if p.x - c.x < 0 and p.y - c.y == 0 then
    return 4
  end
  if p.x - c.x > 0 and 0 < p.y - c.y then
    return 5
  end
  if p.x - c.x > 0 and 0 > p.y - c.y then
    return 6
  end
  if p.x - c.x < 0 and 0 > p.y - c.y then
    return 7
  end
  if p.x - c.x < 0 and 0 < p.y - c.y then
    return 8
  end
  return 1
end

local CmpFunc_centerPos

local function CmpFunc_SortPosByCenterArrow(p1, p2)
  local dis1 = Vector2.Distance(CmpFunc_centerPos, p1)
  local dis2 = Vector2.Distance(CmpFunc_centerPos, p2)
  if dis1 == dis2 then
    return get_index(CmpFunc_centerPos, p1) < get_index(CmpFunc_centerPos, p2)
  else
    return dis1 < dis2
  end
end

function HelperProxy:SortPosByCenterArrow(centerPos, posList)
  CmpFunc_centerPos = centerPos
  table.sort(posList, CmpFunc_SortPosByCenterArrow)
  CmpFunc_centerPos = nil
  return posList
end

function HelperProxy:IsDebug()
  if self._debug == nil then
    self._debug = self._common_lua_helper:IsDebug()
  end
  return self._debug
end

function HelperProxy:PlayMovie(path, bgColor, controlMode, scalingMode)
  self._common_lua_helper:PlayMovie(path, bgColor, controlMode, scalingMode)
end

function HelperProxy:_InitLevelExpTable()
  self._levelExpTable = {}
  self._levelExpTable[1] = 0
  local exp = 0
  local lv = 1
  local lvProp = Cfg.cfg_role_level[lv]
  while lvProp do
    exp = exp + lvProp.NeedExp
    lv = lv + 1
    self._levelExpTable[lv] = exp
    lvProp = Cfg.cfg_role_level[lv]
  end
  self._levelExpTable[lv] = nil
end

function HelperProxy:GetLevelExp(lv)
  if not self._levelExpTable then
    self:_InitLevelExpTable()
  end
  local exp = self._levelExpTable[lv]
  if exp then
    return exp
  else
    return 0
  end
end

function HelperProxy:GetLvByExp(exp)
  if not self._levelExpTable then
    self:_InitLevelExpTable()
  end
  local lv = 1
  while exp >= self._levelExpTable[lv] do
    lv = lv + 1
    if not self._levelExpTable[lv] then
      break
    end
  end
  return lv - 1
end

function HelperProxy:GetMaxLevel()
  if self._maxLevel then
    return self._maxLevel
  end
  local maxLv = 1
  local lvProp = Cfg.cfg_role_level[maxLv]
  while lvProp do
    maxLv = maxLv + 1
    lvProp = Cfg.cfg_role_level[maxLv]
  end
  self._maxLevel = maxLv - 1
  return self._maxLevel
end

function HelperProxy:InitCameraShake()
  self._common_lua_helper:InitCameraShake()
end

function HelperProxy:DestroyCameraShake()
  self._common_lua_helper:CameraShakeDispose()
end

function HelperProxy:GCCollect()
  self._common_lua_helper:GCCollect()
end

function HelperProxy:Utf8toUnicodeNum(s, nBegin)
  local chHeadChar = s:byte(nBegin)
  if not chHeadChar then
    return -1
  end
  local nOutEnd = 0
  if chHeadChar < 128 then
    nOutEnd = nBegin + 1
    return chHeadChar, nOutEnd
  end
  if chHeadChar < 192 or 253 < chHeadChar then
    return -1
  end
  local nUnicodeNum = 0
  local nLength = 0
  if chHeadChar < 224 then
    nUnicodeNum = chHeadChar & 31
    nLength = 2
  elseif chHeadChar < 240 then
    nUnicodeNum = chHeadChar & 15
    nLength = 3
  elseif chHeadChar < 248 then
    nUnicodeNum = chHeadChar & 7
    nLength = 4
  elseif chHeadChar < 252 then
    nUnicodeNum = chHeadChar & 3
    nLength = 5
  else
    nUnicodeNum = chHeadChar & 1
    nLength = 6
  end
  nOutEnd = nBegin + nLength
  for i = nBegin + 1, nOutEnd - 1 do
    local tempChar = s:byte(i)
    if tempChar & 192 ~= 128 then
      return -1
    end
    nUnicodeNum = nUnicodeNum << 6
    nUnicodeNum = nUnicodeNum | tempChar & 63
  end
  return nUnicodeNum, nOutEnd
end

function HelperProxy:GetNickWordLength(nUnicodeNum, cfg_lang_len)
  for key, value in pairs(cfg_lang_len) do
    if nUnicodeNum >= value.UnicodeBegin and nUnicodeNum <= value.UnicodeEnd then
      return value.length
    end
  end
  return 1
end

function HelperProxy:GetSubStringByWordsNum(str, nLimitWordsNum)
  if not str or str == "" then
    return ""
  end
  if nLimitWordsNum <= 0 then
    return ""
  end
  local cfg_lang_len = Cfg.cfg_nick_lang_len({})
  local len = string.len(str)
  local nWordNum = 0
  local i = 1
  local last_i = 1
  while len >= i do
    local nUnicodeNum = 0
    last_i = i
    nUnicodeNum, i = self:Utf8toUnicodeNum(str, i)
    if nUnicodeNum < 0 or not i then
      Log.fatal("字符串utf8编码错误", str)
      return ""
    end
    local nWordLength = self:GetNickWordLength(nUnicodeNum, cfg_lang_len)
    local lastWordNum = nWordNum
    nWordNum = lastWordNum + nWordLength
    if nWordNum == nLimitWordsNum then
      return string.sub(str, 1, i - 1)
    elseif nLimitWordsNum < nWordNum then
      return string.sub(str, 1, last_i - 1)
    end
  end
  return str
end

function HelperProxy:GetCharLength(str)
  str = str or ""
  local cfg_lang_len = Cfg.cfg_nick_lang_len({})
  local len = string.len(str)
  local nWordNum = 0
  local i = 1
  while len >= i do
    local nUnicodeNum = 0
    nUnicodeNum, i = self:Utf8toUnicodeNum(str, i)
    if nUnicodeNum < 0 or not i then
      Log.fatal("字符串utf8编码错误", str)
      return 999999999
    end
    local nWordLength = self:GetNickWordLength(nUnicodeNum, cfg_lang_len)
    nWordNum = nWordNum + nWordLength
  end
  return nWordNum
end

function HelperProxy:LoadPet(petName, isBattle)
  local controllerType = PetAnimatorControllerType.Aircraft
  if isBattle then
    controllerType = PetAnimatorControllerType.Battle
  end
  local ancName = self:GetPetAnimatorControllerName(petName, controllerType)
  local req1 = ResourceManager:GetInstance():SyncLoadAsset(petName, LoadType.GameObject)
  if req1 == nil then
    Log.fatal("加载宝宝模型失败，", petName)
    return
  end
  local req2 = ResourceManager:GetInstance():SyncLoadAsset(ancName, LoadType.GameObject)
  if req2 == nil then
    Log.fatal("加载宝宝状态机失败，", ancName)
    return
  end
  local pet = req1.Obj
  if isBattle then
    local anim = req2.Obj:GetComponent(typeof(UnityEngine.Animator))
    if anim == nil then
      Log.fatal("找不到Animator组件，加载pet模型失败：", ancName)
      return nil
    end
    local petAnim = pet:GetComponentInChildren(typeof(UnityEngine.Animator))
    petAnim.runtimeAnimatorController = anim.runtimeAnimatorController
  else
    local anim = req2.Obj:GetComponent(typeof(UnityEngine.Animation))
    if anim == nil then
      Log.fatal("找不到Animation组件，加载pet模型失败：", ancName)
      return
    end
    if anim.clip == nil then
      Log.exception("星灵没有默认的Stand动作：", petName)
      return
    end
    local root = pet.transform:Find("Root").gameObject
    local animator = root:GetComponent(typeof(UnityEngine.Animator))
    if animator then
      UnityEngine.Object.Destroy(animator)
    end
    local petAnim = root:AddComponent(typeof(UnityEngine.Animation))
    local clips = self._common_lua_helper:GetAllAnimationClip(anim)
    for i = 0, clips.Length - 1 do
      local clip = clips[i]
      if clip == nil then
        Log.exception("星灵动作为空:", petName, "，索引：", i)
      else
        petAnim:AddClip(clip, clip.name)
      end
    end
    petAnim.clip = anim.clip
  end
  return pet, {req1, req2}
end

function HelperProxy:GetPetAnimatorControllerName(petName, animatorControllerType)
  if string.endwith(petName, ".prefab") then
    local name = string.gsub(petName, ".prefab", "")
    local ancName
    if animatorControllerType == PetAnimatorControllerType.Battle then
      ancName = name .. "_battle.prefab"
    elseif animatorControllerType == PetAnimatorControllerType.Aircraft then
      ancName = name .. "_aircraft.prefab"
    elseif animatorControllerType == PetAnimatorControllerType.Homeland then
      ancName = name .. "_homeland.prefab"
    elseif animatorControllerType == PetAnimatorControllerType.HomelandStory then
      ancName = name .. "_homeland_story.prefab"
    end
    return ancName
  else
    Log.fatal("pet模型名称错误：", petName)
  end
end

function HelperProxy:GetAllAnimationClip(anim)
  return self._common_lua_helper:GetAllAnimationClip(anim)
end

function HelperProxy:GetEnableGameRecord()
  local enable = self:GetConfig("GameRecord", "false")
  return enable == "true"
end

local STR_GSUB = string.gsub
local STR_GMATCH = string.gmatch
local STR_LEN = string.len
local regex = "{%w+}"

function HelperProxy:GetUrlWithParam(rawStr, ...)
  rawStr = STR_GSUB(rawStr, "{{", "{")
  rawStr = STR_GSUB(rawStr, "}}", "}")
  rawStr = STR_GSUB(rawStr, "##", "#")
  for match in STR_GMATCH(rawStr, regex) do
    local argIndex = string.sub(match, 2, STR_LEN(match) - 1)
    local toReplace = select(argIndex, ...)
    if toReplace then
      rawStr = STR_GSUB(rawStr, match, toReplace)
    else
      Log.fatal("StringTable:FindStringWithParams Error,本地化参数不足:", rawStr)
    end
  end
  return rawStr
end

function HelperProxy:FileImurUrl(srcUrl)
  Log.debug("HelperProxy:FileImurUrl begin")
  local roleModule = GameGlobal.GameLogic():GetModule(RoleModule)
  local paltid = GetPlatformOS()
  local sArea = GameGlobal.GameLogic().ClientInfo.m_login_source
  local sPartition = 0
  local sRoleid = roleModule:GetPstId()
  local openid = GameGlobal.GameLogic():GetOpenId()
  local info = GameGlobal.GameLogic():GetZoneID()
  local l, q = string.find(srcUrl, "out.survey.imur.tencent.com")
  local x, y = string.find(srcUrl, "out.weisurvey.com")
  if l ~= nil or x ~= nil then
    local newurl = self:GetUrlWithParam(srcUrl, openid, info)
    Log.debug("[url] out imur", newurl)
    return true, newurl
  end
  l, q = string.find(srcUrl, "imur.tencent.com")
  if l == nil then
    return false, srcUrl
  else
    local newurl = self:GetUrlWithParam(srcUrl, paltid, sArea, sPartition, sRoleid)
    Log.debug("[url] in imur", newurl)
    return true, newurl
  end
end

function HelperProxy:AppendImurCallback(url)
  local zoneID2CallbackNum = {
    [186] = 1,
    [11] = 2,
    [115] = 3,
    [102] = 4,
    [171] = 5,
    [191] = 6,
    [13] = 7,
    [81] = 1,
    [82] = 2,
    [83] = 3,
    [84] = 4,
    [85] = 6,
    [86] = 7,
    [91] = 5,
    [101] = 8,
    [192] = 9,
    [117] = 10
  }
  local serverZoneID = GameGlobal.GameLogic():GetModule(PayModule):GetMidasZoneID()
  local callback = zoneID2CallbackNum[serverZoneID]
  local appendCallback = "&callback=" .. tostring(callback)
  return url .. appendCallback
end

function HelperProxy:OpenUrl(hrefName)
  if not string.find(hrefName, "survey") then
    SDKProxy:GetInstance():OpenUrl(hrefName, true)
    return
  end
  Log.debug("HelperProxy:OpenUrl , hrefName : ", hrefName)
  local bfind, newurl = self:FileImurUrl(hrefName)
  Log.debug("newurl : ", newurl)
  local final_url
  if bfind then
    final_url = self:AppendImurCallback(newurl)
  else
    Log.debug("[url]", hrefName)
    final_url = self:AppendImurCallback(hrefName)
  end
  SDKProxy:GetInstance():OpenUrl(final_url)
end

function HelperProxy:GetHeadIconSizeWithTag(rt, tag)
  local size = self.tag2size[tag]
  if rt == nil or size == nil then
    Log.error("GetHeadIconSizeWithTag cant find tag ", tag)
    return
  end
  rt.sizeDelta = size
end

function HelperProxy:GetHeadBgSizeWithTag(rt)
  local size = Vector2(193, 175)
  rt.sizeDelta = size
end

function HelperProxy:GetHeadFrameDefaultID()
  if _G.IsInland then
    return 3762000
  else
    return 1000
  end
end

function HelperProxy:GetHeadIconDefaultID()
  if _G.IsInland then
    return 3751001
  else
    return 1001
  end
end

function HelperProxy:GetHeadBgDefaultID()
  return 1
end

function HelperProxy:GetHeadBgName(headBg)
  local cfg_head_bg = headBg and Cfg.cfg_player_head_bg[headBg]
  if not cfg_head_bg then
    local bid = self:GetHeadBgDefaultID()
    cfg_head_bg = Cfg.cfg_player_head_bg[bid]
  end
  return cfg_head_bg.Icon
end

function HelperProxy:GetHeadIconName(head)
  if _G.IsInland then
    local cfg_head = head and Cfg.cfg_item_head[head]
    if not cfg_head then
      local id = self:GetHeadIconDefaultID()
      cfg_head = Cfg.cfg_item_head[id]
    end
    if not cfg_head then
      return "", ""
    end
    return cfg_head.Icon, cfg_head.Tag
  else
    local cfg_header = Cfg.cfg_role_head_image[head]
    if cfg_header then
      return cfg_header.Icon, ""
    else
      return "", ""
    end
  end
end

function HelperProxy:GetHeadFrameName(headFrame)
  if _G.IsInland then
    local cfg_head_frame = headFrame and Cfg.cfg_item_headframe[headFrame]
    if not cfg_head_frame then
      local id = self:GetHeadFrameDefaultID()
      cfg_head_frame = Cfg.cfg_item_headframe[id]
    end
    return cfg_head_frame.Icon
  else
    if not headFrame or headFrame == 0 then
      headFrame = HelperProxy:GetInstance():GetHeadFrameDefaultID()
    end
    local cfgHeadFrame = Cfg.cfg_role_head_frame[headFrame]
    return cfgHeadFrame.Icon
  end
end

function HelperProxy:GetHeadBgMaskSizeWithTag(rt)
  local size = Vector2(165, 165)
  rt.sizeDelta = size
end

function HelperProxy:GetHeadRootSizeWithTag(rt, type)
  local scale = self.frame2scale[type]
  rt.localScale = Vector3(1, 1, 1) * scale
end

function HelperProxy:GetHeadFrameSizeWithTag(rt)
  local size = Vector2(231, 231)
  rt.sizeDelta = size
end

function HelperProxy:SetShowMuskActive(active)
  self._common_lua_helper:SetShadowSettingActive(active)
end

function HelperProxy:ReplacePlayerName(strContent)
  local roleName = GameGlobal.GetModule(RoleModule):GetName()
  strContent = string.gsub(strContent, "PlayerName", roleName)
  return strContent
end

function HelperProxy:CheckEmail(strContent)
  if not strContent then
    return false
  end
  if strContent:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?") then
    return true
  else
    return false
  end
end

function HelperProxy:GetEquipSkillDesc(desc, petid, equiplv, skillid)
  local buffids = {}
  local cfg_p_skill = Cfg.cfg_passive_skill[skillid]
  if cfg_p_skill then
    buffids = cfg_p_skill.BuffID
  else
    Log.fatal("###[GetEquipSkillDesc] cfg_passive_skill is nil ! id --> ", skillid)
    return
  end
  local cfg_equip = Cfg.cfg_pet_equip({PetID = petid, Level = equiplv})
  local descStr
  if not cfg_equip then
    return StringTable.Get(desc)
  end
  local equipData = cfg_equip[1]
  local skillParam = equipData.elementParam
  local descStrParam
  if skillParam then
    descStrParam = {}
    local idx = 0
    for index, buff in ipairs(skillParam) do
      local insert = false
      for i = 1, #buffids do
        local buffid = buffids[i]
        if buffid == buff.BuffID then
          insert = true
          break
        end
      end
      if insert then
        for index2, tmp in ipairs(buff) do
          if tmp.isShow == nil or tmp.isShow == true then
            idx = idx + 1
            local buffValue
            if tmp.type == 1 then
              buffValue = tostring(tmp.value)
            elseif tmp.type == 2 then
              buffValue = self:GetEquipSkillParamValue(tmp.value) .. "%%"
            elseif tmp.type == 3 then
              buffValue = self:GetEquipSkillParamValue(tmp.value + 1) .. "%%"
            end
            descStrParam[idx] = buffValue
          end
        end
      end
    end
  end
  if descStrParam then
    descStr = StringTable.Get(desc, table.unpack(descStrParam))
  else
    descStr = StringTable.Get(desc)
  end
  return descStr
end

function HelperProxy:GetEquipSkillDescDiff(desc, petid, equiplv, nextLv, skillid)
  local buffids = {}
  local cfg_p_skill = Cfg.cfg_passive_skill[skillid]
  if cfg_p_skill then
    buffids = cfg_p_skill.BuffID
  else
    Log.fatal("###[GetEquipSkillDescDiff] cfg_passive_skill is nil ! id --> ", skillid)
    return
  end
  local cfg_equip = Cfg.cfg_pet_equip({PetID = petid, Level = equiplv})
  local descStr
  if not cfg_equip then
    Log.error("###[GetEquipSkillDescDiff]Cfg.cfg_pet_equip is nil ! id --> ", petid, "|lv -- > ", equiplv)
    return
  end
  local cfg_equip_next = Cfg.cfg_pet_equip({PetID = petid, Level = nextLv})
  local descStr_next
  if not cfg_equip_next then
    Log.error("###[GetEquipSkillDescDiff]Cfg.cfg_equip_next is nil ! id --> ", petid, "|lv -- > ", nextLv)
    return
  end
  local equipData = cfg_equip[1]
  local equipData_next = cfg_equip_next[1]
  local skillParam = equipData.elementParam
  local skillParam_next = equipData_next.elementParam
  local descStrParam, descStrParam_next
  if skillParam then
    descStrParam = {}
    local idx = 0
    for index, buff in ipairs(skillParam) do
      local insert = false
      for i = 1, #buffids do
        local buffid = buffids[i]
        if buffid == buff.BuffID then
          insert = true
          break
        end
      end
      if insert then
        for index2, tmp in ipairs(buff) do
          if tmp.isShow == nil or tmp.isShow == true then
            idx = idx + 1
            local buffValue
            if tmp.type == 1 then
              buffValue = tostring(tmp.value)
            elseif tmp.type == 2 then
              buffValue = self:GetEquipSkillParamValue(tmp.value) .. "%%"
            elseif tmp.type == 3 then
              buffValue = self:GetEquipSkillParamValue(tmp.value + 1) .. "%%"
            end
            descStrParam[idx] = buffValue
          end
        end
      end
    end
  end
  if skillParam_next then
    descStrParam_next = {}
    local idx = 0
    for index, buff in ipairs(skillParam_next) do
      local insert = false
      for i = 1, #buffids do
        local buffid = buffids[i]
        if buffid == buff.BuffID then
          insert = true
          break
        end
      end
      if insert then
        for index2, tmp in ipairs(buff) do
          if tmp.isShow == nil or tmp.isShow == true then
            idx = idx + 1
            local buffValue
            if tmp.type == 1 then
              buffValue = tostring(tmp.value)
            elseif tmp.type == 2 then
              buffValue = self:GetEquipSkillParamValue(tmp.value) .. "%%"
            elseif tmp.type == 3 then
              buffValue = self:GetEquipSkillParamValue(tmp.value + 1) .. "%%"
            end
            descStrParam_next[idx] = buffValue
          end
        end
      end
    end
  end
  local changeTab = {}
  for i = 1, #descStrParam_next do
    local change = false
    local item_next = descStrParam_next[i]
    local item = descStrParam[i]
    if item_next ~= item then
      change = true
    end
    if change then
      item_next = "<color=#ffca01>" .. item_next .. "</color>"
      descStrParam_next[i] = item_next
    end
  end
  descStr = StringTable.Get(desc)
  if descStrParam_next and 0 < #descStrParam_next then
    return self:GetStringWithOutHtmlColor(descStr, descStrParam_next)
  else
    return self:GetStringWithOutHtmlColor(descStr)
  end
end

function HelperProxy:GetEquipSkillParamValue(num)
  if type(num) ~= "number" then
    Log.fatal("### num is not number.")
    return 0
  end
  local a = num * 100
  local c, d = math.modf(a)
  if 0.001 < d then
    return c + d
  else
    return c
  end
end

function HelperProxy:GetStringWithOutHtmlColor(stg, param)
  local str = stg
  local ss_1 = string.split(str, "<link=")
  local c = table.count(ss_1)
  local ls = ""
  for i = 1, c do
    local ls_tmp = ""
    if i == 1 then
      local stemp = ss_1[i]
      local append_tmp = string.gsub(stemp, "%b<>", "")
      ls_tmp = ls_tmp .. append_tmp
    else
      ls_tmp = ls_tmp .. "<link="
      local ss_2 = string.split(ss_1[i], "</link>")
      local c_2 = table.count(ss_2)
      for j = 1, c_2 do
        if j == 1 then
          ls_tmp = ls_tmp .. ss_2[j]
        else
          ls_tmp = ls_tmp .. "</link>"
          local stemp = ss_2[j]
          local append_tmp = string.gsub(stemp, "%b<>", "")
          ls_tmp = ls_tmp .. append_tmp
        end
      end
    end
    ls = ls .. ls_tmp
  end
  local descStr
  if param then
    descStr = StringTable:GetInstance():FindStringWithParams(ls, table.unpack(param))
  else
    descStr = str
  end
  return descStr
end

function HelperProxy:GetPetSkinCfg(tid, grade, skinId, path)
  local realSkinId = 0
  if self:IsEffectByPetSkin(path) and skinId and 1 < skinId then
    realSkinId = skinId
  end
  if realSkinId == 0 then
    if grade == 0 then
      local petCfg = Cfg.cfg_pet[tid]
      if not petCfg then
        return nil
      end
      realSkinId = petCfg.SkinId
    else
      local gradeCfg = Cfg.cfg_pet_grade({PetID = tid, Grade = grade})[1]
      if not gradeCfg then
        return nil
      end
      realSkinId = gradeCfg.SkinId
    end
  end
  local cfg = Cfg.cfg_pet_skin[realSkinId]
  if not cfg then
    Log.fatal("###[GetPetSkinCfg] skin cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg
end

function HelperProxy:GetPetHead(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetHead] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.Head
end

function HelperProxy:GetPetItemIcon(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.fatal("###[GetPetItemIcon] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.ItemIcon
end

function HelperProxy:GetPetVideo(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetVideo] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.VideoIcon
end

function HelperProxy:GetPetTeamBody(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetTeamBody] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.TeamBody
end

function HelperProxy:GetPetStaticBody(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetStaticBody] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.StaticBody
end

function HelperProxy:GetMainLobbyStaticBody(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetSimpleCg] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.MainLobbyCg
end

function HelperProxy:GetPetSimpleCg(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetSimpleCg] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.SimpleCG
end

function HelperProxy:GetPetAircraftBody(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetAircraftBody] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.AircraftBody
end

function HelperProxy:GetPetBattleMes(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetCg] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.BattleMes
end

function HelperProxy:GetPetHeadChain(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetHeadChain] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.HeadChain
end

function HelperProxy:GetPetSpine(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetCg] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.Spine
end

function HelperProxy:GetMainLobbySpine(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetCg] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.MainLobbySpine
end

function HelperProxy:GetMainLobbyEnterSpine(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetCg] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.MainLobbyEnterSpine
end

function HelperProxy:GetMainLobbyEnterSpineSubGo(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetCg] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.MainLobbyEnterSpineSubGo
end

function HelperProxy:GetPetBody(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetCg] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.Body
end

function HelperProxy:GetPetPrefab(tid, grade, skinId, path)
  local cfg = self:GetPetSkinCfg(tid, grade, skinId, path)
  if not cfg then
    Log.debug("###[GetPetPrefab] cfg is nil ! id --> ", tid, "| grade --> ", grade, "| skinId --> ", skinId, "| path --> ", path)
    return nil
  end
  return cfg.Prefab
end

function HelperProxy:IsEffectByPetSkin(path)
  if not path then
    return true
  end
  local cfg = Cfg.cfg_pet_skin_effect_filter[path]
  if cfg then
    return cfg.Effected
  end
  return true
end

function HelperProxy:NewStringList()
  return self._common_lua_helper:NewStringList()
end

function HelperProxy:GetNavAgentID(index)
  return self._common_lua_helper:GetNavAgentID(index)
end

function HelperProxy:CopyTextToClipboard(text)
  if string.isnullorempty(text) then
    return
  end
  self._common_lua_helper:CopeTextToClipboard(text)
end

function HelperProxy:AgainFightActive(matchType, win)
  local _win = 0
  if win then
    _win = 1
  else
    _win = 0
  end
  local cfg_again_fight = Cfg.cfg_again_fight({Type = matchType, Win = _win})
  if cfg_again_fight then
    local active = cfg_again_fight[1].Active
    if active == 1 then
      return true
    else
      return false
    end
  end
  return false
end

function HelperProxy:AddAnimTo(from, to)
  self._common_lua_helper:AddAnimTo(from, to)
end

function HelperProxy:RemoveAnimTo(from, to)
  self._common_lua_helper:RemoveAnimTo(from, to)
end

function HelperProxy:TriggerAircraftAnimationEvent(anim, clip, time)
  self._common_lua_helper:TriggerAircraftAnimationEvent(anim, clip, time)
end

function HelperProxy:SetRoleShaderLodLevel(level)
  self._common_lua_helper:SetRoleShaderLodLevel(level)
end

function HelperProxy:AddFpsTools()
  self._common_lua_helper:AddFpsTools()
end

function HelperProxy:GetVideoUrl(name)
  return ResourceManager:GetInstance():GetAssetPath(name, LoadType.VideoClip)
end

function HelperProxy:CopyString(str)
  UnityEngine.GUIUtility.systemCopyBuffer = str
end

function HelperProxy:SetGameTimeScale(scale)
  UnityEngine.Time.timeScale = scale
  UnityEngine.PlayerPrefs.SetFloat("TimeScale", scale)
  Log.debug("SetTimeScale ", scale, " ")
end

function HelperProxy:GetFixTimeLen(sourceLen)
  return sourceLen * UnityEngine.Time.timeScale
end

function HelperProxy:GetGameTimeScale()
  return UnityEngine.Time.timeScale
end

function HelperProxy:IsInEnglish()
  local currentLanguageType = Localization.GetCurLanguage()
  if currentLanguageType == LanguageType.us or currentLanguageType == LanguageType.idn or currentLanguageType == LanguageType.es or currentLanguageType == LanguageType.pt then
    return true
  end
  return false
end

function HelperProxy:Sec2DayHourMin(sec)
  local minAll = sec // 60
  local min = minAll % 60
  local hourAll = minAll // 60
  local hour = hourAll % 24
  local day = hourAll // 24
  return day, hour, min
end

function HelperProxy:Time2Tex(sec)
  local timeStr = ""
  local minAll = sec // 60
  local min = minAll % 60
  local hourAll = minAll // 60
  local hour = hourAll % 24
  local day = hourAll // 24
  if day and 0 < day then
    if hour and 0 < hour then
      timeStr = StringTable.Get("str_week_tower_reset_time_day_and_hour", day, hour)
    else
      timeStr = StringTable.Get("str_week_tower_reset_time_day", day)
    end
    return timeStr
  end
  if hour and 0 < hour then
    if min and 0 < min then
      timeStr = StringTable.Get("str_week_tower_reset_time_hour_and_min", hour, min)
    else
      timeStr = StringTable.Get("str_week_tower_reset_time_hour", hour)
    end
    return timeStr
  end
  if min and 0 < min then
    timeStr = StringTable.Get("str_week_tower_reset_time_only_min", min)
    return timeStr
  end
  timeStr = StringTable.Get("str_week_tower_reset_time_only_sec")
  return timeStr
end

function HelperProxy:GetGiftsFromNeedMat(needMat)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local items = itemModule:GetItemListBySubType(ItemSubType.ItemSubType_Gift)
  local haveChooseGift = {}
  local cfg_gift = Cfg.cfg_item_gift({})
  for _, v in pairs(items) do
    local giftId = v:GetTemplateID()
    local giftPstId = v:GetID()
    local giftCount = v:GetCount()
    local _cfg_gift = cfg_gift[giftId]
    if _cfg_gift then
      local GiftType = _cfg_gift.ItemGiftType
      if GiftType == ItemGiftType.ItemGiftType_Choose then
        local gift = {}
        gift.id = giftId
        gift.pstid = giftPstId
        gift.count = giftCount
        table.insert(haveChooseGift, gift)
      end
    end
  end
  table.sort(haveChooseGift, function(a, b)
    return a.id > b.id
  end)
  local openGiftList = {}
  local needMatList = needMat
  Log.debug("###[lxs] 检查的材料列表[", #needMatList, "]")
  for i = 1, #needMatList do
    Log.debug("###[lxs] 材料 id[", needMatList[i].id, "] 数量[", needMatList[i].count, "]")
  end
  Log.debug("###[lxs] 拥有的礼包列表[", #haveChooseGift, "]")
  for i = 1, #haveChooseGift do
    Log.debug("###[lxs] 礼包 id[", haveChooseGift[i].id, "] 数量[", haveChooseGift[i].count, "]")
  end
  
  local function _getItemListByGiftCfg(giftid)
    local __cfg = cfg_gift[giftid]
    return __cfg.ItemList
  end
  
  local function _checkMatInGift(giftid, matid)
    local __cfg = cfg_gift[giftid]
    local __itemList = __cfg.ItemList
    if __itemList then
      for i = 1, #__itemList do
        local __item = __itemList[i]
        if __item[1] == matid then
          return true, i, __item[2]
        end
      end
    end
    return false
  end
  
  local checkIdx = #needMatList
  while 0 < checkIdx do
    local mat = needMatList[checkIdx]
    Log.debug("###[lxs] 检查材料[", mat.id, "] 需要[", mat.count, "]")
    local matCheckEnd = false
    while not matCheckEnd do
      Log.debug("###[lxs] 材料不够，查")
      for j = #haveChooseGift, 1, -1 do
        local gift = haveChooseGift[j]
        local inGift, inGiftIdx, inGiftCount = _checkMatInGift(gift.id, mat.id)
        if inGift then
          Log.debug("###[lxs] 在该礼包[", gift.id, "] 数量[", gift.count, "]")
          local less = mat.count - inGiftCount * gift.count
          local useCount
          if less <= 0 then
            Log.debug("###[lxs] 这个礼包  足够  开出全部材料")
            matCheckEnd = true
            useCount = math.ceil(mat.count / inGiftCount)
          else
            Log.debug("###[lxs] 这个礼包  不能  开出全部材料")
            useCount = gift.count
          end
          Log.debug("###[lxs] 使用了礼包数量[", useCount, "],每个礼包开[", inGiftCount, "]")
          gift.count = gift.count - useCount
          Log.debug("###[lxs] 礼包还剩[", gift.count, "]")
          if gift.count <= 0 then
            Log.debug("###[lxs] 礼包用完了,移除")
            table.remove(haveChooseGift, j)
          end
          mat.count = mat.count - useCount * inGiftCount
          Log.debug("###[lxs] 这个材料还需要[", mat.count, "]")
          if mat.count <= 0 then
            Log.debug("###[lxs] 这个材料够了,移除")
            table.remove(needMatList, checkIdx)
          end
          local saveGift = {}
          saveGift.id = gift.id
          saveGift.pstid = gift.pstid
          saveGift.count = useCount
          saveGift.idx = inGiftIdx
          table.insert(openGiftList, saveGift)
          Log.debug("###[lxs] 记录一下这个礼包使用,id[", saveGift.id, "] 数量[", saveGift.count, "]")
        else
          Log.debug("###[lxs] 不在该礼包[", gift.id, "]")
        end
        if matCheckEnd then
          Log.debug("###[lxs] 材料够了,查下一个材料")
          break
        else
          Log.debug("###[lxs] 材料还不够,查下一个礼包")
        end
      end
      matCheckEnd = true
    end
    checkIdx = checkIdx - 1
  end
  Log.debug("###[lxs] 所有材料检查完毕,使用了这些礼包")
  for i = 1, #openGiftList do
    local g = openGiftList[i]
    local gid = g.id
    local gc = g.count
    local gi = g.idx
    Log.debug("###[lxs] 礼包 id[", gid, "] count[", gc, "] idx[", gi, "]")
  end
  if table.count(needMatList) == 0 then
    Log.debug("###[lxs] 需要的材料  都能开出来")
    return true, openGiftList
  end
  Log.debug("###[lxs] 需要的材料  还差一些")
  return false
end

function HelperProxy:IsCrossDayTo(otherTime)
  local now = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  if 86400 < now - otherTime then
    return true
  end
  local targetTime = GameGlobal.GetModule(LoginModule):GetCampaignRefreshTime() - 86400
  if otherTime < targetTime and now > targetTime then
    return true
  end
  return false
end

function HelperProxy:HomeGetBody(pstid, face)
  local _face
  if face then
    _face = face
  else
    _face = "Norm"
  end
  local icon = ""
  local homeModule = GameGlobal.GetModule(HomelandModule)
  local uiHomeModule = homeModule:GetUIModule()
  local homeClient = uiHomeModule:GetClient()
  local homelandPetManager = homeClient:PetManager()
  local pet = homelandPetManager:GetPetByPstID(pstid)
  local skinid = pet:ClothSkinID()
  local tid = pet:TemplateID()
  local cfg = Cfg.cfg_home_pet_story_face[skinid]
  if cfg then
    icon = cfg[_face]
    if not icon then
      icon = ""
      Log.error("###[HelperProxy] icon is nil ! id --> ", skinid, ",_face --> ", _face)
    end
  else
    icon = "base_icon_" .. tid
    Log.error("###[HelperProxy] cfg is nil ! id --> ", skinid)
  end
  return icon
end

function HelperProxy:CheckBinderID(pets, petid)
  local cfg_pet = Cfg.cfg_pet({})
  local cfg = cfg_pet[petid]
  if cfg_pet and cfg then
    for i = 1, #pets do
      local _petid = pets[i]
      if _petid ~= petid then
        local _cfg = cfg_pet[_petid]
        if _cfg and _cfg.BinderPetID and cfg.BinderPetID and cfg.BinderPetID == _cfg.BinderPetID then
          return true, _petid
        end
      end
    end
  end
  return false
end

function HelperProxy:CheckTextIncludeImgAndSpace(str)
  local plainStr = str
  plainStr = string.gsub(plainStr, "<sprite.*/>", "lixuesen")
  local space = string.match(plainStr, " ")
  local sprite = string.match(plainStr, "lixuesen")
  if space and sprite then
    return true
  else
    return false
  end
end

function HelperProxy:CheckTextIncludeImg(str)
  return false
end

function HelperProxy:GetItemCountStr(count, maxLength, preColor, countColor)
  local dight = 0
  local tmpCount = count
  if tmpCount < 0 then
    tmpCount = -tmpCount
  end
  while 0 < tmpCount do
    tmpCount = math.floor(tmpCount / 10)
    dight = dight + 1
  end
  local pre = ""
  if 0 <= count then
    for i = 1, 7 - dight do
      pre = pre .. "0"
    end
  else
    for i = 1, 7 - dight - 1 do
      pre = pre .. "0"
    end
  end
  if 0 < count then
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  elseif count == 0 then
    return string.format("<color=" .. preColor .. ">%s</color>", pre)
  else
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  end
end

function HelperProxy:GetPetSkillDescFull(pet, skillId, replaceByEquipRefine, specialEquipLv)
  if not pet or not skillId then
    return ""
  end
  local cfg = BattleSkillCfg(skillId)
  if not cfg then
    return ""
  end
  if not self._skillConfigHelper then
    self._skillConfigHelper = SkillConfigHelper:New()
  end
  local skillDesc
  if replaceByEquipRefine then
    skillDesc = self:GetEquipRefineSkillReplace(pet, skillId)
    if skillDesc then
      return skillDesc
    end
  end
  local skillType = cfg.Type
  if skillType == PetSkillType.SkillType_ChainSkill or skillType == PetSkillType.SkillType_Active then
    local skillConfigData = self._skillConfigHelper:GetSkillData(skillId)
    local descForceParam = {}
    if skillType == PetSkillType.SkillType_Active then
      local extraParam = skillConfigData:GetSkillTriggerExtraParam()
      if extraParam and extraParam[SkillTriggerTypeExtraParam.SanChangeByRoundCastTimes] then
        local baseCost = extraParam[SkillTriggerTypeExtraParam.SanValue]
        local modCost = extraParam[SkillTriggerTypeExtraParam.SanChangeByRoundCastTimes]
        local curTimes = 0
        local curCost = baseCost + modCost * curTimes
        table.insert(descForceParam, tostring(curCost))
      end
    end
    skillDesc = skillConfigData:GetPetSkillDes(descForceParam)
  else
    local equipLv
    if specialEquipLv then
      equipLv = specialEquipLv
    else
      equipLv = pet:GetEquipLv()
    end
    if equipLv == 0 then
      equipLv = 1
    end
    skillDesc = self:GetEquipSkillDesc(cfg.Desc, pet:GetTemplateID(), equipLv, skillId)
  end
  return skillDesc
end

function HelperProxy:GetEquipRefineSkillReplace(pet, skillId)
  if not pet or not skillId then
    return nil
  end
  local refineLv = pet:GetEquipRefineLv()
  if refineLv < 1 then
    return nil
  end
  local refineConfig = UIPetEquipHelper.GetRefineCfg(pet:GetTemplateID(), refineLv)
  if not refineConfig then
    return nil
  end
  local replaceData = refineConfig.SubstituteSkillDesc
  if not replaceData then
    return nil
  end
  local newDesc
  for k, v in pairs(replaceData) do
    newDesc = v[skillId]
    if newDesc and newDesc ~= "" then
      break
    end
  end
  if newDesc then
    return StringTable.Get(newDesc)
  end
  return nil
end

function HelperProxy:GetLongEventGrade()
  return self._upLvGradeVal
end

function HelperProxy:SetLongEventGrade(val)
  self._upLvGradeVal = val
end

function HelperProxy:SMazeDamageUnit(num)
  if not num then
    Log.error("###[HelperProxy] SMazeDamageUnit num is nil !")
    return ""
  end
  local tab = {
    [1] = {
      9,
      3,
      "K"
    },
    [2] = {
      12,
      6,
      "M"
    },
    [3] = {
      15,
      -1,
      "M"
    }
  }
  local ret
  for i = #tab, 1, -1 do
    local data = tab[i]
    if num >= math.pow(10, data[1] - 1) then
      local num2
      if data[2] < 0 then
        num2 = "99999999"
      else
        num2 = tostring(math.modf(num / math.pow(10, data[2])))
      end
      ret = num2 .. data[3]
      break
    end
  end
  if ret then
    return ret
  else
    Log.debug("###[HelperProxy] SMazeDamageUnit ret ori num ! num:", num)
    return tostring(num), num
  end
end

local RoleHeadSizeType = {
  Small = 1,
  Middle = 2,
  Big = 3
}
_enum("RoleHeadSizeType", RoleHeadSizeType)
local RoleHeadTag = {
  All = 0,
  QTag = 1,
  Person = 2,
  Camp = 3
}
_enum("RoleHeadTag", RoleHeadTag)
local RoleHeadFrameSizeType = {
  Size1 = 1,
  Size2 = 2,
  Size3 = 3,
  Size4 = 4,
  Size5 = 5,
  Size6 = 6,
  Size7 = 7
}
_enum("RoleHeadFrameSizeType", RoleHeadFrameSizeType)
local PetAnimatorControllerType = {
  Battle = 1,
  Aircraft = 2,
  Homeland = 3,
  HomelandStory = 4
}
_enum("PetAnimatorControllerType", PetAnimatorControllerType)
