_class("UIActivityN20Intro", UIController)
UIActivityN20Intro = UIActivityN20Intro

function UIActivityN20Intro:OnShow(uiParams)
  self._param = uiParams[1] or "nil"
  self._cfg = Cfg.cfg_activityintro[self._param]
  if self._cfg == nil then
    Log.fatal("###[UIActivityN20Intro] self._cfg is nil. param --> ", self._param)
  end
  self:InitWidget()
  self:_OnValue()
end

function UIActivityN20Intro:InitWidget()
  self._title = self:GetUIComponent("UILocalizationText", "Title")
  self._des = self:GetUIComponent("UILocalizationText", "Des")
  self._subTitle = self:GetUIComponent("UILocalizationText", "SubTitle")
  self._subTitlePanel = self:GetGameObject("SubTitlePanel")
end

function UIActivityN20Intro:_OnValue()
  self._title:SetText(StringTable.Get(self._cfg.Title))
  self._des:SetText(StringTable.Get(self._cfg.Intro))
  if self._cfg.SubTitle == nil or self._cfg.SubTitle == "" then
    self._subTitlePanel:SetActive(false)
  else
    self._subTitlePanel:SetActive(true)
    self._subTitle:SetText(StringTable.Get(self._cfg.SubTitle))
  end
end

function UIActivityN20Intro:btnCloseOnClick(go)
  self:Lock("UIActivityN20Intro:OnHide")
  self:StartTask(function(TT)
    self:UnLock("UIActivityN20Intro:OnHide")
    self:CloseDialog()
  end, self)
end
