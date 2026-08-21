_class("UIStateManager", Object)
UIStateManager = UIStateManager
local UI_STATE_SWITCH_LOCK_NAME = "UIStateSwitch"
local OPEN_DIALOG_LOCK_NAME = "OpenDialog"
local CLOSE_DIALOG_LOCK_NAME = "CloseDialog"
local OPEN_POPUP_LOCK_NAME = "OpenPopup"
local CLOSE_POPUP_LOCK_NAME = "ClosePopup"

function UIStateManager:Constructor(request)
  local uiControllerMng = UIControllerManager:New(request)
  self.uiControllerManager = uiControllerMng
  self.registeredStateDic = {}
  self.stateStack = Stack:New()
  self.isStateStackDirty = false
  self.lastStateType = UIStateType.Invalid
  self.curState = nil
  self.nextState = nil
  self.uiParams = nil
  self.nextDialogListInfo = nil
  self.stackStateInfoCache = Stack:New()
  self.clearCacheUIList = {
    "UIAircraftController",
    "UIBattle",
    "UIHomelandMain",
    "UILoginEmpty"
  }
  for k, v in pairs(UIRegister.registeredUIs) do
    uiControllerMng:RegisterUI(k, v.uiPrefab, v.maskType, v.hideUnderLayer, v.loadDataBeforeSwitch, v.uiComponents)
  end
  UIStateRegister.Register(self)
  UIExtendManagerRegister:RegisterUIExtendManagers(uiControllerMng)
  self.logouting = false
end

function UIStateManager:Reset()
  self:ClearState()
end

function UIStateManager:Dispose()
  if self.curState then
    self.curState:Dispose()
  end
  self.uiControllerManager:Dispose()
end

function UIStateManager:RegisterUIState(uiStateType, uiState, bScreenshot)
  if self.registeredStateDic[uiStateType] == nil then
    uiState:Init(uiStateType, self.uiControllerManager)
    if bScreenshot == true then
      uiState:SetExitScreenShot(true)
    end
    self.registeredStateDic[uiStateType] = uiState
  end
end

function UIStateManager:GetUIRegisterInfo(ui_name)
  return self.uiControllerManager:GetUIRegisterInfo(ui_name)
end

function UIStateManager:GetLastStateType()
  return self.lastStateType
end

function UIStateManager:Lock(name)
  self.uiControllerManager:Lock(name)
end

function UIStateManager:UnLock(name)
  self.uiControllerManager:UnLock(name)
end

function UIStateManager:ExpirationLock(name, lockMs)
  self.uiControllerManager:ExpirationLock(name, lockMs)
end

function UIStateManager:CancelExpirationLock(name)
  self.uiControllerManager:CancelExpirationLock(name)
end

function UIStateManager:ShowBusy(flag)
  Log.debug("[busy] ShowBusy", flag, Log.traceback())
  self.uiControllerManager:ShowBusy(flag)
end

function UIStateManager:ClearBusy()
  Log.debug("[busy] ClearBusy", Log.traceback())
  self.uiControllerManager:ClearBusy()
end

function UIStateManager:UnLockAll()
  self.uiControllerManager:UnLockAll()
end

function UIStateManager:IsLocked()
  return self.uiControllerManager:IsLocked()
end

function UIStateManager:GetSwitchLock()
  return self.uiControllerManager:GetSwitchLock()
end

function UIStateManager:LockedSize()
  return self.uiControllerManager:LockedSize()
end

function UIStateManager:SetBlackSideVisible(visible, force)
  self.uiControllerManager:SetBlackSideVisible(visible, force)
end

function UIStateManager:SetForceCloseBlackSideVisible(visible)
  self.uiControllerManager:SetForceCloseBlackSideVisible(visible)
end

function UIStateManager:SetForceCloseBlackSideVisible(visible)
  self.uiControllerManager:SetForceCloseBlackSideVisible(visible)
end

