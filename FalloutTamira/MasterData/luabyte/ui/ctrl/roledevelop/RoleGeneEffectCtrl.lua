local RoleGeneEffectCtrl = BaseClass("RoleGeneEffectCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = RoleGeneEffectCtrl


function M:SetActive(b)
    self._view:SetActive(b)
end

function M:Update(data, isOpen, star)
    local length = #data
    for i=1,length do
        local item = self.m_Effects[i]

        if not item then
            item = self._view.effectItem:Instantiate()
            self.m_Effects[#self.m_Effects + 1] = item
        end

        item.text:SetText(data[i]) 
        item.on:SetActive(isOpen)
        item:SetActive(true) 
    end

    local subCount = #self.m_Effects - length
    for i=1,subCount do
        local index = length + i
        self.m_Effects[index]:SetActive(false) 
    end

    self:_SetStar(star)
end

function M:_SetStar(star)
    for i,v in ipairs(self.m_Dots) do
        v:SetActive(false) 
    end

    for i=1,star do
        local item = self.m_Dots[i]

        if not item then
            item = self._view.dotItem:Instantiate()
            self.m_Dots[#self.m_Dots + 1] = item
        end

        item:SetActive(true) 
    end
end

function M:Init()
    self.m_Effects = {}
    self.m_Dots = {}
    self:ShowPanel()
end


return RoleGeneEffectCtrl
