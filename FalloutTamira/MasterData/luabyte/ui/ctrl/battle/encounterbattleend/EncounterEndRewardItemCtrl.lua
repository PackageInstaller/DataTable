local EncounterEndRewardItemCtrl = BaseClass("EncounterEndRewardItemCtrl",  require("UI.Ctrl.Common.BaseSubCtrl"))
local M = EncounterEndRewardItemCtrl


function M:Hide()
    self:HidePanel()
end

function M:OpenPanel(rewards)
    self:ShowPanel()
    self:_RefreshReward(rewards)
end

function M:_RefreshReward(rewards)
    local index = 0
    for k,v in pairs(rewards) do
        index = index + 1

        local item = self.m_Items[index]
        if not item then
            item = self._view.item:Instantiate()
            self.m_Items[#self.m_Items + 1] = item
        end

        item:SetActive(true)
        item.item:SetInfo(k, ItemNumberType.TOTLE, v)
    end

    if #self.m_Items > index then
        local length = #self.m_Items - index

        for i=1,length do
            self.m_Items[index + 1]:SetActive(false)
        end
    end
end

function M:Init()
    self.m_Items = {}
end


return M