function UIStateManager:PreLoadState(TT, uiStateType)
  local state = self.registeredStateDic[uiStateType]
  if state then
    state:PreLoad(TT)
  end
end

function UIStateManager:PushAndSwitchState(uiStateType, ...)
  if self.nextState ~= nil then
    Log.warn("[UI] UIStateManager:PushAndSwitchState ", uiStateType, " Error, UIState ", self.nextState:GetType(), " is switching")
    return
  end
  if uiStateType == self:CurUIStateType() then
    self:SwitchState(uiStateType, ...)
    return
  end
  if self:IsInStateStackBottom(uiStateType) then
    self:ClearState()
    self:SwitchState(uiStateType, ...)
    return
  end
  Log.sys("[UI] UIStateManager:PushAndSwitchState: ", uiStateType)
  self.nextState = self.registeredStateDic[uiStateType]
  if self.nextState then
    self:Lock(UI_STATE_SWITCH_LOCK_NAME)
    if self.curState then
      local curStateInfo = StateStackInfo:New(self.curState, self.uiParams)
      local nextStateType = self.nextState:GetType()
      self.isStateStackDirty = true
      if self:ContainsUIState(nextStateType) then
        self.stackStateInfoCache:Clear()
        while self.stateStack:Size() > 0 do
          local popState = self.stateStack:Pop()
          if popState.uiState:GetType() == nextStateType then
            break
          end
          self.stackStateInfoCache:Push(popState)
        end
        while self.stackStateInfoCache:Size() > 0 do
          local info = self.stackStateInfoCache:Pop()
          self.stateStack:Push(info)
        end
        self:PushToStateStack(curStateInfo)
      else
        self:PushToStateStack(curStateInfo)
      end
    end
    self.uiParams = {
      ...
    }
  end
end

function UIStateManager:SwitchState(uiStateType, ...)
  if self.nextState then
    Log.warn("[UI] UIStateManager:SwitchState ", uiStateType, " Error, UIState ", self.nextState:GetType(), " is switching")
    return
  end
  Log.sys("[UI] UIStateManager:SwitchState, ", uiStateType)
  if self:ContainsUIState(uiStateType) then
    self:PopStateTo(uiStateType, true)
    return
  end
  self.nextState = self.registeredStateDic[uiStateType]
  if self.nextState then
    self:Lock(UI_STATE_SWITCH_LOCK_NAME)
    self.uiParams = {
      ...
    }
  end
end

function UIStateManager:SwitchStateWithDialogList(uiStateType, dialogList, ...)
  if self.nextState then
    Log.warn("[UI] UIStateManager:SwitchState ", uiStateType, " Error, UIState ", self.nextState:GetType(), " is switching")
    return
  end
  Log.sys("[UI] UIStateManager:SwitchState, ", uiStateType)
  if self:ContainsUIState(uiStateType) then
    self:PopStateTo(uiStateType, true)
    return
  end
  self.nextState = self.registeredStateDic[uiStateType]
  if self.nextState then
    self.nextDialogListInfo = dialogList
    self:Lock(UI_STATE_SWITCH_LOCK_NAME)
    self.uiParams = {
      ...
    }
  end
end

function UIStateManager:ForceSwitchState(TT, uiStateType, ...)
  Log.sys("[UI] UIStateManager:ForceSwitchState, ", uiStateType)
  self.logouting = true
  while self.nextState do
    YIELD(TT)
  end
  self.nextState = self.registeredStateDic[uiStateType]
  if self.nextState then
    self:Lock(UI_STATE_SWITCH_LOCK_NAME)
    self.uiParams = {
      ...
    }
  end
end

function UIStateManager:PopState(...)
  if self.nextState then
    Log.warn("[UI] UIStateManager:PopState Error, UIState ", self.nextState:GetType(), " is switching")
    return
  end
  Log.sys("[UI] UIStateManager:PopState")
  if self.stateStack:Size() > 0 then
    self.isStateStackDirty = true
    local stateInfo = self.stateStack:Pop()
    self.nextState = stateInfo.uiState
    self.uiParams = GameHelper.IsNull(...) and stateInfo.uiParams or {
      ...
    }
    self:Lock(UI_STATE_SWITCH_LOCK_NAME)
  else
    Log.fatal("[UI] UIStateManager:PopState Error, Stack is empty")
  end
