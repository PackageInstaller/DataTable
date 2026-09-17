local this = class("signInGE", L_GameEventStore.baseGameEventCls)

function this:initData()
  self.count = 0
  self.time = 0
  self.show = true
  self.dayChange = false
end

function this:populate(protoData)
  local data = protoData.sign
  if self.count ~= 0 and data.count > self.count then
    self.dayChange = true
  end
  self.count = data.count
  self.time = data.time
  self.show = data.show
  printf("同步数据111", self)
end

function this:checkValid()
  if not L_TimeUtil.isSameMonth(self._time, L_TimeUtil.getServerTime()) then
    self:initData()
  end
end

function this:needShow()
  return self.count > 0 and L_TimeUtil.isSameDay(L_TimeUtil.getServerTime(), self.time) and not self.show
end

function this:req_signIn(cb)
  self.show = true
  L_Net:sendMessage(MsgGenCode.CSProtoActivitySign, {
    u32 = self.id
  }, cb)
end

return this
