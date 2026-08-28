local import                = import
local checkNumber           = checkNumber
--region import
local Singleton             = import('Frame.Singleton')
local ClubGVGNetworkClient  = import('Game.UI.Club.GVG.ClubGVGNetworkClient')
local ClubGVGTimerDriver    = import('Game.UI.Club.GVG.ClubGVGTimerDriver')
local ClubGVGReportAnalyzer = import('Game.UI.Club.GVG.ClubGVGReportAnalyzer')
local PriorityQueue         = import("Game.Utils.PriorityQueue")
local Aoi                   = import("Game.Utils.Aoi")
local Yielders              = CS.Engine.Lib.Yielders
local cs_coroutine          = require "XLua.cs_coroutine"
local ResourceModule        = CS.Engine.Modules.ResourceModule
local Vector3Int = CS.UnityEngine.Vector3Int
--endregion

--region defines
local WaitForOneSeconds = Yielders.GetWaitForSeconds(1)

local TEST = false
---@type ClubGVGTestDataProvider
local ClubGVGTestDataProvider
if TEST then
    ClubGVGTestDataProvider = import('Game.UI.Club.GVG.Test.ClubGVGTestDataProvider')
    
end

local CompareFunc = function (a, b)
    return a > b
end

--endregion

---@class ClubGVGMgr
---@field GetInstance fun(self:ClubGVGMgr):ClubGVGMgr
local ClubGVGMgr = Class('ClubGVGMgr', Singleton)


function ClubGVGMgr:__init()
    self._isRequestHomeComplete = nil
    self._isFailure = false
    ---@type ClubGVGNetworkClient
    self.gvgClient = nil
    
    self._isInitial = false
    ---@type ClubGVGConstants.StageStatus
    self._currentStageStatus = nil
    
    self._clubId2Color = {}
    
    self._playerId2MarchQueue = {}
    self._buildingId2WorldPos = {}
    self._worldPos2SelectTileMapCell = {}

    self._playerBanners = {}

    ---公会id->建筑信息
    self._clubId2Building = nil
    
    self._buildId2TileData = nil

    self._questId          = Constants.SpecialQuestId.ClubGVGId
    self._teamNum          = QuestConfMgr:GetInstance():GetQuestTeamNum(self._questId)

    
end


function ClubGVGMgr:__delete()
    
end

---Initial
---@param ClubGVGConstants ClubGVGConstants
function ClubGVGMgr:Initial(ClubGVGConstants, battleEnterOffsetSeconds, durationOfProtectionPeriod, attackBuildingConsume, ...)
    if self._isInitial then 
        self:ClientInit()
        -- self:RequestHome()
        return
    end
    self._isInitial        = true
    ---@type ClubGVGTimerDriver
    self._timerDriver = ClubGVGTimerDriver.New()
    ---@type PriorityQueue
    self._enemyMarching = PriorityQueue.New(CompareFunc)
    ---@type ClubGVGReportAnalyzer
    self._reportAnalyzer = ClubGVGReportAnalyzer.New()

    self._battleEnterOffsetSeconds = battleEnterOffsetSeconds
    self._durationOfProtectionPeriod = durationOfProtectionPeriod
    self._attackBuildingConsume = attackBuildingConsume
    ---@type ClubGVGConstants
    self._constants        = ClubGVGConstants

    self._mapScaleType = ClubGVGConstants.MapScaleType.Secondary

    ---@type CardComponent
    local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    self._cardComponent = cardComponent

    ---@type PlayerDojo
    self._playerDojo = GameUtils.GetPlayerDojo()

    ---@type TeamComponent
    self._teamComponent    = GameUtils.GetEntityCompByType(ECSComponentType.Constants.TeamComponent)
    self._maxMemberNum     = self._teamComponent:GetMaxTeamMemberNum(self._questId)
    ---@type ClubGVGComponent
    self._component        = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.ClubGVGComponent)
    self._component:Initial(...)

    self._timerDriver:Init(self, self._component)
    self._reportAnalyzer:Init(self, self._component, self._timerDriver)
    
    self._playerId         = checkNumber(GameUtils.GetPlayerId())
    local clubComp         = ClubUtils.GetClubComp()
    ---@type ClubHomeDojo
    local homeDojo = clubComp:GetHomeDojo()
    -- self._gvgHost =  homeDojo.gvgHost
    self._clubId           = checkInt(homeDojo.clubId)

    self:LoadTileMapData(ClubGVGConstants.ResourcePath.TileMapData)
    
    self:ClientInit()

end


---@return ClubGVGNetworkClient
function ClubGVGMgr:GetClient()
    return self.gvgClient
end

---@return ClubGVGComponent
function ClubGVGMgr:GetComp()
    return self._component
end

function ClubGVGMgr:LoadTileMapData(jsonPath)
    if self._buildId2TileData ~= nil then
        return
    end
    local path   = string.format(jsonPath, 1)
    ResourceModule.LoadBundleAsync( path, function (loader, ok)
        if ok then
           local jsonData    = tostring(loader.ResultObject)
           ---@type TrackDataReader
           local TrackDataReader   = import('Game.Behaviours.Maze.TrackDataReader')
           jsonData = TrackDataReader.StripTail(jsonData)
           local tileMapData = table.deserialize(jsonData)
           self:InitTileMapData(tileMapData)
           
        end

        loader:Release()
    end, true )
    
end

function ClubGVGMgr:InitTileMapData(tileMapData)
    local mapSize = tileMapData.size
    local mapPosition = tileMapData.position
    local mapPositionX, mapPositionY = checkNumber(mapPosition.x), checkNumber(mapPosition.y)
    ---@type Aoi
    self._aoi = Aoi.New({x = checkNumber(mapSize.x), y = checkNumber(mapSize.y), radius = 4})

    local position2BuildingId = {
        -- [x] = {[y] = buildingId}
    }
    local buildId2TileData = {}
    local tiles            = checkTable(tileMapData.tiles)
    for key, value in pairs(tiles) do
        local buildId = checkNumber(value.id)
        buildId2TileData[buildId] = value
        
        local position = value.position
        local px, py = checkNumber(position.x), checkNumber(position.y)

        position2BuildingId[px] = position2BuildingId[px] or {}
        position2BuildingId[px][py] = buildId

        ---将坐标转成正的
        local tilePosX, tilePosY = px - mapPositionX, py  - mapPositionY
        self._aoi:enter(buildId, tilePosX, tilePosY)
    end

    self._buildId2TileData = buildId2TileData
    self._position2BuildingId = position2BuildingId
    self._mapPosition = {mapPositionX, mapPositionY}
    -- print("position2BuildingId", table.count(position2BuildingId), table.count(buildId2TileData))

