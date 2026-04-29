_class("UITestFuncEntry", UICustomWidget)
UITestFuncEntry = UITestFuncEntry

function UITestFuncEntry:SetData(className, prefabName)
  local isShow = EngineGameHelper.IsDevelopmentBuild() or HelperProxy:GetInstance():GetConfig("EnableTestFunc", "false") == "true"
  self:GetGameObject():SetActive(isShow)
  self._className = className
  self._prefabName = prefabName
end

function UITestFuncEntry:BtnOnClick()
  self:ShowDialog("UITestFuncController", self._className, self._prefabName)
end
