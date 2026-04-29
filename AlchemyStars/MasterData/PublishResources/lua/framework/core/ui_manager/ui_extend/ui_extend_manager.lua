_class("UIExtendManager", Object)
UIExtendManager = UIExtendManager

function UIExtendManager:Constructor()
  Log.debug("[UIExtend] UIExtendManager:Constructor")
  self.logics = {}
  self.seq = 0
end

function UIExtendManager:Dispose()
  Log.debug("[UIExtend] UIExtendManager:Dispose")
  for _, v in pairs(self.logics) do
    v:Dispose()
  end
  self.logics = nil
  self.seq = 0
end

function UIExtendManager:OnDestroy()
end

function UIExtendManager:CreateUI(uiName, uiPrefabName, ...)
  local view, resRequest = UIResourceManager.GetView(uiName, uiPrefabName)
  if not view then
    Log.fatal("[UIExtend] UIExtendManager:CreateUI, Load Resources error: ", uiPrefabName)
    return
  end
  local logic, id = self:CreateExtendLogic(uiName)
  if not logic then
    resRequest:Dispose()
    return
  end
  logic:Load(view, resRequest)
  logic:Show()
  self:OnUILoaded(uiName, logic, ...)
  return id
end

function UIExtendManager:CreateUIAsync(TT, uiName, uiPrefabName, ...)
  local view, resRequest = UIResourceManager.GetViewAsync(TT, uiName, uiPrefabName)
  if not view then
    Log.fatal("[UIExtend] UIExtendManager:CreateUIAsync, Load Resources error: ", uiPrefabName)
    return
  end
  local logic, id = self:CreateExtendLogic(uiName)
  if not logic then
    resRequest:Dispose()
    return
  end
  logic:Load(view, resRequest)
  logic:Show()
  self:OnUILoaded(uiName, logic, ...)
  return id
end

function UIExtendManager:DestroyUI(logicID)
  local logic = self.logics[logicID]
  if logic then
    logic:Dispose()
    self.logics[logicID] = nil
  end
end

function UIExtendManager:OnUILoaded(uiName, logic, ...)
  logic:SetName(uiName)
  logic:OnCreate(...)
  GameGlobal.UIStateManager():SetHighParent(logic)
end

function UIExtendManager:CreateExtendLogic(uiName)
  local id = 0
  local logic = _createInstance(uiName)
  if logic then
    if not logic:IsChildOf("UIExtendLogic") then
      Log.fatal("[UIExtend] UIExtendManager:CreateExtendLogic Fail, ", uiName, " is not inherited from UIExtendLogic!")
      return
    end
    id = self.seq + 1
    if id < 0 then
      id = 1
    end
    self.seq = id
    self.logics[id] = logic
  else
    Log.fatal("[UIExtend] UIExtendManager:CreateExtendLogic Error, ", uiName)
  end
  return logic, id
end
