local M = BaseClass("OtakuManufacturingTabItemCtrl")

function M:__init(view)
    self._view = view
    self.m_index = 0
    self.m_roomData = nil
    self.m_selectAction = nil
    self._view.btn_mask:onClick(Bind(self, self.OnClickMask))
    self.m_onBridgeUpgrade = EventMgr:AddListener(UIMessageNames.OTAKU_UPGRADE, Bind(self, self.OnBridgeUpgradeEvent))
    self.m_onSettleUpdate = EventMgr:AddListener(UIMessageNames.OTAKU_SETTLE_UPDATE, Bind(self, self.OnSettleUpdateEvent))
end

function M:OnDispose()
    self.m_index = nil
    self.m_roomData = nil
    self.m_isSelect = false
    self.m_selectAction = nil
    EventMgr:RemoveListener(UIMessageNames.OTAKU_UPGRADE, self.m_onBridgeUpgrade)
    EventMgr:RemoveListener(UIMessageNames.OTAKU_SETTLE_UPDATE, self.m_onSettleUpdate)
    if self._view then self._view:OnDispose() end
    self._view = nil
end

function M:OnBridgeUpgradeEvent(roomId)
    if not self.m_roomData then return end

    if self.m_roomData:RoomId() == roomId then
        self:_UpdateDotsBar()
    end
end

function M:OnSettleUpdateEvent(roomId)
    if not self.m_roomData then return end

    if self.m_roomData:RoomId() == roomId then
        self:_UpdateSettleNum()
    end
end

function M:OnClickMask(go)
    if self.m_isSelect then return end

    if not self.m_roomData then
        GameHelper.TipsById(5580) -- 未建造制造舱
        return
    end

    self:UpdateTab(self.m_index)
end

function M:InitTabItems(idx, roomData, title, iconPath, callback)
    self.m_index = idx
    self.m_roomData = roomData
    self.m_selectAction = callback
    self._view.txt_normal:SetText(title)
    self._view.txt_select:SetText(title)
    self._view.img_normal:SetPic(iconPath)
    self._view.img_select:SetPic(iconPath)

    local isLock = self.m_roomData == nil
    self._view.lock:SetActive(isLock)
    self._view.barDots:SetActive(not isLock)
    self._view.roleNum:SetActive(not isLock)
    self._view.img_icon:SetActive(not isLock)
    self._view.img_normal:SetActive(not isLock)
    self._view.txt_normal:SetActive(not isLock)

    self:_UpdateDotsBar()
    self:_UpdateSettleNum()
end

function M:UpdateTab(idx)
    local state = self.m_index == idx
    if state and self.m_selectAction then
        self.m_selectAction(self.m_index)
    end
end

function M:UpdateState(isOn)
    self.m_isSelect = isOn
    self._view.select:SetActive(self.m_isSelect)
    self._view.normal:SetActive(not self.m_isSelect)
end

function M:_UpdateDotsBar()
    if not self.m_roomData then return end

    local level = self.m_roomData:Level()
    local maxLevel = self.m_roomData:MaxLevel()
    self._view.barDots:Update(level, maxLevel)
end

function M:_UpdateSettleNum()
    if not self.m_roomData then return end

    local curNmu = self.m_roomData:CurRoleLiveNum()
    local maxDeployNum = self.m_roomData:RoleDeployMaxNum()
    self._view.txt_roleNum:SetText(tostring(curNmu))
    self._view.txt_totalNum:SetText(tostring(maxDeployNum))
    self._view.roleNum:SetState((curNmu == 0) and 2 or 1)
end

return M
