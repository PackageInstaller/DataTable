_class("UIFeatureTetrisInfo", UIController)
UIFeatureTetrisInfo = UIFeatureTetrisInfo

function UIFeatureTetrisInfo:OnShow(uiParams)
  self._data = uiParams[1]
  self:Init()
  self:_RefreshContent(true)
end

function UIFeatureTetrisInfo:OnHide()
  self:DetachEvent(GameEventType.TetrisFeatureRandom, self._RefreshData)
  self:DetachEvent(GameEventType.TetrisFeatureLock, self._RefreshLock)
end

function UIFeatureTetrisInfo:Init()
  self._tetrisIconAtlas = self:GetAsset("UIFeatureSkill.spriteatlas", LoadType.SpriteAtlas)
  self._tetrisIcon = self:GetUIComponent("Image", "TetrisIcon")
  self._tetrisAnim = self:GetUIComponent("Animation", "TetrisIcon")
  self._powerText = self:GetUIComponent("UILocalizationText", "Power")
  self._powerTxtGO = self:GetGameObject("Power")
  self._reRollBtnGO = self:GetGameObject("ReRollBtn")
  self._lockBtnGO = self:GetGameObject("LockBtn")
  self._lockStateGO = self:GetGameObject("LockState")
  self._mainColorCountGOList = {}
  self._mainColorCountIconList = {}
  self._mainColorCountAnimList = {}
  self._mainColorCountStateList = {}
  self._allAnim = self:GetUIComponent("Animation", "UICanvas")
  local mainColorCount = self._data:GetMainColorMaxCount()
  self._enableMainColorIcon = "n46_blj_di18"
  self._disEnableMainColorIcon = "n46_blj_di19"
  for i = 1, mainColorCount do
    self._mainColorCountGOList[i] = self:GetGameObject("MainColor_" .. i)
    self._mainColorCountGOList[i]:SetActive(self._data:GetMainColorEnable())
    self._mainColorCountAnimList[i] = self:GetUIComponent("Animation", "MainColor_" .. i)
    self._mainColorCountIconList[i] = self:GetUIComponent("Image", "MainColor_" .. i)
  end
  self._powerTxtGO:SetActive(self._data:GetPowerEnable())
  self._reRollBtnGO:SetActive(self._data:GetReRollEnable())
  self._lockBtnGO:SetActive(self._data:GetLockEnable())
  self._lockStateGO:SetActive(self._data:GetLockEnable())
  self:AttachEvent(GameEventType.TetrisFeatureRandom, self._RefreshData)
  self:AttachEvent(GameEventType.TetrisFeatureLock, self._RefreshLock)
  self._isPlayReRoll = false
  self:_PlayOpenAnim()
end

function UIFeatureTetrisInfo:_RefreshData()
  self:_RefreshContent(false)
end

function UIFeatureTetrisInfo:_PlayOpenAnim()
  AudioHelperController.PlayUISoundAutoRelease(160229105)
end

function UIFeatureTetrisInfo:_PlayBtnAudio()
  AudioHelperController.PlayUISoundAutoRelease(160229106)
end

function UIFeatureTetrisInfo:_RefreshLock()
  local tetrisIndex, tetrisLock, tetrisPower, tetrisMainColorCount, tetrisCostPower = InnerGameHelperRender.GetFeatureTetrisInfo()
  if self._data:GetLockEnable() then
    self._lockState = tetrisLock
    self._lockStateGO:SetActive(tetrisLock)
  end
  GameGlobal.UIStateManager():UnLock("UIFeatureTetrisInfo:LockBtnOnClick")
end

function UIFeatureTetrisInfo:_PlayTetrisIconChange(init, tetrisIndex)
  return GameGlobal.TaskManager():StartTask(function(TT)
    if self._lockState then
      return
    end
    if not init then
      self._tetrisAnim:Play("uieff_UIFeatureTetrisInfo_TetrisIcon_out")
      YIELD(TT, 200)
    end
    local iconName = self._data:GetTetrisIconByIndex(tetrisIndex)
    self._tetrisIcon.sprite = self._tetrisIconAtlas:GetSprite(iconName)
    if not init then
      YIELD(TT)
      self._tetrisAnim:Play("uieff_UIFeatureTetrisInfo_TetrisIcon_in")
      YIELD(TT, 267)
    end
  end)
