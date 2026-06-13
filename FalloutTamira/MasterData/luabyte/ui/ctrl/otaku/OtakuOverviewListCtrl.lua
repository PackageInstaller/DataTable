local OtakuOverviewListCtrl = BaseClass("OtakuOverviewListCtrl", require("UI.Ctrl.Common.BaseSubCtrl"))
local M = OtakuOverviewListCtrl
local OtakuRoomType = OtakuType.OtakuRoomType

function M:Refresh(roomId)
    self.m_Items[roomId]:Refresh()
end

function M:OpenPanel(roomData, clickCallBack)
    self.m_CallBack = clickCallBack
    self:_MakeData(roomData)
    self:_RefreshList()
    self:_SelectDefaultRoom()
end

function M:_SelectDefaultRoom()
    local roomData = self.m_RoomDatas[1]
    self:_OnItemClick(roomData:RoomId(), roomData:Type(), roomData:LiveSpace())
end 

function M:_MakeData(roomData)
    self.m_RoomDatas = MapUtil.FilterValues(roomData, function (v)
        return v:Type() ~= OtakuRoomType.EST_Communication and 
               v:Type() ~= OtakuRoomType.EST_Dormitory and 
               v:Type() ~= OtakuRoomType.EST_Survey
    end)

    local otakuRoomTypeSort = OtakuType.OtakuRoomTypeSort
    table.sort( self.m_RoomDatas, function (v1, v2)
        local t1 = v1:Type()
        local t2 = v2:Type()
        local time1 = v1:BuildTick()
        local time2 = v2:BuildTick()
        local id1 = v1:RoomId()
        local id2 = v2:RoomId()

        if t1 ~= t2 then
            local index1 = MapUtil.FindKey(otakuRoomTypeSort, function (v) return v == t1 end)
            local index2 = MapUtil.FindKey(otakuRoomTypeSort, function (v) return v == t2 end)
            return index1 < index2
        end

        if time1 ~= time2 then
            return time1 < time2
        end

        return id1 < id2
    end )
end

function M:_RefreshList()
    for i,v in ipairs(self.m_RoomDatas) do
        if v:Type() == OtakuRoomType.EST_Canteen then
            self:_SetItem2(i, v)
        else
            self:_SetItem1(i, v)
        end
    end
end

function M:_SetItem1(index, v)
    local item = self._view.item1:Instantiate()
    item:OpenPanel(index, v, Bind(self, self._OnItemClick))
    self.m_Items[v:RoomId()] = item
end

--设置餐厅逻辑
function M:_SetItem2(index, v)
    local item = self._view.item2:Instantiate()
    item:OpenPanel(index, v, Bind(self, self._OnItemClick))
    self.m_Items[v:RoomId()] = item
end

--设置训练室逻辑
function M:_SetItem3(index, v)
    local item = self._view.item3:Instantiate()
    item:OpenPanel(index, v, Bind(self, self._OnItemClick))
    self.m_Items[v:RoomId()] = item
end

function M:_OnItemClick(roomId, type, liveSpace)
    self.m_CallBack(roomId, type, liveSpace)
    
    if self.m_CurRoomId ~= 0 then
        self.m_Items[self.m_CurRoomId]:UnSelect()
    end

    self.m_Items[roomId]:Select()
    self.m_CurRoomId = roomId
end

function M:Init()
    self.m_Items = {}
    self.m_CurRoomId = 0
    self:ShowPanel()
end

function M:OnDispose()
    for i,v in pairs(self.m_Items) do
        v:OnDispose()
    end

    self.m_Items = {}
    self.m_RoomDatas = {}
    M.super.OnDispose(self)
end


return OtakuOverviewListCtrl
