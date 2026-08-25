local AutoAdaptionText = NewClass("AutoAdaptionText")
local TypeOfTMP_Text = typeof(CS.TMPro.TMP_Text)
local TypeOfText = typeof(CS.UnityEngine.UI.Text)
local TYPEOF_Z1Button = typeof(CS.Z1Client.Z1Button)
local TYPEOF_Button = typeof(CS.UnityEngine.UI.Button)
local T_DragGesture = typeof(CS.Z1Client.General.DragGesture)
local TypeOfScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local TYPEOF_NotDrawImage = typeof(CS.UnityEngine.UI.NotDrawImage)
local T_RectMask2D = typeof(CS.UnityEngine.UI.RectMask2D)
local T_Mask = typeof(CS.UnityEngine.UI.Mask)
local TYPEOF_RepeatButton = typeof(CS.RepeatButton)
local T_MaskableGraphic = typeof(CS.UnityEngine.UI.MaskableGraphic)
local _SetAnchoredPos = CS.Framework.TransformUtil.SetAnchoredPos
local _GetAnchoredPos = CS.Framework.TransformUtil.GetAnchoredPos
local _SetHeight = CS.Framework.TransformUtil.SetHeight
local _SetWidth = CS.Framework.TransformUtil.SetWidth
local UnityTime = CS.UnityEngine.Time
local DefaultMovementSpd = 15
local TempVec2 = CS.UnityEngine.Vector2()
local _GetComponentInParent

function _GetComponentInParent(go, type)
  if not go then
    return
  end
  local comp = go.gameObject:GetComponent(type)
  if comp then
    return comp
  end
  local parentGo = go.transform.parent
  if parentGo then
    do return _GetComponentInParent, parentGo end
    return _GetComponentInParent, parentGo, type
  end
  return nil
end

function AutoAdaptionText.StartAutoAdaptionText(txtGo, pivot, fontOffset, sizeOffset, spd, enableAutoSizing, forceAutoScroll)
  local scrollRect = _GetComponentInParent(txtGo, TypeOfScrollRect)
  if not scrollRect then
    print("=====txtGo==no scrollRect=", txtGo.name)
    return
  end
  local comp = AddLuaCompOnce(txtGo, AutoAdaptionText)
  comp:SetEnableAutoSizing(enableAutoSizing or false)
  comp:SetSpeed(spd)
  comp:SetPivot(pivot)
  comp:SetFontOffset(fontOffset)
  comp:SetContentSizeOffset(sizeOffset)
  comp:SetForceAutoScroll(forceAutoScroll)
  comp._lastTMPFontSize = -1
  comp.waitingTime = 1
  comp.disableLateUpdate = false
  return comp
end

function AutoAdaptionText:SetDragDelegate(drawDelegate)
  self._drawDelegate = drawDelegate
  if self._drawDelegate and not IsNil(self.tmpTextComp) then
    self.tmpTextComp.raycastTarget = false
  end
end

function AutoAdaptionText:SetAdjustAlignment(cn, other)
  self.adjustAlignmentCN = cn
  self.adjustAlignmentOther = other
end

