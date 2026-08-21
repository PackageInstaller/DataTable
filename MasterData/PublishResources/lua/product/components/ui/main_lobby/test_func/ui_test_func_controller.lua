_class("UITestFuncController", UIController)
UITestFuncController = UITestFuncController

function UITestFuncController:LoadDataOnEnter(TT, res, uiParams)
  local className = uiParams and uiParams[1]
  local prefabName = uiParams and uiParams[2]
  local func = uiParams and uiParams[3]
  if func then
    self._data = func()
  end
  local obj = UIWidgetHelper.SpawnObject(self, "_pool", className, prefabName)
  obj:SetData(self._data)
end

function UITestFuncController:OnShow(uiParams)
  self:_SetCommonTopButton()
end

function UITestFuncController:OnHide()
end

function UITestFuncController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:CloseDialog()
  end)
end
