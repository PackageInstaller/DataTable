---如需继承，请保证view中的变量是一致的
local BagBaseIemCtrl = BaseClass("BagBaseIemCtrl")
local M = BagBaseIemCtrl

function M:__init(view)
    self._view = view
    self._itemId = 0
    self._itemCount = -1
    self:Init()
end

function M:Init()

end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

function M:SetActive(v)
    self._view:SetActive(v)
end

function M:SetItem(itemId, itemCount)
    if self._itemId ~= itemId then
        self._view.icon:SetItemIcon(itemId)
        if self._view.quality then
            self._view.quality:SetItemQuality(itemId)
        end
    end
    if self._itemCount ~= itemCount and self._view.numberTf then
        self._view.numberTf:SetText(tostring(itemCount))
    end
    self._itemId = itemId
    self._itemCount = itemCount
end

return BagBaseIemCtrl
