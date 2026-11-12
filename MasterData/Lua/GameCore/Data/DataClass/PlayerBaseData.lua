local PlayerBaseData = class("PlayerBaseData")
local TimerManager = require("GameCore.Timer.TimerManager")
local AvgManager = require("GameCore.Module.AvgManager")
local NotificationManager = require("GameCore.Module.NotificationManager")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local TimerScaleType = require("GameCore.Timer.TimerScaleType")
local ModuleManager = require("GameCore.Module.ModuleManager")
local localdata = require("GameCore.Data.LocalData")
local RapidJson = require("rapidjson")
local PcEventUpWorldLv = {
  [5] = "pc_level_5",
  [10] = "pc_level_10",
  [15] = "pc_level_15",
  [20] = "pc_level_20",
  [25] = "pc_level_25",
  [30] = "pc_level_30",
  [35] = "pc_level_35",
  [40] = "pc_level_40",
  [45] = "pc_level_45",
  [50] = "pc_level_50",
  [55] = "pc_level_55",
  [60] = "pc_level_60"
}

function PlayerBaseData:Init()
  self._nPlayerId = nil
  self._sPlayerNickName = nil
  self._bMale = false
  self._nNewbie = nil
  self._nCreateTime = nil
  self._nHeadIconId = nil
  self._nHashtag = nil
  self._sSignature = nil
  self._nShowSkinId = nil
  self._nTitlePrefix = nil
  self._nTitleSuffix = nil
  self._tbTitle = nil
  self._tbCoreTeam = nil
  self._nWorldClass = 0
  self._nWorldExp = 0
  self._nWorldStage = 0
  self._nCurWorldStageIndex = 0
  self._nCurEnergy = 0
  self._nCurEnergyBattery = 0
  self._nEnergyTime = 0
  self._nEnergyBatteryTime = 0
  self._nBuyEnergyCount = 0
  self._nBuyEnergyLimit = 0
  self._mapEnergyTimer = nil
  self._nOldWorldClass = 0
  self._nOldWorldExp = 0
  self._tbHonorTitle = nil
  self._tbHonorTitleList = nil
  self._nSendGiftCnt = 0
  self._nRenameTime = 0
  self.nRequestEnergyLimitTime = 10
  self._sDestoryUrl = ""
  self._bWorldClassChange = false
  self.bNewDay = false
  self.bNeedHotfix = false
  self.bShowNewDayWindDelay = false
  self.bShowNewDayWind = false
  self.bSkipNewDayWind = false
  self.bInLoading = false
  self:ProcessTableData()
  EventManager.Add(EventId.TransAnimInClear, self, self.OnEvent_TransAnimInClear)
  EventManager.Add(EventId.TransAnimOutClear, self, self.OnEvent_TransAnimOutClear)
  EventManager.Add(EventId.UserEvent_CreateRole, self, self.Event_CreateRole)
  EventManager.Add("Prologue_EventUpload", self, self.PrologueEventUpload)
  EventManager.Add("CS2LuaEvent_OnApplicationFocus", self, self.OnCS2LuaEvent_AppFocus)
end

function PlayerBaseData:UnInit()
  if self.NextRefreshTimer ~= nil then
    self.NextRefreshTimer:Cancel()
    self.NextRefreshTimer = nil
  end
  if self._mapEnergyTimer ~= nil then
    self._mapEnergyTimer:Cancel(nil)
    self._mapEnergyTimer = nil
  end
end

function PlayerBaseData:ProcessTableData()
  local _PlayerHead = {}
  local tbPlayerHead = {}
  
  local function func_ForEach_Head(mapLineData)
    tbPlayerHead = {
      Id = mapLineData.Id,
      Icon = mapLineData.Icon
    }
    table.insert(_PlayerHead, tbPlayerHead)
  end
  
  ForEachTableLine(DataTable.PlayerHead, func_ForEach_Head)
  table.sort(_PlayerHead, function(a, b)
    return a.Id < b.Id
  end)
  CacheTable.Set("_PlayerHead", _PlayerHead)
  self._nMaxWorldClass = 0
  
  local function func_ForEach_WorldClass(mapLineData)
    self._nMaxWorldClass = self._nMaxWorldClass + 1
  end
  
  ForEachTableLine(DataTable.WorldClass, func_ForEach_WorldClass)
  self._nBuyEnergyLimit = 0
  
  local function func_ForEach_EnergyBuy(mapLineData)
    if self._nBuyEnergyLimit < mapLineData.Id then
      self._nBuyEnergyLimit = mapLineData.Id
    end
    CacheTable.SetField("_EnergyBuy", mapLineData.PriceGroup, mapLineData.Id, mapLineData)
  end
  
  ForEachTableLine(DataTable.EnergyBuy, func_ForEach_EnergyBuy)
  local _tbDemonAdvance = {}
  
  local function foreachTable(mapData)
    local levelMin = mapData.LevelRange[1]
    local levelMax = mapData.LevelRange[2]
    local nType = AllEnum.WorldClassType.LevelUp
    table.insert(_tbDemonAdvance, {
      nType = nType,
      nId = mapData.Id,
      nMinLevel = levelMin,
      nMaxLevel = levelMax
    })
    if mapData.AdvanceQuestGroup ~= 0 then
      local nType = AllEnum.WorldClassType.Advance
      table.insert(_tbDemonAdvance, {
        nType = nType,
        nId = mapData.Id,
        nMinLevel = levelMax,
        nMaxLevel = levelMax
      })
    end
  end
  
  ForEachTableLine(ConfigTable.Get("DemonAdvance"), foreachTable)
  CacheTable.Set("_DemonAdvance", _tbDemonAdvance)
  self.tbHonorLevelTitle = {}
  
  local function foreachHonorLevel(mapData)
    if self.tbHonorLevelTitle[mapData.GroupId] == nil then
      self.tbHonorLevelTitle[mapData.GroupId] = {}
    end
    table.insert(self.tbHonorLevelTitle[mapData.GroupId], mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("HonorLevel"), foreachHonorLevel)
end

function PlayerBaseData:CacheAccInfo(mapData)
  if mapData ~= nil then
    self._nPlayerId = mapData.Id
    self._sPlayerNickName = mapData.NickName
    self._nNewbie = mapData.Newbie
    self._nCreateTime = mapData.CreateTime
    self._nHeadIconId = mapData.HeadIcon
    self._nHashtag = mapData.Hashtag
    self._sSignature = mapData.Signature
    self._nShowSkinId = mapData.SkinId
    self._nTitlePrefix = mapData.TitlePrefix
    self._nTitleSuffix = mapData.TitleSuffix
    self._tbCoreTeam = {}
    for i, v in ipairs(mapData.Chars) do
      self._tbCoreTeam[i] = v.CharId
    end
    self._bMale = mapData.Gender == true
    self._nSendGiftCnt = mapData.SendGiftCnt or 0
    PlayerData.Roguelike:GetClientLocalRoguelikeData()
    PlayerData.Guide:SetGuideNewbie(mapData.Newbies)
    CS.AdventureModuleHelper.playerUid = mapData.Id
    CS.InputManager.Instance:LoadBindingOverrides(mapData.Id)
    EventManager.Hit("FinishCacheAccInfo")
  end
