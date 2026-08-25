local UIViewNotificationsMgr = _ENV.UIViewNotificationsMgr
local UIViewEffectMgr = _ENV.UIViewEffectMgr
local ResLoadMgr = _ENV.ResLoadMgr
local Color = CS.UnityEngine.Color
local ColorUtils = _ENV.ColorUtils
local DOTween = CS.DG.Tweening.DOTween
local DOTweenUtils = _ENV.DOTweenUtils
local UIAudioManager = _ENV.UIAudioManager
local DataCenter = _ENV.DataCenter
local EventMgr = _ENV.EventMgr
local Z1ButtonState = CS.Z1Client.Z1ButtonState
local Z1ButtonType = CS.Z1Client.Z1ButtonType
local StrUtils = _ENV.StrUtils
local UICustomInput = CS.UICustomInput
local CommandBufferMgr = _ENV.CommandBufferMgr
local T_Image = typeof(CS.UnityEngine.UI.Image)
local T_Animator = typeof(CS.UnityEngine.Animator)
local T_Z1Toggle = typeof(CS.Z1Client.Z1Toggle)
local T_CanvasGroup = typeof(CS.UnityEngine.CanvasGroup)
local T_AudioEffect = typeof(CS.FrameWork.AudioEffect)
local T_RepeatButton = typeof(CS.RepeatButton)
local T_UITableview = typeof(CS.UITableview)
local T_InputField = typeof(CS.UnityEngine.UI.InputField)
local T_TMP_InputField = typeof(CS.TMPro.TMP_InputField)
local T_Toggle = typeof(CS.UnityEngine.UI.Toggle)
local T_Slider = typeof(CS.UnityEngine.UI.Slider)
local T_Text = typeof(CS.UnityEngine.UI.Text)
local T_TMP_Text = typeof(CS.TMPro.TMP_Text)
local T_TMP_Dropdown = typeof(CS.TMPro.TMP_Dropdown)
local TMPDropdownOption = CS.TMPro.TMP_Dropdown.OptionData
local IsResourceLoading = CS.Z1Client.LuaCSharpUtil.IsResourceLoading
local _TimerManager = TimerManager.Instance
local _CreateTimer = TimerManager.Instance.CreateTimer
local _StopTimer = TimerManager.Instance.StopTimer
local _AddComponentOnce = AddComponentOnce
local _GetRealtimeSinceStartup = CS.Framework.TimeUtil.GetRealtimeSinceStartup
local _SetLocalEulerAngles = CS.Framework.TransformUtil.SetLocalEulerAngles
local _GetLocalEulerAngles = CS.Framework.TransformUtil.GetLocalEulerAngles
local _FindChild = CS.Framework.GameObjectUtil.FindChild
local getmetatable = _ENV.getmetatable
local tableCellSize = CS.UnityEngine.Vector2(0, 0)
local IsEditor = CS.Z1Client.General.OSDef.isEditor
local IllegalFunctionsInBinder
if IsEditor then
  IllegalFunctionsInBinder = {
    BindAction = "Binder.BindAction已经被禁用",
    BindToRaw = "Binder.BindToRaw已经被禁用",
    BindComponent = "Binder.BindComponent已经被禁用，请使用BaseView.AddViewComponent或者ViewComponent.AddViewComponent",
    BindFrom = "Binder.BindFrom已经被禁用",
    BindToRawProperty = "Binder.BindToRawProperty已经被禁用",
    BindToProperty = "Binder.BindToProperty已经被禁用",
    SimpleBindToRaw = "Binder.SimpleBindToRaw已经被禁用",
    BindCallback = "Binder.BindCallback已经被禁用",
    BindEvent = "Binder.BindEvent已经被禁用，请用BaseView.BindEvent",
    BindConditionEvent = "Binder.BindConditionEvent已经被禁用",
    BindOnceEvent = "Binder.BindOnceEvent已经被禁用，请用BaseView.BindEventOnce",
    BindSet = "Binder.BindSet已经被禁用",
    BindRawTable = "Binder.BindRawTable已经被禁用",
    BindToText = "Binder.BindToText已经被禁用，请用BaseView.SetText结合事件来使用",
    BindToRawText = "Binder.BindToRawText已经被禁用，请用BaseView.SetRawText结合事件来使用",
    BindToTextWithColor = "Binder.BindToTextWithColor已经被禁用，请用BaseView.SetText结合事件来使用",
    BindToTextColorOld = "Binder.BindToTextColorOld已经被禁用，请用BaseView.SetTextColorByHtml结合事件来使用",
    ChangeNumInAnim = "Binder.ChangeNumInAnim已经被禁用，请用BaseView.ChangeNumInAnim",
    BindToTextSize = "Binder.BindToTextSize已经被禁用，请用BaseView.SetTextSize结合事件来使用",
    BindToTextColor = "Binder.BindToTextColor已经被禁用，请用BaseView.SetTextColorType结合事件来使用",
    BindToTextColorCode = "Binder.BindToTextColorCode已经被禁用，请用BaseView.SetTextColorType结合事件来使用",
    PlayAnimator = "Binder.PlayAnimator已经被禁用，请用BaseView.PlayAnimator",
    BindToAnimator = "Binder.BindToAnimator已经被禁用，请用BaseView.PlayAnimator等，自己实现控制逻辑",
    SetIcon = "Binder.SetIcon已经被禁用，请用BaseView.SetIcon",
    ClearIcon = "Binder.ClearIcon已经被禁用，请用BaseView.ClearIcon",
    PlayEffect = "Binder.PlayEffect已经被禁用，请用BaseView.PlayEffect",
    StopEffect = "Binder.StopEffect已经被禁用，请用BaseView.StopEffect",
    SetImage = "Binder.SetImage已经被禁用，请用BaseView.SetImage",
    SetImageSync = "Binder.SetImageSync已经被禁用，请用BaseView.SetImageSync",
    ClearImage = "Binder.ClearImage已经被禁用，请用BaseView.ClearImage",
    BindToImage = "Binder.BindToImage已经被禁用，请用BaseView.SetImage结合事件来使用",
    BindToImageSync = "Binder.BindToImageSync已经被禁用，请用BaseView.SetImageSync结合事件来使用",
    LoadAsset = "Binder.LoadAsset已经被禁用，请用BaseView.LoadAsset",
    LoadAssetAsync = "Binder.LoadAssetAsync已经被禁用，请用BaseView.LoadAssetAsync",
    Instantiate = "Binder.Instantiate已经被禁用，请用BaseView.Instantiate",
    BindToImageColor = "Binder.BindToImageColor已经被禁用，请用BaseView.SetImageColor",
    SetImageColor = "Binder.SetImageColor已经被禁用，请用BaseView.SetImageColorRGBA",
    SetImageAlpha = "Binder.SetImageAlpha已经被禁用，请用BaseView.SetImageAlpha",
    BindToImageFillAmount = "Binder.BindToImageFillAmount已经被禁用，请用BaseView.SetImageFillAmount",
    SetImageFillAmount = "Binder.SetImageFillAmount已经被禁用，请用BaseView.SetImageFillAmount",
    SetImageColorByHtml = "Binder.SetImageColorByHtml已经被禁用，请用BaseView.SetImageColorByHtml",
    BindToCanvasGroup = "Binder.BindToCanvasGroup已经被禁用，请用BaseView.SetCanvasGroup",
    SetCanvasGroup = "Binder.SetCanvasGroup已经被禁用，请用BaseView.SetCanvasGroup",
    GetOrAddCanvasGroup = "Binder.GetOrAddCanvasGroup已经被禁用，请用BaseView.AddCanvasGroupOnce",
    DotweenProcessAlpha = "Binder.DotweenProcessAlpha已经被禁用，请用BaseView.DotweenProcessAlpha",
    SetCanvasGroupBlocksRaycasts = "Binder.SetCanvasGroupBlocksRaycasts已经被禁用，请用BaseView.SetCanvasGroupBlocksRaycasts",
    BindToVisibleByCanvasGroup = "Binder.BindToVisibleByCanvasGroup已经被禁用，请用BaseView.SetCanvasGroupVisible",
    BindButtonClick = "Binder.BindButtonClick已经被禁用，请用BaseView.AddButtonClickListener,BaseView.SetButtonState" .. ",BaseView.SetButtonChosen,BaseView.DisableButtonAudioEffect,BaseView.SetButtonText,BaseView.SetButtonRedPoint",
    BindZ1Button = "Binder.BindZ1Button已经被禁用，请用BaseView.AddButtonClickListener,BaseView.SetButtonState" .. ",BaseView.SetButtonChosen,BaseView.DisableButtonAudioEffect,BaseView.SetButtonText,BaseView.SetButtonRedPoint",
    BindEffectToButton = "Binder.BindEffectToButton已经被禁用，请用BaseView.ApplyEffectToButton",
    BindPressDown = "Binder.BindPressDown已经被禁用，请用BaseView.AddPressDownListener",
    BindLongPressButton = "Binder.BindLongPressButton已经被禁用，请用BaseView.AddLongPressButtonListener和BaseView.AddShortPressButtonListener",
    CancelRepeatButtonPress = "Binder.CancelRepeatButtonPress已经被禁用，请用BaseView.DisableRepeatButtonPress",
    BindPressUp = "Binder.BindPressUp已经被禁用，请用BaseView.AddPressUpListener",
    BindUICustomInput = "Binder.BindUICustomInput已经被禁用，请用BaseView.AddUICustomInputlistener",
    BindOnBeginDrag = "Binder.BindOnBeginDrag已经被禁用，请用BaseView.AddOnBeginDragListener",
    BindToButtonGray = "Binder.BindToButtonGray已经被禁用，请用BaseView.SetButtonGray",
    SetButtonInteractable = "Binder.SetButtonInteractable已经被禁用，请用BaseView.SetButtonInteractable",
    BindTimer = "Binder.BindTimer已经被禁用，请用BaseView.BindTimer",
    StopTimer = "Binder.BStopTimer已经被禁用，请用BaseView.StopTimer",
    BindToCircularListView = "Binder.BindToCircularListView已经被禁用，请用BaseView.CreateTableview的相关操作",
    CircularScrollTo = "Binder.CircularScrollTo已经被禁用，请用BaseView.CreateTableview",
    CircularRemoveItemWithAnim = "Binder.CircularRemoveItemWithAnim已经被禁用，请用BaseView.CreateTableview的相关操作",
    PlayCircularScrollViewFadeInAnim = "Binder.PlayCircularScrollViewFadeInAnim已经被禁用，请用BaseView.PlayTableViewFadeInAnim的相关操作",
    ListViewJumpToIndex = "Binder.ListViewJumpToIndex已经被禁用，请用BaseView.CreateTableview的相关操作",
    BindNormalListView = "Binder.BindNormalListView已经被禁用，请用BaseView.CreateTableview的相关操作",
    BindExpandListView = "Binder.BindExpandListView已经被禁用，请用BaseView.CreateTableview的相关操作",
    BindPageListView = "Binder.BindPageListView已经被禁用，请用BaseView.CreateTableview的相关操作",
    BindCenterListView = "Binder.BindCenterListView已经被禁用，请用BaseView.CreateTableview的相关操作",
    CenterListScrollTo = "Binder.CenterListScrollTo已经被禁用，请用BaseView.CreateTableview的相关操作",
    GetInputFieldComp = "Binder.GetInputFieldComp已经被禁用，请用BaseView.GetInputFieldComp的相关操作",
    GetInputText = "Binder.GetInputText已经被禁用，请用BaseView.GetInputText的相关操作",
    BindToInputText = "Binder.BindToInputText已经被禁用，请用BaseView.SetInputText的相关操作",
    SetInputTextCharLimite = "Binder.SetInputTextCharLimite已经被禁用，请用BaseView.SetInputTextCharLimit",
    SetInputText = "Binder.SetInputText已经被禁用，请用BaseView.SetInputText的相关操作",
    BindToInputValueChange = "Binder.BindToInputValueChange已经被禁用，请用BaseView.AddInputValueChangeListener",
    BindToInputEndEdit = "Binder.BindToInputEndEdit已经被禁用，请用BaseView.AddInputEndEditListener",
    BindToToggleIsOn = "Binder.BindToToggleIsOn已经被禁用，请用BaseView.SetToggleIsOn",
    BindToToggleValueChange = "Binder.BindToToggleValueChange已经被禁用，请用BaseView.AddToggleValueChangeListener",
    SetToggle = "Binder.SetToggle已经被禁用，请用BaseView.SetToggle",
    SetToggleInteractable = "Binder.SetToggleInteractable已经被禁用，请用BaseView.SetToggleInteractable",
    SetZ1Toggle = "Binder.SetZ1Toggle已经被禁用，请用BaseView.SetZ1Toggle",
    BindToZ1Toggle = "Binder.BindToZ1Toggle已经被禁用，请用BaseView.AddZ1ToggleValueChangedListener"
  }
