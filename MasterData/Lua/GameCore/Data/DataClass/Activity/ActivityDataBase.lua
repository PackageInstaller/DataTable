local ActivityDataBase = class("ActivityDataBase")
local LocalData = require("GameCore.Data.LocalData")

function ActivityDataBase:ctor(mapActData)
  self.nActId = mapActData.Id
  self.actCfg = nil
  self.nOpenTime = mapActData.StartTime
  self.nEndTime = mapActData.EndTime
  self.bRedDot = false
  self.bBanner = false
  self.actCfg = ConfigTable.GetData("Activity", self.nActId)
  self.bPlay = self:CheckActPlay()
  self:Init()
end

function ActivityDataBase:Init()
end

function ActivityDataBase:UpdateActivityState(mapState)
  self.bRedDot = mapState.RedDot
  self.bBanner = mapState.Banner
end

function ActivityDataBase:RefreshActivityData(mapActData)
  self.nOpenTime = mapActData.StartTime
  self.nEndTime = mapActData.EndTime
end

function ActivityDataBase:GetActId()
  return self.nActId
end

function ActivityDataBase:GetActCfgData()
  return self.actCfg
end

function ActivityDataBase:GetActType()
  return self.actCfg.ActivityType
end

function ActivityDataBase:CheckActivityOpen()
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  if self.actCfg.EndType == GameEnum.activityEndType.NoLimit then
    return self.nOpenTime > 0
  else
    return curTime < self.nEndTime and self.nOpenTime > 0
  end
end

function ActivityDataBase:CheckActShow()
  if self.actCfg.PreLimit == GameEnum.activityPreLimit.WorldClass then
    local nCurWorldClass = PlayerData.Base:GetWorldClass()
    local nNeedWorldClass = tonumber(self.actCfg.LimitParam)
    if nCurWorldClass < nNeedWorldClass then
      return false
    end
  elseif self.actCfg.PreLimit == GameEnum.activityPreLimit.questLimit then
    local nStoryId = tonumber(self.actCfg.LimitParam)
    local bReaded = PlayerData.Avg:IsStoryReaded(nStoryId)
    if not bReaded then
      return false
    end
  end
  if self.actCfg.EndType == GameEnum.activityEndType.NoLimit then
    return not self.bBanner and self:CheckActivityOpen()
  else
    return self:CheckActivityOpen()
  end
end

function ActivityDataBase:CheckHideFromActList()
  if self.actCfg ~= nil then
    return self.actCfg.HideFromActivityList
  end
  return true
end

function ActivityDataBase:GetPlayState()
  return self.bPlay
end

function ActivityDataBase:RefreshPlayState()
  self.bPlay = self:CheckActPlay()
end

function ActivityDataBase:CheckActPlay()
  if self.actCfg.PlayCond == GameEnum.activityPreLimit.WorldClass then
    local nCurWorldClass = PlayerData.Base:GetWorldClass()
    local nNeedWorldClass = tonumber(self.actCfg.PlayCondParams)
    if nCurWorldClass < nNeedWorldClass then
      return false
    end
  elseif self.actCfg.PlayCond == GameEnum.activityPreLimit.questLimit then
    local nStoryId = tonumber(self.actCfg.PlayCondParams)
    local bReaded = PlayerData.Avg:IsStoryReaded(nStoryId)
    if not bReaded then
      return false
    end
  end
  if self.actCfg.EndType == GameEnum.activityEndType.NoLimit then
    return not self.bBanner and self:CheckActivityOpen()
  else
    return self:CheckActivityOpen()
  end
end

function ActivityDataBase:CheckActJumpCond(bShowTips)
  local bPlayCond = true
  local sTips = ""
  if self.actCfg.PlayCond == GameEnum.activityPreLimit.WorldClass then
    local nCurWorldClass = PlayerData.Base:GetWorldClass()
    local nNeedWorldClass = tonumber(self.actCfg.PlayCondParams)
    if nCurWorldClass < nNeedWorldClass then
      bPlayCond = false
      sTips = orderedFormat(ConfigTable.GetUIText("Activity_Play_Cond_Tip_1"), nNeedWorldClass)
    end
  elseif self.actCfg.PlayCond == GameEnum.activityPreLimit.questLimit then
    local nStoryId = tonumber(self.actCfg.LimitParam)
    local bReaded = PlayerData.Avg:IsStoryReaded(nStoryId)
    if not bReaded then
      bPlayCond = false
      local cfgData = ConfigTable.GetData_Story(nStoryId)
      local sName = ""
      if cfgData ~= nil then
        sName = cfgData.Title
      end
      sTips = orderedFormat(ConfigTable.GetUIText("Activity_Play_Cond_Tip_2"), sName)
    end
  end
  if not bPlayCond and bShowTips then
    EventManager.Hit(EventId.OpenMessageBox, sTips)
  end
  return bPlayCond, sTips
end

function ActivityDataBase:CheckRewardAllReceive()
  return false
end

function ActivityDataBase:GetActivityRedDot()
  return self.bRedDot
end

function ActivityDataBase:GetActOpenTime()
  return self.nOpenTime
end

function ActivityDataBase:GetActEndTime()
  return self.nEndTime
end

function ActivityDataBase:GetActSortId()
  return self.actCfg.SortId
end

function ActivityDataBase:CheckPopUp()
  local localData = LocalData.GetPlayerLocalData("Act_PopUp_DontShow" .. self.nActId)
  if localData then
    return false
  end
  return PlayerData.PopUp:IsNeedActPopUp(self.nActId)
end

function ActivityDataBase:CheckShowBanner()
  return self:CheckActPlay() and self.actCfg.BannerRes ~= "" and self.bBanner == false
end

function ActivityDataBase:GetBannerPng()
  return self.actCfg.BannerRes
end

function ActivityDataBase:RefreshRedDot()
end

function ActivityDataBase:RefreshStateData(bRedDot, bBanner)
  self.bRedDot = bRedDot
  self.bBanner = bBanner
end

function ActivityDataBase:UpdateStatus()
end

function ActivityDataBase:GetSpecialParam()
  return self.actCfg.SpecialParam
end

return ActivityDataBase
