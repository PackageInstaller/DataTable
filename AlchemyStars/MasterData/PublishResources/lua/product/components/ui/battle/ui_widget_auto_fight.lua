_class("UIWidgetAutoFight", UICustomWidget)
UIWidgetAutoFight = UIWidgetAutoFight

function UIWidgetAutoFight:OnShow(uiParams)
  self.enableFakeInput = true
  self:InitWidget()
end

function UIWidgetAutoFight:InitWidget()
  self._uiAtlas = self:GetAsset("UIBattle.spriteatlas", LoadType.SpriteAtlas)
  self._autoBtnNormalSpriteName = "thread_junei_btn3"
  self._autoBtnPressedSpriteName = "thread_junei_btn4"
  self._autoBtnLockSpriteName = "thread_zd_suo1"
  self:SetIsAutoFighting(false)
  self._banAutoFightBtn = false
  local roleModule = GameGlobal.GetModule(RoleModule)
  if LocalDB.HasKey("AutoFightRecord" .. roleModule:GetPstId()) and LocalDB.GetInt("AutoFightRecord" .. roleModule:GetPstId()) == 1 then
    self.IsAutoFightRecord = true
  else
    self.IsAutoFightRecord = false
  end
  if LocalDB.HasKey("BattleAutoFight" .. roleModule:GetPstId()) and LocalDB.GetInt("BattleAutoFight" .. roleModule:GetPstId()) == 1 then
    self.IsBattleAutoFight = true
  else
    self.IsBattleAutoFight = false
  end
  self.useGuide = false
  self._goAutoFightMask = self:GetGameObject("imgAutoFightMask")
  self._goAutoFightMask:SetActive(false)
  self._autoFightBtn = self:GetGameObject("btnAutoFight")
  self._autoFightImage = self:GetUIComponent("Image", "btnAutoFight")
  self._autoFightForbiddenStr = StringTable.Get("str_battle_forbidden_operation_in_autofight")
  self.autoParam = self:CheckAutoEnable()
  if self.autoParam.bShow then
    self._autoFightBtn:SetActive(true)
    if self.autoParam.bEnable then
      self._autoFightImage.sprite = self._uiAtlas:GetSprite(self._autoBtnNormalSpriteName)
      if self.autoParam.bSerialRunning then
        self:BtnAutoFightOnClick()
      elseif self.IsBattleAutoFight then
        self:BtnAutoFightOnClick()
      end
    else
      self._autoFightImage.sprite = self._uiAtlas:GetSprite(self._autoBtnLockSpriteName)
    end
  else
    self._autoFightBtn:SetActive(false)
  end
  self._autoBtnPool = self:GetUIComponent("UISelectObjectPath", "auto")
  self._manualBtns = self:GetGameObject("manual")
  self:RegisterEvent()
  self._stencil = self:GetUIComponent("Slider", "stencil")
  self._stencil.value = 0
  self._stencilViewValue = self:GetUIComponent("UILocalizationText", "stencilValue")
  self._stencilViewValue.text = "0"
  self._stencil.onValueChanged:AddListener(function(value)
    self._stencilViewValue.text = value
    UnityEngine.Shader.SetGlobalFloat("_outlineWidthTest", tonumber(value))
  end)
end

function UIWidgetAutoFight:SetData(matchEnterData, chessPanelPool)
  if matchEnterData:GetMatchType() == MatchType.MT_Chess and chessPanelPool then
    self:GetGameObject("fightCtrl"):SetActive(false)
    if self:IsAutoFighting() then
      self:BtnAutoFightOnClick()
    end
    self:GetGameObject("chessRTBtn"):SetActive(true)
    local timeSpeedPool = self:GetUIComponent("UISelectObjectPath", "chessTimeSpeed")
    self.timeSpeed = timeSpeedPool:SpawnObject("UIBattleTimeSpeed")
  else
    self:GetGameObject("fightCtrl"):SetActive(true)
    self:GetGameObject("chessRTBtn"):SetActive(false)
    local timeSpeedPool = self:GetUIComponent("UISelectObjectPath", "timeSpeed")
    self.timeSpeed = timeSpeedPool:SpawnObject("UIBattleTimeSpeed")
  end
  local serialMd = self:GetModule(SerialAutoFightModule)
  if serialMd:IsRunning() and not self:IsAutoFighting() then
    self:BtnAutoFightOnClick()
  end
  if serialMd:IsRunning() and serialMd:GetTotalCount() > 1 then
    self._autoBtn = self._autoBtnPool:SpawnObject("UIWidgetSerialButton")
    self._autoBtn:SetData(OpenUISerialFightInfoState.InGame)
    self._manualBtns:SetActive(false)
  end
  self:AttachEvent(GameEventType.CancelSerialAutoFight, self.OnCancelSerialAutoFight)
end

function UIWidgetAutoFight:RegisterEvent()
  self:AttachEvent(GameEventType.BanAutoFightBtn, self.OnBanAutoFightBtn)
  self:AttachEvent(GameEventType.GuidePlayerShow, self.OnGuidePlayerShow)
  self:AttachEvent(GameEventType.ShowGuideStep, self.OnShowGuideStep)
  self:AttachEvent(GameEventType.FinishGuideStep, self.OnFinishGuideStep)
end

