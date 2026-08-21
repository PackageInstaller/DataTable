_class("UICommonHelper", Singleton)
UICommonHelper = UICommonHelper

function UICommonHelper:ChangePetTagBackground(templateId, imageLoader, isFullBg)
  local petCfg = Cfg.cfg_pet[templateId]
  local tags = petCfg.Tags
  if not tags or tags[1] == nil then
    return
  end
  local tag = tags[1]
  local tagCfg = Cfg.cfg_pet_tags[tag]
  if not tagCfg then
    return
  end
  local bgName = tagCfg.BgFull
  if not isFullBg then
    bgName = tagCfg.BgHalf
  end
  imageLoader:LoadImage(bgName)
end

function UICommonHelper:GetPassAward(awardHeadType, cfgId, spit)
  local cfg, passFixDropId
  if awardHeadType == AwardHeadType.Mission then
    cfg = Cfg.cfg_mission[cfgId]
  elseif awardHeadType == AwardHeadType.ExtMisson then
    cfg = Cfg.cfg_extra_mission_task[cfgId]
  elseif awardHeadType == AwardHeadType.ResInstance then
    cfg = Cfg.cfg_res_instance_detail[cfgId]
  elseif awardHeadType == AwardHeadType.Maze then
    cfg = Cfg.cfg_maze_room[cfgId]
  elseif awardHeadType == AwardHeadType.Tower then
    cfg = Cfg.cfg_tower_detail[cfgId]
  end
  if not spit then
    return self:GetDropByAwardType(AwardType.Pass, cfg, nil, awardHeadType)
  else
    return self:GetDropByAwardType(AwardType.Pass, cfg, spit, awardHeadType), cfg and cfg.CPassRandomAward or {}
  end
end

function UICommonHelper:IsMazeUseNewCfg()
  local loginModule = GameGlobal.GetModule(LoginModule)
  local timeTransform = 1
  local timeStr = "2024-06-13 05:00:00"
  local switchTime = 0
  if timeTransform == 0 then
    switchTime = loginModule:GetTimeStampByTimeStr(timeStr, Enum_DateTimeZoneType.E_ZoneType_GMT)
  elseif timeTransform == 1 then
    switchTime = loginModule:GetTimeStampByTimeStr(timeStr, Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone)
  end
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local svrTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if switchTime <= svrTime then
    return true
  else
    return false
  end
end

function UICommonHelper:GetDropByAwardType(awardType, cfg, spit, awardHeadType)
  local dataList = {}
  if not cfg then
    return dataList
  end
  if awardType == AwardType.First then
    dataList = self:ParseDrop(cfg.FirstDropId)
  elseif awardType == AwardType.Pass then
    local passFixDropId = cfg.PassFixDropId
    if awardHeadType and awardHeadType == AwardHeadType.Maze and self:IsMazeUseNewCfg() then
      passFixDropId = cfg.NewPassFixDropId
    end
    if spit then
      dataList = self:ParseDrop(passFixDropId)
    else
      dataList = self:ParseDrop(passFixDropId, cfg.CPassRandomAward)
    end
  elseif awardType == AwardType.ThreeStar then
    dataList = self:ParseDrop(cfg.ThreeStarDropId)
  end
  table.sort(dataList, function(a, b)
    local cfga = Cfg.cfg_item[a.ItemID]
    local cfgb = Cfg.cfg_item[b.ItemID]
    if cfga.Color ~= cfgb.Color then
      return cfga.Color > cfgb.Color
    end
    return cfga.ID < cfgb.ID
  end)
  return dataList
end

function UICommonHelper:ParseDrop(dropId, randomAward)
  local dataList = {}
  if not dropId then
    return dataList
  end
  randomAward = randomAward or {}
  local cfgs = Cfg.cfg_drop({DropID = dropId})
  if not cfgs then
    Log.fatal("cfg_drop parse failed:", dropId)
    return dataList
  end
  for k, v in pairs(cfgs) do
    local showType = v.ShowType
    if showType then
      local data = {}
      data.ItemID = v.AssetID
      if data.ItemID and data.ItemID ~= 0 then
        data.Type = v.ProbabilityType
        if showType == 1 then
          data.Count = v.MinCount
        elseif showType == 2 then
          data.Count = 0
        end
        table.insert(dataList, data)
      end
    end
  end
  table.appendArray(dataList, randomAward)
  return dataList
end

