_class("UIWidgetFeatureStepPoint", UICustomWidget)
UIWidgetFeatureStepPoint = UIWidgetFeatureStepPoint

function UIWidgetFeatureStepPoint:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeatureStepPoint:InitWidget()
  self._offSetGo = self:GetGameObject("OffSet")
  self._titleText = self:GetUIComponent("UILocalizationText", "Title")
  self._stepInfoText = self:GetUIComponent("UILocalizationText", "StepInfo")
  self._stepInfoMaxText = self:GetUIComponent("UILocalizationText", "StepInfoMax")
  self._recoverInfoText = self:GetUIComponent("UILocalizationText", "RecoverInfo")
  self._bgImage = self:GetUIComponent("Image", "Bg")
  self._anim = self:GetGameObject():GetComponent("Animation")
  self:RegisterEvent()
  self._offSetGo:SetActive(false)
  self._inited = false
end

function UIWidgetFeatureStepPoint:RegisterEvent()
  self:AttachEvent(GameEventType.FeatureListInit, self._OnFeatureListInit)
  self:AttachEvent(GameEventType.FeatureStepPointRefresh, self._OnFeatureStepPointRefresh)
  self:AttachEvent(GameEventType.FeatureStepPointRefreshByLink, self._OnFeatureStepPointRefreshByLink)
  self:AttachEvent(GameEventType.FeatureMaxStepPointRefresh, self._OnFeatureMaxStepPointRefresh)
  self:AttachEvent(GameEventType.FeatureRecoverStepPointRefresh, self._OnFeatureRecoverStepPointRefresh)
end

function UIWidgetFeatureStepPoint:SetData(initData)
  self._offSetGo:SetActive(true)
  self._initData = initData
  self._maxStepPoint = self._initData:GetMaxStepPoint()
  self._initStepPoint = self._initData:GetInitStepPoint()
  self._recoverStepPoint = self._initData:GetRecoverStepPoint()
  self._curStepPoint = self._initStepPoint
  self:_RefreshInfo(self._curStepPoint, self._maxStepPoint, self._recoverStepPoint)
end

function UIWidgetFeatureStepPoint:_RefreshInfo(curStepPoint, maxStepPoint, recoverStepPoint, animName)
  local uiCount = curStepPoint
  if maxStepPoint < uiCount then
    uiCount = maxStepPoint
  end
  if uiCount < 0 then
    uiCount = 0
  end
  local countStr
  local strCurCount = "<color=#e68812>" .. tostring(uiCount) .. "</color>"
  countStr = strCurCount
  self._stepInfoText:SetText(countStr)
  local maxStr = tostring(maxStepPoint)
  if self._stepInfoMaxText then
    self._stepInfoMaxText:SetText(maxStr)
  end
  local recoverStr
  recoverStr = "<color=#26e0fc>" .. tostring(recoverStepPoint) .. "</color>"
  self._recoverInfoText:SetText(recoverStr)
  if animName and self._anim then
    self._anim:Stop()
    self._anim:Play(animName)
  end
end

function UIWidgetFeatureStepPoint:_OnFeatureListInit(featureListInfo)
  if self._initData then
    return
  end
  if featureListInfo then
    for i, v in ipairs(featureListInfo) do
      local featureType = v:GetFeatureType()
      if featureType == FeatureType.StepPoint then
        self:SetData(v)
        self._inited = true
        break
      end
    end
  end
end

function UIWidgetFeatureStepPoint:_OnFeatureStepPointRefresh(curVal, oldVal, isRoundRecover)
  if not self._inited then
    return
  end
  self._curStepPoint = curVal
  local animName
  if isRoundRecover then
    animName = "uieff_UIWidgetFeatureStepPoint_cancel"
  end
  self:_RefreshInfo(self._curStepPoint, self._maxStepPoint, self._recoverStepPoint, animName)
end

function UIWidgetFeatureStepPoint:_OnFeatureStepPointRefreshByLink(chainPath, extraRecover, playLongAnim)
  if not self._inited then
    return
  end
  local tempCurPoint = self._curStepPoint
  if chainPath and 0 < #chainPath then
    tempCurPoint = tempCurPoint - (#chainPath - 1)
  end
  tempCurPoint = math.max(0, tempCurPoint)
  local tempRecover = self._recoverStepPoint
  if extraRecover and 0 < extraRecover then
    tempRecover = tempRecover + extraRecover
  end
  local animName = "uieff_UIWidgetFeatureStepPoint_click"
  if playLongAnim then
    animName = "uieff_UIWidgetFeatureStepPoint_cancel"
  end
  self:_RefreshInfo(tempCurPoint, self._maxStepPoint, tempRecover, animName)
end

function UIWidgetFeatureStepPoint:_OnFeatureMaxStepPointRefresh(curVal, oldVal)
  if not self._inited then
    return
  end
  self._maxStepPoint = curVal
  self:_RefreshInfo(self._curStepPoint, self._maxStepPoint, self._recoverStepPoint)
end

function UIWidgetFeatureStepPoint:_OnFeatureRecoverStepPointRefresh(curVal, oldVal)
  if not self._inited then
    return
  end
  self._recoverStepPoint = curVal
  self:_RefreshInfo(self._curStepPoint, self._maxStepPoint, self._recoverStepPoint)
end
