_class("UIPetForecastComic", UICustomWidget)
UIPetForecastComic = UIPetForecastComic

function UIPetForecastComic:SetData(day, forecastData, isSelected)
  self.day = day
  self._forecastData = forecastData
  local piece = self._forecastData:GetPiece(day)
  local unlock = piece.state == PredictionStatus.PRES_Accepted
  local unreach = piece.state == PredictionStatus.PRES_UnReach
  local state = unlock and "unlock" or "lock"
  local comicImg = self._forecastData:GetCfg_imgs(day, state)
  UIWidgetHelper.SetRawImage(self, "_img", comicImg)
  local key = unreach and "colorUnreach" or nil
  self._forecastData:SetObjColor(self, "RawImage", "_img", key)
end
