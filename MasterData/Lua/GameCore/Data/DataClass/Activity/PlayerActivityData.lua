local PlayerActivityData = class("PlayerActivityData")
local PeriodicQuestActData = require("GameCore.Data.DataClass.Activity.PeriodicQuestActData")
local LoginRewardActData = require("GameCore.Data.DataClass.Activity.LoginRewardActData")
local MiningGameData = require("GameCore.Data.DataClass.Activity.MiningGameData")
local TrialActData = require("GameCore.Data.DataClass.Activity.TrialActData")
local CookieActData = require("GameCore.Data.DataClass.Activity.CookieActData")
local TowerDefenseData = require("GameCore.Data.DataClass.Activity.TowerDefenseData")
local JointDrillActData = require("GameCore.Data.DataClass.Activity.JointDrillActData")
local ActivityLevelTypeData = require("GameCore.Data.DataClass.Activity.ActivityLevelTypeData")
local ActivityTaskData = require("GameCore.Data.DataClass.Activity.ActivityTaskData")
local ActivityShopData = require("GameCore.Data.DataClass.Activity.ActivityShopData")
local AdvertiseActData = require("GameCore.Data.DataClass.Activity.AdvertiseActData")
local LocalData = require("GameCore.Data.LocalData")
local SwimThemeData = require("GameCore.Data.DataClass.Activity.SwimThemeData")
local OurRegiment_10101Data = require("GameCore.Data.DataClass.Activity.OurRegiment_10101Data")
local Dream_10102Data = require("GameCore.Data.DataClass.Activity.Dream_10102Data")
local TimerManager = require("GameCore.Timer.TimerManager")
local BdConvertData = require("GameCore.Data.DataClass.Activity.BdConvertData")
local BreakOut_30101Data = require("GameCore.Data.DataClass.Activity.BreakOut_30101Data")
local BreakOutData = require("GameCore.Data.DataClass.Activity.BreakOutData")
local TrekkerVersusData = require("GameCore.Data.DataClass.Activity.TrekkerVersusData")
local ThrowGiftData = require("GameCore.Data.DataClass.Activity.ThrowGiftData")
local Christmas_20101Data = require("GameCore.Data.DataClass.Activity.Christmas_20101Data")
local Miracle_10103Data = require("GameCore.Data.DataClass.Activity.Miracle_10103Data")
local SpringFestival_10104Data = require("GameCore.Data.DataClass.Activity.SpringFestival_10104Data")
local WinterNight_10105Data = require("GameCore.Data.DataClass.Activity.WinterNight_10105Data")
local Postal_10106Data = require("GameCore.Data.DataClass.Activity.Postal_10106Data")
local Viewfinder_10107Data = require("GameCore.Data.DataClass.Activity.Viewfinder_10107Data")
local Tech_10108Data = require("GameCore.Data.DataClass.Activity.Tech_10108Data")
local GunStorm_10109Data = require("GameCore.Data.DataClass.Activity.GunStorm_10109Data")
local Summer_10110Data = require("GameCore.Data.DataClass.Activity.Summer_10110Data")
local PenguinCardActData = require("GameCore.Data.DataClass.Activity.PenguinCardActData")
local GoldenSpyData = require("GameCore.Data.DataClass.Activity.GoldenSpyData")
local Solodance_20102Data = require("GameCore.Data.DataClass.Activity.Solodance_20102Data")
local SwimTheme_11100Data = require("GameCore.Data.DataClass.Activity.SwimTheme_11100Data")
local CultivationManual_10111Data = require("GameCore.Data.DataClass.Activity.CultivationManual_10111Data")
local DoubleDropsActData = require("GameCore.Data.DataClass.Activity.DoubleDropsActData")
local FollowSocialMediaData = require("GameCore.Data.DataClass.Activity.FollowSocialMediaData")
local Summer_20103Data = require("GameCore.Data.DataClass.Activity.Summer_20103Data")
local IceCreamActData = require("GameCore.Data.DataClass.Activity.IceCreamActData")
local SoldierActData = require("GameCore.Data.DataClass.Activity.SoldierActData")
local LongestDay_10112Data = require("GameCore.Data.DataClass.Activity.LongestDay_10112Data")
local MathParkourActData = require("GameCore.Data.DataClass.Activity.MathParkourActData")
local DustDawn_20104Data = require("GameCore.Data.DataClass.Activity.DustDawn_20104Data")
local MailBindActData = require("GameCore.Data.DataClass.Activity.MailBindActData")
local MallCheckInActData = require("GameCore.Data.DataClass.Activity.MallCheckInActData")
local UnchartedMap_10113Data = require("GameCore.Data.DataClass.Activity.UnchartedMap_10113Data")

function PlayerActivityData:Init()
  self.bCacheActData = false
  self.tbAllActivity = {}
  self.tbAllActivityGroup = {}
  self.tbActivityPopUp = {}
  self.tbLoginRewardPopUp = {}
  self.tbReadedCG = {}
  self.mapMallActType = {}
  self:InitActivityCfg()
  EventManager.Add(EventId.IsNewDay, self, self.OnEvent_NewDay)
  EventManager.Add(EventId.UpdateWorldClass, self, self.OnEvent_UpdateWorldClass)
  EventManager.Add("Story_RewardClosed", self, self.OnEvent_StoryEnd)
end

