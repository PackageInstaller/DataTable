local base = ControllerBase
local ActivitySignInMiniGameCtrl = class("ActivitySignInMiniGameCtrl", base)
local ActivitySignInMiniGameData = require("Game.ActivitySignInMiniGame.Data.ActivitySignInMiniGameData")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActivityFrameOpenFunc = require("Game.ActivityFrame.ActivityFrameOpenFunc")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function ActivitySignInMiniGameCtrl:OnInit()
  ConfigData:LoadDynCfg(eDynConfigData.sign_minigame_award)
  ConfigData:LoadDynCfg(eDynConfigData.sign_minigame_emoji)
  ConfigData:LoadDynCfg(eDynConfigData.sign_minigame_range)
  ConfigData:LoadDynCfg(eDynConfigData.sign_minigame_sign)
  ConfigData:LoadDynCfg(eDynConfigData.sign_minigame_text)
end

function ActivitySignInMiniGameCtrl:InitCtrl(activityFrameData)
  if self._actSignInMiniGameData ~= nil then
    error("Cant support more limit signInMiniGame activity")
    return
  end
  self._activityFrameData = activityFrameData
  self._actSignInMiniGameData = ActivitySignInMiniGameData.New()
  self._actSignInMiniGameData:InitActivityFrameData(activityFrameData)
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivitySignInMiniGame)
  self._isOpen = true
end

function ActivitySignInMiniGameCtrl:InitNetWrorkData(msgData)
  if self._isOpen ~= true then
    return
  end
  if msgData == nil then
    error("CS_ACTIVITY_SingleConcreteInfo 返回数据字段activityAnnivSign为空")
    return
  end
  if msgData ~= nil then
    self._isOpen = true
  else
    self._isOpen = false
    return
  end
  self._actSignInMiniGameData:InitNetWrorkData(msgData)
  self:UpdActSignInMiniGameRedDot()
end

function ActivitySignInMiniGameCtrl:GetCurData()
  return self._actSignInMiniGameData
end

function ActivitySignInMiniGameCtrl:GetActSignInMiniGameActData()
  return self._activityFrameData
end

function ActivitySignInMiniGameCtrl:IsOpen()
  return self._isOpen == true
end

function ActivitySignInMiniGameCtrl:SetLoginIsFirstOpen()
  self._isFirstOpen = true
end

function ActivitySignInMiniGameCtrl:GetLoginIsFirstOpen()
  return self._isFirstOpen
end

function ActivitySignInMiniGameCtrl:GetActId()
  return self._actSignInMiniGameData:GetActID()
end

function ActivitySignInMiniGameCtrl:IsCanSignToDay()
  local nextTime = self._actSignInMiniGameData:GetNextSignTime()
  if nextTime == nil then
    return false
  end
  if nextTime == 0 then
    return true
  else
    if self:GetHasSignDayCount() >= self:GetTotalSignDay() then
      return false
    end
    return nextTime <= PlayerDataCenter.timestamp
  end
end

function ActivitySignInMiniGameCtrl:GetTotalSignDay(actId)
  if actId == nil then
    actId = self:GetActId()
  end
  local cfg = ConfigData.sign_minigame_sign[actId]
  if cfg == nil then
    return 0
  end
  return cfg.total_sign_times
end

function ActivitySignInMiniGameCtrl:GetActSignInMiniGameAtlasName()
  local actId = self:GetActId()
  local cfg = ConfigData.sign_minigame_sign[actId]
  if cfg == nil then
    error("Cant get sign_minigame_sign cfg, actId:" .. tostring(actId))
    return ""
  end
  return cfg.atlas_name
end

function ActivitySignInMiniGameCtrl:GetHasSignDayCount()
  return self._actSignInMiniGameData:GetHasSignDayCount()
end

function ActivitySignInMiniGameCtrl:GetLeftDayWithOpenTime(timeStamp)
  local openTime = self._actSignInMiniGameData:GetActOpenTime()
  if openTime ~= nil then
    local leftTime = timeStamp - openTime
    local leftDay = TimeUtil:TimestampToTimeInter(math.floor(leftTime), false, true)
    return leftDay
  end
  return nil
end

function ActivitySignInMiniGameCtrl:GetLeftDayWithCurTime(timeStamp)
  local leftDay1 = self:GetLeftDayWithOpenTime(PlayerDataCenter.timestamp)
  local leftDay2 = self:GetLeftDayWithOpenTime(timeStamp)
  return leftDay1 - leftDay2