end
local BaseView, Super = NewClass("BaseView", UIBasePanel)

function BaseView:ctor()
  Super.ctor(self)
  self.instantiateGos = nil
  self.timerIds = nil
  self.effMgr = UIViewEffectMgr()
  self.imagesLoader = UIViewImagesLoader()
  self.notificationsMgr = UIViewNotificationsMgr(self)
  self.clickButtons = nil
  self.audioMuteButtons = nil
  self.pressedDownListeners = nil
end

function BaseView:RegisterNotifications()
end

function BaseView:RegisterEvents()
end

function BaseView:OnBuildView()
end

function BaseView:OnBind(binder)
  self.binder = binder
  Super.OnBind(self)
  self:OnBuildView()
  self:_InitChildrenTapViews()
  self:RegisterNotifications()
  self:RegisterEvents()
  self:OnEnterView()
  self:_ClearBinderIllegalFunctions()
end

function BaseView:OnAddToStage()
  Super.OnAddToStage(self)
  self:OnEnterViewFinished()
end

function BaseView:OnEnterView()
end

function BaseView:OnEnterViewFinished()
end

function BaseView:OnExitView()
  self:CloseAllChildrenPanels()
  self.notificationsMgr:Clear()
  self:_RemoveAllButtonListeners()
  self:_RemoveAllPressDownListeners()
  self:_RemoveAllPressUpListeners()
  self:_RemoveAllLongPressButtonListeners()
  self:_RemoveAllShortPressButtonListeners()
  self:_RemoveAllUICustomInputlisteners()
  self:_RemoveAllOnBeginDragListeners()
  self:_RemoveAllInputValueChangeListeners()
  self:_RemoveAllDropdownValueChangedListener()
  self:_RemoveAllSliderListeners()
  self:_RemoveAllInputEndEditListeners()
  self:_RemoveAllToggleValueChangeListeners()
  self:_RemoveAllZ1ToggleValueChangedListeners()
  self:_ResumeChildrenPermanentStatus()
  self:_ClearCommands()
  self:RemoveAllEvents()
  self:StopAllTimers()
  self:ClearTableviews()
  if self.effMgr then
    self.effMgr:ClearAll()
    self.effMgr = nil
  end
  if self.imagesLoader then
    self.imagesLoader:ClearAll()
    self.imagesLoader = nil
  end
  if self.iconMgr then
    self.iconMgr:ClearAll()
    self.iconMgr = nil
  end
  DOTweenUtils.KillAllTweensByTarget(self)
  ResLoadMgr.UnloadAssetByTarget(self)
  if self.instantiateGos then
    for i = 1, #self.instantiateGos do
      Destroy(self.instantiateGos[i])
    end
    self.instantiateGos = nil
  end
end

function BaseView:DestroyUI()
  EventMgr.Instance.BeforeClosePanelEvent:Dispatch(self.url)
  self:_ResumeAllCanvasGroupInteractable()
  self._canvasGroupCfg = nil
  
  local function destroyFunc()
    if not self.ui then
      return
    end
    self:OnExitView()
    if self.viewCompsMgr then
      self.viewCompsMgr:Dispose()
      self.viewCompsMgr = nil
    end
    self:_ResumeAllCanvasGroupInteractable()
    self.binder:teardown()
    DOTweenUtils.KillAllTweensByTarget(self)
    local uiExport = self.ui.uiNode:GetComponent(typeof(CS.FrameWork.UIExport))
    if not Main.isAppDestroyed then
      pcall(uiExport.ResetObjActive, uiExport)
      local panel = UIAsyncLoadMgr.Instance:GetPanel(self.url)
      if not panel then
        PoolManager.Instance:FreeUI(self.ui)
      else
        panel:Close()
      end
    end
    self.ui = nil
    self.root = nil
    self.animator = nil
    local onDestroyCallback = self.onDestroyCallback
    self.onDestroyCallback = nil
    if onDestroyCallback then
      onDestroyCallback()
    end
  end
  
  if not self.closeWithoutAnim then
    self:PlayUIAnim(destroyFunc, false)
  else
    destroyFunc()
  end
  UIBackCommandStack.Remove(self)
  EventMgr.Instance.ClosePanelEvent:Dispatch(self.url)
end

function BaseView:_SetupBinderIllegalFunctions()
  if not IsEditor or not self.binder then
    return
  end
  local metaTable = getmetatable(self.binder)
  local o_index = metaTable.__index
  
  function metaTable.__index(t, k)
    local illegalMsg = rawget(IllegalFunctionsInBinder, k)
    if illegalMsg then
      Logger.Warn(illegalMsg)
    end
    if o_index then
      if type(o_index) == "function" then
        do return o_index, t end
        return o_index, t, k
      end
      return o_index[k]
    end
  end
  
  self.originIdxMetaTable = o_index
end

function BaseView:_ClearBinderIllegalFunctions()
  if not IsEditor or not self.binder then
    return
  end
  if self.originIdxMetaTable then
    local metaTable = getmetatable(self.binder)
    metaTable.__index = self.originIdxMetaTable
    self.originIdxMetaTable = nil
  end
end

function BaseView:RegisterNotify(name, handler, handlerObj, priority)
  self.notificationsMgr:RegisterNotify(name, handler, handlerObj, priority)
end

function BaseView:UnregisterNotify(name, handler, handlerObj)
  self.notificationsMgr:UnregisterNotify(name, handler, handlerObj)
end

function BaseView:Notify(name, ...)
  self.notificationsMgr:Notify(name, ...)
end

function BaseView:RegisterLocalNotify(name, handler, handlerObj, priority)
  self.notificationsMgr:RegisterLocalNotify(name, handler, handlerObj, priority)
end

function BaseView:UnregisterLocalNotify(name, handler, handlerObj)
  self.notificationsMgr:UnregisterLocalNotify(name, handler, handlerObj)