function AutoAdaptionText:ForceUpdate(cfg)
  self._autoAdaptionCfg = cfg
  if IsNil(self.tmpTextComp) then
    return
  end
  self.disableLateUpdate = false
  local isNeedAdjBound = false
  local isDisableAutoScroll = self:IsDisbaleAutoScroll()
  if cfg then
    if isDisableAutoScroll then
      self:_ApplyAdaptionCfg(cfg.adaptionCfg)
      isNeedAdjBound = true
    else
      self:_ApplyAdaptionCfg(cfg.initCfg)
    end
  end
  self:_ForeceRefresh()
  if not isDisableAutoScroll and cfg then
    local fontSize = self.tmpTextComp.fontSize
    local newFontSize = fontSize
    local lineCount = self.tmpTextComp.textInfo and self.tmpTextComp.textInfo.lineCount or 0
    if lineCount <= cfg.lineLimit then
      newFontSize = cfg.maxFontSize
    else
      newFontSize = cfg.miniFontSize
    end
    if fontSize ~= newFontSize then
      self.tmpTextComp.fontSize = newFontSize
      if cfg.adaptionCfg then
        cfg.adaptionCfg.fontSize = newFontSize
      end
      self:_ForeceRefresh()
    end
  end
  if not isDisableAutoScroll and cfg and self.orinContentSize and self.textAreaSize and cfg.limitPercent and self.textAreaSize > 0 and self.orinContentSize / self.textAreaSize < cfg.limitPercent then
    self:_ApplyAdaptionCfg(cfg.adaptionCfg)
    self:_ForeceRefresh()
    isNeedAdjBound = true
  end
  if cfg and cfg.adaptionCfg and isNeedAdjBound then
    self.disableLateUpdate = true
    local offset = 0
    if isDisableAutoScroll then
      local lineCount = self.tmpTextComp.textInfo and self.tmpTextComp.textInfo.lineCount or 0
      local autoSize = isDisableAutoScroll and cfg.adaptionCfg.autoSizeCN or cfg.autoSizeOther
      if 11 == lineCount then
        offset = autoSize and 80 or 130
      elseif 10 == lineCount then
        offset = autoSize and 60 or 110
      elseif 9 == lineCount then
        offset = autoSize and 50 or 90
      elseif 8 == lineCount then
        offset = autoSize and 40 or 70
      elseif 7 == lineCount then
        offset = autoSize and 30 or 50
      elseif 6 == lineCount then
        offset = autoSize and 0 or 30
      end
    else
      local height = cfg.adaptionCfg.height
      if self.orinContentSize * 0.5 > height * 0.5 and self.isVertical then
        offset = self.orinContentSize * 0.5 - height * 0.5
      end
    end
    _SetAnchoredPos(self.tmpTextComp.transform, cfg.adaptionCfg.x, cfg.adaptionCfg.y + offset)
  end
end

function AutoAdaptionText:_ForeceActiveTmp()
  if IsNil(self.tmpTextComp) then
    return
  end
  if not self.tmpTextComp.gameObject.activeInHierarchy then
    local parent = self.tmpTextComp.transform.parent
    while parent do
      local parentGo = parent.gameObject
      if not parentGo.activeSelf then
        parentGo:SetActive(true)
      elseif parentGo.activeInHierarchy then
        break
      end
      parent = parent.transform.parent
    end
  end
end

function AutoAdaptionText:ForceMeshUpdate()
  self:_ForeceRefresh()
end

function AutoAdaptionText:_ForeceRefresh()
  self:_ForeceActiveTmp()
  if self.tmpTextComp.ForceMeshUpdate then
    if ApplicationUtils.IsEditor() then
      xpcall(function()
        self.tmpTextComp:ForceMeshUpdate()
      end, function(err)
        Logger.Error("如果频繁出现这个错误，可能是字体里面新加buff图片导致，重新启动unity")
      end)
    else
      self.tmpTextComp:ForceMeshUpdate()
    end
  end
  self:OnDisable()
  self:OnEnable()
  self:LateUpdate()
end

function AutoAdaptionText:_ApplyAdaptionCfg(cfg)
  if not cfg or IsNil(self.tmpTextComp) then
    return
  end
  local isDisableAutoScroll = self:IsDisbaleAutoScroll()
  self.tmpTextComp.fontSize = cfg.fontSize
  self.tmpTextComp.enableAutoSizing = isDisableAutoScroll and cfg.autoSizeCN or cfg.autoSizeOther
  if isDisableAutoScroll then
    self.tmpTextComp.alignment = cfg.alignmentCN
  else
    self.tmpTextComp.alignment = cfg.alignmentOther
  end
  _SetWidth(self.tmpTextComp.transform, isDisableAutoScroll and cfg.widthCN or cfg.widthOther)
  _SetHeight(self.tmpTextComp.transform, cfg.height)
  TempVec2.x = cfg.pivotX
  TempVec2.y = cfg.pivotY
  self.tmpTextComp.transform.pivot = TempVec2
  TempVec2.x = cfg.anchorX
  TempVec2.y = cfg.anchorY
  self.tmpTextComp.transform.anchorMin = TempVec2
  self.tmpTextComp.transform.anchorMax = TempVec2
  _SetAnchoredPos(self.tmpTextComp.transform, cfg.x, cfg.y)
  if cfg.contentSize then
    self:_SetContentSize(cfg.contentSize)
  end
  if cfg.endWaitTime then
    self:_SetEndWaitTime(cfg.endWaitTime)
  end
end

function AutoAdaptionText:ForceRestart()
  self:ForceUpdate()
end

