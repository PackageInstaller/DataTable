local M = BaseClass("BridgeUICtrl", BaseUICtrl)

function M:Init()
    self.m_roomData = nil
    local ctrl = require("UI.Ctrl.Bridge.BridgeCabinItemCtrl")
    local view = require("UI.View.Bridge.BridgeCabinItemView")
    self._view.scrollCabin:Init(ctrl, view)
    self._view.rectSkill:onClick(Bind(self, self.OnSkillClick))
    self._view.ctrlTitle:SetChangedCallback(Bind(self, self.OnUpgradeCallback))
end

function M:OnDispose()
    self.m_roomData = nil
    M.super.OnDispose(self)
end

function M:OnEnter(roomData)
    GameHelper.DoPlayerAction(PlayerAction.OpenBridge)

    self.m_roomData = roomData
    self._view.ctrlTitle:Init(roomData)
    self._view.ctrlSettle:Init(roomData)
    self:_UpdateCabinList()
end

--点击设置退出键【关闭带顶栏的Normal窗口】
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:_UpdateCabinList()
    local data = self.m_roomData:GetCabinData()
    self._view.scrollCabin:SetDataList(data)
end

function M:OnUpgradeCallback()
    self:_UpdateCabinList()
    self._view.ctrlSettle:UpdateSettle()
end

function M:OnSkillClick()
    UIContextMgr:GetInstance():Show("BridgeCmdSkill")
end

return M
