_class("UITestFuncSubpageBase", UICustomWidget)
UITestFuncSubpageBase = UITestFuncSubpageBase

function UITestFuncSubpageBase:OnShow(uiParams)
  self._btnManager = UITestFuncBtnManager:New(self)
  self:_FillData(self._btnManager)
  local pool = self:GetUIComponent("UISelectObjectPath", "_pool")
  self._btnManager:SpawnBtns(pool)
end

function UITestFuncSubpageBase:OnHide()
end

function UITestFuncSubpageBase:ExitBtnOnClick()
  self:GetGameObject():SetActive(false)
end

function UITestFuncSubpageBase:_FillData(btnManager)
end
