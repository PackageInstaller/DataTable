_class("UIWordNew", UICustomWidget)
UIWordNew = UIWordNew

function UIWordNew:OnShow(uiParams)
  self._text = self:GetUIComponent("RollingText", "text")
  self._tittle = self:GetUIComponent("RollingText", "tittle")
end

function UIWordNew:SetData(tittle, content)
  self._text:RefreshText(content)
  self._tittle:RefreshText(tittle)
end
