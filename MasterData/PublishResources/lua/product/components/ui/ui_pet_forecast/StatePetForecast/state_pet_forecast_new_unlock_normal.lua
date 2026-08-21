_class("StatePetForecastNewUnlockNormal", StatePetForecast)
StatePetForecastNewUnlockNormal = StatePetForecastNewUnlockNormal

function StatePetForecastNewUnlockNormal:OnEnter(TT)
  self:Init()
  if self.data.normal then
    self.ui:PlayPetForecastView(self.data.normal)
  else
    self.fsm:ChangeState(StatePetForecast.Normal)
  end
end

function StatePetForecastNewUnlockNormal:OnExit(TT)
end