end

function UIStateManager:PopStateTo(uiStateType, doSwitch, ...)
  return GameGlobal.TaskManager():StartTask(UIStateManager.PopStateToImp, self, uiStateType, doSwitch, ...)
end

function UIStateManager:ClearState()
  self.isStateStackDirty = true
  self.stateStack:Clear()
end

function UIStateManager:ShowDialog(uiName, ...)
  return GameGlobal.TaskManager():StartTask(UIStateManager.ShowDialogImp, self, uiName, ...)
end

function UIStateManager:CloseDialog(uiName)
  return GameGlobal.TaskManager():StartTask(UIStateManager.CloseDialogImp, self, uiName)
end

function UIStateManager:GetUIMessageBox(TT, uiMsgBoxName, isShow)
  return self.uiControllerManager:GetUIMessageBox(TT, uiMsgBoxName, isShow)
end

function UIStateManager:CheckMessageBoxCameraStatus(isShow)
  self.uiControllerManager:CheckMessageBoxCameraStatus(isShow)
end

function UIStateManager:SetGuideMessageBoxParent(view, uiName)
  self.uiControllerManager:SetGuideMessageBoxParent(view, uiName)
end

function UIStateManager:HasPopup()
  return self.uiControllerManager:HasPopup()
end

function UIStateManager:GetCurShowingPriority()
  return self.uiControllerManager:GetCurShowingPriority()
end

function UIStateManager:ClearPopup()
  return GameGlobal.TaskManager():StartTask(UIControllerManager.ClearPopup, self.uiControllerManager)
end

function UIStateManager:PopupPriorityFilter(value, bOnlyFilter)
  bOnlyFilter = bOnlyFilter or false
  if value then
    GameGlobal.TaskManager():StartTask(UIControllerManager.SetPopupPriorityFilter, self.uiControllerManager, value, bOnlyFilter)
  else
    return self.uiControllerManager:GetPopupPriorityFilter()
  end
end

function UIStateManager:ShowPopup(popup)
  local uiMsgBoxName = popup.uiMsgBoxName
  Log.debug("[UIPopup] UIStateManager:ShowPopup,", uiMsgBoxName)
  return GameGlobal.TaskManager():StartTask(UIStateManager.ShowPopupImp, self, uiMsgBoxName, popup)
end

function UIStateManager:ClosePopup(popup)
  local uiMsgBoxName = popup.uiMsgBoxName
  Log.debug("[UIPopup] UIStateManager:ClosePopup,", uiMsgBoxName)
  return GameGlobal.TaskManager():StartTask(UIStateManager.ClosePopupImp, self, uiMsgBoxName, popup)
end

function UIStateManager:Update(deltaTimeMS)
  if self.nextState and not self.uiControllerManager:GetSwitchLock() then
    local targetState = self.nextState
    self:UnLock(UI_STATE_SWITCH_LOCK_NAME)
    GameGlobal.TaskManager():StartTask(UIStateManager.DoSwitchState, self, targetState, self.uiParams)
  end
  self.uiControllerManager:Update(deltaTimeMS)
end

function UIStateManager:CurUIStateType()
  if self.curState ~= nil then
    return self.curState:GetType()
  end
  return UIStateType.Invalid
end

function UIStateManager:ShowCurUIState(flag)
  if self.curState then
    self.curState:Show(flag)
  end
end

function UIStateManager:IsShow(uiName)
  return self.uiControllerManager:IsShow(uiName)
end

function UIStateManager:IsTopUI(uiName)
  return self.uiControllerManager:IsTopUI(uiName)
end

function UIStateManager:GetController(uiName)
  return self.uiControllerManager:GetController(uiName)
end