end

function ActivitySignInMiniGameCtrl:GetAllSignInDay()
  local allSignDay = {}
  local sings = self._actSignInMiniGameData:GetActSign()
  if sings ~= nil then
    for k, v in pairs(sings) do
      local leftDay = self:GetLeftDayWithOpenTime(v.signTime)
      allSignDay[leftDay] = true
    end
  end
  return allSignDay
end

function ActivitySignInMiniGameCtrl:GetNewSignInDay()
  local sings = self._actSignInMiniGameData:GetActSign()
  if sings ~= nil then
    local count = #sings
    return count, sings[count]
  end
  return nil, nil
end

function ActivitySignInMiniGameCtrl:GetAllSignData()
  return self._actSignInMiniGameData:GetActSign()
end

function ActivitySignInMiniGameCtrl:GetIsPlayedCartoon()
  return self._actSignInMiniGameData:GetActivityIscartoonPlayed()
end

function ActivitySignInMiniGameCtrl:GetSignInMiniGameFirstAvg()
  local actId = self:GetActId()
  local cfg = ConfigData.sign_minigame_sign[actId]
  if cfg == nil then
    error("Cant get sign_minigame_sign cfg, actId:" .. tostring(actId))
    return ""
  end
  return cfg.avg_id
end

function ActivitySignInMiniGameCtrl:GetSignDataRange(signDataIndex)
  local actID = self:GetActId()
  local awardGroup = self._actSignInMiniGameData:GetActAwardGroup()
  if awardGroup ~= nil and ConfigData.sign_minigame_award[actID] ~= nil and ConfigData.sign_minigame_award[actID][awardGroup] ~= nil and ConfigData.sign_minigame_award[actID][awardGroup][signDataIndex] ~= nil then
    return ConfigData.sign_minigame_award[actID][awardGroup][signDataIndex].range
  end
  return nil
end

function ActivitySignInMiniGameCtrl:UpdActSignInMiniGameRedDot()
  local reddotNode = self._actSignInMiniGameData:GetActivityReddotNode()
  if reddotNode == nil then
    return
  end
  local showReddot = self:IsCanSignToDay()
  reddotNode:SetRedDotCount(showReddot and 1 or 0)
end

function ActivitySignInMiniGameCtrl:CS_ACTIVITY_SignMiniGame_Sign(emojiId, callback)
  self.networkCtrl:CS_ACTIVITY_SignMiniGame_Sign(self:GetActId(), emojiId, function(args)
    if args ~= nil and args.Count > 0 then
      local msgData = args[0]
      self:InitNetWrorkData(msgData.data)
      self.cacheAward = msgData.award
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivitySignInMiniGameCtrl:CS_ACTIVITY_SignMiniGame_PlayCartoon()
  self.networkCtrl:CS_ACTIVITY_SignMiniGame_PlayCartoon(self:GetActId(), function(args)
    if args ~= nil and args.Count > 0 then
      self:SetActivityIscartoonPlayed()
    end
  end)
end

function ActivitySignInMiniGameCtrl:ShowAward()
  local rewardDic = self.cacheAward
  local rewardIdList = {}
  local rewardNumList = {}
  for k, v in pairs(rewardDic) do
    table.insert(rewardIdList, k)
    table.insert(rewardNumList, v)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window ~= nil then
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIdList, rewardNumList)
      window:AddAndTryShowReward(CRData)
    end
  end)
end

function ActivitySignInMiniGameCtrl:CloseActLimitTaskCtrl(activityFrameData)
  if UIManager:GetWindow(UIWindowTypeID.SignInMiniGame) ~= nil then
    UIUtil.ReturnHome()
  end
  self:Delete()
end

function ActivitySignInMiniGameCtrl:OnDelete()
  ConfigData:ReleaseDynCfg(eDynConfigData.sign_minigame_award)
  ConfigData:ReleaseDynCfg(eDynConfigData.sign_minigame_emoji)
  ConfigData:ReleaseDynCfg(eDynConfigData.sign_minigame_range)
  ConfigData:ReleaseDynCfg(eDynConfigData.sign_minigame_sign)
  ConfigData:ReleaseDynCfg(eDynConfigData.sign_minigame_text)
end

return ActivitySignInMiniGameCtrl