function PlayerActivityData:UnInit()
  EventManager.Remove(EventId.IsNewDay, self, self.OnEvent_NewDay)
  EventManager.Remove(EventId.UpdateWorldClass, self, self.OnEvent_UpdateWorldClass)
  EventManager.Remove("Story_RewardClosed", self, self.OnEvent_StoryEnd)
end

function PlayerActivityData:InitActivityCfg()
  local function foreachTableLine(line)
    if nil == CacheTable.GetData("_PeriodicQuestGroup", line.Belong) then
      CacheTable.SetData("_PeriodicQuestGroup", line.Belong, {})
    end
    if nil == CacheTable.GetData("_PeriodicQuestGroup", line.Belong)[line.UnlockTime + 1] then
      CacheTable.GetData("_PeriodicQuestGroup", line.Belong)[line.UnlockTime + 1] = {}
    end
    table.insert(CacheTable.GetData("_PeriodicQuestGroup", line.Belong)[line.UnlockTime + 1], line.GroupId)
    if nil == CacheTable.GetData("_PeriodicQuestDay", line.Belong) then
      CacheTable.SetData("_PeriodicQuestDay", line.Belong, {})
    end
    CacheTable.GetData("_PeriodicQuestDay", line.Belong)[line.GroupId] = line.UnlockTime + 1
    if nil == CacheTable.GetData("_PeriodicQuestMaxDay", line.Belong) then
      CacheTable.SetData("_PeriodicQuestMaxDay", line.Belong, 0)
    end
    if line.UnlockTime + 1 > CacheTable.GetData("_PeriodicQuestMaxDay", line.Belong) then
      CacheTable.SetData("_PeriodicQuestMaxDay", line.Belong, line.UnlockTime + 1)
    end
  end
  
  ForEachTableLine(DataTable.PeriodicQuestGroup, foreachTableLine)
  
  local function foreachTableLine(line)
    CacheTable.InsertData("_PeriodicQuest", line.Belong, line)
  end
  
  ForEachTableLine(DataTable.PeriodicQuest, foreachTableLine)
  
  local function foreachLoginRewardGroup(line)
    CacheTable.InsertData("_LoginRewardGroup", line.RewardGroupId, line)
  end
  
  ForEachTableLine(DataTable.LoginRewardGroup, foreachLoginRewardGroup)
  
  local function foreachTableLine(line)
    CacheTable.SetData("_ActivityTaskControl", line.ActivityId, line)
  end
  
  ForEachTableLine(DataTable.ActivityTaskControl, foreachTableLine)
  self.mapMallActType = {}
  for _, nType in ipairs(ConfigTable.GetConfigNumberArray("MallActType") or {}) do
    self.mapMallActType[nType] = true
  end
end

function PlayerActivityData:CacheAllActivityData(mapNetMsg)
  if mapNetMsg.List ~= nil then
    PlayerData.ActivityAvg:ResetCachedAvgData()
    for _, v in ipairs(mapNetMsg.List) do
      local nActId = v.Id
      local actCfg = ConfigTable.GetData("Activity", nActId)
      if nil ~= actCfg and v.HistoryStoryChapter ~= nil then
        PlayerData.ActivityAvg:CacheAvgData(v.HistoryStoryChapter, nActId)
      end
      if nil ~= actCfg then
        if actCfg.ActivityType == GameEnum.activityType.PeriodicQuest then
          self:RefreshPeriodicActQuest(nActId, v.Periodic)
        elseif actCfg.ActivityType == GameEnum.activityType.LoginReward or actCfg.ActivityType == GameEnum.activityType.SignIn then
          self:RefreshLoginRewardActData(nActId, v.Login)
        elseif actCfg.ActivityType == GameEnum.activityType.Mining then
          self:RefreshMiningGameActData(nActId, v.Mining)
        elseif actCfg.ActivityType == GameEnum.activityType.Cookie then
          self:RefreshCookieGameActData(nActId, v.Cookie)
        elseif actCfg.ActivityType == GameEnum.activityType.TowerDefense then
          self:RefreshTowerDefenseActData(nActId, v.TowerDefense)
        elseif actCfg.ActivityType == GameEnum.activityType.JointDrill then
          self:RefreshJointDrillActData(nActId, v.JointDrill)
        elseif actCfg.ActivityType == GameEnum.activityType.Levels then
          self:RefreshActivityLevelGameActData(nActId, v.Levels)
        elseif actCfg.ActivityType == GameEnum.activityType.Trial then
          self:RefreshTrialActData(nActId, v.Trial)
        elseif actCfg.ActivityType == GameEnum.activityType.CG then
          self:RefreshActivityCGData(v.CG)
        elseif actCfg.ActivityType == GameEnum.activityType.Task then
          local actIns = self.tbAllActivity[nActId]
          if actIns == nil then
            local mapActData = {}
            mapActData.Id = nActId
            mapActData.StartTime = 0
            mapActData.EndTime = 0
            actIns = ActivityTaskData.new(mapActData)
            self.tbAllActivity[nActId] = actIns
          end
          actIns:CacheData(v.Task)
          EventManager.Hit("RefreshActivityTask")
        elseif actCfg.ActivityType == GameEnum.activityType.Shop then
          self:RefreshActivityShopData(nActId, v.Shop)
        elseif actCfg.ActivityType == GameEnum.activityType.Advertise then
          self:RefreshInfinityTowerActData(nActId, v.Shop)
        elseif actCfg.ActivityType == GameEnum.activityType.BDConvert then
          self:RefreshBdConvertData(nActId, v.BdConvert)
        elseif actCfg.ActivityType == GameEnum.activityType.Breakout then
          self:RefreshBreakOutData(nActId, v.Milkout)
        elseif actCfg.ActivityType == GameEnum.activityType.TrekkerVersus then
          self:RefreshTrekkerVersusData(nActId, v.TrekkerVersus)
        elseif actCfg.ActivityType == GameEnum.activityType.ThrowGift then
          self:RefreshThrowGiftData(nActId, v.ThrowGift)
        elseif actCfg.ActivityType == GameEnum.activityType.PenguinCard then
          self:RefreshPenguinCardActData(nActId, v.PenguinCard)
        elseif actCfg.ActivityType == GameEnum.activityType.GoldenSpy then
          self:RefreshGoldenSpyActData(nActId, v.GDS)
        elseif actCfg.ActivityType == GameEnum.activityType.Double then
          self:RefreshDoubleDropsActData(nActId, v.Double)
        elseif actCfg.ActivityType == GameEnum.activityType.FollowSocialMedia then
          self:RefreshFollowSocialMediaActData(nActId, v.Share)
        elseif actCfg.ActivityType == GameEnum.activityType.IceCream then
          self:RefreshIceCreamActData(nActId, v.IceCream)
        elseif actCfg.ActivityType == GameEnum.activityType.Soldier then
          self:RefreshSoldierActData(nActId, v.Soldier)
        elseif actCfg.ActivityType == GameEnum.activityType.MathParkour then
          self:RefreshMathParkourActData(nActId, v.MathParkour)
        elseif actCfg.ActivityType == GameEnum.activityType.MailBind then
          self:RefreshMailBindActData(nActId, v.MailBind)
        elseif actCfg.ActivityType == GameEnum.activityType.MallLogin then
          self:RefreshMallLoginActData(nActId, v.MallLogin)
        end
      end
    end
    PlayerData.ActivityAvg:RefreshAvgRedDot()
  end
  self:RefreshLoginRewardPopUpList()
  self:RefreshActivityRedDot()