end

function BaseView:LocalNotify(name, ...)
  self.notificationsMgr:LocalNotify(name, ...)
end

function BaseView:BindEvent(event, callback)
  if not self.evengsMgr then
    self.evengsMgr = UIViewEventsMgr()
  end
  self.evengsMgr:BindEvent(event, callback)
end

function BaseView:BindEventOnce(event, callback)
  if not self.evengsMgr then
    self.evengsMgr = UIViewEventsMgr()
  end
  self.evengsMgr:BindEventOnce(event, callback)
end

function BaseView:RemoveEvent(event, callback)
  if self.evengsMgr then
    self.evengsMgr:RemoveEvent(event, callback)
  end
end

function BaseView:RemoveAllEvents()
  if self.evengsMgr then
    self.evengsMgr:RemoveAllEvents()
  end
end

function BaseView:BindTimer(duration, repeatTimes, repeatCallback, finishCallback)
  local timerId
  timerId = _CreateTimer(_TimerManager, duration, repeatTimes, repeatCallback, function()
    if timerId then
      self:StopTimer(timerId)
      timerId = nil
    end
    if finishCallback then
      finishCallback()
    end
  end)
  if timerId then
    self.timerIds = self.timerIds or {}
    self.timerIds[timerId] = true
  end
  return timerId
end

function BaseView:StopTimer(timerId)
  if timerId and self.timerIds and self.timerIds[timerId] then
    self.timerIds[timerId] = nil
    _StopTimer(_TimerManager, timerId)
  end
end

function BaseView:StopAllTimers()
  if self.timerIds then
    for timerId, _ in pairs(self.timerIds) do
      _StopTimer(_TimerManager, timerId)
    end
  end
  self.timerIds = nil
end

function BaseView:SetText(owner, value, isUseBigFont, linkCallBack, extraParam)
  if self.binder then
    self.binder:SetText(owner, value, isUseBigFont, linkCallBack, extraParam)
  end
end

function BaseView:SetRawText(owner, value)
  if self.binder then
    self.binder:SetRawText(owner, value)
  end
end

function BaseView:GetTextComp(owner)
  if self.binder then
    do return self.binder.GetTextComp, self.binder end
    return self.binder.GetTextComp, self.binder, owner
  end
end

function BaseView:GetColorStr(wordEffectKey)
  if self.binder then
    do return self.binder.GetColorStr, self.binder end
    return self.binder.GetColorStr, self.binder, wordEffectKey
  end
end

function BaseView:GetColorText(text, wordEffectKey)
  if self.binder then
    do return self.binder.GetColorText, self.binder, text end
    return self.binder.GetColorText, self.binder, text, wordEffectKey
  end
end

function BaseView:SetTextColor(owner, x, y, z, w)
  if self.binder then
    self.binder:SetTextColor(owner, x, y, z, w)
  end
end

function BaseView:SetTextColorByHtml(owner, colorStr)
  if self.binder then
    self.binder:SetTextColorByHtml(owner, colorStr)
  end
end

function BaseView:ChangeNumInAnim(owner, oldNum, targetNum)
  if not (owner and oldNum) or not targetNum then
    Logger.Info("<BaseView.ChangeNumInAnim> error params:", owner, oldNum, targetNum)
    return
  end
  local time = 0.5
  local interval = time / math.abs(targetNum - oldNum)
  local currNum = oldNum
  local isAdd = targetNum - currNum > 0
  local delta = isAdd and 1 or -1
  delta = math.floor(delta * (math.abs(targetNum - currNum) / 50))
  if 0 == delta % 10 then
    delta = isAdd and delta + 1 or delta - 1
  end
  local timerId
  timerId = self:BindTimer(interval, -1, function()
    if timerId and currNum == targetNum then
      self:StopTimer(timerId)
      return
    end
    currNum = currNum + delta
    if delta > 0 and currNum > targetNum then
      currNum = targetNum
    elseif delta < 0 and currNum < targetNum then
      currNum = targetNum
    end
    self:SetText(owner, currNum)
  end)
end

function BaseView:SetTextSize(owner, fontSize)
  if not self.binder then
    return
  end
  self.binder:SetTextSize(owner, fontSize)
end

function BaseView:SetTextColorType(owner, colorType)
  if not self.binder then
    return
  end
  self.binder:SetTextColorType(owner, colorType)
end

function BaseView:SetTextColorCode(owner, colorHexCode)
  if not (owner and colorHexCode) or "" == colorHexCode then
    return
  end
  local textComp = self:GetTextComp(owner)
  if not textComp then
    return
  end
  local alpha = textComp.color.a
  local color = ColorUtils.ParseHtmlStringToUnityColor(colorHexCode, alpha)
  if not color then
    return
  end
  textComp.color = color
end

function BaseView:SetImageColor(owner, color)
  if not color then
    return
  end
  local image = owner:GetComponent(T_Image)
  if not image then
    Logger.Error("BaseView.SetImageColor中owner参数无效，缺少Image组件")
    return
  end
  if type(color) == "string" then
    local c = ColorUtils.ParseHtmlStringToUnityColor(color, image.color.a)
    image.color = c
  else
    image.color = color
  end
end

function BaseView:SetImageColorRGBA(owner, x, y, z, w)
  local image = owner:GetComponent(T_Image)
  if not image then
    Logger.Error("BaseView.SetImageColorRGBA中owner参数无效，缺少Image组件")
    return
  end
  image.color = Color(x, y, z, w)
end

function BaseView:SetImageAlpha(owner, a)
  local image = owner:GetComponent(T_Image)
  if not image then
    Logger.Error("BaseView.SetImageAlpha中owner参数无效，缺少Image组件")
    return
  end
  local color = image.color
  color.a = a
  image.color = color
end

function BaseView:SetImageFillAmount(owner, fillAmount)
  local image = owner:GetComponent(T_Image)
  if not image then
    Logger.Error("BaseView.SetImageFillAmount中owner参数无效，缺少Image组件")
    return
  end
  image.fillAmount = fillAmount
end

function BaseView:SetCanvasGroup(owner, alpha)
  local canvasGroup = owner:GetComponent(T_CanvasGroup)
  if not canvasGroup then
    Logger.Error("BaseView.SetCanvasGroup中owner参数无效，缺少CanvasGroup组件")
    return
  end
  canvasGroup.alpha = alpha
end

function BaseView:GetCanvasGroupValue(owner)
  local canvasGroup = owner:GetComponent(T_CanvasGroup)
  if canvasGroup then
    return canvasGroup.alpha
  end
  return 1
end

function BaseView:AddCanvasGroupOnce(owner)
  do return self.AddComponentOnce, self, owner end
  return self.AddComponentOnce, self, owner, T_CanvasGroup
end

function BaseView:DotweenProcessAlpha(owner, alpha, time)
  local canvasGroup = self:AddCanvasGroupOnce(owner)
  local tween = self:DotweenTo(function()
    return canvasGroup.alpha
  end, function(v)
    canvasGroup.alpha = v
  end, alpha, time)
  return tween
end

function BaseView:SetCanvasGroupBlocksRaycasts(owner, blocksRaycasts)
  local canvasGroup = owner:GetComponent(T_CanvasGroup)
  if not canvasGroup then
    Logger.Error("BaseView.SetCanvasGroupBlocksRaycasts中owner参数无效，缺少CanvasGroup组件")
    return
  end
  canvasGroup.blocksRaycasts = blocksRaycasts
end

function BaseView:SetCanvasGroupVisible(owner, visible)
  local canvasGroup = owner:GetComponent(T_CanvasGroup)
  if not canvasGroup then
    Logger.Error("BaseView.SetCanvasGroupVisible中owner参数无效，缺少CanvasGroup组件")
    return
  end
  canvasGroup.alpha = visible and 1 or 0
end

function BaseView:DotweenTo(getter, setter, endValue, duration)
  local tween = DOTween.To(getter, function(v)
    if self.ui then
      setter(v)
    end
  end, endValue, duration, self)
  return tween
end

function BaseView:AddComponentOnce(owner, compType)
  do return _AddComponentOnce, owner end
  return _AddComponentOnce, owner, compType
end

function BaseView:LoadAsset(path, assetType)
  do return ResLoadMgr.LoadAsset, path, self end
  return ResLoadMgr.LoadAsset, path, self, assetType
end

function Binder:LoadAssetAsync(path, callback)
  do return ResLoadMgr.LoadAssetAsync, path, self end
  return ResLoadMgr.LoadAssetAsync, path, self, callback
end

function BaseView:SetImage(owner, path, nativeSize, callback)
  if self.imagesLoader then
    self.imagesLoader:SetImage(owner, path, nativeSize, callback)
  end
end

function BaseView:ClearImage(owner)
  if self.imagesLoader then
    self.imagesLoader:ClearImage(owner)
  end
end

function BaseView:SetImageSync(owner, path, nativeSize)
  if path then
    if IsResourceLoading then
      local ret, result = pcall(IsResourceLoading, path)
      if ret and result then
        self:SetImage(owner, path, nativeSize)
        return
      end
    end
    local image = owner:GetComponent(T_Image)
    if image then
      image.sprite = self:LoadAsset(path)
      image.enabled = true
      if nativeSize then
        image:SetNativeSize()
      end
    end
  end
end

