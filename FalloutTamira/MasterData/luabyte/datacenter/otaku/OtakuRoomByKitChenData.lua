-- 厨房数据类
local BaseOtakuRoomData = require("DataCenter.Otaku.BaseOtakuRoomData")
local OtakuRoomByKitChenData = BaseClass("OtakuRoomByKitChenData", BaseOtakuRoomData)
local M = OtakuRoomByKitChenData
local OtakuRoomType = OtakuType.OtakuRoomType
local ETableState = EnumConst.ETableState

function M:OnInit()
end

-- 是否完成
function M:IsEnd()
    return true
end

-- 额外附加数据
function M:ExtraData(diningTables)

end

function M:_getPosTimer(index, diningTables)
    local nowTimer = TimeUtil.GetNowTimeStamp()
    for _, diningTable in pairs(diningTables) do
        if diningTable.Position == index - 1 and diningTable.StudioId == self.m_RoomData.StudioId and diningTable.EndTick > nowTimer then
            return diningTable.EndTick
        end
    end
end

function M:_getPosData(index, timer)
    local data = {}
    local openNum = self:GetSeatLimit()
    if openNum < index then
        data.state = ETableState.Lock
        data.lockTips = self:GetUnlockPosLevel(index)
        data.EndTick = 0
        return data
    end
    local nowTimer = TimeUtil.GetNowTimeStamp()
    if timer and timer > nowTimer then
        data.state = ETableState.Cleaning
        data.EndTick = timer
        return data
    end
    data.EndTick = 0
    data.state = ETableState.None
    return data
end

function M:UpdateDining(diningTables)
    self.dinings = self.dinings or {}
    local nowTimer = TimeUtil.GetNowTimeStamp()

    for _, diningTable in pairs(diningTables) do
        if diningTable.StudioId == self.m_RoomData.StudioId then
            local data = self.dinings[diningTable.Position + 1]
            if diningTable.EndTick > nowTimer then
                data.state = ETableState.Cleaning
                data.EndTick = diningTable.EndTick
            else
                data.state = ETableState.None
            end
        end
    end
end

function M:GetDinings()
    return self.dinings or {}
end

-- 获取餐厅的可吃饭人数
function M:GetSeatLimit()
    local level = self:Level()
    local houseLevelRestaurants = ConfigHelper.GetCfgsByLua("houseLevel", {type=OtakuRoomType.EST_Canteen, level=level})

    if #houseLevelRestaurants <= 0 then
        Logger.LogError("查找数据错误")
        return 0
    end
    return houseLevelRestaurants[1].seatLimit
end

-- 获取当前空座位数量
function M:GetNullPosNum()
    local nullNum = 0
    local nowTimer = TimeUtil.GetNowTimeStamp()
    for _, dining in pairs(self.dinings) do
        if dining.state == ETableState.Cleaning then
            if dining.EndTick <= nowTimer then
                dining.state = ETableState.None
                nullNum = nullNum + 1
            end
        elseif dining.state == ETableState.None then
            nullNum = nullNum + 1
        end
    end
    return nullNum
end

-- 获取可以吃饭的位置
function M:GetPos(num)
    local pos = {}
    local nowTimer = TimeUtil.GetNowTimeStamp()
    local index = 1
    for i, dining in pairs(self.dinings) do
        if dining.state == ETableState.Cleaning then
            if dining.EndTick <= nowTimer then
                dining.state = ETableState.None
                pos[index] = i - 1
                index = index + 1
            end
        elseif dining.state == ETableState.None then
            pos[index] = i - 1
            index = index + 1
        end
        if #pos == num then
            return pos
        end
    end
    return pos
end

-- 获取解锁该位置的等级
function M:GetUnlockPosLevel(index)
    local houseLevelRestaurants = ConfigHelper.GetCfgsByLua("houseLevel", {type=OtakuRoomType.EST_Canteen})

    if #houseLevelRestaurants <= 0 then
        Logger.LogError("查找餐厅错误")
        return 0
    end

    local level

    for i = #houseLevelRestaurants, 1, -1 do
        local houseLevel = houseLevelRestaurants[i]

        if houseLevel.seatLimit >= index then
            level = houseLevel.level
        end
    end
    return level
end

function M:RemoveRoleLiveByIndex(index)
end

function M:OnUpdate(netUpdateType)
end

function M:OnDestory()
end

return OtakuRoomByKitChenData
