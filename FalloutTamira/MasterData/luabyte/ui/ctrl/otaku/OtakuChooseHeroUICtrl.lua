local M = BaseClass("OtakuChooseHeroUICtrl", BaseUICtrl)
local DeployHeroState = OtakuType.DeployHeroState
local RoomStateLiveType = OtakuType.RoomStateLiveType

function M:Init()
    self.m_Items = {}
    self._view.rectClose:onClick(Bind(self, self.ClosePanel))
    self._view.btnConfirm:onClick(Bind(self, self.ClickConfirm))
    self._view.btnClear:onClick(Bind(self, self.ClickClear))
    self._settleUpdateEvent = EventMgr:AddListener(UIMessageNames.OTAKU_SETTLE_UPDATE,
        Bind(self, self.OnSettleUpdateEvent))
    self._selectUpdateEvent = EventMgr:AddListener(UIMessageNames.OTAKU_SETTLE_SELECT_HERO,
        Bind(self, self.UpdateSelectList))
    self.selectHeros = {}
    self.curCabinHeros = {}
    self.pos = {}
end

function M:OnDispose()
    self.selectHeros = {}
    self.curCabinHeros = {}
    self.pos = {}
    EventMgr:RemoveListener(UIMessageNames.OTAKU_SETTLE_UPDATE, self._settleUpdateEvent)
    EventMgr:RemoveListener(UIMessageNames.OTAKU_SETTLE_SELECT_HERO, self._selectUpdateEvent)
    M.super.OnDispose(self)
end

function M:OnEnter(roomData, data, position, curSettleType, deployMaxNum)
    self.m_RoomData = roomData
    self.m_RoomId = roomData:RoomId()
    self.m_ChooseHeroData = data
    self.m_Position = position
    self.m_CurSettleType = curSettleType
    self.m_DeployMaxNum = deployMaxNum
    self:_UpdateItems()
    for i = 1, self.m_DeployMaxNum do
        table.insert(self.pos, i)
    end
end

--点击设置退出键【关闭带顶栏的popup窗口】
function M:OnDeviceBack()
    self:Close()
    return true 
end