end

function PlayerBaseData:CacheEnergyInfo(mapData)
  if mapData ~= nil then
    self.bEnergyInfoCached = true
    self._nCurEnergy = mapData.Energy.Primary
    self._nCurEnergyBattery = mapData.Energy.Secondary
    local nServerTime = CS.ClientManager.Instance.serverTimeStamp
    self._nEnergyTime = mapData.Energy.IsPrimary == true and mapData.Energy.NextDuration + nServerTime or 0
    self._nEnergyBatteryTime = mapData.Energy.IsPrimary == true and 0 or mapData.Energy.NextDuration + nServerTime
    self._nBuyEnergyCount = mapData.Count
    NotificationManager.UnregisterNotification(10000000, 0)
    if self._mapEnergyTimer ~= nil then
      self._mapEnergyTimer:Cancel(nil)
    end
    if mapData.Energy.NextDuration == 0 then
      return
    end
    if mapData.Energy.IsPrimary == false then
      self._mapEnergyBatteryTimer = TimerManager.Add(1, mapData.Energy.NextDuration, self, self.HandleEnergyBatteryTimer, true, true, false)
    else
      self._mapEnergyTimer = TimerManager.Add(1, mapData.Energy.NextDuration, self, self.HandleEnergyTimer, true, true, false)
    end
    if LocalSettingData.GetLocalSettingData("Energy") and self._nCurEnergy < ConfigTable.GetConfigNumber("EnergyMaxLimit") then
      local nEmptyEnergy = ConfigTable.GetConfigNumber("EnergyMaxLimit") - self._nCurEnergy - 1
      local nTime = ConfigTable.GetConfigNumber("EnergyGain") * 60 * nEmptyEnergy + self._nEnergyTime
      NotificationManager.RegisterNotification(10000000, 0, nTime)
    end
  end
end

function PlayerBaseData:CacheTitleInfo(mapData)
  self._tbTitle = {}
  if not mapData then
    return
  end
  for _, v in pairs(mapData) do
    table.insert(self._tbTitle, v.TitleId)
  end
end

function PlayerBaseData:CacheHonorTitleInfo(mapData)
  if not mapData then
    return
  end
  self._tbHonorTitle = {}
  for _, v in pairs(mapData) do
    table.insert(self._tbHonorTitle, v)
  end
end

function PlayerBaseData:CacheHonorTitleList(mapData)
  self._tbHonorTitleList = {}
  if not mapData then
    return
  end
  for _, v in pairs(mapData) do
    local data = {Id = v}
    table.insert(self._tbHonorTitleList, data)
  end
  self:RefreshHonorTitleRedDot()
end

function PlayerBaseData:CacheHonorTitleListActivity(mapData)
  if not mapData then
    return
  end
  if not self._tbHonorTitleList then
    self._tbHonorTitleList = {}
  end
  for _, v in pairs(mapData) do
    table.insert(self._tbHonorTitleList, v)
  end
  self:RefreshHonorTitleRedDot()
end

function PlayerBaseData:CacheWorldClassInfo(mapData)
  if mapData ~= nil then
    self._nWorldClass = mapData.Cur
    self._nWorldExp = mapData.LastExp
    self._nWorldStage = mapData.Stage
    self:RefreshCurWorldStageIndex()
  end
end

function PlayerBaseData:CacheSendGiftCount(nCount)
  self._nSendGiftCnt = nCount
end

function PlayerBaseData:CacheRenameTime(nTime)
  self._nRenameTime = nTime
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  local nPastTime = nCurTime - self._nRenameTime
  local nRemain = ConfigTable.GetConfigNumber("NickNameResetTimeLimit") - nPastTime
  if nRemain <= 0 then
    self.bRenameCD = false
    return
  end
  self:SetRenameTimer(nRemain)
end

function PlayerBaseData:RefreshEnergyBuyCount(nCount)
  self._nBuyEnergyCount = nCount
end

function PlayerBaseData:RefreshSendGiftCount(nCount)
  self._nSendGiftCnt = nCount
end

function PlayerBaseData:GetPlayerId()
  return self._nPlayerId
end

function PlayerBaseData:GetPlayerNickName()
  return self._sPlayerNickName or "SaiLa"
end

function PlayerBaseData:SetPlayerNickName(sPlayerName)
  if AVG_EDITOR == true then
    if type(sPlayerName) == "string" and sPlayerName ~= "" then
      self._sPlayerNickName = sPlayerName
    else
      self._sPlayerNickName = nil
    end
  end
end

function PlayerBaseData:GetPlayerHashtag()
  return self._nHashtag
end

function PlayerBaseData:GetPlayerCoreTeam()
  local tbTeam = {}
  for i = 1, 3 do
    if not self._tbCoreTeam[i] then
      tbTeam[i] = 0
    else
      tbTeam[i] = self._tbCoreTeam[i]
    end
  end
  return tbTeam
end

function PlayerBaseData:GetPlayerAllTitle()
  local tbPrefix, tbSuffix = {}, {}
  for _, v in pairs(self._tbTitle) do
    local mapCfg = ConfigTable.GetData("Title", v)
    if mapCfg.TitleType == GameEnum.TitleType.Prefix then
      table.insert(tbPrefix, {
        nId = v,
        sDesc = mapCfg.Desc,
        nSort = mapCfg.Sort
      })
    else
      table.insert(tbSuffix, {
        nId = v,
        sDesc = mapCfg.Desc,
        nSort = mapCfg.Sort
      })
    end
  end
  table.sort(tbPrefix, function(a, b)
    return a.nSort < b.nSort
  end)
  table.sort(tbSuffix, function(a, b)
    return a.nSort < b.nSort
  end)
  return tbPrefix, tbSuffix
end

function PlayerBaseData:GetPlayerTitle()
  return self._nTitlePrefix, self._nTitleSuffix
end

function PlayerBaseData:GetPlayerHonorTitle()
  return self._tbHonorTitle
end

function PlayerBaseData:GetPlayerHonorTitleList()
  return self._tbHonorTitleList
end

function PlayerBaseData:GetPlayerShowSkin()
  return self._nShowSkinId
end

function PlayerBaseData:GetPlayerSignature()
  return self._sSignature == "" and ConfigTable.GetUIText("Friend_DefaultSign") or self._sSignature
end

function PlayerBaseData:GetPlayerSex()
  return self._bMale
end

function PlayerBaseData:SetPlayerSex(bIsMale)
  self._bMale = bIsMale == true
end

function PlayerBaseData:IsDefaultHead(nId)
  if nId == 100101 or nId == 101001 then
    return true
  else
    return false
  end
