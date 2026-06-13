--OtakuemployeeOverviewUI_new
local OtakuOverviewMainCtrl = BaseClass("OtakuOverviewMainCtrl", BaseUICtrl)
local M = OtakuOverviewMainCtrl
local OtakuRoomType = OtakuType.OtakuRoomType

function M:OnEnter()
    self.m_Rooms = OtakuRoomDataMgr:GetInstance():RoomDatas()
    self:_Refresh()
end

--点击设置退出键【关闭带顶栏的Normal窗口】
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:_Refresh()
    self._view.listPanel:OpenPanel(self.m_Rooms, Bind(self, self._OnItemClick))
    self._view.infoPanel:OpenPanel()
end

function M:_OnItemClick(roomId, type, liveSpace)
    self._view.infoPanel:Update(roomId, type, liveSpace)
end

function M:Init()
    self.m_SettleUpgradeEvent = EventMgr:AddListener(UIMessageNames.OTAKU_SETTLE_UPDATE,
        Bind(self, self.OnSettleUpdateEvent))
end

function M:OnSettleUpdateEvent(roomId)
    local roomData = OtakuRoomDataMgr:GetInstance():RoomDataByRoomId(roomId)
    self._view.listPanel:Refresh(roomId)
    self._view.infoPanel:OpenPanel()
    self._view.infoPanel:Refresh(roomId, roomData:Type(), roomData:LiveSpace())
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.OTAKU_SETTLE_UPDATE, self.m_SettleUpgradeEvent)
    self.m_Rooms = nil
    M.super.OnDispose(self)
end

return OtakuOverviewMainCtrl
