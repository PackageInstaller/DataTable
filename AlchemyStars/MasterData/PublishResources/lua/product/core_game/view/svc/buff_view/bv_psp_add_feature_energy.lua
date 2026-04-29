_class("BuffViewPSPAddFeatureEnergy", BuffViewBase)
BuffViewPSPAddFeatureEnergy = BuffViewPSPAddFeatureEnergy

function BuffViewPSPAddFeatureEnergy:PlayView(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTPopStarProAddFeatureEnergy:New())
end
