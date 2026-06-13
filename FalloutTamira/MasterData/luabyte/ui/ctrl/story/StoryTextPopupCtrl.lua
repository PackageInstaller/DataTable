local M = BaseClass("StoryTextPopupCtrl", BaseUICtrl)

function M:Init()
    self.m_story = nil
    self.m_callback = nil
    self._view.btn_mask:onClick(Bind(self, self.Close))
    self._view.btn_confirm:onClick(Bind(self, self.OnClickConfirm))
end

function M:OnEnter(story, canGet, callback)
    self.m_story = story
    self.m_callback = callback
    self:_SetDesc(story.rewardDec)
    self:_SetBtnState(story.reward, canGet)
end

function M:OnClose()
    if self.m_callback then
        self.m_callback()
        self.m_callback = nil
    end
    self.m_story = nil
end

function M:OnClickConfirm(go)
    if not self.m_story then return end
    StoryDataMgr:GetInstance():CheckAndSendStoryReward(self.m_story, 1, Bind(self, self.Close))
end

function M:_SetDesc(rewardDec)
    local desc = ""
    for _, id in ipairs(rewardDec or {}) do
        local str = ConfigHelper.GetLocalString(id)
        desc = desc .. str .. "\n"
    end
    self._view.txt_desc:SetText(desc)
end

function M:_SetBtnState(reward, canGet)
    if canGet then
        for _, id in ipairs(reward or {}) do
            local itemGroup = ConfigHelper.GetCfgByLua("itemGroup", id)
            if itemGroup then
                for _, itemId in ipairs(itemGroup.items or {}) do
                    if ItemDataMgr:GetInstance():GetItemNumById(itemId) <= 0 then
                        self._view.uiState:SetState(1) -- 可领取
                        return
                    end
                end
            else
                Logger.LogError("itemGroup is nil, id = " .. id)
            end
        end
    end
    self._view.uiState:SetState(2) -- 已领取
end

return M
