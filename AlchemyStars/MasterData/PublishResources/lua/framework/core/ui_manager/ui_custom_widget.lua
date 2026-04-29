_class("UICustomWidget", GameEventListener)
local TABLE_CLEAR = table.clear

function UICustomWidget:Constructor()
  self.enabled = true
  self.name = nil
  self.view = nil
  self.uiOwner = nil
  self.attachedEventTypes = nil
  self.type2Callbacks = nil
  self.key2CustomWidgetPools = {}
  self.name2Assets = {}
  self.go2ResRequest = {}
  self.gameobject = nil
  self.name2Gameobjects = {}
  self.type2ComponentTable = {}
  self.uiEventTriggers = {}
  self.uiCustomEventListener = UICustomUIEventListener:New()
end

function UICustomWidget:Dispose()
  self.attachedEventTypes = nil
  self.type2Callbacks = nil
  self.key2CustomWidgetPools = nil
  self.name2Assets = nil
  self.name2ObjRequests = nil
  self.gameobject = nil
  self.name2Gameobjects = nil
  self.type2ComponentTable = nil
  self.uiOwner = nil
  self.uiCustomEventListener = nil
end

function UICustomWidget:OnShow()
end

function UICustomWidget:OnHide()
end

function UICustomWidget:RootUIOwner()
  return self.uiOwner
end

function UICustomWidget:RemoveCustomEventListener(delegate)
  self.uiCustomEventListener:RemoveCustomEventListener(delegate)
end

function UICustomWidget:RemoveAllCustomEventListener()
  self.uiCustomEventListener:RemoveAllCustomEventListener()
end

function UICustomWidget:AddUICustomEventListener(go, type, func)
  self.uiCustomEventListener:AddUICustomEventListener(go, type, func)
end

function UICustomWidget:PushAndSwitchState(uiStateType, ...)
  GameGlobal.UIStateManager():PushAndSwitchState(uiStateType, ...)
end

function UICustomWidget:SwitchState(uiStateType, ...)
  GameGlobal.UIStateManager():SwitchState(uiStateType, ...)
end

function UICustomWidget:PopState()
  GameGlobal.UIStateManager():PopState()
end

function UICustomWidget:PopStateTo(uiStateType, doSwitch, ...)
  GameGlobal.UIStateManager():PopStateTo(uiStateType, doSwitch, ...)
end

function UICustomWidget:ShowDialog(uiName, ...)
  GameGlobal.UIStateManager():ShowDialog(uiName, ...)
end

function UICustomWidget:StartTask(func, ...)
  if type(func) ~= "function" then
    return
  end
  local taskID = GameGlobal.TaskManager():StartTask(func, ...)
  return taskID
end

function UICustomWidget:StartSafeTask(lockName, func, ...)
  local params = {
    ...
  }
  if params[1] == self then
    table.insert(params, 2, lockName)
  else
    table.insert(params, 1, lockName)
  end
  local taskID = UICustomWidget.StartTask(self, func, table.unpack(params))
  if self._safeTasks == nil then
    self._safeTasks = {}
  end
  table.insert(self._safeTasks, {taskID = taskID, lockName = lockName})
  return taskID
end

function UICustomWidget:ReleaseSafeTasks()
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

function UICustomWidget:GetModule(proto)
  return GameGlobal.GetModule(proto)
end

function UICustomWidget:GetUIModule(gameModuleProto)
  return GameGlobal.GetUIModule(gameModuleProto)
end

function UICustomWidget:AttachEvent(gameEventType, func)
  if func then
    if not self.type2Callbacks then
      self.type2Callbacks = {}
    end
    local callback = self.type2Callbacks[gameEventType]
    if callback then
      local str = ""
      for k, v in pairs(GameEventType) do
        if gameEventType == v then
          str = k
          break
        end
      end
      Log.fatal("[UI] UICustomWidget:AttachEvent Error, had attached callback of event [", str .. "=" .. gameEventType .. "]")
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

function UICustomWidget:DetachEvent(gameEventType, func)
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

function UICustomWidget:DetachAllEvents()
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

function UICustomWidget:DispatchEvent(gameEventType, ...)
  GameGlobal.EventDispatcher():Dispatch(gameEventType, ...)
end

function UICustomWidget:Lock(name)
  GameGlobal.UIStateManager():Lock(name)
