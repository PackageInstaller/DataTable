_class("StatePetForecast", State)
StatePetForecast = StatePetForecast

function StatePetForecast:Init()
  self.fsm = self:GetFsm()
  self.ui = self.fsm:GetData()
  self.data = self.ui._forecastData
end

function StatePetForecast:Destroy()
  StatePetForecast.super:Destroy()
  self.ui = nil
end
