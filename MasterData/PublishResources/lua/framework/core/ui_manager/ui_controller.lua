require("game_event_listener")
_class("UIController", GameEventListener)
local TABLE_CLEAR = table.clear

function UIController:Constructor(ui_root_transform)
  self.view = nil
  self.name = nil
  self.depth = 0
  self.maskType = MaskType.MT_None
  self.hideUnderLayer = HideUnderLayerType.Dont_Hide
  self.components = SortedDictionary:New()
  self.defaultComponent = UIDefaultComponent:New()
  self.defaultComponent:Init(self, nil)
  self.componentParams = {}
  self.ondepthChanges = FastArray:New()
  self.attachedEventTypes = nil
  self.type2Callbacks = nil
  self.key2CustomWidgetPools = {}
  self.resRequest = nil
  self.name2Assets = {}
  self.go2ResRequest = {}
  self.gameobject = nil
  self.name2Gameobjects = {}
  self.type2ComponentTable = {}
  self.hideUnderLayerFlag = true
  self.uiEventTriggers = {}
  self.uiCustomEventListener = UICustomUIEventListener:New()
end

function UIController:Dispose()
  self.ondepthChanges = nil
  self.attachedEventTypes = nil
  self.type2Callbacks = nil
  self.name2Assets = nil
  self.name2ObjRequests = nil
  self.gameobject = nil
  self.name2Gameobjects = nil
  self.type2ComponentTable = nil
  self.components = nil
  self.defaultComponent = nil
  self.componentParams = nil
  self.key2CustomWidgetPools = nil
  self.uiCustomEventListener = nil
  if self.resRequest then
    Log.fatal("Error @ yqq, resRequest Not Dispose")
  end
end

function UIController:GetName()
  return self.name
end

function UIController:SetName(name)
  self.name = name
end

function UIController:GetDepth()
  return self.depth
end

function UIController:SetDepth(depth)
  if self.depth ~= depth then
    self.depth = depth
    if self.ondepthChanges then
      for i = 1, self.ondepthChanges:Size() do
        local callback = self.ondepthChanges:GetAt(i)
        callback:Call(self.depth)
      end
    end
  end
end

function UIController:GetHideUnderLayerFlag()
  return self.hideUnderLayerFlag
end

function UIController:SetHideUnderLayerFlag(flag)
  self.hideUnderLayerFlag = flag
end

function UIController:RemoveCustomEventListener(delegate)
  self.uiCustomEventListener:RemoveCustomEventListener(delegate)
end

function UIController:AddUICustomEventListener(go, type, func)
  self.uiCustomEventListener:AddUICustomEventListener(go, type, func)
end

function UIController:RemoveAllCustomEventListener()
  self.uiCustomEventListener:RemoveAllCustomEventListener()
end

function UIController:GetMaskType()
  return self.maskType
end

function UIController:SetMaskType(maskType)
  self.maskType = maskType
end

function UIController:ManualSetUnderLayerUIVisble(visble)
  if GameGlobal.UIStateManager().uiControllerManager:CheckHideUnderLayerUIType(self:GetName()) == HideUnderLayerType.Manual_Hide then
    GameGlobal.UIStateManager().uiControllerManager:SetUnderLayerUIVisble(self:GetName(), visble)
  end
end

function UIController:OnRootActiveChange(flag)
end

function UIController:GetHideUnderLayer()
  return self.hideUnderLayer
end

function UIController:SetHideUnderLayer(hideUnderLayer)
  self.hideUnderLayer = hideUnderLayer
end

function UIController:OnShow(uiParams)
end

function UIController:OnUpdate(deltaTimeMS)
end

function UIController:OnHide()
end

function UIController:LoadDataOnEnter(TT, res, uiParams)
  res:SetSucc(true)
end

function UIController:UpdateUIOnEnterByDefaultData()
end

function UIController:UpdateUIOnEnter()
end

function UIController:PushAndSwitchState(uiStateType, ...)
  GameGlobal.UIStateManager():PushAndSwitchState(uiStateType, ...)
end

function UIController:SwitchState(uiStateType, ...)
  GameGlobal.UIStateManager():SwitchState(uiStateType, ...)
end

function UIController:PopState(...)
  GameGlobal.UIStateManager():PopState(...)
end

function UIController:PopStateTo(uiStateType, doSwitch, ...)
  GameGlobal.UIStateManager():PopStateTo(uiStateType, doSwitch, ...)
