local ViewComponent = NewClass("ViewComponent")

function ViewComponent:ctor(gameObject, view)
  self.view = view
  self.binder = view.binder:createChild(view.binder)
  self.gameObject = gameObject
  self.viewComponents = nil
  self.notificationsMgr = UIViewNotificationsMgr(view)
  self.viewCompsMgr = UIViewComponentsMgr(view)
  self.instantiateGos = nil
end

function ViewComponent:RegisterNotifications()
end

function ViewComponent:RegisterEvents()
end

function ViewComponent:UpdateLocalizedTextAndResouce()
  if self.binder then
    self.binder:UpdateLocalizedTextAndResouce(self.gameObject)
  end
end

function ViewComponent:OnBuildComponent()
end

function ViewComponent:OnEnterComponent()
end

function ViewComponent:OnExitComponent()
  self.notificationsMgr:Clear()
  self.viewCompsMgr:Dispose()
  self:RemoveAllEvents()
  if self.binder then
    self.binder:teardown()
  end
  self.view = nil
  ResLoadMgr.UnloadAssetByTarget(self)
  if self.instantiateGos then
    for i = 1, #self.instantiateGos do
      Destroy(self.instantiateGos[i])
    end
    self.instantiateGos = nil
  end
end

function ViewComponent:RegisterNotify(name, handler, handlerObj, priority)
  if self.view then
    self.notificationsMgr:RegisterNotify(name, handler, handlerObj, priority)
  end
end

function ViewComponent:UnregisterNotify(name, handler, handlerObj)
  Logger.Error("UnregisterNotify : ", name)
  if self.view then
    self.notificationsMgr:UnregisterNotify(name, handler, handlerObj)
  end
end

function ViewComponent:Notify(name, ...)
  if self.view then
    self.notificationsMgr:Notify(name, ...)
  end
end

function ViewComponent:RegisterLocalNotify(name, handler, handlerObj, priority)
  if self.view then
    self.notificationsMgr:RegisterLocalNotify(name, handler, handlerObj, priority)
  end
end

function ViewComponent:UnregisterLocalNotify(name, handler, handlerObj)
  Logger.Error("UnregisterLocalNotify : ", name)
  if self.view then
    self.notificationsMgr:UnregisterLocalNotify(name, handler, handlerObj)
  end
end

function ViewComponent:LocalNotify(name, ...)
  if self.view then
    self.notificationsMgr:LocalNotify(name, ...)
  end
end

function ViewComponent:BindEvent(event, callback)
  if not self.evengsMgr then
    self.evengsMgr = UIViewEventsMgr()
  end
  self.evengsMgr:BindEvent(event, callback)
end

function ViewComponent:BindEventOnce(event, callback)
  if not self.evengsMgr then
    self.evengsMgr = UIViewEventsMgr()
  end
  self.evengsMgr:BindEventOnce(event, callback)
end

function ViewComponent:RemoveEvent(event, callback)
  if self.evengsMgr then
    self.evengsMgr:RemoveEvent(event, callback)
  end
end

function ViewComponent:RemoveAllEvents()
  if self.evengsMgr then
    self.evengsMgr:RemoveAllEvents()
  end
end

function ViewComponent:BindTimer(duration, repeatTimes, repeatCallback, finishCallback)
  if self.view then
    do return self.view.BindTimer, self.view, duration, repeatTimes, repeatCallback end
    return self.view.BindTimer, self.view, duration, repeatTimes, repeatCallback, finishCallback
  end
end

function ViewComponent:StopTimer(timerId)
  if self.view then
    self.view:StopTimer(timerId)
  end
end

function ViewComponent:StopAllTimers()
  if self.view then
    self.view:StopAllTimers()
  end
end

function ViewComponent:SetActive(owner, isActive)
  if self.view then
    self.view:SetActive(owner, isActive)
  end
end

function ViewComponent:SetText(owner, value, isUseBigFont, linkCallBack, extraParam)
  if self.view then
    self.view:SetText(owner, value, isUseBigFont, linkCallBack, extraParam)
  end
end

function ViewComponent:SetRawText(owner, value)
  if self.view then
    self.view:SetRawText(owner, value)
  end
