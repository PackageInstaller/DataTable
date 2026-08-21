_class("UIControllerManager", Object)
UIControllerManager = UIControllerManager
local SHALLOW_COPY = table.shallowcopy
local SWITCH_LOCK_NAME = "__framework_switch_lock__"
local cacheUINames = {
  "UIMainLobbyController"
}

function UIControllerManager:Constructor(request)
  self.uiRegisterInfoTable = {}
  self.popupManager = PopupManager:GetInstance()
  self.layerManager = UILayerManager:New(request, self)
  self.lockManager = UILockManager:New(self.layerManager)
  self.uiResolution = UIResolution:New(self.layerManager)
  local messageBoxCamera = self.layerManager:GetMessageBoxCamera()
  if messageBoxCamera then
    messageBoxCamera.enabled = false
  end
  self.extendManagers = {}
  self.loadDataTaskID = nil
  self.cacheViews = FastArray:New()
  self.visibleViews = ArrayList:New()
  self.allName2Controllers = {}
  self.allName2ControllersDirty = false
  self.allName2ControllersCache = {}
  self.forceClearCache = false
end

function UIControllerManager:Dispose()
  local visibleUIList = ArrayList:New()
  visibleUIList:Clone(self.visibleViews)
  for i = 1, visibleUIList:Size() do
    local uiName = visibleUIList:GetAt(i)
    self:ForceUnLoadUI(uiName)
  end
  if self.allName2ControllersDirty then
    self.allName2ControllersCache = SHALLOW_COPY(self.allName2Controllers)
    self.allName2ControllersDirty = false
  end
  local allName2Controllers = self.allName2ControllersCache
  for k, v in pairs(allName2Controllers) do
    self:ForceUnLoadUI(k)
  end
  self.popupManager:Dispose()
  self.layerManager:Dispose()
  self.lockManager:Dispose()
  self.uiResolution:Dispose()
  self:ClearAllExtendManagers()
  UIHelper.RemoveAllUI3DModules()
end

function UIControllerManager:RegisterUI(uiName, strPrefab, maskType, hideUnderLayer, loadDataBeforeSwitch, uiComponents)
  self.uiRegisterInfoTable[uiName] = UIRegisterInfo:New(strPrefab, maskType, hideUnderLayer, loadDataBeforeSwitch, uiComponents)
end

function UIControllerManager:GetUIRegisterInfo(ui_name)
  return self.uiRegisterInfoTable[ui_name]
end

function UIControllerManager:VisibleUIList()
  return self.visibleViews
end

function UIControllerManager:IsShow(uiName)
  return self.visibleViews:Contains(uiName)
end

function UIControllerManager:ForceUnLoadUI(uiName)
  self:UnLoadUIInternal(uiName)
  self:RemoveController(uiName)
end

function UIControllerManager:HideDialog(TT, uiName, setCache)
  setCache = setCache or false
  self:BeforeHideUI(TT, uiName)
  self:HideUI(uiName, setCache)
  self:AfterHideUI(uiName)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateLayerTopDepth, -1)
end

function UIControllerManager:BeforeHideUI(TT, uiName)
  if not self.visibleViews:Contains(uiName) then
    Log.fatal("[UI] UIControllerManager:BeforeHideUI, ui is not visible, ", uiName)
    return
  end
  if self:CheckHideUnderLayerUIType(uiName) == HideUnderLayerType.Auto_Hide then
    self:SetUnderLayerUIVisble(uiName, true)
  end
  GameGlobal.UAReportForceGuideEvent("UIShowEvent", {
    uiName,
    2,
    ""
  }, true)
  local uiController = self:GetController(uiName)
  if uiController then
    uiController:BeforeHide(TT)
  end
end

function UIControllerManager:HideUI(uiName, setCache)
  setCache = setCache or false
  if setCache then
    self:HideUIInternal(uiName)
  else
    self:UnLoadUIInternal(uiName)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIClose, uiName)
end

function UIControllerManager:AfterHideUI(uiName, setCache)
  if not setCache and (not self.cacheViews:Contains(uiName) or self.forceClearCache) then
    self:RemoveController(uiName)
  end
end

