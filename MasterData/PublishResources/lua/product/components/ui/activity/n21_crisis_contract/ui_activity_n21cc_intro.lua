_class("UIActivityN21CCIntro", UIController)
UIActivityN21CCIntro = UIActivityN21CCIntro

function UIActivityN21CCIntro:OnShow(uiParams)
  self._param = uiParams[1] or "nil"
  self._cfg = Cfg.cfg_activityintro[self._param]
  if self._cfg == nil then
    Log.fatal("###[UIActivityN21CCIntro] self._cfg is nil. param --> ", self._param)
  end
  self:InitWidget()
  self:_OnValue()
end

function UIActivityN21CCIntro:InitWidget()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._subTitlePanel = self:GetGameObject("SubTitlePanel")
  self._subTitle = self:GetUIComponent("UILocalizationText", "SubTitle")
end

function UIActivityN21CCIntro:_OnValue()
  if self._cfg.SubTitle == nil or self._cfg.SubTitle == "" then
    self._subTitlePanel:SetActive(false)
  else
    self._subTitlePanel:SetActive(true)
    self._subTitle:SetText(StringTable.Get(self._cfg.SubTitle))
  end
  self._title:SetText(StringTable.Get(self._cfg.Title))
  self._desLabel:SetText(StringTable.Get(self._cfg.Intro))
end

function UIActivityN21CCIntro:btnCloseOnClick(go)
  self:Lock("UIActivityN21CCIntro:OnHide")
  self:StartTask(function(TT)
    self:UnLock("UIActivityN21CCIntro:OnHide")
    self:CloseDialog()
  end, self)
end
