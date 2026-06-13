-- 餐厅data  餐厅数据类 OtakuRoomByCanteenData
local RestaurantDataMgr = BaseClass("RestaurantDataMgr", Singleton)
local M = RestaurantDataMgr
local MessageId = Proto.MessageId
local RESTAURANTSTAR = "RESTAURANTSTAR"
local HOURS5 = 18000
local tInsert = table.insert


function M:__init()
    -- 餐桌CD变化
    self._tempNotifyDiningTableEatCDChangeCallback = NetPack:RegistResponse(MessageId.NotifyDiningTableEatCdChange, Bind(self, self.NotifyDiningTableEatCDChangeCallback))
end

function M:GetCurrentRoomData()
    return self.roomData
end

function M:UpdateData(roomData)
    self.roomData = roomData
end

-- 更新当日餐厅星级数据 餐厅特供食物
function M:_UpdateStarData(Star, Tick, Food)
    self.Star = Star
    self.Tick = Tick
    self.Food = Food
end

-- 今日能否主动弹出餐厅星级
function M:GetToDayTipsStar()
    local lastTips = PlayerPrefTools.GetPlayerPrefsInt(RESTAURANTSTAR, 0)
    if not lastTips or lastTips == 0 then
        return true
    end
    if TimeUtil.IsToday(lastTips - HOURS5) then
        return false
    end
    return true
end

function M:UpdteTipsStarTimer()
    local nowTimer = TimeUtil.GetNowTimeStamp()
    PlayerPrefTools.SetPlayerPrefs(RESTAURANTSTAR, nowTimer)
end

-- 更新今日星级
function M:UdpateToDayStar(starCallBack)
    self.starCallBack = starCallBack
    if not self.Tick then
        self:RequestCanteenStar()
        return
    end
    -- 同一天不需要重新请求数据
    if TimeUtil.IsToday(self.Tick - HOURS5) then
        if self.starCallBack then
            self.starCallBack(self.Star, self.Food)
        end
        return
    end
    self:RequestCanteenStar()
end

-------------------------------------start-----------------
-- 邀请英雄Req
function M:RequestInviteHeroEat(heroIds, Positions, StudioId, callBack)
    -- Logger.LogError("邀请吃饭 Req")
    self.callBack = callBack
    if #Positions < #heroIds then
        Logger.LogError("没有空位置")
        return
    end
    self.heroIds = heroIds
    self._tempResponseInviteHeroEatCallback = NetPack:RegistResponse(MessageId.ResponseInviteHeroEat, Bind(self, self.ResponseInviteHeroEatCallback))

    local request = {}
    request.StudioId = StudioId
    request.Positions = Positions -- 位置
    request.HeroIds = heroIds -- 英雄id
    NetPack:SendMessage(MessageId.RequestInviteHeroEat, request)
end

-- 请求餐厅星级Req
function M:RequestCanteenStar()
    self._tempResponseCanteenStarCallback = NetPack:RegistResponse(MessageId.ResponseCanteenStar, Bind(self, self.ResponseCanteenStarCallback))
    local request = {}
    NetPack:SendMessage(MessageId.RequestCanteenStar, request)
end

-----------------------------------------------------------------------------------------------

-- 邀请英雄Ack
function M:ResponseInviteHeroEatCallback(messagId, result, msg)
    -- Logger.LogError("邀请吃饭 Ack")
    NetPack:UnRegistResponse(MessageId.ResponseInviteHeroEat, self._tempResponseInviteHeroEatCallback)
    self._tempResponseInviteHeroEatCallback = nil

    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    if self.callBack then
        self.callBack(msg.DiningTables)
        self.callBack = nil
    end
    -- 吃饭埋点
    -- local dataKey = { "dinner_hero_id" }
    local dataValues = {self:GetHeros(self.heroIds)}
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Cabin_dinner, dataValues)
end

-- 请求餐厅星级Ack
function M:ResponseCanteenStarCallback(_, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseCanteenStar, self._tempResponseCanteenStarCallback)
    self._tempResponseCanteenStarCallback = nil

    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end

    self:_UpdateStarData(msg.Star, msg.Tick, msg.Food)
    if self.starCallBack then
        self.starCallBack(self.Star, self.Food)
    end
end

-- 餐桌CD变化
function M:NotifyDiningTableEatCDChangeCallback(messagId, result, msg)
    local tempTable = {}

    for i = 1, #msg.DiningTables do
        local tempData = msg.DiningTables[i]
        local studioId = tempData.StudioId

        if not tempTable[studioId] then
            tempTable[studioId] = {}
        end

        tInsert(tempTable[studioId], tempData)
    end

    for studioId, dinings in pairs(tempTable) do
        local roomData = OtakuRoomDataMgr:GetInstance():RoomDataByRoomId(studioId)

        if roomData then
            roomData:UpdateDining(dinings)
        end
    end
end

-----------------------------------------end------------------

function M:GetHeros(heroIds)
    local herosStr = ""
    for key, heroId in pairs(heroIds) do
        if key == 1 then
            herosStr = heroId
        else
            herosStr = herosStr .. "," .. heroId
        end
    end
    return herosStr
end

-- 清除当前餐厅数据
function M:ClearData()
    self.roomData = nil
    self.dinings = nil
    self.heroIds = nil
end

function M:Dispose()
    NetPack:UnRegistResponse(MessageId.NotifyDiningTableEatCdChange, self._tempNotifyDiningTableEatCDChangeCallback)
end

return M
