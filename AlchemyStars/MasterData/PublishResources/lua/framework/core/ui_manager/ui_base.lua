_class("UIBase", GameEventListener)
UIBase = UIBase
local TABLE_CLEAR = table.clear
local SHALLOW_COPY = table.shallowcopy

function UIBase:Constructor()
  Log.debug("[UI] UIBase:Constructor")
  self.name = nil
  self.view = nil
  self.attachedEventTypes = nil
  self.autoBinder = nil
  self.key2CustomWidgetPools = {}
  self.resRequest = nil
  self.name2Assets = {}
  self.go2ResRequest = {}
  self.gameobject = nil
  self.name2Gameobjects = {}
  self.type2ComponentTable = {}
end

function UIBase:Dispose()
  self.attachedEventTypes = nil
  self.autoBinder = nil
  self.key2CustomWidgetPools = nil
  self.name2Assets = nil
  self.go2ResRequest = nil
  self.gameobject = nil
  self.name2Gameobjects = nil
  self.type2ComponentTable = nil
  if self.resRequest then
    Log.fatal("[UI] UIBase:Dispose Error, resRequest Not Dispose,", self.name)
  end
end

function UIBase:GetName()
  return self.name
end

function UIBase:PushAndSwitchState(uiStateType, ...)
  GameGlobal.UIStateManager():PushAndSwitchState(uiStateType, ...)
end

function UIBase:SwitchState(uiStateType, ...)
  GameGlobal.UIStateManager():SwitchState(uiStateType, ...)
end

function UIBase:PopState()
  GameGlobal.UIStateManager():PopState()
end

function UIBase:PopStateTo(uiStateType, doSwitch, ...)
  GameGlobal.UIStateManager():PopStateTo(uiStateType, doSwitch, ...)
end

function UIBase:ShowDialog(uiName, ...)
  GameGlobal.UIStateManager():ShowDialog(uiName, ...)
end

function UIBase:StartTask(func, ...)
  if type(func) ~= "function" then
    return
  end
  local taskID = GameGlobal.TaskManager():StartTask(func, ...)
  Log.sys("[UI] UIBase StartTask, ID= ", taskID)
  return taskID
end

function UIBase:GetModule(proto)
  return GameGlobal.GetModule(proto)
end

function UIBase:GetUIModule(gameModuleProto)
  return GameGlobal.GetUIModule(gameModuleProto)
end

function UIBase:AttachEvent(gameEventType, func)
  if func then
    if not self.autoBinder then
      self.autoBinder = AutoEventBinder:New(GameGlobal.EventDispatcher())
    end
    self.autoBinder:BindEvent(gameEventType, self, func)
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

function UIBase:DetachEvent(gameEventType, func)
  if func then
    if self.autoBinder then
      self.autoBinder:UnBindEvent(gameEventType)
    end
  elseif self.attachedEventTypes then
    GameGlobal.EventDispatcher():RemoveListener(gameEventType, self:GetListenerID())
    self.attachedEventTypes:Remove(gameEventType)
  end
end

function UIBase:DettachAllEvents()
  local attachedEventTypes = self.attachedEventTypes
  if attachedEventTypes then
    for i = 1, attachedEventTypes:Size() do
      local gameEventType = attachedEventTypes:GetAt(i)
      GameGlobal.EventDispatcher():RemoveListener(gameEventType, self:GetListenerID())
    end
    self.attachedEventTypes:Clear()
  end
  if self.autoBinder then
    self.autoBinder:UnBindAllEvents()
  end
end

function UIBase:Lock(name)
  GameGlobal.UIStateManager():Lock(name)
end

function UIBase:ExpirationLock(name, lockMs)
  GameGlobal.UIStateManager():ExpirationLock(name, lockMs)
end

function UIBase:UnLock(name)
  GameGlobal.UIStateManager():UnLock(name)
end

function UIBase:SetShowBusy(value)
  GameGlobal.UIStateManager():ShowBusy(value)
end

