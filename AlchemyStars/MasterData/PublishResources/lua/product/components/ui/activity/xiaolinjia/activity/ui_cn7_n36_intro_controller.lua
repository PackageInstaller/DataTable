_class("UICN7N36IntroController", UIController)
UICN7N36IntroController = UICN7N36IntroController

function UICN7N36IntroController:OnShow(uiParams)
  self._param = uiParams[1]
  self._cfg = Cfg.cfg_activityintro[self._param]
  if not self._cfg then
    return
  end
  self:_GetComponent()
  self:_OnValue()
end

function UICN7N36IntroController:_GetComponent()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._content = self:GetUIComponent("UILocalizationText", "Content")
  self._animation = self:GetUIComponent("Animation", "uianim")
end

function UICN7N36IntroController:_OnValue()
  self._title:SetText(StringTable.Get(self._cfg.Title))
  self._content:SetText(StringTable.Get(self._cfg.Intro))
  if self._cfg and not string.isnullorempty(self._cfg.ShowAnim) then
    self._animation:Play(self._cfg.ShowAnim)
  end
end

function UICN7N36IntroController:ConfirmBtnOnClick(go)
  self:Lock("UICN7N36IntroController:OnHide")
  if self._cfg and not string.isnullorempty(self._cfg.HideAnim) then
    self._animation:Play(self._cfg.HideAnim)
  end
  self:StartTask(function(TT)
    self:UnLock("UICN7N36IntroController:OnHide")
    self:CloseDialog()
  end, self)
end