end

function PlayerBaseData:ChangePlayerHeadId(nId)
  self._nHeadIconId = nId
end

function PlayerBaseData:GetPlayerHeadId()
  return self._nHeadIconId
end

function PlayerBaseData:GetPlayerCreatTime()
  return os.date("%Y.%m.%d", self._nCreateTime)
end

function PlayerBaseData:GetPlayerAvgId()
  local sName = "avg0_1"
  return sName
end

function PlayerBaseData:HandleEnergyTimer()
  if self._mapEnergyTimer ~= nil then
    self._mapEnergyTimer:Cancel(nil)
  end
  if self._nCurEnergy < ConfigTable.GetConfigNumber("EnergyMaxLimit") then
    self._nCurEnergy = self._nCurEnergy + 1
    if self._mapEnergyBatteryTimer ~= nil then
      self._mapEnergyBatteryTimer:Cancel(nil)
    end
    if self._nCurEnergy < ConfigTable.GetConfigNumber("EnergyMaxLimit") then
      local nEnergyGain = ConfigTable.GetConfigNumber("EnergyGain") * 60
      self._nEnergyTime = nEnergyGain + CS.ClientManager.Instance.serverTimeStamp
      self._mapEnergyTimer = TimerManager.Add(1, nEnergyGain, self, self.HandleEnergyTimer, true, true, false)
    elseif self._nCurEnergyBattery < ConfigTable.GetConfigNumber("EnergyBatteryMax") then
      local nEnergyBatteryGain = ConfigTable.GetConfigNumber("EnergyBatteryGain") * 60
      self._nEnergyBatteryTime = nEnergyBatteryGain + CS.ClientManager.Instance.serverTimeStamp
      self._mapEnergyBatteryTimer = TimerManager.Add(1, nEnergyBatteryGain, self, self.HandleEnergyBatteryTimer, true, true, false)
    end
    EventManager.Hit(EventId.UpdateEnergy)
  else
    self._nEnergyTime = 0
  end
end

function PlayerBaseData:HandleEnergyBatteryTimer()
  if self._nCurEnergyBattery < ConfigTable.GetConfigNumber("EnergyBatteryMax") then
    self._nCurEnergyBattery = self._nCurEnergyBattery + 1
    local nEnergyBatteryGain = ConfigTable.GetConfigNumber("EnergyBatteryGain") * 60
    self._nEnergyBatteryTime = nEnergyBatteryGain + CS.ClientManager.Instance.serverTimeStamp
    if self._mapEnergyBatteryTimer ~= nil then
      self._mapEnergyBatteryTimer:Cancel(nil)
    end
    self._mapEnergyBatteryTimer = TimerManager.Add(1, nEnergyBatteryGain, self, self.HandleEnergyBatteryTimer, true, true, false)
    EventManager.Hit(EventId.UpdateEnergyBattery)
  else
    self._nEnergyBatteryTime = 0
    if self._mapEnergyBatteryTimer ~= nil then
      self._mapEnergyBatteryTimer:Cancel(nil)
    end
  end
end

function PlayerBaseData:ChangeEnergy(mapData)
  if mapData ~= nil then
    if self._mapEnergyTimer ~= nil then
      self._mapEnergyTimer:Cancel(nil)
    end
    if self._mapEnergyBatteryTimer ~= nil then
      self._mapEnergyBatteryTimer:Cancel(nil)
    end
    local nLength = #mapData
    self._nCurEnergy = mapData[nLength].Primary
    self._nCurEnergyBattery = mapData[nLength].Secondary
    local nServerTime = CS.ClientManager.Instance.serverTimeStamp
    if mapData[nLength].IsPrimary == true then
      self._nEnergyTime = mapData[nLength].NextDuration + nServerTime
      if mapData[nLength].NextDuration ~= 0 then
        self._mapEnergyTimer = TimerManager.Add(1, mapData[nLength].NextDuration, self, self.HandleEnergyTimer, true, true, false)
      end
    else
      self._nEnergyBatteryTime = mapData[nLength].NextDuration + nServerTime
      if mapData[nLength].NextDuration ~= 0 then
        self._mapEnergyBatteryTimer = TimerManager.Add(1, mapData[nLength].NextDuration, self, self.HandleEnergyBatteryTimer, true, true, false)
      end
    end
    EventManager.Hit(EventId.UpdateEnergyBattery)
    EventManager.Hit(EventId.UpdateEnergy)
    NotificationManager.UnregisterNotification(10000000, 0)
    if LocalSettingData.GetLocalSettingData("Energy") and self._nCurEnergy < ConfigTable.GetConfigNumber("EnergyMaxLimit") then
      local nEmptyEnergy = ConfigTable.GetConfigNumber("EnergyMaxLimit") - self._nCurEnergy - 1
      local nTime = ConfigTable.GetConfigNumber("EnergyGain") * 60 * nEmptyEnergy + self._nEnergyTime
      NotificationManager.RegisterNotification(10000000, 0, nTime)
    end
  end
end

function PlayerBaseData:ChangeTitle(mapData)
  if not mapData then
    return
  end
  if not self._tbTitle then
    self._tbTitle = {}
  end
  for _, v in pairs(mapData) do
    table.insert(self._tbTitle, v.TitleId)
    RedDotManager.SetValid(RedDotDefine.Friend_Title_Item, v.TitleId, true)
  end
end

function PlayerBaseData:ChangeHonorTitle(mapData)
  if not mapData then
    return
  end
  if not self._tbHonorTitleList then
    self._tbHonorTitleList = {}
  end
  local newData = {}
  local delData = {}
  for _, v in pairs(mapData) do
    local data = {
      Lv = v.Level,
      Id = v.NewId
    }
    table.insert(self._tbHonorTitleList, data)
    local honorData = ConfigTable.GetData("Honor", v.NewId)
    if honorData.TabType == GameEnum.honorTabType.Achieve then
      local function foreachHonor(mapData)
        if mapData.TabType == GameEnum.honorTabType.Achieve and mapData.Params[1] == honorData.Params[1] and mapData.Priotity < honorData.Priotity then
          table.insert(delData, mapData.Id)
          
          RedDotManager.SetValid(RedDotDefine.Friend_Honor_Title_Item, mapData.Id, true)
        end
      end
      
      ForEachTableLine(ConfigTable.Get("Honor"), foreachHonor)
    end
    RedDotManager.SetValid(RedDotDefine.Friend_Honor_Title_Item, v.NewId, true)
    table.insert(newData, v.NewId)
  end
  if 0 < #newData or 0 < delData then
    local sJson = localdata.GetPlayerLocalData("HonorTitle")
    local localHonorTilte = decodeJson(sJson)
    if type(localHonorTilte) == "table" then
      if 0 < #newData then
        for k, v in ipairs(newData) do
          table.insert(localHonorTilte, v)
        end
      end
      if 0 < #delData then
        for k, v in ipairs(delData) do
          if table.indexof(localHonorTilte, delData) then
            table.removebyvalue(localHonorTilte, v)
          end
        end
      end
    end
    localdata.SetPlayerLocalData("HonorTitle", RapidJson.encode(localHonorTilte))
  end