end

function ClubGVGMgr:AoiAroundX(cell)
    local mapPositionX, mapPositionY = SafeUnpack(self._mapPosition)
    local px, py = checkNumber(cell.x), checkNumber(cell.y)
    local tilePosX, tilePosY = px - mapPositionX, py  - mapPositionY
    return self._aoi:aroundx(tilePosX, tilePosY)
        
end

function ClubGVGMgr:ClientInit()
    
    if ClubGVGTestDataProvider then
        self:RequestHome()
        return
    end

    self:ClientDestroy()

    local PackageId = self:GetConstants().PackageId
    local packageId2Handler = {
        [PackageId.WinningStreak]     = Bind(self, self.OnReceiveWinningStreak),
        [PackageId.KillWinningStreak] = Bind(self, self.OnReceiveKillWinningStreak),
        [PackageId.Report]            = Bind(self, self.OnReceiveReport),
        [PackageId.PlayerEnterGVGSuccess]            = Bind(self, self.OnReceivePlayerEnterGVGSuccess),
        -- [Constants.EventNames.ClubGvgTaskRedPointActive]            = Bind(self, self.OnTaskRedPointActive),
        -- [Constants.EventNames.ClubGvgRedPointChange]            = Bind(self, self.OnTaskRedPointChange),
    }

    
    self:GetOrRequestRefreshGvgHost(function (host)
        local ip, port = SafeUnpack(string.split(host, ":"))
        self.gvgClient =    ClubGVGNetworkClient.New(packageId2Handler)
        self.gvgClient:SetOnConnectSuccessCallback(function (isReset)
            self:RequestHome(isReset)

        end)
        self.gvgClient:Connect(tostring(ip), checkNumber(port)) 
        
    end)
   
    
end


function ClubGVGMgr:ClientDestroy()
    if self.gvgClient then
        self.gvgClient:Dispose()
        self.gvgClient = nil
    end
end

function ClubGVGMgr:GetOrRequestRefreshGvgHost(cb)
    local host = self:GetHost()
    if not string.isEmpty(host) then
        if cb then
            cb(host)
        end
        return
    end
    
    return self:RequestInterface(Interfaces.OverseaClubGVGRefreshGvgHost, {}, function (data)
        -- if true then
        --     self._isRequestHomeComplete = true
        --     self:SetRequestFailure(true)
        --     return
        -- end
        host = data.host
        if string.isEmpty(host) then
            printError("not found host")
        end
        local clubComp         = ClubUtils.GetClubComp()
        ---@type ClubHomeDojo
        local homeDojo = clubComp:GetHomeDojo()
        homeDojo:SetGVGHost(host)
        self._gvgHost = host
        if cb then
            cb(host)
        end
    end, nil, false, function() 
        self._isRequestHomeComplete = true
        self:SetRequestFailure(true)
    end)
end

function ClubGVGMgr:GetHost()
    if string.isEmpty(self._gvgHost) then
        local clubComp         = ClubUtils.GetClubComp()
        ---@type ClubHomeDojo
        local homeDojo = clubComp:GetHomeDojo()
        self._gvgHost = homeDojo.gvgHost
    end

    return self._gvgHost

end

function ClubGVGMgr:RequestHome(isReset)
    if self._isRequestHomeComplete == false then return end
    self._isRequestHomeComplete = false
    return self:RequestInterface(Interfaces.OverseaClubGVGHome, {}, function (data)
        -- if true then
        --     data.marchInfo = {
        --         {
        --             playerId = "4090",
        --             endTime = GameUtils.GetServerTime() + 5000,
        --             startBuilding = "40005",
        --             endBuilding = "10001",
        --         }
        --     }
        --     -- data.playerPlace = 40005
        --     -- data.playerInfo["4090"].place = 40005
        -- end
        local curSeconds = GameUtils.GetServerTime()

        self._component:InitialHome(data, curSeconds)
        self:InitStage(curSeconds)
        self:InitClubId2Building()
        self:InitStageStatus()
        self:InitMarchInfo()
        local rebirthTime = checkNumber(data.rebirthTime)
        self:SetResurrecting(rebirthTime > 0 and curSeconds < rebirthTime)
        self:InitTimerDriver()
        self:ReEnter()
        self._isRequestHomeComplete = true
    -- self:SetRequestFailure(true)
        if ClubGVGTestDataProvider == nil then
            self.gvgClient:Send(self:GetConstants().PackageId.PlayerEnterGVG, {})
        else
            ClubGVGTestDataProvider:PlayReport(self)
            
        end

    end, nil, isReset == true, function() 
        self._isRequestHomeComplete = true
        self:SetRequestFailure(true)
    end)
end

function ClubGVGMgr:RequestSaveTeam()
    self._teamComponent:SetTeamReq(self._questId, function() 

    end)
end


function ClubGVGMgr:RequestJoin()
    -- if true then
    --     local t = [[{"t":1,"pid":4090,"playerInfo":{"playerId":4090,"name":"mit0001","level":53,"avatar":6210006,"avatarFrame":6200002,"clubId":100062,"team":[{"combatValue":47483,"cardsInfo":[{"cardId":140008,"star":4,"cardLevel":60}]},{"combatValue":30413,"cardsInfo":[{"cardId":102021,"star":3,"cardLevel":60}]},{"combatValue":27931,"cardsInfo":[{"cardId":108006,"star":0,"cardLevel":60}]}],"place":"10001","clubName":"bks","hp":100},"rts":3,"id":114,"time":"2024-05-31 18:01:18"}]]
    --     local data = table.deserialize(t)
    --     data.pid = self._playerId
    --     data.playerInfo.playerId = self._playerId
    --     data.playerInfo.place = self:GetHomeDojo().clubPlace
    --     data.playerInfo.clubId = self._clubId
    --     self:OnReceiveReport(_, data)
    --     return
    -- end
    return self:RequestInterface(Interfaces.OverseaClubGVGJoin, {}, function (data) 

    end, nil, false)
