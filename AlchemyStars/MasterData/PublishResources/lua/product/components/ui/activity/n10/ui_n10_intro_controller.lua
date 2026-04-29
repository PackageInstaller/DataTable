_class("UIN10IntroController", UIController)
UIN10IntroController = UIN10IntroController

function UIN10IntroController:OnShow(uiParams)
  self._param = uiParams[1]
  self._cfg = Cfg.cfg_activityintro[self._param]
  self:_GetComponent()
  self:_OnValue()
end

function UIN10IntroController:_GetComponent()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._content = self:GetUIComponent("UILocalizationText", "Content")
  self._animation = self:GetUIComponent("Animation", "uianim")
end

function UIN10IntroController:_OnValue()
  self._title:SetText(StringTable.Get(self._cfg.Title))
  self._content:SetText(StringTable.Get(self._cfg.Intro))
  if self._cfg and not string.isnullorempty(self._cfg.ShowAnim) then
    self._animation:Play(self._cfg.ShowAnim)
  end
end

function UIN10IntroController:ConfirmBtnOnClick(go)
  self:Lock("UIN10IntroController:OnHide")
  if self._cfg and not string.isnullorempty(self._cfg.HideAnim) then
    self._animation:Play(self._cfg.HideAnim)
  end
  self:StartTask(function(TT)
    YIELD(TT, 600)
    self:UnLock("UIN10IntroController:OnHide")
    self:CloseDialog()
  end, self)
end