end

function UICustomWidget:ExpirationLock(name, lockMs)
  GameGlobal.UIStateManager():ExpirationLock(name, lockMs)
end

function UICustomWidget:UnLock(name)
  GameGlobal.UIStateManager():UnLock(name)
end

function UICustomWidget:SetShowBusy(value)
  GameGlobal.UIStateManager():ShowBusy(value)
end

function UICustomWidget:GetCustomWidget(customWidget)
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

function UICustomWidget:GetGameObject(name)
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
    Log.fatal("UICustomWidget", self.name, " GetGameObject ->", name, "<- is Null !")
    return nil
  end
end

function UICustomWidget:GetUIComponent(componentTypeName, name)
  if componentTypeName == "UISelectObjectPath" then
    local uiCustomWidgetPool = self.key2CustomWidgetPools[name]
    if uiCustomWidgetPool then
      return uiCustomWidgetPool
    end
    local view = self.view
    if view then
      local dynamicInfoOfEngine = view:GetUIComponent(componentTypeName, name)
      if dynamicInfoOfEngine then
        uiCustomWidgetPool = UICustomWidgetPool:New(self.uiOwner, dynamicInfoOfEngine)
        self.key2CustomWidgetPools[name] = uiCustomWidgetPool
        return uiCustomWidgetPool
      end
    end
    Log.fatal("UICustomWidget", self.name, " GetUIComponent ->", componentTypeName, " ", name, "<- is Null !")
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
    Log.fatal("UICustomWidget", self.name, " GetUIComponent ->", componentTypeName, " ", name, "<- is Null !")
    return nil
  end
end

function UICustomWidget:GetUIComponentDynamic(componentTypeName, dynamicObject)
  local key = dynamicObject:GetInstanceID()
  local uiCustomWidgetPool = self.key2CustomWidgetPools[key]
  if uiCustomWidgetPool then
    return uiCustomWidgetPool
  end
  local dynamicInfoOfEngine = dynamicObject:GetComponent(componentTypeName)
  if dynamicInfoOfEngine then
    uiCustomWidgetPool = UICustomWidgetPool:New(self.uiOwner, dynamicInfoOfEngine)
    self.key2CustomWidgetPools[key] = uiCustomWidgetPool
    return uiCustomWidgetPool
  end
  Log.fatal("UICustomWidget ", self.name, " GetUIComponentDynamic ->", componentTypeName, " ", key, "<- is Null !")
  return nil
end

function UICustomWidget:GetChildComponent(parent, componentTypeName, name)
  local child = parent.transform:Find(name)
  if child == nil then
    return nil
  end
  return child:GetComponent(componentTypeName)
end

function UICustomWidget:GetAsset(name, loadType)
  return UIResourceManager.GetAsset(name, loadType, self.name2Assets)
end

function UICustomWidget:DisposeAsset(name)
  UIResourceManager.DisposeAsset(name, self:GetName(), self.name2Assets)
end

function UICustomWidget:SyncGetGameObject(name, parentTransform)
  local go = UIResourceManager.SyncGetGameObject(name, self.go2ResRequest)
  if parentTransform then
    go.transform:SetParent(parentTransform, false)
  end
  return go
end

function UICustomWidget:AsyncGetGameObject(TT, name, parentTransform)
  local go = UIResourceManager.AsyncGetGameObject(TT, name, self.go2ResRequest)
  if parentTransform then
    go.transform:SetParent(parentTransform, false)
  end
  return go
end

function UICustomWidget:DisposeGameObject(go)
  UIResourceManager.DisposeGameObject(go, self.go2ResRequest)
end

function UICustomWidget:DisposeAllResources()
  UIResourceManager.DisposeAllAssets(self.name2Assets)
  UIResourceManager.DisposeAllGameObjects(self.go2ResRequest)
end

function UICustomWidget:CreateUI3DModule()
  return UIHelper.CreateUI3DModule(self.name)
end

function UICustomWidget:InitUI3DModule(ui3DModule, modelPrefabPath, limitRotateAngle)
  if self.uiOwner == nil or self.uiOwner.super._className == "UIMessageBox" then
    return
  end
  if ui3DModule then
    local callback = GameHelper:GetInstance():CreateCallback(ui3DModule.OnUIControllerDepthChange, ui3DModule)
    self.uiOwner:AddDepthChangeCallback(callback)
    limitRotateAngle = limitRotateAngle or -1
    ui3DModule:Init(modelPrefabPath, limitRotateAngle)
    return callback:GetID()
  end
