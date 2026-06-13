local M = BaseClass("MissionSweepRewardItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self._view.itemPfb:EnablePopItem(true)
    self.m_itemPfbs = { self._view.itemPfb }
end

function M:UpdateItem(data)
    if not data then return end

    local count, num = 1, data.SweepIdx + 1
    self._view.txt_num:SetText(string.format("%02d", num))
    for _, v in ipairs(data.Awards or {}) do
        self:_CreateItemPfb(v, count, 1)
        count = count + 1
    end
    for _, v in ipairs(data.AwardExt or {}) do
        local state = 4 + v.Tp
        for _, value in ipairs(v.Awards or {}) do
            self:_CreateItemPfb(value, count, state)
            count = count + 1
        end
    end

    for i = count, #self.m_itemPfbs do
        self.m_itemPfbs[i]:SetActive(false)
    end
end

function M:OnDispose()
    M.super.OnDispose(self)
end

function M:_CreateItemPfb(item, idx, state)
    local go = self.m_itemPfbs[idx]
    if not go then
        go = self._view.itemPfb:Instantiate()
        table.insert(self.m_itemPfbs, go)
        go:EnablePopItem(true)
    end
    go:SetInfo(item.Id, ItemNumberType.TOTLE, item.Cnt)
    go:SetState(state)
    go:SetActive(true)
end

return M
