local HomeBannerData = class("HomeBannerData")
local JumpManager = require("Game.Jump.JumpManager")
local cs_UnityWebRequest = CS.UnityEngine.Networking.UnityWebRequest
local emptyTimeString = ""
local eTimeSetType = {
  AfterMaintenance = 1,
  UntilOnly = 2,
  FullTime = 3,
  FullTimePassNewYear = 4
}
local GetDurationTimeFuncDic = {
  [eTimeSetType.AfterMaintenance] = function(self, timeSetType)
    local startTime = TimeUtil:TimestampToDateString(self.eventStartTimeStamp, false, true, ConfigData:GetTipTag(TipTag.advStartTimeFormat, timeSetType))
    local endTime = emptyTimeString
    return startTime, endTime
  end,
  [eTimeSetType.UntilOnly] = function(self, timeSetType)
    local startTime = emptyTimeString
    local endTime = TimeUtil:TimestampToDateString(self.eventEndTimeStamp, false, true, ConfigData:GetTipTag(TipTag.advEndTimeFormat, timeSetType))
    return startTime, endTime
  end,
  [eTimeSetType.FullTime] = function(self, timeSetType)
    local startTime = TimeUtil:TimestampToDateString(self.eventStartTimeStamp, false, true, ConfigData:GetTipTag(TipTag.advStartTimeFormat, timeSetType))
    local endTime = TimeUtil:TimestampToDateString(self.eventEndTimeStamp, false, true, ConfigData:GetTipTag(TipTag.advEndTimeFormat, timeSetType))
    return startTime, endTime
  end,
  [eTimeSetType.FullTimePassNewYear] = function(self, timeSetType)
    local startTime = TimeUtil:TimestampToDateString(self.eventStartTimeStamp, false, true, ConfigData:GetTipTag(TipTag.advStartTimeFormat, timeSetType))
    local endTime = TimeUtil:TimestampToDateString(self.eventEndTimeStamp, false, true, ConfigData:GetTipTag(TipTag.advEndTimeFormat, timeSetType))
    return startTime, endTime
  end
}

function HomeBannerData.CreateNewBannerData(bannerJsonData)
  local bannerData = HomeBannerData.New()
  bannerData.id = bannerJsonData.id
  bannerData:UpdateBannerData(bannerJsonData)
  return bannerData
end

function HomeBannerData:ctor()
  self.id = nil
  self.pic_name = nil
  self.pic_url = nil
  self.__isOpenUrl = false
  self.targetUrl = nil
  self.__isInnerJump = false
  self.jumpTargetId = nil
  self.jumpArgs = nil
  self.sort = nil
  self.delay = 3
  self.outOfDataTimeStamp = nil
  self.__isShowLeftTime = false
  self.timeSetType = 0
  self.eventStartTimeStamp = 0
  self.eventEndTimeStamp = 0
  self.__IsTriedTurnURL = false
end

function HomeBannerData:UpdateBannerData(bannerJsonData)
  self.pic_name = bannerJsonData.pic_name
  self.pic_url = bannerJsonData.pic_url
  if bannerJsonData.type_id == nil or bannerJsonData.type_id < 0 then
  elseif bannerJsonData.type_id == 0 then
    self.__isOpenUrl = true
    self.targetUrl = bannerJsonData.extra
    self.__urlExtraLogic = bannerJsonData.extra_id or 0
  else
    self.__isInnerJump = true
    if ConfigData.banner_tv[bannerJsonData.type_id] == nil or ConfigData.banner_tv[bannerJsonData.type_id][bannerJsonData.extra_id or 0] == nil then
      error("can't read bannerCfg with type_id:" .. tostring(bannerJsonData.type_id) .. " extra_id:" .. tostring(bannerJsonData.extra_id or 0))
      self.__isInnerJump = false
    else
      local bannerCfg = ConfigData.banner_tv[bannerJsonData.type_id][bannerJsonData.extra_id or 0]
      self.jumpTargetId = bannerCfg.jump_id
      self.jumpArgs = bannerCfg.jump_arg
    end
  end
  self.sort = bannerJsonData.sort
  self.delay = bannerJsonData.delay
  self.outOfDataTimeStamp = Consts.GameChannelType.IsInland() and TimeUtil:TimeStringToTimeStamp(bannerJsonData.end_time) or bannerJsonData.end_time_ts
  self.__isShowLeftTime = bannerJsonData.is_time_limit
  self.timeSetType = bannerJsonData.time_display_type
  self.eventStartTimeStamp = bannerJsonData.event_start_time_ts
  self.eventEndTimeStamp = bannerJsonData.event_end_time_ts
