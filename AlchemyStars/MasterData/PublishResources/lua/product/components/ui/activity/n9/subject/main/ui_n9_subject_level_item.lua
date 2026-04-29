_class("UIN9SubjectLevelItem", UICustomWidget)
UIN9SubjectLevelItem = UIN9SubjectLevelItem

function UIN9SubjectLevelItem:OnShow()
  self._go = self:GetGameObject()
  self._normalLevel = self:GetGameObject("NormalLevel")
  self._testLevel = self:GetGameObject("TestLevel")
  self._openPanel = self:GetGameObject("OpenPanel")
  self._unOpenPanel = self:GetGameObject("UnOpenPanel")
  self._nameLabel = self:GetUIComponent("UILocalizedTMP", "Name")
  self._remainTimeLabel = self:GetUIComponent("UILocalizationText", "RemainTime")
  self._testLevelNameLabel = self:GetUIComponent("UILocalizedTMP", "TestLevelName")
  self._testGradeLabel = self:GetUIComponent("UILocalizedTMP", "TestGrade")
  self._testGradeGo = self:GetGameObject("TestGrade")
  self._EMIMatResRequest = ResourceManager:GetInstance():SyncLoadAsset("uieff_n9_subject_grade_name.mat", LoadType.Mat)
  self._EMIMat = self._EMIMatResRequest.Obj
  local mat = self._testGradeLabel.fontMaterial
  self._testGradeLabel.fontMaterial = self._EMIMat
  self._testGradeLabel.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
  self._EMIMatResRequest1 = ResourceManager:GetInstance():SyncLoadAsset("uieff_n9_subject_level_name.mat", LoadType.Mat)
  self._EMIMat1 = self._EMIMatResRequest1.Obj
  local mat = self._testLevelNameLabel.fontMaterial
  self._testLevelNameLabel.fontMaterial = self._EMIMat1
  self._testLevelNameLabel.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
  local mat = self._nameLabel.fontMaterial
  self._nameLabel.fontMaterial = self._EMIMat1
  self._nameLabel.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UIN9SubjectLevelItem:OnHide()
  self._EMIMatResRequest = nil
  self._EMIMat = nil
  self._EMIMatResRequest1 = nil
  self._EMIMat1 = nil
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
end

function UIN9SubjectLevelItem:Refresh(levelData)
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
    self._testLevelNameLabel:SetText(self._levelData:GetLevelName())
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

function UIN9SubjectLevelItem:RefreshNormalLevelStatus()
  if self._levelData:IsOpen() then
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
    self._openPanel:SetActive(true)
    self._unOpenPanel:SetActive(false)
    self._nameLabel:SetText(self._levelData:GetLevelName())
  else
    self._openPanel:SetActive(false)
    self._unOpenPanel:SetActive(true)
    self._nameLabel:SetText(self._levelData:GetLevelName())
    self._remainTimeLabel:SetText(self._levelData:GetOpenTimeStr())
  end
  self._processLoader = self:GetUIComponent("UISelectObjectPath", "Process")
  self._processLoader:SpawnObjects("UIN9SubjectLevelProcess", self._levelData:GetLevelGradCount())
  local items = self._processLoader:GetAllSpawnList()
  for i = 1, #items do
    if i <= self._levelData:GetCompleteGradeCount() then
      items[i]:Refresh(true)
    else
      items[i]:Refresh(false)
    end
  end
end

function UIN9SubjectLevelItem:BtnOnClick()
  if not self._levelData:IsOpen() then
    ToastManager.ShowToast(StringTable.Get("str_activity_n9_level_unopen_tips", self._levelData:GetOpenTimeStr()))
    return
  end
  local levelType = self._levelData:GetLevelType()
  if levelType == 1 then
    self:ShowDialog("UIN9SubjectNormalDetailController", self._levelData)
  elseif levelType == 2 then
    self:ShowDialog("UIN9SubjectTestDetailController", self._levelData)
  end
end