end

function PlayerBaseData:ChangeWorldClass(mapData)
  if mapData ~= nil then
    self._nOldWorldClass = self._nWorldClass
    self._nOldWorldExp = self._nWorldExp
    for _, v in ipairs(mapData) do
      self._nWorldClass = self._nWorldClass + v.AddClass
      self._nWorldExp = self._nWorldExp + v.ExpChange
    end
    self:SetWorldClassChange(self._nOldWorldClass ~= self._nWorldClass)
    self:CheckNewFuncUnlockWorldClass(self._nOldWorldClass, self._nWorldClass)
    EventManager.Hit(EventId.UpdateWorldClass)
    if self._nOldWorldClass ~= self._nWorldClass then
      self:RefreshCurWorldStageIndex()
      self:RefreshWorldClassRedDot()
      for i = self._nOldWorldClass + 1, self._nWorldClass do
        if i == 5 then
          local tab = {}
          table.insert(tab, {
            "role_id",
            tostring(PlayerData.Base._nPlayerId)
          })
          NovaAPI.UserEventUpload("authorizationlevel_5", tab)
        elseif i == 10 then
          local tab = {}
          table.insert(tab, {
            "role_id",
            tostring(PlayerData.Base._nPlayerId)
          })
          NovaAPI.UserEventUpload("authorizationlevel_10", tab)
        elseif i == 20 then
          local tab = {}
          table.insert(tab, {
            "role_id",
            tostring(PlayerData.Base._nPlayerId)
          })
          NovaAPI.UserEventUpload("authorizationlevel_20", tab)
        end
        if PcEventUpWorldLv[i] then
          self:UserEventUpload_PC(PcEventUpWorldLv[i])
        end
      end
    end
  end
end

function PlayerBaseData:ChangeWorldClassInBoard(mapData)
  if mapData ~= nil then
    self._nOldWorldClass = self._nWorldClass
    self._nOldWorldExp = self._nWorldExp
    self._nWorldClass = mapData.FinalClass
    self._nWorldExp = mapData.LastExp
    EventManager.Hit(EventId.UpdateWorldClass)
    self:CheckNewFuncUnlockWorldClass(self._nOldWorldClass, self._nWorldClass)
    if self._nOldWorldClass ~= self._nWorldClass then
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        
        self:SetWorldClassChange(true)
        self:TryOpenWorldClassUpgrade()
      end
      
      cs_coroutine.start(wait)
      self:RefreshCurWorldStageIndex()
      self:RefreshWorldClassRedDot()
      for i = self._nOldWorldClass + 1, self._nWorldClass do
        if i == 5 then
          local tab = {}
          table.insert(tab, {
            "role_id",
            tostring(PlayerData.Base._nPlayerId)
          })
          NovaAPI.UserEventUpload("authorizationlevel_5", tab)
        elseif i == 10 then
          local tab = {}
          table.insert(tab, {
            "role_id",
            tostring(PlayerData.Base._nPlayerId)
          })
          NovaAPI.UserEventUpload("authorizationlevel_10", tab)
        elseif i == 20 then
          local tab = {}
          table.insert(tab, {
            "role_id",
            tostring(PlayerData.Base._nPlayerId)
          })
          NovaAPI.UserEventUpload("authorizationlevel_20", tab)
        end
        if PcEventUpWorldLv[i] then
          self:UserEventUpload_PC(PcEventUpWorldLv[i])
        end
      end
    end
  end
end

function PlayerBaseData:RefreshCurWorldStageIndex()
  self._nCurWorldStageIndex = 0
  local tbDemonAdvanceCfg = CacheTable.Get("_DemonAdvance")
  local bMax = self._nWorldClass >= tbDemonAdvanceCfg[#tbDemonAdvanceCfg].nMaxLevel
  if bMax then
    self._nCurWorldStageIndex = #tbDemonAdvanceCfg
  else
    for k, v in ipairs(tbDemonAdvanceCfg) do
      if v.nType == AllEnum.WorldClassType.LevelUp then
        if v.nMinLevel <= self._nWorldClass and v.nMaxLevel > self._nWorldClass then
          self._nCurWorldStageIndex = k
          break
        end
      elseif v.nType == AllEnum.WorldClassType.Advance and v.nMinLevel <= self._nWorldClass and v.nMaxLevel >= self._nWorldClass then
        self._nCurWorldStageIndex = v.nId == self._nWorldStage and k + 1 or k
        break
      end
    end
  end
end

function PlayerBaseData:ChangeWorldStage(nStageId)
  self._nWorldStage = nStageId
  self:RefreshCurWorldStageIndex()
end

function PlayerBaseData:TryOpenWorldClassUpgrade(callback)
  if self._bWorldClassChange then
    local function popUpCallback()
      EventManager.Hit("Guide_CloseWorldClassPopUp")
      
      if nil ~= callback then
        callback()
      end
    end
    
    PopUpManager.OpenPopUpPanel({
      GameEnum.PopUpSeqType.WorldClass,
      GameEnum.PopUpSeqType.FuncUnlock
    }, popUpCallback)
  end
  return self._bWorldClassChange
end

function PlayerBaseData:OnNextDayRefresh()
  if self.NextRefreshTimer ~= nil then
    self.NextRefreshTimer:Cancel()
    self.NextRefreshTimer = nil
  end
  
  local function callback(_, msgData)
    local curNextRefreshTime = self.NextRefreshTime
    self:SetNextRefreshTime(msgData.ServerTs)
    if curNextRefreshTime > msgData.ServerTs then
      return
    end
    self:OnNewDay()
    EventManager.Hit(EventId.IsNewDay)
    local bInMainView = PanelManager.GetCurPanelId() == PanelId.MainView
    if not bInMainView then
      PopUpManager.ResetInterruptPopUp()
    end
    local bInAdventure = ModuleManager.GetIsAdventure()
    local bInStarTowerSweep = not bInAdventure and (PlayerData.State:GetStarTowerSweepState() or PanelManager.GetCurPanelId() == PanelId.StarTowerResult or PanelManager.GetCurPanelId() == PanelId.StarTowerBuildSave)
    local bInAvg = AvgManager.CheckInAvg()
    if bInAdventure or bInStarTowerSweep or bInAvg or self.bSkipNewDayWind then
      print("Inlevel")
      self.bNewDay = true
      if bInAvg then
        self.bShowNewDayWindDelay = true
      end
      return
    end
    self:BackToHome()
  end
  
  HttpNetHandler.SendPingPong(HttpNetHandler, true, callback)
end

function PlayerBaseData:NeedHotfix()
  self.bNeedHotfix = true
  if NovaAPI.GetCurrentModuleName() == "MainMenuModuleScene" then
    PlayerData.Base:OnBackToMainMenuModule()
  end
end

function PlayerBaseData:SetNextRefreshTime(curTimeStamp)
  local serverTimeStamp = CS.ClientManager.Instance.serverTimeStamp
  self.NextRefreshTime = CS.ClientManager.Instance:GetNextRefreshTime(curTimeStamp) + 1
  if self.NextRefreshTimer == nil then
    self.NextRefreshTimer = TimerManager.Add(-1, 2, self, self.CheckNewDay, true, true, true, nil)
  end
  print("下次刷新时间:" .. self.NextRefreshTime)
  print("距下次刷新时间:" .. self.NextRefreshTime - serverTimeStamp)
end

function PlayerBaseData:CheckNewDay()
  local serverTimeStamp = CS.ClientManager.Instance.serverTimeStamp
  if serverTimeStamp > self.NextRefreshTime then
    self:OnNextDayRefresh()
  end
end

function PlayerBaseData:SetWorldClassChange(bChange, nDemonId, callback)
  self._bWorldClassChange = bChange
  if bChange then
    nDemonId = nDemonId or 0
    local mapParam = {nDemonId = nDemonId, callback = callback}
    PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.WorldClass, mapParam)
  end
