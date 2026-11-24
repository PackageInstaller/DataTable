require("SeasonSLG/SeasonSLGEventMgr")
require("SeasonSLG/SeasonSLGMapMgr")

local DAILY_RECORD_POPUP_HOUR = 18
local LOCAL_TIME_OFFSET = 8 * 3600
local ONE_DAY_SECONDS = 24 * 3600

local NOTICE_RECORD_MAX = 200

local NOTICE_OVERVIEW_MAX_POINTS = 200

local NOTICE_RECORD_UNIQUE_TYPES = { ["5"] = true, ["6"] = true }

local NOTICE_RECORD_TIME_FORMAT = "!%m-%d %H:%M"

local NOTICE_FLAG_STAMINA_FULL = "staminaFull"

local NOTICE_FLAG_COMMON_CD = "noticeCommonCd"

SeasonSLGTimeEventMgr = {
    activityInfo = nil,
    worldProgress = 0,
    triggerEventMap = {},
    triggerEventTimeMap = {},
    triggerEventEndMap = {},
    triggerEventEndTimeMap = {},
    triggerEventEndConfigMap = {},
    noticeTriggerMap = {},
    noticeTriggerTimeMap = {},
    noticeEndMap = {},
    noticeEndTimeMap = {},
    noticeEndConfigMap = {},
    noticeRepeatNextTimeMap = {},
    noticeRepeatEndTimeMap = {},
    noticeRepeatConfigMap = {},
    noticeRepeatTimedEventIdMap = {},
    timedEventList = {},
    noticeList = {},
    progressList = {},
}

SeasonSLGTimeEventMgr.Init = function()
    SeasonSLGTimeEventMgr.Clear()
    SeasonSLGTimeEventMgr.worldProgress = 0
    SeasonSLGTimeEventMgr.triggerEventMap = {}
    SeasonSLGTimeEventMgr.triggerEventTimeMap = {}
    SeasonSLGTimeEventMgr.triggerEventEndMap = {}
    SeasonSLGTimeEventMgr.triggerEventEndTimeMap = {}
    SeasonSLGTimeEventMgr.triggerEventEndConfigMap = {}
    SeasonSLGTimeEventMgr.noticeTriggerMap = {}
    SeasonSLGTimeEventMgr.noticeTriggerTimeMap = {}
    SeasonSLGTimeEventMgr.noticeEndMap = {}
    SeasonSLGTimeEventMgr.noticeEndTimeMap = {}
    SeasonSLGTimeEventMgr.noticeEndConfigMap = {}
    SeasonSLGTimeEventMgr.noticeRepeatNextTimeMap = {}
    SeasonSLGTimeEventMgr.noticeRepeatEndTimeMap = {}
    SeasonSLGTimeEventMgr.noticeRepeatConfigMap = {}
    SeasonSLGTimeEventMgr.noticeRepeatTimedEventIdMap = {}
    SeasonSLGTimeEventMgr.misinterNoticeBatchMap = {}
    SeasonSLGTimeEventMgr.misinterHandledBatchMap = {}
    SeasonSLGTimeEventMgr.noticeEventKeyMap = {}

    SeasonSLGTimeEventMgr.noticeCommonCdTime = 0
    SeasonSLGTimeEventMgr.noticeRecordLoaded = false
    SeasonSLGTimeEventMgr.noticeRecordList = nil
    SeasonSLGTimeEventMgr.noticeBackfilled = false
    SeasonSLGTimeEventMgr.lastStaminaIsFull = false
    SeasonSLGTimeEventMgr.noticeLocalKey = nil
    SeasonSLGTimeEventMgr.noticeLocalKeyWarned = false
    SeasonSLGTimeEventMgr.timedEventList = {}
    SeasonSLGTimeEventMgr.noticeList = {}
    SeasonSLGTimeEventMgr.progressList = {}

    SeasonSLGTimeEventMgr.ClearDirtyNoticeLocalKeys()
    LuaMgr.RemoveTimer(TimerConst.SeasonSLGTimeEvent)
    if SeasonSLGTimeEventMgr.GetCurrentSeasonalConfig() == nil then
        SeasonSLGTimeEventMgr.ScheduleNextSeasonOpen()
        return nil
    end
    SeasonSLGMapMgr.CheckSeasonalData()
    if SeasonSLGMapMgr.curSeasonal==nil then
        return nil;
    end
    local activityGroupId = SeasonSLGMapMgr.curSeasonal.ActivityGroupId[1]
    local activityKey = ConfigMgr.Config.activityGroup[activityGroupId].key
    SeasonSLGTimeEventMgr.activityInfo = DataExHelper.GetDataExByTag(activityKey)
    if SeasonSLGTimeEventMgr.activityInfo == nil then
        activityGroupId = SeasonSLGMapMgr.curSeasonal.ActivityGroupId[2]
        activityKey = ConfigMgr.Config.activityGroup[activityGroupId].key
        SeasonSLGTimeEventMgr.activityInfo = DataExHelper.GetDataExByTag(activityKey)
        if SeasonSLGTimeEventMgr.activityInfo == nil then
            return nil
        end
    end
    SeasonSLGTimeEventMgr.InitSeasonConfigList()
    LuaMgr.AddUIEventListener(UIEventConst.HeartBeat, SeasonSLGTimeEventMgr.OnHeartBeat)
    DAILY_RECORD_POPUP_HOUR = SeasonSLGMapMgr.Constants().SeasonalBattleReportTime or 18
end

SeasonSLGTimeEventMgr.GetCurrentSeasonalConfig = function()
    local seasonalMap = ConfigMgr.Config.SeasonalMap
    if seasonalMap == nil then
        return nil
    end
    local nowTime = LuaMgr.Timestamp()
    for i, v in pairs(seasonalMap) do
        local openTime = tonumber(v.OpenTime)
        local endTime = tonumber(v.EndTime)
        if openTime ~= nil and endTime ~= nil and nowTime >= openTime and nowTime <= endTime then
            return v
        end
    end
    return nil
end

SeasonSLGTimeEventMgr.ScheduleNextSeasonOpen = function()
    local nextOpenTime = SeasonSLGTimeEventMgr.GetNextSeasonOpenTime()
    if nextOpenTime == nil then
        return
    end
    local delay = math.max(1, nextOpenTime - LuaMgr.Timestamp())
    LuaMgr.AddTimer(TimerConst.SeasonSLGTimeEvent, SeasonSLGTimeEventMgr.OnSeasonOpenTimer, delay, 1, false)
end

SeasonSLGTimeEventMgr.GetNextSeasonOpenTime = function()
    local seasonalMap = ConfigMgr.Config.SeasonalMap
    if seasonalMap == nil then
        return nil
    end
    local nowTime = LuaMgr.Timestamp()
    local nextOpenTime = nil
    for i, v in pairs(seasonalMap) do
        local openTime = tonumber(v.OpenTime)
        if openTime ~= nil and nowTime < openTime then
            if nextOpenTime == nil or openTime < nextOpenTime then
                nextOpenTime = openTime
            end
        end
    end
    return nextOpenTime
end

SeasonSLGTimeEventMgr.OnSeasonOpenTimer = function()
    SeasonSLGTimeEventMgr.Init()
end

SeasonSLGTimeEventMgr.GetActivityStartTime = function()
    if SeasonSLGTimeEventMgr.activityInfo ~= nil then
        local startTime=tonumber(SeasonSLGTimeEventMgr.activityInfo.startTime)
        if startTime~=nil then
            return startTime
        end
    end
    local seasonConfig=SeasonSLGTimeEventMgr.GetCurrentSeasonalConfig()
    if seasonConfig~=nil then
        return tonumber(seasonConfig.OpenTime)
    end
    return nil
end

SeasonSLGTimeEventMgr.GetCurSeasonId = function()
    if SeasonSLGMapMgr.curSeasonal == nil then
        return nil
    end
    return SeasonSLGMapMgr.curSeasonal.Id
end

SeasonSLGTimeEventMgr.GetDailyRecordDayStartTime = function(nowTime)
    nowTime = tonumber(nowTime) or LuaMgr.Timestamp()
    local localTimestamp = nowTime + LOCAL_TIME_OFFSET
    return math.floor(localTimestamp / ONE_DAY_SECONDS) * ONE_DAY_SECONDS - LOCAL_TIME_OFFSET
end

SeasonSLGTimeEventMgr.GetDailyRecordTodayTriggerTime = function(nowTime)
    return SeasonSLGTimeEventMgr.GetDailyRecordDayStartTime(nowTime) + DAILY_RECORD_POPUP_HOUR * 3600
end

SeasonSLGTimeEventMgr.GetDailyRecordPeriodStartTime = function(nowTime)
    nowTime = tonumber(nowTime) or LuaMgr.Timestamp()
    local todayTriggerTime = SeasonSLGTimeEventMgr.GetDailyRecordTodayTriggerTime(nowTime)
    if nowTime >= todayTriggerTime then
        return todayTriggerTime
    end
    return todayTriggerTime - ONE_DAY_SECONDS
end

SeasonSLGTimeEventMgr.GetDailyRecordPeriodId = function(nowTime)
    local periodStartTime = SeasonSLGTimeEventMgr.GetDailyRecordPeriodStartTime(nowTime)
    return os.date("!%Y%m%d", periodStartTime + LOCAL_TIME_OFFSET)
end

SeasonSLGTimeEventMgr.GetNextDailyRecordPopupTime = function(nowTime)
    nowTime = tonumber(nowTime) or LuaMgr.Timestamp()
    local todayTriggerTime = SeasonSLGTimeEventMgr.GetDailyRecordTodayTriggerTime(nowTime)
    if nowTime < todayTriggerTime then
        return todayTriggerTime
    end
    return todayTriggerTime + ONE_DAY_SECONDS
end

SeasonSLGTimeEventMgr.GetDailyRecordPopupDelay = function(nowTime)
    nowTime = tonumber(nowTime) or LuaMgr.Timestamp()
    return math.max(1, SeasonSLGTimeEventMgr.GetNextDailyRecordPopupTime(nowTime) - nowTime)
end

SeasonSLGTimeEventMgr.GetFirstDailyRecordPopupTime = function()
    local activityStartTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    if activityStartTime == nil then
        local seasonConfig = SeasonSLGTimeEventMgr.GetCurrentSeasonalConfig()
        activityStartTime = seasonConfig ~= nil and tonumber(seasonConfig.OpenTime) or nil
    end
    if activityStartTime == nil then
        return nil
    end

    local todayTriggerTime = SeasonSLGTimeEventMgr.GetDailyRecordTodayTriggerTime(activityStartTime)
    if activityStartTime <= todayTriggerTime then
        return todayTriggerTime
    end
    return todayTriggerTime + ONE_DAY_SECONDS
end

SeasonSLGTimeEventMgr.CheckDailyRecordPopupPeriodAvailable = function(nowTime)
    local firstPopupTime = SeasonSLGTimeEventMgr.GetFirstDailyRecordPopupTime()
    if firstPopupTime == nil then
        return false
    end
    return SeasonSLGTimeEventMgr.GetDailyRecordPeriodStartTime(nowTime) >= firstPopupTime
end

SeasonSLGTimeEventMgr.GetDailyRecordPopupRecordKey = function(periodId)
    local uid = ""
    if DataMgr ~= nil and DataMgr.Player ~= nil then
        uid = DataMgr.Player.uid or ""
    end
    local seasonId = SeasonSLGTimeEventMgr.GetCurSeasonId() or ""
    return string.format("%s_SeasonSLGDailyRecordPopup_%s_%s", tostring(uid), tostring(seasonId), tostring(periodId or ""))
end

SeasonSLGTimeEventMgr.CheckDailyRecordPopupShown = function(periodId)
    local key = SeasonSLGTimeEventMgr.GetDailyRecordPopupRecordKey(periodId)
    return PlayerPrefs.GetString(key, "") == "1"
end

SeasonSLGTimeEventMgr.SetDailyRecordPopupShown = function(periodId)
    local key = SeasonSLGTimeEventMgr.GetDailyRecordPopupRecordKey(periodId)
    PlayerPrefs.SetString(key, "1")
    PlayerPrefs.Save()
end

SeasonSLGTimeEventMgr.CanShowDailyRecordPopup = function(nowTime)
    nowTime = tonumber(nowTime) or LuaMgr.Timestamp()
    if SeasonSLGTimeEventMgr.GetCurrentSeasonalConfig() == nil then
        return false, nil
    end
    if SeasonSLGMapMgr.curSeasonal == nil then
        SeasonSLGMapMgr.CheckSeasonalData()
    end
    if SeasonSLGTimeEventMgr.GetCurSeasonId() == nil then
        return false, nil
    end
    if not SeasonSLGTimeEventMgr.CheckDailyRecordPopupPeriodAvailable(nowTime) then
        return false, nil
    end

    local periodId = SeasonSLGTimeEventMgr.GetDailyRecordPeriodId(nowTime)
    if SeasonSLGTimeEventMgr.CheckDailyRecordPopupShown(periodId) then
        return false, periodId
    end
    return true, periodId
end

SeasonSLGTimeEventMgr.TryShowDailyRecordPopup = function(nowTime)
    local canShow, periodId = SeasonSLGTimeEventMgr.CanShowDailyRecordPopup(nowTime)
    if not canShow then
        return false
    end

    if SeasonSLGMapMgr.CheckGuideIsFinish() == false then
        return false
    end

    local panelName = UIName ~= nil and UIName.SeasonSLGDailyRecordPopupViewModel or "SeasonSLGDailyRecordPopupViewModel"
    if LuaMgr.IsPanelOpen(panelName) then
        return false
    end

    SeasonSLGTimeEventMgr.SetDailyRecordPopupShown(periodId)
    LuaMgr.ShowLuaPanel(panelName)
    return true