end

function UIFeatureTetrisInfo:_PlayMainColorChange(init, tetrisMainColorCount)
  if self._data:GetMainColorEnable() then
    return GameGlobal.TaskManager():StartTask(function(TT)
      self._isFullMainColor = tetrisMainColorCount >= self._data:GetMainColorMaxCount()
      for i = 1, self._data:GetMainColorMaxCount() do
        if i <= tetrisMainColorCount and (init or self._mainColorCountStateList[i] == false) then
          self._mainColorCountAnimList[i]:Play("uieff_UIFeatureTetrisInfo_MainColor_in")
          self._mainColorCountStateList[i] = true
        elseif i > tetrisMainColorCount and (init or self._mainColorCountStateList[i] == true) then
          self._mainColorCountAnimList[i]:Play("uieff_UIFeatureTetrisInfo_MainColor_out")
          self._mainColorCountStateList[i] = false
        end
        if not init then
          YIELD(TT, 200)
        end
      end
    end)
  end
end

function UIFeatureTetrisInfo:_RefreshContent(init)
  GameGlobal.TaskManager():StartTask(function(TT)
    local allTaskID = {}
    local tetrisIndex, tetrisLock, tetrisPower, tetrisMainColorCount, tetrisCostPower = InnerGameHelperRender.GetFeatureTetrisInfo()
    local taskID = self:_PlayTetrisIconChange(init, tetrisIndex)
    table.insert(allTaskID, taskID)
    if self._data:GetLockEnable() then
      self._lockState = tetrisLock
      self._lockStateGO:SetActive(tetrisLock)
    end
    if self._data:GetPowerEnable() then
      if tetrisPower > self._data:GetMaxShowPower() then
        tetrisPower = self._data:GetMaxShowPower()
      end
      self._powerText:SetText(tetrisPower)
      self._power = tetrisPower
      self._costPower = tetrisCostPower
    end
    taskID = self:_PlayMainColorChange(init, tetrisMainColorCount)
    table.insert(allTaskID, taskID)
    while not TaskHelper:GetInstance():IsAllTaskFinished(allTaskID) do
      YIELD(TT)
    end
    if not init then
      self._isPlayReRoll = false
      GameGlobal.UIStateManager():UnLock("UIFeatureTetrisInfo:ReRollBtnOnClick")
    end
  end)
end

function UIFeatureTetrisInfo:BeforeHide(TT)
  self._allAnim:Play("uieff_UIFeatureTetrisInfo_out")
  YIELD(TT, 200)
  self._isClosing = true
end

function UIFeatureTetrisInfo:DotBGOnClick(go)
  if not self._isClosing then
    self:CloseDialog()
  end
end

function UIFeatureTetrisInfo:GuideExitbuttonOnClick(go)
  self:DotBGOnClick(go)
end

function UIFeatureTetrisInfo:ReRollBtnOnClick(go)
  if self._isPlayReRoll then
    return
  end
  if self._power >= self._costPower then
    if self._isFullMainColor and self._lockState then
      ToastManager.ShowToast(StringTable.Get("str_battle_tetris_desc_1"))
    else
      GameGlobal.UIStateManager():Lock("UIFeatureTetrisInfo:ReRollBtnOnClick")
      self._isPlayReRoll = true
      self._power = self._power - self._costPower
      self:_PlayBtnAudio()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.UITetrisOP, TetrisFeatureCmdOPType.ReRoll)
    end
  else
    ToastManager.ShowToast(StringTable.Get("str_battle_tetris_desc_0"))
  end
end

function UIFeatureTetrisInfo:LockBtnOnClick(go)
  GameGlobal.UIStateManager():Lock("UIFeatureTetrisInfo:LockBtnOnClick")
  self:_PlayBtnAudio()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UITetrisOP, TetrisFeatureCmdOPType.Lock, not self._lockState)
end