end

function PlayerBaseData:OnBackToMainMenuModule()
  print("New Day Check")
  if self.bNewDay == true then
    self:OnNextDayRefresh()
    self.bNewDay = false
    if self.bInLoading then
      self.bShowNewDayWindDelay = true
    else
      self:BackToHome()
    end
  end
  if self.bNeedHotfix then
    self.bNeedHotfix = false
    local msg = {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Hotfix_Tip"),
      callbackConfirm = function()
        NovaAPI.ExitGame()
      end
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
  end
end

function PlayerBaseData:CheckNextDayForSweep()
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.1))
    
    self:OnBackToMainMenuModule()
  end
  
  cs_coroutine.start(wait)
end

function PlayerBaseData:BackToHome()
  if PanelManager.GetCurPanelId() ~= PanelId.MainView then
    EventManager.Hit("NewDay_Clear_Guide")
    if not self.bShowNewDayWind then
      local msg = {
        nType = AllEnum.MessageBox.Alert,
        sContent = ConfigTable.GetUIText("Alert_NextDay"),
        callbackConfirm = function()
          self.bShowNewDayWind = false
          if PanelManager.GetCurPanelId() == PanelId.MainView then
            return
          end
          self:GoHomeFromCurModule()
        end
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
      self.bShowNewDayWind = true
      self.bSkipNewDayWind = false
    end
  end
end

function PlayerBaseData:GoHomeFromCurModule()
  if ModuleManager.GetCurModuleName() == "DormModuleScene" then
    local function transitionOpenCallback()
      local function OnEventAfterEnterMain()
        EventManager.Remove(EventId.AfterEnterMain, self, OnEventAfterEnterMain)
        
        PanelManager.IGNORE_CS_TRANS_EVENT = false
        
        local function wait()
          PanelManager.Home()
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          EventManager.Hit(EventId.SetTransition)
        end
        
        cs_coroutine.start(wait)
      end
      
      local function OnEventDormLevelFinish()
        EventManager.Remove("DORM_LEVEL_FINISH", self, OnEventDormLevelFinish)
        PanelManager.IGNORE_CS_TRANS_EVENT = true
        NovaAPI.EnterModule("MainMenuModuleScene", true)
      end
      
      EventManager.Add("DORM_LEVEL_FINISH", self, OnEventDormLevelFinish)
      EventManager.Add(EventId.AfterEnterMain, self, OnEventAfterEnterMain)
      NovaAPI.DispatchEventWithData("DORM_LEVEL_STATE_CHANGED", nil, {true, 0})
    end
    
    EventManager.Hit(EventId.SetTransition, 6, transitionOpenCallback, AllEnum.MainViewCorner.Dorm)
    return
  elseif ModuleManager.GetCurModuleName() == "MathParkourModuleScene" then
    local function OnEventEnterModule(_, _, sEnterModuleName)
      EventManager.Remove("EnterModule", self, OnEventEnterModule)
      
      if sEnterModuleName ~= "MainMenuModuleScene" then
        return
      end
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        PanelManager.Home()
      end
      
      cs_coroutine.start(wait)
    end
    
    EventManager.Add("EnterModule", self, OnEventEnterModule)
    NovaAPI.EnterModule("MainMenuModuleScene", true)
    return
  end
  PanelManager.Home()
end

function PlayerBaseData:SetSkipNewDayWindow(bSkip)
  self.bSkipNewDayWind = bSkip
end

function PlayerBaseData:GetCurEnergy()
  local mapRet = {}
  mapRet.nEnergy = self._nCurEnergy
  mapRet.nEnergyTime = self._nEnergyTime
  return mapRet
end

function PlayerBaseData:GetCurEnergyBattery()
  local mapRet = {}
  mapRet.nEnergyBattery = self._nCurEnergyBattery
  mapRet.nEnergyBatteryTime = self._nEnergyBatteryTime
  return mapRet
end

function PlayerBaseData:GetMaxEnergyTime()
  local nMaxEnergy = ConfigTable.GetConfigNumber("EnergyMaxLimit") or 0
  local nEmptyEnergy = nMaxEnergy - self._nCurEnergy
  if nEmptyEnergy <= 0 then
    return 0
  end
  return ConfigTable.GetConfigNumber("EnergyGain") * 60 * nEmptyEnergy
end

function PlayerBaseData:GetWorldClass()
  return self._nWorldClass
end

function PlayerBaseData:GetMaxWorldClass()
  return self._nMaxWorldClass
end

function PlayerBaseData:GetWorldClassState(nLv)
  local tbState = PlayerData.State:GetWorldClassRewardState()
  local nIndex = math.ceil(nLv / 8)
  if tbState[nIndex] then
    return 1 << nLv - (nIndex - 1) * 8 - 1 & tbState[nIndex] > 0
  else
    return false
  end
end

function PlayerBaseData:GetEnabledWorldClassLv()
  local bEnabled = false
  for i = 2, self._nMaxWorldClass do
    bEnabled = self:GetWorldClassState(i)
    if bEnabled then
      return i, bEnabled
    end
  end
  return self._nWorldClass + 1, false
end

function PlayerBaseData:GetWorldExp()
  return self._nWorldExp
end

function PlayerBaseData:GetCurWorldClassStageIndex()
  return self._nCurWorldStageIndex
end

function PlayerBaseData:GetCurWorldClassStageId()
  local mapCfg = CacheTable.Get("_DemonAdvance")[self._nCurWorldStageIndex]
  if mapCfg ~= nil then
    return mapCfg.nId
  end
  return 0
end

function PlayerBaseData:GetOldWorldClass()
  return self._nOldWorldClass
end

function PlayerBaseData:GetOldWorldExp()
  return self._nOldWorldExp
end

function PlayerBaseData:CheckEnergyEnough(nId)
  local mapData = ConfigTable.GetData_Mainline(nId)
  if mapData ~= nil then
    return mapData.EnergyConsume <= self._nCurEnergy
  else
    return false
  end
end

function PlayerBaseData:GetEnergyBuyCount()
  return self._nBuyEnergyCount
end

function PlayerBaseData:GetEnergyBuyLimit()
  return self._nBuyEnergyLimit
end

function PlayerBaseData:GetCurEnergyBuyGroup(nBuyCount)
  local energyBuy = CacheTable.Get("_EnergyBuy") or {}
  local tbGroupData = {}
  for nGroup, data in pairs(energyBuy) do
    for nId, v in pairs(data) do
      if nId == nBuyCount then
        tbGroupData = data
        break
      end
    end
  end
  return tbGroupData
end

function PlayerBaseData:GetSendGiftCount()
  return self._nSendGiftCnt
end

function PlayerBaseData:CheckRenameCD()
  if self.bRenameCD then
    local nPastTime = ConfigTable.GetConfigNumber("NickNameResetTimeLimit") - (CS.ClientManager.Instance.serverTimeStamp - self._nRenameTime)
    local day = math.ceil(nPastTime / 86400)
    if 1 < day then
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        sContent = orderedFormat(ConfigTable.GetUIText("Friend_Rename_TimeCDWarning1"), day)
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        sContent = ConfigTable.GetUIText("Friend_Rename_TimeCDWarning2")
      })
    end
  end
  return self.bRenameCD