end

function UIController:ShowCurUIState(flag)
  GameGlobal.UIStateManager():ShowCurUIState(flag)
end

function UIController:ShowDialog(uiName, ...)
  GameGlobal.UIStateManager():ShowDialog(uiName, ...)
end

function UIController:CloseDialog()
  GameGlobal.UIStateManager():CloseDialog(self:GetName())
end

function UIController:Manager()
  return GameGlobal.UIStateManager()
end

function UIController:GetModule(gameModuleProto)
  return GameGlobal.GetModule(gameModuleProto)
end

function UIController:GetUIModule(gameModuleProto)
  return GameGlobal.GetUIModule(gameModuleProto)
end

function UIController:StartTask(func, ...)
  if type(func) ~= "function" then
    return
  end
  local taskID = GameGlobal.TaskManager():StartTask(func, ...)
  return taskID
end

function UIController:StartSafeTask(lockName, func, ...)
  local params = {
    ...
  }
  if params[1] == self then
    table.insert(params, 2, lockName)
  else
    table.insert(params, 1, lockName)
  end
  local taskID = UIController.StartTask(self, func, table.unpack(params))
  if self._safeTasks == nil then
    self._safeTasks = {}
  end
  table.insert(self._safeTasks, {taskID = taskID, lockName = lockName})
  return taskID
end

function UIController:ReleaseSafeTasks()
  if self._safeTasks == nil then
    return
  end
  local taskMgr = GameGlobal.TaskManager()
  for k, v in pairs(self._safeTasks) do
    local task = taskMgr:FindTask(v.taskID)
    if task and task.state ~= TaskState.Stop then
      if v.lockName then
        self:UnLock(v.lockName)
      end
      taskMgr:KillTask(v.taskID)
    end
  end
  self._safeTasks = nil
end

function UIController:Lock(name)
  GameGlobal.UIStateManager():Lock(name)
end

function UIController:UnLock(name)
  GameGlobal.UIStateManager():UnLock(name)
end

function UIController:ExpirationLock(name, lockMs)
  GameGlobal.UIStateManager():ExpirationLock(name, lockMs)
end

function UIController:CancelExpirationLock(name)
  GameGlobal.UIStateManager():CancelExpirationLock(name)
end

function UIController:SetShowBusy(value)
  GameGlobal.UIStateManager():ShowBusy(value)
end

function UIController:CallUIMethod(uiName, methodName, ...)
  return GameGlobal.UIStateManager():CallUIMethod(uiName, methodName, ...)
end

function UIController:AttachEvent(gameEventType, func)
  if func then
    if not self.type2Callbacks then
      self.type2Callbacks = {}
    end
    local callback = self.type2Callbacks[gameEventType]
    if callback then
      Log.fatal("[UI] UIController:AttachEvent Error, had attached callback of event, ", gameEventType, ",", debug.traceback())
      return
    end
    callback = GameHelper:GetInstance():CreateCallback(func, self)
    self.type2Callbacks[gameEventType] = callback
    GameGlobal.EventDispatcher():AddCallbackListener(gameEventType, callback)
  else
    if not self.attachedEventTypes then
      self.attachedEventTypes = FastArray:New()
    end
    if self.attachedEventTypes:Contains(gameEventType) then
      return
    end
    self.attachedEventTypes:PushBack(gameEventType)
    GameGlobal.EventDispatcher():AddListener(gameEventType, self)
  end
end

function UIController:DetachEvent(gameEventType, func)
  if func then
    if self.type2Callbacks then
      local callback = self.type2Callbacks[gameEventType]
      if callback then
        GameGlobal.EventDispatcher():RemoveCallbackListener(gameEventType, callback)
        self.type2Callbacks[gameEventType] = nil
      end
    end
  elseif self.attachedEventTypes then
    GameGlobal.EventDispatcher():RemoveListener(gameEventType, self:GetListenerID())
    self.attachedEventTypes:Remove(gameEventType)
  end
end

function UIController:DetachAllEvents()
  local attachedEventTypes = self.attachedEventTypes
  if attachedEventTypes then
    for i = 1, attachedEventTypes:Size() do
      local gameEventType = attachedEventTypes:GetAt(i)
      GameGlobal.EventDispatcher():RemoveListener(gameEventType, self:GetListenerID())
    end
    self.attachedEventTypes:Clear()
  end
  local type2Callbacks = self.type2Callbacks
  if type2Callbacks then
    for k, v in pairs(type2Callbacks) do
      GameGlobal.EventDispatcher():RemoveCallbackListener(k, v)
    end
    TABLE_CLEAR(self.type2Callbacks)
  end
