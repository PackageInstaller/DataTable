local GameTimeEventManager, Super = System.NewClass("GameTimeEventManager", Manager, IUpdater)

function GameTimeEventManager:ctor()
  Super.ctor(self)
  self.waitServerTimeTimer = nil
  self.zeroOclockTimer = nil
  self.fiveOclockTimer = nil
end

function GameTimeEventManager:Awake(binder)
  Super.Awake(self)
  self.binder = binder
end

function GameTimeEventManager:OnDestroy()
  Super.OnDestroy(self)
end

function GameTimeEventManager:Enable()
  if self.waitServerTimeTimer then
    self.binder:StopTimer(self.waitServerTimeTimer)
  end
  self.waitServerTimeTimer = self.binder:BindTimer(0, -1, function()
    if 0 ~= TimeUtils.GetRawServerTime() then
      self.binder:StopTimer(self.waitServerTimeTimer)
      self.waitServerTimeTimer = nil
      local delayTime = 5
      local nextZeroOclock = TimeUtils.GetSecondToNextDayClock(0, 0) + delayTime
      Logger.Info("Create ZeroOclock Timer", nextZeroOclock)
      self.zeroOclockTimer = self.binder:BindTimer(nextZeroOclock, 0, nil, System.fn(self, self.OnZeroOclock))
      local nextFiveOclock = TimeUtils.GetSecondToNextDayClock(5, 0) + delayTime
      Logger.Info("Create FiveOclock Timer", nextFiveOclock)
      self.fiveOclockTimer = self.binder:BindTimer(nextFiveOclock, 0, nil, System.fn(self, self.OnFiveOclock))
    end
  end, nil)
end

function GameTimeEventManager:Disable()
  self.binder:StopTimer(self.waitServerTimeTimer)
  self.waitServerTimeTimer = nil
  self.binder:StopTimer(self.zeroOclockTimer)
  self.zeroOclockTimer = nil
  self.binder:StopTimer(self.fiveOclockTimer)
  self.fiveOclockTimer = nil
end

function GameTimeEventManager:OnZeroOclock()
  Logger.Info("OnZeroOclock")
  EventMgr.Instance.OnZeroOclock:Dispatch()
end

function GameTimeEventManager:OnFiveOclock()
  Logger.Info("OnFiveOclock")
  EventMgr.Instance.OnFiveOclock:Dispatch()
  MainShopDataUtils.ReqShopData()
end

return GameTimeEventManager