end

function ViewComponent:GetTextComp(owner)
  if self.view then
    do return self.view.GetTextComp, self.view end
    return self.view.GetTextComp, self.view, owner
  end
end

function ViewComponent:GetColorStr(wordEffectKey)
  if self.view then
    do return self.view.GetColorStr, self.view end
    return self.view.GetColorStr, self.view, wordEffectKey
  end
end

function ViewComponent:GetColorText(text, wordEffectKey)
  if self.view then
    do return self.view.GetColorText, self.view, text end
    return self.view.GetColorText, self.view, text, wordEffectKey
  end
end

function ViewComponent:SetTextColor(owner, x, y, z, w)
  if self.view then
    self.view:SetTextColor(owner, x, y, z, w)
  end
end

function ViewComponent:SetTextColorByHtml(owner, colorStr)
  if self.view then
    self.view:SetTextColorByHtml(owner, colorStr)
  end
end

function ViewComponent:ChangeNumInAnim(owner, oldNum, targetNum)
  if self.view then
    self.view:ChangeNumInAnim(owner, oldNum, targetNum)
  end
end

function ViewComponent:SetTextSize(owner, fontSize)
  if self.view then
    self.view:SetTextSize(owner, fontSize)
  end
end

function ViewComponent:SetTextColorType(owner, colorType)
  if self.view then
    self.view:SetTextColorType(owner, colorType)
  end
end

function ViewComponent:SetTextColorCode(owner, colorHexCode)
  if self.view then
    self.view:SetTextColorCode(owner, colorHexCode)
  end
end

function ViewComponent:SetImageColor(owner, color)
  if self.view then
    self.view:SetImageColor(owner, color)
  end
end

function ViewComponent:SetImageColorRGBA(owner, x, y, z, w)
  if self.view then
    self.view:SetImageColorRGBA(owner, x, y, z, w)
  end
end

function ViewComponent:SetImageAlpha(owner, a)
  if self.view then
    self.view:SetImageAlpha(owner, a)
  end
end

function ViewComponent:SetImageColorByHtml(owner, colorStr)
  if self.view then
    self.view:SetImageColorByHtml(owner, colorStr)
  end
end

function ViewComponent:SetImageFillAmount(owner, fillAmount)
  if self.view then
    self.view:SetImageFillAmount(owner, fillAmount)
  end
end

function ViewComponent:SetCanvasGroup(owner, alpha)
  if self.view then
    self.view:SetCanvasGroup(owner, alpha)
  end
end

function ViewComponent:AddCanvasGroupOnce(owner)
  if self.view then
    do return self.view.AddCanvasGroupOnce, self.view end
    return self.view.AddCanvasGroupOnce, self.view, owner
  end
end

function ViewComponent:DotweenProcessAlpha(owner, alpha, time)
  if self.view then
    do return self.view.DotweenProcessAlpha, self.view, owner, alpha end
    return self.view.DotweenProcessAlpha, self.view, owner, alpha, time
  end
end

function ViewComponent:SetCanvasGroupBlocksRaycasts(owner, blocksRaycasts)
  if self.view then
    self.view:SetCanvasGroupBlocksRaycasts(owner, blocksRaycasts)
  end
end

function ViewComponent:SetCanvasGroupVisible(owner, visible)
  if self.view then
    self.view:SetCanvasGroupVisible(owner, visible)
  end
end

function ViewComponent:DotweenTo(getter, setter, endValue, duration)
  if self.view then
    do return self.view.DotweenTo, self.view, getter, setter, endValue end
    return self.view.DotweenTo, self.view, getter, setter, endValue, duration
  end
end

function ViewComponent:AddComponentOnce(owner, compType)
  if self.view then
    do return self.view.AddComponentOnce, self.view, owner end
    return self.view.AddComponentOnce, self.view, owner, compType
  end
end

function ViewComponent:LoadAsset(path, assetType)
  if self.view then
    do return self.view.LoadAsset, self.view, path end
    return self.view.LoadAsset, self.view, path, assetType
  end
end

