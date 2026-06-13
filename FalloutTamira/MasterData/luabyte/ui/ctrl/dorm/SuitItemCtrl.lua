local SuitItemCtrl = BaseClass("SuitItemCtrl")
local M = SuitItemCtrl

function M:__init(view)
    self._view = view
end

function M:ClickItem(go)
    
end

function M:UpdateData(data)
    self.data = data
    self._view.item:SetInfo(self.data.cfg.id, ItemNumberType.FRACTION, 1 ,#self.data.furnitures)
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return SuitItemCtrl
