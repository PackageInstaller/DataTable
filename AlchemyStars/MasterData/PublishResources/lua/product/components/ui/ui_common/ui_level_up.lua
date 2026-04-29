_class("UILevelUp", UIController)
UILevelUp = UILevelUp

function UILevelUp:LoadDataOnEnter(TT, res, uiParams)
  local serialautofightmodule = self:GetModule(SerialAutoFightModule)
  local running = serialautofightmodule:IsRunning()
  if running then
    res:SetSucc(false)
  else
    res:SetSucc(true)
  end
end

function UILevelUp:OnShow(uiParams)
  self._lvText = self:GetUIComponent("UILocalizationText", "Lv")
  self._newLvText = self:GetUIComponent("UILocalizationText", "NewLv")
  self._maxGO = self:GetGameObject("Max")
  self._phyRecText = self:GetUIComponent("UILocalizationText", "RecNum")
  self._maxPhyOrg = self:GetUIComponent("UILocalizationText", "MaxOrg")
  self._maxPhyNew = self:GetUIComponent("UILocalizationText", "MaxNew")
  local orgLv = uiParams[1]
  local newLv = uiParams[2]
  local matchResRoleInfo = uiParams[3]
  self.orgLvPhyMax = matchResRoleInfo.max_phy_before
  self.newgLvPhyMax = matchResRoleInfo.max_phy_after
  self.recPhy = matchResRoleInfo.phy_add
  self._lvText:SetText(orgLv)
  self._newLvText:SetText(newLv)
  local maxLv = HelperProxy:GetInstance():GetMaxLevel()
  if newLv == maxLv then
    self._maxGO:SetActive(true)
  end
  self._phyRecText:SetText(0)
  self._maxPhyOrg:SetText(self.orgLvPhyMax)
  self._maxPhyNew:SetText(self.orgLvPhyMax)
  local frameTime = 16.666666666666668
  self.phyRecStartTime = frameTime * 133
  self.phyRecEndTime = frameTime * 171
  self.phyRecTotalTime = self.phyRecEndTime - self.phyRecStartTime
  self.phyRecAnimDone = false
  self.newPhyStartTime = frameTime * 185
  self.newPhyEndTime = frameTime * 200
  self.newPhyTotalTime = self.newPhyEndTime - self.newPhyStartTime
  self.newPhyAnimDone = false
  self.accTime = 0
  self._closeCallBack = nil
  if uiParams[4] then
    self._closeCallBack = uiParams[4]
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundPlayerUpLevel)
end

function UILevelUp:OnUpdate(deltaTimeMS)
  self.accTime = self.accTime + deltaTimeMS
  if self.accTime < self.phyRecStartTime or self.newPhyAnimDone then
    return
  end
  if not self.phyRecAnimDone then
    local percent = (self.accTime - self.phyRecStartTime) / self.phyRecTotalTime
    if self.accTime > self.phyRecEndTime then
      self.phyRecAnimDone = true
      percent = 1
    end
    local phyRec = DG.Tweening.DOVirtual.EasedValue(0, self.recPhy, percent, DG.Tweening.Ease.OutQuad)
    self._phyRecText:SetText(math.floor(phyRec))
  elseif self.accTime > self.newPhyStartTime then
    local percent = (self.accTime - self.newPhyStartTime) / self.newPhyTotalTime
    if self.accTime > self.newPhyEndTime then
      self.newPhyAnimDone = true
      percent = 1
    end
    local newPhy = DG.Tweening.DOVirtual.EasedValue(self.orgLvPhyMax, self.newgLvPhyMax, percent, DG.Tweening.Ease.Linear)
    self._maxPhyNew:SetText(math.floor(newPhy))
  end
end

function UILevelUp:FullScreenBtnOnClick(go)
  if self.newPhyAnimDone then
    self:CloseDialog()
    if self._closeCallBack then
      self._closeCallBack()
    end
  end
end