function AutoAdaptionText:ctor(go)
  self.gameObject = go
  self.isTmpFont = false
  self.tmpTextComp = go:GetComponent(TypeOfTMP_Text)
  if not self.tmpTextComp then
    self.tmpTextComp = go:GetComponent(TypeOfText)
  else
    self.isTmpFont = true
    if not self:IsDisbaleAutoScroll() then
      self.tmpTextComp.enableAutoSizing = false
    end
  end
  self.scrollRect = _GetComponentInParent(go, TypeOfScrollRect)
  self.scrollContent = self.scrollRect.content
  self.viewportMask = self.scrollRect.viewport.gameObject:GetComponent(T_RectMask2D) or self.scrollRect.viewport.gameObject:GetComponent(T_Mask)
  self.maskGrahpic = self.scrollRect.viewport.gameObject:GetComponent(T_MaskableGraphic)
  self.notDrawImage = self.scrollRect.gameObject:GetComponent(TYPEOF_NotDrawImage)
  self.contentSize = 0
  self.pivot = 0
  self.fontOffset = 0
  self.isAutoAdaptionFinished = false
  self._isDragingScrollRect = false
  self.isVertical = self.scrollRect.vertical
  self.scrollRect.movementType = 1
  self.scrollToTopTime = -1
  self.contentSizeOffset = 5
  self.textAreaSize = 0
  self.gesture = self.scrollRect.gameObject:GetComponent(T_DragGesture)
  if not self.gesture then
    self.gesture = self.scrollRect.gameObject:AddComponent(T_DragGesture)
  end
  self.gesture.longPressTime = 0.2
  self.fnOnBeginDragScrollview = System.fn(self, self._OnBeginDragScrollview)
  self.fnOnDragScrollview = System.fn(self, self._OnDragScrollview)
  self.fnOnEndDragScrollview = System.fn(self, self._OnEndDragScrollview)
  self.fnOnClickScrollview = System.fn(self, self._OnClickScrollview)
  self.fnOnPointerDown = System.fn(self, self._OnPointerDown)
  self.fnOnPointerUp = System.fn(self, self._OnPointerUp)
  self.fnOnPointerLong = System.fn(self, self._OnPointerLong)
  local parentGameObject = self.scrollRect.transform.parent.gameObject
  self.parentScrollRect = _GetComponentInParent(parentGameObject, TypeOfScrollRect)
  self._isParentDragging = false
  self._offsetBeforeForward = 0
  self._lastTMPFontSize = -1
  self.waitingTime = 1
  self.handlerBtn = nil
end

function AutoAdaptionText:SetBtn(handlerBtn)
  self.handlerBtn = handlerBtn
  if self.handlerBtn and not IsNil(self.tmpTextComp) then
    self.tmpTextComp.raycastTarget = false
  end
end

function AutoAdaptionText:SetSpeed(spd)
  self._movementSpd = spd or DefaultMovementSpd
end

function AutoAdaptionText:SetContentSizeOffset(ofs)
  self.contentSizeOffset = ofs or 8
end

function AutoAdaptionText:SetEnableAutoSizing(enabled)
  local isDisableAutoScroll = self:IsDisbaleAutoScroll()
  if isDisableAutoScroll then
    return
  end
  if self.tmpTextComp and self.isTmpFont then
    self.tmpTextComp.enableAutoSizing = enabled
  end
end

function AutoAdaptionText:SetPivot(pivot)
  self.pivot = pivot or 0
end

function AutoAdaptionText:SetFontOffset(fontOffset)
  self.fontOffset = fontOffset or 0
end

function AutoAdaptionText:OnEnable()
  if self.disableLateUpdate then
    return
  end
  self.orinContentSize = 0
  self.waitingTime = 1
  self._lastTMPFontSize = -1
  self.isAutoAdaptionFinished = false
  self._isDragingScrollRect = false
  self._isParentDragging = false
  self.gesture:onBeginDrag("+", self.fnOnBeginDragScrollview)
  self.gesture:onDrag("+", self.fnOnDragScrollview)
  self.gesture:onEndDrag("+", self.fnOnEndDragScrollview)
  self.gesture:onPointerClick("+", self.fnOnClickScrollview)
  self.gesture:onPointerDown("+", self.fnOnPointerDown)
  self.gesture:onPointerUp("+", self.fnOnPointerUp)
  self.gesture:onPointerLong("+", self.fnOnPointerLong)
  self:_SetContentOffset(0)
  LateUpdateBeat.Instance:Add(self.LateUpdate, self)
end

