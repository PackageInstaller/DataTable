_class("UIN38HardLevelBtn", UICustomWidget)
UIN38HardLevelBtn = UIN38HardLevelBtn

function UIN38HardLevelBtn:OnShow(uiParams)
  self:InitWidget()
end

function UIN38HardLevelBtn:InitWidget()
  self._bg = self:GetUIComponent("Image", "Bg")
  self._name = self:GetUIComponent("UILocalizationText", "Name")
  self._lockGO = self:GetGameObject("Lock")
  self._timeGO = self:GetGameObject("Time")
  self._timeText = self:GetUIComponent("UILocalizationText", "Time")
end

function UIN38HardLevelBtn:SetData(atlas, isBlack, blackUnlock, clickCallback)
  self._atlas = atlas
  self._clickCallback = clickCallback
  self._isBlack = isBlack
  local btnSpriteName = "n26_kng_btn01"
  local multiLangaugeName = "str_n38_hard_title"
  if self._isBlack then
    btnSpriteName = "n26_kng_btn02"
    multiLangaugeName = "str_n38_diff_title"
  end
  self._bg.sprite = atlas:GetSprite(btnSpriteName)
  self._name:SetText(StringTable.Get(multiLangaugeName))
  if isBlack then
    self._lockGO:SetActive(not blackUnlock)
    if not blackUnlock then
      local startTime = self.uiOwner._blevelComponentInfo.m_unlock_time
      local curTime = math.floor(self:GetModule(SvrTimeModule):GetServerTime() * 0.001)
      if startTime > curTime then
        self._timeGO:SetActive(true)
        self._timeText:SetText(UIN38Line:GetFormatTimerStr(math.max(startTime - curTime, 0), "FEFCFC"))
      else
        self._timeGO:SetActive(false)
      end
    else
      self._timeGO:SetActive(false)
    end
  else
    self._timeGO:SetActive(false)
    self._lockGO:SetActive(false)
  end
end

function UIN38HardLevelBtn:Refresh(blackUnlock)
  if self._isBlack then
    self._lockGO:SetActive(not blackUnlock)
    if not blackUnlock then
      local startTime = self.uiOwner._blevelComponentInfo.m_unlock_time
      local curTime = math.floor(self:GetModule(SvrTimeModule):GetServerTime() * 0.001)
      if startTime > curTime then
        self._timeGO:SetActive(true)
        self._timeText:SetText(UIN38Line:GetFormatTimerStr(math.max(startTime - curTime, 0), "FEFCFC"))
      else
        self._timeGO:SetActive(false)
      end
    else
      self._timeGO:SetActive(false)
    end
  else
    self._timeGO:SetActive(false)
    self._lockGO:SetActive(false)
  end
end

function UIN38HardLevelBtn:SetUnlock(isUnlock)
  self._lockGO:SetActive(isUnlock)
end

function UIN38HardLevelBtn:LevelBtnOnClick(go)
  if self._clickCallback then
    self._clickCallback(self._isBlack)
  end
end
