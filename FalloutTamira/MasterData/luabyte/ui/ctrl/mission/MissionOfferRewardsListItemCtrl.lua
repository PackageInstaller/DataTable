local M = BaseClass("MissionOfferRewardsListItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self.m_isMax = false
    self._view:onClick(Bind(self, self.OnClickItem))
end

function M:OnDispose()
    self.m_data = nil
    self.m_isMax = nil
    self.m_callback = nil
    M.super.OnDispose(self)
end

function M:UpdateItem(data)
    if data == nil then return end
    self.m_data = data
    self._view.txt_name:SetText(data.MissionCfg.name)
    self._view.tipsRect:SetActive(data.IsToday)
    self._view.selectRect:SetActive(data.IsSelect)
    local curNum, maxNum = 0, 0
    for i, _ in ipairs(data.Words) do
        maxNum = maxNum + 1
        local isDone = (1 << (i - 1)) & data.Mask ~= 0
        if isDone then curNum = curNum + 1 end
    end
    self.m_isMax = curNum >= maxNum
    self._view.doneRect:SetActive(self.m_isMax)
    self._view.txt_numL:SetText(tostring(curNum))
    self._view.txt_numR:SetText(tostring(maxNum))
end

function M:OnClickItem(go)
    if self.m_isMax then
        GameHelper.ConfirmPopupUI("此关卡奖励已全部获取，是否继续选中？", function(ok)
            if ok then
                if self.m_callback then
                    self.m_data.IsSelect = true
                    self.m_callback(self.m_data)
                end
            end
        end)
    else
        if self.m_callback then
            self.m_data.IsSelect = true
            self.m_callback(self.m_data)
        end
    end
end

function M:SetCallback(callback)
    self.m_callback = callback
end

return M
