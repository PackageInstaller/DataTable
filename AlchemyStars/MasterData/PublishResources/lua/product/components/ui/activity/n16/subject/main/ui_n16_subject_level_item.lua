_class("UIN16SubjectLevelItem", UICustomWidget)
UIN16SubjectLevelItem = UIN16SubjectLevelItem

function UIN16SubjectLevelItem:OnShow()
  self._go = self:GetGameObject()
  self._normalLevel = self:GetGameObject("NormalLevel")
  self._testLevel = self:GetGameObject("TestLevel")
  self._openPanel = self:GetGameObject("OpenPanel")
  self._unOpenPanel = self:GetGameObject("UnOpenPanel")
  self._nameLabel = self:GetUIComponent("UILocalizationText", "Name")
  self._remainTimeLabel = self:GetUIComponent("UILocalizationText", "RemainTime")
  self._testLevelNameLabel = self:GetUIComponent("UILocalizedTMP", "TestLevelName")
  self._testGradeLabel = self:GetUIComponent("UILocalizedTMP", "TestGrade")
  self._testGradeGo = self:GetGameObject("TestGrade")
  self._maskGo = self:GetGameObject("mask")
  self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset("uieff_n16_ingame_evaluate.mat", LoadType.Mat)
  self._EMIMat = self._EMIMatResRequest.Obj
  local mat = self._testGradeLabel.fontMaterial
  self._testGradeLabel.fontMaterial = self._EMIMat
  self._testGradeLabel.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIN16SubjectLevelItem:OnHide()
  self._EMIMatResRequest = nil
  self._EMIMat = nil
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIN16SubjectLevelItem:Refresh(levelData)
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self._levelData = levelData
  if self._levelData == nil then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  local levelType = self._levelData:GetLevelType()
  if levelType == 1 then
    self._normalLevel:SetActive(true)
    self._testLevel:SetActive(false)
    if self._levelData:IsOpen() then
      self:RefreshNormalLevelStatus()
    else
      self:RefreshNormalLevelStatus()
      self._timerHandler = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
        self:RefreshNormalLevelStatus()
      end)
    end
  elseif levelType == 2 then
    self._normalLevel:SetActive(false)
    self._testLevel:SetActive(true)
    local levelStr = self._levelData:GetGradeLevelStr()
    if levelStr and levelStr ~= "" then
      self._testGradeGo:SetActive(true)
      self._testGradeLabel:SetText(levelStr)
    else
      self._testGradeLabel:SetText("--")
    end
  else
    self._testGradeLabel:SetText("")
  end
end

function UIN16SubjectLevelItem:RefreshNormalLevelStatus()
  if self._levelData:IsOpen() then
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
    self._openPanel:SetActive(true)
    self._unOpenPanel:SetActive(false)
    self._nameLabel:SetText("<color=#cbb05a>" .. self._levelData:GetLevelName() .. "</color>")
    self._maskGo:SetActive(false)
  else
    self._openPanel:SetActive(false)
    self._unOpenPanel:SetActive(true)
    self._nameLabel:SetText(self._levelData:GetLevelName())
    self._remainTimeLabel:SetText(self._levelData:GetOpenTimeStr())
    self._maskGo:SetActive(true)
  end
  self._processLoader = self:GetUIComponent("UISelectObjectPath", "Process")
  self._processLoader:SpawnObjects("UIN16SubjectLevelProcess", self._levelData:GetLevelGradCount())
  local items = self._processLoader:GetAllSpawnList()
  for i = 1, #items do
    if i <= self._levelData:GetCompleteGradeCount() then
      items[i]:Refresh(true)
    else
      items[i]:Refresh(false)
    end
  end
end

function UIN16SubjectLevelItem:BtnOnClick()
  if not self._levelData:IsOpen() then
    ToastManager.ShowToast(StringTable.Get("str_activity_n16_level_unopen_tips", self._levelData:GetOpenTimeStr()))
    return
  end
  local levelType = self._levelData:GetLevelType()
  if levelType == 1 then
    self:ShowDialog("UIN16SubjectNormalDetailController", self._levelData)
  elseif levelType == 2 then
    self:ShowDialog("UIN16SubjectTestDetailController", self._levelData)
  end
end