function ViewComponent:LoadAssetAsync(path, callback)
  if self.view then
    do return self.view.LoadAssetAsync, self.view, path end
    return self.view.LoadAssetAsync, self.view, path, callback
  end
end

function ViewComponent:SetImage(owner, path, nativeSize, callback)
  if self.view then
    self.view:SetImage(owner, path, nativeSize, callback)
  end
end

function ViewComponent:ClearImage(owner)
  if self.view then
    self.view:ClearImage(owner)
  end
end

function ViewComponent:SetImageSync(owner, path, nativeSize)
  if self.view then
    self.view:SetImageSync(owner, path, nativeSize)
  end
end

function ViewComponent:Instantiate(asset, parentTrans)
  local go = Instantiate(asset, parentTrans)
  if go then
    self.instantiateGos = self.instantiateGos or {}
    table.insert(self.instantiateGos, go)
  end
  return go
end

function ViewComponent:AddInputValueChangeListener(owner, onChange)
  if self.view then
    do return self.view.AddInputValueChangeListener, self.view, owner end
    return self.view.AddInputValueChangeListener, self.view, owner, onChange
  end
end

function ViewComponent:SetInputText(owner, txt)
  if self.view then
    do return self.view.SetInputText, self.view, owner end
    return self.view.SetInputText, self.view, owner, txt
  end
end

function ViewComponent:SetIcon(iconType, parent, itemData)
  if self.view then
    self.view:SetIcon(iconType, parent, itemData)
  end
end

function ViewComponent:ClearIcon(parent)
  if self.view then
    self.view:ClearIcon(parent)
  end
end

function ViewComponent:PlayEffect(effPath, owner, offsetX, offsetY, loop)
  if self.view then
    do return self.view.PlayEffect, self.view, effPath, owner, offsetX, offsetY end
    return self.view.PlayEffect, self.view, effPath, owner, offsetX, offsetY, loop
  end
end

function ViewComponent:StopEffect(eff)
  if self.view then
    self.view:StopEffect(eff)
  end
end

function ViewComponent:PlayAnimator(animator, name, argType, arg)
  if self.view then
    self.view:PlayAnimator(animator, name, argType, arg)
  end
end

function ViewComponent:GetButton(owner)
  if self.view then
    do return self.view.GetButton, self.view end
    return self.view.GetButton, self.view, owner
  end
end

function ViewComponent:AddButtonClickListener(owner, onClick)
  if self.view then
    self.view:AddButtonClickListener(owner, onClick)
  end
end

function ViewComponent:RemoveButtonClickListener(owner)
  if self.view then
    self.view:RemoveButtonClickListener(owner)
  end
end

function ViewComponent:SetButtonText(owner, txt)
  if self.view then
    self.view:SetButtonText(owner, txt)
  end
end

function ViewComponent:SetButtonRedPoint(owner, redFunc)
  if self.view then
    self.view:SetButtonRedPoint(owner, redFunc)
  end
end

function ViewComponent:SetButtonState(owner, btnState)
  if self.view then
    self.view:SetButtonState(owner, btnState)
  end
end

function ViewComponent:SetButtonChosen(owner, isChosen)
  if self.view then
    self.view:SetButtonChosen(owner, isChosen)
  end
end

function ViewComponent:DisableButtonAudioEffect(owner, disable)
  if self.view then
    self.view:DisableButtonAudioEffect(owner, disable)
  end
end

function ViewComponent:ApplyEffectToButton(owner, isShowAppear)
  if self.view then
    self.view:ApplyEffectToButton(owner, isShowAppear)
  end
end

function ViewComponent:SetZ1Toggle(owner, isOn, withoutNotify)
  if self.view then
    self.view:SetZ1Toggle(owner, isOn, withoutNotify)
  end
end

function ViewComponent:AddZ1ToggleValueChangedListener(owner, onToggleChange, lockClickFunc)
  if self.view then
    self.view:AddZ1ToggleValueChangedListener(owner, onToggleChange, lockClickFunc)
  end
end

function ViewComponent:RemoveZ1ToggleValueChangedListener(owner)
  if self.view then
    self.view:RemoveZ1ToggleValueChangedListener(owner)
  end