function UIStateManager:GetControllerCamera(uiName)
  return self.uiControllerManager:GetControllerCamera(uiName)
end

function UIStateManager:SetTopParent(ui)
  return self.uiControllerManager:SetTopParent(ui)
end

function UIStateManager:SetHighParent(ui)
  return self.uiControllerManager:SetHighParent(ui)
end

function UIStateManager:GetExtendManager(type)
  return self.uiControllerManager:GetExtendManager(type)
end

function UIStateManager:CallUIMethod(uiName, methodName, ...)
  return self.uiControllerManager:CallUIMethod(uiName, methodName, ...)
end

function UIStateManager:DoSwitchState(TT, nextState, params)
  while self.uiControllerManager:GetSwitchLock() do
    YIELD(TT)
  end
  local bScreenShot = false
  self.uiControllerManager:SetSwitchLock(true)
  if self.curState ~= nil then
    self.lastStateType = self.curState:GetType()
    bScreenShot = self.curState:GetExitScreenShot()
  else
    self.lastStateType = UIStateType.Invalid
  end
  if bScreenShot then
    UISwitchImgManager.Show()
  end
  GameObjectHelper.UnLoadUnUsedAsset()
  local res = UIStateSwitchReq:New()
  self.uiControllerManager:ResetAllLayerVisble()
  nextState:TryEnter(TT, self.curState, res, params, self.nextDialogListInfo)
  if res:GetSucc() then
    local forceClearCache = false
    for _, clearCacheUIName in pairs(self.clearCacheUIList) do
      local defaultUIList = nextState:GetDefaultUIList()
      for i = 1, #defaultUIList do
        local name = defaultUIList[i]
        if name == clearCacheUIName then
          forceClearCache = true
          break
        end
      end
    end
    self.uiControllerManager:SetForceClearCache(forceClearCache)
    if self.curState then
      self.curState:Exit(TT, nextState)
    end
    self.uiControllerManager:SetForceClearCache(false)
    local nextSceneName = nextState:GetSceneName()
    if not string.isnullorempty(nextSceneName) and UIHelper.GetActiveSceneName() ~= nextSceneName then
      local scene = GameGlobal.GameLogic():LoadScene(TT, nextSceneName)
      nextState:SetScene(scene)
      YIELD(TT)
    end
    nextState:Enter(self.curState, res, params, self.nextDialogListInfo)
    UISwitchImgManager.Hide()
    nextState:AfterEnter(TT, self.curState, res, params, self.nextDialogListInfo)
    if self.curState then
      self.curState:Dispose()
    end
    self.curState = nextState
    if table.icontains(GCStateList, nextState:GetType()) or table.icontains(GCStateList, self.lastStateType) then
      HelperProxy:GetInstance():GCCollect()
      collectgarbage("collect")
      HelperProxy:GetInstance():GCCollect()
      collectgarbage("collect")
    end
    if res:GetSucc() then
      Log.debug("[UI] UIStateManager:DoSwitchState, EnterState success, ", nextState:GetType())
      GameGlobal.EventDispatcher():Dispatch(GameEventType.SwitchUIStateFinish, nextState:GetType())
    else
      Log.fatal("[UI] UIStateManager:DoSwitchState, EnterState false: ", nextState:GetType())
    end
  else
    UISwitchImgManager.Hide()
  end
  self.nextState = nil
  self.nextDialogListInfo = nil
  self.uiControllerManager:SetSwitchLock(false)
end

