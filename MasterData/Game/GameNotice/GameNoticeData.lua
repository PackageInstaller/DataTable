local GameNoticeData = class("GameNoticeData")
local GameNoticEnum = require("Game.GameNotice.GameNoticEnum")

function GameNoticeData.CreateData(jasonData)
  local noticeData = GameNoticeData.New()
  noticeData.idx = jasonData.id
  noticeData:UpdateBaseGNData(jasonData)
  return noticeData
end

function GameNoticeData:ctor()
  self.idx = nil
  self.type = nil
  self.name = nil
  self.startTimeStamp = nil
  self.endTimeStamp = nil
  self.template = nil
  self.targetUrl = nil
  self.picName = nil
  self._jumpType = GameNoticEnum.eJumpType.none
  self._jumpTargetId = nil
  self._jumpArgs = nil
  self._jumpUrl = nil
  self.__IsTriedTurnURL = false
end

function GameNoticeData:UpdateBaseGNData(jasonData)
  self.type = jasonData.type
  self.name = jasonData.name
  self.endTimeStamp = jasonData.end_time
  self.startTimeStamp = jasonData.start_time
  self.template = jasonData.content_type_id
  self.picName = jasonData.pic_name
  self:_UpdateJumpData(jasonData)
  self:_UpdateTargetUrl(jasonData)
end

function GameNoticeData:_UpdateTargetUrl(jasonData)
  local targetUrl = ""
  if jasonData.content_type_id == GameNoticEnum.eTemplates.banner then
    targetUrl = jasonData.content
  end
  self.targetUrl = targetUrl
end

function GameNoticeData:_UpdateJumpData(jasonData)
  if self.template ~= GameNoticEnum.eTemplates.banner and jasonData.skip == nil then
    return
  end
  if jasonData.skip.jump_type_id == nil then
    return
  end
  self._jumpType = jasonData.skip.jump_type_id
  if self:IsJumpInner() then
    self._jumpTargetId = jasonData.skip.jump_id
    self._jumpArgs = jasonData.skip.jump_arg
    return
  end
  if self:IsJumpOuter() then
    self._jumpUrl = jasonData.skip.jump_url
    return
  end
end

function GameNoticeData:IsOutOfDate()
  return self:GetGNLeftDate() < 0
end

function GameNoticeData:HasBannerPicName()
  return self.picName ~= nil
end

function GameNoticeData:IsJumpInner()
  return self._jumpType == GameNoticEnum.eJumpType.inner
end

function GameNoticeData:IsJumpOuter()
  return self._jumpType == GameNoticEnum.eJumpType.outer
end

function GameNoticeData:GetJumpID()
  return self._jumpTargetId
end

function GameNoticeData:GetJumpArgs()
  return self._jumpArgs
end

function GameNoticeData:GetJumpUrl()
  if self.__IsTriedTurnURL then
    return self._jumpUrl
  end
  if self:IsJumpOuter() and self.template == GameNoticEnum.eTemplates.banner then
    local token = CS.MicaSDKManager.Instance.accessToken
    token = CS.UnityEngine.Networking.UnityWebRequest.EscapeURL(token)
    if token == nil then
      token = ""
    end
    local url = self._jumpUrl
    if string.match(url, "?") ~= nil then
      url = url .. "&token=" .. token
    else
      url = url .. "?token=" .. token
    end
    self._jumpUrl = url
  end
  self.__IsTriedTurnURL = true
  return self._jumpUrl
end

function GameNoticeData:GetGNLeftDate()
  return self.endTimeStamp - PlayerDataCenter.timestamp
end

return GameNoticeData
