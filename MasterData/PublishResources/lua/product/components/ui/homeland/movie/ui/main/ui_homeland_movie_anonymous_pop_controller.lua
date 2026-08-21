_class("UIHomelandAnonymousPopController", UIController)
UIHomelandAnonymousPopController = UIHomelandAnonymousPopController

function UIHomelandAnonymousPopController:Constructor()
  self._cfg = Cfg.cfg_homeland_movice_expain({})
  self._widgets = {}
end

function UIHomelandAnonymousPopController:OnShow(uiParams)
  self.AnonymousId = uiParams[1]
  self:InitWidget()
  self:SetData()
end

function UIHomelandAnonymousPopController:OnHide()
end

function UIHomelandAnonymousPopController:InitWidget()
  self._mainTitle = self:GetUIComponent("RawImageLoader", "mainTitle")
  self._noticeText = self:GetUIComponent("UILocalizationText", "noticeText")
end

function UIHomelandAnonymousPopController:SetData()
  self._noticeText:SetText(StringTable.Get("str_movie_letter_text_8"))
end

function UIHomelandAnonymousPopController:BGOnClick(TT)
  self:CloseDialog()
  self:ShowDialog("UIHomelandAnonymousMovieController", self.AnonymousId)
end