end

function ClubGVGMgr:RequestMarch(requestData)
    -- if true then
    --     local t = [[{"t":2,"pid":4090,"pa":["10001","40001"],"mt":1717212424,"id":2,"time":"2024-06-01 11:26:14"}]]
    --     local data = table.deserialize(t)
    --     data.pid = self._playerId
    --     data.pa = string.split(requestData.path, ",")
    --     data.tmt = 5
    --     data.mt = GameUtils.GetServerTime() + data.tmt
    --     self:OnReceiveReport(_, data)
    --     return
    -- end
    return self:RequestInterface(Interfaces.OverseaClubGVGMarch, requestData, function (data) 
        -- self._component:UpdateMarch(data, requestData)

    end, nil, false)
end

function ClubGVGMgr:RequestMarchAccelerate(consumes)
    return self:RequestInterface(Interfaces.OverseaClubGVGMarchAccelerate, {}, function (data) 
        
    end, consumes, false)
end

function ClubGVGMgr:RequestAtBuilding()
    -- if true then
    --     local jsonStr = [[ [{"t":4,"pid":6496,"bid":"40002","hp":0,"sld":0,"wHp":70,"et":1717677149,"id":420,"time":"2024-06-06 20:32:24"}] ]]
    --     local t = table.deserialize(jsonStr)
    --     t[1].bid = self:GetHomeDojo().playerPlace
    --     self:OnReceiveReport(_, t)


    --     local jsonStr = [[  [{"t":5,"bid":"40002","cid":100150,"hp":30,"id":421,"time":"2024-06-06 20:32:24"}] ]]
    --     local t = table.deserialize(jsonStr)
    --     t[1].bid = self:GetHomeDojo().playerPlace
    --     self:OnReceiveReport(_, t)


    --     return
    -- end

    return self:RequestInterface(Interfaces.OverseaClubGVGAtBuilding, {}, function (data) 
        GameUtils.Toast(localize("您的队伍攻城成功，所在建筑生命值-1"))
    end, nil, false)
end

function ClubGVGMgr:RequestAt(request)
    -- if true then
    --     print("RequestAt------>>>")
    --     local jsonStr = [[{"t":6,"pid":4090,"tid":5188,"bid":"40001","et":1717226477,"id":44,"time":"2024-06-01 15:21:02"}	]]
    --     local t = table.deserialize(jsonStr)
    --     t.et = GameUtils.GetServerTime() + 3
    --     self:OnReceiveReport(_, t)

    --     jsonStr = [[{"t":7,"pid":4090,"tid":5188,"bid":"40001","w":0,"wHp":65,"id":47,"time":"2024-06-01 15:50:22"}	]]
    --     t = table.deserialize(jsonStr)
    --     self:OnReceiveReport(_, t)

    --     jsonStr = [[{"t":8,"r":2,"pids":[4090],"rtm":1717228282,"id":48,"time":"2024-06-01 15:50:22"}]]
    --     t = table.deserialize(jsonStr)
    --     t.rtm = GameUtils.GetServerTime() + 1000
    --     self:OnReceiveReport(_, t)

    --     -- jsonStr = [[{"t":7,"pid":4090,"tid":5188,"bid":"40001","w":1,"wHp":65,"id":47,"time":"2024-06-01 15:50:22"}	]]
    --     -- t = table.deserialize(jsonStr)
    --     -- self:OnReceiveReport(_, t)

    --     -- jsonStr = [[{"t":8,"r":2,"pids":[5188],"rtm":1717228282,"id":48,"time":"2024-06-01 15:50:22"}]]
    --     -- t = table.deserialize(jsonStr)
    --     -- self:OnReceiveReport(_, t)
        
    --     return
    -- end

    -- if true then
    --     local jsonStr = [[ [{"t":6,"pid":6496,"tid":4996,"bid":"10002","et":1717672069,"id":383,"time":"2024-06-06 19:07:34"}] ]]
    --     local t = table.deserialize(jsonStr)
    --     t[1].et = GameUtils.GetServerTime() + 15
    --     self:OnReceiveReport(_, t)

    --     jsonStr = [[ [{"t":7,"pid":6496,"tid":4996,"bid":"10002","w":0,"wHp":95,"id":384,"time":"2024-06-06 19:07:34"}] ]]
    --     local t = table.deserialize(jsonStr)
    --     self:OnReceiveReport(_, t)

    --     jsonStr = [[ [{"t":8,"r":2,"pids":[6496],"rtm":1717672114,"id":385,"time":"2024-06-06 19:07:34"}] ]]
    --     local t = table.deserialize(jsonStr)
    --     t[1].rtm = GameUtils.GetServerTime() + 60
    --     self:OnReceiveReport(_, t)

    --     return
    -- end

    return self:RequestInterface(Interfaces.OverseaClubGVGAt, request, function (data) 
        return data
    end, nil, true)
end


function ClubGVGMgr:RequestDeath(requestData)
    return self:RequestInterface(Interfaces.OverseaClubGVGDeath, requestData, function (data) 

        return data
    end, nil, true)
end

function ClubGVGMgr:RequestRebirth(consumeData)
    return self:RequestInterface(Interfaces.OverseaClubGVGRebirth, {}, function (data) 
        self._component:SetRebirthTimes(1)
        GameUtils.Toast(localize("复活次数+1"))
        return data
    end, consumeData, true, nil, true)
end

function ClubGVGMgr:RequestRank()
    return self:RequestInterface(Interfaces.OverseaClubGVGRank, {}, function (data) 
        return data
    end, nil, true)
end

function ClubGVGMgr:RequestPlayerRank()

    return self:RequestInterface(Interfaces.OverseaClubGVGPlayerRank, {}, function (data) 
        return data
    end, nil, true)
end

