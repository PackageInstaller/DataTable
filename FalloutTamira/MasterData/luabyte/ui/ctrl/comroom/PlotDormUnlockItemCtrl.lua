local M = BaseClass("PlotDormUnlockItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self._view.btn_enter:onClick(Bind(self, self.OnClickItem))
end

function M:OnDispose()
    self.m_callback = nil
    self.m_isUnlock = nil
    self.m_dormStory = nil
    self.m_bookStoryId = nil
    M.super.OnDispose(self)
end

function M:UpdateItem(data, idx)
    if not data then return end

    self.m_dormStory = data.Config
    self.m_isUnlock = data:IsUnlock()
    self.m_bookStoryId = data.BookStoryId

    local cost = self.m_dormStory.cost
    self._view.lockMask:SetActive(not self.m_isUnlock)
    self._view.txt_name:SetText(self.m_dormStory.storyTitle)
    self._view.txt_index:SetText(string.format("%02d", idx - 1))
    self._view.img_banner:SetPic(self.m_dormStory.personalPicture, false)
    self._view.itemSlip:SetItemNum(cost[1], ItemNumberType.BALANCE, cost[2])
end

function M:OnClickItem(go)
    if self.m_isUnlock then
        StoryDataMgr:GetInstance():TriggerStoryByGroup(self.m_dormStory.groupId)
    else
        if self.m_callback then
            self.m_callback(self.m_dormStory, self.m_bookStoryId)
        end
    end
end

function M:SetCallback(callback)
    self.m_callback = callback
end

return M
