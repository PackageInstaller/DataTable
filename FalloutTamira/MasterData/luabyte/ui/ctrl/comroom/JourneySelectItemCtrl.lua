local M = BaseClass("JourneySelectItemCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))

function M:Init()
    self.m_data = nil
    self:SetClickCallback(Bind(self, self.OnClickItem))
end

function M:OnClickItem(go)
    if not self.m_data.IsMark or (self.m_data.Cnt <= 0) then
        GameHelper.PopItem(self.m_data.Id, self.m_data.Cnt, self._view)
        return
    end
    if self.m_clickCallback then self.m_clickCallback(self.m_data) end
end

function M:UpdateItem(data)
    if data == nil then return end

    self.m_data = data
    self:SetMarkActive(self.m_data.IsMark)
    self:SetInfo(data.Id, ItemNumberType.NONE, data.Cnt)
    -- 非高亮不可选中
    if data.IsMark and data.Cnt > 0 then
        if data.IsSelect then
            self:SetState(2) -- 选中
        else
            self:SetState(1) -- 未选中
        end
    else
        self:SetState(3) -- 不可选
    end
end

function M:OnDispose()
    self.m_data = nil
    self.m_clickCallback = nil
    M.super.OnDispose(self)
end

function M:SetSelectCallback(callback)
    self.m_clickCallback = callback
end

return M