function ClubGVGMgr:RequestClubRecruit()
    return self:RequestInterface(Interfaces.OverseaClubGVGClubRecruit, {}, function (data) 
        return data
    end, nil, true)
end

function ClubGVGMgr:RequestPlayerRecruit(requestData)
    return self:RequestInterface(Interfaces.OverseaClubGVGPlayerRecruit, requestData, function (data) 
        return data
    end, nil, true)
end

--- 退出gvg界面来请求玩家记录
function ClubGVGMgr:RequestPlayerRecruit2(requestData)
    return self:RequestInterface(Interfaces.OverseaClubGVGPlayerRecruit2, requestData, function (data) 
        return data
    end, nil, true)
end

function ClubGVGMgr:RequestReport(requestData)
    return self:RequestInterface(Interfaces.OverseaClubGVGReport, requestData, function (data) 
        return data
    end, nil, true)
end

function ClubGVGMgr:RequestReport2(requestData)
    return self:RequestInterface(Interfaces.OverseaClubGVGReport2, requestData, function (data) 
        return data
    end, nil, true)
end


--- RequestInterface
--- 请求接口
---@param interface string 必传
---@param requestData table 必传
---@param callback fun(data:table) 必传
---@param consumeData table {{goodsId: number,  num: number}}
---@param isBroadcast boolean 是否广播接口请求成功
---@param errorCallback fun() 是否请求错误
---@param isNotifyConsumeGoodsChange boolean 是否通知消耗道具改变
function ClubGVGMgr:RequestInterface(interface, requestData, callback, consumeData, isBroadcast, errorCallback, isNotifyConsumeGoodsChange)
    requestData = requestData or {}
    
    local responseCallback = function(request, response)
        if checkNumber(response.errCode) ~= 0 then 
            if errorCallback then
                errorCallback()
            end
            return 
        end

        -------------------------------------------
        ---更新全局数据
        local data
        if callback then
            data = callback(response.data)
        end

        -------------------------------------------
        --- 更新消耗
        if consumeData then
            GoodsUtils.DrawRewards(consumeData, isNotifyConsumeGoodsChange)
        end

        -------------------------------------------
        --- 更新本地数据
        if isBroadcast then
            Events.Broadcast(self:GetConstants().EventNames.RequestSuccess, interface, data)
        end
    end
    if ClubGVGTestDataProvider then
        local response = ClubGVGTestDataProvider:GenerateDataByInterface(interface, requestData, self)
        responseCallback(requestData, response)
        return
    end

    return GameUtils.Request(interface, requestData, responseCallback)
end


---连胜通知
---@param data {playerId:number, loseId:number, times:number}
function ClubGVGMgr:OnReceiveWinningStreak(_, data)
    self:HandleReceiveWinningStreakData(data, self:GetConstants().BannerType.WinningStreak)

end

---终结连胜通知（双方工会的）
---@param data {playerId:number, loseId:number, times:number}
function ClubGVGMgr:OnReceiveKillWinningStreak(_, data)
    self:HandleReceiveWinningStreakData(data, self:GetConstants().BannerType.KillWinningStreak)

end

---@param data {playerId:number, loseId:number, times:number}
function ClubGVGMgr:HandleReceiveWinningStreakData(data, bannerType)
    self._component:UpdatePlayerWinningStreak(data.playerId, data.times)
    self._component:UpdatePlayerWinningStreak(data.loseId, 0)

    data.playerId = checkNumber(data.playerId)
    data.loseId   = checkNumber(data.loseId)
    data.times    = checkNumber(data.times)
    local isFindSelf = data.playerId == self._playerId or data.loseId == self._playerId
    if isFindSelf then
        table.insert(self._playerBanners, {data = data, bannerType = bannerType})
    else
        Events.Broadcast(self:GetConstants().EventNames.ShowBannerUI, data, bannerType)
    end
end


---战报同步通知
function ClubGVGMgr:OnReceiveReport(_, data)
    
    if not self._isRequestHomeComplete then
        return
    end
    
    local count = #data
    local state, st
    if count > 0 then
        for index, reportData in ipairs(data) do
            state, st = self:ReportAnalyze(reportData)
            if state == self:GetConstants().ReportState.Reset then break end
        end
    else
        state, st = self:ReportAnalyze(data)
    end
    
    if st and self._isCanUpdateServerTime then
        ---先暴力强更
        local serverTime = checkNumber(st)
        self._playerDojo:UpdateServerTime(serverTime)
        self._isCanUpdateServerTime = false
    end
    
    if state == self:GetConstants().ReportState.Reset and not TEST then
        
        self:RequestHome(true)
    end
end

function ClubGVGMgr:ReportAnalyze(reportData)
    local reportUUID = checkNumber(reportData.id)
    local state = self:UpdateReportUUID(reportUUID)
    if state ~= self:GetConstants().ReportState.Update then
        return state, reportData.st
    end
    
    local isFindSelf, extraData = self._reportAnalyzer:Analyze(reportData)
    local dataType = checkNumber(reportData.t)
    Events.Broadcast(self:GetConstants().EventNames.ReceiveRecord, dataType, reportData, isFindSelf, extraData)
    return state, reportData.st
end
function ClubGVGMgr:UpdateReportUUID(reportUUID)
    local dojo = self:GetHomeDojo()
    local state = self:GetReportState(reportUUID, dojo.newReportId)
    
    if state == self:GetConstants().ReportState.Reset then
        dojo:UpdateReportUUID(reportUUID)
    end
    return state
end

function ClubGVGMgr:GetReportState(reportUUID, currentUUID)
    if reportUUID <= currentUUID  then
        return self:GetConstants().ReportState.Discard
    elseif reportUUID > reportUUID + 1 then
        return self:GetConstants().ReportState.Reset
    else
        return self:GetConstants().ReportState.Update
    end
end

---战报同步通知
function ClubGVGMgr:OnReceivePlayerEnterGVGSuccess(_, data)
    self._roomId = data.roomId

end

---激活红点
function ClubGVGMgr:OnTaskRedPointActive()
    self:OnTaskRedPointChange(0)
end