function BaseView:Instantiate(asset, parentTrans)
  local go = Instantiate(asset, parentTrans)
  if go then
    self.instantiateGos = self.instantiateGos or {}
    table.insert(self.instantiateGos, go)
  end
  return go
end

function BaseView:SetIcon(iconType, parent, itemData)
  if not self.iconMgr then
    self.iconMgr = UIViewMaterialIconMgr(self)
  end
  self.iconMgr:SetIcon(iconType, parent, itemData)
end

function BaseView:ClearIcon(parent)
  if self.iconMgr then
    self.iconMgr:ClearIcon(parent)
  end
end

function BaseView:PlayEffect(effPath, owner, offsetX, offsetY, loop)
  if self.effMgr then
    do return self.effMgr.PlayEffect, self.effMgr, effPath, owner, offsetX, offsetY end
    return self.effMgr.PlayEffect, self.effMgr, effPath, owner, offsetX, offsetY, loop
  end
end

function BaseView:StopEffect(eff)
  if self.effMgr then
    self.effMgr:StopEffect(eff)
  end
end

function BaseView:PlayAnimator(animator, name, argType, arg)
  AnimatorUtils.PlayBlendParams(animator, name, argType, arg)
  animator:Update(0)
end

function BaseView:AddButtonClickListener(owner, onClick)
  local buttonComp = self:GetButton(owner)
  if not buttonComp then
    Logger.Error("BaseView.BindButtonClick中owner参数无效，缺少Z1Button或者Button组件")
    return
  end
  buttonComp.onClick:RemoveAllListeners()
  buttonComp.onClick:AddListener(self:_ButtonClickFuncButton(buttonComp, onClick))
  self.clickButtons = self.clickButtons or {}
  self.clickButtons[buttonComp] = true
end

function BaseView:_ButtonClickFuncButton(buttonComp, onClick)
  return function()
    if 0 == self:GetCanvasGroupValue(buttonComp.gameObject) then
      return
    end
    if _GetRealtimeSinceStartup() - DataCenter.gameData.ButtonClickTime < 0.1 then
      return
    end
    EventMgr.Instance.ClickButtonEffect:Dispatch(buttonComp.gameObject)
    if onClick then
      onClick()
      DataCenter.gameData.ButtonClickTime = _GetRealtimeSinceStartup()
    end
    local playAudioEffectFunc = self:GetButtonAudioEffectFunc(buttonComp.gameObject)
    if not playAudioEffectFunc then
      return
    end
    local btnState = buttonComp.BtnState or Z1ButtonState.Default
    playAudioEffectFunc(btnState)
  end
end

function BaseView:RemoveButtonClickListener(owner)
  local buttonComp = self:GetButton(owner)
  if not buttonComp then
    Logger.Error("BaseView.RemoveButtonClickListener中owner参数无效，缺少Z1Button或者Button组件")
    return
  end
  buttonComp.onClick:RemoveAllListeners()
  if self.clickButtons then
    self.clickButtons[buttonComp] = nil
  end
end

function BaseView:SetButtonText(owner, txt)
  local buttonComp = self:GetButton(owner)
  if not buttonComp then
    Logger.Error("BaseView.SetButtonClickState中owner参数无效，缺少Z1Button或者Button组件")
    return
  end
  if buttonComp.buttonTextComp then
    local str = StrUtils.SafeSetWordEffectStr(txt)
    str = LT.ReplaceUnicodeSpace(str)
    buttonComp.buttonTextComp.text = str
  end
end

function BaseView:SetButtonRedPoint(owner, redPointFunc)
  local buttonComp = self:GetButton(owner)
  if not buttonComp then
    Logger.Error("BaseView.SetButtonRedPoint中owner参数无效，缺少Z1Button或者Button组件")
    return
  end
  if redPointFunc and buttonComp.RedDotObj then
    self:AddViewComponentOnce(buttonComp.RedDotObj, UICompRedDot, nil, nil, redPointFunc)
  end
end

function BaseView:SetButtonState(owner, btnState)
  local buttonComp = self:GetButton(owner)
  if not buttonComp then
    Logger.Error("BaseView.SetButtonClickState中owner参数无效，缺少Z1Button或者Button组件")
    return
  end
  if buttonComp.BtnType == Z1ButtonType.CommonButton then
    buttonComp.BtnState = btnState
  end
end

function BaseView:SetButtonChosen(owner, isChosen)
  local buttonComp = self:GetButton(owner)
  if not buttonComp then
    Logger.Error("BaseView.SetButtonClickState中owner参数无效，缺少Z1Button或者Button组件")
    return
  end
  if buttonComp.BtnType == Z1ButtonType.SingleChooseButton then
    buttonComp.IsChosen = isChosen
  end
end

function BaseView:DisableButtonAudioEffect(owner, disable)
  self.audioMuteButtons = self.audioMuteButtons or {}
  self.audioMuteButtons[owner] = disable
  local audioEffectComp = owner:GetComponent(T_AudioEffect)
  if audioEffectComp then
    audioEffectComp.CanPlayAudio = not disable
  end
end

function BaseView:GetButtonAudioEffectFunc(owner)
  if self.audioMuteButtons and self.audioMuteButtons[owner] then
    return
  end
  if not UIAudioManager or not UIAudioManager.Instance then
    return
  end
  local playAudioEffectFunc = UIAudioManager.Instance:GetButtonPlayAudioEffectFunc(owner)
  if not playAudioEffectFunc then
    return
  end
  return playAudioEffectFunc
end

function BaseView:_RemoveAllButtonListeners()
  if not self.ui or IsNil(self.ui.uiNode) then
    return
  end
  if self.clickButtons then
    for k, _ in pairs(self.clickButtons) do
      if not IsNil(k) then
        k.onClick:RemoveAllListeners()
      end
    end
    self.clickButtons = nil
  end
end

function BaseView:ApplyEffectToButton(owner, isShowAppear)
  local animator = owner:GetComponent(T_Animator)
  if not animator then
    return
  end
  if isShowAppear then
    AnimatorUtils.SetTrigger(animator, CommonDefine.BtnAniTrigger.Appear)
    animator:Update(0)
  end
  self:BindEvent(EventMgr.Instance.ClickButtonEffect, function(own)
    if owner == own and not IsNil(animator) then
      AnimatorUtils.SetTrigger(animator, CommonDefine.BtnAniTrigger.Click)
      animator:Update(0)
    end
  end)
end

function BaseView:FindChildComponent(go, childName, compType)
  local trs = self:FindChild(go, childName)
  if trs then
    local comp = trs:GetComponent(compType)
    if comp then
      return comp
    end
  end
  return nil
end

function BaseView:FindChildTextComponent(go, childName)
  local trs = self:FindChild(go, childName)
  if trs then
    local comp = trs:GetComponent(T_TMP_Text)
    if comp then
      return comp
    end
    do return trs.GetComponent, trs end
    return trs.GetComponent, trs, T_Text
  end
  return nil
end

function BaseView:FindChildRecursively(root, childName)
  local child
  local transform = root.transform
  local count = transform.childCount - 1
  for i = 0, count do
    local tf = transform:GetChild(i)
    if tf and tf.gameObject.name == childName then
      child = tf
      break
    end
  end
  if not child then
    for i = 0, count do
      local tf = transform:GetChild(i)
      local childGo = self:FindChildRecursively(tf.gameObject, childName)
      if childGo then
        child = childGo.transform
        break
      end
    end
  end
  if child then
    return child.gameObject
  end
  return nil
end

function BaseView:Travel(root, func)
  if root then
    if func then
      func(root)
    end
    for i = 0, root.childCount - 1 do
      self:Travel(root:GetChild(i), func)
    end
  end
end

function BaseView:AddPressDownListener(owner, onClick)
  local repeatButtonComp = owner:GetComponent(T_RepeatButton)
  if not repeatButtonComp then
    Logger.Error("BaseView.AddPressDownListener中owner参数无效，缺少RepeatButton组件")
    return
  end
  repeatButtonComp.onClickDown:RemoveAllListeners()
  repeatButtonComp.onClickDown:AddListener(self:_PressDownFuncButton(repeatButtonComp, onClick))
  self.pressedDownListeners = self.pressedDownListeners or {}
  self.pressedDownListeners[repeatButtonComp] = true
end

function BaseView:RemovePressDownListener(owner)
  local repeatButtonComp = owner:GetComponent(T_RepeatButton)
  if not repeatButtonComp then
    Logger.Error("BaseView.RemovePressDownListener中owner参数无效，缺少RepeatButton组件")
    return
  end
  if self.pressedDownListeners then
    self.pressedDownListeners[repeatButtonComp] = nil
  end
  repeatButtonComp.onClickDown:RemoveAllListeners()
end

function BaseView:_PressDownFuncButton(repeatButtonComp, onClick)
  return function()
    if onClick then
      onClick()
    end
    local playAudioEffectFunc = self:GetButtonAudioEffectFunc(repeatButtonComp.gameObject)
    if not playAudioEffectFunc then
      return
    end
    playAudioEffectFunc(Z1ButtonState.Default)
  end
end

function BaseView:_RemoveAllPressDownListeners()
  if self.pressedDownListeners then
    for k, _ in pairs(self.pressedDownListeners) do
      k.onClickDown:RemoveAllListeners()
    end
    self.pressedDownListeners = nil
  end
end

