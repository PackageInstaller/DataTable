_class("UIActivityN7Intro", UIController)
UIActivityN7Intro = UIActivityN7Intro

function UIActivityN7Intro:OnShow(uiParams)
  self._param = uiParams[1] or "nil"
  self._cfg = Cfg.cfg_activityintro[self._param]
  if self._cfg == nil then
    Log.fatal("###[UIActivityN7Intro] self._cfg is nil. param --> ", self._param)
  end
  self:InitWidget()
  self:_OnValue()
end

function UIActivityN7Intro:InitWidget()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._content = self:GetUIComponent("UILocalizationText", "Content")
end

function UIActivityN7Intro:_OnValue()
  self._title:SetText(StringTable.Get(self._cfg.Title))
  self._content:SetText(StringTable.Get(self._cfg.Intro))
end

function UIActivityN7Intro:btnCloseOnClick(go)
  self:Lock("UIActivityN7Intro:OnHide")
  self:StartTask(function(TT)
    YIELD(TT, 600)
    self:UnLock("UIActivityN7Intro:OnHide")
    self:CloseDialog()
  end, self)
end
