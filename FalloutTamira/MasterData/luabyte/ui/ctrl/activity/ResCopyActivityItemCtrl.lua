local M = BaseClass("ResCopyActivityItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self.m_tipsId = 0
    self.m_itemIcons = { self._view.img_icon }
    self._view.btn_leave:onClick(Bind(self, self.OnClickLeave))
end

function M:OnDispose()
    for _, v in ipairs(self.m_itemIcons) do v:OnDestroy() end
    self.m_itemIcons = nil
    self.m_tipsId = nil
    M.super.OnDispose(self)
end

function M:UpdateItem(data)
    if data == nil then return end
    local roleAct = data.RoleAct
    self.m_chapter = data.Chapter
    local maxCount = data.LimitTimes
    local tick = roleAct and roleAct.Value1 or 0
    local isToday = TimeUtil.IsToday(tick, TimeUtil.DailyRefreshTime)
    local curCount = isToday and roleAct.Value0 or 0
    self._view.txt_lValue:SetText(tostring(curCount))
    self._view.txt_rValue:SetText(tostring(maxCount))
    self._view.txt_label:SetText(self.m_chapter.name)
    self._view.uiState:SetState(curCount < maxCount and 1 or 2)
    self:_CheckUnlockState()
    self:_ShowChapterRewards()
end

function M:OnClickLeave(go)
    if self.m_tipsId > 0 then
        GameHelper.TipsById(self.m_tipsId)
    else
        -- 活动期间所有资源本不受星期条件限制，全部开放。（但仍受基础的关卡进度限制）
        JumpMgr:GetInstance():Execute(100, EnumConst.EBattleStyle.Normal, self.m_chapter)
    end
end

function M:_ShowChapterRewards()
    local groupId = self.m_chapter.chapterReward
    local group = ConfigHelper.GetCfgByLua("itemGroup", groupId)
    local len = group and #group.items or 0
    if len > 0 then
        for i, itemId in ipairs(group and group.items or {}) do
            local icon = self.m_itemIcons[i]
            if not icon then
                icon = self._view.img_icon:Instantiate()
                table.insert(self.m_itemIcons, icon)
            end
            icon:SetItemIcon(itemId)
            icon:SetActive(true)
        end
        for i = len + 1, #self.m_itemIcons do
            self.m_itemIcons[i]:SetActive(false)
        end
    else
        for _, v in ipairs(self.m_itemIcons) do v:SetActive(false) end
    end
end

function M:_CheckUnlockState()
    local lockId = GameHelper.CSGetFirstLockReason(self.m_chapter.openCondition)
    if lockId > 0 then -- 未解锁
        local openCfg = ConfigHelper.GetCfgByLua("openCondition", lockId)
        if openCfg then
            self.m_tipsId = openCfg.tips
        else
            self.m_tipsId = 5864
            Logger.LogError("openCondition is nil, id = " .. tostring(lockId))
        end
    else
        self.m_tipsId = 0
    end
end

return M
