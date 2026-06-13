local M = BaseClass("FreeChooseHerosItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self.m_data = nil
    self.m_clickCallback = nil
    self.m_pressCallback = nil
    self._view.heroItem.canSelect = true
    self._view.heroItem.selectBack = Bind(self, self.OnItemSelected)
    self._view.heroItem:SetLongPressCallback(Bind(self, self.OnItemLongPress))
end

-- 选中/取消 回调
function M:OnItemSelected(_, it)
    if self.m_clickCallback then
        self.m_clickCallback(self.m_data.heroId)
    end
end

-- 状态改变回调
function M:SetSelectChangeCallback(callback, longPress)
    self.m_clickCallback = callback
    self.m_pressCallback = longPress
end

-- {heroId=1,selected=false}
function M:UpdateItem(data)
    self.m_data = data
    self._view.heroItem:SetHeroId(self.m_data.heroId, 0, 1)
    self._view.heroItem:SetSelect(self.m_data.selected)
    self._view.heroItem:SetTag(self.m_data.isHave)
end

function M:OnItemLongPress(go)
    if self.m_pressCallback then
        self._view.heroItem:SetClickUp() -- 禁止连续触发
        self.m_pressCallback(self.m_data.heroId)
    end
end

function M:OnDispose()
    self.m_data = nil
    self.m_clickCallback = nil
    self.m_pressCallback = nil
    self._view.heroItem.selectBack = nil
    self._view.heroItem:SetLongPressCallback(nil)
    M.super.OnDispose(self)
end

return M
