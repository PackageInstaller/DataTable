_class("UISeasonBuildProgramS3", UICustomWidget)
UISeasonBuildProgramS3 = UISeasonBuildProgramS3

function UISeasonBuildProgramS3:OnShow(uiParams)
  self:InitWidget()
end

function UISeasonBuildProgramS3:InitWidget()
  self.unFinishGo = self:GetGameObject("unFinish")
  self.finishGo = self:GetGameObject("finish")
  self.unOpenGo = self:GetGameObject("unOpen")
  self.txtTitle = self:GetUIComponent("UILocalizationText", "txtTitle")
  self.step1 = self:GetUIComponent("UISelectObjectPath", "step1")
  self.step3 = self:GetUIComponent("UISelectObjectPath", "step3")
end

function UISeasonBuildProgramS3:InitWithRewardClickCb(cb)
  self.rewardClickCb = cb
end

function UISeasonBuildProgramS3:SetData(context, buildClickCb)
  self._context = context
  self._buildClickCb = buildClickCb
  local level = self._context:GetCurLevel()
  local isLevelFull = self._context:BuildLevelIsFull()
  local isOpen = true
  if not isLevelFull then
    local quest = self._context:GetQuestByBuildLevel(level)
    isOpen = quest.Open
  end
  if not isOpen then
    self.unOpenGo:SetActive(true)
    self.unFinishGo:SetActive(false)
    self.finishGo:SetActive(false)
  else
    self.unOpenGo:SetActive(false)
    self.unFinishGo:SetActive(not isLevelFull)
    self.finishGo:SetActive(isLevelFull)
  end
  local cfg = self._context:GetBuildCfgByLevel(level)
  local showCfg = Cfg.cfg_season_castle_show[cfg.ID]
  if showCfg then
    self.txtTitle:SetText(StringTable.Get(showCfg.Title))
  end
  if not isLevelFull and isOpen then
    self:RefreshStepsUI()
  end
end

function UISeasonBuildProgramS3:RefreshStepsUI()
  self:_CheckStepsUI()
  self.step1Widget:SetData(self._context)
  self.step3Widget:SetData(self._context, self._buildClickCb, self.rewardClickCb)
end

function UISeasonBuildProgramS3:_CheckStepsUI()
  if not self.step1Widget then
    self.step1Widget = self.step1:SpawnObject("UISeasonBuildProgramStep1S3")
  end
  if not self.step3Widget then
    self.step3Widget = self.step3:SpawnObject("UISeasonBuildProgramStep3S3")
  end
end