end

function HomeBannerData:GetBannerIsInnerJump()
  return self.__isInnerJump
end

function HomeBannerData:GetBannerIsOpenURL()
  return self.__isOpenUrl
end

function HomeBannerData:GetWebURL()
  if not self.__IsTriedTurnURL then
    if self.__urlExtraLogic == 1 then
      local token = CS.MicaSDKManager.Instance.accessToken
      token = cs_UnityWebRequest.EscapeURL(token)
      if token == nil then
        token = ""
      end
      if string.match(self.targetUrl, "?") ~= nil then
        self.targetUrl = self.targetUrl .. "&token=" .. token
      else
        self.targetUrl = self.targetUrl .. "?token=" .. token
      end
    elseif string.match(self.targetUrl, "h5game=true") ~= nil then
      local url = self.targetUrl
      local UID = PlayerDataCenter.strPlayerId
      local game_channel_id = CS.MicaSDKManager.Instance.SDK_Channel_Id
      local type_id = CS.MicaSDKManager.Instance.Type_id
      url = GR.StringFormat(url, game_channel_id, type_id, UID)
      local args = string.split(url, "?")
      args[2] = CS.AESEncrypt.Encrypt(args[2])
      url = args[1] .. "?token=" .. args[2]
      self.targetUrl = url
    end
    self.__IsTriedTurnURL = true
  end
  return self.targetUrl
end

function HomeBannerData:GetBannerIsShowLeftTime()
  return self.__isShowLeftTime
end

function HomeBannerData:GetBannerLeftTime()
  local curTs = PlayerDataCenter.timestamp
  return self.outOfDataTimeStamp - curTs
end

function HomeBannerData:GetBannerIsOutOfData()
  return self:GetBannerLeftTime() <= 0
end

function HomeBannerData:GetStartAndEndTime()
  local timeSetType = self.timeSetType
  local startTime = emptyTimeString
  local endTime = emptyTimeString
  if GetDurationTimeFuncDic[timeSetType] ~= nil then
    startTime, endTime = GetDurationTimeFuncDic[timeSetType](self, timeSetType)
  end
  return startTime, endTime
end

function HomeBannerData:GetBannerPicUrl()
  return self.pic_url
end

function HomeBannerData:GetIsLotteryOrShopItemClosed()
  if self.jumpTargetId == JumpManager.eJumpTarget.DynLottery then
    if self.jumpArgs == nil or #self.jumpArgs <= 0 then
      return false
    end
    local poolId
    if self.jumpArgs ~= nil then
      poolId = self.jumpArgs[1]
    end
    return not PlayerDataCenter.allLtrData:GetIsSpecificPoolOpen(poolId)
  elseif self.jumpTargetId == JumpManager.eJumpTarget.DynShop then
    if self.jumpArgs == nil or #self.jumpArgs <= 0 then
      return false
    end
    local shopId, shopDataId, shopPageId
    if self.jumpArgs ~= nil then
      shopId = self.jumpArgs[1]
      shopDataId = self.jumpArgs[2]
      shopPageId = self.jumpArgs[3]
    end
    local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    if not ctrl:GetIsUnlock() then
      return true
    end
    if not ctrl:ShopIsUnlock(shopId) then
      return true
    end
    if shopDataId ~= nil and ctrl:GetShelfIsSouldOut(shopId, shopDataId) then
      return true
    end
  elseif self.jumpTargetId == JumpManager.eJumpTarget.DynActivity then
    if self.jumpArgs == nil or #self.jumpArgs <= 0 then
      return false
    end
    return not JumpManager:Jump2DynActivityValidate(self.jumpArgs, true)
  end
  return false
end

function HomeBannerData:GetBannerPicName()
  return self.pic_name
end

return HomeBannerData
