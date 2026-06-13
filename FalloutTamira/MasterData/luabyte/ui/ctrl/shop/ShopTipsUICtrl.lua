local ShopTipsUICtrl = BaseClass("ShopTipsUICtrl", BaseUICtrl)
local M = ShopTipsUICtrl

function M:Init()
    self._view.rectBgClose:onClick(Bind(self, self.Close))
    self._view.rectClose:onClick(Bind(self, self.Close))
end

function M:OnEnter(titleId, contentId)
    self._view.txtTitle:SetText(titleId)
    self._view.txtContent:SetText(contentId)
end

function M:OnDispose()
    self._view.rectBgClose:onClick(nil)
    self._view.rectClose:onClick(nil)
    M.super.OnDispose(self)
end

return ShopTipsUICtrl