function AutoAdaptionText:OnDisable()
  self.disableLateUpdate = false
  LateUpdateBeat.Instance:Remove(self.LateUpdate, self)
  self.gesture:onBeginDrag("-", self.fnOnBeginDragScrollview)
  self.gesture:onDrag("-", self.fnOnDragScrollview)
  self.gesture:onEndDrag("-", self.fnOnEndDragScrollview)
  self.gesture:onPointerClick("-", self.fnOnClickScrollview)
  self.gesture:onPointerDown("-", self.fnOnPointerDown)
  self.gesture:onPointerUp("-", self.fnOnPointerUp)
  self.gesture:onPointerLong("-", self.fnOnPointerLong)
end

function AutoAdaptionText:LateUpdate()
  if IsNil(self.viewportMask) then
    LateUpdateBeat.Instance:Remove(self.LateUpdate, self)
    return
  end
  if (self._drawDelegate or self.handlerBtn) and not IsNil(self.tmpTextComp) then
    self.tmpTextComp.raycastTarget = false
  end
  if self.disableLateUpdate then
    return
  end
  if self:IsDisbaleAutoScroll() then
    self:_OnDisableAutoAdaption()
    return
  end
  self:_CalTextAreaSize()
  self:_CalContentSize()
  if self:_IsNeedAutoScroll() then
    self:_OnEnableAutoAdaption()
    self:_UpdateAutoAdaption()
  else
    self:_OnDisableAutoAdaption()
  end
end

function AutoAdaptionText:SetForceAutoScroll(isForce)
  self._forceAutoScroll = isForce
end

function AutoAdaptionText:IsDisbaleAutoScroll()
  if self._forceAutoScroll then
    return false
  end
  do return end
  return Utils.IsLangChinese
end

function AutoAdaptionText:_IsNeedAutoScroll()
  local preferredSize = self.orinContentSize
  if preferredSize <= self.textAreaSize then
    return false
  end
  return true
end

function AutoAdaptionText:_OnEnableAutoAdaption()
  self:_SetContentSize(self.contentSize)
  self.scrollRect.enabled = true
  self.notDrawImage.enabled = true
  self.viewportMask.enabled = true
  self.gesture.enabled = true
  if self.maskGrahpic then
    self.maskGrahpic.enabled = true
  end
end

function AutoAdaptionText:_OnDisableAutoAdaption()
  if self._isDragingScrollRect and self._drawDelegate then
    return
  end
  self.scrollRect.enabled = false
  if not IsNil(self.viewportMask) then
    self.viewportMask.enabled = false
  end
  if not IsNil(self.notDrawImage) then
    self.notDrawImage.enabled = false
  end
  if not IsNil(self.gesture) then
    self.gesture.enabled = false
  end
  if not IsNil(self.maskGrahpic) then
    self.maskGrahpic.enabled = false
  end
  self:_SetContentOffset(0)
end

function AutoAdaptionText:_UpdateAutoAdaption()
  self:_AutoScrollToTop()
  if self.isAutoAdaptionFinished then
    return
  end
  if 0 == self.minContentOffset - self.maxContentOffset then
    self:_OnDisableAutoAdaption()
    return
  end
  if self.waitingTime > 0 then
    self.waitingTime = self.waitingTime - UnityTime.deltaTime
    return
  end
  local spd = self._movementSpd or DefaultMovementSpd
  local ay = self:_GetContentOffset()
  local sign = self.maxContentOffset < self.minContentOffset and -1 or 1
  ay = ay + sign * spd * UnityTime.deltaTime
  if sign < 0 then
    if ay < self.maxContentOffset then
      ay = self.maxContentOffset
      self.isAutoAdaptionFinished = true
      self.scrollToTopTime = 1
    end
  elseif ay > self.maxContentOffset then
    ay = self.maxContentOffset
    self.isAutoAdaptionFinished = true
    self.scrollToTopTime = 1
  end
  self:_SetContentOffset(ay)
end

function AutoAdaptionText:_GetMinContentOffset()
  local delta = self.contentSize - self.textAreaSize
  local pivot = self.pivot
  return -pivot * delta
end

function AutoAdaptionText:_GetMaxContentOffset()
  local delta = self.contentSize - self.textAreaSize
  local pivot = self.pivot
  return -pivot * delta
end