end

function ViewComponent:SetZ1ToggleText(owner, txt)
  if self.view then
    self.view:SetZ1ToggleText(owner, txt)
  end
end

function ViewComponent:SetZ1ToggleTextColorType(owner, t)
  if self.view then
    self.view:SetZ1ToggleTextColorType(owner, t)
  end
end

function ViewComponent:SetZ1ToggleUnlock(owner, isUnlocked)
  if self.view then
    self.view:SetZ1ToggleUnlock(owner, isUnlocked)
  end
end

function ViewComponent:AddDropdownListener(owner, dataList, onValueChanged)
  if self.view then
    self.view:AddDropdownListener(owner, dataList, onValueChanged)
  end
end

function ViewComponent:RemoveDropdownValueChangedListener(owner)
  if self.view then
    self.view:RemoveDropdownValueChangedListener(owner)
  end
end

function ViewComponent:SetDropdownValue(owner, index)
  if self.view then
    self.view:SetDropdownValue(owner, index)
  end
end

function ViewComponent:GetDropdownValue(owner)
  if self.view then
    do return self.view.GetDropdownValue, self.view end
    return self.view.GetDropdownValue, self.view, owner
  end
end

function ViewComponent:AddSliderListener(owner, onValueChanged)
  if self.view then
    self.view:AddSliderListener(owner, onValueChanged)
  end
end

function ViewComponent:RemoveSliderListener(owner)
  if self.view then
    self.view:RemoveSliderListener(owner)
  end
end

function ViewComponent:SetSliderValue(owner, value)
  if self.view then
    self.view:SetSliderValue(owner, value)
  end
end

function ViewComponent:GetSliderValue(owner)
  if self.view then
    do return self.view.GetSliderValue, self.view end
    return self.view.GetSliderValue, self.view, owner
  end
end

function ViewComponent:AddViewComponent(gameObject, viewComponentCls, ...)
  if self.view then
    do return self.viewCompsMgr.AddViewComponent, self.viewCompsMgr, gameObject, viewComponentCls, ... end
    return self.viewCompsMgr.AddViewComponent, self.viewCompsMgr, gameObject, viewComponentCls, ...
  end
end

function ViewComponent:AddViewComponentOnce(gameObject, viewComponentCls, ...)
  if self.view then
    do return self.viewCompsMgr.AddViewComponentOnce, self.viewCompsMgr, gameObject, viewComponentCls, ... end
    return self.viewCompsMgr.AddViewComponentOnce, self.viewCompsMgr, gameObject, viewComponentCls, ...
  end
end

function ViewComponent:RemoveViewComponentOnce(gameObject, viewComponentCls)
  if self.view then
    do return self.viewCompsMgr.RemoveViewComponentOnce, self.viewCompsMgr, gameObject end
    return self.viewCompsMgr.RemoveViewComponentOnce, self.viewCompsMgr, gameObject, viewComponentCls
  end
end

function ViewComponent:GetViewComponent(gameObject, viewComponentCls)
  if self.view then
    do return self.viewCompsMgr.GetViewComponent, self.viewCompsMgr, gameObject end
    return self.viewCompsMgr.GetViewComponent, self.viewCompsMgr, gameObject, viewComponentCls
  end
end

function ViewComponent:FindChild(go, childName)
  if self.view then
    do return self.view.FindChild, self.view, go end
    return self.view.FindChild, self.view, go, childName
  end
  return nil
end

function ViewComponent:FindChildComponent(go, childName, comp)
  if self.view then
    do return self.view.FindChildComponent, self.view, go, childName end
    return self.view.FindChildComponent, self.view, go, childName, comp
  end
  return nil
end

function ViewComponent:FindChildRecursively(root, childName)
  if self.view then
    do return self.view.FindChildRecursively, self.view, root end
    return self.view.FindChildRecursively, self.view, root, childName
  end
  return nil
end

function ViewComponent:Travel(root, func)
  if self.view then
    self.view:Travel(root, func)
  end
end

function ViewComponent:AddPressDownListener(owner, onClick)
  if self.view then
    self.view:AddPressDownListener(owner, onClick)
  end
