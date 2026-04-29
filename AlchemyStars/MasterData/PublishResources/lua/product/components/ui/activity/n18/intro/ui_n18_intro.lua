_class("UIN18Intro", UIController)
UIN18Intro = UIN18Intro

function UIN18Intro:OnShow(uiParams)
  self._param = uiParams[1] or "nil"
  self._cfg = Cfg.cfg_activityintro[self._param]
  if self._cfg == nil then
    Log.fatal("###[UIN18Intro] self._cfg is nil. param --> ", self._param)
  end
  self.anim = self:GetGameObject():GetComponent("Animation")
  self.Content = self:GetUIComponent("UILocalizationText", "Content")
  self._TitleText = self:GetUIComponent("UILocalizationText", "txtTitle")
  self:Flush()
  self:PlayAnim(true)
end

function UIN18Intro:OnHide()
end

function UIN18Intro:Flush()
  self.Content:SetText(StringTable.Get(self._cfg.Intro))
  self._TitleText:SetText(StringTable.Get(self._cfg.Title))
end

function UIN18Intro:btnCloseOnClick(go)
  self:PlayAnim(false, function()
    self:CloseDialog()
  end)
end

function UIN18Intro:bgOnClick(go)
  self:PlayAnim(false, function()
    self:CloseDialog()
  end)
end

function UIN18Intro:PlayAnim(isIn, callback)
  self:StartTask(function(TT)
    self:Lock("UIN18IntroPlayAnim")
    if isIn then
      self.anim:Play("uieff_Activity_UISummer1Intro_In")
      YIELD(TT, 500)
    else
      self.anim:Play("uieff_Activity_UISummer1Intro_Out")
      YIELD(TT, 500)
    end
    self:UnLock("UIN18IntroPlayAnim")
    if callback then
      callback()
    end
  end, self)
end
