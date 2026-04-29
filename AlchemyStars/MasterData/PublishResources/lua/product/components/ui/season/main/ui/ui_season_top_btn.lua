_class("UISeasonTopBtn", UICustomWidget)
UISeasonTopBtn = UISeasonTopBtn

function UISeasonTopBtn:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonTopBtn:InitWidget()
  self._home = self:GetGameObject("Home")
  self._hide = self:GetGameObject("Hide")
  self._help = self:GetGameObject("Help")
  self._video = self:GetGameObject("Video")
end

function UISeasonTopBtn:SetData(backCB, homeCB, hideCB, helpCB, videoCB)
  self._backCB = backCB
  self._homeCB = homeCB
  self._hideCB = hideCB
  self._helpCB = helpCB
  self._videoCB = videoCB
  self._home:SetActive(self._homeCB ~= nil)
  self._hide:SetActive(self._hideCB ~= nil)
  self._help:SetActive(self._helpCB ~= nil)
  self._video:SetActive(self._videoCB ~= nil)
end

function UISeasonTopBtn:BackOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundCancel)
  self._backCB()
end

function UISeasonTopBtn:HomeOnClick()
  if self._homeCB then
    self._homeCB()
  end
end

function UISeasonTopBtn:HideOnClick()
  if self._homeCB then
    self._hideCB()
  end
end

function UISeasonTopBtn:HelpOnClick()
  if self._helpCB then
    self._helpCB()
  end
end

function UISeasonTopBtn:VideoOnClick()
  if self._videoCB then
    self._videoCB()
  end
end

function UISeasonTopBtn:SetBacktrackUI()
  self._hide:SetActive(false)
  self._help:SetActive(false)
  self._video:SetActive(false)
end