end

function PlayerBaseData:SetRenameTimer(nTime)
  if self.timerRename ~= nil then
    self.timerRename:Cancel(false)
    self.timerRename = nil
  end
  self.bRenameCD = true
  self.timerRename = TimerManager.Add(1, nTime, self, function()
    self.bRenameCD = false
  end, true, true, false)
end

function PlayerBaseData:SendPlayerNameEditReq(sName, callback)
  local msgData = {Name = sName}
  
  local function successCallback(_, mapMainData)
    self._sPlayerNickName = sName
    self._nHashtag = mapMainData.Hashtag
    self._nRenameTime = mapMainData.ResetTime
    self:SetRenameTimer(ConfigTable.GetConfigNumber("NickNameResetTimeLimit"))
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_name_edit_req, msgData, nil, successCallback)
end

function PlayerBaseData:SendPlayerWorldClassRewardReceiveReq(nLv, nStage, callback, nMinLevel)
  local msgData = {}
  if nLv ~= nil then
    msgData.Class = nLv
  end
  local tbReward = {}
  if nLv ~= nil then
    local mapCfg = ConfigTable.GetData("WorldClass", nLv)
    if mapCfg ~= nil then
      local tbRewardCfg = decodeJson(mapCfg.Reward)
      for sItem, nCount in pairs(tbRewardCfg) do
        local nItemId = tonumber(sItem)
        table.insert(tbReward, {Tid = nItemId, Qty = nCount})
      end
    end
  else
    local mapReward = {}
    nMinLevel = nMinLevel or 1
    for i = nMinLevel, self._nWorldClass do
      local bCanReceive = self:GetWorldClassState(i)
      if bCanReceive then
        local mapCfg = ConfigTable.GetData("WorldClass", i)
        if mapCfg ~= nil then
          local tbRewardCfg = decodeJson(mapCfg.Reward)
          for sItem, nCount in pairs(tbRewardCfg) do
            local nItemId = tonumber(sItem)
            if mapReward[nItemId] == nil then
              mapReward[nItemId] = nCount
            else
              mapReward[nItemId] = mapReward[nItemId] + nCount
            end
          end
        end
      end
    end
    for nId, nCount in pairs(mapReward) do
      table.insert(tbReward, {Tid = nId, Qty = nCount})
    end
  end
  
  local function successCallback(_, mapMainData)
    UTILS.OpenReceiveByDisplayItem(tbReward, mapMainData, function()
      if PlayerData.Guide:GetGuideState() then
        EventManager.Hit("Guide_ReceiveWorldClassReward")
      end
    end)
    self:RefreshCurWorldStageIndex()
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_world_class_reward_receive_req, msgData, nil, successCallback)
end

function PlayerBaseData:SendPlayerWorldClassAdvanceReq(nStageId, callback)
  local function successCallback(_, msgData)
    local function callback()
      self:ChangeWorldStage(nStageId)
      
      EventManager.Hit("DemonAdvanceSuccess")
    end
    
    self:SetWorldClassChange(true, nStageId, callback)
    self:TryOpenWorldClassUpgrade()
    if nil ~= callback then
      callback(msgData)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_world_class_advance_req, {}, nil, successCallback)
end

function PlayerBaseData:SendPlayerCharsShowReq(tbChar, callback)
  local msgData = {CharIds = tbChar}
  
  local function successCallback(_, mapMainData)
    self._tbCoreTeam = tbChar
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_chars_show_req, msgData, nil, successCallback)
end

function PlayerBaseData:SendPlayerSignatureEditReq(sSignature, callback)
  local msgData = {Signature = sSignature}
  
  local function successCallback(_, mapMainData)
    self._sSignature = sSignature
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_signature_edit_req, msgData, nil, successCallback)
end

function PlayerBaseData:SendPlayerSkinShowReq(nSkinId, callback)
  local msgData = {SkinId = nSkinId}
  
  local function successCallback(_, mapMainData)
    self._nShowSkinId = nSkinId
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_skin_show_req, msgData, nil, successCallback)
end

function PlayerBaseData:SendPlayerTitleEditReq(nTitlePrefix, nTitleSuffix, callback)
  local msgData = {TitlePrefix = nTitlePrefix, TitleSuffix = nTitleSuffix}
  
  local function successCallback(_, mapMainData)
    self._nTitlePrefix = nTitlePrefix
    self._nTitleSuffix = nTitleSuffix
    callback(mapMainData)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_title_edit_req, msgData, nil, successCallback)
end

function PlayerBaseData:SendEnergyBuy(nCount, callback)
  HttpNetHandler.SendMsg(NetMsgId.Id.energy_buy_req, {Value = nCount}, nil, callback)
end

function PlayerBaseData:SendEnergyBatteryExtract(nAmount, callback)
  HttpNetHandler.SendMsg(NetMsgId.Id.energy_extract_req, {Value = nAmount}, nil, callback)
end

function PlayerBaseData:PlayerWorldClassRewardReceiveSuc(mapMainData)
end

