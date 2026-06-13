local M = BaseClass("OtakuTitleCtrl")

function M:__init(view)
    self._view = view
    self.m_roomData = nil
    self.m_changedCallback = nil
    self._view.rectUpgrade:onClick(Bind(self, self.OnUpgradeClick))
    local eventHandler = Bind(self, self.OnBridgeUpgradeEvent)
    self.m_onBridgeUpgrade = EventMgr:AddListener(UIMessageNames.OTAKU_UPGRADE, eventHandler)
    self.m_uiVisble = Bind(self, self.OnUIVisbleEvent)
    IGameEventMgr:RegisterEventHandleByTypeName("UIVisbleEvent", self.m_uiVisble)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.OTAKU_UPGRADE, self.m_onBridgeUpgrade)
    IGameEventMgr:UnRegisterEventHandleByTypeName("UIVisbleEvent", self.m_uiVisble)
    self.m_roomData = nil
    self.m_uiVisble = nil
    self.m_changedCallback = nil

    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:OnUpgradeClick()
    if self.m_roomData:Level() >= self.m_roomData:MaxLevel() then
        GameHelper.TipsById(4115)
        return
    end

    UIContextMgr:GetInstance():Show("OtakuUpgradeUI", self.m_roomData)
end

function M:OnBridgeUpgradeEvent(roomId)
    if self.m_roomData:RoomId() == roomId then
        self:_UpdateLevelAndDotsBar()
        if self.m_changedCallback then
            self.m_changedCallback()
        end
    end
end

function M:_InitNameAndIcon()
    local roomIdx = ""
    local roomType = self.m_roomData:Type()
    local maxRoomNum = OtakuRoomDataMgr:GetInstance():GetMaxRoomBuildNumByType(roomType)
    if maxRoomNum > 1 then roomIdx = string.format("%02d", self.m_roomData:RoomIndex()) end
    local roomName = ConfigHelper.GetLocalString(self.m_roomData:Name())
    self._view.txtName:SetText(roomName .. roomIdx)
    self._view.imgIcon:SetPic(self.m_roomData:Icon())
end

function M:_UpdateLevelAndDotsBar()
    local level = self.m_roomData:Level()
    local maxLevel = self.m_roomData:MaxLevel()
    self._view.txtLevel:SetText(tostring(level))

    if level >= maxLevel then
        -- 满级
        self._view.stateUpgrade:SetState(2)
    else
        if self.m_roomData:IsUpLevel() then
            -- 可升级
            self._view.stateUpgrade:SetState(3)
        else
            -- 等级没满
            self._view.stateUpgrade:SetState(1)
        end
    end

    self._view.barDots:Update(level, maxLevel)
end

function M:Init(roomData)
    self.m_roomData = roomData
    self:_InitNameAndIcon()
    self:_UpdateLevelAndDotsBar()
end

function M:SetChangedCallback(callback)
    self.m_changedCallback = callback
end

function M:OnUIVisbleEvent(evt)
    if not self.m_roomData or not evt.isShow then return end
    self:_UpdateLevelAndDotsBar()
end

return M
