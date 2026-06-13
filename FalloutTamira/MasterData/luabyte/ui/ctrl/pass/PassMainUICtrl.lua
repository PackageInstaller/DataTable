local M = BaseClass("PassMainUICtrl", BaseUICtrl)

function M:Init()
    local names = {
        ConfigHelper.GetLocalString(44001),
        ConfigHelper.GetLocalString(44004),
        ConfigHelper.GetLocalString(44005),
    }
    local icons = {
        "UI/SpritePics/pass/ui_pass_icon_1.png",
        "UI/SpritePics/pass/ui_pass_icon_2.png",
        "UI/SpritePics/pass/ui_pass_icon_3.png",
    }
    self.m_tabIdx = 0
    self.m_curLevel = 1
    self.m_closeTimer = nil
    local itemId = GameHelper.GetParamter(328)
    local selectHandler = Bind(self, self.OnTabChanged)
    local updHandler = Bind(self, self.OnUpdatePassInfo)
    self.m_maxLevel = PassDataMgr:GetInstance():GetMaxLevel()
    self._view.btn_buyLevel:onClick(Bind(self, self.OnClickBuyLevel))
    self.m_itemTag = ItemDataMgr:GetInstance():AddItemChange(itemId, updHandler)
    self._view.tabMain:InitIconItems(self.m_tabIdx, names, icons, selectHandler)
    self._view.passMain:SetQuickShopCallback(function() self._view.tabMain:TabSelect(2) end)
    self.m_onChangedEvent = EventMgr:AddListener(UIMessageNames.PASS_INFO_CHANGED, updHandler)
end

function M:OnEnter(tabIdx)
    self.m_tabIdx = tabIdx or 0
    self:OnUpdatePassInfo()
end

function M:OnVisible()
    --用来解决领取完通行证奖励后 客户端数据刷新不及时 获取红点仍然显示问题
    IRedPointMgr:ForceCheck(RedPointConst.PassCardRewardRedPointChecker)
end

--设置退出时调用，返回TRUE则为拦截底层逻辑
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnClose()
    if self.m_closeTimer then self.m_closeTimer:Stop() end
    ItemDataMgr:GetInstance():RemoveItemChangeByTag(self.m_itemTag)
    EventMgr:RemoveListener(UIMessageNames.PASS_INFO_CHANGED, self.m_onChangedEvent)
    self.m_tabIdx = nil
    self.m_itemTag = nil
    self.m_curLevel = nil
    self.m_maxLevel = nil
    self.m_closeTimer = nil
    self.m_onChangedEvent = nil
    self._view.tabMain:DisposeAll()
end

-- 购买等级
function M:OnClickBuyLevel(go)
    UIContextMgr:GetInstance():Show("PassLevelPopupUI")
end

function M:OnTabChanged(idx)
    self.m_tabIdx = idx
    self:_UpdateActivityTime()
    self._view.passMain:SetPanelState(idx == 0)
    self._view.passTask:SetPanelState(idx == 1)
    self._view.passShop:SetPanelState(idx == 2)
end

function M:OnUpdatePassInfo()
    self:_UpdateExpAndLevel()
    self._view.tabMain:TabSelect(self.m_tabIdx)
end

function M:_UpdateExpAndLevel()
    self.m_curLevel = PassDataMgr:GetInstance():GetPassLevel()
    self._view.txt_passLv:SetText(tostring(self.m_curLevel))
    if self.m_curLevel >= self.m_maxLevel then
        self._view.expState:SetState(2) -- 满级
    else
        self._view.expState:SetState(1)
        local pass = PassDataMgr:GetInstance():GetPassCfgByLevel(self.m_curLevel)
        if pass then
            local maxPoint = pass.levelPoint
            local curSumPoint = PassDataMgr:GetInstance():GetPassPoint()
            local prevSumPoint = pass.upgradePoint - maxPoint
            local curPoint = math.min(maxPoint, math.max(0, curSumPoint - prevSumPoint))
            local progress = curPoint / maxPoint
            local expStr = string.format("%d/%d", curPoint, maxPoint)
            self._view.txt_expValue:SetText(expStr)
            self._view.slider_exp:SetValue(progress)
        else
            Logger.LogError("pass is nil. level = " .. self.m_curLevel)
        end
    end
end

function M:_UpdateActivityTime()
    local actId
    if self.m_tabIdx == 1 then
        actId = PassDataMgr:GetInstance():GetTaskActivityId()
    elseif self.m_tabIdx == 2 then
        actId = PassDataMgr:GetInstance():GetShopActivityId()
    else
        actId = PassDataMgr:GetInstance():GetActivityId()
    end
    local _, endTime = ActivityDataMgr:GetInstance():GetActivityTime(actId)
    self._view.txt_remainTime:SetText(TimeUtil.GetTimeFormat(endTime, "%y/%m/%d %H:%M:%S"))
    local curTime = TimeUtil.GetNowTimeStamp()
    local remain = math.max(0, endTime - curTime)
    if self.m_closeTimer then self.m_closeTimer:Stop() end
    self.m_closeTimer = TimerManager:GetInstance():GetTimer(remain, Bind(self, self.Close), self, true, nil, true)
    self.m_closeTimer:Start()
end

return M