function PlayerBaseData:PlayerWorldClassAdvanceSuc(mapMainData)
  UTILS.OpenReceiveByChangeInfo(mapMainData.Change)
  local nCurId = self:GetCurWorldClassStageId()
  local mapCfg = ConfigTable.GetData("DemonAdvance", nCurId)
  if mapCfg ~= nil then
    local nGroupId = mapCfg.AdvanceQuestGroup
    PlayerData.Quest:ReceiveDemonQuest(nGroupId)
  end
  self:RefreshWorldClassRedDot()
end

function PlayerBaseData:SendPlayerHonorTitleEditReq(tbhonorTitle, callback)
  local msgData = {List = tbhonorTitle}
  
  local function successCallback()
    if callback ~= nil then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_honor_edit_req, msgData, nil, successCallback)
end

function PlayerBaseData:GetDestoryUrl()
  return self._sDestoryUrl
end

function PlayerBaseData:SetDestoryUrl(sUrl)
  self._sDestoryUrl = sUrl
end

function PlayerBaseData:RequestDestoryUrl(cb)
  local function callback(_, msgData)
    if cb ~= nil then
      cb(self._sDestoryUrl)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.player_destroy_req, {}, nil, callback)
end

function PlayerBaseData:OnNewDay()
  self._nBuyEnergyCount = 0
  self._nSendGiftCnt = 0
end

function PlayerBaseData:RefreshWorldClassRedDot()
  local nWorldClass = self:GetWorldClass()
  local nCurStageId = PlayerData.Base:GetCurWorldClassStageId()
  local tbDemonAdvanceCfg = CacheTable.Get("_DemonAdvance")
  for _, v in ipairs(tbDemonAdvanceCfg) do
    local bRedDot = false
    if v.nType == AllEnum.WorldClassType.LevelUp then
      for lv = v.nMinLevel, v.nMaxLevel do
        local bAble = self:GetWorldClassState(lv)
        if lv <= nWorldClass and bAble then
          bRedDot = true
          break
        end
      end
      RedDotManager.SetValid(RedDotDefine.WorldClass_LevelUp, v.nId, bRedDot)
    elseif v.nType == AllEnum.WorldClassType.Advance then
      if nCurStageId == v.nId and nWorldClass == v.nMinLevel then
        local mapCfg = ConfigTable.GetData("DemonAdvance", v.nId)
        if mapCfg ~= nil then
          local tbQuestList = PlayerData.Quest:GetDemonQuestData(mapCfg.AdvanceQuestGroup, v.nId)
          local nAllProgress = #tbQuestList
          local nCurProgress = 0
          for _, v in ipairs(tbQuestList) do
            if v.nStatus == 1 then
              nCurProgress = nCurProgress + 1
            end
          end
          bRedDot = nAllProgress <= nCurProgress
        end
      end
      RedDotManager.SetValid(RedDotDefine.WorldClass_Advance, v.nId, bRedDot)
    end
  end
end

function PlayerBaseData:RefreshHonorTitleRedDot()
  local sJson = localdata.GetPlayerLocalData("HonorTitle")
  local localHonorTilte = decodeJson(sJson)
  if type(localHonorTilte) ~= "table" then
    return
  end
  for k, v in pairs(localHonorTilte) do
    RedDotManager.SetValid(RedDotDefine.Friend_Honor_Title_Item, tonumber(v), true)
  end
end

function PlayerBaseData:SendPlayerRedeemCodeReq(sCode, callback)
  local msgData = {Value = sCode}
  
  local function successCallback(_, msgData)
    if callback ~= nil then
      callback(msgData.Change)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.redeem_code_req, msgData, nil, successCallback)
end

function PlayerBaseData:SendEnergyInfoReq()
  local function callback(_, msgData)
    if msgData ~= nil then
      self._nCurEnergy = msgData.Primary
      
      self._nCurEnergyBattery = msgData.Secondary
      local nServerTime = CS.ClientManager.Instance.serverTimeStamp
      self._nEnergyTime = msgData.IsPrimary == true and msgData.NextDuration + nServerTime or 0
      self._nEnergyBatteryTime = msgData.IsPrimary == true and 0 or msgData.NextDuration + nServerTime
      if self._mapEnergyTimer ~= nil then
        self._mapEnergyTimer:Cancel()
        self._mapEnergyTimer = nil
      end
      if self._mapEnergyBatteryTimer ~= nil then
        self._mapEnergyBatteryTimer:Cancel()
        self._mapEnergyBatteryTimer = nil
      end
      if msgData.IsPrimary == false and msgData.NextDuration > 0 then
        self._mapEnergyBatteryTimer = TimerManager.Add(1, msgData.NextDuration, self, self.HandleEnergyBatteryTimer, true, true, false)
      elseif msgData.NextDuration > 0 then
        self._mapEnergyTimer = TimerManager.Add(1, msgData.NextDuration, self, self.HandleEnergyTimer, true, true, false)
      end
      EventManager.Hit(EventId.UpdateEnergyBattery)
      EventManager.Hit(EventId.UpdateEnergy)
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.energy_info_req, {}, nil, callback)
end

function PlayerBaseData:CheckFunctionBtn(nFuncId, PassCallback, sSound)
  if sSound == nil then
    sSound = "ui_common_feedback_error"
  end
  local mapFuncCfgData = ConfigTable.GetData("OpenFunc", nFuncId)
  if mapFuncCfgData == nil then
    printError("OpenFunc Data Missing:" .. nFuncId)
    return true
  end
  if mapFuncCfgData.NeedWorldClass > 0 and self._nWorldClass < mapFuncCfgData.NeedWorldClass then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = sSound,
      sContent = UTILS.ParseParamDesc(mapFuncCfgData.Tips, mapFuncCfgData)
    })
    return false
  end
  if 0 < mapFuncCfgData.NeedConditions then
    local nLevelStar = PlayerData.Mainline:GetMianlineLevelStar(mapFuncCfgData.NeedConditions)
    if nLevelStar < 1 then
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Tips,
        sSound = sSound,
        sContent = UTILS.ParseParamDesc(mapFuncCfgData.Tips, mapFuncCfgData)
      })
      return false
    end
  end
  if type(PassCallback) == "function" then
    PassCallback()
  end
end

function PlayerBaseData:CheckFunctionUnlock(nFuncId, bShowTips)
  local mapFuncCfgData = ConfigTable.GetData("OpenFunc", nFuncId)
  if mapFuncCfgData == nil then
    printError("OpenFunc Data Missing:" .. nFuncId)
    return true
  end
  if mapFuncCfgData.NeedWorldClass > 0 and self._nWorldClass < mapFuncCfgData.NeedWorldClass then
    if bShowTips then
      EventManager.Hit(EventId.OpenMessageBox, UTILS.ParseParamDesc(mapFuncCfgData.Tips, mapFuncCfgData))
    end
    return false
  end
  if 0 < mapFuncCfgData.NeedConditions then
    local nLevelStar = PlayerData.Mainline:GetMianlineLevelStar(mapFuncCfgData.NeedConditions)
    if nLevelStar < 1 then
      if bShowTips then
        EventManager.Hit(EventId.OpenMessageBox, UTILS.ParseParamDesc(mapFuncCfgData.Tips, mapFuncCfgData))
      end
      return false
    end
  end
  return true