end

function UIController:DispatchEvent(gameEventType, ...)
  GameGlobal.EventDispatcher():Dispatch(gameEventType, ...)
end

function UIController:GetGameObject(name)
  if not name then
    if self.gameobject == nil then
      self.gameobject = self.view:GetGameObject()
    end
    return self.gameobject
  else
    local obj = self.name2Gameobjects[name]
    if obj then
      return obj
    end
    local view = self.view
    if view then
      local target = view:GetGameObject(name)
      if target then
        self.name2Gameobjects[name] = target
        return target
      end
    end
    Log.fatal("UIController", self:GetName(), " GetGameObject ->", name, "<- is Null !")
    return nil
  end
end

function UIController:GetUIComponent(componentTypeName, name)
  if componentTypeName == "UISelectObjectPath" then
    local uiCustomWidgetPool = self.key2CustomWidgetPools[name]
    if uiCustomWidgetPool then
      return uiCustomWidgetPool
    end
    local view = self.view
    if view then
      local dynamicInfoOfEngine = view:GetUIComponent(componentTypeName, name)
      if dynamicInfoOfEngine then
        uiCustomWidgetPool = UICustomWidgetPool:New(self, dynamicInfoOfEngine)
        self.key2CustomWidgetPools[name] = uiCustomWidgetPool
        return uiCustomWidgetPool
      end
    end
    Log.fatal("UIController", self:GetName(), " GetUIComponent ->", componentTypeName, " ", name, "<- is Null !")
    return nil
  else
    local name2Component = self.type2ComponentTable[componentTypeName]
    if name2Component then
      local component = name2Component[name]
      if component then
        return component
      end
    end
    local view = self.view
    if view then
      local target = view:GetUIComponent(componentTypeName, name)
      if target then
        if name2Component == nil then
          self.type2ComponentTable[componentTypeName] = {}
          name2Component = self.type2ComponentTable[componentTypeName]
        end
        name2Component[name] = target
        return target
      end
    end
    Log.fatal("UIController", self:GetName(), " GetUIComponent ->", componentTypeName, " ", name, "<- is Null !")
    return nil
  end
end

function UIController:GetUIComponentDynamic(componentTypeName, dynamicObject)
  local key = dynamicObject:GetInstanceID()
  local uiCustomWidgetPool = self.key2CustomWidgetPools[key]
  if uiCustomWidgetPool then
    return uiCustomWidgetPool
  end
  local dynamicInfoOfEngine = dynamicObject:GetComponent(componentTypeName)
  if dynamicInfoOfEngine then
    uiCustomWidgetPool = UICustomWidgetPool:New(self, dynamicInfoOfEngine)
    self.key2CustomWidgetPools[key] = uiCustomWidgetPool
    return uiCustomWidgetPool
  end
  Log.fatal("UIController ", self:GetName(), " GetUIComponentDynamic ->", componentTypeName, " ", key, "<- is Null !")
  return nil
end

function UIController:GetChildComponent(parent, componentTypeName, name)
  local child = parent.transform:Find(name)
  if child == nil then
    return nil
  end
  return child:GetComponent(componentTypeName)
end

function UIController:GetGameObjectInCustomWidget(customWidget, name)
  for _, pool in pairs(self.key2CustomWidgetPools) do
    local spawns = pool:GetAllSpawnList()
    if 0 < #spawns then
      for _, widget in pairs(spawns) do
        if widget._className == customWidget then
          return widget:GetGameObject(name), widget
        end
      end
    end
  end
end

function UIController:GetCustomWidget(customWidget)
  for _, pool in pairs(self.key2CustomWidgetPools) do
    local spawns = pool:GetAllSpawnList()
    if 0 < #spawns then
      for _, widget in pairs(spawns) do
        if widget._className == customWidget then
          return widget
        end
      end
    end
  end
end

function UIController:GetAsset(name, loadType)
  return UIResourceManager.GetAsset(name, loadType, self.name2Assets)
end

function UIController:AsyncGetAsset(TT, name, loadType)
  return UIResourceManager.AsyncGetAsset(TT, name, loadType, self.name2Assets)
end

