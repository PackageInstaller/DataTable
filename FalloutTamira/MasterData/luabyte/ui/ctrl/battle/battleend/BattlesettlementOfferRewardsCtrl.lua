local M = BaseClass("BattlesettlementOfferRewardsCtrl", BaseUICtrl)

function M:Init()
    self.m_isClose = false
    self.m_battleStyle = EnumConst.EBattleStyle.Reward
    self._view.btn_mask:onClick(Bind(self, self.OnClickClose))
    self.m_items = { self._view.entryItem1, self._view.entryItem2, self._view.entryItem3 }
end

function M:OnEnter(mission, datas, lv, exp)
    self.m_second = 10
    self._view.txt_name:SetText(mission.name)
    self._view.txt_second:SetText(self.m_second .. "S")
    self._view.roleCtrl:Refresh(self.m_battleStyle, mission)
    for i, entry in ipairs(datas) do self:_SetEntryInfo(i, entry) end

    if self.m_timer then self.m_timer:Stop() end
    local handler = Bind(self, self.OnTimerCallBack)
    self.m_timer = TimerManager:GetInstance():GetTimer(1, handler, self)
    self.m_timer:Start()

    local context = UIContextMgr:GetInstance():GetContext("MissionOfferRewards")
    local oldLv = context:GetWantedLevel()
    local oldExp = context:GetWantedExp()
    local curLvExp = context:GetLevelTotalExp(oldLv)
    local sumExp = 0
    for i = oldLv, lv - 1 do sumExp = sumExp + context:GetLevelTotalExp(i) end
    sumExp = (sumExp - oldExp) + exp
    self._view.txt_level:SetText(tostring(oldLv))
    self._view.txt_valueR:SetText(tostring(curLvExp))
    self.m_co = coroutine.start(function()
        local offset, sum = 0, 0
        for i = 0, sumExp do
            if self.m_isClose then break end
            sum = oldExp + (i - offset)
            if sum >= curLvExp then
                offset = offset + (curLvExp - oldExp) -- step:1
                oldExp = sum - curLvExp               -- step:2
                oldLv = oldLv + 1
                sum = 0
                curLvExp = context:GetLevelTotalExp(oldLv)
                self._view.txt_level:SetText(tostring(oldLv))
                self._view.txt_valueR:SetText(tostring(curLvExp))
            end
            self._view.txt_valueL:SetText(tostring(sum))
            self._view.img_fill:SetFillAmount(sum / curLvExp)
            coroutine.waitforseconds(0.03)
        end
        self.m_co = nil
    end)
end

function M:OnClose()
    self.m_isClose = true
    if self.m_timer then
        self.m_timer:Stop()
        self.m_timer = nil
    end

    if self.m_co then
        coroutine.stopwaiting(self.m_co)
        self.m_co = nil
    end

    M.super.OnClose(self)
end

function M:OnClickClose(go)
    -- 黑屏动画状态不可点击
    if self.m_second >= 9 then return end
    self:Close()
    UIContextMgr:GetInstance():GetContext("MissionOfferRewards"):BattleBack()
    ModuleMgr:GetInstance():ChangeModule(ModuleConfig.MainSceneModule.id)
end

function M:OnTimerCallBack()
    self.m_second = self.m_second - 1
    self._view.txt_second:SetText(self.m_second .. "S")
    if self.m_second < 0 then
        self:Close()
        UIContextMgr:GetInstance():GetContext("MissionOfferRewards"):BattleBack()
        ModuleMgr:GetInstance():ChangeModule(ModuleConfig.MainSceneModule.id)
    end
end

function M:_SetEntryInfo(idx, entry)
    local itemView = self.m_items[idx]
    if entry == nil then
        itemView:SetActive(false)
        return
    end
    itemView:SetActive(true)

    if entry.IsWin then
        itemView.uiState:SetState(4) -- 已完成
    else
        itemView.uiState:SetState(1) -- 未完成
    end

    local mcrandom = ConfigHelper.GetCfgByLua("mcrandom", entry.EntryId)
    if not mcrandom then
        Logger.LogError("mcrandom is nil, id = " .. entry.EntryId)
    else
        itemView.img_icon:SetPic(mcrandom.icon)
        itemView.txt_name:SetText(mcrandom.codename)
    end
end

return M