function UIControllerManager:TryShowUI(TT, uiName, res, uiParams)
  Log.prof("[UIProf] UIControllerManager:TryShowUI, ", uiName)
  local uiInfo = self.uiRegisterInfoTable[uiName]
  if not uiInfo then
    Log.fatal("[UI] UIControllerManager:TryShowUI, UI is not registered: ", uiName)
    res:SetSucc(false)
    return
  end
  if not self.cacheViews:Contains(uiName) then
    self:LoadUI(TT, uiName, res)
  else
    res.loadFromDisk = false
  end
  if not res:GetSucc() then
    return
  end
  if uiInfo.loadDataBeforeSwitch then
    self:LoadDataOnEnter(TT, uiName, res, uiParams)
  end
end

function UIControllerManager:LoadUI(TT, uiName, res)
  Log.prof("[UIProf] UIControllerManager:LoadUI, ", uiName)
  if uiName == "UIBattle" then
    GameGlobal:GetInstance():GetCollector("CoreGameLoading"):Sample("UIControllerManager:LoadUI() begin")
  end
  local loadFromDisk = false
  local controller = self:CreateController(uiName)
  if not controller then
    Log.fatal("[UI] UIControllerManager:LoadUI,UI Controller is null when load ui: ", uiName)
    res:SetSucc(false)
    return
  end
  if self.visibleViews:Contains(uiName) then
    Log.warn("[UI] UIControllerManager:LoadUI, ", uiName, " already visible")
    res:SetSucc(true)
    return
  end
  if not self.cacheViews:Contains(uiName) then
    local uiRegisterInfo = self.uiRegisterInfoTable[uiName]
    if not uiRegisterInfo then
      Log.fatal("[UI] UIControllerManager:LoadUI, Cannot find ui info when load: ", uiName)
      res:SetSucc(false)
      return
    end
    local view, resRequest = UIResourceManager.GetViewAsync(TT, uiName, uiRegisterInfo.uiPrefab)
    if not view then
      Log.fatal("[UI] UIControllerManager:LoadUI, Load Resources error: ", uiRegisterInfo.uiPrefab)
      res:SetSucc(false)
      return
    end
    loadFromDisk = true
    controller:Load(view, resRequest)
    self:OnUILoaded(controller, uiName, uiRegisterInfo)
  end
  if not loadFromDisk then
    res.loadFromDisk = loadFromDisk
  end
  if uiName == "UIBattle" then
    GameGlobal:GetInstance():GetCollector("CoreGameLoading"):Sample("UIControllerManager:LoadUI() end")
  end
  Log.prof("[UIProf] UIControllerManager:LoadUI end, ", uiName)
end

function UIControllerManager:ShowAllUI()
  _ylw("*********ShowAllUI")
  _ylw("*********visibleViews")
  for i = 1, self.visibleViews:Size() do
    local name = self.visibleViews:GetAt(i)
    _ylw(name)
  end
  _ylw("*********cacheViews")
  for i = 1, self.cacheViews:Size() do
    local name = self.cacheViews:GetAt(i)
    _ylw(name)
  end
  self.layerManager:ShowAllUI()
end

function UIControllerManager:ShowUI(uiName, res, uiParams, depth)
  depth = depth or -1
  local uiController = self:GetController(uiName)
  self.layerManager:OnShowUI(uiController, depth)
  if self.visibleViews:Contains(uiName) then
    Log.warn("[UI] UIControllerManager:ShowUI, ", uiName, " already visible")
    return true
  end
  if not self.cacheViews:Contains(uiName) then
    Log.fatal("[UI] UIControllerManager:ShowUI, cache cannot find ", uiName)
    return false
  end
  self.visibleViews:PushBack(uiName)
  self.cacheViews:Remove(uiName)
  Log.prof("[UIProf] UIControllerManager:Show UI Controller, ", uiName)
  local l_reportParam = ""
  if uiParams and uiParams[1] then
    l_reportParam = tonumber(uiParams[1])
  end
  GameGlobal.UAReportForceGuideEvent("UIShowEvent", {
    uiName,
    1,
    l_reportParam
  }, true)
  uiController:Show(uiParams)
  Log.prof("[UIProf] UIControllerManager:Show UI Controller, end", uiName)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIOpen, uiName)
end

