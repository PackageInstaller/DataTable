local M = BaseClass('ItemPfbCtrl')

function M:__init(view)
    self._view = view
    self._view.item.onClick = Bind(self, self.OnClickUI)
end

function M:SetActive(isShow)
    self._view:SetActive(isShow)
end

function M:SetInfo(id, num)
    self.id = id
    self.num = num
    self._view.item:SetInfo(id, ItemNumberType.TOTLE, num)
end

function M:UpdateItem(data)
    self:SetInfo(data.id, data.num)
end

function M:SetItemClick(func)
    self.m_callback = func
end

function M:OnClickUI()
    if self.m_callback then
        self.m_callback(self.id, self.num)
    end
end

function M:SetState(state)
    self._view.item:SetState(state)
end

function M:OnDispose()
    self.m_callback = nil
    if self._view then
        self._view.item:DoDispose()
        self._view:OnDispose()
        self._view = nil
    end
end

return M
