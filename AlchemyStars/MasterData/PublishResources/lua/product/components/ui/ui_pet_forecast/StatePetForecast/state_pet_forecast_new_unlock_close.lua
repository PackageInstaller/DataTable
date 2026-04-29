_class("StatePetForecastNewUnlockClose", StatePetForecast)
StatePetForecastNewUnlockClose = StatePetForecastNewUnlockClose

function StatePetForecastNewUnlockClose:OnEnter(TT)
  self:Init()
  if self.data.close then
    self.ui:PlayPetForecastView(self.data.close)
    while self.ui:IsPlaying() do
      YIELD(TT)
    end
  end
  self.ui:CloseDialog()
end

function StatePetForecastNewUnlockClose:OnExit(TT)
end
