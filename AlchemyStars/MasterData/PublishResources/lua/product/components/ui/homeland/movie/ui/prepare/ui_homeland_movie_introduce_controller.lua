_class("UIHomelandMovieIntroduceController", UIController)
UIHomelandMovieIntroduceController = UIHomelandMovieIntroduceController

function UIHomelandMovieIntroduceController:OnShow(uiParams)
  self._movieId = uiParams[1]
  self:InitWidget()
  self:_OnValue()
end

function UIHomelandMovieIntroduceController:InitWidget()
  self.txtContent = self:GetUIComponent("UILocalizationText", "txtContent")
  self.posterBg = self:GetUIComponent("RawImageLoader", "posterBg")
end

function UIHomelandMovieIntroduceController:_OnValue()
  if not self._movieId then
    Log.error("UIHomelandMovieIntroduceController uiParmas error, movieId is null")
    return
  end
  local movieCfg = Cfg.cfg_homeland_movice[self._movieId]
  if not movieCfg then
    Log.error("UIHomelandMovieIntroduceController uiParmas error, can't find movie cfg_homeland_movice id = " .. self._movieId)
    return
  end
  self.txtContent:SetText(StringTable.Get(movieCfg.Intro))
  self.posterBg:LoadImage(movieCfg.Poster)
end

function UIHomelandMovieIntroduceController:BtnBackOnClick(go)
  self:CloseDialog()
end
