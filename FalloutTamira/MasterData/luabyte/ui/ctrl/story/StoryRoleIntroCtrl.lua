local M = BaseClass("StoryRoleIntroCtrl", BaseUICtrl)

function M:Init()
    self._view.btn_mask:onClick(Bind(self, self.OnClickMask))
end

function M:OnEnter(storyCfg)
    local roleName = storyCfg.roleName
    local drawPath = storyCfg.roleDrawing[1]
    self._view.img_role:SetPic(drawPath, true)
    self._view.img_roleMask:SetPic(drawPath, true)
    self._view.txt_name:SetText(roleName[1]) -- 名字
    self._view.txt_desc:SetText(roleName[4])
    self._view.txt_label1:SetText(roleName[2])
    self._view.txt_label2:SetText(roleName[3])
    if roleName[5] and roleName[6] then
        self._view.txt_label3:SetText(roleName[5])
        self._view.txt_label4:SetText(roleName[6])
        self._view.label2:SetActive(true)
    else
        self._view.label2:SetActive(false)
    end
    if roleName[7] and roleName[8] then
        self._view.txt_label5:SetText(roleName[7])
        self._view.txt_label6:SetText(roleName[8])
        self._view.label3:SetActive(true)
    else
        self._view.label3:SetActive(false)
    end
    local heroId = storyCfg.roleShow[1] or 0
    local heroData = IHeroDataMgr:GetHeroDataById(heroId)
    if heroData then
        local icon = "UI/SpritePics/nation/ui_icon_nation_%d"
        local faction = heroData:GetFaction() -- 阵营
        self._view.img_icon:SetPic(string.format(icon, faction))
    end
end

function M:OnClickMask(go)
    if self.m_tween then return end

    self._view.animator.enabled = false
    self.m_tween = self._view.canvasGroup:SetDoFade(0, 0.5):SetTweenUpdate(true):OnTweenComplete(function()
        self.m_tween = nil
        self:Close()
    end)
end

function M:OnClose()
    M.super.OnClose()
    StoryDataMgr:GetInstance():NextStory()
end

return M
