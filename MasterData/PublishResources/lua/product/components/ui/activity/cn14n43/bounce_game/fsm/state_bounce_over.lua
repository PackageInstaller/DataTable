_class("StateBounceOver", StateBounceBase)
StateBounceOver = StateBounceOver

function StateBounceOver:OnEnter(TT, ...)
  self:Init()
  self.uiController:ShowResult()
  
  local function callback()
    self.uiController:QuickGame()
  end
  
  local killedBoss = self.bounceData:GetKilledBoss()
  self.uiController:BounceMissionSettle(self.bounceData:GetMissionId(), self.bounceData:GetScore(), killedBoss and 1 or 0, self.bounceData:GetLastTime(), callback)
end

function StateBounceOver:OnExit(TT)
end