---红点改变
function ClubGVGMgr:OnTaskRedPointChange(taskTips)
    self._component:UpdateTaskTips(taskTips)
    Events.Broadcast(self:GetConstants().EventNames.UpdateTaskRedPoint)

end



function ClubGVGMgr:ReEnter()
    self:RegisterListeners()
    self:StartCountDown()

end

--region listeners

function ClubGVGMgr:RegisterListeners()
    self._listeners = CfUtils.EventsDecorated({
        [Constants.EventNames.EVENT_REQUEST_COMPLETE] = Bind(self, self.OnEventRequestComplete),
        [Constants.EventNames.ClubGvgTaskRedPointActive]            = Bind(self, self.OnTaskRedPointActive),
        [Constants.EventNames.ClubGvgRedPointChange]            = Bind(self, self.OnTaskRedPointChange),
    })
end
function ClubGVGMgr:RemoveListeners()
    if self._listeners == nil then return end
    CfUtils.EventsUndecorated(self._listeners)
    self._listeners = nil

end
--endregion

--region count down

function ClubGVGMgr:StartCountDown()
    if not isNull(self._countdown) then return end
    local EventNames               = self:GetConstants().EventNames
    local EventNameChangeCountDown = EventNames.ChangeCountDown
    local EventNameActivityEnd     = EventNames.ActivityEnd
    local yield_return             = cs_coroutine.yield_return
    local Stage                    = self:GetConstants().Stage
    self._countdown = cs_coroutine.start(function() 
        local HasListener = Events.HasListener
        local Broadcast   = Events.Broadcast
        while true do
            local curSeconds = GameUtils.GetServerTime()
            -- self:SetIsProtectionPeriod(curSeconds < self._protectionPeriodEndTime)
            self._isCanUpdateServerTime = true
            self._timerDriver:Update(curSeconds)
            -- local isChangeStage, stage =  self:CheckStageChange(curSeconds)
            local dojo = self:GetHomeDojo()
            local stage = dojo.stage
            
            local gvgEndTime              = dojo.gvgEndTime
            if stage == Stage.Result or curSeconds >= gvgEndTime then
                Broadcast(EventNameActivityEnd, curSeconds)
                break
            end

            if self:CheckIsCanAutoAttackBuilding(curSeconds) then
                self:RequestAtBuilding()
            end
            
            if HasListener(EventNameChangeCountDown) then
                Broadcast(EventNameChangeCountDown, curSeconds)
            end

            -- self:CheckAutoAtkBuilding(curSeconds)
            
            yield_return(WaitForOneSeconds)
        end
        self._countdown = nil
    end)
end
function ClubGVGMgr:StopCountDown()
    if isNull(self._countdown) then return end
    cs_coroutine.stop(self._countdown)
    self._countdown = nil
end

-- function ClubGVGMgr:CheckAutoAtkBuilding(curSeconds)
--     local dojo = self:GetHomeDojo()()
--     local isInCD = dojo.attackCDEndTime > 0 and GameUtils.GetServerTime() < dojo.attackCDEndTime


-- end
--endregion

function ClubGVGMgr:InitStage(curSeconds)
    curSeconds                    = curSeconds or GameUtils.GetServerTime()
    ---@type ClubGVGHomeDojo
    local dojo                    = self:GetHomeDojo()
    local gvgStartTime            = dojo.gvgStartTime
    local gvgEndTime              = dojo.gvgEndTime
    self._prepareEndTime          = gvgStartTime + self._battleEnterOffsetSeconds
    self._protectionPeriodEndTime = self._prepareEndTime + self._durationOfProtectionPeriod
    self:SetIsProtectionPeriod(curSeconds < self._protectionPeriodEndTime)
    if curSeconds < self._prepareEndTime then
        dojo:SetStage(self:GetConstants().Stage.Preview, self._prepareEndTime)
    elseif curSeconds < gvgEndTime then
        dojo:SetStage(self:GetConstants().Stage.Batting, gvgEndTime)
    else
        dojo:SetStage(self:GetConstants().Stage.Result, curSeconds + 1000)
    end
    
end

function ClubGVGMgr:InitStageStatus()
    local dojo         = self:GetHomeDojo()
    local stage        = dojo.stage
    local Stage        = self:GetConstants().Stage
    local StageStatus = self:GetConstants().StageStatus
    -- PrepareAndUneditedTeam       = 1,   -- 准备阶段 未编辑队伍
    -- PrepareComplete              = 2,   -- 准备阶段 编辑队伍完成
    -- BattleStageAndUneditedTeam   = 3,   -- 战斗阶段 未编辑队伍
    -- BattleStageAndNonAcceded     = 4,   -- 战斗阶段 未加入战场
    -- InBattle                     = 5,   -- 在战场里
    local status         = StageStatus.Non
    local isEditComplete = self:IsEditTeamComplete()
    if stage == Stage.Preview then
        status = isEditComplete and StageStatus.PrepareComplete or StageStatus.PrepareAndUneditedTeam
    elseif stage == Stage.Batting then
        ---玩家加入战场后才会有该字段数据
        local playerPlace = dojo.playerPlace
        status = playerPlace > 0 and StageStatus.InBattle or (isEditComplete and StageStatus.BattleStageAndNonAcceded or StageStatus.BattleStageAndUneditedTeam)
    end

    self:SetStageStatus(status)

end

---@return boolean 是否编队完成
function ClubGVGMgr:IsEditTeamComplete()
    local questId = self._questId
    ---@type TeamComponent
    local teamComponent = self._teamComponent
    local isComplete = true
    for i = 1, self._teamNum do
        local t     = teamComponent:GetTeamByQuestId(questId, i)
        local count = teamComponent:GetTeamMemberCount(t) 
        if count <= 0 then
            isComplete = false
            break
        end
    end
    return isComplete
end


function ClubGVGMgr:InitClubId2Building()
    ---@type ClubGVGHomeDojo
    local dojo              = self:GetHomeDojo()
    local buildingInfo      = dojo.buildingInfo
    self._clubId2Building   = {}
    
    ---@param value {buildingId:number, type:number, clubId:number, shield:number, leftHp:number, playerIds:table, defensePlayerIds:table, attackPlayerIds:table, fightingInfo:table}
    for buildingId, value in pairs(buildingInfo) do
        local clubId = checkNumber(value.clubId)
        self._clubId2Building[clubId] = self._clubId2Building[clubId] or {}
        self._clubId2Building[clubId][buildingId] = value

    end