end

function UICustomWidget:Show3DModule(ui3DModule, camPfbPath, maxFov, uiOperationGraphic, uibaseDepth, isCanUpDown, isCanScale, isCanRot)
  if ui3DModule then
    isCanUpDown = isCanUpDown ~= false
    isCanScale = isCanScale ~= false
    isCanRot = isCanRot ~= false
    ui3DModule:Show(camPfbPath, maxFov, uiOperationGraphic, uibaseDepth, isCanUpDown, isCanScale, isCanRot)
  end
end

function UICustomWidget:Hide3DModule(ui3DModule)
  if ui3DModule then
    ui3DModule:Hide()
  end
end

function UICustomWidget:Dispose3DModule(ui3DModule, id)
  if self.uiOwner == nil or self.uiOwner.super._className == "UIMessageBox" then
    return
  end
  if ui3DModule then
    self.uiOwner:RemoveDepthChangeCallback(id)
    ui3DModule:Release()
  end
end

function UICustomWidget:SetName(name)
  self.name = name
end

function UICustomWidget:GetName()
  return self.name
end

function UICustomWidget:Enable(flag)
  if self.enabled ~= flag then
    self.enabled = flag
    UIHelper.SetActiveRecursively(self:GetGameObject(), flag)
  end
end

function UICustomWidget:IsEnable()
  return self.enabled
end

function UICustomWidget:Load(view, uiOwner)
  self.view = view
  self.luaView = LuaUIView:New()
  self.uiOwner = uiOwner
  self:Show()
end

function UICustomWidget:Show()
  if self.view then
    self.view:SetShow(true, self)
  end
  if self.luaView then
    self.luaView:SetShow(true, self)
  end
  self:OnShow()
  if self.enableFakeInput then
    self:AttachEvent(GameEventType.FakeInput, self.OnFakeInput)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIShowEnd, self.name)
end

function UICustomWidget:Hide()
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
  self.uiCustomEventListener:RemoveAllCustomEventListener()
  self:DisposeCustomWidgets()
  self:DisposeAllResources()
end

function UICustomWidget:UnLoad()
  self:Hide()
  UIHelper.DestroyGameObject(self:GetGameObject())
  self.view = nil
  self.luaView:Dispose()
  self.luaView = nil
end

function UICustomWidget:View()
  return self.view
end

function UICustomWidget:DisposeCustomWidgets()
  local key2CustomWidgetPools = table.shallowcopy(self.key2CustomWidgetPools)
  if key2CustomWidgetPools then
    for _, v in pairs(key2CustomWidgetPools) do
      v:Dispose()
    end
  end
  TABLE_CLEAR(self.key2CustomWidgetPools)
end

function UICustomWidget:AddUIEvent(uiEventType, widget, name)
  self.luaView:AddUIEvent(uiEventType, widget, name)
end

function UICustomWidget:SetUIEventTrigger(gameObject, eventTriggerType, func)
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

function UICustomWidget:RemoveUIEventTrigger(gameObject, eventTriggerType)
  if not self.uiEventTriggers[eventTriggerType] then
    return
  end
  local eventTriggerGOTable = self.uiEventTriggers[eventTriggerType]
  if not table.icontains(eventTriggerGOTable, gameObject) then
    return
  end
  UIEventTriggerListener.Get(gameObject)[eventTriggerType] = nil
end

function UICustomWidget:RemoveAllUIEventTrigger()
  for eventTriggerType, eventTriggerGOTable in pairs(self.uiEventTriggers) do
    for i = 1, #eventTriggerGOTable do
      local go = eventTriggerGOTable[i]
      UIEventTriggerListener.Get(go)[eventTriggerType] = nil
    end
  end
end

function UICustomWidget:OnFakeInput(t)
  if t.ui == self.name then
    if t.uiid and self.uiid ~= t.uiid then
      return
    else
      self[t.input](self, table.unpack(t.args))
    end
  end
end

function UICustomWidget:CallUIMethod(uiName, methodName, ...)
  return GameGlobal.UIStateManager():CallUIMethod(uiName, methodName, ...)
end