function UIStateManager:PopStateToImp(TT, uiStateType, doSwitch, ...)
  doSwitch = doSwitch ~= false
  if self.nextState then
    Log.warn("[UI] UIStateManager:PopStateToImp ", uiStateType, " Error, UIState ", self.nextState:GetType(), " is switching")
    return
  end
  Log.sys("[UI] UIStateManager:PopStateToImp: ", uiStateType)
  if not self:ContainsUIState(uiStateType) then
    Log.fatal("[UI] UIStateManager:PopStateToImp Error, cannot find type, ", uiStateType)
    return
  end
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  local t = self.stateStack:ToArray()
  for i = 1, #t do
    local dest = t[i]
    if dest.uiState:GetType() == uiStateType then
      for j = 1, i do
        t[j].uiState:UnloadInvisibleUI()
      end
      if doSwitch then
        self.nextState = dest.uiState
        self.uiParams = GameHelper.IsNull(...) and dest.uiParams or {
          ...
        }
        self:Lock(UI_STATE_SWITCH_LOCK_NAME)
      end
      self.isStateStackDirty = true
      self.stateStack:Clear()
      for j = #t, i + 1, -1 do
        self.stateStack:Push(t[j])
      end
      return
    else
      dest.uiState:RevertState(TT, res)
      if not res:GetSucc() then
        return
      end
    end
  end
  Log.fatal("[UI] UIStateManager:PopStateToImp Error, ", uiStateType)
end

function UIStateManager:ContainsUIState(uiStateType)
  local t = self.stateStack:ToArray()
  for i = 1, #t do
    if uiStateType == t[i].uiState:GetType() then
      return true
    end
  end
  return false
end

function UIStateManager:PushToStateStack(stateInfo)
  if not stateInfo then
    return
  end
  local curStateType = stateInfo.uiState:GetType()
  if self:ContainsUIState(curStateType) then
    local targetState
    local tmpStateStack = Stack:New()
    while self.stateStack:Size() > 0 do
      local popState = self.stateStack:Pop()
      if popState.uiState:GetType() == curStateType then
        targetState = popState
        break
      else
        tmpStateStack:Push(popState)
      end
    end
    while tmpStateStack:Size() > 0 do
      local info = tmpStateStack:Pop()
      self.stateStack:Push(info)
    end
    self.stateStack:Push(targetState)
  else
    self.stateStack:Push(stateInfo)
  end
end

function UIStateManager:IsInStateStackBottom(uiStateType)
  local t = self.stateStack:ToArray()
  if t then
    local count = #t
    if 0 < count then
      return t[count].uiState:GetType() == uiStateType
    end
  end
  return false
end

local oldStr

function UIStateManager:LogUIStateStackWhenDirty()
  if self.isStateStackDirty then
    local str = ""
    local t = self.stateStack:ToArray()
    for i = 1, #t do
      local value = t[i]
      str = str .. value.uiState:GetType() .. ","
    end
    if oldStr ~= str then
      oldStr = str
      Log.fatal("------------------ ", str)
    end
  end
end

function UIStateManager:ShowDialogImp(TT, uiName, ...)
  local lockName = OPEN_DIALOG_LOCK_NAME .. uiName
  self:Lock(lockName)
  while self.uiControllerManager:GetSwitchLock() do
    if self.logouting then
      self:UnLock(lockName)
      return
    end
    YIELD(TT)
  end
  self:UnLock(lockName)
  if self.curState then
    return self.curState:ShowDialog(TT, uiName, ...)
  end
end

function UIStateManager:CloseDialogImp(TT, uiName)
  local lockName = CLOSE_DIALOG_LOCK_NAME .. uiName
  self:Lock(lockName)
  while self.uiControllerManager:GetSwitchLock() do
    if self.logouting then
      self:UnLock(lockName)
      return
    end
    YIELD(TT)
  end
  self:UnLock(lockName)
  if self.curState then
    return self.curState:CloseDialog(TT, uiName)
  end
end

local popupRequestID = 0

function UIStateManager:ShowPopupImp(TT, uiMsgBoxName, popup)
  popupRequestID = popupRequestID + 1
  local lockName = OPEN_POPUP_LOCK_NAME .. uiMsgBoxName .. popupRequestID
  self:Lock(lockName)
  while PopupManager:GetInstance():GetSwitchLock() or popup.priority < PopupPriority.Network and self.uiControllerManager:GetSwitchLock() do
    YIELD(TT)
  end
  PopupManager:GetInstance():SetSwitchLock(true)
  PopupManager:GetInstance():OpenPopup(TT, popup)
  PopupManager:GetInstance():SetSwitchLock(false)
  self:UnLock(lockName)