end

function PlayerActivityData:CacheActivityData(mapNetMsg)
  if nil == mapNetMsg then
    return
  end
  for _, v in ipairs(mapNetMsg) do
    self:CreateActivityIns(v)
  end
end

function PlayerActivityData:UpdateActivityState(mapNetMsg)
  if nil == mapNetMsg then
    return
  end
  for _, v in ipairs(mapNetMsg) do
    if self.tbAllActivity[v.Id] ~= nil then
      self.tbAllActivity[v.Id]:UpdateActivityState(v)
    end
  end
  self:RefreshActivityRedDot()
end

function PlayerActivityData:RefreshActivityData(mapNetMsg)
  if nil == self.tbAllActivity[mapNetMsg.Id] then
    self:CreateActivityIns(mapNetMsg)
    self:SendActivityDetailMsg(nil, true)
  else
    self.tbAllActivity[mapNetMsg.Id]:RefreshActivityData(mapNetMsg)
  end
  self:RefreshPopUpList()
  self:RefreshActivityRedDot()
end

function PlayerActivityData:RefreshActivityStateData(mapNetMsg)
  if nil ~= self.tbAllActivity[mapNetMsg.Id] then
    self.tbAllActivity[mapNetMsg.Id]:RefreshStateData(mapNetMsg.RedDot, mapNetMsg.Banner)
    self:RefreshActivityRedDot()
  end
end

function PlayerActivityData:RefreshActStatus()
  for _, actData in pairs(self.tbAllActivity) do
    local bPlay = actData:GetPlayState()
    if not bPlay then
      actData:RefreshPlayState()
      local bPlay_new = actData:GetPlayState()
      if bPlay_new then
        actData:UpdateStatus()
      end
    end
  end
end

