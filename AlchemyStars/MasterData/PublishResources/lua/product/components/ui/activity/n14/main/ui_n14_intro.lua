_class("UIN14Intro", UIController)
UIN14Intro = UIN14Intro

function UIN14Intro:OnShow(uiParams)
  self._param = uiParams[1] or "nil"
  self._cfg = Cfg.cfg_activityintro[self._param]
  if self._cfg == nil then
    Log.fatal("###[UIActivityN11Intro] self._cfg is nil. param --> ", self._param)
  end
  self.anim = self:GetGameObject():GetComponent("Animation")
  self.Content = self:GetUIComponent("UILocalizationText", "txtDesc")
  self._TitleText = self:GetUIComponent("UILocalizationText", "txtTitle")
end

function UIN14Intro:OnHide()
end

function UIN14Intro:btnCloseOnClick(go)
  self:CloseDialog()
end