function UICommonHelper:GetOptimalEnemys(levelId)
  local monsters, bossList, eliteList = self:GetLevelData(levelId)
  local newMonsters = {}
  for _, value in pairs(bossList) do
    for key, mon in pairs(value) do
      table.insert(newMonsters, mon)
    end
  end
  for _, value in pairs(eliteList) do
    for key, mon in pairs(value) do
      table.insert(newMonsters, mon)
    end
  end
  for _, value in pairs(monsters) do
    for key, mon in pairs(value) do
      table.insert(newMonsters, mon)
    end
  end
  table.sort(newMonsters, function(a, b)
    local classIdA = a.ClassID
    local classIdB = b.ClassID
    local clsA = Cfg.cfg_monster_class[classIdA]
    local clsB = Cfg.cfg_monster_class[classIdB]
    local isBodyAreaA = #clsA.Area
    local isBodyAreaB = #clsB.Area
    local isBossA = clsA.MonsterType == 2 and 1 or 0
    local isBossB = clsB.MonsterType == 2 and 1 or 0
    local isEliteA = a.EliteID ~= nil and 1 or 0
    local isEliteB = b.EliteID ~= nil and 1 or 0
    if isEliteA == isEliteB then
      if isBossA == isBossB then
        if isBodyAreaA == isBodyAreaB then
          return clsA.ID > clsB.ID
        else
          return isBodyAreaA > isBodyAreaB
        end
      else
        return isBossA > isBossB
      end
    else
      return isEliteA > isEliteB
    end
  end)
  local newMonsterIds = {}
  local count = table.count(newMonsters)
  if 5 < count then
    count = 5
  end
  for i = 1, count do
    table.insert(newMonsterIds, newMonsters[i].ID)
  end
  return newMonsterIds
end

function UICommonHelper:GetLevelData(levelId)
  local _levelid
  local roleModule = GameGlobal.GetModule(RoleModule)
  if roleModule:IsPassLevel(levelId) then
    _levelid = levelId
  else
    local _cfg_level_tmp = Cfg.cfg_level[levelId]
    if _cfg_level_tmp then
      if _cfg_level_tmp.FirstFightLevelID then
        _levelid = _cfg_level_tmp.FirstFightLevelID
      end
    else
      Log.error("###[UICommonHelper] cfg_level is nil ! id --> ", levelId)
    end
  end
  if not _levelid then
    _levelid = levelId
    Log.debug("###[UICommonHelper] 保险 _levelid is nil ! levelId == ", levelId)
  end
  local roleModule = GameGlobal.GetModule(RoleModule)
  local info_normal = {}
  local info_boss = {}
  local info_elite = {}
  local cfg_monster_class = Cfg.cfg_monster_class({})
  
  local function callBack(monsterId)
    local mon = Cfg.cfg_monster[monsterId]
    if mon and mon.ClassID and mon.ClassID > 0 then
      local cfg_class = cfg_monster_class[mon.ClassID]
      if not cfg_class then
        Log.error("###[UICommonHelper] cfg_class is nil ! id --> ", mon.ClassID)
      end
      local type = cfg_class.MonsterType
      local elite = mon.EliteID
      local info
      local key = tostring(mon.ClassID)
      if elite then
        key = key .. "_" .. mon.ElementType
        key = key .. "_" .. table.concat(mon.EliteID, "_")
        info = info_elite
      elseif type == 2 or type == 4 then
        key = key .. "_" .. mon.ElementType
        info = info_boss
      else
        key = key .. "_" .. mon.ElementType
        info = info_normal
      end
      info[key] = mon
    end
  end
  
  local value = Cfg.cfg_level[_levelid]
  for kk, vv in ipairs(value.MonsterWave) do
    local cmwvv = Cfg.cfg_monster_wave[vv]
    if cmwvv ~= nil then
      local refreshIDList = {}
      table.insert(refreshIDList, cmwvv.WaveBeginRefreshID)
      if cmwvv.WaveInternalRefresh then
        for index, value in ipairs(cmwvv.WaveInternalRefresh) do
          local refreshID = value.refreshID
          table.insert(refreshIDList, refreshID)
        end
      end
      if table.count(refreshIDList) > 0 then
        for i = 1, #refreshIDList do
          local crvv = Cfg.cfg_refresh[refreshIDList[i]]
          if crvv ~= nil then
            local len = #crvv.MonsterRefreshIDList
            if len == 1 then
              local cmrd = Cfg.cfg_refresh_monster[crvv.MonsterRefreshIDList[1]]
              if cmrd ~= nil and cmrd.MonsterIDList ~= nil then
                for krmd, vrmd in ipairs(cmrd.MonsterIDList) do
                  callBack(vrmd)
                end
              end
            end
          end
        end
      end
    end
  end
  
  local function bookShowClassIDFilter(tab)
    local newTab = {}
    for index, mon in pairs(tab) do
      local cfg = cfg_monster_class[mon.ClassID]
      local bookShowClassId = cfg.bookShowClassId
      if bookShowClassId and -1 < bookShowClassId and not newTab[bookShowClassId] then
        newTab[bookShowClassId] = {}
        table.insert(newTab[bookShowClassId], mon)
      end
    end
    return newTab
  end
  
  local info_normal_new = bookShowClassIDFilter(info_normal)
  local info_boss_new = bookShowClassIDFilter(info_boss)
  local info_elite_new = bookShowClassIDFilter(info_elite)
  return info_normal_new, info_boss_new, info_elite_new