function BaseView:AddPressUpListener(owner, onPointerUp)
  local repeatButtonComp = owner:GetComponent(T_RepeatButton)
  if not repeatButtonComp then
    Logger.Error("BaseView.AddPressUpListener中owner参数无效，缺少RepeatButton组件")
    return
  end
  repeatButtonComp.onRelease:RemoveAllListeners()
  repeatButtonComp.onRelease:AddListener(onPointerUp)
  self.pressedUpListeners = self.pressedUpListeners or {}
  self.pressedUpListeners[repeatButtonComp] = true
end

function BaseView:RemovePressUpListener(owner)
  local repeatButtonComp = owner:GetComponent(T_RepeatButton)
  if not repeatButtonComp then
    Logger.Error("BaseView.RemovePressUpListener中owner参数无效，缺少RepeatButton组件")
    return
  end
  if self.pressedUpListeners then
    self.pressedUpListeners[repeatButtonComp] = nil
  end
  repeatButtonComp.onRelease:RemoveAllListeners()
end

function BaseView:_RemoveAllPressUpListeners()
  if self.pressedUpListeners then
    for k, _ in pairs(self.pressedUpListeners) do
      k.onRelease:RemoveAllListeners()
    end
    self.pressedUpListeners = nil
  end
end

function BaseView:SetLongPressButtonIntervalTime(owner, intervalTime)
  local repeatButtonComp = owner:GetComponent(T_RepeatButton)
  if not repeatButtonComp then
    Logger.Error("BaseView.SetLongPressButtonIntervalTime中owner参数无效，缺少RepeatButton组件")
    return
  end
  repeatButtonComp.interval = intervalTime
end

function BaseView:AddLongPressButtonListener(owner, onLongPress)
  local repeatButtonComp = owner:GetComponent(T_RepeatButton)
  if not repeatButtonComp then
    Logger.Error("BaseView.AddLongPressButtonListener中owner参数无效，缺少RepeatButton组件")
    return
  end
  local triggeredTimes = 0
  local isPlayedAudio = false
  local onAction = self:_LongPressButtonFuncButton(repeatButtonComp, onLongPress, function()
    local playAudioEffectFunc = self:GetButtonAudioEffectFunc(repeatButtonComp.gameObject)
    if not playAudioEffectFunc or isPlayedAudio then
      return
    end
    isPlayedAudio = true
    playAudioEffectFunc(Z1ButtonState.Default)
  end)
  repeatButtonComp.onLongPress:RemoveAllListeners()
  repeatButtonComp.onLongPress:AddListener(function()
    triggeredTimes = triggeredTimes + 1
    onAction(triggeredTimes)
  end)
  self:BindEvent(EventMgr.Instance.TouchEndEvent, function()
    triggeredTimes = 0
    isPlayedAudio = false
  end)
end

function BaseView:RemoveLongPressButtonListener(owner)
  local repeatButtonComp = owner:GetComponent(T_RepeatButton)
  if not repeatButtonComp then
    Logger.Error("BaseView.RemoveLongPressButtonListener中owner参数无效，缺少RepeatButton组件")
    return
  end
  if self.longPressedListeners then
    self.longPressedListeners[repeatButtonComp] = nil
  end
  repeatButtonComp.onLongPress:RemoveAllListeners()
end

function BaseView:_LongPressButtonFuncButton(repeatButtonComp, onLongPress, audioCtrlFunc)
  return function(triggeredTimes)
    if onLongPress then
      onLongPress(triggeredTimes)
    end
    if audioCtrlFunc then
      audioCtrlFunc()
    end
  end
end

function BaseView:_RemoveAllLongPressButtonListeners()
  if self.longPressedListeners then
    for k, _ in pairs(self.longPressedListeners) do
      k.onLongPress:RemoveAllListeners()
    end
    self.longPressedListeners = nil
  end
end

function BaseView:AddShortPressButtonListener(owner, onClick)
  local repeatButtonComp = owner:GetComponent(T_RepeatButton)
  if not repeatButtonComp then
    Logger.Error("BaseView.AddShortPressButtonListener中owner参数无效，缺少RepeatButton组件")
    return
  end
  repeatButtonComp.onShortPress:RemoveAllListeners()
  repeatButtonComp.onShortPress:AddListener(self:_ShortPressFuncButton(repeatButtonComp, onClick))
  self.shortPressedListeners = self.shortPressedListeners or {}
  self.shortPressedListeners[repeatButtonComp] = true
end

function BaseView:_ShortPressFuncButton(repeatButtonComp, onClick)
  return function()
    if _GetRealtimeSinceStartup() - DataCenter.gameData.ButtonClickTime < 0.1 then
      return
    end
    if onClick then
      onClick()
      DataCenter.gameData.ButtonClickTime = _GetRealtimeSinceStartup()
    end
    local playAudioEffectFunc = self:GetButtonAudioEffectFunc(repeatButtonComp.gameObject)
    if not playAudioEffectFunc then
      return
    end
    playAudioEffectFunc(Z1ButtonState.Default)
  end
end

function BaseView:RemoveShortPressButtonListener(owner)
  local repeatButtonComp = owner:GetComponent(T_RepeatButton)
  if not repeatButtonComp then
    Logger.Error("BaseView.RemoveShortPressButtonListener中owner参数无效，缺少RepeatButton组件")
    return
  end
  repeatButtonComp.onShortPress:RemoveAllListeners()
  if self.shortPressedListeners then
    self.shortPressedListeners[repeatButtonComp] = nil
  end
end

function BaseView:_RemoveAllShortPressButtonListeners()
  if self.shortPressedListeners then
    for k, _ in pairs(self.shortPressedListeners) do
      k.onShortPress:RemoveAllListeners()
    end
    self.shortPressedListeners = nil
  end
end

function BaseView:DisableRepeatButtonPress(owner)
  local repeatButtonComp = owner:GetComponent(T_RepeatButton)
  if not repeatButtonComp then
    Logger.Error("BaseView.DisableRepeatButtonPress中owner参数无效，缺少RepeatButton组件")
    return
  end
  if repeatButtonComp.isPointerDown == nil then
    owner:SetActive(false)
    owner:SetActive(true)
    return
  end
  repeatButtonComp.isPointerDown = false
end

function BaseView:AddOnBeginDragListener(owner, onBegion)
  local repeatButtonComp = owner:GetComponent(T_RepeatButton)
  if not repeatButtonComp then
    Logger.Error("BaseView.AddOnBeginDragListener中owner参数无效，缺少RepeatButton组件")
    return
  end
  repeatButtonComp.onBeginDrag:RemoveAllListeners()
  repeatButtonComp.onBeginDrag:AddListener(onBegion)
  self.beginDragListeners = self.beginDragListeners or {}
  self.beginDragListeners[repeatButtonComp] = true
end

function BaseView:RemoveOnBeginDragListener(owner)
  local repeatButtonComp = owner:GetComponent(T_RepeatButton)
  if not repeatButtonComp then
    Logger.Error("BaseView.RemoveOnBeginDragListener中owner参数无效，缺少RepeatButton组件")
    return
  end
  repeatButtonComp.onBeginDrag:RemoveAllListeners()
  if self.beginDragListeners then
    self.beginDragListeners[repeatButtonComp] = nil
  end
end

function BaseView:_RemoveAllOnBeginDragListeners()
  if self.beginDragListeners then
    for k, _ in pairs(self.beginDragListeners) do
      k.onBeginDrag:RemoveAllListeners()
    end
    self.beginDragListeners = nil
  end
end

function BaseView:SetButtonGray(owner, isGray, isClickable)
  local gray = ColorUtils.ParseHtmlStringToUnityColor(CommonDefine.TextColorDefine.Gray)
  local normal = ColorUtils.ParseHtmlStringToUnityColor(CommonDefine.TextColorDefine.White)
  local imageObj = owner:GetComponent(T_Image)
  if imageObj then
    imageObj.color = isGray and gray or normal
  end
  if nil == isClickable then
    isClickable = true
  end
  local btnObj = self:GetButton(owner)
  if btnObj then
    btnObj.interactable = isClickable
  end
end

function BaseView:SetButtonInteractable(owner, isClickable, resetCd)
  local btnObj = self:GetButton(owner)
  if btnObj then
    btnObj.interactable = isClickable
    if resetCd then
      self._btnInteraTimer = self._btnInteraTimer or {}
      self:StopTimer(self._btnInteraTimer[owner])
      self._btnInteraTimer[owner] = self:BindTimer(resetCd, 0, nil, function()
        if not IsNil(btnObj) then
          btnObj.interactable = not isClickable
        end
      end)
    end
  end
end

function BaseView:AddUICustomInputlistener(owner, onClick)
  if not onClick then
    return
  end
  local cusInput = UICustomInput.Get(owner)
  cusInput.onAction = onClick
  self.customInputListeners = self.customInputListeners or {}
  self.customInputListeners[cusInput] = true
end

function BaseView:RemoveUICustomInputlistener(owner)
  local cusInput = UICustomInput.Get(owner)
  cusInput.onAction = nil
  if self.customInputListeners then
    self.customInputListeners[cusInput] = nil
  end
end

function BaseView:_RemoveAllUICustomInputlisteners(owner)
  if self.customInputListeners then
    for k, _ in pairs(self.customInputListeners) do
      k.onAction = nil
    end
    self.customInputListeners = nil
  end
end