function PlayerActivityData:CreateActivityIns(actData)
  local actIns
  local actCfg = ConfigTable.GetData("Activity", actData.Id)
  if actCfg == nil then
    return
  end
  if actCfg.ActivityType == GameEnum.activityType.PeriodicQuest then
    actIns = PeriodicQuestActData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.LoginReward or actCfg.ActivityType == GameEnum.activityType.SignIn then
    actIns = LoginRewardActData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.Mining then
    actIns = MiningGameData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.Trial then
    actIns = TrialActData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.Cookie then
    actIns = CookieActData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.TowerDefense then
    actIns = TowerDefenseData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.JointDrill then
    actIns = JointDrillActData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.Levels then
    actIns = ActivityLevelTypeData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.HistoryStory or actCfg.ActivityType == GameEnum.activityType.Story or actCfg.ActivityType == GameEnum.activityType.NewStory then
    PlayerData.ActivityAvg:CacheActivityAvgData(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.Task then
    actIns = ActivityTaskData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.Shop then
    actIns = ActivityShopData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.Advertise then
    actIns = AdvertiseActData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.BDConvert then
    actIns = BdConvertData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.Breakout then
    actIns = BreakOutData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.TrekkerVersus then
    actIns = TrekkerVersusData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.ThrowGift then
    actIns = ThrowGiftData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.PenguinCard then
    actIns = PenguinCardActData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.GoldenSpy then
    actIns = GoldenSpyData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.Double then
    actIns = DoubleDropsActData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.FollowSocialMedia then
    actIns = FollowSocialMediaData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.IceCream then
    actIns = IceCreamActData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.Soldier then
    actIns = SoldierActData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.MathParkour then
    actIns = MathParkourActData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.MailBind then
    actIns = MailBindActData.new(actData)
  elseif actCfg.ActivityType == GameEnum.activityType.MallLogin then
    actIns = MallCheckInActData.new(actData)
  end
  if actIns ~= nil then
    self.tbAllActivity[actData.Id] = actIns
  end
end

function PlayerActivityData:RefreshActivityRedDot()
  local bHasNewRedDot = false
  local mapEntranceRedDot = {}
  local mapEntranceNewRedDot = {}
  for _, v in pairs(self.tbAllActivity) do
    RedDotManager.SetValid(RedDotDefine.Activity_Tab, v:GetActId(), v:CheckActShow() and v:GetActivityRedDot() and not v:CheckHideFromActList())
    if type(v.RefreshRedDot) == "function" then
      v:RefreshRedDot()
    end
    local bInActGroup = false
    if v:GetActCfgData().ActivityThemeType > 0 or self:IsActivityInActivityGroup(v:GetActId()) then
      bInActGroup = true
    end
    if not bInActGroup and v:CheckActShow() and not v:CheckHideFromActList() then
      local bTabRedDot = RedDotManager.GetValid(RedDotDefine.Activity_Tab, v:GetActId())
      local sData = LocalData.GetPlayerLocalData("Activity_Tab_New_" .. v:GetActId())
      local nValue = tonumber(sData == nil and "0" or sData)
      local bNewRedDot = nValue == 0 and not bTabRedDot
      if bNewRedDot then
        bHasNewRedDot = true
      end
      RedDotManager.SetValid(RedDotDefine.Activity_New_Tab, v:GetActId(), bNewRedDot)
      local nEntranceId = v:GetActCfgData().EntranceId or 0
      mapEntranceRedDot[nEntranceId] = mapEntranceRedDot[nEntranceId] or bTabRedDot
      mapEntranceNewRedDot[nEntranceId] = mapEntranceNewRedDot[nEntranceId] or bNewRedDot
    end
  end
  local bHasGroupNewRedDot = false
  for nId, v in pairs(self.tbAllActivityGroup) do
    if v:CheckActGroupShow() then
      local bGroupNewRedDot = RedDotManager.GetValid(RedDotDefine.Activity_New_Tab, nId)
      if bGroupNewRedDot then
        bHasGroupNewRedDot = true
      end
      local nEntranceId = v:GetActGroupCfgData().EntranceId or 0
      mapEntranceRedDot[nEntranceId] = mapEntranceRedDot[nEntranceId] or RedDotManager.GetValid(RedDotDefine.Activity_Group, nId)
      mapEntranceNewRedDot[nEntranceId] = mapEntranceNewRedDot[nEntranceId] or bGroupNewRedDot
    end
  end
  local bHasRedDot = RedDotManager.GetValid(RedDotDefine.Activity)
  RedDotManager.SetValid(RedDotDefine.Activity_New, nil, not bHasRedDot and (bHasNewRedDot or bHasGroupNewRedDot))
  self:RefreshActivityEntranceRedDot(mapEntranceRedDot, mapEntranceNewRedDot)
end

function PlayerActivityData:RefreshActivityEntranceRedDot(mapEntranceRedDot, mapEntranceNewRedDot)
  local mapEntranceId = self.mapLastEntranceRedDotId or {}
  for nEntranceId in pairs(mapEntranceRedDot) do
    mapEntranceId[nEntranceId] = true
  end
  for nEntranceId in pairs(mapEntranceNewRedDot) do
    mapEntranceId[nEntranceId] = true
  end
  for nEntranceId in pairs(mapEntranceId) do
    local bRedDot = mapEntranceRedDot[nEntranceId] == true
    local bNewRedDot = not bRedDot and mapEntranceNewRedDot[nEntranceId] == true
    RedDotManager.SetValid(RedDotDefine.Activity_Entrance, nEntranceId, bRedDot)
    RedDotManager.SetValid(RedDotDefine.Activity_Entrance_New, nEntranceId, bNewRedDot)
  end
  self.mapLastEntranceRedDotId = mapEntranceId
end

function PlayerActivityData:GetActivityList()
  return self.tbAllActivity
end

function PlayerActivityData:GetSortedActList()
  local tbActList = {}
  for k, v in pairs(self.tbAllActivity) do
    if v:CheckActShow() and not v:CheckHideFromActList() then
      local bInActGroup = false
      if v:GetActCfgData().ActivityThemeType > 0 or self:IsActivityInActivityGroup(v:GetActId()) then
        bInActGroup = true
      end
      if not bInActGroup then
        table.insert(tbActList, v)
      end
    end
  end
  table.sort(tbActList, function(a, b)
    if a:GetActSortId() == b:GetActSortId() then
      return a:GetActId() < b:GetActId()
    end
    return a:GetActSortId() < b:GetActSortId()
  end)
  return tbActList
end

function PlayerActivityData:GetActivitySubEntranceId()
  local tbEntranceIds = {}
  local mapHasEntrance = {}
  
  local function collect(nEntranceId)
    nEntranceId = nEntranceId or 0
    if nEntranceId <= 0 or mapHasEntrance[nEntranceId] then
      return
    end
    mapHasEntrance[nEntranceId] = true
    table.insert(tbEntranceIds, nEntranceId)
  end
  
  for _, actData in ipairs(self:GetSortedActList()) do
    local actCfg = actData:GetActCfgData()
    if actCfg ~= nil then
      collect(actCfg.EntranceId)
    end
  end
  for _, actGroupData in ipairs(self:GetSortedActGroupList()) do
    local actGroupCfg = actGroupData:GetActGroupCfgData()
    if actGroupCfg ~= nil then
      collect(actGroupCfg.EntranceId)
    end
  end
  if 1 < #tbEntranceIds then
    printError(string.format("同时开放了%d个活动列表子入口(EntranceId: %s)，只显示第一个", #tbEntranceIds, table.concat(tbEntranceIds, ", ")))
  end
  return tbEntranceIds[1] or 0
end

function PlayerActivityData:GetActivityDataById(nActId)
  return self.tbAllActivity[nActId] or nil
end

function PlayerActivityData:GetActivityDataByType(nActType)
  for _, v in pairs(self.tbAllActivity) do
    if v:GetActType() == nActType then
      return v
    end
  end
end

function PlayerActivityData:GetMallActivityData()
  local tbActList = {}
  for _, actData in pairs(self.tbAllActivity) do
    if self.mapMallActType[actData:GetActType()] and actData:CheckActShow() then
      table.insert(tbActList, actData)
    end
  end
  if 1 < #tbActList then
    table.sort(tbActList, function(a, b)
      return a:GetActId() < b:GetActId()
    end)
    local tbActIds = {}
    for _, actData in ipairs(tbActList) do
      table.insert(tbActIds, actData:GetActId())
    end
    printError(string.format("同时开放了%d个商城活动(ActivityId: %s)，只显示id最小的那个", #tbActList, table.concat(tbActIds, ", ")))
  end
  return tbActList[1]
end

function PlayerActivityData:CacheActivityGroupData()
  local function foreachActGroup(mapData)
    self:CreateActivityGroupIns(mapData)
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityGroup"), foreachActGroup)
  self:RefreshPopUpList()
  self:RefreshActGroupNewRedDot()
end

function PlayerActivityData:CreateActivityGroupIns(actData)
  local actIns
  local actCfg = actData
  if actCfg == nil then
    return
  end
  local nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(actCfg.StartTime)
  local nEndEnterTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(actCfg.EnterEndTime)
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  if nOpenTime <= curTime and nEndEnterTime > curTime then
    if actCfg.ActivityThemeType == GameEnum.activityThemeType.Swim then
      actIns = SwimThemeData.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.OurRegiment_10101 then
      actIns = OurRegiment_10101Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.Dream_10102 then
      actIns = Dream_10102Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.BreakOut_30101 or actCfg.ActivityThemeType == GameEnum.activityThemeType.BreakOut_30102 or actCfg.ActivityThemeType == GameEnum.activityThemeType.BreakOut_30103 or actCfg.ActivityThemeType == GameEnum.activityThemeType.BreakOut_30104 then
      actIns = BreakOut_30101Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.Christmas_20101 then
      actIns = Christmas_20101Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.Miracle_10103 then
      actIns = Miracle_10103Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.Spring_10104 then
      actIns = SpringFestival_10104Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.WinterNight_10105 then
      actIns = WinterNight_10105Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.Postal_10106 then
      actIns = Postal_10106Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.SoloDance_20102 then
      actIns = Solodance_20102Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.Viewfinder_10107 then
      actIns = Viewfinder_10107Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.Swim_11100 then
      actIns = SwimTheme_11100Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.Tech_10108 then
      actIns = Tech_10108Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.GunStorm_10109 then
      actIns = GunStorm_10109Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.Summer_10110 then
      actIns = Summer_10110Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.Summer_20103 then
      actIns = Summer_20103Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.CultivationManual_10111 then
      actIns = CultivationManual_10111Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.LongestDay_10112 then
      actIns = LongestDay_10112Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.DustDawn_20104 then
      actIns = DustDawn_20104Data.new(actData)
    elseif actCfg.ActivityThemeType == GameEnum.activityThemeType.UnchartedMap_10113 then
      actIns = UnchartedMap_10113Data.new(actData)
    end
    self.tbAllActivityGroup[actData.Id] = actIns
    PlayerData.ActivityAvg:RefreshAvgRedDot()
  elseif nOpenTime > curTime then
    TimerManager.Add(1, nOpenTime - curTime, nil, function()
      self:RefreshActivityGroupData(actData)
    end, true, true, true)
  end
end

function PlayerActivityData:RefreshActivityGroupData(actData)
  if nil == self.tbAllActivityGroup[actData.Id] then
    self:CreateActivityGroupIns(actData)
  else
    self.tbAllActivityGroup[actData.Id]:RefreshActivityData(actData)
  end
  self:RefreshActGroupNewRedDot()
end

function PlayerActivityData:RefreshActGroupNewRedDot()
  for _, actIns in pairs(self.tbAllActivityGroup) do
    if actIns:CheckActGroupShow() then
      local sData = LocalData.GetPlayerLocalData("Activity_Tab_New_" .. actIns:GetActGroupId())
      local nValue = tonumber(sData == nil and "0" or sData)
      local bNewRedDot = nValue == 0
      RedDotManager.SetValid(RedDotDefine.Activity_New_Tab, actIns:GetActGroupId(), bNewRedDot)
    end
  end
end

function PlayerActivityData:GetSortedActGroupList()
  local tbActGroupList = {}
  for k, v in pairs(self.tbAllActivityGroup) do
    if v:CheckActGroupShow() then
      table.insert(tbActGroupList, v)
    end
  end
  table.sort(tbActGroupList, function(a, b)
    if not a:CheckActivityGroupOpen() and b:CheckActivityGroupOpen() then
      return false
    elseif a:CheckActivityGroupOpen() and not b:CheckActivityGroupOpen() then
      return true
    end
    return a:GetActGroupId() < b:GetActGroupId()
  end)
  return tbActGroupList
end

function PlayerActivityData:GetActivityGroupDataById(nActGroupId)
  return self.tbAllActivityGroup[nActGroupId]
end

function PlayerActivityData:GetActivityGroupDataByActivityId(nActId)
  local bInGroup, nActGroupId = self:IsActivityInActivityGroup(nActId)
  if bInGroup and nActGroupId ~= nil then
    return self:GetActivityGroupDataById(nActGroupId)
  end
  local activityCfg = ConfigTable.GetData("Activity", nActId)
  if activityCfg ~= nil and activityCfg.MidGroupId ~= nil and activityCfg.MidGroupId > 0 then
    return self:GetActivityGroupDataById(activityCfg.MidGroupId)
  end
end

function PlayerActivityData:GetMainviewShowActivityGroup()
  local tbShowList = {}
  for _, actGroupData in pairs(self.tbAllActivityGroup) do
    if actGroupData:CheckActGroupShow() and actGroupData:IsUnlockShow() then
      local actGroupCfg = actGroupData:GetActGroupCfgData()
      if actGroupCfg ~= nil and actGroupCfg.EnterRes ~= nil and actGroupCfg.EnterRes ~= "" then
        table.insert(tbShowList, actGroupData)
      end
    end
  end
  table.sort(tbShowList, function(a, b)
    if not a:CheckActivityGroupOpen() and b:CheckActivityGroupOpen() then
      return false
    elseif a:CheckActivityGroupOpen() and not b:CheckActivityGroupOpen() then
      return true
    end
    return a:GetActGroupId() < b:GetActGroupId()
  end)
  return tbShowList
end

function PlayerActivityData:IsActivityInActivityGroup(nActId)
  local isInGroup, getActId
  for _, actGroupData in pairs(self.tbAllActivityGroup) do
    if actGroupData:CheckActGroupShow() then
      isInGroup, getActId = actGroupData:IsActivityInActivityGroup(nActId)
      if isInGroup == true then
        return isInGroup, getActId
      end
    end
  end
  return false
end

function PlayerActivityData:RefreshPeriodicActQuest(nActId, mapMsgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshQuestList(mapMsgData.Quests)
    self.tbAllActivity[nActId]:RefreshFinalStatus(mapMsgData.FinalStatus)
  end
end

function PlayerActivityData:RefreshSingleQuest(questData)
  local actCfg = ConfigTable.GetData("Activity", questData.ActivityId)
  if not actCfg then
    return
  end
  if actCfg.ActivityType == GameEnum.activityType.PeriodicQuest then
    local questCfg = ConfigTable.GetData("PeriodicQuest", questData.Id)
    if questCfg then
      local nActId = questCfg.Belong
      if nil ~= self.tbAllActivity[nActId] then
        self.tbAllActivity[nActId]:RefreshQuestData(questData)
      end
      EventManager.Hit("RefreshPeriodicAct", nActId)
    end
  elseif actCfg.ActivityType == GameEnum.activityType.Mining then
    if nil ~= self.tbAllActivity[questData.ActivityId] then
      self.tbAllActivity[questData.ActivityId]:RefreshQuestData(questData)
    end
  elseif actCfg.ActivityType == GameEnum.activityType.Cookie then
    if nil ~= self.tbAllActivity[questData.ActivityId] then
      self.tbAllActivity[questData.ActivityId]:RefreshQuestData(questData)
    end
  elseif actCfg.ActivityType == GameEnum.activityType.JointDrill then
    self.tbAllActivity[questData.ActivityId]:RefreshQuestData(questData)
  elseif actCfg.ActivityType == GameEnum.activityType.Task then
    if self.tbAllActivity[questData.ActivityId] ~= nil then
      self.tbAllActivity[questData.ActivityId]:RefreshSingleQuest(questData)
      EventManager.Hit("RefreshActivityTask")
    end
  elseif actCfg.ActivityType == GameEnum.activityType.BDConvert then
    if nil ~= self.tbAllActivity[questData.ActivityId] then
      self.tbAllActivity[questData.ActivityId]:RefreshQuestData(questData)
    end
  elseif actCfg.ActivityType == GameEnum.activityType.TowerDefense then
    if nil ~= self.tbAllActivity[questData.ActivityId] then
      self.tbAllActivity[questData.ActivityId]:RefreshQuestData(questData)
    end
  elseif actCfg.ActivityType == GameEnum.activityType.TrekkerVersus then
    if nil ~= self.tbAllActivity[questData.ActivityId] then
      self.tbAllActivity[questData.ActivityId]:RefreshQuestData(questData)
    end
  elseif actCfg.ActivityType == GameEnum.activityType.ThrowGift then
    if nil ~= self.tbAllActivity[questData.ActivityId] then
      self.tbAllActivity[questData.ActivityId]:RefreshQuestData(questData)
    end
  elseif actCfg.ActivityType == GameEnum.activityType.PenguinCard then
    if nil ~= self.tbAllActivity[questData.ActivityId] then
      self.tbAllActivity[questData.ActivityId]:RefreshQuestData(questData)
    end
  elseif actCfg.ActivityType == GameEnum.activityType.Double then
    if nil ~= self.tbAllActivity[questData.ActivityId] then
      self.tbAllActivity[questData.ActivityId]:RefreshQuestData(questData)
    end
  elseif actCfg.ActivityType == GameEnum.activityType.Soldier and nil ~= self.tbAllActivity[questData.ActivityId] then
    self.tbAllActivity[questData.ActivityId]:RefreshQuestData(questData)
  end
end

function PlayerActivityData:CacheLoginRewardActData(nActId, mapMsgData)
  self:RefreshLoginRewardActData(nActId, mapMsgData)
  self:RefreshLoginRewardPopUpList()
end

function PlayerActivityData:RefreshLoginRewardActData(nActId, actData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshLoginData(actData.Receive, actData.Actual)
  end
end

function PlayerActivityData:ReceiveLoginRewardSuc(nActId)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:ReceiveRewardSuc()
  end
end

function PlayerActivityData:CacheMallLoginActData(nActId, mapMsgData)
  self:RefreshMallLoginActData(nActId, mapMsgData)
  self:RefreshActivityRedDot()
end

function PlayerActivityData:RefreshMallLoginActData(nActId, actData)
  if nil == actData or nil == self.tbAllActivity[nActId] then
    return
  end
  self.tbAllActivity[nActId]:RefreshMallLoginData(actData)
end

function PlayerActivityData:ReceiveMallLoginRewardSuc(nActId)
  if nil == self.tbAllActivity[nActId] then
    return
  end
  self.tbAllActivity[nActId]:ReceiveRewardSuc()
  self:RefreshActivityRedDot()
end

function PlayerActivityData:RefreshPopUpList()
  self.tbActivityPopUp = {}
  local bFuncOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Activity)
  if not bFuncOpen then
    return
  end
  for _, v in pairs(self.tbAllActivity) do
    if v:CheckPopUp() and v:CheckActPlay() then
      table.insert(self.tbActivityPopUp, v:GetActId())
    end
  end
  for _, v in pairs(self.tbAllActivityGroup) do
    if v:CheckPopUp() and v:CheckActGroupPopUpShow() and v:IsUnlock() then
      table.insert(self.tbActivityPopUp, v:GetActGroupId())
    end
  end
  if #self.tbActivityPopUp > 0 then
    PlayerData.PopUp:InsertPopUpQueue(self.tbActivityPopUp)
  end
end

function PlayerActivityData:RefreshLoginRewardPopUpList()
  self.tbLoginRewardPopUp = {}
  local bFuncOpen = PlayerData.Base:CheckFunctionUnlock(GameEnum.OpenFuncType.Activity)
  if not bFuncOpen then
    return
  end
  for nActId, data in pairs(self.tbAllActivity) do
    local nActType = data:GetActType()
    if (nActType == GameEnum.activityType.LoginReward or nActType == GameEnum.activityType.SignIn) and data:CheckCanReceive() and data:CheckActivityOpen() and data:CheckActPlay() then
      table.insert(self.tbLoginRewardPopUp, data)
    end
  end
  table.sort(self.tbLoginRewardPopUp, function(a, b)
    if a:GetActSortId() == b:GetActSortId() then
      return a:GetActId() < b:GetActId()
    end
    return a:GetActSortId() < b:GetActSortId()
  end)
  if #self.tbLoginRewardPopUp > 0 then
    PopUpManager.PopUpEnQueue(GameEnum.PopUpSeqType.ActivityLogin, self.tbLoginRewardPopUp)
  end
end

function PlayerActivityData:RefreshMiningGameActData(nActId, msgMapData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshMiningGameActData(nActId, msgMapData)
  end
end

function PlayerActivityData:RefreshCookieGameActData(nActId, msgMapData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshCookieGameActData(nActId, msgMapData)
  end
end

function PlayerActivityData:RefreshJointDrillActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshJointDrillActData(msgData)
  end
end

function PlayerActivityData:RefreshTowerDefenseActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshTowerDefenseActData(nActId, msgData)
  end
end

function PlayerActivityData:RefreshBdConvertData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshBdConvertData(nActId, msgData)
  end
end

function PlayerActivityData:RefreshBreakOutData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshBreakOutData(nActId, msgData)
  end
end

function PlayerActivityData:RefreshTrekkerVersusData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshTrekkerVersusData(nActId, msgData)
  end
end

function PlayerActivityData:RefreshThrowGiftData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshThrowGiftData(nActId, msgData)
  end
end

function PlayerActivityData:RefreshPenguinCardActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshPenguinCardActData(msgData)
  end
end

function PlayerActivityData:RefreshGoldenSpyActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshGoldenSpyActData(nActId, msgData)
  end
end

function PlayerActivityData:RefreshFollowSocialMediaActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshFollowSocialMediaActData(nActId, msgData)
  end
end

function PlayerActivityData:RefreshIceCreamActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshIceCreamActData(nActId, msgData)
  end
end

function PlayerActivityData:RefreshSoldierActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshSoldierActData(nActId, msgData)
  end
end

function PlayerActivityData:RefreshActivityLevelGameActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshActivityLevelGameActData(nActId, msgData)
  end
end

function PlayerActivityData:RefreshMailBindActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshMailBindActData(nActId, msgData)
  end
end

function PlayerActivityData:SetActivityLevelActId(nActId)
  self.nActivityLevelActId = nActId
end

function PlayerActivityData:GetActivityLevelActId()
  return self.nActivityLevelActId
end

function PlayerActivityData:RefreshTrialActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshTrialActData(msgData)
  end
end

function PlayerActivityData:RefreshActivityAvgData(nActId, msgData)
  PlayerData.ActivityAvg:RefreshActivityAvgData(nActId, msgData)
end

function PlayerActivityData:RefreshActivityShopData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshActivityShopData(msgData)
  end
end

function PlayerActivityData:RefreshActivityCGData(msgData)
  self.tbReadedCG = {}
  for _, actId in pairs(msgData) do
    table.insert(self.tbReadedCG, actId)
  end
end

function PlayerActivityData:IsCGPlayed(nActId)
  return table.indexof(self.tbReadedCG, nActId) > 0
end

function PlayerActivityData:RefreshDoubleDropsActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshDoubleDropsActData(nActId, msgData)
  end
end

function PlayerActivityData:RefreshMathParkourActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshMathParkourActData(nActId, msgData)
  end
end

function PlayerActivityData:GetActivityBannerList()
  local tbList = {}
  for _, v in pairs(self.tbAllActivity) do
    if v:CheckShowBanner() then
      table.insert(tbList, v)
    end
  end
  table.sort(tbList, function(a, b)
    return a:GetActId() < b:GetActId()
  end)
  return tbList
end

function PlayerActivityData:RefreshInfinityTowerActData(nActId, msgData)
  if nil ~= self.tbAllActivity[nActId] then
    self.tbAllActivity[nActId]:RefreshInfinityTowerActData(nActId, msgData)
  end
end

function PlayerActivityData:SendActivityDetailMsg(callback, bForceGet)
  local function callFunc()
    self.bCacheActData = true
    
    if callback ~= nil then
      callback()
    end
  end
  
  if not self.bCacheActData or bForceGet then
    HttpNetHandler.SendMsg(NetMsgId.Id.activity_detail_req, {}, nil, callFunc)
  elseif callback ~= nil then
    callback()
  end
end

function PlayerActivityData:SendReceivePerQuest(nActId, nQuestId, callback)
  local function callFunc(_, mapChangeInfo)
    local actData = self.tbAllActivity[nActId]
    
    local tbQuestList = actData:RefreshQuestStatus(nQuestId)
    UTILS.OpenReceiveByChangeInfo(mapChangeInfo, callback)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_periodic_reward_receive_req, {ActivityId = nActId, QuestId = nQuestId}, nil, callFunc)
end

function PlayerActivityData:SendReceiveFinalReward(nActId, callback)
  local function callFunc(_, mapMsgData)
    self:ReceiveFinalRewardSuc(nActId, mapMsgData)
    
    if nil ~= callback then
      callback()
    end
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_periodic_final_reward_receive_req, {Value = nActId}, nil, callFunc)
end

function PlayerActivityData:ReceiveQuestReward(mapMsgData)
  UTILS.OpenReceiveByChangeInfo(mapMsgData)
end

function PlayerActivityData:ReceiveFinalRewardSuc(actId, mapMsgData)
  local actData = self.tbAllActivity[actId]
  if nil ~= actData then
    actData:RefreshFinalStatus(true)
    UTILS.OpenReceiveByChangeInfo(mapMsgData)
  end
end

function PlayerActivityData:SendReceiveLoginRewardMsg(nActId, callFunc, mapNpc)
  local function callback(_, mapMsgData)
    self:ReceiveLoginRewardSuc(nActId)
    
    UTILS.OpenReceiveByChangeInfo(mapMsgData, callFunc, nil, nil, mapNpc)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_login_reward_receive_req, {Value = nActId}, nil, callback)
end

function PlayerActivityData:SendReceiveMallLoginRewardMsg(nActId, callFunc, mapNpc)
  local function callback(_, mapMsgData)
    self:ReceiveMallLoginRewardSuc(nActId)
    
    UTILS.OpenReceiveByChangeInfo(mapMsgData, callFunc, nil, nil, mapNpc)
  end
  
  HttpNetHandler.SendMsg(NetMsgId.Id.activity_malllogin_reward_receive_req, {Value = nActId}, nil, callback)
end

function PlayerActivityData:OpenActivityPanel(nActId, nEntranceId)
  local tbList = self:GetSortedActList()
  if nil == next(tbList) then
    self:RefreshActivityRedDot()
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Activity_Empty"))
    return
  end
  
  local function openFunc()
    local function func()
      EventManager.Hit(EventId.OpenPanel, PanelId.ActivityList, nActId or 0, nEntranceId)
    end
    
    EventManager.Hit(EventId.SetTransition, 5, func)
  end
  
  self:SendActivityDetailMsg(openFunc)
end

function PlayerActivityData:OnEvent_NewDay()
  self.bCacheActData = false
end

function PlayerActivityData:OnEvent_UpdateWorldClass()
  self:RefreshPopUpList()
  self:RefreshLoginRewardPopUpList()
  self:RefreshActStatus()
  self:RefreshActGroupNewRedDot()
end

function PlayerActivityData:OnEvent_StoryEnd()
  self:RefreshPopUpList()
  self:RefreshLoginRewardPopUpList()
  self:RefreshActStatus()
  self:RefreshActGroupNewRedDot()
end

return PlayerActivityData