function UIController:DisposeAsset(name)
  UIResourceManager.DisposeAsset(name, self:GetName(), self.name2Assets)
end

function UIController:SyncGetGameObject(name, parentTransform)
  local go = UIResourceManager.SyncGetGameObject(name, self.go2ResRequest)
  if parentTransform then
    go.transform:SetParent(parentTransform, false)
  end
  return go
end

function UIController:AsyncGetGameObject(TT, name, parentTransform)
  local go = UIResourceManager.AsyncGetGameObject(TT, name, self.go2ResRequest)
  if parentTransform then
    go.transform:SetParent(parentTransform, false)
  end
  return go
end

function UIController:DisposeGameObject(go)
  UIResourceManager.DisposeGameObject(go, self.go2ResRequest)
end

function UIController:DisposeAllResources()
  UIResourceManager.DisposeAllAssets(self.name2Assets)
  UIResourceManager.DisposeAllGameObjects(self.go2ResRequest)
end

function UIController:PlayEnterAnim(TT)
end

function UIController:PlayLeaveAnim(TT)
end

function UIController:AddDepthChangeCallback(callback)
  self.ondepthChanges:PushBack(callback)
end

function UIController:RemoveDepthChangeCallback(id)
  for i = 1, self.ondepthChanges:Size() do
    local callback = self.ondepthChanges:GetAt(i)
    if callback:GetID() == id then
      self.ondepthChanges:Remove(callback)
      break
    end
  end
end

function UIController:CreateUI3DModule()
  return UIHelper.CreateUI3DModule(self:GetName())
end

function UIController:InitUI3DModule(ui3DModule, modelPrefabPath, limitRotateAngle)
  if ui3DModule then
    local callback = GameHelper:GetInstance():CreateCallback(ui3DModule.OnUIControllerDepthChange, ui3DModule)
    self.ondepthChanges:PushBack(callback)
    limitRotateAngle = limitRotateAngle or -1
    ui3DModule:Init(modelPrefabPath, limitRotateAngle)
    return callback:GetID()
  end
end

function UIController:Show3DModule(ui3DModule, camPfbPath, maxFov, uiOperationGraphic, uibaseDepth, isCanUpDown, isCanScale, isCanRot)
  if ui3DModule then
    isCanUpDown = isCanUpDown ~= false
    isCanScale = isCanScale ~= false
    isCanRot = isCanRot ~= false
    ui3DModule:Show(camPfbPath, maxFov, uiOperationGraphic, uibaseDepth, isCanUpDown, isCanScale, isCanRot)
  end
end

function UIController:Hide3DModule(ui3DModule)
  if ui3DModule then
    ui3DModule:Hide()
  end
end

function UIController:Dispose3DModule(ui3DModule, id)
  if ui3DModule then
    for i = 1, self.ondepthChanges:Size() do
      local callback = self.ondepthChanges:GetAt(i)
      if callback:GetID() == id then
        self.ondepthChanges:Remove(callback)
        ui3DModule:Release()
        break
      end
    end
  end
end

function UIController:DisposeAll3DModules()
  for i = 1, self.ondepthChanges:Size() do
    local callback = self.ondepthChanges:GetAt(i)
    local ui3DModule = callback:GetOoObject()
    if ui3DModule then
      ui3DModule:Release()
    end
  end
  self.ondepthChanges:Clear()
end

function UIController:AddComponents(uiComponentInfo)
  if uiComponentInfo then
    for k, v in pairs(uiComponentInfo) do
      local cmp = _createInstance(k)
      if cmp then
        if not cmp:IsChildOf("UIComponent") then
          Log.fatal("[UI] UIController:AddComponent Fail, ", k, " is not inherited from UIComponent!")
        else
          cmp:Init(self, v)
          self.components:Insert(k, cmp)
        end
      else
        Log.fatal("[UI] UIController:AddComponent Fail, ", k)
      end
    end
  end
end

function UIController:Update(deltaTimeMS)
  self:OnUpdate(deltaTimeMS)
end

function UIController:Load(view, resRequest)
  self.view = view
  self.resRequest = resRequest
  self.luaView = LuaUIView:New()
end

function UIController:SetComponentSharedParam(key, value)
  self.componentParams[key] = value
end

function UIController:GetComponentSharedParam(key)
  return self.componentParams[key]
end

