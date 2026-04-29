_class("UIHomelandMovieExplainController", UIController)
UIHomelandMovieExplainController = UIHomelandMovieExplainController

function UIHomelandMovieExplainController:Constructor()
  self._cfg = Cfg.cfg_homeland_movice_expain({})
  self._widgets = {}
end

function UIHomelandMovieExplainController:OnShow(uiParams)
  self:InitWidget()
  self:SetData()
end

function UIHomelandMovieExplainController:OnHide()
end

function UIHomelandMovieExplainController:InitWidget()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
end

function UIHomelandMovieExplainController:SetData()
  self._widgets = self._content:SpawnObjects("UIHomelandMovieExplainItem", table.count(self._cfg))
  local index = 1
  for i, v in pairs(self._cfg) do
    self._widgets[index]:SetData(v)
    index = index + 1
  end
end

function UIHomelandMovieExplainController:BtnBackOnClick(TT)
  self:CloseDialog()
end
