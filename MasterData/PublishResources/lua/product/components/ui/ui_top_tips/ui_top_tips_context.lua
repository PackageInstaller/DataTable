_class("UITopTipsContext", UICustomWidget)
UITopTipsContext = UITopTipsContext

function UITopTipsContext:OnShow(uiParams)
  self._rect = self:GetUIComponent("RectTransform", "rect")
end

function UITopTipsContext:OnHide()
end

function UITopTipsContext:DiaName()
  return "UITopTipsController"
end

function UITopTipsContext:SetData(enum, go)
  self:Lock("UITopTips")
  self._rect.position = go:GetComponent("Transform").position
  local anchoredPosition = self._rect.anchoredPosition
  self:StartTask(function(TT)
    YIELD(TT, 50)
    self:ShowDialog("UITopTipsController", enum, anchoredPosition)
  end, self)
end

function UITopTipsContext:PopupTips(enum, offsetPosition, deltaPosition)
  self:Lock("UITopTips")
  self:StartTask(function(TT)
    YIELD(TT, 50)
    self:ShowDialog(self:DiaName(), enum, offsetPosition, deltaPosition)
  end, self)
end
