local M = BaseClass("DormStoryGiftItemCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))

function M:Init()
    self.m_data = nil
    self:SetClickCallback(Bind(self, self._ClickItem))
    self._view.BtnTips.transform:onClick(Bind(self, self.OnClickTips))
end

function M:OnDispose()
    self.m_data = nil
    M.super.OnDispose(self)
end

function M:OnClickTips(go)
    GameHelper.PopItem(self.m_data.data.Id, 0, self._view)
end

function M:_ClickItem(go)
    if self.isTask then
        local itemData = self.m_data.data
        EventMgr:Broadcast(UIMessageNames.DORM_STORY_SELECT_ITEM, itemData)
    end
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    local itemData = data.data
    -- 数据不同 刷新
    if self.m_data ~= data then
        self.m_data = data

        self:SetInfo(itemData.Id, ItemNumberType.TOTLE, itemData.Num)
    end

    self:SetSelect(self.m_isSelect(itemData.Id))
    self.isTask = self.m_isTask(self.m_data.data.Id)
    if self.isTask then
        self:SetState(1)
    else
        self:SetState(3)
    end
end

function M:SetSelect(value)
    self.m_data.isSelect = value
    self:Select(self.m_data.isSelect)
end

function M:SetCallBack(action, action1)
    self.m_isTask = action
    self.m_isSelect = action1
end

return M