end

SeasonSLGTimeEventMgr.CheckSeasonId = function(configSeasonId)
    local seasonId = SeasonSLGTimeEventMgr.GetCurSeasonId()
    if seasonId == nil or configSeasonId == nil then
        return false
    end
    return tostring(configSeasonId) == tostring(seasonId)
end

SeasonSLGTimeEventMgr.InitSeasonConfigList = function()
    SeasonSLGTimeEventMgr.timedEventList = SeasonSLGTimeEventMgr.GetSeasonConfigList(ConfigMgr.Config.SeasonalTimedEventMap, "SeasonId")
    SeasonSLGTimeEventMgr.noticeList = SeasonSLGTimeEventMgr.GetSeasonConfigList(ConfigMgr.Config.SeasonalNoticeMap, "SeasonalID")
    SeasonSLGTimeEventMgr.progressList = SeasonSLGTimeEventMgr.GetSeasonConfigList(ConfigMgr.Config.SeasonalProgress, "SeasonalID")
    table.sort(SeasonSLGTimeEventMgr.progressList, function(a, b)
        return SeasonSLGTimeEventMgr.GetProgressEventTime(a) < SeasonSLGTimeEventMgr.GetProgressEventTime(b)
    end)
end

SeasonSLGTimeEventMgr.GetSeasonConfigList = function(configList, seasonField)
    local result = {}
    if configList == nil then
        return result
    end
    for i, v in pairs(configList) do
        if SeasonSLGTimeEventMgr.CheckSeasonId(v[seasonField]) then
            table.insert(result, v)
        end
    end
    return result
end

SeasonSLGTimeEventMgr.OnHeartBeat = function()
    SeasonSLGTimeEventMgr.CheckTimeEvent()
end

SeasonSLGTimeEventMgr.CheckTimeEvent = function()
    if SeasonSLGTimeEventMgr.activityInfo == nil then
        return
    end
    local nowTime = LuaMgr.Timestamp()

    SeasonSLGTimeEventMgr.UpdateWorldProgress(nowTime)
    SeasonSLGTimeEventMgr.CheckTimedEvent(nowTime)
    SeasonSLGTimeEventMgr.CheckTimedEventEnd(nowTime)
    SeasonSLGTimeEventMgr.CheckNoticeEndEvent(nowTime)

    SeasonSLGTimeEventMgr.CheckEventNotice(nowTime)
    SeasonSLGTimeEventMgr.CheckNoticeEvent(nowTime)
    SeasonSLGTimeEventMgr.ScheduleNextCheck(nowTime)
end

SeasonSLGTimeEventMgr.GetProgressEventTime = function(config)
    return (tonumber(config.Day) or 0) * 24 * 60 * 60 + (tonumber(config.Hour) or 0) * 60 * 60
end

SeasonSLGTimeEventMgr.CalculateWorldProgress = function(nowTime)
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    if startTime == nil then
        return SeasonSLGTimeEventMgr.worldProgress or 0, nil, nil
    end
    local progressConfig = SeasonSLGTimeEventMgr.progressList
    if progressConfig == nil or #progressConfig == 0 then
        return SeasonSLGTimeEventMgr.worldProgress or 0, nil, nil
    end

    local passTime = nowTime - startTime
    local curProgress = 0
    local curConfig = nil
    local curEventTime = -1
    for i, v in pairs(progressConfig) do
        local eventTime = SeasonSLGTimeEventMgr.GetProgressEventTime(v)
        if passTime >= eventTime and eventTime >= curEventTime then
            curProgress = tonumber(v.Progress) or 0
            curConfig = v
            curEventTime = eventTime
        end
    end
    return curProgress, curConfig, curEventTime
end

SeasonSLGTimeEventMgr.UpdateWorldProgress = function(nowTime)
    local curProgress, curConfig = SeasonSLGTimeEventMgr.CalculateWorldProgress(nowTime)
    if curProgress ~= SeasonSLGTimeEventMgr.worldProgress then
        SeasonSLGTimeEventMgr.worldProgress = curProgress
        SeasonSLGTimeEventMgr.OnWorldProgressChange(curProgress, curConfig)
    end
end

SeasonSLGTimeEventMgr.CheckTimedEvent = function(nowTime)
    local configMap = SeasonSLGTimeEventMgr.timedEventList
    if configMap == nil or #configMap == 0 then
        return
    end
    for i, v in pairs(configMap) do
        if not SeasonSLGTimeEventMgr.triggerEventMap[v.Id] then
            if SeasonSLGTimeEventMgr.CheckEventTrigger(v, nowTime) then
                SeasonSLGTimeEventMgr.triggerEventMap[v.Id] = true
                SeasonSLGTimeEventMgr.triggerEventTimeMap[v.Id] = nowTime
                SeasonSLGTimeEventMgr.AddTimedEventEnd(v)
                SeasonSLGTimeEventMgr.OnTimedEventTrigger(v)
            end
        end
    end
end

SeasonSLGTimeEventMgr.AddTimedEventEnd = function(config)
    local endTime = SeasonSLGTimeEventMgr.GetTimedEventEndTime(config)
    if endTime == nil then
        return
    end
    SeasonSLGTimeEventMgr.triggerEventEndTimeMap[config.Id] = endTime
    SeasonSLGTimeEventMgr.triggerEventEndConfigMap[config.Id] = config
end

SeasonSLGTimeEventMgr.GetTimedEventDuration = function(config)
    if config == nil then
        return 0
    end
    return tonumber(config.DurationSec) or 0
end

SeasonSLGTimeEventMgr.GetTimedEventEndTime = function(config)
    local duration = SeasonSLGTimeEventMgr.GetTimedEventDuration(config)
    if duration <= 0 then
        return nil
    end
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    local triggerTime = SeasonSLGTimeEventMgr.GetTimedEventTriggerTime(config)
    if startTime == nil or triggerTime == nil then
        return nil
    end
    return startTime + triggerTime + duration
end