end

local closePopupRequestID = 0

function UIStateManager:ClosePopupImp(TT, uiMsgBoxName, popup)
  closePopupRequestID = closePopupRequestID + 1
  local lockName = CLOSE_POPUP_LOCK_NAME .. uiMsgBoxName .. closePopupRequestID
  self:Lock(lockName)
  while PopupManager:GetInstance():GetSwitchLock() or popup.priority < PopupPriority.Network and self.uiControllerManager:GetSwitchLock() do
    YIELD(TT)
  end
  PopupManager:GetInstance():SetSwitchLock(true)
  PopupManager:GetInstance():ClosePopup(TT, popup)
  PopupManager:GetInstance():SetSwitchLock(false)
  self:UnLock(lockName)
end

function UIStateManager:IsLogouting()
  return self.logouting
end

function UIStateManager:SetIsLogouting(value)
  self.logouting = value
end

function UIStateManager:GetMessageBoxCamera()
  return self.uiControllerManager:GetMessageBoxCamera()
end

function UIStateManager:GetUICameraByDepth(depth)
  return self.uiControllerManager:GetUICameraByDepth(depth)
end

function UIStateManager:SetDepthRaycast(depth, active)
  self.uiControllerManager.layerManager.layerManagerHelper:SetDepthRaycast(depth, active)
end

function UIStateManager:CloseAllDialogsExcept(exceptUIName)
  local uiList = {}
  for i = 1, self.uiControllerManager:VisibleUIList():Size() do
    local name = self.uiControllerManager:VisibleUIList():GetAt(i)
    if name ~= exceptUIName then
      uiList[#uiList + 1] = name
    end
  end
  for i = 1, #uiList do
    local uiController = self.uiControllerManager:GetController(uiList[i])
    uiController.SkipTransitionAmin = true
    if i == 1 then
      local underLayerUIName = self.uiControllerManager:GetUnderLayerUI(uiList[i])
      self.uiControllerManager:SetUIRootActive(underLayerUIName, true)
    else
      uiController:SetHideUnderLayerFlag(false)
    end
    self:CloseDialog(uiList[i])
  end
end

function UIStateManager:CloseAllDialogOverLayerWithName(uiName, exceptUINameList)
  exceptUINameList = exceptUINameList or {}
  local underLayer = self.uiControllerManager:GetDepth(uiName)
  local uiList = {}
  for i = 1, self.uiControllerManager:VisibleUIList():Size() do
    local name = self.uiControllerManager:VisibleUIList():GetAt(i)
    local uiLayer = self.uiControllerManager:GetDepth(name)
    if underLayer < uiLayer then
      local closeDialogFlag = true
      for _, exceptUIName in pairs(exceptUINameList) do
        if name == exceptUIName then
          closeDialogFlag = false
        end
      end
      if closeDialogFlag then
        uiList[#uiList + 1] = name
      end
    end
  end
  for i = 1, #uiList do
    local uiController = self.uiControllerManager:GetController(uiList[i])
    uiController.SkipTransitionAmin = true
    if i == 1 then
      local underLayerUIName = self.uiControllerManager:GetUnderLayerUI(uiList[i])
      self.uiControllerManager:SetUIRootActive(underLayerUIName, true)
    else
      uiController:SetHideUnderLayerFlag(false)
    end
    self:CloseDialog(uiList[i])
  end
end

_class("StateStackInfo", Object)
StateStackInfo = StateStackInfo

function StateStackInfo:Constructor(uiState, uiParams)
  self.uiState = uiState
  self.uiParams = uiParams
end

require("async_request_res")
_class("UIStateSwitchReq", AsyncRequestRes)
UIStateSwitchReq = UIStateSwitchReq

function UIStateSwitchReq:Constructor()
  self.loadFromDisk = true
end
