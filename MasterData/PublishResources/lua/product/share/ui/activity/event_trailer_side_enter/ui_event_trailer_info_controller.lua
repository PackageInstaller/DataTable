_class("UIEventTrailerInfoController", UIController)
UIEventTrailerInfoController = UIEventTrailerInfoController

function UIEventTrailerInfoController:Constructor()
end

function UIEventTrailerInfoController:OnShow(uiParams)
  self._data = uiParams[1]
  self._cfg = self._data.cfg
  self._startTime = self._data.startTime
  self._endTime = self._data.endTime
  self:GetComponents()
  self:InitComponents()
end

function UIEventTrailerInfoController:GetComponents()
  self._campaignPic = self:GetUIComponent("RawImageLoader", "campaignPic")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._time1 = self:GetUIComponent("UILocalizationText", "time1")
  self._time2 = self:GetUIComponent("UILocalizationText", "time2")
  self._intro = self:GetUIComponent("UILocalizationText", "intro")
  self._anim = self:GetUIComponent("Animation", "anim")
end

function UIEventTrailerInfoController:InitComponents()
  if self._cfg.Pic then
    self._campaignPic.gameObject:SetActive(true)
    self._campaignPic:LoadImage(self._cfg.Pic)
  else
    self._campaignPic.gameObject:SetActive(false)
  end
  self._name:SetText(StringTable.Get(self._cfg.Name))
  self._intro:SetText(StringTable.Get(self._cfg.Intro))
end

function UIEventTrailerInfoController:CloseBtnOnClick()
  self:StartTask(function(TT)
    YIELD(TT, 500)
    self:CloseDialog()
  end)
end