SeasonSLGTimeEventMgr.GetTimedEventRefreshIntervals=function(timedProgressData)
    if timedProgressData == nil or timedProgressData.Config == nil then
        return {0, 0}
    end
    local debuff = timedProgressData.Config.SeasonalPersonalDeBuff
    if type(debuff) ~= "table" then
        return {0, 0}
    end
    local intervals={}
    local lastData = debuff[#debuff][1]
    intervals[1] = lastData or 0
    intervals[2] = lastData or 0
    return intervals
end


SeasonSLGTimeEventMgr.GetTimedEventInterval=function(timedProgressData,intervals)
    if timedProgressData==nil then
        return {}
    end
    if intervals == nil then
       intervals = SeasonSLGTimeEventMgr.GetTimedEventRefreshIntervals(timedProgressData)
    end
    local attackId=timedProgressData.TimeEventID
    local attackConfig=ConfigMgr.Config.SeasonalGridWorldAttackMap[attackId]
    local endTimeInterval=intervals[1]
    local stepTimeInterval={}
    if attackConfig~=nil then
        if attackConfig.ShowIcon == 1 then
            endTimeInterval = intervals[2]
        end
        for i = 1, #attackConfig.SeasonalPersonalDeBuff do
            local debuffData = attackConfig.SeasonalPersonalDeBuff[i]
            table.insert(stepTimeInterval,#stepTimeInterval+1,debuffData[1])
        end
        table.insert(stepTimeInterval,#stepTimeInterval+1,endTimeInterval)
    end
    local fallbackTime=timedProgressData.BatchStartTime or LuaMgr.Timestamp()
    local mapStateData=SeasonSLGMapMgr.MapStateData or {}
    local worldAttackStartTime=mapStateData.WorldAttackStartTime or {}
    local startTime=worldAttackStartTime[1] or fallbackTime
    if attackConfig~=nil and attackConfig.ShowIcon==1 then
        startTime=worldAttackStartTime[2] or fallbackTime
    end
    return stepTimeInterval,startTime
end



SeasonSLGTimeEventMgr.CheckTimedEventExpired = function(config, nowTime)
    local endTime = SeasonSLGTimeEventMgr.GetTimedEventEndTime(config)
    return endTime ~= nil and nowTime > endTime
end

SeasonSLGTimeEventMgr.CheckTimedEventEnd = function(nowTime)
    local endEventIds = {}
    for id, endTime in pairs(SeasonSLGTimeEventMgr.triggerEventEndTimeMap) do
        if not SeasonSLGTimeEventMgr.triggerEventEndMap[id] and nowTime >= endTime then
            table.insert(endEventIds, id)
        end
    end
    for i = 1, #endEventIds do
        local id = endEventIds[i]
        if not SeasonSLGTimeEventMgr.triggerEventEndMap[id] and SeasonSLGTimeEventMgr.triggerEventEndTimeMap[id] ~= nil then
            local eventConfig = SeasonSLGTimeEventMgr.triggerEventEndConfigMap[id]
            SeasonSLGTimeEventMgr.triggerEventEndMap[id] = true
            SeasonSLGTimeEventMgr.triggerEventEndTimeMap[id] = nil
            SeasonSLGTimeEventMgr.triggerEventEndConfigMap[id] = nil
            SeasonSLGTimeEventMgr.OnTimedEventEnd(eventConfig)
        end
    end
end

SeasonSLGTimeEventMgr.ScheduleNextCheck = function(nowTime)
    LuaMgr.RemoveTimer(TimerConst.SeasonSLGTimeEvent)
    local delay = SeasonSLGTimeEventMgr.GetNextCheckDelay(nowTime)
    if delay ~= nil and delay > 0 then
        LuaMgr.AddTimer(TimerConst.SeasonSLGTimeEvent, SeasonSLGTimeEventMgr.OnTimerCheck, delay, 1, false)
    end
end

SeasonSLGTimeEventMgr.OnTimerCheck = function()
    SeasonSLGTimeEventMgr.CheckTimeEvent()
end


SeasonSLGTimeEventMgr.GetNoticePara = function(config, index)
    if config == nil then
        return nil
    end
    index = index or 1
    local noticePara = config.NoticePara
    if type(noticePara) == "table" then
        return noticePara[index]
    end
    if index == 1 then
        return noticePara
    end
    return nil
end



SeasonSLGTimeEventMgr.TriggerMisinterNotice = function(nowTime, batchKey, recordTime)
    local noticeMap = SeasonSLGTimeEventMgr.noticeList
    if noticeMap == nil then
        return
    end
    local triggerConfig = nil
    local triggerTime = nil
    for _, noticeConfig in pairs(noticeMap) do
        local noticePara = SeasonSLGTimeEventMgr.GetNoticePara(noticeConfig, 0)
        if noticePara == nil then
            noticePara = SeasonSLGTimeEventMgr.GetNoticePara(noticeConfig, 1)
        end
        if tostring(noticeConfig.NoticeTimeType) == "5" and tonumber(noticePara) == 0 then
            triggerConfig, triggerTime = SeasonSLGTimeEventMgr.SelectNoticeByPriority(triggerConfig, triggerTime, noticeConfig, nowTime or LuaMgr.Timestamp())
        end
    end
    if triggerConfig ~= nil then


        SeasonSLGTimeEventMgr.misinterHandledBatchMap = SeasonSLGTimeEventMgr.misinterHandledBatchMap or {}
        if batchKey ~= nil then
            if SeasonSLGTimeEventMgr.misinterHandledBatchMap[batchKey] == true then
                return false
            end
            SeasonSLGTimeEventMgr.misinterHandledBatchMap[batchKey] = true
        end


        SeasonSLGTimeEventMgr.AddNoticeRecord(triggerConfig,
                SeasonSLGTimeEventMgr.GetNoticeEventRecordTime("5", { batchStartTime = recordTime }),
                batchKey)
        if batchKey ~= nil then
            SeasonSLGTimeEventMgr.misinterNoticeBatchMap = SeasonSLGTimeEventMgr.misinterNoticeBatchMap or {}
            local lastBatchKey = SeasonSLGTimeEventMgr.misinterNoticeBatchMap[triggerConfig.Id]
            if lastBatchKey ~= batchKey then
                SeasonSLGTimeEventMgr.noticeTriggerMap[triggerConfig.Id] = nil
                SeasonSLGTimeEventMgr.noticeEndMap[triggerConfig.Id] = nil
                SeasonSLGTimeEventMgr.noticeTriggerTimeMap[triggerConfig.Id] = nil
                SeasonSLGTimeEventMgr.misinterNoticeBatchMap[triggerConfig.Id] = batchKey
            end
        end
        local isTrigger = SeasonSLGTimeEventMgr.TriggerNotice(triggerConfig, nowTime or LuaMgr.Timestamp(), nil, triggerTime)
        if not isTrigger then

            return false
        end
        return true
    end
    return false
end

SeasonSLGTimeEventMgr.GetNoticeShowRank = function(config)
    if config == nil then
        return 999999
    end
    return tonumber(config.NoticeShowRank) or 999999
end



SeasonSLGTimeEventMgr.SelectNoticeByPriority = function(activeConfig, activeTriggerTime, config, triggerTime, byTimeFirst)
    if config == nil or triggerTime == nil then
        return activeConfig, activeTriggerTime
    end
    if activeConfig == nil then
        return config, triggerTime
    end
    if byTimeFirst then

        local newTriggerTime = tonumber(triggerTime)
        local oldTriggerTime = tonumber(activeTriggerTime)
        if newTriggerTime ~= nil and oldTriggerTime ~= nil and newTriggerTime ~= oldTriggerTime then
            if newTriggerTime > oldTriggerTime then
                return config, triggerTime
            end
            return activeConfig, activeTriggerTime
        end
        if SeasonSLGTimeEventMgr.GetNoticeShowRank(config) < SeasonSLGTimeEventMgr.GetNoticeShowRank(activeConfig) then
            return config, triggerTime
        end
        return activeConfig, activeTriggerTime
    end

    local configRank = SeasonSLGTimeEventMgr.GetNoticeShowRank(config)
    local activeRank = SeasonSLGTimeEventMgr.GetNoticeShowRank(activeConfig)
    if configRank ~= activeRank then
        if configRank < activeRank then
            return config, triggerTime
        end
        return activeConfig, activeTriggerTime
    end

    if activeTriggerTime == nil or triggerTime < activeTriggerTime then
        return config, triggerTime
    end
    return activeConfig, activeTriggerTime
end

SeasonSLGTimeEventMgr.GetNoticeConfigById = function(noticeId)
    if noticeId == nil then
        return nil
    end
    if SeasonSLGTimeEventMgr.noticeEndConfigMap[noticeId] ~= nil then
        return SeasonSLGTimeEventMgr.noticeEndConfigMap[noticeId]
    end
    if SeasonSLGTimeEventMgr.noticeRepeatConfigMap[noticeId] ~= nil then
        return SeasonSLGTimeEventMgr.noticeRepeatConfigMap[noticeId]
    end
    for i, config in pairs(SeasonSLGTimeEventMgr.noticeList or {}) do
        if tostring(config.Id) == tostring(noticeId) then
            return config
        end
    end
    return nil
end


SeasonSLGTimeEventMgr.CheckCanTriggerNotice = function(config)
    if config == nil then
        return false
    end
    local rank = SeasonSLGTimeEventMgr.GetNoticeShowRank(config)
    local nowTime = LuaMgr.Timestamp()
    for noticeId, isTrigger in pairs(SeasonSLGTimeEventMgr.noticeTriggerMap) do
        if isTrigger and tostring(noticeId) ~= tostring(config.Id) and not SeasonSLGTimeEventMgr.noticeEndMap[noticeId] then
            local activeConfig = SeasonSLGTimeEventMgr.GetNoticeConfigById(noticeId)
            if activeConfig ~= nil
                    and not SeasonSLGTimeEventMgr.CheckNoticeCurrentPlayExpired(activeConfig, nowTime)
                    and SeasonSLGTimeEventMgr.GetNoticeShowRank(activeConfig) <= rank then
                return false
            end
        end
    end
    return true
end




SeasonSLGTimeEventMgr.IsNoticeCommonCdType = function(config)
    if config == nil or tonumber(config.NoticeHome) ~= 1 then
        return false
    end
    local noticeTimeType = tonumber(config.NoticeTimeType)
    if noticeTimeType == nil then
        return false
    end
    return noticeTimeType >= 5 and noticeTimeType <= 9
end


SeasonSLGTimeEventMgr.GetNoticeCommonCd = function()
    local constants = SeasonSLGMapMgr.Constants()
    if constants == nil then
        return 0
    end
    return tonumber(constants.SeasonalNoticeTotalCd) or 0
end


SeasonSLGTimeEventMgr.CheckNoticeCommonCd = function(config, nowTime)
    if not SeasonSLGTimeEventMgr.IsNoticeCommonCdType(config) then
        return true
    end
    local cd = SeasonSLGTimeEventMgr.GetNoticeCommonCd()
    if cd <= 0 then
        return true
    end
    nowTime = nowTime or LuaMgr.Timestamp()
    SeasonSLGTimeEventMgr.EnsureNoticeLocalContext()
    local lastTime = tonumber(SeasonSLGTimeEventMgr.noticeCommonCdTime) or 0
    if lastTime <= 0 then

        lastTime = tonumber(SeasonSLGTimeEventMgr.GetNoticeLocalValue(NOTICE_FLAG_COMMON_CD)) or 0
        SeasonSLGTimeEventMgr.noticeCommonCdTime = lastTime
    end
    if lastTime > 0 and nowTime - lastTime < cd then
        return false
    end
    return true
end



SeasonSLGTimeEventMgr.SetNoticeCommonCd = function(nowTime)
    nowTime = nowTime or LuaMgr.Timestamp()
    SeasonSLGTimeEventMgr.noticeCommonCdTime = nowTime
    SeasonSLGTimeEventMgr.SetNoticeLocalValue(NOTICE_FLAG_COMMON_CD, nowTime)
end






SeasonSLGTimeEventMgr.GetWorldAttackStartTime = function(index)
    local mapStateData = SeasonSLGMapMgr.MapStateData
    if mapStateData == nil or mapStateData.WorldAttackStartTime == nil then
        return nil
    end
    return tonumber(mapStateData.WorldAttackStartTime[index])
end


SeasonSLGTimeEventMgr.GetServerEventTime = function()
    local mapStateData = SeasonSLGMapMgr.MapStateData
    if mapStateData == nil then
        return nil
    end
    return mapStateData.EventTime
end




SeasonSLGTimeEventMgr.GetNoticeLocalUid = function()
    if DataMgr.Player ~= nil and not IsNullOrEmpty(DataMgr.Player.uid) then
        return tostring(DataMgr.Player.uid)
    end
    return nil
end

SeasonSLGTimeEventMgr.GetNoticeLocalSeasonId = function()
    if SeasonSLGMapMgr.curSeasonal ~= nil and not IsNullOrEmpty(SeasonSLGMapMgr.curSeasonal.Id) then
        return tostring(SeasonSLGMapMgr.curSeasonal.Id)
    end
    return nil
end



SeasonSLGTimeEventMgr.EnsureNoticeLocalContext = function()
    local key = SeasonSLGTimeEventMgr.GetNoticeLocalRecordKey()
    if SeasonSLGTimeEventMgr.noticeLocalKey ~= key then
        SeasonSLGTimeEventMgr.noticeLocalKey = key
        SeasonSLGTimeEventMgr.noticeRecordLoaded = false
        SeasonSLGTimeEventMgr.noticeRecordList = nil
        SeasonSLGTimeEventMgr.noticeCommonCdTime = 0
        SeasonSLGTimeEventMgr.lastStaminaIsFull = false
        SeasonSLGTimeEventMgr.noticeBackfilled = false
    end
    if key == nil then
        if SeasonSLGTimeEventMgr.noticeLocalKeyWarned ~= true then
            SeasonSLGTimeEventMgr.noticeLocalKeyWarned = true
            LuaDebug.error("SeasonSLGTimeEventMgr: uid 或赛季未就绪，公告本地记录/标记读写已跳过")
        end
        return nil
    end
    return key
end



SeasonSLGTimeEventMgr.GetNoticeLocalRecordKey = function()
    local uid = SeasonSLGTimeEventMgr.GetNoticeLocalUid()
    local seasonId = SeasonSLGTimeEventMgr.GetNoticeLocalSeasonId()
    if uid == nil or seasonId == nil then
        return nil
    end
    return string.format("%s_SeasonSLGNoticeRecord_%s", uid, seasonId)
end

SeasonSLGTimeEventMgr.LoadNoticeRecordList = function()
    local key = SeasonSLGTimeEventMgr.EnsureNoticeLocalContext()
    if key == nil then
        return {}
    end
    if SeasonSLGTimeEventMgr.noticeRecordLoaded and SeasonSLGTimeEventMgr.noticeRecordList ~= nil then
        return SeasonSLGTimeEventMgr.noticeRecordList
    end
    local list = {}
    local recordStr = PlayerPrefs.GetString(key, "")
    if not IsNullOrEmpty(recordStr) then

        local ok, records = pcall(json.decode, recordStr)
        if ok and type(records) == "table" then
            list = records
        end
    end
    SeasonSLGTimeEventMgr.noticeRecordLoaded = true
    SeasonSLGTimeEventMgr.noticeRecordList = list
    return list
end

SeasonSLGTimeEventMgr.SaveNoticeRecordList = function(list)
    local key = SeasonSLGTimeEventMgr.EnsureNoticeLocalContext()
    if key == nil then
        return
    end
    SeasonSLGTimeEventMgr.noticeRecordLoaded = true
    SeasonSLGTimeEventMgr.noticeRecordList = list or {}
    PlayerPrefs.SetString(key, json.encode(SeasonSLGTimeEventMgr.noticeRecordList))
    PlayerPrefs.Save()
end


SeasonSLGTimeEventMgr.GetNoticeFlagKey = function(name)
    if name == nil then
        return nil
    end
    local uid = SeasonSLGTimeEventMgr.GetNoticeLocalUid()
    local seasonId = SeasonSLGTimeEventMgr.GetNoticeLocalSeasonId()
    if uid == nil or seasonId == nil then
        return nil
    end
    return string.format("%s_SeasonSLGNoticeFlag_%s_%s", uid, seasonId, tostring(name))
end

SeasonSLGTimeEventMgr.GetNoticeFlag = function(name)
    if name == nil then
        return false
    end
    if SeasonSLGTimeEventMgr.EnsureNoticeLocalContext() == nil
            or SeasonSLGTimeEventMgr.GetNoticeFlagKey(name) == nil then
        return false
    end
    return PlayerPrefs.GetInt(SeasonSLGTimeEventMgr.GetNoticeFlagKey(name), 0) == 1
end

SeasonSLGTimeEventMgr.SetNoticeFlag = function(name, isOn)
    if name == nil then
        return
    end
    if SeasonSLGTimeEventMgr.EnsureNoticeLocalContext() == nil
            or SeasonSLGTimeEventMgr.GetNoticeFlagKey(name) == nil then
        return
    end
    PlayerPrefs.SetInt(SeasonSLGTimeEventMgr.GetNoticeFlagKey(name), isOn == true and 1 or 0)
    PlayerPrefs.Save()
end


SeasonSLGTimeEventMgr.GetNoticeLocalValue = function(name)
    if name == nil then
        return nil
    end
    if SeasonSLGTimeEventMgr.EnsureNoticeLocalContext() == nil
            or SeasonSLGTimeEventMgr.GetNoticeFlagKey(name) == nil then
        return nil
    end
    local value = PlayerPrefs.GetString(SeasonSLGTimeEventMgr.GetNoticeFlagKey(name), "")
    if IsNullOrEmpty(value) then
        return nil
    end
    return value
end

SeasonSLGTimeEventMgr.SetNoticeLocalValue = function(name, value)
    if name == nil then
        return
    end
    if SeasonSLGTimeEventMgr.EnsureNoticeLocalContext() == nil
            or SeasonSLGTimeEventMgr.GetNoticeFlagKey(name) == nil then
        return
    end
    if value == nil then
        PlayerPrefs.DeleteKey(SeasonSLGTimeEventMgr.GetNoticeFlagKey(name))
    else
        PlayerPrefs.SetString(SeasonSLGTimeEventMgr.GetNoticeFlagKey(name), tostring(value))
    end
    PlayerPrefs.Save()
end




SeasonSLGTimeEventMgr.ClearDirtyNoticeLocalKeys = function()
    local dirtyUidPrefixs = { "nil_", "_" }
    local flagNames = { NOTICE_FLAG_COMMON_CD, NOTICE_FLAG_STAMINA_FULL }
    local seasonIds = { "" }
    if ConfigMgr.Config ~= nil and ConfigMgr.Config.SeasonalMap ~= nil then
        for _, seasonalConfig in pairs(ConfigMgr.Config.SeasonalMap) do
            if seasonalConfig ~= nil and not IsNullOrEmpty(seasonalConfig.Id) then
                table.insert(seasonIds, tostring(seasonalConfig.Id))
            end
        end
    end
    local isDelete = false
    for _, uidPrefix in ipairs(dirtyUidPrefixs) do
        for _, seasonId in ipairs(seasonIds) do
            local recordKey = string.format("%s_SeasonSLGNoticeRecord_%s", uidPrefix, seasonId)
            if PlayerPrefs.HasKey(recordKey) then
                PlayerPrefs.DeleteKey(recordKey)
                isDelete = true
            end
            for _, flagName in ipairs(flagNames) do
                local flagKey = string.format("%s_SeasonSLGNoticeFlag_%s_%s", uidPrefix, seasonId, flagName)
                if PlayerPrefs.HasKey(flagKey) then
                    PlayerPrefs.DeleteKey(flagKey)
                    isDelete = true
                end
            end
        end
    end
    if isDelete then
        PlayerPrefs.Save()
    end
end


SeasonSLGTimeEventMgr.HasNoticeRecord = function(noticeTimeType, recordTime)
    if noticeTimeType == nil or recordTime == nil then
        return false
    end
    local list = SeasonSLGTimeEventMgr.LoadNoticeRecordList()
    for i = #list, 1, -1 do
        local record = list[i]
        if record ~= nil and tostring(record.type) == tostring(noticeTimeType)
                and tonumber(record.time) == tonumber(recordTime) then
            return true
        end
    end
    return false
end



SeasonSLGTimeEventMgr.GetNoticeRecordTime = function(noticeTimeType)
    if noticeTimeType == nil then
        return nil
    end
    local list = SeasonSLGTimeEventMgr.LoadNoticeRecordList()
    for i = #list, 1, -1 do
        local record = list[i]
        if record ~= nil and tostring(record.type) == tostring(noticeTimeType) then
            return tonumber(record.time)
        end
    end
    return nil
end


SeasonSLGTimeEventMgr.HasNoticeRecordKey = function(dedupeKey)
    if dedupeKey == nil then
        return false
    end
    local list = SeasonSLGTimeEventMgr.LoadNoticeRecordList()
    for i = #list, 1, -1 do
        local record = list[i]
        if record ~= nil and record.key ~= nil and tostring(record.key) == tostring(dedupeKey) then
            return true
        end
    end
    return false
end








SeasonSLGTimeEventMgr.AddNoticeRecord = function(config, recordTime, dedupeKey)
    if config == nil or recordTime == nil then
        return
    end
    local list = SeasonSLGTimeEventMgr.LoadNoticeRecordList()
    local noticeType = tostring(config.NoticeTimeType)
    for i = #list, 1, -1 do
        local record = list[i]
        if record ~= nil then

            if dedupeKey ~= nil and record.key ~= nil and tostring(record.key) == tostring(dedupeKey) then
                return
            end
            if NOTICE_RECORD_UNIQUE_TYPES[noticeType] == true and tostring(record.type) == noticeType then

                if tonumber(record.time) == tonumber(recordTime) then
                    return
                end
                table.remove(list, i)
                break
            end
        end
    end
    table.insert(list, {
        id = config.Id,
        type = noticeType,
        time = recordTime,
        key = dedupeKey,
    })
    while #list > NOTICE_RECORD_MAX do
        table.remove(list, 1)
    end
    SeasonSLGTimeEventMgr.SaveNoticeRecordList(list)
end


SeasonSLGTimeEventMgr.GetNoticeRecordList = function()
    local list = SeasonSLGTimeEventMgr.LoadNoticeRecordList()
    table.sort(list, function(a, b)
        return (tonumber(a.time) or 0) < (tonumber(b.time) or 0)
    end)
    return list
end


SeasonSLGTimeEventMgr.FormatNoticeRecordTime = function(triggerTime)
    return os.date(NOTICE_RECORD_TIME_FORMAT, (tonumber(triggerTime) or 0) + LOCAL_TIME_OFFSET)
end





SeasonSLGTimeEventMgr.CheckNoticeSend = function(config)
    if config == nil then
        return false
    end
    return tonumber(config.NoticeSend) == 1
end






SeasonSLGTimeEventMgr.GetNoticeTriggerTimePoints = function(config, nowTime)
    local points = {}
    if config == nil then
        return points
    end
    nowTime = tonumber(nowTime) or LuaMgr.Timestamp()
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    if startTime == nil then
        return points
    end
    local noticeTimeType = tostring(config.NoticeTimeType)
    if noticeTimeType == "1" then
        local triggerTime = startTime + (tonumber(SeasonSLGTimeEventMgr.GetNoticePara(config, 1)) or 0)
        if nowTime >= triggerTime then
            table.insert(points, triggerTime)
        end
    elseif noticeTimeType == "3" then
        local openDay = tonumber(SeasonSLGTimeEventMgr.GetNoticePara(config, 1)) or 0
        if openDay > 0 then
            local triggerTime = startTime + (openDay - 1) * ONE_DAY_SECONDS
            if nowTime >= triggerTime then
                table.insert(points, triggerTime)
            end
        end
    elseif noticeTimeType == "2" then
        local timedEventConfig = SeasonSLGTimeEventMgr.GetNoticeTimedEventConfig(config)
        if timedEventConfig ~= nil then
            local eventTriggerTime = SeasonSLGTimeEventMgr.GetTimedEventTriggerTime(timedEventConfig)
            local firstWindowStart = startTime + (tonumber(eventTriggerTime) or 0)
            if nowTime >= firstWindowStart then

                local lastTime = nowTime
                local eventEndTime = SeasonSLGTimeEventMgr.GetTimedEventEndTime(timedEventConfig)
                if eventEndTime ~= nil and eventEndTime < lastTime then
                    lastTime = eventEndTime
                end
                local duration = SeasonSLGTimeEventMgr.GetNoticeDuration(config)
                local interval = SeasonSLGTimeEventMgr.GetNoticeRepeatInterval(config)
                if duration <= 0 or interval <= 0 then

                    table.insert(points, firstWindowStart)
                else
                    local cycleTime = duration + interval
                    local pointCount = 0
                    local windowStart = firstWindowStart
                    while windowStart <= lastTime and pointCount < NOTICE_OVERVIEW_MAX_POINTS do
                        table.insert(points, windowStart)
                        pointCount = pointCount + 1
                        windowStart = windowStart + cycleTime
                    end
                end
            end
        end
    end
    return points
end





SeasonSLGTimeEventMgr.GetNoticeOverviewList = function()
    local result = {}
    local addedMap = {}
    local noticeMap = ConfigMgr.Config.SeasonalNoticeMap


    if noticeMap ~= nil and SeasonSLGTimeEventMgr.GetNoticeRecordList ~= nil then
        local recordList = SeasonSLGTimeEventMgr.GetNoticeRecordList()
        for i = 1, #recordList do
            local record = recordList[i]
            if record ~= nil and record.id ~= nil then
                local noticeConfig = noticeMap[tostring(record.id)] or noticeMap[record.id]
                if SeasonSLGTimeEventMgr.CheckNoticeSend(noticeConfig) then
                    local time = tonumber(record.time) or 0
                    local key = tostring(noticeConfig.Id) .. "_" .. tostring(time)
                    if addedMap[key] == nil then
                        addedMap[key] = true
                        table.insert(result, { config = noticeConfig, time = time })
                    end
                end
            end
        end
    end


    local nowTime = LuaMgr.Timestamp()
    local noticeList = SeasonSLGTimeEventMgr.noticeList
    if noticeList ~= nil then
        for i = 1, #noticeList do
            local noticeConfig = noticeList[i]
            if SeasonSLGTimeEventMgr.CheckNoticeSend(noticeConfig) then
                local timeType = tostring(noticeConfig.NoticeTimeType)
                if timeType == "1" or timeType == "2" or timeType == "3" then
                    local points = SeasonSLGTimeEventMgr.GetNoticeTriggerTimePoints(noticeConfig, nowTime)
                    for j = 1, #points do
                        local time = points[j]
                        local key = tostring(noticeConfig.Id) .. "_" .. tostring(time)
                        if addedMap[key] == nil then
                            addedMap[key] = true
                            table.insert(result, { config = noticeConfig, time = time })
                        end
                    end
                end
            end
        end
    end

    table.sort(result, function(a, b)
        local timeA = tonumber(a.time) or 0
        local timeB = tonumber(b.time) or 0
        if timeA ~= timeB then
            return timeA > timeB
        end
        return tostring(a.config.Id) < tostring(b.config.Id)
    end)
    return result
end




SeasonSLGTimeEventMgr.GetNoticeDesc = function(config)
    if config == nil then
        return ""
    end
    if not IsNullOrEmpty(config.DescLan) then
        return LuaMgr.GetLangText(config.DescLan)
    end
    return config.Desc or ""
end







SeasonSLGTimeEventMgr.GetNoticeEventRecordTime = function(noticeTimeType, ctx)
    local noticeType = tostring(noticeTimeType)
    if noticeType == "5" then
        if ctx ~= nil and tonumber(ctx.batchStartTime) ~= nil then
            return tonumber(ctx.batchStartTime)
        end
        return SeasonSLGTimeEventMgr.GetWorldAttackStartTime(2)
                or SeasonSLGTimeEventMgr.GetWorldAttackStartTime(1)
                or LuaMgr.Timestamp()
    elseif noticeType == "6" then
        if ctx ~= nil and tonumber(ctx.killTime) ~= nil then
            return tonumber(ctx.killTime)
        end
        local serverEventTime = SeasonSLGTimeEventMgr.GetServerEventTime()
        if serverEventTime ~= nil and tonumber(serverEventTime.WorldAttackBossCompleteTime) ~= nil then
            return tonumber(serverEventTime.WorldAttackBossCompleteTime)
        end
    elseif noticeType == "7" then
        if ctx ~= nil and tonumber(ctx.produceTime) ~= nil then
            return tonumber(ctx.produceTime)
        end
    elseif noticeType == "8" then
        if ctx ~= nil and tonumber(ctx.fullTime) ~= nil then
            return tonumber(ctx.fullTime)
        end
    elseif noticeType == "9" then
        if ctx ~= nil and ctx.buildId ~= nil then
            local serverEventTime = SeasonSLGTimeEventMgr.GetServerEventTime()
            if serverEventTime ~= nil and type(serverEventTime.WorldBuildCompleteTime) == "table" then
                local buildTime = tonumber(serverEventTime.WorldBuildCompleteTime[tostring(ctx.buildId)])
                if buildTime ~= nil then
                    return buildTime
                end
            end
        end
    end
    return LuaMgr.Timestamp()
end








SeasonSLGTimeEventMgr.TriggerEventNotice = function(noticeTimeType, dedupeKey, recordTime)
    if dedupeKey == nil or SeasonSLGTimeEventMgr.noticeList == nil then
        return false
    end
    local nowTime = LuaMgr.Timestamp()
    recordTime = tonumber(recordTime) or nowTime
    local triggerConfig = nil
    local triggerTime = nil
    for _, noticeConfig in pairs(SeasonSLGTimeEventMgr.noticeList) do
        if tostring(noticeConfig.NoticeTimeType) == tostring(noticeTimeType) then
            triggerConfig, triggerTime = SeasonSLGTimeEventMgr.SelectNoticeByPriority(triggerConfig, triggerTime, noticeConfig, nowTime)
        end
    end
    if triggerConfig == nil then
        return false
    end
    SeasonSLGTimeEventMgr.noticeEventKeyMap = SeasonSLGTimeEventMgr.noticeEventKeyMap or {}
    if SeasonSLGTimeEventMgr.noticeEventKeyMap[triggerConfig.Id] == dedupeKey then
        return false
    end


    SeasonSLGTimeEventMgr.AddNoticeRecord(triggerConfig, recordTime, dedupeKey)

    if not SeasonSLGTimeEventMgr.CheckCanTriggerNotice(triggerConfig) then
        return false
    end

    SeasonSLGTimeEventMgr.noticeTriggerMap[triggerConfig.Id] = nil
    SeasonSLGTimeEventMgr.noticeEndMap[triggerConfig.Id] = nil
    SeasonSLGTimeEventMgr.noticeTriggerTimeMap[triggerConfig.Id] = nil
    SeasonSLGTimeEventMgr.noticeEndTimeMap[triggerConfig.Id] = nil
    SeasonSLGTimeEventMgr.noticeEndConfigMap[triggerConfig.Id] = nil

    if not SeasonSLGTimeEventMgr.TriggerNotice(triggerConfig, nowTime, nil, nowTime) then
        return false
    end
    SeasonSLGTimeEventMgr.noticeEventKeyMap[triggerConfig.Id] = dedupeKey
    return true
end



SeasonSLGTimeEventMgr.CheckMisinterBossCompleteNotice = function(nowTime)
    local serverEventTime = SeasonSLGTimeEventMgr.GetServerEventTime()
    if serverEventTime == nil then
        return false
    end
    local killTime = tonumber(serverEventTime.WorldAttackBossCompleteTime)
    if killTime == nil or killTime <= 0 then
        return false
    end

    local spawnTime = SeasonSLGTimeEventMgr.GetWorldAttackStartTime(2)
            or SeasonSLGTimeEventMgr.GetWorldAttackStartTime(1)
    if spawnTime ~= nil and spawnTime >= killTime then
        return false
    end
    if SeasonSLGTimeEventMgr.HasNoticeRecord("6", killTime) then
        return false
    end
    return SeasonSLGTimeEventMgr.TriggerEventNotice("6", "worldattackboss_" .. killTime, killTime)
end


SeasonSLGTimeEventMgr.CheckDispatchCompleteNotice = function(nowTime)
    if DataMgr.Player == nil then
        return false
    end
    local isTrigger = SeasonSLGTimeEventMgr.CheckDispatchCompleteNoticeByMap(DataMgr.Player.SeasonalResource, "resource")
    isTrigger = SeasonSLGTimeEventMgr.CheckDispatchCompleteNoticeByMap(DataMgr.Player.SeasonalWorldGuard, "worldguard") or isTrigger
    return isTrigger
end

SeasonSLGTimeEventMgr.CheckDispatchCompleteNoticeByMap = function(dispatchMap, tag)
    if type(dispatchMap) ~= "table" then
        return false
    end
    local isTrigger = false
    for gridId, dispatchData in pairs(dispatchMap) do
        if dispatchData ~= nil then
            local produceTime = tonumber(dispatchData.ProduceTime)
            if produceTime ~= nil and produceTime > 0
                    and SeasonSLGEventMgr.GetDisPatchStatus(dispatchData.Members, produceTime)
                            == SeasonSLGConst.SeasonSLGDispatchStatusDef.Dispatch_Reward then
                local dedupeKey = string.format("dispatch_%s_%s_%s", tag, tostring(gridId), tostring(produceTime))
                if not SeasonSLGTimeEventMgr.HasNoticeRecordKey(dedupeKey) then
                    isTrigger = SeasonSLGTimeEventMgr.TriggerEventNotice("7", dedupeKey, produceTime) or isTrigger
                end
            end
        end
    end
    return isTrigger
end

SeasonSLGTimeEventMgr.GetAllSeasonalDispatchLeft = function()
    local dispatchDic = {}
    local now = LuaMgr.Timestamp()
    local left = 0
    local checkDispatchMap = function(dispatchMap)
        if type(dispatchMap) ~= "table" then
            return
        end
        for _, dispatchInfo in pairs(dispatchMap) do
            if not IsNull(dispatchInfo) and type(dispatchInfo.Members) == "table" then
                local produceTime = tonumber(dispatchInfo.ProduceTime) or 0
                for _, memberId in pairs(dispatchInfo.Members) do
                    memberId = tostring(memberId)
                    local memberLeft = produceTime - now
                    if dispatchDic[memberId] then
                        if memberLeft > left then
                            left = memberLeft
                            dispatchDic[memberId] = memberLeft
                        end
                    else
                        dispatchDic[memberId] = memberLeft
                    end
                end
            end
        end
    end
    checkDispatchMap(DataMgr.Player.SeasonalResource)
    checkDispatchMap(DataMgr.Player.SeasonalWorldGuard)
    return dispatchDic
end





SeasonSLGTimeEventMgr.CheckStaminaFullNotice = function(nowTime)
    local constants = SeasonSLGMapMgr.Constants()
    if constants == nil or constants.SeasonalStaminaItem == nil then
        return false
    end
    local maxStamina = SeasonSLGMapMgr.GetSeasonalStaminaRecoverMax()
    if maxStamina <= 0 then
        return false
    end
    SeasonSLGTimeEventMgr.EnsureNoticeLocalContext()
    local curStamina = SeasonSLGTimeEventMgr.GetSeasonalStaminaCount()
    if curStamina < maxStamina then

        if SeasonSLGTimeEventMgr.lastStaminaIsFull == true
                or SeasonSLGTimeEventMgr.GetNoticeFlag(NOTICE_FLAG_STAMINA_FULL) then
            SeasonSLGTimeEventMgr.lastStaminaIsFull = false
            SeasonSLGTimeEventMgr.SetNoticeFlag(NOTICE_FLAG_STAMINA_FULL, false)
        end
        return false
    end
    if SeasonSLGTimeEventMgr.lastStaminaIsFull == true then
        return false
    end
    if SeasonSLGTimeEventMgr.GetNoticeFlag(NOTICE_FLAG_STAMINA_FULL) then
        SeasonSLGTimeEventMgr.lastStaminaIsFull = true
        return false
    end

    SeasonSLGTimeEventMgr.lastStaminaIsFull = true
    SeasonSLGTimeEventMgr.SetNoticeFlag(NOTICE_FLAG_STAMINA_FULL, true)
    local fullTime = SeasonSLGTimeEventMgr.GetSeasonalStaminaFullTime(curStamina, maxStamina)
    local dedupeKey = "stamina_" .. tostring(fullTime)
    if SeasonSLGTimeEventMgr.HasNoticeRecordKey(dedupeKey) then
        return false
    end
    return SeasonSLGTimeEventMgr.TriggerEventNotice("8", dedupeKey, fullTime)
end


SeasonSLGTimeEventMgr.GetSeasonalStaminaCount = function()
    local constants = SeasonSLGMapMgr.Constants()
    if constants == nil or constants.SeasonalStaminaItem == nil then
        return 0
    end
    return tonumber(DataHelper.GetItemCountById(constants.SeasonalStaminaItem)) or 0
end


SeasonSLGTimeEventMgr.GetSeasonalStaminaFullTime = function(curStamina, maxStamina)
    local constants = SeasonSLGMapMgr.Constants()
    local recoverMin = 0
    if constants ~= nil then
        recoverMin = tonumber(constants.SeasonalStaminaRecoverMin) or 0
    end
    local recoverInterval = recoverMin * 60
    local lastRecoverTime = 0
    if DataMgr.Player ~= nil then
        lastRecoverTime = tonumber(DataMgr.Player.SeasonalStaminaLastRecoverTime) or 0
    end
    if recoverInterval <= 0 or lastRecoverTime <= 0 then
        return LuaMgr.Timestamp()
    end
    local lackCount = maxStamina - curStamina
    if lackCount < 0 then
        lackCount = 0
    end
    return lastRecoverTime + lackCount * recoverInterval
end




SeasonSLGTimeEventMgr.CheckWorldBuildCompleteNotice = function(nowTime)
    local serverEventTime = SeasonSLGTimeEventMgr.GetServerEventTime()
    if serverEventTime == nil or type(serverEventTime.WorldBuildCompleteTime) ~= "table" then

        return SeasonSLGTimeEventMgr.CheckWorldBuildCompleteNoticeFallback(nowTime)
    end
    local isTrigger = false
    for buildId, completeTime in pairs(serverEventTime.WorldBuildCompleteTime) do
        local buildCompleteTime = tonumber(completeTime)
        if buildCompleteTime ~= nil and buildCompleteTime > 0 then
            local dedupeKey = "worldbuild_" .. tostring(buildId)
            if not SeasonSLGTimeEventMgr.HasNoticeRecordKey(dedupeKey) then
                isTrigger = SeasonSLGTimeEventMgr.TriggerEventNotice("9", dedupeKey, buildCompleteTime) or isTrigger
            end
        end
    end
    return isTrigger
end


SeasonSLGTimeEventMgr.CheckWorldBuildCompleteNoticeFallback = function(nowTime)
    if SeasonSLGMapMgr.WorldBuildGridMap == nil then
        return false
    end
    local isTrigger = false
    for gridId, cfgGrid in pairs(SeasonSLGMapMgr.WorldBuildGridMap) do
        if cfgGrid ~= nil and not IsNullOrEmpty(cfgGrid.Function) and #cfgGrid.Function >= 2 then
            local dedupeKey = "worldbuild_" .. tostring(cfgGrid.Function[2])
            if not SeasonSLGTimeEventMgr.HasNoticeRecordKey(dedupeKey)
                    and SeasonSLGMapMgr.CheckBlockEventsIsComplete(gridId) then
                isTrigger = SeasonSLGTimeEventMgr.TriggerEventNotice("9", dedupeKey, nowTime) or isTrigger
            end
        end
    end
    return isTrigger
end



SeasonSLGTimeEventMgr.GetLatestMisinterBatchStartTime = function(mapStateData)
    if mapStateData == nil or mapStateData.TimedEventProgress == nil then
        return nil
    end
    local latestBatchStartTime = nil
    for _, timedProgress in pairs(mapStateData.TimedEventProgress) do
        if timedProgress ~= nil and timedProgress.EventType == SeasonSLGConst.GridFuncType.Misinter then

            local attackConfig = timedProgress.Config
            local isBossMisinter = attackConfig ~= nil
                    and (attackConfig.ShowIcon == 1 or (tonumber(attackConfig.EventLevel) or 0) >= 10)
            if isBossMisinter then
                local batchStartTime = tonumber(timedProgress.BatchStartTime)
                if batchStartTime ~= nil and batchStartTime > 0
                        and (latestBatchStartTime == nil or batchStartTime > latestBatchStartTime) then
                    latestBatchStartTime = batchStartTime
                end
            end
        end
    end
    return latestBatchStartTime
end



SeasonSLGTimeEventMgr.CheckMisinterAppearByBatch = function(nowTime)
    local batchStartTime = SeasonSLGTimeEventMgr.GetLatestMisinterBatchStartTime(SeasonSLGMapMgr.MapStateData)
    if batchStartTime == nil then
        return false
    end
    local recordedTime = SeasonSLGTimeEventMgr.GetNoticeRecordTime("5")
    if recordedTime ~= nil and batchStartTime <= recordedTime then
        return false
    end
    return SeasonSLGTimeEventMgr.TriggerMisinterNotice(nowTime, tostring(batchStartTime), batchStartTime)
end


SeasonSLGTimeEventMgr.CheckMisinterAppearNotice = function(nowTime)
    return SeasonSLGTimeEventMgr.CheckMisinterAppearByBatch(nowTime)
end


SeasonSLGTimeEventMgr.CheckEventNotice = function(nowTime)
    nowTime = nowTime or LuaMgr.Timestamp()

    SeasonSLGTimeEventMgr.CheckMisinterAppearNotice(nowTime)
    SeasonSLGTimeEventMgr.CheckMisinterBossCompleteNotice(nowTime)
    SeasonSLGTimeEventMgr.CheckDispatchCompleteNotice(nowTime)
    SeasonSLGTimeEventMgr.CheckStaminaFullNotice(nowTime)
    SeasonSLGTimeEventMgr.CheckWorldBuildCompleteNotice(nowTime)
end




SeasonSLGTimeEventMgr.TryBackfillNoticeRecord = function()
    if SeasonSLGTimeEventMgr.noticeBackfilled == true then
        return
    end
    local mapStateData = SeasonSLGMapMgr.MapStateData
    if mapStateData == nil or mapStateData.TimedEventProgress == nil then
        return
    end
    if SeasonSLGTimeEventMgr.noticeList == nil or #SeasonSLGTimeEventMgr.noticeList == 0 then

        return
    end
    SeasonSLGTimeEventMgr.noticeBackfilled = true
    local nowTime = LuaMgr.Timestamp()

    SeasonSLGTimeEventMgr.CheckMisinterAppearByBatch(nowTime)
    SeasonSLGTimeEventMgr.CheckMisinterBossCompleteNotice(nowTime)
    SeasonSLGTimeEventMgr.CheckWorldBuildCompleteNotice(nowTime)
end

SeasonSLGTimeEventMgr.GetNoticeTimedEventConfig = function(config, timedEventConfig)
    if timedEventConfig ~= nil then
        return timedEventConfig
    end
    if config == nil or ConfigMgr.Config.SeasonalTimedEventMap == nil then
        return nil
    end
    local timedEventId = SeasonSLGTimeEventMgr.GetNoticePara(config, 1)
    return ConfigMgr.Config.SeasonalTimedEventMap[timedEventId] or ConfigMgr.Config.SeasonalTimedEventMap[tostring(timedEventId)]
end

SeasonSLGTimeEventMgr.GetNoticeRepeatInterval = function(config)
    if config == nil or tostring(config.NoticeTimeType) ~= "2" then
        return 0
    end
    return tonumber(SeasonSLGTimeEventMgr.GetNoticePara(config, 2)) or 0
end

SeasonSLGTimeEventMgr.SetNoticeRepeatState = function(config, nextPlayTime, endTime, timedEventConfig)
    if config == nil or nextPlayTime == nil or endTime == nil or timedEventConfig == nil then
        return
    end
    SeasonSLGTimeEventMgr.noticeRepeatNextTimeMap[config.Id] = nextPlayTime
    SeasonSLGTimeEventMgr.noticeRepeatEndTimeMap[config.Id] = endTime
    SeasonSLGTimeEventMgr.noticeRepeatConfigMap[config.Id] = config
    SeasonSLGTimeEventMgr.noticeRepeatTimedEventIdMap[config.Id] = timedEventConfig.Id
end


SeasonSLGTimeEventMgr.GetNoticeType2PlayWindow = function(config, nowTime, timedEventConfig)
    if config == nil or tostring(config.NoticeTimeType) ~= "2" then
        return nil, nil, nil, timedEventConfig
    end
    nowTime = nowTime or LuaMgr.Timestamp()
    timedEventConfig = SeasonSLGTimeEventMgr.GetNoticeTimedEventConfig(config, timedEventConfig)
    local eventEndTime = SeasonSLGTimeEventMgr.GetTimedEventEndTime(timedEventConfig)
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    local triggerTime = SeasonSLGTimeEventMgr.GetNoticeTriggerTime(config, timedEventConfig)
    if eventEndTime == nil or startTime == nil or triggerTime == nil then
        return nil, nil, nil, timedEventConfig
    end
    if nowTime >= eventEndTime then
        return nil, nil, nil, timedEventConfig
    end

    local firstWindowStart = startTime + triggerTime
    if nowTime < firstWindowStart then
        return nil, nil, firstWindowStart, timedEventConfig
    end

    local duration = SeasonSLGTimeEventMgr.GetNoticeDuration(config)
    if duration <= 0 then
        return firstWindowStart, eventEndTime, nil, timedEventConfig
    end

    local interval = SeasonSLGTimeEventMgr.GetNoticeRepeatInterval(config)
    if interval <= 0 then
        local windowEnd = math.min(firstWindowStart + duration, eventEndTime)
        if nowTime >= firstWindowStart and nowTime < windowEnd then
            return firstWindowStart, windowEnd, nil, timedEventConfig
        end
        return nil, nil, nil, timedEventConfig
    end

    local cycleTime = duration + interval
    local repeatIndex = math.floor((nowTime - firstWindowStart) / cycleTime)
    local windowStart = firstWindowStart + repeatIndex * cycleTime
    local windowEnd = math.min(windowStart + duration, eventEndTime)
    local nextWindowStart = windowStart + cycleTime
    if nextWindowStart >= eventEndTime then
        nextWindowStart = nil
    end

    if nowTime >= windowStart and nowTime < windowEnd then
        return windowStart, windowEnd, nextWindowStart, timedEventConfig
    end
    return nil, nil, nextWindowStart, timedEventConfig
end

SeasonSLGTimeEventMgr.CheckNoticeType2CanTrigger = function(config, nowTime, timedEventConfig, defaultTriggerTime)
    if config == nil or tostring(config.NoticeTimeType) ~= "2" then
        return false, nil, timedEventConfig
    end
    nowTime = nowTime or LuaMgr.Timestamp()
    timedEventConfig = SeasonSLGTimeEventMgr.GetNoticeTimedEventConfig(config, timedEventConfig)
    if SeasonSLGTimeEventMgr.CheckNoticeExpired(config, nowTime, timedEventConfig) then
        SeasonSLGTimeEventMgr.ClearNoticeRepeat(config.Id)
        return false, nil, timedEventConfig
    end

    local windowStart = nil
    local windowEnd = nil
    windowStart, windowEnd, _, timedEventConfig = SeasonSLGTimeEventMgr.GetNoticeType2PlayWindow(config, nowTime, timedEventConfig)
    if windowStart == nil or windowEnd == nil then
        return false, nil, timedEventConfig
    end
    return true, windowStart or defaultTriggerTime, timedEventConfig
end

SeasonSLGTimeEventMgr.CheckNoticeCurrentPlayExpired = function(config, nowTime)
    if config == nil then
        return true
    end
    local duration = SeasonSLGTimeEventMgr.GetNoticeDuration(config)
    if duration <= 0 then
        return false
    end
    local endTime = SeasonSLGTimeEventMgr.noticeEndTimeMap[config.Id]
    if endTime ~= nil then
        return nowTime >= endTime
    end
    local triggerTime = SeasonSLGTimeEventMgr.noticeTriggerTimeMap[config.Id]
    if triggerTime == nil then
        return false
    end
    return nowTime >= triggerTime + duration
end

SeasonSLGTimeEventMgr.CheckNoticeCanShowActive = function(config, nowTime, timedEventConfig)
    if config == nil or SeasonSLGTimeEventMgr.noticeEndMap[config.Id] then
        return false
    end
    local noticeTimeType = tostring(config.NoticeTimeType)
    if noticeTimeType ~= "2" then
        return not SeasonSLGTimeEventMgr.CheckNoticeCurrentPlayExpired(config, nowTime)
    end
    if SeasonSLGTimeEventMgr.CheckNoticeExpired(config, nowTime, timedEventConfig) then
        return false
    end
    if SeasonSLGTimeEventMgr.noticeTriggerMap[config.Id] then
        return not SeasonSLGTimeEventMgr.CheckNoticeCurrentPlayExpired(config, nowTime)
    end
    local windowStart = nil
    local windowEnd = nil
    windowStart, windowEnd = SeasonSLGTimeEventMgr.GetNoticeType2PlayWindow(config, nowTime, timedEventConfig)
    return windowStart ~= nil and windowEnd ~= nil
end

SeasonSLGTimeEventMgr.ClearNoticeRepeat = function(noticeId)
    SeasonSLGTimeEventMgr.noticeRepeatNextTimeMap[noticeId] = nil
    SeasonSLGTimeEventMgr.noticeRepeatEndTimeMap[noticeId] = nil
    SeasonSLGTimeEventMgr.noticeRepeatConfigMap[noticeId] = nil
    SeasonSLGTimeEventMgr.noticeRepeatTimedEventIdMap[noticeId] = nil
end


SeasonSLGTimeEventMgr.AddNoticeRepeat = function(config, nowTime, timedEventConfig)
    if config == nil or tostring(config.NoticeTimeType) ~= "2" then
        return
    end
    local interval = SeasonSLGTimeEventMgr.GetNoticeRepeatInterval(config)
    if interval <= 0 then
        SeasonSLGTimeEventMgr.ClearNoticeRepeat(config.Id)
        return
    end
    timedEventConfig = SeasonSLGTimeEventMgr.GetNoticeTimedEventConfig(config, timedEventConfig)
    local endTime = SeasonSLGTimeEventMgr.GetTimedEventEndTime(timedEventConfig)
    if endTime == nil or nowTime >= endTime then
        return
    end

    local nextPlayTime = nil
    _, _, nextPlayTime, timedEventConfig = SeasonSLGTimeEventMgr.GetNoticeType2PlayWindow(config, nowTime, timedEventConfig)
    if nextPlayTime == nil or nextPlayTime >= endTime then
        SeasonSLGTimeEventMgr.ClearNoticeRepeat(config.Id)
        return
    end

    SeasonSLGTimeEventMgr.SetNoticeRepeatState(config, nextPlayTime, endTime, timedEventConfig)
end

SeasonSLGTimeEventMgr.CheckNoticeRepeatEnd = function(config, nowTime)
    if config == nil or SeasonSLGTimeEventMgr.GetNoticeRepeatInterval(config) <= 0 then
        return true
    end
    local endTime = SeasonSLGTimeEventMgr.noticeRepeatEndTimeMap[config.Id]
    if endTime == nil then
        return true
    end
    return nowTime >= endTime
end


SeasonSLGTimeEventMgr.EndNoticeRepeatByTimedEvent = function(timedEventConfig)
    if timedEventConfig == nil then
        return
    end
    local endNoticeIds = {}
    for noticeId, timedEventId in pairs(SeasonSLGTimeEventMgr.noticeRepeatTimedEventIdMap) do
        if tostring(timedEventId) == tostring(timedEventConfig.Id) then
            table.insert(endNoticeIds, noticeId)
        end
    end
    for i = 1, #endNoticeIds do
        local noticeId = endNoticeIds[i]
        local noticeConfig = SeasonSLGTimeEventMgr.noticeRepeatConfigMap[noticeId]
        SeasonSLGTimeEventMgr.ClearNoticeRepeat(noticeId)
        SeasonSLGTimeEventMgr.noticeEndMap[noticeId] = true
        if SeasonSLGTimeEventMgr.noticeEndTimeMap[noticeId] ~= nil then
            SeasonSLGTimeEventMgr.OnNoticeEnd(noticeConfig)
            SeasonSLGTimeEventMgr.noticeEndTimeMap[noticeId] = nil
            SeasonSLGTimeEventMgr.noticeEndConfigMap[noticeId] = nil
            SeasonSLGTimeEventMgr.noticeTriggerMap[noticeId] = false
        end
    end
end

SeasonSLGTimeEventMgr.GetNextCheckDelay = function(nowTime)
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    if startTime == nil then
        return nil
    end
    local passTime = nowTime - startTime
    local nextTime = nil
    local progressConfig = SeasonSLGTimeEventMgr.progressList
    if progressConfig ~= nil then
        for i, v in pairs(progressConfig) do
            nextTime = SeasonSLGTimeEventMgr.GetMinNextTime(nextTime, SeasonSLGTimeEventMgr.GetProgressEventTime(v), passTime)
        end
    end
    local noticeMap = SeasonSLGTimeEventMgr.noticeList
    if noticeMap ~= nil then
        for i, v in pairs(noticeMap) do
            if not SeasonSLGTimeEventMgr.noticeTriggerMap[v.Id] and tostring(v.NoticeTimeType) == "1" then
                nextTime = SeasonSLGTimeEventMgr.GetMinNextTime(nextTime, tonumber(SeasonSLGTimeEventMgr.GetNoticePara(v, 1)) or 0, passTime)
            end
        end
    end
    for id, endTime in pairs(SeasonSLGTimeEventMgr.noticeEndTimeMap) do
        if not SeasonSLGTimeEventMgr.noticeEndMap[id] then
            nextTime = SeasonSLGTimeEventMgr.GetMinNextTime(nextTime, endTime - startTime, passTime)
        end
    end
    for id, endTime in pairs(SeasonSLGTimeEventMgr.triggerEventEndTimeMap) do
        if not SeasonSLGTimeEventMgr.triggerEventEndMap[id] then
            nextTime = SeasonSLGTimeEventMgr.GetMinNextTime(nextTime, endTime - startTime, passTime)
        end
    end

    for id, nextRepeatTime in pairs(SeasonSLGTimeEventMgr.noticeRepeatNextTimeMap) do
        nextTime = SeasonSLGTimeEventMgr.GetMinNextTime(nextTime, nextRepeatTime - startTime, passTime)
    end
    local activeEventList = SeasonSLGTimeEventMgr.GetActiveEventList()
    for i, timedEventConfig in ipairs(activeEventList or {}) do
        for j, noticeConfig in pairs(SeasonSLGTimeEventMgr.noticeList or {}) do
            if tostring(noticeConfig.NoticeTimeType) == "2"
                    and tostring(SeasonSLGTimeEventMgr.GetNoticePara(noticeConfig, 1)) == tostring(timedEventConfig.Id) then
                local windowStart = nil
                local windowEnd = nil
                local nextWindowStart = nil
                windowStart, windowEnd, nextWindowStart = SeasonSLGTimeEventMgr.GetNoticeType2PlayWindow(noticeConfig, nowTime, timedEventConfig)
                if windowStart ~= nil and windowEnd ~= nil then
                    nextTime = SeasonSLGTimeEventMgr.GetMinNextTime(nextTime, windowEnd - startTime, passTime)
                elseif nextWindowStart ~= nil then
                    nextTime = SeasonSLGTimeEventMgr.GetMinNextTime(nextTime, nextWindowStart - startTime, passTime)
                end
            end
        end
    end
    local configMap = SeasonSLGTimeEventMgr.timedEventList
    if configMap ~= nil then
        for i, v in pairs(configMap) do
            if not SeasonSLGTimeEventMgr.triggerEventMap[v.Id] and v.Trigger ~= nil and #v.Trigger >= 2 then
                local triggerType = tostring(v.Trigger[1])
                local triggerValue = tonumber(v.Trigger[2]) or 0
                if triggerType == "1" then
                    nextTime = SeasonSLGTimeEventMgr.GetMinNextTime(nextTime, triggerValue * 3600, passTime)
                elseif triggerType == "2" then
                    nextTime = SeasonSLGTimeEventMgr.GetMinNextTime(nextTime, SeasonSLGTimeEventMgr.GetProgressReachTime(triggerValue), passTime)
                end
            end
        end
    end
    if nextTime == nil then
        return nil
    end
    return math.max(1, nextTime - passTime)
end

SeasonSLGTimeEventMgr.GetMinNextTime = function(curNextTime, eventTime, passTime)
    if eventTime == nil or eventTime <= passTime then
        return curNextTime
    end
    if curNextTime == nil or eventTime < curNextTime then
        return eventTime
    end
    return curNextTime
end


SeasonSLGTimeEventMgr.CheckNoticeEvent = function(nowTime)
    local noticeMap = SeasonSLGTimeEventMgr.noticeList
    if noticeMap == nil or #noticeMap == 0 then
        return
    end
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    if startTime == nil then
        return
    end
    local passTime = nowTime - startTime
    local triggerConfig = nil
    local triggerTime = nil
    local triggerTimedEventConfig = nil
    for i, v in pairs(noticeMap) do
        if not SeasonSLGTimeEventMgr.noticeTriggerMap[v.Id]
                and not SeasonSLGTimeEventMgr.noticeEndMap[v.Id]
                and tostring(v.NoticeTimeType) == "1" then
            local noticeTime = tonumber(SeasonSLGTimeEventMgr.GetNoticePara(v, 1)) or 0
            if passTime >= noticeTime and not SeasonSLGTimeEventMgr.CheckNoticeExpired(v, nowTime) then
                triggerConfig, triggerTime = SeasonSLGTimeEventMgr.SelectNoticeByPriority(triggerConfig, triggerTime, v, startTime + noticeTime)
            end
        end
    end

    local activeEventList = SeasonSLGTimeEventMgr.GetActiveEventList()
    for i, timedEventConfig in ipairs(activeEventList or {}) do
        for j, noticeConfig in pairs(noticeMap) do
            if not SeasonSLGTimeEventMgr.noticeTriggerMap[noticeConfig.Id]
                    and not SeasonSLGTimeEventMgr.noticeEndMap[noticeConfig.Id]
                    and tostring(noticeConfig.NoticeTimeType) == "2"
                    and tostring(SeasonSLGTimeEventMgr.GetNoticePara(noticeConfig, 1)) == tostring(timedEventConfig.Id) then
                local noticeTriggerTime = SeasonSLGTimeEventMgr.GetNoticeDisplayTriggerTime(noticeConfig, timedEventConfig)
                local canTrigger = false
                local noticeTimedEventConfig = timedEventConfig
                canTrigger, noticeTriggerTime, noticeTimedEventConfig = SeasonSLGTimeEventMgr.CheckNoticeType2CanTrigger(noticeConfig, nowTime, timedEventConfig, noticeTriggerTime)
                if canTrigger and noticeTriggerTime ~= nil and nowTime >= noticeTriggerTime and not SeasonSLGTimeEventMgr.CheckNoticeExpired(noticeConfig, nowTime, noticeTimedEventConfig) then
                    triggerConfig, triggerTime = SeasonSLGTimeEventMgr.SelectNoticeByPriority(triggerConfig, triggerTime, noticeConfig, noticeTriggerTime)
                    if triggerConfig == noticeConfig then
                        triggerTimedEventConfig = noticeTimedEventConfig
                    end
                end
            end
        end
    end

    if triggerConfig ~= nil then
        SeasonSLGTimeEventMgr.TriggerNotice(triggerConfig, nowTime, triggerTimedEventConfig, triggerTime)
    end
end


SeasonSLGTimeEventMgr.CheckNoticeByTimedEvent = function(timedEventConfig)
    local noticeMap = SeasonSLGTimeEventMgr.noticeList
    if noticeMap == nil or #noticeMap == 0 or timedEventConfig == nil then
        return
    end
    local nowTime = LuaMgr.Timestamp()
    local triggerConfig = nil
    local triggerTime = nil
    local triggerTimedEventConfig = timedEventConfig
    for i, v in pairs(noticeMap) do
        if not SeasonSLGTimeEventMgr.noticeTriggerMap[v.Id]
                and not SeasonSLGTimeEventMgr.noticeEndMap[v.Id]
                and tostring(v.NoticeTimeType) == "2" then
            if tostring(SeasonSLGTimeEventMgr.GetNoticePara(v, 1)) == tostring(timedEventConfig.Id) then
                local noticeTriggerTime = SeasonSLGTimeEventMgr.GetTriggeredEventSortTime(timedEventConfig)
                local canTrigger = false
                local noticeTimedEventConfig = timedEventConfig
                canTrigger, noticeTriggerTime, noticeTimedEventConfig = SeasonSLGTimeEventMgr.CheckNoticeType2CanTrigger(v, nowTime, timedEventConfig, noticeTriggerTime)
                if canTrigger and not SeasonSLGTimeEventMgr.CheckNoticeExpired(v, nowTime, noticeTimedEventConfig) then
                    triggerConfig, triggerTime = SeasonSLGTimeEventMgr.SelectNoticeByPriority(
                            triggerConfig,
                            triggerTime,
                            v,
                            noticeTriggerTime)
                    if triggerConfig == v then
                        triggerTimedEventConfig = noticeTimedEventConfig
                    end
                end
            end
        end
    end
    if triggerConfig ~= nil then
        SeasonSLGTimeEventMgr.TriggerNotice(triggerConfig, nowTime, triggerTimedEventConfig, triggerTime)
    end
end

SeasonSLGTimeEventMgr.GetNoticeRecordKey = function(config, suffix)
    if config == nil then
        return nil
    end
    local uid = DataMgr.Player.uid or ""
    local seasonId = SeasonSLGTimeEventMgr.GetCurSeasonId() or ""
    return string.format("%s_SeasonSLGNotice_%s_%s_%s", uid, seasonId, tostring(config.Id), suffix or "")
end

SeasonSLGTimeEventMgr.GetActivityOpenDay = function(nowTime)
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    if startTime == nil then
        return nil
    end
    local passTime = (nowTime or LuaMgr.Timestamp()) - startTime
    if passTime < 0 then
        return nil
    end
    return math.floor(passTime / (24 * 60 * 60)) + 1
end

SeasonSLGTimeEventMgr.GetNoticeDisplayTriggerTime = function(config, timedEventConfig)
    if config == nil then
        return nil
    end
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    if startTime == nil then
        return nil
    end
    local noticeTimeType = tostring(config.NoticeTimeType)
    if noticeTimeType ~= "2" and SeasonSLGTimeEventMgr.noticeTriggerTimeMap[config.Id] ~= nil then
        return SeasonSLGTimeEventMgr.noticeTriggerTimeMap[config.Id]
    end
    if noticeTimeType == "1" then
        local triggerTime = SeasonSLGTimeEventMgr.GetNoticeTriggerTime(config)
        if triggerTime ~= nil then
            return startTime + triggerTime
        end
    elseif noticeTimeType == "2" then
        if SeasonSLGTimeEventMgr.noticeTriggerMap[config.Id]
                and SeasonSLGTimeEventMgr.noticeTriggerTimeMap[config.Id] ~= nil then
            return SeasonSLGTimeEventMgr.noticeTriggerTimeMap[config.Id]
        end
        local windowStart = nil
        local nextWindowStart = nil
        windowStart, _, nextWindowStart = SeasonSLGTimeEventMgr.GetNoticeType2PlayWindow(config, LuaMgr.Timestamp(), timedEventConfig)
        if windowStart ~= nil then
            return windowStart
        end
        if nextWindowStart ~= nil then
            return nextWindowStart
        end
        timedEventConfig = SeasonSLGTimeEventMgr.GetNoticeTimedEventConfig(config, timedEventConfig)
        local triggerTime = SeasonSLGTimeEventMgr.GetNoticeTriggerTime(config, timedEventConfig)
        if triggerTime ~= nil then
            return startTime + triggerTime
        end
    end
    return nil
end

SeasonSLGTimeEventMgr.CheckActiveNoticePriority = function(activeConfig, activeTriggerTime, config, triggerTime, nowTime, timedEventConfig, byTimeFirst)
    if config == nil or triggerTime == nil then
        return activeConfig, activeTriggerTime
    end
    if SeasonSLGTimeEventMgr.noticeEndMap[config.Id] then
        return activeConfig, activeTriggerTime
    end
    if not SeasonSLGTimeEventMgr.CheckNoticeCanShowActive(config, nowTime, timedEventConfig) then
        return activeConfig, activeTriggerTime
    end
    local duration = SeasonSLGTimeEventMgr.GetNoticeDuration(config)
    if duration > 0 then
        local noticeTimeType = tostring(config.NoticeTimeType)
        if noticeTimeType == "3" or noticeTimeType == "4" then
            if nowTime > triggerTime + duration then
                return activeConfig, activeTriggerTime
            end
        elseif SeasonSLGTimeEventMgr.CheckNoticeExpired(config, nowTime, timedEventConfig) then
            return activeConfig, activeTriggerTime
        end
    end
    return SeasonSLGTimeEventMgr.SelectNoticeByPriority(activeConfig, activeTriggerTime, config, triggerTime, byTimeFirst)
end

SeasonSLGTimeEventMgr.CheckNoticeOnSeasonSLGMapEnter = function()
    local noticeMap = SeasonSLGTimeEventMgr.noticeList
    if noticeMap == nil or #noticeMap == 0 then
        return
    end
    local nowTime = LuaMgr.Timestamp()
    local openDay = SeasonSLGTimeEventMgr.GetActivityOpenDay(nowTime)
    if openDay == nil then
        return
    end
    local triggerConfig = nil
    local triggerTime = nil
    local triggerKey = nil
    for i, v in pairs(noticeMap) do
        if tostring(v.NoticeTimeType) == "3" and tonumber(SeasonSLGTimeEventMgr.GetNoticePara(v, 1)) == openDay then
            local key = SeasonSLGTimeEventMgr.GetNoticeRecordKey(v, "OpenDay" .. tostring(openDay))
            if key ~= nil and PlayerPrefs.GetString(key, "") ~= "1" then
                local oldConfig = triggerConfig
                triggerConfig, triggerTime = SeasonSLGTimeEventMgr.SelectNoticeByPriority(triggerConfig, triggerTime, v, nowTime)
                if triggerConfig ~= oldConfig then
                    triggerKey = key
                end
            end
        end
    end
    if triggerConfig ~= nil then
        if triggerKey ~= nil then
            PlayerPrefs.SetString(triggerKey, "1")
            PlayerPrefs.Save()
        end
        SeasonSLGTimeEventMgr.TriggerNotice(triggerConfig, nowTime, nil, triggerTime)
        if SeasonSLGTimeEventMgr.GetNoticeDuration(triggerConfig) > 0 then
            SeasonSLGTimeEventMgr.ScheduleNextCheck(nowTime)
        end
    end
end

SeasonSLGTimeEventMgr.TriggerNoticeByGridUnlock = function(gridId)
    if gridId == nil then
        return
    end
    local noticeMap = SeasonSLGTimeEventMgr.noticeList
    if noticeMap == nil or #noticeMap == 0 then
        return
    end
    local nowTime = LuaMgr.Timestamp()
    local triggerConfig = nil
    local triggerTime = nil
    for i, v in pairs(noticeMap) do
        if tostring(v.NoticeTimeType) == "4" then
            if tostring(SeasonSLGTimeEventMgr.GetNoticePara(v, 1)) == tostring(gridId) then
                triggerConfig, triggerTime = SeasonSLGTimeEventMgr.SelectNoticeByPriority(triggerConfig, triggerTime, v, nowTime)
            end
        end
    end
    if triggerConfig ~= nil then

        SeasonSLGTimeEventMgr.AddNoticeRecord(triggerConfig, nowTime, "grid_" .. tostring(gridId))
        SeasonSLGTimeEventMgr.TriggerNotice(triggerConfig, nowTime, nil, triggerTime)
        if SeasonSLGTimeEventMgr.GetNoticeDuration(triggerConfig) > 0 then
            SeasonSLGTimeEventMgr.ScheduleNextCheck(nowTime)
        end
    end
end


SeasonSLGTimeEventMgr.TriggerNotice = function(config, nowTime, timedEventConfig, displayTriggerTime)
    if config == nil or SeasonSLGTimeEventMgr.noticeTriggerMap[config.Id] or SeasonSLGTimeEventMgr.noticeEndMap[config.Id] then
        return false
    end
    nowTime = nowTime or LuaMgr.Timestamp()
    if not SeasonSLGTimeEventMgr.CheckCanTriggerNotice(config) then
        return false
    end
    local triggerTime = displayTriggerTime or SeasonSLGTimeEventMgr.GetNoticeDisplayTriggerTime(config, timedEventConfig) or nowTime
    SeasonSLGTimeEventMgr.noticeTriggerTimeMap[config.Id] = triggerTime
    if SeasonSLGTimeEventMgr.CheckNoticeExpired(config, nowTime, timedEventConfig) then
        return false
    end
    SeasonSLGTimeEventMgr.noticeEndMap[config.Id] = false
    SeasonSLGTimeEventMgr.noticeTriggerMap[config.Id] = true
    SeasonSLGTimeEventMgr.AddNoticeEnd(config, nowTime, timedEventConfig)
    SeasonSLGTimeEventMgr.AddNoticeRepeat(config, nowTime, timedEventConfig)
    SeasonSLGTimeEventMgr.OnNoticeTrigger(config)
    return true
end

SeasonSLGTimeEventMgr.AddNoticeEnd = function(config, nowTime, timedEventConfig)
    local duration = SeasonSLGTimeEventMgr.GetNoticeDuration(config)
    if duration <= 0 then
        return
    end
    local endTime = nowTime + duration
    if tostring(config.NoticeTimeType) == "2" then
        local windowEnd = nil
        _, windowEnd = SeasonSLGTimeEventMgr.GetNoticeType2PlayWindow(config, nowTime, timedEventConfig)
        if windowEnd ~= nil then
            endTime = windowEnd
        end
    end
    SeasonSLGTimeEventMgr.noticeEndTimeMap[config.Id] = endTime
    SeasonSLGTimeEventMgr.noticeEndConfigMap[config.Id] = config
end

SeasonSLGTimeEventMgr.GetNoticeDuration = function(config)
    if config == nil then
        return 0
    end
    return tonumber(config.Duration) or 0
end

SeasonSLGTimeEventMgr.GetNoticeTriggerTime = function(config, timedEventConfig)
    if config == nil then
        return nil
    end
    local noticeTimeType = tostring(config.NoticeTimeType)
    if noticeTimeType == "1" then
        return tonumber(SeasonSLGTimeEventMgr.GetNoticePara(config, 1)) or 0
    elseif noticeTimeType == "2" and timedEventConfig ~= nil then
        return SeasonSLGTimeEventMgr.GetTimedEventTriggerTime(timedEventConfig)
    elseif noticeTimeType == "5" or noticeTimeType == "6" or noticeTimeType == "7"
            or noticeTimeType == "8" or noticeTimeType == "9" then
        return 0
    end
    return nil
end

SeasonSLGTimeEventMgr.GetNoticeEndTime = function(config, timedEventConfig)
    local duration = SeasonSLGTimeEventMgr.GetNoticeDuration(config)
    if duration <= 0 then
        return nil
    end
    local noticeTimeType = tostring(config.NoticeTimeType)
    if noticeTimeType == "3" or noticeTimeType == "4" or noticeTimeType == "5"
            or noticeTimeType == "6" or noticeTimeType == "7"
            or noticeTimeType == "8" or noticeTimeType == "9" then
        local triggerTime = SeasonSLGTimeEventMgr.noticeTriggerTimeMap[config.Id]
        if triggerTime == nil then
            return nil
        end
        return triggerTime + duration
    end
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    local triggerTime = SeasonSLGTimeEventMgr.GetNoticeTriggerTime(config, timedEventConfig)
    if startTime == nil or triggerTime == nil then
        return nil
    end
    return startTime + triggerTime + duration
end


SeasonSLGTimeEventMgr.CheckNoticeExpired = function(config, nowTime, timedEventConfig)
    if config ~= nil and tostring(config.NoticeTimeType) == "2" then
        timedEventConfig = SeasonSLGTimeEventMgr.GetNoticeTimedEventConfig(config, timedEventConfig)
        local timedEventEndTime = SeasonSLGTimeEventMgr.GetTimedEventEndTime(timedEventConfig)
        return timedEventEndTime ~= nil and nowTime >= timedEventEndTime
    end
    local endTime = SeasonSLGTimeEventMgr.GetNoticeEndTime(config, timedEventConfig)
    return endTime ~= nil and nowTime > endTime
end


SeasonSLGTimeEventMgr.CheckNoticeEndEvent = function(nowTime)
    local endNoticeIds = {}
    for id, endTime in pairs(SeasonSLGTimeEventMgr.noticeEndTimeMap) do
        if not SeasonSLGTimeEventMgr.noticeEndMap[id] and nowTime >= endTime then
            table.insert(endNoticeIds, id)
        end
    end
    for i = 1, #endNoticeIds do
        local id = endNoticeIds[i]
        if not SeasonSLGTimeEventMgr.noticeEndMap[id] and SeasonSLGTimeEventMgr.noticeEndTimeMap[id] ~= nil then
            local noticeConfig = SeasonSLGTimeEventMgr.noticeEndConfigMap[id]
            SeasonSLGTimeEventMgr.noticeEndTimeMap[id] = nil
            SeasonSLGTimeEventMgr.noticeEndConfigMap[id] = nil
            SeasonSLGTimeEventMgr.noticeTriggerMap[id] = false
            if SeasonSLGTimeEventMgr.CheckNoticeRepeatEnd(noticeConfig, nowTime) then
                SeasonSLGTimeEventMgr.noticeEndMap[id] = true
                SeasonSLGTimeEventMgr.ClearNoticeRepeat(id)
            end
            SeasonSLGTimeEventMgr.OnNoticeEnd(noticeConfig)
        end
    end
end

SeasonSLGTimeEventMgr.CheckEventTrigger = function(config, nowTime)
    if config == nil or config.Trigger == nil or #config.Trigger < 2 then
        return false
    end
    if SeasonSLGTimeEventMgr.CheckTimedEventExpired(config, nowTime) then
        return false
    end
    local triggerType = tostring(config.Trigger[1])
    local triggerValue = tonumber(config.Trigger[2]) or 0
    if triggerType == "1" then
        local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
        if startTime == nil then
            return false
        end
        local passTime = nowTime - startTime
        return passTime >= triggerValue * 3600 and SeasonSLGTimeEventMgr.CheckDuration(config, passTime, triggerValue * 3600)
    elseif triggerType == "2" then
        if SeasonSLGTimeEventMgr.GetWorldProgress() < triggerValue then
            return false
        end
        local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
        local reachTime = SeasonSLGTimeEventMgr.GetProgressReachTime(triggerValue)
        if startTime == nil or reachTime == nil then
            return false
        end
        return SeasonSLGTimeEventMgr.CheckDuration(config, nowTime - startTime, reachTime)
    end
    return false
end

SeasonSLGTimeEventMgr.CheckDuration = function(config, passTime, triggerTime)
    local duration = SeasonSLGTimeEventMgr.GetTimedEventDuration(config)
    if duration <= 0 then
        return true
    end
    return passTime <= triggerTime + duration
end

SeasonSLGTimeEventMgr.GetProgressReachTime = function(progress)
    local progressConfig = SeasonSLGTimeEventMgr.progressList
    if progressConfig == nil or #progressConfig == 0 then
        return nil
    end
    local reachTime = nil
    for i, v in pairs(progressConfig) do
        if (tonumber(v.Progress) or 0) >= progress then
            local eventTime = SeasonSLGTimeEventMgr.GetProgressEventTime(v)
            if reachTime == nil or eventTime < reachTime then
                reachTime = eventTime
            end
        end
    end
    return reachTime
end

SeasonSLGTimeEventMgr.GetTriggeredEventList = function()
    local list = {}
    for i, v in pairs(SeasonSLGTimeEventMgr.timedEventList) do
        if SeasonSLGTimeEventMgr.triggerEventMap[v.Id] then
            table.insert(list, v)
        end
    end
    table.sort(list, function(a, b)
        return SeasonSLGTimeEventMgr.GetTriggeredEventSortTime(a) > SeasonSLGTimeEventMgr.GetTriggeredEventSortTime(b)
    end)
    return list
end

SeasonSLGTimeEventMgr.GetActiveEventList = function()
    local list = {}
    if SeasonSLGTimeEventMgr.activityInfo == nil then
        return list
    end
    local nowTime = LuaMgr.Timestamp()
    for i, v in pairs(SeasonSLGTimeEventMgr.timedEventList) do
        if SeasonSLGTimeEventMgr.CheckEventTrigger(v, nowTime) then
            table.insert(list, v)
        end
    end
    table.sort(list, function(a, b)
        return SeasonSLGTimeEventMgr.GetTriggeredEventSortTime(a) > SeasonSLGTimeEventMgr.GetTriggeredEventSortTime(b)
    end)
    return list
end

SeasonSLGTimeEventMgr.GetActiveTimedEventNoticeConfig = function()
    local activeEventList = SeasonSLGTimeEventMgr.GetActiveEventList()
    if activeEventList == nil or #activeEventList == 0 then
        return nil
    end
    local noticeMap = SeasonSLGTimeEventMgr.noticeList
    if noticeMap == nil or #noticeMap == 0 then
        return nil
    end
    local nowTime = LuaMgr.Timestamp()
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    if startTime == nil then
        return nil
    end
    local activeConfig = nil
    local activeTriggerTime = nil
    for i, timedEventConfig in ipairs(activeEventList) do
        for j, noticeConfig in ipairs(noticeMap) do
            if tostring(noticeConfig.NoticeTimeType) == "2" and tostring(SeasonSLGTimeEventMgr.GetNoticePara(noticeConfig, 1)) == tostring(timedEventConfig.Id) then
                local duration = SeasonSLGTimeEventMgr.GetNoticeDuration(noticeConfig)
                if duration <= 0 or not SeasonSLGTimeEventMgr.CheckNoticeExpired(noticeConfig, nowTime, timedEventConfig) then
                    local triggerTime = SeasonSLGTimeEventMgr.GetNoticeDisplayTriggerTime(noticeConfig, timedEventConfig)
                    activeConfig, activeTriggerTime = SeasonSLGTimeEventMgr.CheckActiveNoticePriority(activeConfig, activeTriggerTime, noticeConfig, triggerTime, nowTime, timedEventConfig)
                end
            end
        end
    end
    return activeConfig
end



SeasonSLGTimeEventMgr.GetActiveNoticeConfig = function(skipTriggered, byTimeFirst)
    local noticeMap = SeasonSLGTimeEventMgr.noticeList
    if noticeMap == nil or #noticeMap == 0 then
        return nil
    end
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime()
    if startTime == nil then
        return nil
    end
    local nowTime = LuaMgr.Timestamp()
    local activeConfig = nil
    local activeTriggerTime = nil

    for i, noticeConfig in pairs(noticeMap) do
        local noticeTimeType = tostring(noticeConfig.NoticeTimeType)
        if skipTriggered ~= true or not SeasonSLGTimeEventMgr.noticeTriggerMap[noticeConfig.Id] then
            if noticeTimeType == "1" then
                local triggerTime = SeasonSLGTimeEventMgr.GetNoticeDisplayTriggerTime(noticeConfig)
                if triggerTime ~= nil and nowTime >= triggerTime then
                    activeConfig, activeTriggerTime = SeasonSLGTimeEventMgr.CheckActiveNoticePriority(activeConfig, activeTriggerTime, noticeConfig, triggerTime, nowTime, nil, byTimeFirst)
                end
            elseif noticeTimeType == "3" or noticeTimeType == "4" then
                local triggerTime = SeasonSLGTimeEventMgr.GetNoticeDisplayTriggerTime(noticeConfig)
                if triggerTime ~= nil then
                    activeConfig, activeTriggerTime = SeasonSLGTimeEventMgr.CheckActiveNoticePriority(activeConfig, activeTriggerTime, noticeConfig, triggerTime, nowTime, nil, byTimeFirst)
                end
            end
        end
    end

    local activeEventList = SeasonSLGTimeEventMgr.GetActiveEventList()
    if activeEventList ~= nil and #activeEventList > 0 then
        for i, timedEventConfig in ipairs(activeEventList) do
            for j, noticeConfig in pairs(noticeMap) do
                local repeatNextTime = SeasonSLGTimeEventMgr.noticeRepeatNextTimeMap[noticeConfig.Id]

                local canShowRepeatNotice = SeasonSLGTimeEventMgr.noticeTriggerMap[noticeConfig.Id]
                        or repeatNextTime == nil
                        or nowTime >= repeatNextTime
                if (skipTriggered ~= true or not SeasonSLGTimeEventMgr.noticeTriggerMap[noticeConfig.Id])
                        and canShowRepeatNotice
                        and tostring(noticeConfig.NoticeTimeType) == "2"
                        and tostring(SeasonSLGTimeEventMgr.GetNoticePara(noticeConfig, 1)) == tostring(timedEventConfig.Id) then
                    local triggerTime = SeasonSLGTimeEventMgr.GetNoticeDisplayTriggerTime(noticeConfig, timedEventConfig)
                    if triggerTime ~= nil then
                        activeConfig, activeTriggerTime = SeasonSLGTimeEventMgr.CheckActiveNoticePriority(activeConfig, activeTriggerTime, noticeConfig, triggerTime, nowTime, timedEventConfig, byTimeFirst)
                    end
                end
            end
        end
    end

    return activeConfig
end

SeasonSLGTimeEventMgr.GetTriggeredEventSortTime = function(config)
    if config == nil then
        return 0
    end
    if SeasonSLGTimeEventMgr.triggerEventTimeMap[config.Id] ~= nil then
        return SeasonSLGTimeEventMgr.triggerEventTimeMap[config.Id]
    end
    local triggerTime = SeasonSLGTimeEventMgr.GetTimedEventTriggerTime(config)
    local startTime = SeasonSLGTimeEventMgr.GetActivityStartTime() or 0
    return startTime + (triggerTime or 0)
end

SeasonSLGTimeEventMgr.GetTimedEventTriggerTime = function(config)
    if config == nil or config.Trigger == nil or #config.Trigger < 2 then
        return 0
    end
    local triggerType = tostring(config.Trigger[1])
    local triggerValue = tonumber(config.Trigger[2]) or 0
    if triggerType == "1" then
        return triggerValue * 3600
    elseif triggerType == "2" then
        return SeasonSLGTimeEventMgr.GetProgressReachTime(triggerValue) or 0
    end
    return 0
end

SeasonSLGTimeEventMgr.OnTimedEventTrigger = function(config)
    LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGTimedEventTrigger, config)
    SeasonSLGTimeEventMgr.CheckNoticeByTimedEvent(config)
end

SeasonSLGTimeEventMgr.OnTimedEventEnd = function(config)
    SeasonSLGTimeEventMgr.EndNoticeRepeatByTimedEvent(config)
    LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGTimedEventEnd, config)
end

SeasonSLGTimeEventMgr.OnWorldProgressChange = function(progress, config)
    LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGWorldProgressChange, progress, config)
