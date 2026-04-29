_class("UIActivityNPlusSixBuildingItem", UICustomWidget)
UIActivityNPlusSixBuildingItem = UIActivityNPlusSixBuildingItem

function UIActivityNPlusSixBuildingItem:OnShow()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._iconTran = self:GetUIComponent("RectTransform", "Icon")
  self._btnGo = self:GetGameObject("Btn")
  self._btnTran = self:GetUIComponent("RectTransform", "Btn")
  self._go = self:GetGameObject("Go")
  self._iconImage = self:GetUIComponent("RawImage", "Icon")
  self._effectParent = self:GetGameObject("EffectNode")
  self._effect = nil
  self._isPlayCompleteEffect = false
  self._tmpValue = 0
end

function UIActivityNPlusSixBuildingItem:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:DestroyEffect()
end

function UIActivityNPlusSixBuildingItem:Refresh(buildingData)
  local operatorName = {
    [UIActivityNPlusSixBuildingStatus.CleanUp] = "str_n_plus_six_building_tips_cleanup_operator_name",
    [UIActivityNPlusSixBuildingStatus.CleanUpComplete] = "str_n_plus_six_building_tips_repair_operator_name",
    [UIActivityNPlusSixBuildingStatus.RepairComplete] = "str_n_plus_six_building_tips_decorate_operator_name"
  }
  self._buildingData = buildingData
  if not self._buildingData then
    self._go:SetActive(false)
    return
  end
  if not self._buildingData:IsShow() then
    self._go:SetActive(false)
    return
  end
  self._go:SetActive(true)
  self._go.transform.anchoredPosition = self._buildingData:GetWidgetPos()
  self._iconTran.sizeDelta = Vector2(self._buildingData:GetIconWidth(), self._buildingData:GetIconHeight())
  self._iconTran.anchoredPosition = self._buildingData:GetIconPos()
  self._iconTran.localEulerAngles = Vector3(0, 0, self._buildingData:GetIconRotate())
  self._btnTran.sizeDelta = Vector2(self._buildingData:GetTriggerWidth(), self._buildingData:GetTriggerHeight())
  self._btnTran.anchoredPosition = self._buildingData:GetTriggerPos()
  self._btnTran.localEulerAngles = Vector3(0, 0, self._buildingData:GetTriggerRotate())
  local status = self._buildingData:GetStatusType()
  self._icon:LoadImage(self._buildingData:GetIcon())
  if self._buildingData:CanBuild() == false or self._buildingData:IsUnLock() == false or self._buildingData:IsNextStatusUnLock() == false then
    self._btnGo:SetActive(false)
  else
    self._btnGo:SetActive(true)
    local str = operatorName[status]
    if not str then
      self._btnGo:SetActive(false)
    end
  end
  if self._isPlayCompleteEffect then
    self._iconImage.material:SetFloat("_Intensity", self._tmpValue)
  end
  self:PlayIdleEffect()
end

function UIActivityNPlusSixBuildingItem:PlayIdleEffect()
  if self:CanBuild() then
    if self._timerHandler then
      return
    end
    local isStageOne = true
    local timer = 0
    local startValue1 = 0
    local endValue1 = 0.7
    local length1 = 1.5
    local speed1 = (endValue1 - startValue1) / length1
    local startValue2 = 0.7
    local endValue2 = 0
    local length2 = 1.5
    local speed2 = (endValue2 - startValue2) / length2
    self._iconImage.material:SetFloat("_Intensity", 0)
    self._timerHandler = GameGlobal.Timer():AddEventTimes(0, TimerTriggerCount.Infinite, function()
      timer = timer + UnityEngine.Time.deltaTime
      local value = 0
      if isStageOne then
        value = startValue1 + timer * speed1
      else
        value = startValue2 + timer * speed2
      end
      self._iconImage.material:SetFloat("_Intensity", value)
      if isStageOne then
        if timer > length1 then
          isStageOne = false
          timer = 0
        end
      elseif timer > length2 then
        isStageOne = true
        timer = 0
      end
    end)
  else
    if self._isPlayCompleteEffect == false then
      self._iconImage.material:SetFloat("_Intensity", 0)
    end
    if self._timerHandler then
      GameGlobal.Timer():CancelEvent(self._timerHandler)
      self._timerHandler = nil
    end
  end
end

function UIActivityNPlusSixBuildingItem:DestroyEffect()
  if self._effect then
    UIHelper.DestroyGameObject(self._effect)
    self._effect = nil
  end
end

function UIActivityNPlusSixBuildingItem:PlayBuildingCompleteEffect()
  self:DestroyEffect()
  self._effect = UIHelper.GetGameObject("uieff_n6_rebuild_xiufu_1.prefab")
  self._effect.transform:SetParent(self._effectParent.transform, false)
  self._iconImage.material:SetFloat("_Intensity", 0)
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self._isPlayCompleteEffect = true
  GameGlobal.TaskManager():StartTask(function(TT)
    self:Lock("UIActivityNPlusSixBuildingItem_PlayBuildingCompleteEffect")
    local isStageOne = true
    local timer = 0
    local startValue1 = 0
    local endValue1 = 3
    local length1 = 0.2
    local speed1 = (endValue1 - startValue1) / length1
    self._tmpValue = 0
    local startValue2 = 3
    local endValue2 = 0
    local length2 = 1
    local speed2 = (endValue2 - startValue2) / length2
    while true do
      YIELD(TT)
      timer = timer + UnityEngine.Time.deltaTime
      local value = 0
      if isStageOne then
        value = startValue1 + timer * speed1
        self._tmpValue = value
      else
        value = startValue2 + timer * speed2
      end
      self._iconImage.material:SetFloat("_Intensity", value)
      if isStageOne then
        if length1 < timer then
          isStageOne = false
          self._iconImage.material:SetFloat("_Intensity", self._tmpValue)
          timer = 0
        end
      elseif length2 < timer then
        isStageOne = true
        timer = 0
        self:DestroyEffect()
        break
      end
    end
    self._iconImage.material:SetFloat("_Intensity", 0)
    self._isPlayCompleteEffect = false
    self:UnLock("UIActivityNPlusSixBuildingItem_PlayBuildingCompleteEffect")
  end, self)
end

function UIActivityNPlusSixBuildingItem:BtnOnClick()
  self:Click()
end

function UIActivityNPlusSixBuildingItem:Click()
  if not self:CanBuild() then
    return
  end
  self:ShowDialog("UIActivityNPlusSixBuildingTipsController", self._buildingData)
end

function UIActivityNPlusSixBuildingItem:CanBuild()
  if not self._buildingData then
    return false
  end
  if not self._buildingData:CanBuild() then
    return false
  end
  if not self._buildingData:IsUnLock() then
    return false
  end
  if not self._buildingData:IsNextStatusUnLock() then
    return false
  end
  return true
end