end


---@param data {id:number, t:number, bid:number, cid:number, hp:number}   
function ClubGVGMgr:UpdateClubId2Building(data)
    local buildingId   = checkNumber(data.bid)
    local buildingInfo = self:GetBuildInfo(buildingId)
    local clubId       = buildingInfo.clubId
    ---清理
    self._clubId2Building[clubId] = self._clubId2Building[clubId] or {}
    self._clubId2Building[clubId][buildingId] = nil

    ---填充
    local cid = checkNumber(data.cid)
    self._clubId2Building[cid] = self._clubId2Building[cid] or {}
    self._clubId2Building[cid][buildingId] = buildingInfo
end


function ClubGVGMgr:InitMarchInfo()
    ---@type ClubGVGHomeDojo
    local dojo         = self:GetHomeDojo()
    local marchInfo    = dojo.marchInfo

    local clubId2Building = self:GetClubId2Building()
    local clubId          = self._clubId
    --- 工会拥有的建筑物
    local clubBuilding    = clubId2Building[clubId]

    local enemyMarching   = self._enemyMarching
    enemyMarching.Values = {}
    enemyMarching.Priorities = {}
    -- enemyMarching:Clear()

    local playerId2Queue = self:GetPlayerId2MarchQueue()
    for key, queue in pairs(playerId2Queue) do
        queue.Values = {}
        queue.Priorities = {}
        -- queue:Clear()
    end

    local curSeconds      = GameUtils.GetServerTime()
    for key, value in pairs(marchInfo) do
        local value = marchInfo[key]
        local res   = self:UpdateMarchInfo(value, curSeconds, clubBuilding)
        if not res then
            marchInfo[key] = nil
        end
    end

end

---更新行军信息
function ClubGVGMgr:UpdateMarchInfo(value, curSeconds, clubBuilding)
    curSeconds = curSeconds or GameUtils.GetServerTime()

    if clubBuilding == nil then
        local clubId2Building = self:GetClubId2Building()
        --- 工会拥有的建筑物
        clubBuilding    = clubId2Building[self._clubId]
    end

    local isUpdateSuccess = curSeconds < checkNumber(value.endTime)
    if isUpdateSuccess then
        local marchPlayerId = checkNumber(value.playerId)
        local endTime       = checkNumber(value.endTime)
        ---@type table<number, PriorityQueue>
        local playerId2MarchQueue = self:GetPlayerId2MarchQueue()
        playerId2MarchQueue[marchPlayerId] = playerId2MarchQueue[marchPlayerId] or PriorityQueue.New(CompareFunc)
        playerId2MarchQueue[marchPlayerId]:Enqueue(value, endTime)

        if clubBuilding then
            local building = clubBuilding[checkNumber(value.endBuilding)]
            ---是己方工会建筑物 并且 该玩家不是己方工会人员
            if building ~= nil and self:GetPlayerInfoById(marchPlayerId).clubId ~= self._clubId and marchPlayerId ~= self._playerId then
                self._enemyMarching:Enqueue(value, endTime)
            end
            
        end

    end

    return isUpdateSuccess

end

---@param marchInfo {playerId:number, endTime:number, startBuilding:number, endBuilding:number}
function ClubGVGMgr:RemoveMarchInfo(marchInfo)
    if marchInfo == nil then
        return
    end
    ---@type table<number, PriorityQueue>
    local playerId2MarchQueue = self:GetPlayerId2MarchQueue()
    playerId2MarchQueue[checkNumber(marchInfo.playerId)] = nil
    -- local queue = playerId2MarchQueue[checkNumber(marchInfo.playerId)]
    -- if queue then
    --     queue.Values = {}
    --     queue.Priorities = {}
    -- end

    local Values = self._enemyMarching.Values
    local Priorities = self._enemyMarching.Priorities
    for i = #Values, 1, -1 do
        if checkNumber(Values[i].playerId) == checkNumber(marchInfo.playerId) then
            table.remove(Values, i)
            table.remove(Priorities, i)
        end
    end

end

function ClubGVGMgr:UpdatePlayerDieStatus()
    -- self._teamComponent:ResetAllTeam(self._questId)
    self:InitStageStatus()
    self:SetResurrecting(true)
    
end

---检查是否能自动进攻建筑
function ClubGVGMgr:CheckIsCanAutoAttackBuilding(curSeconds)
    ---@type ClubGVGHomeDojo
    local dojo = self:GetHomeDojo()
    if not dojo.autoAttack then
        return false
    end
    if dojo.clubIsDie == 1 then
        return false
    end

    if dojo.hp < self._attackBuildingConsume then
        return false
    end

    curSeconds = curSeconds or GameUtils.GetServerTime()
    local isInCD = dojo.attackCDEndTime > 0 and curSeconds < dojo.attackCDEndTime
    if isInCD then
        return false
    end

    local playerPlace = checkNumber(dojo.playerPlace)
    local clubId = self:GetClubId()
    local buildInfo = self:GetBuildInfo(playerPlace)
    if buildInfo == nil or checkNumber(buildInfo.clubId) == clubId then
        return false
    end

    if dojo.marchInfo[self:GetPlayerId()] ~= nil then
        return false
    end

    return self:IsCanAttackBuilding(buildInfo)

end

function ClubGVGMgr:IsCanAttackBuilding(buildingInfo)
    local isCanAttack = true
    local clubId = self:GetClubId()
    ---@type ClubGVGHomeDojo
    local dojo = self:GetHomeDojo()
    local marchInfo = dojo.marchInfo
    local playerId2Info = self:GetPlayerId2PlayerInfo()
    -- print("attackPlayerIds", table.toString(attackPlayerIds))

    local buildingClubId   = checkNumber(buildingInfo.buildingClubId)

    ---如果是自己工会的建筑则不能再进攻
    if buildingClubId == clubId then
        return false
    end

    --- 需要对建筑物的玩家进行检查 如果存在非己方工会 则需要判断该玩家是否在行军中
    local playerIds = checkTable(buildingInfo.playerIds)
    for index, playerId in ipairs(playerIds) do
        playerId = checkNumber(playerId)
        local playerInfo = playerId2Info[playerId]
        ---玩家是自己工会则无视  非自己工会需要检查是否在行军中
        if checkNumber(playerInfo.clubId) ~= clubId then
            isCanAttack = isCanAttack and marchInfo[playerId] ~= nil

        end    
    end

    return isCanAttack