function BaseView:CreateTableview(owner, numberCellsInTableview, tableCellAtIndex, tableCellSizeForIndex, cleaner)
  local scrollRect = owner:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
  if scrollRect then
    scrollRect.scrollSensitivity = cd.ScrollSensitivity
  end
  local tableview = owner:GetComponent(T_UITableview)
  local methodCache = {
    AddChild = function(_, targetGo, ...)
      local cell = tableview:AddChild(targetGo, ...)
      if targetGo and not IsNil(targetGo) then
        targetGo:SetActive(false)
      end
      return cell
    end
  }
  local viewProxy = setmetatable({}, {
    __index = function(_, key)
      local cached = methodCache[key]
      if cached then
        return cached
      end
      local member = tableview[key]
      if type(member) == "function" then
        local function wrapper(_, ...)
          do return member, tableview, ... end
          
          return member, tableview, ...
        end
        
        methodCache[key] = wrapper
        return wrapper
      end
      return member
    end
  })
  
  function tableview.numberCellsInTableview(tlv)
    local num = numberCellsInTableview(tlv)
    if num < 0 then
      num = 0
    end
    return num
  end
  
  function tableview.tableCellAtIndex(_, idx)
    do return tableCellAtIndex, viewProxy end
    return tableCellAtIndex, viewProxy, idx + 1
  end
  
  if tableCellSizeForIndex then
    function tableview.tableCellSizeForIndex(_, idx)
      local w, h = tableCellSizeForIndex(viewProxy, idx + 1)
      
      tableCellSize.x = w
      tableCellSize.y = h
      return tableCellSize
    end
  elseif not tableview.tableCellSizeForIndex and tableview.gridWidth then
    local gridW = tableview.gridWidth
    local gridH = tableview.gridHeight
    
    function tableview.tableCellSizeForIndex()
      tableCellSize.x = gridW
      tableCellSize.y = gridH
      return tableCellSize
    end
  end
  assert(tableview.tableCellSizeForIndex, "tableview.tableCellSizeForIndex is nil!!!  " .. owner.name)
  self.tableviews = self.tableviews or {}
  self.tableviews[tableview] = {cleaner = cleaner}
  return tableview
end

function BaseView:DequeueCell(view, prefab)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(prefab)
  return cell
end

function BaseView:DequeueCellByTag(view, tag, prefab)
  local cell = view:DequeueCellByTag(tag)
  cell = cell or view:AddChild(prefab)
  cell.tag = tag
  return cell
end

function BaseView:ClearTableviews()
  if self.tableviews then
    for k, v in pairs(self.tableviews) do
      if not IsNil(k) then
        if v.cleaner then
          k:Travel(v.cleaner)
        end
        k:UnregisterAllCallbacks()
      end
    end
    self.tableviews = nil
  end
end

function BaseView:PlayTableViewFadeInAnim(listGo)
  Binder.PlayTableViewFadeInAnim(self, listGo)
end

function BaseView:AddDropdownListener(owner, dataList, onValueChanged, hideArrowRotation, showArrowRotation)
  local dropdown = owner:GetComponent(T_TMP_Dropdown)
  if not dropdown then
    Logger.Error("BaseView.AddDropdownListener中owner参数无效，缺少TMP_Dropdown组件")
    return
  end
  local optionDataList = {}
  for _, data in ipairs(dataList) do
    local optionData
    if data.text and data.imageSprite then
      optionData = TMPDropdownOption(data.text, data.imageSprite)
    else
      local ctorParam = data.text or data.imageSprite
      optionData = TMPDropdownOption(ctorParam)
    end
    if optionData then
      table.insert(optionDataList, optionData)
    end
  end
  dropdown.onValueChanged:RemoveAllListeners()
  dropdown:ClearOptions()
  dropdown:AddOptions(optionDataList)
  dropdown.onValueChanged:AddListener(function(index)
    if onValueChanged then
      onValueChanged(index + 1)
    end
  end)
  if hideArrowRotation and showArrowRotation then
    local arrowObj = _FindChild(owner, "Arrow")
    local arrowTf = arrowObj.transform
    local eulerX, eulerY = _GetLocalEulerAngles(arrowTf)
    
    local function _DropdownCustomInput(hover)
      local rotation = hideArrowRotation
      if hover then
        if dropdown.IsExpanded then
          rotation = hideArrowRotation
        else
          rotation = showArrowRotation
        end
      end
      _SetLocalEulerAngles(arrowTf, eulerX, eulerY, rotation)
    end
    
    _SetLocalEulerAngles(arrowTf, eulerX, eulerY, hideArrowRotation)
    self:AddUICustomInputlistener(owner, _DropdownCustomInput)
  end
  self._dropdownValueChangedListeners = self._dropdownValueChangedListeners or {}
  self._dropdownValueChangedListeners[dropdown] = true
end

function BaseView:RemoveDropdownValueChangedListener(owner)
  local dropdown = owner:GetComponent(T_TMP_Dropdown)
  if not dropdown then
    Logger.Error("BaseView.RemoveDropdownValueChangedListener中owner参数无效，缺少TMP_Dropdown组件")
    return
  end
  dropdown.onValueChanged:RemoveAllListeners()
  if self._dropdownValueChangedListeners then
    self._dropdownValueChangedListeners[dropdown] = nil
  end
end

function BaseView:_RemoveAllDropdownValueChangedListener()
  if self._dropdownValueChangedListeners then
    for k, _ in pairs(self._dropdownValueChangedListeners) do
      if not IsNil(k) then
        k.onValueChanged:RemoveAllListeners()
      end
    end
    self._dropdownValueChangedListeners = nil
  end
end

function BaseView:SetDropdownValue(owner, index)
  local dropdown = owner:GetComponent(T_TMP_Dropdown)
  if not dropdown then
    Logger.Error("BaseView.SetDropdownValue中owner参数无效，缺少TMP_Dropdown组件")
    return
  end
  if not index or type(index) ~= "number" then
    Logger.Error("BaseView.SetDropdownValue中index参数无效，类型错误")
    return
  end
  index = index - 1
  if index < 0 or index >= dropdown.options.Count then
    Logger.Error("BaseView.SetDropdownValue中index参数无效，index out of range")
    return
  end
  dropdown.value = index
end

function BaseView:GetDropdownValue(owner)
  local dropdown = owner:GetComponent(T_TMP_Dropdown)
  if not dropdown then
    Logger.Error("BaseView.SetDropdownValue中owner参数无效，缺少TMP_Dropdown组件")
    return
  end
  return dropdown.value
end

function BaseView:AddSliderListener(owner, onValueChanged)
  local slider = owner:GetComponent(T_Slider)
  if not slider then
    Logger.Error("BaseView.AddSliderListener中owner参数无效，缺少Slider组件")
    return
  end
  slider.onValueChanged:RemoveAllListeners()
  slider.onValueChanged:AddListener(onValueChanged)
  self._sliderValueChangedListeners = self._sliderValueChangedListeners or {}
  self._sliderValueChangedListeners[slider] = true
end

function BaseView:RemoveSliderListener(owner)
  local slider = owner:GetComponent(T_Slider)
  if not slider then
    Logger.Error("BaseView.RemoveSliderListener中owner参数无效，缺少Slider组件")
    return
  end
  slider.onValueChanged:RemoveAllListeners()
  if self._sliderValueChangedListeners[slider] then
    self._sliderValueChangedListeners[slider] = nil
  end
end

function BaseView:SetSliderValue(owner, value)
  local slider = owner:GetComponent(T_Slider)
  if not slider then
    Logger.Error("BaseView.SetSliderValue中owner参数无效，缺少Slider组件")
    return
  end
  if type(value) ~= "number" then
    Logger.Error("BaseView.SetSliderValue中index参数无效，类型错误")
    return
  end
  slider.value = value
end

function BaseView:GetSliderValue(owner)
  local slider = owner:GetComponent(T_Slider)
  if not slider then
    Logger.Error("BaseView.SetSliderValue中owner参数无效，缺少Slider组件")
    return
  end
  return slider.value
end

function BaseView:_RemoveAllSliderListeners()
  if self._sliderValueChangedListeners then
    for k, _ in pairs(self._sliderValueChangedListeners) do
      if not IsNil(k) then
        k.onValueChanged:RemoveAllListeners()
      end
      self._sliderValueChangedListeners[k] = nil
    end
  end
end

function BaseView:PushCommand(handler, handlerObj, repeatable, ...)
  local entry = CommandBufferMgr.Instance:PushCommand(handler, handlerObj, repeatable, ...)
  self.cacheCommands = self.cacheCommands or {}
  table.insert(self.cacheCommands, entry)
  return entry
end

function BaseView:ExecuteCommandBuffer()
  if self.cacheCommands then
    for i = 1, #self.cacheCommands do
      CommandBufferMgr.Instance:ExecuteCommand(self.cacheCommands[i])
    end
    self.cacheCommands = nil
  end
end

function BaseView:_ClearCommands()
  if self.cacheCommands then
    for i = 1, #self.cacheCommands do
      self.cacheCommands[i].isValid = false
    end
    self.cacheCommands = nil
  end
end

function BaseView:GetInputFieldComp(owner)
  local comp = owner:GetComponent(T_InputField)
  comp = comp or owner:GetComponent(T_TMP_InputField)
  return comp
end

function BaseView:GetInputText(owner)
  local comp = self:GetInputFieldComp(owner)
  return comp and comp.text or nil
end

