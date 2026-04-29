_class("StatePetForecastNewUnlockLast", StatePetForecast)
StatePetForecastNewUnlockLast = StatePetForecastNewUnlockLast

function StatePetForecastNewUnlockLast:OnEnter(TT)
  self:Init()
  if self.data.last then
    self.ui:PlayPetForecastView(self.data.last)
    while self.ui:IsPlaying() do
      YIELD(TT)
    end
    self.fsm:ChangeState(StatePetForecast.NewUnlockNormal)
  else
    self.fsm:ChangeState(StatePetForecast.Normal)
  end
end

function StatePetForecastNewUnlockLast:OnExit(TT)
end