end

function ClubGVGMgr:InitTimerDriver()
    ---@type ClubGVGHomeDojo 
    local dojo            = self:GetHomeDojo()
    local protectionPeriodEndTime = self:GetIsProtectionPeriod() and self:GetProtectionPeriodEndTime() or 0
    self._timerDriver:InitData(dojo, protectionPeriodEndTime)
    
end

---CheckStageChange
---检查阶段改变
---@param curSeconds number 当前的时间戳
---@return boolean isChange 
---@return ClubGVGConstants.Stage stage  
function ClubGVGMgr:CheckStageChange(curSeconds)
    ---@type ClubGVGHomeDojo 
    local dojo            = self:GetHomeDojo()
    local stageEndSeconds = dojo.stageEndSeconds
    local isChange        = curSeconds >= stageEndSeconds
    local stage           = dojo.stage
    if isChange then
        local Stage = self:GetConstants().Stage
        if stage == Stage.Preview then
            stage            = Stage.Batting
            stageEndSeconds  = dojo.gvgEndTime
        elseif stage == Stage.Batting then
            stage            = Stage.Result
        end
        local comp = self:GetComp()
        comp:UpdateStage(stage, stageEndSeconds)
    end
    return isChange, stage
end

function ClubGVGMgr:CheckAndGetPlayerBanner(bannerData)
    if bannerData == nil then return end
    local t = {}
    local playerBanners = self:GetPlayerBanners()
    for i = #playerBanners, 1, -1 do
        local playerBanner = playerBanners[i]
        local data =  playerBanner.data
        if data.playerId == bannerData.playerId and data.loseId == bannerData.loseId then
            table.insert(t, playerBanner)
            table.remove(playerBanners, i)
        end
    end
    return t

end



function ClubGVGMgr:SetAutoAttack(isOpen)
    return self._component:UpdateAutoAttack(isOpen)
end

function ClubGVGMgr:ReverseAutoAttack()
    local autoAttack = self:GetHomeDojo().autoAttack
    return self:SetAutoAttack(not autoAttack)
end

---GetMarchSeconds
---获取自己的 行军秒数
function ClubGVGMgr:GetMarchSeconds()
    return self:GetMarchSecondsById(self._playerId)
end

---GetMarchSecondsById
---通过玩家id 获取 行军 数据
function ClubGVGMgr:GetMarchSecondsById(playerId)
    local marching      = self:GetPlayerId2MarchQueue()
    local marchData     = marching[checkNumber(playerId)]
    return self:GetMarchSecondsByMarchQueue(marchData)
    
end

---GetEnemyMarchMessage
---获取 强敌来袭 数据
function ClubGVGMgr:GetEnemyMarchSeconds()
    local marching      = self:GetEnemyMarching()
    return self:GetMarchSecondsByMarchQueue(marching)
    
end

---GetMarchSecondsByMarchQueue
---根据行军队列 获取行军时间
---@param queue PriorityQueue
---@return number | nil
---@return table | nil
function ClubGVGMgr:GetMarchSecondsByMarchQueue(queue)
    if queue == nil then
        return nil
    end
    local size          = queue:Size()
    if size < 0 then
        return nil
    end
    local curSeconds    = GameUtils.GetServerTime()
    local seconds, marchInfo
    while size > 0 and seconds == nil do
        ---@type {endTime:number}
        marchInfo = queue:Peek()
        local endTime = marchInfo.endTime
        if curSeconds < endTime then
            seconds = endTime - curSeconds
        else
            queue:Dequeue()
            size = size - 1
        end
    end

    return (seconds ~= nil and seconds > 0) and seconds or nil, marchInfo
end

function ClubGVGMgr:GetPlayerTeamMembers()
    ---@type TeamComponent
    local teamComponent = self._teamComponent
    local questId       = self._questId
    local t = {}
    for i = 1, self._teamNum do
        local tt = teamComponent:GetTeamByQuestId(questId, i)
        local members = {}
        for index, member in ipairs(tt) do
            local cardDojo = self._cardComponent:GetCardById(member.refId)
            if cardDojo then
                table.insert(members, {
                    refId = member.refId,
                    cardId = member.cardId,
                    id = member.refId,
                    fettersId = member.fettersId,
                    fettersCardId = member.fettersCardId,
                    cardLevel = cardDojo.cardLevel,
                    star = cardDojo.star,
                    advanceLevel = cardDojo.advanceLevel,
                })
            else
                table.insert(members, member)
            end
        end
        table.insert(t, {
            cardsInfo    = members,
            combatValue = teamComponent:GetTeamFightingPower(members)
        })
        
    end

    return t
    
end

function ClubGVGMgr:GetStageStatus()
    return self._currentStageStatus
end
function ClubGVGMgr:SetStageStatus(status)
    self._currentStageStatus = status
end

function ClubGVGMgr:GetClubId2Building()
    return self._clubId2Building
end

function ClubGVGMgr:GetPlayerId2PlayerInfo()
    ---@type ClubGVGHomeDojo
    local dojo         = self:GetHomeDojo()
    local playerInfo     = dojo.playerInfo
    return playerInfo
end

function ClubGVGMgr:GetPlayerId()
    return self._playerId
end

---@return {playerId:number, place:number ,name:string,level:number,avatar:string,avatarFrame:string,successiveVictoryTimes:number,hp:number,clubId:number,team:table}
function ClubGVGMgr:GetPlayerInfoById(playerId)
    local playerInfo     = self:GetPlayerId2PlayerInfo()
    return playerInfo[checkNumber(playerId)]
end

