local PlayerDataRequestor = NewClass("PlayerDataRequestor")

function PlayerDataRequestor:ctor()
  self.requestList = {}
end

function PlayerDataRequestor:Start()
  self.isRunning = true
  self.curIndex = 0
  self.totalCount = #self.requestList
end

function PlayerDataRequestor:Update()
  if not self.isRunning then
    return
  end
  self.curIndex = self.curIndex + 1
  if self.curIndex <= self.totalCount then
    local curFun = self.requestList[self.curIndex]
    NetBlockMgr.Instance.CancelBlocked(true)
    curFun()
    NetBlockMgr.Instance.CancelBlocked(false)
  end
  if self.curIndex >= self.totalCount then
    self:Stop()
  end
end

function PlayerDataRequestor:Stop()
  self.isRunning = false
  self.curIndex = 0
end

PlayerDataRequestor.Instance = PlayerDataRequestor()
return PlayerDataRequestor
