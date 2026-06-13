local M = BaseClass("OtakuChooseHeroUIContext", BaseContext)
local DeployState = OtakuType.DeployHeroState


function M:Open(roomId, curSettleType, position)
    local roomData = OtakuRoomDataMgr:GetInstance():RoomDataByRoomId(roomId)
    self:_InitHeroData(roomData, curSettleType, position)
    self:_SortData(curSettleType, roomData, position)
    self:_Show(roomData, self.m_ChooseHeroData, position, curSettleType, self.deployMaxNum)
end

function M:_InitHeroData(roomData, curSettleType, position)
    --最大可入驻数量
    self.deployMaxNum = roomData:RoleDeployMaxNum()
    self.m_ChooseHeroData = {}

    local heroList = IHeroDataMgr:GetHeros()
    local count = heroList.Count

    for i = 0, count - 1 do
        local baseData = {}
        baseData.roomId = roomData:RoomId()
        baseData.roomType = roomData:Type()
        baseData.heroData = heroList[i]
        baseData.heroId = heroList[i]:GetHeroId()
        baseData.select = false
        baseData.position = -1
        baseData.roleStudioHeroData = IRoleStudioHeroDataMgr:GetRoleStudioDataById(baseData.heroId)

        local otherSettleType, otherRoomData = OtakuRoomDataMgr:GetInstance():GetDeployRoomTypeByHeroId(baseData.heroId)
        baseData.curSettleType = curSettleType
        baseData.state = otherSettleType and DeployState.CurCabin or DeployState.Idle
        baseData.otherRoomId = otherSettleType and otherRoomData:RoomId() or baseData.roomId

        if baseData.state == DeployState.CurCabin and
            (otherSettleType.LiveType ~= curSettleType or baseData.roomId ~= baseData.otherRoomId) then
            baseData.state = DeployState.OtherCabin
        end

        if otherSettleType then
            baseData.curRoomName = roomData:Name()
            baseData.otherRoomName = otherRoomData:Name()
            baseData.otherRoomIndex = otherRoomData:RoomIndex()
            baseData.position = otherSettleType.Position
        end

        if baseData.state == DeployState.CurCabin then
            baseData.select = true
        end
        self.m_ChooseHeroData[#self.m_ChooseHeroData + 1] = baseData
        
    end
end

function M:_SortData(curSettleType)
    self:_OtherSort(curSettleType)
end

-- 其他排序
function M:_OtherSort(curSettleType)
    --[[    By: DuSir
舰桥中心&制造舱&餐厅：厨娘&餐厅：服务员&合成舱		
1.已选中＞未选中且未在其他舱室入驻及饱食度大于0＞未选中且已在其他舱室入驻及饱食度大于0＞饱食度为0战员		
2.舰桥中心内相同状态按照hero表字段order1由小到大进行排序，相同order按照英雄品质，相同品质按照heroid由小到大		
3.制造舱内相同状态按照hero表字段order2由小到大进行排序，相同order按照英雄品质，相同品质按照heroid由小到大		
4.餐厅：厨娘内相同状态按照hero表字段order4由小到大进行排序，相同order按照英雄品质，相同品质按照heroid由小到大		
5.合成舱内相同状态按照hero表新增字段order5由小到大进行排序，相同order按照英雄品质，相同品质按照heroid由小到大		
6.餐厅：服务员内相同状态按照hero表新增字段order6由小到大进行排序，相同order按照英雄品质，相同品质按照heroid由小到大
]]
    local orderName = self:_GetOrderName(curSettleType)
    table.sort(self.m_ChooseHeroData, function(v1, v2)
        local e1 = v1.roleStudioHeroData:GetEater()
        local e2 = v2.roleStudioHeroData:GetEater()

        local s1 = v1.state == DeployState.CurCabin
        local s2 = v2.state == DeployState.CurCabin
        if s1 or s2 then
            if s1 and s2 then
                self:_SortSameStatus(v1.heroData, v2.heroData, orderName)
            else
                return v1.state > v2.state
            end
        else
            if (e1 > 0) and (e2 > 0) then
                if v1.state == v2.state then
                    return self:_SortSameStatus(v1.heroData, v2.heroData, orderName)
                else
                    return v1.state < v2.state
                end
            else
                return e1 > e2
            end
        end
    end)
end

-- order参数
function M:_GetOrderName(curSettleType)
    local name = "order1"
    if curSettleType == OtakuType.RoomStateLiveType.Bridge then
        name = "order1"
    elseif curSettleType == OtakuType.RoomStateLiveType.Produce then
        name = "order2"
    elseif curSettleType == OtakuType.RoomStateLiveType.Compound then
        name = "order5"
    elseif curSettleType == OtakuType.RoomStateLiveType.Cook then
        name = "order4"
    elseif curSettleType == OtakuType.RoomStateLiveType.DiningTable then
        name = "order6"
    end
    return name
end

function M:_SortSameStatus(hd1, hd2, orderName)
    local o1 = hd1:GetHeroCfg()[orderName]
    local o2 = hd2:GetHeroCfg()[orderName]
    if o1 == o2 then
        local q1 = hd1:Rare()
        local q2 = hd2:Rare()
        if q1 == q2 then
            local id1 = hd1:GetHeroId()
            local id2 = hd2:GetHeroId()
            return id1 < id2
        else
            return q1 < q2
        end
    else
        return o1 < o2
    end
end

return M