function UIWidgetAutoFight:OnHide()
  local bSerialRunning = false
  if self.autoParam ~= nil then
    bSerialRunning = self.autoParam.bSerialRunning
  end
  if not self.useGuide and self.IsAutoFightRecord and not bSerialRunning and self:GetGameObject("fightCtrl").activeSelf then
    local roleModule = GameGlobal.GetModule(RoleModule)
    LocalDB.SetInt("BattleAutoFight" .. roleModule:GetPstId(), self:IsAutoFighting() and 1 or 0)
  end
  self:DetachEvent(GameEventType.BanAutoFightBtn, self.OnBanAutoFightBtn)
  self:DetachEvent(GameEventType.GuidePlayerShow, self.OnGuidePlayerShow)
  self:DetachEvent(GameEventType.ShowGuideStep, self.OnShowGuideStep)
  self:DetachEvent(GameEventType.FinishGuideStep, self.OnFinishGuideStep)
end

function UIWidgetAutoFight:CheckAutoEnable()
  return GameGlobal.GetUIModule(MatchModule):CheckAutoEnable()
end

function UIWidgetAutoFight:IsAutoFighting()
  return GameGlobal.GetUIModule(MatchModule):IsAutoFighting()
end

function UIWidgetAutoFight:SetIsAutoFighting(isAutoFighting)
  GameGlobal.GetUIModule(MatchModule):SetIsAutoFighting(isAutoFighting)
end

function UIWidgetAutoFight:OnBanAutoFightBtn(val)
  self._banAutoFightBtn = val
end

function UIWidgetAutoFight:BtnAutoFightOnClick(go)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetAutoFight",
    input = "BtnAutoFightOnClick",
    args = {}
  })
  if self.autoParam.bShow == false then
    return
  end
  if self.autoParam.bEnable == false then
    ToastManager.ShowToast(StringTable.Get(self.autoParam.disableMsg))
    return
  end
  local coreGameStateID = GameGlobal:GetInstance():CoreGameStateID()
  if self._banAutoFightBtn then
    if coreGameStateID == GameStateID.MirageEnter or coreGameStateID == GameStateID.MirageWaitInput or coreGameStateID == GameStateID.MirageRoleTurnor or coreGameStateID == GameStateID.MirageMonsterTurn or coreGameStateID == GameStateID.MirageEnd then
      ToastManager.ShowToast(StringTable.Get("str_battle_auto_disable_BossYou"))
    end
    return
  end
  if coreGameStateID == GameStateID.PreviewActiveSkill or coreGameStateID == GameStateID.PickUpActiveSkillTarget or coreGameStateID == GameStateID.PickUpChainSkillTarget then
    return
  end
  self:SetIsAutoFighting(not self:IsAutoFighting())
  GameGlobal.UAReportForceGuideEvent("FightClick", {
    "BtnAutoFightOnClick",
    self:IsAutoFighting() and 1 or 0
  }, false, true)
  if self:IsAutoFighting() then
    self._autoFightImage.sprite = self._uiAtlas:GetSprite(self._autoBtnPressedSpriteName)
  else
    self._autoFightImage.sprite = self._uiAtlas:GetSprite(self._autoBtnNormalSpriteName)
  end
  self._goAutoFightMask:SetActive(self:IsAutoFighting())
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AutoFight, self:IsAutoFighting())
  local md = GameGlobal.GetModule(SerialAutoFightModule)
  if not self:IsAutoFighting() and md:IsRunning() then
    md:CancelSerialAutoFight()
    ToastManager.ShowToast(StringTable.Get("str_battle_serial_fight_finished"))
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickUI2ClosePreviewMonster)
end

function UIWidgetAutoFight:ImgAutoFightMaskOnClick(go)
  ToastManager.ShowToast(self._autoFightForbiddenStr)
end

function UIWidgetAutoFight:OnCancelSerialAutoFight()
  if self._autoBtn then
    self._autoBtn:Hide()
  end
  self._manualBtns:SetActive(true)
end

function UIWidgetAutoFight:GetSpeedBtn()
  if self.timeSpeed then
    self.timeSpeed:ForceDefaultSpeed()
    return self.timeSpeed:GetGameObject("img")
  end
end

function UIWidgetAutoFight:OnGuidePlayerShow()
  local trigger = false
  if self.autoParam.bShow and self.autoParam.bEnable then
    if self.autoParam.bTriggerGuideBattle then
      trigger = true
    else
      trigger = false
    end
  end
  if not trigger then
    return
  end
  local guideModule = self:GetModule(GuideModule)
  if guideModule:GuideInProgress() then
    return
  end
  local matchModule = GameGlobal.GetModule(MatchModule)
  local enterData = matchModule:GetMatchEnterData()
  local matchType = enterData:GetMatchType()
  if matchType == MatchType.MT_Mission then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideMissionAutoBattle)
  elseif matchType == MatchType.MT_ResDungeon then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideResAutoBattle)
  end
end

function UIWidgetAutoFight:OnShowGuideStep()
  self.useGuide = true
  if GuideHelper.GuideInProgress() and self:IsAutoFighting() then
    self:BtnAutoFightOnClick()
  end
end

function UIWidgetAutoFight:OnFinishGuideStep()
end

function UIWidgetAutoFight:GetCurMainStateID()
end
