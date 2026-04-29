_class("StatePetForecastNormal", StatePetForecast)
StatePetForecastNormal = StatePetForecastNormal

function StatePetForecastNormal:OnEnter(TT)
  self:Init()
  self.ui:Flush(false)
end

function StatePetForecastNormal:OnExit(TT)
end
