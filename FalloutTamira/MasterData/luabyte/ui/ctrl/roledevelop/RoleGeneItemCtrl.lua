local RoleGeneItemCtrl = BaseClass("RoleGeneItemCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = RoleGeneItemCtrl

function M:Init()
    self.bgPath = "UI/SpritePics/develop/gena/ui_develop_gena_icon_bg_"
    self.m_StarItems = {}
    self._view:onClick(Bind(self, self._OnItemClick))
    self:ShowPanel()
end

function M:SetSelect(state)
    self._view.tfSelect:SetActive(state)
end

function M:UpdateActive()
    self.m_IsActive = false
end

function M:UpStar()
    self.m_IsActive = true
    self._star = self._star + 1
    self:_SetStar()
end

function M:Update(heroId, cfg, star, isActive, callback)
    self.m_Cfg = cfg
    self._star = star
    self.m_CallBack = callback
    self.m_IsActive = isActive

    self:_SetStar()
    self._view.icon:SetPic(self.m_Cfg.icon)
    self._view.redPoint:SetParam(0, heroId)
    self._view.redPoint:Check()
    self:SetSelect(false)
end



function M:_SetStar()
    for i = 1, self._star do
        local item = self.m_StarItems[i]

        if not item then
            item = self._view.star:Instantiate()
            self.m_StarItems[#self.m_StarItems + 1] = item
        end

        item:SetActive(true)
    end
    for i = self._star + 1, #self.m_StarItems do
        self.m_StarItems[i]:SetActive(false)
    end
    self._view.imgBg:SetPic(self.bgPath .. self._star)
end

function M:_OnItemClick()
    if self.m_CallBack then
        self.m_CallBack(self.m_Cfg, self._star)
    end
end

return RoleGeneItemCtrl
