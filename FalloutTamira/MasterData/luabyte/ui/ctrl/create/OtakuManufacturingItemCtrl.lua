local M = BaseClass("OtakuManufacturingItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self.m_data = nil
    self.m_makeItemId = 0
    self.m_callback = nil
    self.m_makeTimer = nil
    self.m_setTimeFunc = nil
    self.m_stopTime = 0 -- 战员饱食度归零时间
    self.m_makeDuration = 0 -- 走了多长时间
    self._view.item:EnableClick(true)
    self._view.item.onClick = Bind(self, self.OnClickItem)
    self.m_makeHandler = Bind(self, self.OnUpdateMakeCountdown)
    self._view.item:EnablePress(true, Bind(self, self.OnPressItem))
    self.m_onSettleUpdate = EventMgr:AddListener(UIMessageNames.OTAKU_SETTLE_UPDATE, Bind(self, self.OnSettleUpdateEvent))
end

function M:UpdateItem(data)
    if not data then return end
    self.m_data = data
    self.m_roomData = self.m_data.RoomData
    self._view.item:Select(self.m_data.IsSelect)

    self:_StopTimer()
    self:_UpdateUseUpTime()
    local makeItem = self.m_data.Config
    if self.m_data.RoomData then
        -- 制造中
        self._view.uiState:SetState(3)
        self:_UpdateMakeTime()
    else
        self.m_makeDuration = 0
        if self.m_data.Unlock then
            -- 已解锁，未制造
            self._view.uiState:SetState(1)
        else
            -- 未解锁
            local str = ConfigHelper.GetLocalString(5549) --%d级解锁
            local tips = string.format(str, makeItem.houseLimit)
            self._view.uiState:SetState(2)
            self._view.txt_lockTip:SetText(tips)
        end
    end
    self.m_makeItemId = makeItem.item
    self:OnUpdateMakeCountdown(true)
    self._view.item:SetInfo(self.m_makeItemId, ItemNumberType.TOTLE, makeItem.itemNum)
end

function M:OnClickItem(go)
    if not self.m_data.Unlock then return end

    if self.m_callback then
        self.m_callback(self.m_data)
    end
end

function M:OnPressItem(go)
    GameHelper.PopItem(self.m_makeItemId, 0, self._view)
end

function M:SetSelectCallback(action, setTimeFunc)
    self.m_callback = action
    self.m_setTimeFunc = setTimeFunc
end

function M:OnDispose()
    self:_StopTimer()
    self.m_data = nil
    self.m_stopTime = nil
    self.m_callback = nil
    self.m_makeTimer = nil
    self.m_makeItemId = nil
    self.m_setTimeFunc = nil
    self.m_makeHandler = nil
    self.m_makeDuration = nil
    EventMgr:RemoveListener(UIMessageNames.OTAKU_SETTLE_UPDATE, self.m_onSettleUpdate)
    M.super.OnDispose(self)
end

-- 更新制造倒计时
function M:OnUpdateMakeCountdown(manual)
    if not self.m_roomData then return end

    local hasStop = self.m_stopTime > 0
    local curTime = TimeUtil.GetNowTimeStamp()
    if self.m_makeTimer then
        local isStop = hasStop and (curTime > self.m_stopTime)
        if isStop or (self.m_makeDuration <= 0) then self:_StopTimer() end
    end

    -- 更新当前房间正在制造道具的的时间
    local fmtTime = TimeUtil.SecToStringFormat(self.m_makeDuration)
    self._view.txt_time:SetText(fmtTime)

    if self.m_setTimeFunc then self.m_setTimeFunc(fmtTime, self.m_makeTimer == nil) end
    local nextTime = OtakuHelper.NextGetMakeItemTime(self.m_roomData)
    if (curTime >= nextTime) and (nextTime > 0) then
        -- 是否至少有一个制造完成的
        if (nextTime > self.m_stopTime) and hasStop then return end
        OtakuRoomDataMgr:GetInstance():RqStudioMakerAward(self.m_roomData:RoomId())
    end

    if not manual then self.m_makeDuration = self.m_makeDuration - 1 end
end

function M:OnSettleUpdateEvent(roomId)
    if not self.m_roomData then return end

    if self.m_roomData:RoomId() == roomId then
        self:_StopTimer()
        self:_UpdateUseUpTime()
        self:_UpdateMakeTime()
        self:OnUpdateMakeCountdown(true)
    end
end

function M:_UpdateMakeTime()
    local remainTime = OtakuHelper.GetMakeDuration(self.m_roomData)
    local curEater = self.m_roomData:SettleRolesEater()
    local ticTime = self.m_roomData:CalculateTick()
    local nowTime = TimeUtil.GetNowTimeStamp()
    local overTime = ticTime + remainTime
    local isStop = (self.m_stopTime > 0) and (self.m_stopTime <= nowTime)
    local curTime = isStop and self.m_stopTime or nowTime
    self.m_makeDuration = math.max(0, overTime - curTime)
    Logger.Log(string.format("剩余秒数：%d  当前时间：%d", remainTime, nowTime))
    if isStop or (curEater <= 0) then return end
    self.m_makeTimer = TimerManager:GetInstance():GetTimer(1, self.m_makeHandler, nil, false, nil, true)
    self.m_makeTimer:Start()
end

-- 更新战员饱食度归零时间
function M:_UpdateUseUpTime()
    if self.m_roomData then
        self.m_stopTime = self.m_roomData:TerminalTick()
    else
        self.m_stopTime = 0
    end
end

function M:_StopTimer()
    if self.m_makeTimer then
        self.m_makeTimer:Stop()
        self.m_makeTimer = nil
    end
end

return M