end

function PlayerBaseData:CheckNewFuncUnlockWorldClass(nBefore, nNew)
  local function ForEachOpenFucn(mapData)
    if mapData.NeedWorldClass > nBefore and mapData.NeedWorldClass <= nNew then
      if mapData.NeedConditions > 0 then
        local nLevelStar = PlayerData.Mainline:GetMianlineLevelStar(mapData.NeedConditions)
        
        if nLevelStar < 1 then
          return
        end
      end
      if mapData.PopWindows then
        if self.tbFuncNeedShow == nil then
          self.tbFuncNeedShow = {}
        end
        table.insert(self.tbFuncNeedShow, mapData.Id)
        PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.FuncUnlock, self.tbFuncNeedShow)
      end
      EventManager.Hit(EventId.NewFuncUnlockWorldClass, mapData.Id)
    end
  end
  
  ForEachTableLine(DataTable.OpenFunc, ForEachOpenFucn)
end

function PlayerBaseData:CheckNewFuncUnlockMainlinePass(nMainlineId)
  local function ForEachOpenFucn(mapData)
    if mapData.NeedConditions == nMainlineId then
      if mapData.NeedWorldClass > 0 and self._nWorldClass < mapData.NeedWorldClass then
        return
      end
      if mapData.PopWindows then
        if self.tbFuncNeedShow == nil then
          self.tbFuncNeedShow = {}
        end
        table.insert(self.tbFuncNeedShow, mapData.Id)
        PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.FuncUnlock, self.tbFuncNeedShow)
      end
    end
  end
  
  ForEachTableLine(DataTable.OpenFunc, ForEachOpenFucn)
end

function PlayerBaseData:CheckNewFuncUnlockFixedRoguelike(nFRId)
  local function ForEachOpenFunc(mapData)
    if mapData.NeedRoguelike == nFRId then
      if mapData.NeedWorldClass > 0 and self._nWorldClass < mapData.NeedWorldClass then
        return
      end
      if 0 < mapData.NeedConditions then
        local nLevelStar = PlayerData.Mainline:GetMianlineLevelStar(mapData.NeedConditions)
        if nLevelStar < 1 then
          return
        end
      end
      if mapData.PopWindows then
        if self.tbFuncNeedShow == nil then
          self.tbFuncNeedShow = {}
        end
        print("tbFuncNeedShow:" .. mapData.Id)
        table.insert(self.tbFuncNeedShow, mapData.Id)
        PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.FuncUnlock, self.tbFuncNeedShow)
      end
    end
  end
  
  ForEachTableLine(DataTable.OpenFunc, ForEachOpenFunc)
end

function PlayerBaseData:GetLevelHonorTitleData(nGroupId)
  local tbHonorTitle = {}
  local maxLevel = 0
  if self.tbHonorLevelTitle[nGroupId] == nil then
    return nil, maxLevel
  end
  for _, v in pairs(self.tbHonorLevelTitle[nGroupId]) do
    tbHonorTitle[v.Level] = v
    maxLevel = math.max(maxLevel, v.Level)
  end
  return tbHonorTitle, maxLevel
end

function PlayerBaseData:OnEvent_TransAnimInClear()
  self.bInLoading = true
end

function PlayerBaseData:OnEvent_TransAnimOutClear()
  if self.bShowNewDayWindDelay and self.bInLoading then
    self.bShowNewDayWindDelay = false
    self:BackToHome()
  end
  self.bInLoading = false
end

function PlayerBaseData:Event_CreateRole()
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(self._nPlayerId)
  })
  NovaAPI.UserEventUpload("role_create", tab)
  CS.SDKManager.Instance:CreateRole(tostring(self._nPlayerId), self._sPlayerNickName, self._nCreateTime)
  local tab_1 = {}
  table.insert(tab_1, {
    "role_id",
    tostring(self._nPlayerId)
  })
  table.insert(tab_1, {
    "personality_id",
    PlayerData.Avg:GetPersonalityId()
  })
  NovaAPI.UserEventUpload("role_login", tab_1)
end

function PlayerBaseData:PrologueEventUpload(index)
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(self._nPlayerId)
  })
  table.insert(tab, {
    "newbie_tutorial_id",
    index
  })
  NovaAPI.UserEventUpload("newbie_tutorial", tab)
  if index == "1" then
    EventManager.Hit("FirstInputEnable")
  end
end

function PlayerBaseData:UserEventUpload_PC(eventName)
  local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
  local curPlatform = CS.ClientManager.Instance.Platform
  if clientPublishRegion == CS.ClientPublishRegion.JP then
    if curPlatform == "windows" then
      local tab = {}
      table.insert(tab, {
        "role_id",
        tostring(self._nPlayerId)
      })
      NovaAPI.UserEventUpload(eventName, tab)
    else
      local tmpEventName = string.gsub(eventName, "pc_", "move_")
      local tab = {}
      table.insert(tab, {
        "role_id",
        tostring(self._nPlayerId)
      })
      NovaAPI.UserEventUpload(tmpEventName, tab)
    end
  end
end

function PlayerBaseData:OnCS2LuaEvent_AppFocus(bFocus)
  if self._nPlayerId == nil then
    return
  end
  if bFocus == true then
    if self.nCachedTime == nil then
      return
    end
    local nPassedTime = CS.ClientManager.Instance.serverTimeStamp - self.nCachedTime
    self.nCachedTime = nil
    if nPassedTime >= self.nRequestEnergyLimitTime then
      self:SendEnergyInfoReq()
    end
  else
    self.nCachedTime = CS.ClientManager.Instance.serverTimeStamp
    local nNextTime = self._nEnergyBatteryTime > 0 and self._nEnergyBatteryTime or self._nEnergyTime
    nNextTime = nNextTime - self.nCachedTime
    if nNextTime <= 10 then
      nNextTime = 10
    end
    self.nRequestEnergyLimitTime = nNextTime
    self.nLastEnergy = self._nCurEnergy
    self.nLastEnergyBattery = self._nCurEnergyBattery
  end
end

function PlayerBaseData:OnEvent_SettingsNotificationClose()
  NotificationManager.UnregisterNotification(10000000, 0)
  if LocalSettingData.GetLocalSettingData("Energy") and self._nCurEnergy < ConfigTable.GetConfigNumber("EnergyMaxLimit") then
    local nEmptyEnergy = ConfigTable.GetConfigNumber("EnergyMaxLimit") - self._nCurEnergy - 1
    local nTime = ConfigTable.GetConfigNumber("EnergyGain") * 60 * nEmptyEnergy + self._nEnergyTime
    NotificationManager.RegisterNotification(10000000, 0, nTime)
  end
end

return PlayerBaseData