function UIControllerManager:AfterShowUI(TT, uiName, res, uiParams)
  Log.debug("[UI] UIControllerManager:AfterShowUI, ", uiName)
  if not self.visibleViews:Contains(uiName) then
    Log.fatal("[UI] UIControllerManager:AfterShowUI, ui is not visible ", uiName)
    return
  end
  local uiRegisterInfo = self.uiRegisterInfoTable[uiName]
  if not uiRegisterInfo then
    Log.fatal("[UI] UIControllerManager:AfterShowUI, Cannot find ui register info, ", uiName)
    return
  end
  local uiController = self:GetController(uiName)
  if not uiController then
    return
  end
  if uiRegisterInfo.loadDataBeforeSwitch then
    uiController:UpdateUIOnEnter()
  else
    uiController:UpdateUIOnEnterByDefaultData()
  end
  local subTaskList = {}
  subTaskList[#subTaskList + 1] = GameGlobal.TaskManager():StartTask(UIController.AfterShow, uiController)
  if not uiRegisterInfo.loadDataBeforeSwitch then
    self:LoadDataOnEnter(TT, uiName, res, uiParams)
    if res:GetSucc() then
      uiController:UpdateUIOnEnter()
    end
  end
  for i = 1, #subTaskList do
    JOIN(TT, subTaskList[i])
  end
  if self:CheckHideUnderLayerUIType(uiName) == HideUnderLayerType.Auto_Hide then
    self:SetUnderLayerUIVisble(uiName, false)
  end
end

function UIControllerManager:GetUnderLayerUI(uiName)
  for i = 1, self.visibleViews:Size() do
    if self.visibleViews:GetAt(i) == uiName then
      if i == 1 then
        return nil
      end
      return self.visibleViews:GetAt(i - 1)
    end
  end
end

function UIControllerManager:SetUnderLayerUIVisble(uiName, visble)
  local uiController = self:GetController(uiName)
  if not uiController then
    return
  end
  if not uiController:GetHideUnderLayerFlag() then
    uiController:SetHideUnderLayerFlag(true)
    return
  end
  if visble then
    local underLayerUIName = self:GetUnderLayerUI(uiName)
    if underLayerUIName then
      self:SetUIRootActive(underLayerUIName, true)
      self:PrivateSetUnderLayerUIVisble(underLayerUIName, true)
    end
  else
    self:PrivateSetUnderLayerUIVisble(uiName, false)
  end
end

function UIControllerManager:SetUIRootActive(uiName, flag)
  local uiController = self:GetController(uiName)
  local root = self:GetUIRootByDepth(uiController:GetDepth())
  uiController:OnRootActiveChange(flag)
  root:SetActive(flag)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AfterUIRootActive, flag, uiName)
end

function UIControllerManager:ResetAllLayerVisble()
  self.layerManager:ResetAllUIRoot()
end

function UIControllerManager:PrivateSetUnderLayerUIVisble(uiName, visble)
  local visbleMap = {}
  local layer = 0
  for i = 1, self.visibleViews:Size() do
    visbleMap[i] = true
    if self.visibleViews:GetAt(i) == uiName then
      layer = i
      break
    end
  end
  local checkAndSetLayerVisble
  if visble then
    function checkAndSetLayerVisble()
      if layer < 1 then
        return
      end
      local layerName = self.visibleViews:GetAt(layer)
      layer = layer - 1
      for i = layer, 1, -1 do
        visbleMap[i] = self:CheckHideUnderLayerUIType(layerName) == HideUnderLayerType.Dont_Hide
      end
      checkAndSetLayerVisble()
    end
  else
    local idx = 2
    
    function checkAndSetLayerVisble()
      if idx > layer then
        return
      end
      local layerName = self.visibleViews:GetAt(idx)
      for i = 1, idx - 1 do
        visbleMap[i] = self:CheckHideUnderLayerUIType(layerName) == HideUnderLayerType.Dont_Hide
      end
      idx = idx + 1
      checkAndSetLayerVisble()
    end
  end
  checkAndSetLayerVisble()
  for k, v in pairs(visbleMap) do
    local name = self.visibleViews:GetAt(k)
    local flag = v
    if not APPVER_EXPLORE then
      local ver120 = UIHideUnderLayerControllerVER120.uiMap[name]
      local controller = self:GetController(name)
      local isBlur = controller:GetMaskType() == MaskType.MT_BlurMask
      if ver120 or isBlur then
        flag = true
      end
    end
    self:SetUIRootActive(name, flag)
  end
  self.layerManager:ResetLowBGCameraClearFlag()
end

function UIControllerManager:CheckHideUnderLayerUIType(uiName)
  local uiController = self:GetController(uiName)
  if uiController then
    return uiController:GetHideUnderLayer()
  else
    Log.exception("CheckHideUnderLayerUIType controller not exist ", uiName)
    return nil
  end
end

function UIControllerManager:SetForceClearCache(flag)
  self.forceClearCache = flag
end

function UIControllerManager:GetForceClearCache()
  return self.forceClearCache