end

function ViewComponent:RemovePressDownListener(owner)
  if self.view then
    self.view:RemovePressDownListener(owner)
  end
end

function ViewComponent:AddPressUpListener(owner, onPointerUp)
  if self.view then
    self.view:AddPressUpListener(owner, onPointerUp)
  end
end

function ViewComponent:RemovePressUpListener(owner)
  if self.view then
    self.view:RemovePressUpListener(owner)
  end
end

function ViewComponent:SetLongPressButtonIntervalTime(owner, intervalTime)
  if self.view then
    self.view:SetLongPressButtonIntervalTime(owner, intervalTime)
  end
end

function ViewComponent:AddLongPressButtonListener(owner, onLongPress)
  if self.view then
    self.view:AddLongPressButtonListener(owner, onLongPress)
  end
end

function ViewComponent:RemoveLongPressButtonListener(owner)
  if self.view then
    self.view:RemoveLongPressButtonListener(owner)
  end
end

function ViewComponent:AddShortPressButtonListener(owner, onClick)
  if self.view then
    self.view:AddShortPressButtonListener(owner, onClick)
  end
end

function ViewComponent:RemoveShortPressButtonListener(owner)
  if self.view then
    self.view:RemoveShortPressButtonListener(owner)
  end
end

function ViewComponent:DisableRepeatButtonPress(owner)
  if self.view then
    self.view:DisableRepeatButtonPress(owner)
  end
end

function ViewComponent:AddOnBeginDragListener(owner, onBegion)
  if self.view then
    self.view:AddOnBeginDragListener(owner, onBegion)
  end
end

function ViewComponent:RemoveOnBeginDragListener(owner)
  if self.view then
    self.view:RemoveOnBeginDragListener(owner)
  end
end

function ViewComponent:SetButtonGray(owner, isGray, isClickable)
  if self.view then
    self.view:SetButtonGray(owner, isGray, isClickable)
  end
end

function ViewComponent:SetButtonInteractable(owner, isClickable, resetCd)
  if self.view then
    self.view:SetButtonInteractable(owner, isClickable, resetCd)
  end
end

function ViewComponent:AddUICustomInputlistener(owner, onClick)
  if self.view then
    self.view:AddUICustomInputlistener(owner, onClick)
  end
end

function ViewComponent:RemoveUICustomInputlistener(owner)
  if self.view then
    self.view:RemoveUICustomInputlistener(owner)
  end
end

function ViewComponent:CreateTableview(owner, numberCellsInTableview, tableCellAtIndex, tableCellSizeForIndex, cleaner)
  if self.view then
    do return self.view.CreateTableview, self.view, owner, numberCellsInTableview, tableCellAtIndex, tableCellSizeForIndex end
    return self.view.CreateTableview, self.view, owner, numberCellsInTableview, tableCellAtIndex, tableCellSizeForIndex, cleaner
  end
end

function ViewComponent:PlayTableViewFadeInAnim(listGo)
  if self.view then
    do return self.view.PlayTableViewFadeInAnim, self.view end
    return self.view.PlayTableViewFadeInAnim, self.view, listGo
  end
end

function ViewComponent:PushCommand(handler, handlerObj, repeatable, ...)
  if self.view then
    do return self.view.PushCommand, self.view, handler, handlerObj, repeatable, ... end
    return self.view.PushCommand, self.view, handler, handlerObj, repeatable, ...
  end
end

function ViewComponent:ExecuteCommandBuffer()
  if self.view then
    self.view:ExecuteCommandBuffer()
  end
end

function ViewComponent:ReserveChildren(transform, num)
  if self.view then
    do return self.view.ReserveChildren, self.view, transform end
    return self.view.ReserveChildren, self.view, transform, num
  end
  return 0
end

function ViewComponent:LoadAllLangFont(owner)
  if self.view then
    self.view:LoadAllLangFont(owner)
  end
end

function ViewComponent:AddRedPoint(gameObject, redPointID, redArgs)
  if self.view then
    self.view:AddRedPoint(gameObject, redPointID, redArgs)
  end
end

return ViewComponent
