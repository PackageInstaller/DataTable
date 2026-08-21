_class("UITestFuncBtnManager", Object)
UITestFuncBtnManager = UITestFuncBtnManager

function UITestFuncBtnManager:Constructor(uiView, btnPool, subpagePool)
  self._uiView = uiView
  self._btnPool = btnPool
  self._subpagePool = subpagePool
  self._data = {}
end

function UITestFuncBtnManager:SpawnBtns()
  local objs = UIWidgetHelper.SpawnObjects(self._uiView, self._btnPool, "UITestFuncBtn", #self._data)
  for i, v in ipairs(objs) do
    v:SetData(self._data[i])
  end
end

function UITestFuncBtnManager:AddBtn_Default(title, callback)
  table.insert(self._data, {title = title, callback = callback})
end

function UITestFuncBtnManager:AddBtn_Toggle(title, callback, toggleValueCallback)
  table.insert(self._data, {
    title = title,
    callback = callback,
    toggleValueCallback = toggleValueCallback
  })
end

function UITestFuncBtnManager:AddBtn_ShowDialog(title, uiName, uiParams)
  local function callback()
    if uiParams and type(uiParams) == "table" then
      GameGlobal.UIStateManager():ShowDialog(uiName, table.unpack(uiParams))
    else
      GameGlobal.UIStateManager():ShowDialog(uiName, uiParams)
    end
  end
  
  self:AddBtn_Default(title, callback)
end

function UITestFuncBtnManager:AddBtn_SwitchState(title, state, uiParams)
  local function callback()
    if uiParams and type(uiParams) == "table" then
      GameGlobal.UIStateManager():SwitchState(state, table.unpack(uiParams))
    else
      GameGlobal.UIStateManager():SwitchState(state, uiParams)
    end
  end
  
  self:AddBtn_Default(title, callback)
end

function UITestFuncBtnManager:AddBtn_SubPage(title, className, prefabName)
  local function callback()
    UIWidgetHelper.ClearWidgets(self._uiView, self._subpagePool)
    
    local obj = UIWidgetHelper.SpawnObject(self._uiView, self._subpagePool, className, prefabName)
    obj:GetGameObject():SetActive(true)
  end
  
  self:AddBtn_Default(title, callback)
end