function UIBase:GetGameObject(name)
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
    Log.fatal("[UI] ", self.name, " GetGameObject ->", name, "<- is Null !")
    return nil
  end
end

function UIBase:GetUIComponent(componentTypeName, name)
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
    Log.fatal("[UI] ", self.name, " GetUIComponent ->", componentTypeName, " ", name, "<- is Null !")
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
    Log.fatal("[UI] ", self.name, " GetUIComponent ->", componentTypeName, " ", name, "<- is Null !")
    return nil
  end
end

function UIBase:GetUIComponentDynamic(componentTypeName, dynamicObject)
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
  Log.fatal("[UI] ", self.name, " GetUIComponentDynamic ->", componentTypeName, " ", key, "<- is Null !")
  return nil
end

function UIBase:GetAsset(name, loadType)
  return UIResourceManager.GetAsset(name, loadType, self.name2Assets)
end

function UIBase:DisposeAsset(name)
  UIResourceManager.DisposeAsset(name, self:GetName(), self.name2Assets)
end

function UIBase:SyncGetGameObject(name)
  return UIResourceManager.SyncGetGameObject(name, self.go2ResRequest)
end

function UIBase:AsyncGetGameObject(TT, name)
  return UIResourceManager.AsyncGetGameObject(TT, name, self.go2ResRequest)
end

function UIBase:DisposeGameObject(go)
  UIResourceManager.DisposeGameObject(go, self.go2ResRequest)
end

function UIBase:DisposeAllResources()
  UIResourceManager.DisposeAllAssets(self.name2Assets)
  UIResourceManager.DisposeAllGameObjects(self.go2ResRequest)
end

function UIBase:CreateUI3DModule()
  return UIHelper.CreateUI3DModule(self.name)
end

function UIBase:InitUI3DModule(ui3DModule, modelPrefabPath, limitRotateAngle)
end

function UIBase:Show3DModule(ui3DModule, camPfbPath, maxFov, uiOperationGraphic, uibaseDepth, isCanUpDown, isCanScale, isCanRot)
  if ui3DModule then
    isCanUpDown = isCanUpDown ~= false
    isCanScale = isCanScale ~= false
    isCanRot = isCanRot ~= false
    ui3DModule:Show(camPfbPath, maxFov, uiOperationGraphic, uibaseDepth, isCanUpDown, isCanScale, isCanRot)
  end
end

function UIBase:Hide3DModule(ui3DModule)
  if ui3DModule then
    ui3DModule:Hide()
  end
end

function UIBase:Dispose3DModule(ui3DModule, id)
end

function UIBase:SetName(name)
  self.name = name
end

function UIBase:Load(view, resRequest)
  self.view = view
  self.resRequest = resRequest
  self.luaView = LuaUIView:New()
end

function UIBase:Show()
  if self.view then
    self.view:SetShow(true, self)
  end
  if self.luaView then
    self.luaView:SetShow(true, self)
  end
end

function UIBase:Hide()
  local view = self.view
  if view then
    view:SetShow(false, nil)
  end
  if self.luaView then
    self.luaView:SetShow(false, nil)
  end
end

function UIBase:UnLoad()
  self:DettachAllEvents()
  self:DisposeCustomWidgets()
  self:DisposeAllResources()
  local resRequest = self.resRequest
  if resRequest then
    UIResourceManager.DisposeView(resRequest)
  end
  self.resRequest = nil
  self.view = nil
  self.luaView:Dispose()
  self.luaView = nil
end

function UIBase:View()
  return self.view
end

function UIBase:DisposeCustomWidgets()
  local key2CustomWidgetPools = SHALLOW_COPY(self.key2CustomWidgetPools)
  for _, v in pairs(key2CustomWidgetPools) do
    v:Dispose()
  end
  TABLE_CLEAR(self.key2CustomWidgetPools)
end

function UIBase:AddUIEvent(uiEventType, widget, name)
  self.luaView:AddUIEvent(uiEventType, widget, name)
end