end

SeasonSLGTimeEventMgr.OnNoticeTrigger = function(config)
    LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGNoticeTrigger, config)
end

SeasonSLGTimeEventMgr.OnNoticeEnd = function(config)
    LuaMgr.InvokeUIEventListeners(UIEventConst.SeasonSLGNoticeEnd, config)
end

SeasonSLGTimeEventMgr.GetWorldProgress = function()
    if SeasonSLGTimeEventMgr.activityInfo ~= nil then
        local progress = SeasonSLGTimeEventMgr.CalculateWorldProgress(LuaMgr.Timestamp())
        return progress or 0
    end
    return SeasonSLGTimeEventMgr.worldProgress or 0
end

SeasonSLGTimeEventMgr.CheckIsSecondActivity = function()
    if SeasonSLGTimeEventMgr.activityInfo == nil then
        return false
    end
    local activityGroupId = SeasonSLGMapMgr.curSeasonal.ActivityGroupId[2]
    local activityKey = ConfigMgr.Config.activityGroup[activityGroupId].key
    local activityInfo = DataExHelper.GetDataExByTag(activityKey)
    if activityInfo == nil then
        return false
    end
    SeasonSLGTimeEventMgr.activityInfo = activityInfo
    return true
end

SeasonSLGTimeEventMgr.Clear=function()
    LuaMgr.RemoveUIEventListener(UIEventConst.HeartBeat, SeasonSLGTimeEventMgr.OnHeartBeat)
    LuaMgr.RemoveTimer(TimerConst.SeasonSLGTimeEvent)
    SeasonSLGTimeEventMgr.activityInfo = nil
    SeasonSLGTimeEventMgr.worldProgress = 0
    SeasonSLGTimeEventMgr.lastCheckTime = nil
    SeasonSLGTimeEventMgr.triggerEventMap = {}
    SeasonSLGTimeEventMgr.triggerEventTimeMap = {}
    SeasonSLGTimeEventMgr.triggerEventEndMap = {}
    SeasonSLGTimeEventMgr.triggerEventEndTimeMap = {}
    SeasonSLGTimeEventMgr.triggerEventEndConfigMap = {}
    SeasonSLGTimeEventMgr.noticeTriggerMap = {}
    SeasonSLGTimeEventMgr.noticeTriggerTimeMap = {}
    SeasonSLGTimeEventMgr.noticeEndMap = {}
    SeasonSLGTimeEventMgr.noticeEndTimeMap = {}
    SeasonSLGTimeEventMgr.noticeEndConfigMap = {}
    SeasonSLGTimeEventMgr.noticeRepeatNextTimeMap = {}
    SeasonSLGTimeEventMgr.noticeRepeatEndTimeMap = {}
    SeasonSLGTimeEventMgr.noticeRepeatConfigMap = {}
    SeasonSLGTimeEventMgr.noticeRepeatTimedEventIdMap = {}
    SeasonSLGTimeEventMgr.misinterNoticeBatchMap = {}
    SeasonSLGTimeEventMgr.misinterHandledBatchMap = {}
    SeasonSLGTimeEventMgr.noticeEventKeyMap = {}

    SeasonSLGTimeEventMgr.noticeCommonCdTime = 0
    SeasonSLGTimeEventMgr.noticeRecordLoaded = false
    SeasonSLGTimeEventMgr.noticeRecordList = nil
    SeasonSLGTimeEventMgr.noticeBackfilled = false
    SeasonSLGTimeEventMgr.lastStaminaIsFull = false
    SeasonSLGTimeEventMgr.noticeLocalKey = nil
    SeasonSLGTimeEventMgr.noticeLocalKeyWarned = false
    SeasonSLGTimeEventMgr.timedEventList = {}
    SeasonSLGTimeEventMgr.noticeList = {}
    SeasonSLGTimeEventMgr.progressList = {}
end

return SeasonSLGTimeEventMgr