function AutoAdaptionText:_AutoScrollToTop()
  if self.scrollToTopTime > 0 then
    if self.endWaitTime and self.endWaitTime > 0 then
      self.endWaitTime = self.endWaitTime - UnityTime.deltaTime
      return
    end
    self.scrollToTopTime = self.scrollToTopTime - UnityTime.deltaTime
    if self.scrollToTopTime <= 0 then
      self.scrollToTopTime = -1
      self:_SetContentOffset(self.minContentOffset)
    end
  end
end

function AutoAdaptionText:_GetContentOffset()
  local ax, ay = _GetAnchoredPos(self.scrollContent, nil, nil)
  if self.isVertical then
    return ay
  else
    return ax
  end
end

function AutoAdaptionText:_SetContentOffset(ofs)
  local ax, ay = _GetAnchoredPos(self.scrollContent, nil, nil)
  if self.isVertical then
    _SetAnchoredPos(self.scrollContent, ax, ofs)
  else
    _SetAnchoredPos(self.scrollContent, ofs, ay)
  end
end

function AutoAdaptionText:_SetContentSize(size)
  self.contentSize = size
  if self.isVertical then
    _SetHeight(self.scrollContent, self.contentSize)
  else
    _SetWidth(self.scrollContent, self.contentSize)
  end
end

function AutoAdaptionText:_SetEndWaitTime(time)
  self.endWaitTime = time or 0
end

local BoundaryTolerance = 1

function AutoAdaptionText:_IsAtScrollBoundary()
  local offset = self:_GetContentOffset()
  if math.abs(offset - self.minContentOffset) <= BoundaryTolerance then
    return "min"
  end
  if math.abs(offset - self.maxContentOffset) <= BoundaryTolerance then
    return "max"
  end
  return nil
end

function AutoAdaptionText:_GetDragDelta(eventData)
  if self.isVertical then
    return eventData.delta.y
  else
    return eventData.delta.x
  end
end

function AutoAdaptionText:_OnBeginDragScrollview(eventData)
  self.isAutoAdaptionFinished = true
  self._isDragingScrollRect = true
  self.scrollToTopTime = -1
  self._isParentDragging = false
  if self._drawDelegate and self._drawDelegate.OnBeginDrag then
    self._drawDelegate:OnBeginDrag(eventData)
  end
end

function AutoAdaptionText:_OnDragScrollview(eventData)
  if self.parentScrollRect then
    local boundary = self:_IsAtScrollBoundary()
    local isForwardToParent = false
    if boundary then
      local delta = self:_GetDragDelta(eventData)
      if "min" == boundary and delta < 0 or "max" == boundary and delta > 0 then
        isForwardToParent = true
      end
    end
    if isForwardToParent then
      if not self._isParentDragging then
        self.scrollRect.movementType = 2
        self._offsetBeforeForward = self:_GetContentOffset()
        self.parentScrollRect:OnBeginDrag(eventData)
        self._isParentDragging = true
      end
      self:_SetContentOffset(self._offsetBeforeForward)
      self.parentScrollRect:OnDrag(eventData)
    elseif self._isParentDragging then
      self.parentScrollRect:OnEndDrag(eventData)
      self.scrollRect.movementType = 1
      self._isParentDragging = false
    end
  end
  if self._drawDelegate and self._drawDelegate.OnDrag then
    self._drawDelegate:OnDrag(eventData)
  end
end

function AutoAdaptionText:_OnEndDragScrollview(eventData)
  self._isDragingScrollRect = false
  if self._isParentDragging then
    self.parentScrollRect:OnEndDrag(eventData)
    self.scrollRect.movementType = 1
    self._isParentDragging = false
  end
  if self._drawDelegate and self._drawDelegate.OnEndDrag then
    self._drawDelegate:OnEndDrag(eventData)
  end
end

function AutoAdaptionText:_OnClickScrollview(eventData)
  if not IsNil(self.handlerBtn) then
    local buttonComp = self.handlerBtn.gameObject:GetComponent(TYPEOF_Z1Button)
    if nil == buttonComp then
      buttonComp = self.handlerBtn.gameObject:GetComponent(TYPEOF_Button)
    end
    if buttonComp and buttonComp.onClick then
      buttonComp.onClick:Invoke()
    else
      buttonComp = self.handlerBtn.gameObject:GetComponent(TYPEOF_RepeatButton)
      if buttonComp and buttonComp.onShortPress then
        buttonComp.onShortPress:Invoke()
      end
    end
  end
end

function AutoAdaptionText:_OnPointerDown(eventData)
  if self._drawDelegate and self._drawDelegate.OnPointerDown then
    self._drawDelegate:OnPointerDown(eventData)
  end
