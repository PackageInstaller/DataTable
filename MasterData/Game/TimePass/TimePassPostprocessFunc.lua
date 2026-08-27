local NoticeData = require("Game.Notice.NoticeData")
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon
local TimePassPostprocessFunc = {
  [proto_object_CounterModule.CounterModuleDailyChallenge] = function(isUpdate)
    local _, periodicRedNote = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, RedDotStaticTypeId.PeriodicChallenge)
    if periodicRedNote ~= nil then
      local num = PlayerDataCenter.periodicChallengeData:GetIsDailyChallengeFished() and 0 or 1
      periodicRedNote:SetRedDotCount(num)
    end
  end,
  [proto_object_CounterModule.CounterModuleGlobalDailyFlush] = function(isUpdate)
    if not isUpdate then
      return
    end
    NoticeManager:RefreshDungeonRewardRateNotice(true, false)
  end,
  [proto_object_CounterModule.CounterModuleMaintain] = function(isUpdate, data, timeFuncData)
    if not isUpdate then
      return
    end
    local maintianTimeStamp = data.nextExpiredTm
    if timeFuncData.maintainTimerId ~= nil then
      TimerManager:StopTimer(timeFuncData.maintainTimerId)
      timeFuncData.maintainTimerId = nil
      timeFuncData.maintainTimeIsPoped = {}
    end
    timeFuncData.maintainTimerId = TimerManager:StartTimer(1, function()
      local beforeMaintainSpan = maintianTimeStamp - PlayerDataCenter.timestamp
      if beforeMaintainSpan < 0 then
        TimerManager:StopTimer(timeFuncData.maintainTimerId)
        timeFuncData.maintainTimerId = nil
        timeFuncData.maintainTimeIsPoped = {}
        return
      end
      local timeList = ConfigData.game_config.maintainNoticeTimeList
      for index, noticeTime in ipairs(timeList) do
        if noticeTime > beforeMaintainSpan then
          if timeFuncData.maintainTimeIsPoped[noticeTime] then
            return
          end
          timeFuncData.maintainTimeIsPoped[noticeTime] = true
          local min = 0
          local second = 0
          min = noticeTime // 60
          second = noticeTime % 60
          local str = ""
          if 0 < min then
            str = str .. tostring(min) .. ConfigData:GetTipContent(TipContent.TimeName_min)
          end
          if 0 < second then
            str = str .. tostring(second) .. ConfigData:GetTipContent(TipContent.TimeName_second)
          end
          cs_MessageCommon.ShowMessageTips(string.format(ConfigData:GetTipContent(TipContent.MaintainNotice), str), false, 2.5)
          if index == 1 then
            TimerManager:StopTimer(timeFuncData.maintainTimerId)
            timeFuncData.maintainTimerId = nil
            timeFuncData.maintainTimeIsPoped = {}
          end
          return
        end
      end
    end, nil, nil, nil, true)
  end
}
return TimePassPostprocessFunc
