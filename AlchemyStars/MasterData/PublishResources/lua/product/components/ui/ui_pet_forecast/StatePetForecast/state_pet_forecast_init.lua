_class("StatePetForecastInit", StatePetForecast)
StatePetForecastInit = StatePetForecastInit

function StatePetForecastInit:OnEnter(TT)
  self:Init()
  self.ui:Init()
  if self.data:IsAllAccepted() and self.data:HasNewPieceImage() then
    self.fsm:ChangeState(StatePetForecast.NewUnlockNormal)
  else
    self.fsm:ChangeState(StatePetForecast.Normal)
  end
end

function StatePetForecastInit:OnExit(TT)
end