---@return {startBuilding:number,id:number,name:string,clubAvatar:number,serviceName:string}
function ClubGVGMgr:GetClubInfoById(id)
    ---@type ClubGVGHomeDojo
    local dojo         = self:GetHomeDojo()
    local clubInfo     = dojo.clubInfo
    return clubInfo[checkNumber(id)]
end


function ClubGVGMgr:GetQuestId()
    return self._questId
end

function ClubGVGMgr:GetTeamNum()
    return self._teamNum
end

function ClubGVGMgr:GetMaxMemberNum()
    return self._maxMemberNum
end

function ClubGVGMgr:GetClubId()
    return self._clubId
end

function ClubGVGMgr:GetBuildId2TileData()
    return self._buildId2TileData
end

function ClubGVGMgr:GetPosition2BuildingId()
    return self._position2BuildingId
end

function ClubGVGMgr:GetMapPosition()
    return self._mapPosition
end

---@return ClubGVGHomeDojo
function ClubGVGMgr:GetHomeDojo()
    ---@type ClubGVGHomeDojo
    local dojo         = self:GetComp():GetDojo()
    return dojo
end


---GetPlayerId2MarchQueue
---获取 行军信息
---@return PriorityQueue
function ClubGVGMgr:GetPlayerId2MarchQueue()
    return self._playerId2MarchQueue
end

---GetEnemyMarching
---获取 敌方工会的行军信息
---@return PriorityQueue
function ClubGVGMgr:GetEnemyMarching()
    return self._enemyMarching
end

function ClubGVGMgr:GetBuildId2BuildInfo()
    ---@type ClubGVGHomeDojo
    local dojo         = self:GetHomeDojo()
    local buildingInfo     = dojo.buildingInfo
    return buildingInfo
end

---@return {buildingId:number, leftHp:number, type:number, clubId:number, playerIds:table, attackPlayerIds:table, defensePlayerIds:table, fightingInfo:table}
function ClubGVGMgr:GetBuildInfo(buildingId)
    local buildingInfo = self:GetBuildId2BuildInfo()
    return buildingInfo[checkNumber(buildingId)]
end

---保护器结束时间
function ClubGVGMgr:GetProtectionPeriodEndTime()
    return self._protectionPeriodEndTime
end

function ClubGVGMgr:SetIsProtectionPeriod(isProtectionPeriod)
    self._isProtectionPeriod = isProtectionPeriod
end

function ClubGVGMgr:GetIsProtectionPeriod()
    return self._isProtectionPeriod
end


function ClubGVGMgr:GetIsRequestHomeComplete()
    return self._isRequestHomeComplete
end

function ClubGVGMgr:GetRequestFailure()
    return self._isFailure
end

function ClubGVGMgr:SetRequestFailure(isFailure)
    self._isFailure = isFailure
end

---@return Aoi
function ClubGVGMgr:GetAoi()
    return self._aoi
end

function ClubGVGMgr:GetResurrecting()
    return self._resurrecting
end

function ClubGVGMgr:SetResurrecting(resurrecting)
    self._resurrecting = resurrecting
end

function ClubGVGMgr:GetPlayerBanners()
    return self._playerBanners
end

function ClubGVGMgr:GetIsConfirmTick()
    return self._isConfirmTick
end

function ClubGVGMgr:SetIsConfirmTick(isConfirmTick)
    self._isConfirmTick = isConfirmTick
end

function ClubGVGMgr:GetAccelerationConfirmTick()
    return self._accelerationConfirmTick
end

function ClubGVGMgr:SetAccelerationConfirmTick(isConfirmTick)
    self._accelerationConfirmTick = isConfirmTick
end

---获取建筑物世界坐标
function ClubGVGMgr:GetBuildingWorldPos(buildingId, buildingTileMap)
    local worldPos = self._buildingId2WorldPos[buildingId]
    if worldPos == nil then
        local buildId2TileData = self._buildId2TileData
        local tileData         = buildId2TileData[buildingId]
        local position         = tileData.position
        local vector3Int       = Vector3Int(position.x, position.y, position.z)
        worldPos = buildingTileMap:CellToWorld(vector3Int)
        self._buildingId2WorldPos[buildingId] = worldPos
    end
    return worldPos
end

---获取控制选中的tileMap cell
function ClubGVGMgr:GetSelectTileMapCellByWorldPos(worldPos, selectTileMap)
    local cell = self._worldPos2SelectTileMapCell[worldPos]
    if cell == nil then
        cell = selectTileMap:WorldToCell(worldPos)
        cell.z = 0
        self._worldPos2SelectTileMapCell[worldPos] = cell
    end
    return cell
end

function ClubGVGMgr:GetClubId2Color()
    return self._clubId2Color
 end

 function ClubGVGMgr:GetConstants()
    if self._constants == nil then
        self._constants = import('Game.UI.Club.GVG.ClubGVGConstants')
    end
    return self._constants
 end

 function ClubGVGMgr:GetMapScaleType()
    return self._mapScaleType
 end

 function ClubGVGMgr:SetMapScaleType(mapScaleType)
    self._mapScaleType = mapScaleType
 end

function ClubGVGMgr:OnEventRequestComplete(code, path)
    if code ~= 0 then return end
    if path == Interfaces.PlayerSetCopyTeam then
        self:InitStageStatus()
        Events.Broadcast(self:GetConstants().EventNames.ChangeStageStatus)
    end
end


function ClubGVGMgr:Clear()
    self:SetRequestFailure(false)
    --- 停止倒计时
    self:SetAutoAttack(false)
    self:StopCountDown()
    self._timerDriver:Delete()
    self._reportAnalyzer:Delete()
    self:ClientDestroy()
    self:RemoveListeners()
    self._clubId2Color = {}
    self._buildingId2WorldPos = {}
    self._worldPos2SelectTileMapCell = {}
    --- 清理数据组件相关标识
    ---@type ClubGVGComponent
    local component = self._component
    if component ~= nil then 
        component:Clear()
    end

    self._isInitial = false

    if ClubGVGTestDataProvider then
        if ClubGVGTestDataProvider.co then
            CoStop(ClubGVGTestDataProvider.co)
            
        end
    end
end

return ClubGVGMgr
