_class("UIWorldBossDanDetailTipsContext", UICustomWidget)
UIWorldBossDanDetailTipsContext = UIWorldBossDanDetailTipsContext

function UIWorldBossDanDetailTipsContext:OnShow(uiParams)
  self._rect = self:GetUIComponent("RectTransform", "rect")
end

function UIWorldBossDanDetailTipsContext:OnHide()
end

function UIWorldBossDanDetailTipsContext:SetData(str, go)
  self:Lock("UIWorldBossDanDetailTipsController")
  self._rect.position = go:GetComponent("Transform").position
  local anchoredPosition = self._rect.anchoredPosition
  self:StartTask(function(TT)
    YIELD(TT, 50)
    self:ShowDialog("UIWorldBossDanDetailTipsController", str, anchoredPosition)
  end, self)
end