end

function UICommonHelper:TrggerLocalRecordTime(hashKey)
  local trigger = false
  Log.debug("###man CheckOpenNoticeAndShowRed")
  local _svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  if UnityEngine.PlayerPrefs.HasKey(hashKey) then
    local lastLoginTime = UnityEngine.PlayerPrefs.GetInt(hashKey)
    Log.debug("###man HasKey - lastLoginTime - ", lastLoginTime)
    local loginTimeTemp = _svrTimeModule:GetServerTime() / 1000
    local loginTime = math.modf(loginTimeTemp)
    Log.debug("###man HasKey - loginTime - ", loginTime)
    local timeTab = self:Time2Day(loginTime)
    timeTab.hour = 0
    timeTab.minute = 0
    timeTab.second = 0
    local timeOffset = {}
    local cfgHour = Cfg.cfg_global.ui_notice_data_reset_time_hour.IntValue
    if cfgHour then
      Log.debug("###main cfgHour - ", cfgHour)
      timeOffset.hour = cfgHour
    else
      Log.debug("###main cfgHour - no !")
      timeOffset.hour = 5
    end
    timeOffset.minute = 0
    timeOffset.second = 0
    timeTab.hour = timeTab.hour + timeOffset.hour
    timeTab.minute = timeTab.minute + timeOffset.minute
    timeTab.second = timeTab.second + timeOffset.second
    local tempDay = timeTab.day
    local resetTime = os.time({
      day = timeTab.day,
      month = timeTab.month,
      year = timeTab.year,
      hour = timeTab.hour,
      minute = timeTab.minute,
      second = timeTab.second
    })
    Log.debug("###loginTime - ", loginTime, "  resetTime - ", resetTime)
    if loginTime < resetTime then
      tempDay = tempDay - 1
      resetTime = os.time({
        day = tempDay,
        month = timeTab.month,
        year = timeTab.year,
        hour = timeTab.hour,
        minute = timeTab.minute,
        second = timeTab.second
      })
    end
    if lastLoginTime < resetTime then
      UnityEngine.PlayerPrefs.SetInt(hashKey, loginTime)
      trigger = true
    end
  else
    local loginTime = math.modf(_svrTimeModule:GetServerTime() / 1000)
    UnityEngine.PlayerPrefs.SetInt(hashKey, loginTime)
    trigger = true
  end
  return trigger
end

function UICommonHelper:Time2Day(unixTime)
  local tb = {}
  tb.year = tonumber(os.date("%Y", unixTime))
  tb.month = tonumber(os.date("%m", unixTime))
  tb.day = tonumber(os.date("%d", unixTime))
  tb.hour = tonumber(os.date("%H", unixTime))
  tb.minute = tonumber(os.date("%M", unixTime))
  tb.second = tonumber(os.date("%S", unixTime))
  return tb
end