end

function UIControllerManager:IsLocked()
  if self.lockManager then
    return self.lockManager:IsLocked()
  end
  return false
end

function UIControllerManager:LockedSize()
  if self.lockManager then
    return self.lockManager:LockedSize()
  end
  return 0
end

function UIControllerManager:Lock(name)
  if self.lockManager then
    self.lockManager:Lock(name)
  end
end

function UIControllerManager:UnLock(name)
  if self.lockManager then
    self.lockManager:UnLock(name)
  end
end

function UIControllerManager:ExpirationLock(name, lockMs)
  if self.lockManager then
    self.lockManager:ExpirationLock(name, lockMs)
  end
end

function UIControllerManager:CancelExpirationLock(name)
  if self.lockManager then
    self.lockManager:CancelExpirationLock(name)
  end
end

function UIControllerManager:GetSwitchLock()
  if self.lockManager then
    return self.lockManager:HasLock(SWITCH_LOCK_NAME)
  end
  return false
end

function UIControllerManager:SetSwitchLock(value)
  if value then
    self:Lock(SWITCH_LOCK_NAME)
  else
    self:UnLock(SWITCH_LOCK_NAME)
  end
end

function UIControllerManager:UnLockAll()
  if self.lockManager then
    self.lockManager:UnLockAll()
  end
end

function UIControllerManager:ShowBusy(value)
  if self.lockManager then
    Log.debug("[UI] Show Busy: ", value)
    self.lockManager:ShowBusy(value)
  end
end

function UIControllerManager:ClearBusy()
  if self.lockManager then
    self.lockManager:ClearBusy()
  end
end

function UIControllerManager:GetUICameraByDepth(depth)
  return self.layerManager:GetUICameraByDepth(depth)
end

function UIControllerManager:GetUIRootByDepth(depth)
  return self.layerManager:GetUIRootByDepth(depth)
end

function UIControllerManager:TopDepth()
  return self.layerManager:TopDepth()
end

function UIControllerManager:GetMessageBoxCamera()
  return self.layerManager:GetMessageBoxCamera()
end

function UIControllerManager:ShowLayer(depth, flag)
  self.layerManager:ShowLayer(depth, flag)
end

function UIControllerManager:ShowAllLayers()
  self.layerManager:ShowAllLayers()
end

function UIControllerManager:IsLayerShow(depth)
  return self.layerManager:IsLayerShow(depth)
end

function UIControllerManager:IsTopUI(uiName)
  local uiController = self:GetController(uiName)
  return self.layerManager:IsTopUI(uiController:GetDepth())
end

function UIControllerManager:GetDepth(uiName)
  local uiController = self:GetController(uiName)
  return uiController:GetDepth()
end

function UIControllerManager:CloseDialogWhichIsNotToppest(TT, uiName, setCache)
  local uiController = self:GetController(uiName)
  if not uiController or uiController:GetDepth() < 1 then
    Log.fatal("[UI] UIControllerManager:CloseDialogWhichIsNotToppest, uiController is nil or depth<1,", uiName)
    return
  end
  for i = 1, self.visibleViews:Size() do
    local name = self.visibleViews:GetAt(i)
    local upperUI = self:GetController(name)
    if upperUI and upperUI:GetName() ~= uiController:GetName() and upperUI:GetDepth() > uiController:GetDepth() then
      self.layerManager:ChangeUIDepth(upperUI, upperUI:GetDepth() - 1, true)
    end
  end
  self:HideDialog(TT, uiName, setCache)
end

