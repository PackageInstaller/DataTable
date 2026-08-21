_class("UISeasonBuffLevelUpS8", UIController)
UISeasonBuffLevelUpS8 = UISeasonBuffLevelUpS8

function UISeasonBuffLevelUpS8:LoadDataOnEnter(TT, res, uiParams)
  local serialautofightmodule = self:GetModule(SerialAutoFightModule)
  local running = serialautofightmodule:IsRunning()
  if running then
    res:SetSucc(false)
  else
    res:SetSucc(true)
  end
end

function UISeasonBuffLevelUpS8:OnShow(uiParams)
  self._oldLevelText = self:GetUIComponent("UILocalizationText", "OldLevel")
  self._curLevelText = self:GetUIComponent("UILocalizationText", "CurLevel")
  self._detailLevelText = self:GetUIComponent("UILocalizationText", "DetailLevel")
  self._detailContentText = self:GetUIComponent("UILocalizationText", "DetailContent")
  self._levelUpAreaGO = self:GetGameObject("LevelUpArea")
  self._levelUpAreaGO:SetActive(true)
  self._infoAreaGO = self:GetGameObject("InfoArea")
  self._infoAreaGO:SetActive(false)
  local oldLv = uiParams[1]
  local newLv = uiParams[2]
  self.componentID = uiParams[3]
  self._oldLevelText:SetText(StringTable.Get("str_season_buff_level", tostring(oldLv)))
  self._curLevelText:SetText(StringTable.Get("str_season_buff_level", tostring(newLv)))
  local frameTime = 16.666666666666668
  self.switchAreaTime = frameTime * 133
  self.switchAreaDone = false
  self.accTime = 0
  self._closeCallBack = nil
  if uiParams[4] then
    self._closeCallBack = uiParams[4]
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundPlayerUpLevel)
  self._detailLevelText:SetText(StringTable.Get("str_season_buff_level", tostring(newLv)))
  local cfgGroup = Cfg.cfg_component_season_wordbuff({
    ComponentID = self.componentID,
    Lv = newLv
  })
  if cfgGroup and 0 < #cfgGroup then
    local cfg = cfgGroup[1]
    local desc = cfg.Desc
    self._detailContentText:SetText(StringTable.Get(desc))
  else
    self._detailContentText:SetText("")
  end
  self._enable = true
  local guideBuffLevel = Cfg.cfg_guide_const.guide_season_s1_buff_level.IntValue
  if guideBuffLevel == newLv then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISeasonBuffLevelUp2)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISeasonBuffLevelUp)
  end
  self._setAlphaArea = self:GetUIComponent("CanvasGroup", "Panel")
end

function UISeasonBuffLevelUpS8:OnUpdate(deltaTimeMS)
  if not self._enable then
    return
  end
  self.accTime = self.accTime + deltaTimeMS
  if self.accTime < self.switchAreaTime or self.switchAreaDone then
    return
  end
  if self.accTime > self.switchAreaTime then
    self._levelUpAreaGO:SetActive(false)
    self._infoAreaGO:SetActive(true)
    self._setAlphaArea.alpha = 0
    self._setAlphaArea:DOFade(1, 0.3)
    self.switchAreaDone = true
  end
end

function UISeasonBuffLevelUpS8:FullScreenBtnOnClick(go)
  if self.switchAreaDone then
    self:CloseDialog()
    if self._closeCallBack then
      self._closeCallBack()
    end
  end
end