end

function AutoAdaptionText:_OnPointerUp(eventData)
  if self._drawDelegate and self._drawDelegate.OnPointerUp then
    self._drawDelegate:OnPointerUp(eventData)
  end
end

function AutoAdaptionText:_OnPointerLong(eventData)
  if self._drawDelegate and self._drawDelegate.OnPointerLong then
    self._drawDelegate:OnPointerLong(eventData)
  end
end

function AutoAdaptionText:_CalTextWidthFromCharInfo()
  local textInfo = self.tmpTextComp.textInfo
  if not textInfo or 0 == textInfo.characterCount then
    return self.tmpTextComp.preferredWidth
  end
  local maxAdvance = 0
  local hasVisible = false
  for i = 0, textInfo.characterCount - 1 do
    local charInfo = textInfo.characterInfo[i]
    if charInfo.isVisible then
      hasVisible = true
      if maxAdvance < charInfo.xAdvance then
        maxAdvance = charInfo.xAdvance
      end
    end
  end
  if hasVisible then
    return maxAdvance
  end
  return self.tmpTextComp.preferredWidth
end

function AutoAdaptionText:_CalTMPSize()
  if self.isVertical then
    if not self.tmpTextComp.textInfo then
      return self.tmpTextComp.preferredHeight + self.contentSizeOffset
    end
    local fontSpaceing = self.tmpTextComp.lineSpacing / 100 * self.tmpTextComp.fontSize
    local lineCount = self.tmpTextComp.textInfo.lineCount
    local height = 0
    for i = 0, lineCount - 1 do
      height = height + self.tmpTextComp.textInfo.lineInfo[i].lineHeight
    end
    height = height + fontSpaceing * (lineCount - 1)
    local langCode = DataCenter.gameData.CurrTextLanguage
    if self.tmpTextComp.enableAutoSizing and ("CN" == langCode or "TW" == langCode or "JP" == langCode or "KR" == langCode) then
      return math.min(height, self.tmpTextComp.preferredHeight) + self.contentSizeOffset
    end
    return math.max(height, self.tmpTextComp.preferredHeight) + self.contentSizeOffset
  else
    if self.tmpTextComp.enableAutoSizing then
      self.tmpTextComp:ForceMeshUpdate()
      return self:_CalTextWidthFromCharInfo() + self.contentSizeOffset
    end
    return self.tmpTextComp.preferredWidth + self.contentSizeOffset
  end
end

function AutoAdaptionText:_CalContentSize()
  local tmpSize = self:_CalTMPSize()
  if self._lastTMPFontSize == tmpSize then
    return
  end
  self._lastTMPFontSize = tmpSize
  self.contentSize = tmpSize + self.fontOffset
  self.orinContentSize = self.contentSize - self.contentSizeOffset
  if 0 == self.pivot then
    if self.isVertical then
      self.minContentOffset = 0
      self.maxContentOffset = self.contentSize - self.textAreaSize
    else
      self.minContentOffset = 0
      self.maxContentOffset = self.textAreaSize - self.contentSize
    end
  elseif 1 == self.pivot then
    if self.isVertical then
      self.minContentOffset = math.min(self.textAreaSize * 0.5 - (self.fontOffset + self.contentSize * 0.5), 0)
      self.maxContentOffset = math.max(self.contentSize * 0.5 - self.fontOffset - self.textAreaSize * 0.5, 0)
    else
      self.minContentOffset = math.max(tmpSize * 0.5 - self.fontOffset - self.textAreaSize * 0.5, 0)
      self.maxContentOffset = math.min(self.textAreaSize * 0.5 - (self.fontOffset + tmpSize * 0.5), 0)
    end
  elseif self.isVertical then
    self.minContentOffset = math.min(self.textAreaSize - self.contentSize, 0)
    self.maxContentOffset = 0
  else
    self.minContentOffset = self.contentSize - self.textAreaSize
    self.maxContentOffset = 0
  end
  self:_SetContentOffset(self.minContentOffset)
end

function AutoAdaptionText:_CalTextAreaSize()
  if IsNil(self.scrollRect) or IsNil(self.scrollRect.viewport) then
    return
  end
  if self.isVertical then
    self.textAreaSize = self.scrollRect.viewport.rect.height
  else
    self.textAreaSize = self.scrollRect.viewport.rect.width
  end
end

return AutoAdaptionText