function UIControllerManager:CheckLayerMax(TT)
  if not self.layerManager:IsFull() then
    return
  end
  Log.debug("[UI] UIControllerManager:CheckLayerMax, UI Layer Is Full, Correct Layer 1")
  local needCloseUIList = {}
  for i = 1, self.visibleViews:Size() do
    local name = self.visibleViews:GetAt(i)
    local uiController = self:GetController(name)
    if uiController then
      if uiController:GetDepth() == 1 then
        needCloseUIList[#needCloseUIList + 1] = name
      elseif 1 < uiController:GetDepth() then
        self.layerManager:ChangeUIDepth(uiController, uiController:GetDepth() - 1, true)
      end
    end
  end
  for i = 1, #needCloseUIList do
    self:HideDialog(TT, needCloseUIList[i])
  end
end

function UIControllerManager:Update(deltaTimeMS)
  if self.allName2ControllersDirty then
    self.allName2ControllersCache = SHALLOW_COPY(self.allName2Controllers)
    self.allName2ControllersDirty = false
  end
  local allName2Controllers = self.allName2ControllersCache
  local visibleViews = self.visibleViews
  for k, v in pairs(allName2Controllers) do
    if visibleViews:Contains(k) then
      v:Update(deltaTimeMS)
    end
  end
end

function UIControllerManager:RemoveController(uiName)
  self.allName2ControllersDirty = true
  local uiController = self.allName2Controllers[uiName]
  if uiController then
    uiController:Dispose()
  end
  self.allName2Controllers[uiName] = nil
end

function UIControllerManager:GetController(uiName)
  local controller = self.allName2Controllers[uiName]
  return controller
end

function UIControllerManager:GetControllerCamera(uiName)
  local controller = self:GetController(uiName)
  local depth = controller:GetDepth()
  return self:GetUICameraByDepth(depth)
end

function UIControllerManager:SetInVisibleParent(ui)
  return self.layerManager:SetInVisibleParent(ui:View())
end

function UIControllerManager:SetTopParent(ui)
  self.layerManager:SetTopParent(ui:View(), ui:GetName())
end

function UIControllerManager:SetHighParent(ui)
  self.layerManager:SetHighParent(ui:View(), ui:GetName())
end

function UIControllerManager:CreateController(uiName)
  local controller = self.allName2Controllers[uiName]
  if not controller then
    controller = _createInstance(uiName)
    if controller then
      if not controller:IsChildOf("UIController") then
        Log.fatal("[UI] UIControllerManager:CreateController Fail, ", uiName, " is not inherited from UIController!")
        return
      end
      controller:AddComponents(self.uiRegisterInfoTable[uiName].uiComponents)
      self.allName2ControllersDirty = true
      self.allName2Controllers[uiName] = controller
    else
      Log.fatal("[UI] UIControllerManager:CreateController Error, ", uiName)
    end
  end
  return controller
end

function UIControllerManager:CallUIMethod(uiName, methodName, ...)
  if not self.visibleViews:Contains(uiName) then
    Log.fatal("[UI] UIControllerManager:CallUIMethod Error, ui is not visible, ", uiName)
    return nil
  end
  local uiController = self:GetController(uiName)
  if uiController then
    local func = uiController[methodName]
    if func then
      return func(uiController, ...)
    end
  end
  return nil
end

function UIControllerManager:GetUIMessageBox(TT, uiMsgBoxName, isShow)
  local isCache, uiMsgBox, uiView, resRequest = self.popupManager:GetUIMessageBox(TT, uiMsgBoxName)
  self:CheckMessageBoxCameraStatus(isShow)
  if not isCache then
    self.layerManager:SetMessageBoxParent(uiView, uiMsgBoxName)
    self.popupManager:SetUIMessageBox(uiMsgBoxName, uiMsgBox, uiView, resRequest)
  end
  return uiMsgBox
end

function UIControllerManager:CheckMessageBoxCameraStatus(isShow)
  if not self._messageBoxCameraRefCount then
    self._messageBoxCameraRefCount = 0
  end
  if isShow then
    self._messageBoxCameraRefCount = self._messageBoxCameraRefCount + 1
  else
    self._messageBoxCameraRefCount = self._messageBoxCameraRefCount - 1
  end
  local messageBoxCamera = self.layerManager:GetMessageBoxCamera()
  if messageBoxCamera then
    messageBoxCamera.enabled = self._messageBoxCameraRefCount > 0
  end
end

function UIControllerManager:SetGuideMessageBoxParent(view, uiName)
  self.layerManager:SetGuideMessageBoxParent(view, uiName)
end

function UIControllerManager:HasPopup()
  return self.popupManager:HasPopup()
end

function UIControllerManager:GetCurShowingPriority()
  return self.popupManager:GetCurShowingPriority()
end

function UIControllerManager:ClearPopup(TT)
  self.popupManager:Clear(TT)
end

function UIControllerManager:SetPopupPriorityFilter(TT, value, bOnlyFilter)
  self.popupManager:SetPopupPriorityFilter(TT, value, bOnlyFilter)
end

function UIControllerManager:GetPopupPriorityFilter()
  return self.popupManager:GetPriorityFilter()
end

function UIControllerManager:SetBlackSideVisible(visible, force)
  if force then
    self.uiResolution:SetBlackSideVisibleForce(visible)
  else
    self.uiResolution:SetBlackSideVisible(visible)
  end
end

function UIControllerManager:SetForceCloseBlackSideVisible(visible)
  self.uiResolution:SetForceCloseBlackSideVisible(visible)
end

function UIControllerManager:GetCacheUIList()
  local cacheList = FastArray:New()
  for _, v in pairs(cacheUINames) do
    if self.cacheViews:Contains(v) then
      cacheList:PushBack(v)
    end
  end
  return cacheList
end

function UIControllerManager:LoadDataOnEnter(TT, uiName, res, uiParams)
  res = res or UIStateSwitchReq:New()
  local uiController = self:GetController(uiName)
  if uiController then
    Log.prof("[UIProf] UIControllerManager:LoadDataOnEnter, ", uiName)
    uiController:LoadDataOnEnter(TT, res, uiParams)
    Log.prof("[UIProf] UIControllerManager:LoadDataOnEnter end, ", uiName)
    return
  end
  Log.fatal("[UI] UIControllerManager:LoadDataOnEnter, ui controller is null, ", uiName)
  res:SetSucc(false)
end

function UIControllerManager:OnUILoaded(uiController, uiName, uiRegisterInfo)
  Log.prof("[UIProf] UIControllerManager:OnUILoaded, ", uiName)
  self.layerManager:SetInVisibleParent(uiController:View(), uiName)
  uiController:SetName(uiName)
  uiController:SetMaskType(uiRegisterInfo.maskType)
  uiController:SetHideUnderLayer(uiRegisterInfo.hideUnderLayer)
  self.cacheViews:PushBack(uiName)
end

function UIControllerManager:HideUIInternal(uiName)
  if not self.visibleViews:Contains(uiName) then
    Log.warn("[UI] UIControllerManager:HideUIInternal, already hide, ", uiName)
    return true
  end
  local uiController = self:GetController(uiName)
  if uiController then
    Log.debug("[UI] UIControllerManager:Hide UI Controller, ", uiName)
    uiController:Hide()
  end
  if not self.cacheViews:Contains(uiName) then
    self.cacheViews:PushBack(uiName)
  end
  self.visibleViews:Remove(uiName)
  return true
end

function UIControllerManager:UnLoadUIInternal(uiName)
  self:HideUIInternal(uiName)
  if not self.cacheViews:Contains(uiName) then
    Log.warn("[UI] UIControllerManager:UnLoadUIInternal, cannot find ui in cache, ", uiName)
    return true
  end
  local uiRegisterInfo = self.uiRegisterInfoTable[uiName]
  if not uiRegisterInfo then
    Log.fatal("[UI] UIControllerManager:UnLoadUIInternal, cannot find ui register info, ", uiName)
    return false
  end
  if not self:IsCacheUIName(uiName) or self.forceClearCache then
    self:UnloadUICache(uiName)
  end
  return true
end

function UIControllerManager:UnloadUICache(uiName)
  self.cacheViews:Remove(uiName)
  local uiController = self:GetController(uiName)
  if uiController then
    uiController:UnLoad()
  end
end

function UIControllerManager:IsCacheUIName(uiName)
  for k, v in pairs(cacheUINames) do
    if v == uiName then
      return true
    end
  end
  return false
end

function UIControllerManager:IsTaskFinished(taskID)
  local task = GameGlobal.TaskManager():FindTask(taskID)
  if task == nil then
    return true
  else
    return false
  end
end

function UIControllerManager:AddExtendManager(type)
  local mgr = type:New()
  self.extendManagers[type._className] = mgr
end

function UIControllerManager:GetExtendManager(type)
  return self.extendManagers[type._className]
end

function UIControllerManager:ClearAllExtendManagers()
  for _, v in pairs(self.extendManagers) do
    if v then
      v:OnDestroy()
      v:Dispose()
    end
  end
  table.clear(self.extendManagers)
end

_class("UIRegisterInfo", Object)
UIRegisterInfo = UIRegisterInfo

function UIRegisterInfo:Constructor(uiPrefab, maskType, hideUnderLayer, loadDataBeforeSwitch, uiComponents)
  self.uiPrefab = uiPrefab
  self.maskType = maskType or MaskType.MT_Default
  self.hideUnderLayer = hideUnderLayer or HideUnderLayerType.Dont_Hide
  self.loadDataBeforeSwitch = loadDataBeforeSwitch or true
  self.uiComponents = uiComponents
end

local HideUnderLayerType = {
  Dont_Hide = 0,
  Manual_Hide = 1,
  Auto_Hide = 2
}
_enum("HideUnderLayerType", HideUnderLayerType)