function UIController:Show(uiParams)
  if self.view then
    self.view:SetShow(true, self)
  end
  if self.luaView then
    self.luaView:SetShow(true, self)
  end
  self:OnShow(uiParams)
  for i = 1, self.components:Size() do
    self.components:GetAt(i):Show()
  end
  self.defaultComponent:Show()
  self:AttachEvent(GameEventType.FakeInput, self.OnFakeInput)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIShowEnd, self.name, uiParams)
end

function UIController:AfterShow(TT)
  for i = 1, self.components:Size() do
    self.components:GetAt(i):AfterShow(TT)
  end
  self.defaultComponent:AfterShow(TT)
end

function UIController:BeforeHide(TT)
  for i = 1, self.components:Size() do
    self.components:GetAt(i):BeforeHide(TT)
  end
  self.defaultComponent:BeforeHide(TT)
end

function UIController:Hide()
  for i = 1, self.components:Size() do
    self.components:GetAt(i):Hide()
  end
  self.defaultComponent:Hide()
  self:RemoveAllUIEventTrigger()
  self:ReleaseSafeTasks()
  self:DetachAllEvents()
  self:OnHide()
  local view = self.view
  if view then
    view:SetShow(false, nil)
  end
  if self.luaView then
    self.luaView:SetShow(false, nil)
  end
  self:RemoveAllCustomEventListener()
  self:DisposeCustomWidgets()
  self:DisposeAllResources()
  self:DisposeAll3DModules()
end

function UIController:HideView()
  local view = self.view
  if view then
    view:SetShow(false, nil)
  end
end

function UIController:UnLoad()
  local resRequest = self.resRequest
  if resRequest then
    UIResourceManager.DisposeView(resRequest)
  end
  self.resRequest = nil
  self.view = nil
  self.luaView:Dispose()
  self.luaView = nil
end

function UIController:View()
  return self.view
end

function UIController:DisposeCustomWidgets()
  local key2CustomWidgetPools = table.shallowcopy(self.key2CustomWidgetPools)
  if key2CustomWidgetPools then
    for _, v in pairs(key2CustomWidgetPools) do
      v:Dispose()
    end
  end
  TABLE_CLEAR(self.key2CustomWidgetPools)
end

function UIController:AddUIEvent(uiEventType, widget, name)
  self.luaView:AddUIEvent(uiEventType, widget, name)
end

local UIEventTriggerType = {
  Click = "onClick",
  DoubleClick = "onDoubleClick",
  Down = "onDown",
  Enter = "onEnter",
  Exit = "onExit",
  Up = "onUp",
  Select = "onSelect",
  UpdateSelect = "onUpdateSelect",
  BeginDrag = "onBeginDrag",
  Drag = "onDrag",
  EndDrag = "onEndDrag",
  Scroll = "onScroll",
  ApplicationFocus = "onApplicationFocus"
}
_enum("UIEventTriggerType", UIEventTriggerType)

function UIController:SetUIEventTrigger(gameObject, eventTriggerType, func)
  if not self.uiEventTriggers[eventTriggerType] then
    self.uiEventTriggers[eventTriggerType] = {}
  end
  local eventTriggerGOTable = self.uiEventTriggers[eventTriggerType]
  if table.icontains(eventTriggerGOTable, gameObject) then
    Log.fatal(gameObject.name .. "节点已注册" .. eventTriggerType .. "类型的触发器，不可重复注册！")
    return
  end
  local etl = UIEventTriggerListener.Get(gameObject)
  etl[eventTriggerType] = func
  eventTriggerGOTable[#eventTriggerGOTable + 1] = gameObject
end

function UIController:RemoveUIEventTrigger(gameObject, eventTriggerType)
  if not self.uiEventTriggers[eventTriggerType] then
    return
  end
  local eventTriggerGOTable = self.uiEventTriggers[eventTriggerType]
  if not table.icontains(eventTriggerGOTable, gameObject) then
    return
  end
  UIEventTriggerListener.Get(gameObject)[eventTriggerType] = nil
end

function UIController:RemoveAllUIEventTrigger()
  for eventTriggerType, eventTriggerGOTable in pairs(self.uiEventTriggers) do
    for i = 1, #eventTriggerGOTable do
      local go = eventTriggerGOTable[i]
      UIEventTriggerListener.Get(go)[eventTriggerType] = nil
    end
  end
end

function UIController:OnFakeInput(t)
  if self.name == t.ui then
    self[t.input](self, table.unpack(t.args))
  end
end
