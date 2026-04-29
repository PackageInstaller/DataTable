_class("UIN13BuildItem", UICustomWidget)
UIN13BuildItem = UIN13BuildItem

function UIN13BuildItem:OnShow()
  self._isSpine = false
  self._spine = self:GetUIComponent("SpineLoader", "Spine")
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

function UIN13BuildItem:OnHide()
  if self._timerHandler then
    GameGlobal.Timer():CancelEvent(self._timerHandler)
    self._timerHandler = nil
  end
  self:_DestroyEffect()
end

function UIN13BuildItem:SetData(buildManager, buildItemId, type)
  self._buildManager = buildManager
  self._buildItemId = buildItemId
  self.type = type
  local show = buildManager:IsShow(buildItemId)
  self._go:SetActive(show)
  if not show then
    return
  end
  self:_SetPos(buildItemId)
  self:_SetBtn(buildItemId)
  self._isSpine = self:_SetSpine(buildItemId)
  local tb = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"Icon"},
    {"Spine"}
  })
  UIWidgetHelper.SetObjGroupShow(tb, self._isSpine and 2 or 1)
  if not self._isSpine then
    self:_SetIcon(buildItemId)
    self:_PlayIdleEffect()
  end
end

function UIN13BuildItem:_CanBuild()
  return not self._buildManager:IsAllStatusComplete(self._buildItemId) and self._buildManager:IsNextStatusUnlock(self._buildItemId)
end

function UIN13BuildItem:_SetPos(buildItemId)
  self._go.transform.anchoredPosition = self._buildManager:GetWidgetPos(buildItemId)
  self._iconTran.sizeDelta = Vector2(self._buildManager:GetIconWidth(buildItemId), self._buildManager:GetIconHeight(buildItemId))
  self._iconTran.anchoredPosition = self._buildManager:GetIconPos(buildItemId)
  self._iconTran.localEulerAngles = Vector3(0, 0, self._buildManager:GetIconRotate(buildItemId))
  self._btnTran.sizeDelta = Vector2(self._buildManager:GetTriggerWidth(buildItemId), self._buildManager:GetTriggerHeight(buildItemId))
  self._btnTran.anchoredPosition = self._buildManager:GetTriggerPos(buildItemId)
  self._btnTran.localEulerAngles = Vector3(0, 0, self._buildManager:GetTriggerRotate(buildItemId))
end

function UIN13BuildItem:_SetBtn(buildItemId)
  local status = self._buildManager:GetBuildCurStatus(buildItemId)
  local str = UIActivityN13Helper.GetStrByStatus_Operator(status, "")
  local show = self:_CanBuild() and not string.isnullorempty(str)
  self._btnGo:SetActive(show)
end

function UIN13BuildItem:_SetSpine(buildItemId)
  local url, ani = self._buildManager:GetSpine(buildItemId)
  if string.isnullorempty(url) then
    return false
  end
  self._spine:LoadSpine(url)
  local spineSke = self._spine.CurrentSkeleton
  spineSke = spineSke or self._spine.CurrentMultiSkeleton
  if spineSke then
    spineSke.AnimationState:SetAnimation(0, ani, true)
  end
  return true
end

function UIN13BuildItem:_SetIcon(buildItemId)
  self._icon:LoadImage(self._buildManager:GetIcon(buildItemId))
  if self._isPlayCompleteEffect then
    self._iconImage.material:SetFloat("_Intensity", self._tmpValue)
  end
end

function UIN13BuildItem:_PlayIdleEffect()
  if self:_CanBuild() then
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

function UIN13BuildItem:_DestroyEffect()
  if self._effect then
    UIHelper.DestroyGameObject(self._effect)
    self._effect = nil
  end
end

function UIN13BuildItem:BtnOnClick()
  if not self:_CanBuild() then
    return
  end
  self:ShowDialog("UIN13BuildConfirmController", self._buildManager, self._buildItemId, self.type)
end
