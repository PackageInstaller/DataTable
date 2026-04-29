local PopupMsgBoxType = {
  Ok = "Ok",
  OkCancel = "OkCancel",
  OkCancelClose = "OkCancelClose",
  OkClose = "OkClose"
}
_enum("PopupMsgBoxType", PopupMsgBoxType)
_class("UIMessageBox", Object)
UIMessageBox = UIMessageBox
local TABLE_CLEAR = table.clear
local SHALLOW_COPY = table.shallowcopy

function UIMessageBox:Constructor()
  self.bShow = false
  self.view = nil
  self.name = nil
  self.resRequest = nil
  self.key2CustomWidgetPools = {}
  self.gameobject = nil
  self.name2Gameobjects = {}
  self.type2ComponentTable = {}
end

function UIMessageBox:Dispose()
  self.key2CustomWidgetPools = nil
  self.gameobject = nil
  self.name2Gameobjects = nil
  self.type2ComponentTable = nil
end

function UIMessageBox:GetName()
  return self.name
end

function UIMessageBox:SetName(name)
  self.name = name
end

function UIMessageBox:Alert(popup, params)
end

function UIMessageBox:OnShow()
end

function UIMessageBox:OnHide()
end

function UIMessageBox:ClearCallback()
end

function UIMessageBox:GetGameObject(name)
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
    Log.fatal("UIMessageBox", self:GetName(), " GetGameObject ->", name, "<- is Null !")
    return nil
  end
end

function UIMessageBox:GetUIComponent(componentTypeName, name)
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
    Log.fatal("UIMessageBox", self.name, " GetUIComponent ->", componentTypeName, " ", name, "<- is Null !")
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
    Log.fatal("UIMessageBox ", self:GetName(), " GetUIComponent ->", componentTypeName, " ", name, "<- is Null !")
    return nil
  end
end

function UIMessageBox:GetCallBack(popup, btnCallback, param)
  return function()
    self:SetShow(false)
    if btnCallback then
      btnCallback(param)
    end
    Log.debug("[UIPopup] UIMessageBox:GetCallBack request ClosePopup")
    GameGlobal.UIStateManager():ClosePopup(popup)
  end
end

function UIMessageBox:Load(view, resRequest)
  self.view = view
  self.luaView = LuaUIView:New()
  self.resRequest = resRequest
  self:Show()
end

function UIMessageBox:Show()
  if self.view then
    self.view:SetShow(true, self)
  end
  if self.luaView then
    self.luaView:SetShow(true, self)
  end
  self:OnShow()
end

function UIMessageBox:Hide()
  self:OnHide()
  local view = self.view
  if view then
    view:SetShow(false, nil)
  end
  if self.luaView then
    self.luaView:SetShow(false, nil)
  end
  self:DisposeCustomWidgets()
end

function UIMessageBox:UnLoad()
  self:Hide()
  local resRequest = self.resRequest
  if resRequest then
    UIResourceManager.DisposeView(resRequest)
  end
  self.resRequest = nil
  self.view = nil
  self.luaView:Dispose()
  self.luaView = nil
end

function UIMessageBox:SetShow(bShow)
  if self.bShow == bShow then
    return
  end
  self.bShow = bShow
  UIHelper.SetActiveRecursively(self:GetGameObject(), bShow)
end

function UIMessageBox:DisposeCustomWidgets()
  local key2CustomWidgetPools = SHALLOW_COPY(self.key2CustomWidgetPools)
  for k, v in pairs(key2CustomWidgetPools) do
    v:Dispose()
  end
  TABLE_CLEAR(self.key2CustomWidgetPools)
end

function UIMessageBox:AddUIEvent(uiEventType, widget, name)
  self.luaView:AddUIEvent(uiEventType, widget, name)
end
