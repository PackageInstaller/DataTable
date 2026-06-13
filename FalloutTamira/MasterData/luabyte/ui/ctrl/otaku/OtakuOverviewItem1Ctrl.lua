local OtakuOverviewItem1Ctrl = BaseClass("OtakuOverviewItem1Ctrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = OtakuOverviewItem1Ctrl


function M:Select()
    self._view.selectState:SetState(2)
end

function M:UnSelect()
    self._view.selectState:SetState(1)
end

function M:OpenPanel(index, data, clickCallBack)
    self.m_Index = index
    self.m_Data = data
    self.m_CallBack = clickCallBack
    self:_RefreshItem()
    self:UnSelect()
    self:ShowPanel()
end

function M:Refresh()
    self.m_Data = OtakuRoomDataMgr:GetInstance():RoomDataByRoomId(self.m_Data:RoomId())
    self:_RefreshItem()
end

function M:_RefreshItem()
    self:_SetRoomInfo()
    self:_SetLiveSpace()
end

function M:_SetRoomInfo()
    local name = ConfigHelper.GetLocalString(self.m_Data:Name())
   
    if self.m_Data:Type() ~= OtakuType.OtakuRoomType.EST_Bridge then
        name = name .. string.format("%02d", self.m_Data:RoomIndex())
    end
   
    self._view.nameText:SetText(name)
    self._view.numText:SetText(tostring(self.m_Data:CurRoleLiveNum()))
    self._view.maxText:SetText("/" .. tostring(self.m_Data:RoleDeployMaxNum()))
    self._view.icon:SetPic(self.m_Data:Icon())
end

function M:_SetLiveSpace()
    local liveSpace = self.m_Data:LiveSpace()

    for i,v in ipairs(liveSpace) do
        local item = self.m_LiveSpace[i]

        if not item then
            item = self._view.liveSpace:Instantiate()
            self.m_LiveSpace[#self.m_LiveSpace + 1] = item
            item:ShowPanel()
        end

        v.curSettleType = self.m_Data:SettleType()
        item:Update(i, v, Bind(self, self._OnItemSelectClick))
    end
end

function M:Init()
    self.m_CurIndex = 1
    self.m_LiveSpace = {}
    self._view.clickBtn:onClick(Bind(self, self._OnItemClick))
end

function M:_OnItemSelectClick(index)
    self.m_CurIndex = index
end

function M:_OnItemClick()
    self.m_CallBack(self.m_Data:RoomId(), self.m_Data:Type(), self.m_Data:LiveSpace())
end

function M:OnDispose()
    for i,v in ipairs(self.m_LiveSpace) do
        v:OnDispose()
    end
    M.super.OnDispose(self)

    self.clickCallBack = nil
    self.m_Index = nil
    self.m_Data = nil
    self.m_Items = {}
end

return OtakuOverviewItem1Ctrl