function BaseView:SetInputText(owner, txt)
  local comp = self:GetInputFieldComp(owner)
  if comp then
    comp.text = txt
  else
    Logger.Error("BaseView.SetInputText中owner参数无效，缺少Input组件")
  end
end

function BaseView:SetInputTextCharLimit(owner, value)
  local comp = self:GetInputFieldComp(owner)
  if comp then
    comp.characterLimit = value
  else
    Logger.Error("BaseView.SetInputTextCharLimit中owner参数无效，缺少Input组件")
  end
end

function BaseView:AddInputValueChangeListener(owner, onChange)
  local comp = self:GetInputFieldComp(owner)
  if not comp then
    Logger.Error("BaseView.AddInputValueChangeListener中owner参数无效，缺少Input组件")
    return
  end
  comp.onValueChanged:RemoveAllListeners()
  comp.onValueChanged:AddListener(onChange)
  self._inputValueChangedListeners = self._inputValueChangedListeners or {}
  self._inputValueChangedListeners[comp] = true
end

function BaseView:RemoveInputValueChangeListener(owner)
  local comp = self:GetInputFieldComp(owner)
  if not comp then
    Logger.Error("BaseView.RemoveInputValueChangeListener中owner参数无效，缺少Input组件")
    return
  end
  comp.onValueChanged:RemoveAllListeners()
  if self._inputValueChangedListeners then
    self._inputValueChangedListeners[comp] = nil
  end
end

function BaseView:_RemoveAllInputValueChangeListeners()
  if self._inputValueChangedListeners then
    for k, _ in pairs(self._inputValueChangedListeners) do
      if not IsNil(k) then
        k.onValueChanged:RemoveAllListeners()
      end
    end
    self._inputValueChangedListeners = nil
  end
end

function BaseView:AddInputEndEditListener(owner, onEndEdit)
  local comp = self:GetInputFieldComp(owner)
  if not comp then
    Logger.Error("BaseView.AddInputEndEditListener中owner参数无效，缺少Input组件")
    return
  end
  comp.onEndEdit:RemoveAllListeners()
  comp.onEndEdit:AddListener(onEndEdit)
  self._inputEndEditListeners = self._inputEndEditListeners or {}
  self._inputEndEditListeners[comp] = true
end

function BaseView:RemoveInputEndEditListener(owner)
  local comp = self:GetInputFieldComp(owner)
  if not comp then
    Logger.Error("BaseView.RemoveInputEndEditListener中owner参数无效，缺少Input组件")
    return
  end
  comp.onEndEdit:RemoveAllListeners()
  if self._inputEndEditListeners then
    self._inputEndEditListeners[comp] = nil
  end
end

function BaseView:_RemoveAllInputEndEditListeners()
  if self._inputEndEditListeners then
    for k, _ in pairs(self._inputEndEditListeners) do
      if not IsNil(k) then
        k.onEndEdit:RemoveAllListeners()
      end
    end
    self._inputEndEditListeners = nil
  end
end

function BaseView:SetToggleIsOn(owner, isOn)
  local toggleComp = owner:GetComponent(T_Toggle)
  if not toggleComp then
    Logger.Error("BaseView.SetToggleIsOn中owner参数无效，缺少Toggle组件")
    return
  end
  local playAudioEffectFunc = self:GetTogglePlayAudioEffectFunc(owner)
  toggleComp.isOn = isOn
  if not playAudioEffectFunc then
    return
  end
  playAudioEffectFunc(isOn)
end

function BaseView:AddToggleValueChangeListener(owner, onChange)
  local toggleComp = owner:GetComponent(T_Toggle)
  if not toggleComp then
    Logger.Error("BaseView.AddToggleValueChangeListener参数无效，缺少Toggle组件")
    return
  end
  toggleComp.onValueChanged:RemoveAllListeners()
  toggleComp.onValueChanged:AddListener(self:_ToggleValueFunc(toggleComp, onChange))
  self.toggleValueChangedListeners = self.toggleValueChangedListeners or {}
  self.toggleValueChangedListeners[toggleComp] = true
end

function BaseView:RemoveToggleValueChangeListener(owner)
  local toggleComp = owner:GetComponent(T_Toggle)
  if not toggleComp then
    Logger.Error("BaseView.AddToggleValueChangeListener参数无效，缺少Toggle组件")
    return
  end
  toggleComp.onValueChanged:RemoveAllListeners()
  if self.toggleValueChangedListeners and self.toggleValueChangedListeners[toggleComp] then
    self.toggleValueChangedListeners[toggleComp] = nil
  end
end

function BaseView:_RemoveAllToggleValueChangeListeners()
  if self.toggleValueChangedListeners then
    for k, _ in pairs(self.toggleValueChangedListeners) do
      if not IsNil(k) then
        k.onValueChanged:RemoveAllListeners()
      end
    end
    self.toggleValueChangedListeners = nil
  end
end

function BaseView:_ToggleValueFunc(toggleComp, onValueChanged)
  return function(isOn)
    if onValueChanged then
      onValueChanged(isOn)
    end
    local playAudioEffectFunc = self:GetTogglePlayAudioEffectFunc(toggleComp.gameObject)
    if not playAudioEffectFunc then
      return
    end
    playAudioEffectFunc(isOn)
  end
end

function BaseView:SetToggle(owner, isOn)
  local toggleComp = owner:GetComponent(T_Toggle)
  if not toggleComp then
    Logger.Error("BaseView.SetToggle中owner参数无效，缺少Toggle组件")
    return
  end
  toggleComp.isOn = isOn
end

function BaseView:SetToggleInteractable(owner, state)
  local toggleComp = owner:GetComponent(T_Toggle)
  if not toggleComp then
    Logger.Error("BaseView.SetToggleInteractable中owner参数无效，缺少Toggle组件")
    return
  end
  toggleComp.interactable = state
end

function BaseView:GetTogglePlayAudioEffectFunc(owner)
  if self.audioMuteToggles and self.audioMuteToggles[owner] then
    return
  end
  if not UIAudioManager or not UIAudioManager.Instance then
    return
  end
  local playAudioEffectFunc = UIAudioManager.Instance:GetTogglePlayAudioEffectFunc(owner)
  if not playAudioEffectFunc then
    return
  end
  return playAudioEffectFunc
end

function BaseView:SetZ1Toggle(owner, isOn, withoutNotify)
  local toggleComp = owner:GetComponent(T_Z1Toggle)
  if not toggleComp then
    Logger.Error("BaseView.SetZ1Toggle中owner参数无效，缺少Z1Toggle组件")
    return
  end
  if not withoutNotify then
    toggleComp.isOn = isOn
  else
    toggleComp:SetIsOnWithoutNotify(isOn)
  end
  if toggleComp.toggleTextComp then
    local colorType = isOn and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal
    self:SetTextColorType(toggleComp.toggleTextComp, colorType)
  end
end

function BaseView:SetZ1ToggleInteractable(owner, state)
  local toggleComp = owner:GetComponent(T_Z1Toggle)
  if not toggleComp then
    Logger.Error("BaseView.SetZ1ToggleInteractable中owner参数无效，缺少Z1Toggle组件")
    return
  end
  toggleComp.interactable = state
end

function BaseView:_Z1ToggleValueFunc(toggleComp, onValueChanged)
  return function(isOn)
    if onValueChanged then
      onValueChanged(isOn)
    end
    if toggleComp.toggleTextComp then
      local colorType = isOn and CommonDefine.ColorType.Light or CommonDefine.ColorType.Normal
      self:SetTextColorType(toggleComp.toggleTextComp, colorType)
    end
  end
end

function BaseView:AddZ1ToggleValueChangedListener(owner, onToggleChange, lockClickFunc)
  local toggleComp = owner:GetComponent(T_Z1Toggle)
  if not toggleComp then
    Logger.Error("BaseView.AddZ1ToggleListener中owner参数无效，缺少Z1Toggle组件")
    return
  end
  toggleComp.onValueChanged:RemoveAllListeners()
  toggleComp.onToggleTouched:RemoveAllListeners()
  toggleComp.onValueChanged:AddListener(self:_Z1ToggleValueFunc(toggleComp, onToggleChange))
  toggleComp.onToggleTouched:AddListener(function()
    local playAudioEffectFunc = self:GetTogglePlayAudioEffectFunc(owner)
    if playAudioEffectFunc then
      playAudioEffectFunc(true)
    end
  end)
  if lockClickFunc and toggleComp.disableNode then
    self:AddButtonClickListener(toggleComp.disableNode, lockClickFunc)
  end
  self.z1ToggleValueChangedListeners = self.z1ToggleValueChangedListeners or {}
  self.z1ToggleValueChangedListeners[toggleComp] = true
end

function BaseView:RemoveZ1ToggleValueChangedListener(owner)
  local toggleComp = owner:GetComponent(T_Z1Toggle)
  if not toggleComp then
    Logger.Error("BaseView.AddZ1ToggleListener中owner参数无效，缺少Z1Toggle组件")
    return
  end
  toggleComp.onValueChanged:RemoveAllListeners()
  toggleComp.onToggleTouched:RemoveAllListeners()
  if self.z1ToggleValueChangedListeners then
    self.z1ToggleValueChangedListeners[toggleComp] = nil
  end
end

