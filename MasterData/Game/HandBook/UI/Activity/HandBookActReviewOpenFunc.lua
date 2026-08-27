local eActivityType = require("Game.ActivityFrame.ActivityFrameEnum").eActivityType
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivitySpringEnum = require("Game.ActivitySpring.Data.ActivitySpringEnum")
local HandBookActReviewOpenFunc = {}
local ReviewCheckIsBlockSpecialProcess = {
  [eActivityType.Spring] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.activity_spring_main)
    local springCfg = ConfigData.activity_spring_main[actId]
    if springCfg == nil then
      return true
    end
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_spring_main)
    return springCfg.handbook_type == ActivitySpringEnum.actHandbookType.Common
  end
}
local ReviewOpenFunc = {
  [eActivityType.WhiteDay] = function(actId, CRPData)
    UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDayHistoryAlbum, function(window)
      if window == nil then
        return
      end
      window:Hide()
      window:InitWDHistoryAlbum(actId)
    end)
  end,
  [eActivityType.Spring] = function(actId, CRPData)
    UIManager:ShowWindowAsync(UIWindowTypeID.Spring23Story, function(window)
      if window == nil then
        return
      end
      ConfigData:LoadDynCfg(eDynConfigData.activity_interact_main_story)
      ConfigData:LoadDynCfg(eDynConfigData.activity_interact_info)
      ConfigData:LoadDynCfg(eDynConfigData.activity_interact_main)
      ConfigData:LoadDynCfg(eDynConfigData.activity_interact_story_level)
      ConfigData:LoadDynCfg(eDynConfigData.activity_lobby)
      local actFrameId = ConfigData.activity.actTypeMapping[eActivityType.Spring][actId]
      window:InitSpring23StoryReview(actFrameId, function()
        ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact_main_story)
        ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact_info)
        ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact_main)
        ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact_story_level)
        ConfigData:ReleaseDynCfg(eDynConfigData.activity_lobby)
      end)
    end)
  end
}
local ReviewProcessFunc = {
  [eActivityType.WhiteDay] = function(actId, callback)
    local handbookCtrl = ControllerManager:GetController(ControllerTypeId.HandBook)
    handbookCtrl:ReqWhiteHistoryData(actId, function(activityPolariodData)
      ConfigData:LoadDynCfg(eDynConfigData.activity_white_day_photo)
      local photoCfgDic = ConfigData.activity_white_day_photo[actId]
      local unlockedPhotoDic = activityPolariodData ~= nil and activityPolariodData.data or {}
      local totalCount = table.count(photoCfgDic) + 2
      local unlockCount = table.count(unlockedPhotoDic) + 1
      if unlockCount + 1 == totalCount then
        unlockCount = totalCount
      end
      ConfigData:ReleaseDynCfg(eDynConfigData.activity_white_day_photo)
      if callback ~= nil then
        callback(unlockCount, totalCount)
      end
    end)
  end,
  [eActivityType.Spring] = function(actId, callback)
    ConfigData:LoadDynCfg(eDynConfigData.activity_interact_info)
    ConfigData:LoadDynCfg(eDynConfigData.activity_lobby)
    local actFrameId = ConfigData.activity.actTypeMapping[eActivityType.Spring][actId]
    local ids = ConfigData.activity_interact_info.activityAvgsDic[actFrameId]
    local unlockCount = 0
    local totalCount = 0
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local firstAvgId = ConfigData.activity_lobby[actFrameId].first_avg
    if ids ~= nil then
      for _, avgId in ipairs(ids) do
        totalCount = totalCount + 1
        if firstAvgId == avgId or avgPlayCtrl:IsAvgPlayed(avgId) then
          unlockCount = unlockCount + 1
        end
      end
    end
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact_info)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_lobby)
    if callback ~= nil then
      callback(unlockCount, totalCount)
    end
  end
}
HandBookActReviewOpenFunc.ReviewOpenFunc = ReviewOpenFunc
HandBookActReviewOpenFunc.ReviewProcessFunc = ReviewProcessFunc
HandBookActReviewOpenFunc.ReviewCheckIsBlockSpecialProcess = ReviewCheckIsBlockSpecialProcess

function HandBookActReviewOpenFunc:OpenHandbookActReview(CRPData, closeCalbback, isShowMask)
  local bgResName, _ = CRPData:GetCPRBgResName()
  if bgResName == nil or #bgResName == 0 then
    UIManager:ShowWindowAsync(UIWindowTypeID.StoryReview, function(window)
      if window == nil then
        return
      end
      window:InitStoryReview(CRPData, closeCalbback)
      window:SetStoryAvgJustClientPlay()
      if isShowMask == nil then
        isShowMask = false
      end
      window:SetObjMaskActive(isShowMask)
    end)
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroPlotReview, function(window)
    if window == nil then
      return
    end
    window:InitCommonPlotReview(CRPData, closeCalbback)
    window:SetPlotAvgJustClientPlay()
  end)
end

return HandBookActReviewOpenFunc