function M:_UpdateItems()
    for i, v in ipairs(self.m_ChooseHeroData) do
        local item = self.m_Items[i]

        if not item then
            item = self._view.item:Instantiate()
            self.m_Items[#self.m_Items + 1] = item
        end



        item:UpdateItem(v, self.m_Position, self)
        item:ShowPanel()

        if v.state == DeployHeroState.CurCabin then
            table.insert(self.curCabinHeros, v)
        end

        if v.select then
            self:UpdateSelectList(item, true)
        end
    end
end

function M:OnSettleUpdateEvent(roomId)
    if self.m_RoomId ~= roomId then
        return
    end

    for i, v in ipairs(self.m_ChooseHeroData) do
        local state = OtakuType.DeployHeroState.Idle
        local heroId = v.heroId
        local otherSettleType, roomData = OtakuRoomDataMgr:GetInstance():GetDeployRoomTypeByHeroId(heroId)
        local roomName, roomIndex = 0, 0
        if otherSettleType then
            state = (otherSettleType.LiveType == v.curSettleType and v.roomId == roomData:RoomId()) and
                OtakuType.DeployHeroState.CurCabin or OtakuType.DeployHeroState.OtherCabin
            roomName = roomData:Name()
            roomIndex = roomData:RoomIndex()
            v.otherSettleType = otherSettleType.LiveType
        end

        v.state = state
        v.otherRoomName = roomName
        v.otherRoomIndex = roomIndex
    end
    self:_UpdateItems()
end

function M:ClosePanel()
    OtakuRoomDataMgr:GetInstance():UpdateSettleSelectByRoomId(self.m_RoomId)
    EventMgr:Broadcast(UIMessageNames.OTAKU_SETTLE_SELECT_UPDATE, self.m_RoomId)
    self:Close()
end

function M:ClickConfirm()
    local beforePos = DeepCopy(self.pos)
    local info = {}
    local otherInfo = {}
    table.sort(self.selectHeros, function(v1, v2)
        local p1 = v1._data.position
        local p2 = v2._data.position
        return p1 > p2
    end)
    for i, v in pairs(self.selectHeros) do
         --战员在其他舱室
         if v._data.state == DeployHeroState.OtherCabin then
            local data = {
                HeroId = v._data.heroId,
                otherRoomName = v._data.otherRoomName
            }
            table.insert(otherInfo, data)
        end       

        --厨娘，打扫特殊处理
        if self.m_CurSettleType == RoomStateLiveType.DiningTable or self.m_CurSettleType == RoomStateLiveType.Cook then
            local data = {
                HeroId = v._data.heroId,
                Position = 1
            }
            table.insert(info, data)
            break
        end

        local data = {
            HeroId = v._data.heroId,
            Position = self:GetHeroPosition(v)
        }
        table.insert(info, data)
    end
    if #info == 0 then
        local pos = {}
        for i, v in pairs(self.curCabinHeros) do
            table.insert(pos, v.position)
        end
        if #pos > 0 then
            OtakuRoomDataMgr:GetInstance():RequestCancelGarrisonStudio(self.m_RoomId, self.m_CurSettleType, pos,
                Bind(self, self.ClosePanel))
        else
            self:ClosePanel()
        end
    else
        local isEqual = self:CheckHero(info)
        if #otherInfo > 0 then
            UIContextMgr:GetInstance():Show("OtakuSettleExchangeView", self.m_RoomData:Name(), otherInfo, function()
                OtakuRoomDataMgr:GetInstance():RequestGarrisonStudio(self.m_RoomId, self.m_CurSettleType, info, true,
                    Bind(self, self.ClosePanel))
            end, function()
                self.pos = beforePos
            end)
        else
            if isEqual == false then
                OtakuRoomDataMgr:GetInstance():RequestGarrisonStudio(self.m_RoomId, self.m_CurSettleType, info, true,
                    Bind(self, self.ClosePanel))
            else
                self:ClosePanel()
            end
        end

    end
end

--获取英雄位置
function M:GetHeroPosition(value)
    local position = -1
    if value._data.position == -1 or value._data.state == DeployHeroState.OtherCabin then
        position = self.pos[1]
        table.remove(self.pos, 1)
    else
        local index = 0
        for k, v in pairs(self.pos) do
            if v == value._data.position then
                index = k
                break
            end
        end
        --删除判空
        if index > 0 then 
            table.remove(self.pos, index)
        end
        
        position = value._data.position
    end 
    return position
end

function M:CheckHero(heroInfo)
    if #heroInfo == #self.curCabinHeros then
        local isEqual = false
        for index, value in pairs(self.curCabinHeros) do
            local inClude = false
            for key, info in pairs(heroInfo) do
                if info.HeroId == value.heroId then
                    inClude = true
                end
            end
            if inClude == false then
                return false
            else
                isEqual = inClude
            end 
        end
        return isEqual
    end
    return false
end

function M:ClickClear()
    for i, v in pairs(self.selectHeros) do
        v._view.SelectState:SetState(1)
    end
    self.selectHeros = {}
end

function M:UpdateSelectList(item, isAdd)
    --新增操作
    if isAdd then
        if #self.selectHeros >= self.m_DeployMaxNum then
            if self.selectHeros[1] then
                self.selectHeros[1]._data.select = false
                self.selectHeros[1]._view.SelectState:SetState(1)
                table.remove(self.selectHeros, 1)
            end
        end
        --其他舱室战员位置重置
        if item._data.state == DeployHeroState.OtherCabin then
            item._data.position = -1
        end
        table.insert(self.selectHeros, item)
    else
        local index = 1
        for i, v in pairs(self.selectHeros) do
            if v._data.heroId == item._data.heroId then
                index = i
                local value = table.indexof(self.pos, v._data.position)
                if value == false and v._data.position > -1 then
                    table.insert(self.pos, v._data.position)
                end
                break
            end
        end
        table.remove(self.selectHeros, index)
    end
end

function M:OnDeviceBack()
    self:Close()
    return true
end

return M