function BaseView:_RemoveAllZ1ToggleValueChangedListeners()
  if self.z1ToggleValueChangedListeners then
    for k, _ in pairs(self.z1ToggleValueChangedListeners) do
      if not IsNil(k) then
        k.onToggleTouched:RemoveAllListeners()
        k.onValueChanged:RemoveAllListeners()
      end
    end
    self.z1ToggleValueChangedListeners = nil
  end
end

function BaseView:SetZ1ToggleText(owner, txt)
  local toggleComp = owner:GetComponent(T_Z1Toggle)
  if not toggleComp then
    Logger.Error("BaseView.SetZ1ToggleText中owner参数无效，缺少Z1Toggle组件")
    return
  end
  if toggleComp.toggleTextComp then
    local str = StrUtils.SafeSetWordEffectStr(txt)
    str = LT.ReplaceUnicodeSpace(str)
    toggleComp.toggleTextComp.text = str
  end
end

function BaseView:SetZ1ToggleTextColorType(owner, t)
  local toggleComp = owner:GetComponent(T_Z1Toggle)
  if not toggleComp then
    Logger.Error("BaseView.SetZ1ToggleTextColorType中owner参数无效，缺少Z1Toggle组件")
    return
  end
  if toggleComp.toggleTextComp then
    self:SetTextColorType(toggleComp.toggleTextComp, t)
  end
end

function BaseView:SetZ1ToggleUnlock(owner, isUnlocked)
  local toggleComp = owner:GetComponent(T_Z1Toggle)
  if not toggleComp then
    Logger.Error("BaseView.SetZ1ToggleUnlock中owner参数无效，缺少Z1Toggle组件")
    return
  end
  if toggleComp.disableNode then
    toggleComp.disableNode:SetActive(not isUnlocked)
  end
end

function BaseView:SetToggleInteractable(owner, state)
  local toggleComp = owner:GetComponent(T_Toggle)
  if not toggleComp then
    Logger.Error("BaseView.SetToggleInteractable中owner参数无效，缺少Toggle组件")
    return
  end
  toggleComp.interactable = state
end

function BaseView:SetZ1ToggleInteractable(owner, state)
  local toggleComp = owner:GetComponent(T_Z1Toggle)
  if not toggleComp then
    Logger.Error("BaseView.SetZ1ToggleInteractable中owner参数无效，缺少Z1Toggle组件")
    return
  end
  toggleComp.interactable = state
end

function BaseView:_OpenChildPanel(name, parent, url, cb, ...)
  if self.childPanels and self.childPanels[url] then
    return
  end
  self:AddUrl2BackCommondList(url)
  self:RegisterNotify(NotifyId.OnPanelOpened, self._OnChildPanelOpened, self)
  self:RegisterNotify(NotifyId.OnPanelClosing, self._OnChildPanelClosed, self)
  self.childPanels = self.childPanels or {}
  local isPermanent = UIAsyncLoadMgr.Instance:IsPermanent(url)
  UIAsyncLoadMgr.Instance:SetPermanent(url)
  self.childPanels[url] = {
    parent = parent,
    name = name,
    cb = cb
  }
  self.openedChildrenPanels = self.openedChildrenPanels or {}
  self.openedChildrenPanels[url] = {isPermanent = isPermanent}
  if not UIManager.Instance:GetWindow(url) then
    do return UIManager.Instance.Reopen, UIManager.Instance, url, ... end
    return UIManager.Instance.Reopen, UIManager.Instance, url, ...
  else
    do return self._OnChildPanelOpened, self end
    return self._OnChildPanelOpened, self, url, ...
  end
end

function BaseView:AddUrl2BackCommondList(url)
  CommonDefine.BackCommandBlacklist[url] = true
end

function BaseView:CloseChildPanel(url)
  if not self.childPanels or not self.childPanels[url] then
    return
  end
  self:_ResumeChildPanelParent(url)
  self.childPanels[url] = nil
  UIManager.Instance:CloseByUrl(url)
end

function BaseView:_ResumeChildPanelParent(url)
  if not self.childPanels or not self.childPanels[url] then
    return
  end
  local pannel = UIManager.Instance:GetWindow(url)
  local rootNode = pannel and pannel.root or nil
  if not IsNil(rootNode) then
    local preParent = self.childPanels[url].preParent
    if preParent ~= rootNode.transform.parent then
      rootNode.transform:SetParent(preParent, false)
    end
  end
end

function BaseView:CloseAllChildrenPanels()
  if self.childPanels then
    for k, _ in pairs(self.childPanels) do
      self:_ResumeChildPanelParent(k)
      UIManager.Instance:CloseByUrl(k)
    end
    self.childPanels = nil
  end
end

function BaseView:_ResumeChildrenPermanentStatus()
  if self.openedChildrenPanels then
    for k, v in pairs(self.openedChildrenPanels) do
      if v.isPermanent then
        UIAsyncLoadMgr.Instance:SetPermanent(k)
      else
        UIAsyncLoadMgr.Instance:StopPermanent(k)
      end
    end
    self.openedChildrenPanels = nil
  end
end

function BaseView:_OnChildPanelOpened(url)
  if not self.childPanels or not self.childPanels[url] then
    return
  end
  local pannel = UIManager.Instance:GetWindow(url)
  if not pannel then
    Logger.Error("BaseView:_OnChildPanelOpened(url), panel尚未打开，url=" .. url)
    return
  end
  local rootNode = pannel.root
  if IsNil(rootNode) then
    Logger.Error("BaseView:_OnChildPanelOpened(url), pannel.root == nil，url=" .. url)
    return pannel
  end
  local preParent = rootNode.transform.parent
  self.childPanels[url].preParent = preParent
  rootNode.name = self.childPanels[url].name
  if self.childPanels[url].parent.transform ~= preParent then
    rootNode.transform:SetParent(self.childPanels[url].parent.transform, false)
  end
  pannel:SetRendered(true)
  if self.childPanels[url].cb then
    self.childPanels[url].cb()
  end
  return pannel
end

function BaseView:_OnChildPanelClosed(url)
  if not self.childPanels or not self.childPanels[url] then
    return
  end
  self:_ResumeChildPanelParent(url)
  self.childPanels[url] = nil
end

function BaseView:BindCurrency(coinGroup, coinList, showBg, hidePlusBtn)
  do return self.AddViewComponentOnce, self, coinGroup, UICompCommonCurrencyGroupItem, coinList, showBg end
  return self.AddViewComponentOnce, self, coinGroup, UICompCommonCurrencyGroupItem, coinList, showBg, hidePlusBtn
end

function BaseView:SwitchChildTapView(key, ...)
  if self.childTapViewKey == key or not self.childrenTapViews then
    return
  end
  local cfg = self.childrenTapViews[key]
  if not cfg or not cfg.UIUrl then
    return
  end
  self.preChildTapViewKey = self.childTapViewKey
  self.childTapViewKey = key
  if not cfg.viewInstance then
    cfg.viewInstance = self:_OpenChildPanel(cfg.UINodeName, cfg.parent or self.ui.uiNode, cfg.UIUrl, System.fn(self, self._OnChildTapViewSwitchedFinished), ...)
  else
    if cfg.viewInstance.RefreshOnRendered then
      cfg.viewInstance:RefreshOnRendered(...)
    end
    cfg.viewInstance:SetRendered(true)
    self:_OnChildTapViewSwitchedFinished()
  end
end

function BaseView:_InitChildrenTapViews()
end

function BaseView:_OnChildTapViewSwitchedFinished()
  if not self.childTapViewKey or not self.childrenTapViews then
    return
  end
  local cfg = self.childrenTapViews[self.childTapViewKey]
  if not cfg then
    return
  end
  local curPageUrl = cfg.UIUrl
  local curPanel = UIManager.Instance:GetWindow(curPageUrl)
  for _, v in pairs(self.childrenTapViews) do
    if curPageUrl ~= v.UIUrl then
      if v.viewInstance then
        v.viewInstance:SetRendered(false)
      else
        self:CloseChildPanel(v.UIUrl)
      end
    end
  end
  if curPanel then
    if cfg.position then
      CS.Framework.TransformUtil.SetAnchoredPos(curPanel.root.transform, cfg.position[1] or 0, cfg.position[2] or 0)
    else
      CS.Framework.TransformUtil.SetAnchoredPos(curPanel.root.transform, 0, 0)
    end
    if cfg.scale then
      CS.Framework.TransformUtil.SetLocalScale(curPanel.root.transform, cfg.scale[1] or 1, cfg.scale[2] or 1, cfg.scale[3] or 1)
    end
    if cfg.sibIndex and cfg.sibIndex >= 0 then
      curPanel.root.transform:SetSiblingIndex(cfg.sibIndex)
    end
  end
end

function BaseView:ReserveChildren(transform, num, go)
  local ct_transform = transform
  local cnt = ct_transform.childCount
  local targetGo = go or ct_transform:GetChild(0).gameObject
  while num > cnt do
    Instantiate(targetGo, ct_transform)
    cnt = cnt + 1
  end
  return cnt
end

function BaseView:AddRedPoint(gameObject, redPointID, redArgs)
  local redPointComp = self:GetViewComponent(gameObject, UICompRedDotNew)
  if not redPointComp then
    redPointComp = self:AddViewComponentOnce(gameObject, UICompRedDotNew, redPointID, redArgs)
  else
    redPointComp:InitRedData(redPointID, redArgs)
  end
end

function BaseView:LoadAllLangFont(owner)
  self.binder:LoadAllLangFont(owner)
end

return BaseView