function UICommonHelper:HandleLoginErrorCode(retCode, thirdCode)
  if retCode == 1 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_1", retCode))
  elseif retCode == 2 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_2", retCode))
  elseif retCode == 3 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_3", retCode))
  elseif retCode == 4 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_4", thirdCode))
  elseif retCode == 5 then
    local msg = StringTable.Get("str_login_error_code_tips", thirdCode)
    if thirdCode == 2001 or thirdCode == 2003 then
      msg = StringTable.Get("str_login_error_code_2001", thirdCode)
    elseif thirdCode == 2002 then
      msg = StringTable.Get("str_login_error_code_2002", thirdCode)
    elseif thirdCode == 2011 or thirdCode == 2012 or thirdCode == 2013 or thirdCode == 2103 or thirdCode == 2104 then
      msg = StringTable.Get("str_login_error_code_2011", thirdCode)
    elseif thirdCode == 2021 then
      msg = StringTable.Get("str_login_error_code_2021", thirdCode)
    elseif thirdCode == 2022 then
      msg = StringTable.Get("str_login_error_code_2022", thirdCode)
    elseif thirdCode == 2023 then
      msg = StringTable.Get("str_login_error_code_2023", thirdCode)
    elseif thirdCode == 2121 or thirdCode == 2122 then
      msg = StringTable.Get("str_login_error_code_2121", thirdCode)
    elseif thirdCode == 2125 then
      msg = StringTable.Get("str_login_error_code_2125", thirdCode)
    elseif thirdCode == 2126 then
      msg = StringTable.Get("str_login_error_code_2126", thirdCode)
    elseif thirdCode == 2127 or thirdCode == 2128 then
      msg = StringTable.Get("str_login_error_code_2127", thirdCode)
    elseif thirdCode == 2129 or thirdCode == 2130 or thirdCode == 2131 then
      msg = StringTable.Get("str_login_error_code_2129", thirdCode)
    elseif thirdCode == 2136 then
      msg = StringTable.Get("str_login_error_code_2136", thirdCode)
    elseif thirdCode == 2143 or thirdCode == 2112 then
      msg = StringTable.Get("str_login_error_code_2143", thirdCode)
    elseif thirdCode == 2148 then
      msg = StringTable.Get("str_login_error_code_2148", thirdCode)
    elseif thirdCode == 2149 then
      msg = StringTable.Get("str_login_error_code_2149", thirdCode)
    elseif thirdCode == 2155 then
      msg = StringTable.Get("str_login_error_code_2155", thirdCode)
    elseif thirdCode == 2114 then
      msg = StringTable.Get("str_login_error_code_2114", thirdCode)
    elseif thirdCode == 2117 or thirdCode == 2118 then
      msg = StringTable.Get("str_login_error_code_2117_2118", thirdCode)
    elseif thirdCode == 2120 then
      msg = StringTable.Get("str_login_error_code_2120", thirdCode)
    elseif thirdCode == 1403 then
      msg = StringTable.Get("str_login_error_code_1403", thirdCode)
    elseif thirdCode == 1105 then
      msg = StringTable.Get("str_login_error_code_2001", thirdCode)
    end
    ToastManager.ShowToast(msg)
  elseif retCode == 6 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_6", retCode))
  elseif retCode == 8 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_8", retCode))
  elseif retCode == 14 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_14", retCode))
  elseif retCode == 20 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_20", retCode))
  elseif retCode == 21 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_21", retCode))
  elseif retCode == 22 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_22", retCode))
  elseif retCode == 1000 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_1000", retCode))
  elseif retCode == 1001 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_1001", retCode))
  elseif retCode == 1002 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_1002", retCode))
  elseif retCode == 1600 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_1600", retCode))
  elseif retCode == 9999 then
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_9999", thirdCode))
  else
    ToastManager.ShowToast(StringTable.Get("str_login_error_code_tips", retCode))
  end
end

function UICommonHelper.GetNowTimestamp()
  local mSvrTime = GameGlobal.GetModule(SvrTimeModule)
  local nowTimestamp = mSvrTime:GetServerTime() / 1000
  return nowTimestamp
end

function UICommonHelper.CalcLeftSeconds(endTimestamp)
  local nowTimestamp = UICommonHelper.GetNowTimestamp()
  local leftSeconds = endTimestamp - nowTimestamp
  if leftSeconds <= 0 then
    return 0
  end
  return leftSeconds
end

function UICommonHelper.S2DHMS(s)
  if s <= 0 then
    return 0, 0, 0, 0
  end
  local d = s / 86400
  local dm = s % 86400
  local h = dm / 3600
  local hm = s % 3600
  local m = hm / 60
  local mm = s % 60
  local s = mm
  return d, h, m, s
end

local vecCenter = Vector2(0.5, 0.5)
local vecLeft = Vector2(0, 0.5)

function UICommonHelper:RectTransformAnchor2Center(rt)
  rt.anchorMax = vecCenter
  rt.anchorMin = vecCenter
  rt.sizeDelta = Vector2.zero
end

function UICommonHelper:RectTransformAnchor2Left(rt)
  rt.anchorMax = vecLeft
  rt.anchorMin = vecLeft
  rt.sizeDelta = Vector2.zero
end

function UICommonHelper:SwitchToUIMain()
  if GameGlobal.UIStateManager():CurUIStateType() == UIStateType.UIMain then
    GameGlobal.UIStateManager():CloseAllDialogsExcept("UIMainLobbyController")
    UIBgmHelper.PlayMainBgm()
  elseif GameGlobal.GetModule(SeasonModule):UIModule():InSeasaonRunning() then
    GameGlobal.GetUIModule(SeasonModule):ExitSeasonTo(UIStateType.UIMain)
  elseif GameGlobal.GetModule(SeasonMazeModule):UIModule():IsRunning() then
    GameGlobal.GetUIModule(SeasonMazeModule):ExitTo(UIStateType.UIMain)
  else
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  end
end
