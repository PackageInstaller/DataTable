local this = class("baseGameEvent")

function this:ctor(eventId, type, data)
  self.id = eventId
  self.type = type
  self.data = data
  self.ptShopNoticeTime = 0
  self:initData()
end

function this:setPtShopNoticeTime(noticeTime)
  self.ptShopNoticeTime = noticeTime
end

function this:getType()
  return self.type
end

function this:initData()
end

function this:populate(protoData)
end

function this:dispose()
end

function this:checkRedDot()
  return false
end

function this:isActivityCompleted()
  return false
end

function this:getRedState()
  return false
end

function this:markGERed(isActive)
  if isActive then
    L_ReddotManager:markNew(L_ReddotManager.DotDef.GameAct_Events_Group_Reward, self.id)
  else
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.GameAct_Events_Group_Reward, self.id)
  end
  self:call(this.event.gameEventReward)
end

function this:getPtShopRedState()
  if self.ptShopNoticeTime > 0 then
    local dotKey = string.format("IsShowPtShop_%d", self.id)
    local value = L_CommonUtil.getLocalValue(dotKey)
    if not value or tonumber(value) ~= 1 then
      local serverTime = L_TimeUtil.getServerTime()
      if serverTime < self.ptShopNoticeTime then
        local noticeDay = L_GameTpl:getGameConstTpl():getData("ptshop_trade_notice", L_Const.GameTplType.int)
        if serverTime > self.ptShopNoticeTime - noticeDay * 24 * 60 * 60 then
          return true
        end
      end
    end
  end
  return false
end

return this
