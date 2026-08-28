--[[
    author:luqucheng
    time:2021-03-10 11:30:24
]]
local cs_coroutine = import("XLua.cs_coroutine")
local KNManager = CS.Engine.Network.KNManager
local KTool = CS.Engine.Lib.KTool
local KLobbyClientEx = CS.Engine.Network.KLobbyClientEx
local BehaviourAction = CS.Engine.Lib.BehaviourAction
local UINavigationBarRoot = CS.UINavigationBarRoot
local HttpModule = CS.Engine.Http.HttpModule
---@type Engine.Http.RequestMeta
local requestMeta = HttpModule.RequestBodyMeta

local ZipUtils = CS.Engine.ZipUtils

---@class BattleNetworkClient
local BattleNetworkClient = {}

BattleNetworkClient = Class("BattleNetworkClient")

BattleNetworkClient.SendPackageIds = {                                             -- 发送包丢了怎么办          -- 回复包丢了怎么办
    EnterBattle        = 4000,  -- 进入战斗     playerId:玩家id                     -- 需要重发                 -- 重新请求
    LoadingFinished    = 4002,  -- 加载完成                                         -- 需要重发                 -- 重新请求
    Input              = 4006,  -- 上传操作                                         -- 重连以后玩家手动重发      -- 重连时会同步状态
    PlayRecordFinished = 4010,  -- 技能播放完成                                     -- 重连以后逻辑会发          -- 重连时会同步状态
    SendGameEnd        = 4012,  -- 战斗结算                                         -- 重连以后逻辑会发          -- 重新请求？
    SendEmoji          = 4014,  -- 发送表情     faceId:表情Id
    Refresh            = 4016,  -- 申请重连     playerId:玩家id, roomId:房间id
    RequestHosting     = 4018,  -- 请求托管     isOpen:1 (1:启用托管 0取消托管)         -- 重连以后玩家手动重发    -- 重连时会同步状态
    ManualExit         = 4020,  -- 手动退出                                         -- 重连以后玩家手动重发       -- 重连时同步退出状态？
}

BattleNetworkClient.ReceivePackageIds = {                                                                     -- 回复包丢了怎么办             -- 推送丢了怎么办
    Init                = 4001,  -- 初始化数据                                                                 -- 客户端重新请求
    PlayerLoadingProcess = 4003, -- 加载结果    result:1完成0未完成                                             -- 重新请求                    -- 重连时同步加载状态？
    RoundStart          = 4005,  -- 回合开始        round:1开始回合数                                           -- 重连时会同步状态
    InputConfirm        = 4007,  -- 输入确认                                                                   -- 重连时会同步状态             -- 重连时会同步状态
    InputFinished       = 4009,  -- 双方输入完成                                                                                              -- 重连时同步状态
    AllPlayerLoadingFinished = 4011,    -- 双方加载完毕
    BattleEnd           = 4013,  -- 结算结果        win:胜利1/0，statistic:战斗统计，offline:对方掉线1/0         -- 重新请求？
    OtherDisconnect     = 4015,  -- 玩家断开        {quitPlayerId:掉线的玩家id}                                                                -- 重连时同步连接状态？
    PlayerHosting       = 4017,  -- 玩家托管        {playerId:托管的玩家id，isOpen:1(1:启用托管 0取消托管)}      -- 重连时会同步状态              -- 重连时会同步状态
    ReceiveEmoji        = 4019,  -- 收到表情        faceId:表情Id
    RefreshConfirm      = 4021,  -- 断线重连回执
    PlayerRefreshConfirm= 4023,  -- 其他玩家断线重连回执
    HostTerminateGame   = 4025,  -- 主机中止游戏                                                                -- 重连时同步退出状态？         -- 重连时同步退出状态？
    Error               = 4027,  -- 服务器通知错误                                                                                             -- 重连时服务器会重新下发
}

-- 断线丢包时需要重发的消息
BattleNetworkClient.PacketNeedCache = {
    [BattleNetworkClient.SendPackageIds.EnterBattle] = true,  -- 初始化数据
    [BattleNetworkClient.SendPackageIds.LoadingFinished] = true,  -- 加载结果
    [BattleNetworkClient.SendPackageIds.SendGameEnd] = true,  -- 结算结果
}
-- 服务器回包和客户端请求的映射
BattleNetworkClient.PacketAckMap = {
    [BattleNetworkClient.ReceivePackageIds.Init]                    = BattleNetworkClient.SendPackageIds.EnterBattle,  -- 初始化数据
    [BattleNetworkClient.ReceivePackageIds.PlayerLoadingProcess]     = BattleNetworkClient.SendPackageIds.LoadingFinished,  -- 加载结果
    [BattleNetworkClient.ReceivePackageIds.BattleEnd]               = BattleNetworkClient.SendPackageIds.SendGameEnd,  -- 结算结果
    [BattleNetworkClient.ReceivePackageIds.RoundStart] = BattleNetworkClient.SendPackageIds.PlayRecordFinished,  -- 请求回合开始
}

BattleNetworkClient.PacketNameDict = {
    [4000] = '进入战斗',
    [4002] = '加载完成 或 断开连接',
    [4006] = '上传操作',
    [4010] = '技能播完',
    [4011] = '双方加载完成',
    [4012] = '申请结算',
    [4014] = '发送表情',
    [4016] = '申请重连',
    [4018] = '托管请求',
    [4020] = '手动退出',
    [4001] = '初始数据',
    [4003] = '对手加载',
    [4005] = '回合开始',
    [4007] = '出牌确认',
    [4009] = '出牌结束',
    [4013] = '结算结果',
    [4015] = '对方断开',
    [4017] = '玩家托管',
    [4019] = '收到表情',
    [4021] = '重连确认',
    [4023] = '其他玩家重连',
    [4025] = '服务器结束游戏',
    [4027] = '异常消息',
}

BattleNetworkClient.QuitType = {
    Disconnect = 1,
    OutofTime = 2,
    OtherDisconnect = 3,
    ConnectFailed = 4,
    HostDisconnect = 5,     -- 主机退出游戏
    PingOutofTime = 6,
    RoomDestroyed = 7,      -- 房间已销毁
}

BattleNetworkClient.isQuit = false

BattleNetworkClient.retryTime   = 2     -- 连接重试次数
BattleNetworkClient.pintTime    = 2000  -- 心跳检测周期（毫秒）
BattleNetworkClient.timeoutTime = 8000  -- 超时检测周期（毫秒）


local GAME_OBJECT_NAME = "BATTLE_TCP_OBJECT"
local ClientLuaPath = "Game.Behaviours.LuaKLobbyClientEx"


function BattleNetworkClient:__init(  )
    ---@type UnityEngine.GameObject
    self.go = nil
    ---@type table[] @ 还未收到服务器回复的消息
    self.waitAckQueue = {}
    self.address = nil
    self.port = nil
    self.isConnected_ = false

    -- 本地记录日志
    local isEditor = CS.UnityEngine.Application.isEditor
    local dataPath = CS.UnityEngine.Application.dataPath
    local persistentDataPath = CS.UnityEngine.Application.persistentDataPath
    local fileName = string.format("%s_Battle_Tcp_Log.txt", os.date("%m_%d", os.time()))
    if isEditor then
        local ts = string.reverse(dataPath)
        local _, i = string.find(ts, "/")
        local m = string.len(ts) - i + 1
        local dirPath = string.sub(dataPath, 1, m)
        self.logFilePath = dirPath.."Product/"..fileName
    else
        self.logFilePath = persistentDataPath.."/"..fileName
    end

    self:InitBattleClient()
end

function BattleNetworkClient:__delete(  )
    self:Disconnect()
end

---------- tcp network --------------------
---GetBattleRelayGameObject
---获取战斗需要的依赖的对象节点
---@return UnityEngine.GameObject
function BattleNetworkClient:GetBattleRelayGameObject()
    if isNull(self.go) then
        self.go = KTool.CreateEmptyGameObject(nil, GAME_OBJECT_NAME, false)
    end
    return self.go
end

function BattleNetworkClient:GetKLobbyClientEx()
    local instance = self:GetBattleRelayGameObject()
    if isNull(instance) then
        return nil
    end
    if isNull(self.lobbyClient) then
        local lb = GetLuaBehaviour(instance, ClientLuaPath) or AddLuaBehaviour(instance, ClientLuaPath)
        if isNull(lb) then
            return nil
        end
        if isNull(lb.Env) then
            lb:Init()
        end
        self.lobbyClient = lb.Env
    end
    return self.lobbyClient
end

---InitBattleClient
---初始战中的tcp长链接的逻辑
---@param instance UnityEngine.GameObject
function BattleNetworkClient:InitBattleClient(instance)
    ---@type LuaKLobbyClientEx
    local lobbyClient = self:GetKLobbyClientEx()
    if isNull(lobbyClient) then
        printError("[BattleNetworkClient] 初始化 连接载体错误")
        return
    end

    lobbyClient:SetClientName('BATTLE')
    lobbyClient:SetPingDelta(BattleNetworkClient.pintTime)
    lobbyClient:SetTimeoutDelta(BattleNetworkClient.timeoutTime)
    lobbyClient:SetRetryTimes(BattleNetworkClient.retryTime)
    lobbyClient:SetPacketNameDict(BattleNetworkClient.PacketNameDict)
    lobbyClient:IsOpenLogListen(true)

    lobbyClient.onConnectCb = Bind(self, self.OnConnectHandler)
    lobbyClient.onDisconnectCb = Bind(self, self.OnDisconnectHandler)
    lobbyClient.onTimeoutCb = function()
        self.isConnected_ = false
        self:QuitBattle(BattleNetworkClient.QuitType.OutofTime)
    end
    lobbyClient.onStopCb = function()
        self.isConnected_ = false
        self:QuitBattle(BattleNetworkClient.QuitType.ConnectFailed)
    end
    lobbyClient.onLogCb = function(msg)
        self:Log2File(msg)
    end

    self:Register()
end
---------- tcp network --------------------

function BattleNetworkClient:Connect(address, port)
    self.address = address
    self.port = port
    self.isConnected_ = false

    local instance = self:GetBattleRelayGameObject()
    if instance then
        ---@type LuaKLobbyClientEx
        local lobbyClient = self:GetKLobbyClientEx()
        if isNull(lobbyClient) then
            printError("[BattleNetworkClient] 连接 连接载体错误")
            return
        end
        lobbyClient:Connect(checkString(address), port)
    end
end

function BattleNetworkClient:Reconnect()
    local instance = self:GetBattleRelayGameObject()
    if instance then
        ---@type LuaKLobbyClientEx
        local lobbyClient = self:GetKLobbyClientEx()
        if isNull(lobbyClient) then
            printError("[BattleNetworkClient] 连接 连接载体错误")
            return
        end
        lobbyClient:Reconnect()
    end
end

function BattleNetworkClient:Disconnect()
    local instance = self:GetBattleRelayGameObject()
    if instance then
        ---@type LuaKLobbyClientEx
        local lobbyClient = self:GetKLobbyClientEx()
        if isNull(lobbyClient) then
            printError("[BattleNetworkClient] 断开 连接载体错误")
            return
        end
        lobbyClient:Disconnect()
    end
end

function BattleNetworkClient:Dispose(  )
    if not isNull(self.go) then
        KTool.SafeDelete(self.go, true)
    end
    self.go = nil
    local go = CS.UnityEngine.GameObject.Find(GAME_OBJECT_NAME)
    if not isNull(go) then
        KTool.SafeDelete(go, true)
    end
    if self.quitCo then
        cs_coroutine.stop(self.quitCo)
        self.quitCo = nil
    end
end

function BattleNetworkClient:Send( packageId, data, force, addCache)
    addCache = addCache or 1
    if addCache == 1 then
        self:AddCache(packageId, data)
    end

    logs('self:IsConnected()', self:IsConnected())
    if not self:IsConnected() then return end     -- 如果没有连接，那么不真的发送，但是会缓存发送内容，等重连时重新发送

    ---@type LuaKLobbyClientEx
    local lobbyClient = self:GetKLobbyClientEx()
    if isNull(lobbyClient) then
        printError("[BattleNetworkClient] 发消息 连接载体错误")
        return
    end

    -- 设置时间戳
    if not data.ts then
        data.ts = os.time()
    end

    if packageId == self.SendPackageIds.SendGameEnd
    or packageId == self.SendPackageIds.ManualExit then
        -- 带结算的消息特别大，压缩一下
        local json = table.serialize(data)
        local zip, length = ZipUtils.GZip(json, 0)
        local writer = lobbyClient:BeginSend(packageId)
        writer:Write(zip)
        lobbyClient:EndSend(false)
    else
        lobbyClient:SendPacket(packageId, data)
    end
end

function BattleNetworkClient:BroadcastPackage(packageId, data)
    Events.Broadcast(Constants.EventNames.BattleNetworkOnReceived, packageId, data)
end

function BattleNetworkClient:Register(  )
    -- self:SetHandler(self.ReceivePackageIds.InputOutofTime, Bind(self, self.OnReceiveInputOutofTime))
    self:SetHandler(self.ReceivePackageIds.OtherDisconnect, Bind(self, self.OnOtherDisconnected))
    self:SetHandler(self.ReceivePackageIds.InputConfirm, Bind(self, self.BroadcastPackage))
    self:SetHandler(self.ReceivePackageIds.InputFinished, Bind(self, self.BroadcastPackage))
    self:SetHandler(self.ReceivePackageIds.PlayerHosting, Bind(self, self.BroadcastPackage))

    self:SetHandler(self.ReceivePackageIds.Init, function(packageId, data)
        if isNotNull(self.OnReceiveInitData) then
            self.OnReceiveInitData(packageId, data)
        else
            self:Log2File("4001的回调丢失了")
        end
    end)

    self:SetHandler(self.ReceivePackageIds.Error, function(packageId, data)
        -- if isNotNull(data.errcode) 
        -- and checkNumber(data.errcode) == 103 then
        --     -- 服务器上房间已经被销毁
        --     if BattleViewMgr.battleState == Constants.BattleState.End then
        --         -- 如果已经结算了，那么进入这里可能是因为，申请了结算以后，由于断线丢失了结算结果。这时结算那边应该会5s超时使用http请求结算结果，这边不用处理
        --     else
        --         -- 服务器已经关闭了房间，但是客户端还在重连，服务器就会返回103
        --         self:QuitBattle(BattleNetworkClient.QuitType.RoomDestroyed)
        --     end
        -- end
    end)

    self:SetHandler(self.ReceivePackageIds.RoundStart, function (packageId, data)
        if BattleViewMgr.battleState == Constants.BattleState.WaitingForStart
        or BattleViewMgr.battleState == Constants.BattleState.Processing then
            local needSync = isNotNull(data) and checkInt(data.isReconnect) or 0
            if needSync == 1 then
                -- 如果请求回合开始时，服务器发现客户端的回合数和服务器的回合数不同步了，会通知客户端重新同步逻辑
                self:Send(self.SendPackageIds.Refresh, {playerId = GameUtils.GetPlayerId(), roomId = BattleViewMgr.roomId})
                return
            end
            local round = isNotNull(data) and checkNumber(data.round) or 1
            if round > BattleMgr.totalTurnCount then
                BattleMgr:RoundStart()
                Events.Broadcast(Constants.EventNames.BattleRecordShow)
            end
        end
    end)

    self:SetHandler(self.ReceivePackageIds.PlayerLoadingProcess, function (packageId, data)
        -- 加载完成的相应消息，这个注册是为了删除缓存的waitAck消息
    end)

    self:SetHandler(self.ReceivePackageIds.AllPlayerLoadingFinished, function (packageId, data)
        -- self:Disconnect()
        -- 所有人加载完成，开始进入战斗
        BattleViewMgr.waitForStart = false
        if BattleViewMgr.battleState == Constants.BattleState.WaitingForStart then
            cs_coroutine.start(BattleViewMgr.StartBattle, BattleViewMgr)
        end
    end)

    self:SetHandler(self.ReceivePackageIds.ReceiveEmoji, function (packageId, data)
        if BattleViewMgr.battleState == Constants.BattleState.Processing then
            Events.Broadcast(Constants.EventNames.BattleReceiveEmoji, data.faceId)
        end
    end)

    self:SetHandler(self.ReceivePackageIds.BattleEnd, function (packageId, data)
        -- local json = CS.Engine.Network.KNManager.ReadPayloadString(reader, len)
        -- print("ReceivePVPAccept====>", json)
        -- self.statistic = t.statistic
        -- if t.offline == 1 then
        --     cs_coroutine.start(self.GameOver, self, t.win == 1, nil)
        -- end
        Events.Broadcast(Constants.EventNames.BattleReceiveOnlineSettlement, data)
    end)

    self:SetHandler(self.ReceivePackageIds.RefreshConfirm, function (packageId, data)
        -- print("RefreshConfirm", table.toString(data, "data"))
        self:ResendCache()
        BattleViewMgr:SyncGame(data.battleRecords, data.curRoundRecords, data.residueTimeStamp, data)
    end)

    self:SetHandler(self.ReceivePackageIds.HostTerminateGame, function (packageId, data)
        if BattleViewMgr.afterManualExit == true then
            return  -- 防止重复进入
        end
        if BattleInfo:IsPVP() then
            if isNotNull(BattleViewMgr.requestManualExit) and BattleViewMgr.requestManualExit == true then
                BattleViewMgr.afterManualExit = true
                -- 主动退出的一方走战斗失败，不能直接退出，因为要经过4013获取服务器下发的奖励
                GameUtils.AfterRequest()
                cs_coroutine.start(BattleViewMgr.GameOver, BattleViewMgr, false, {})
                -- GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.UISceneHome, hasExcluded = false }, nil, Constants.LoadingType.MainHome) 
            else
                BattleViewMgr.afterManualExit = true
                -- 另一方直接获胜
                cs_coroutine.start(BattleViewMgr.GameOver, BattleViewMgr, true, {})
            end
        else
            if isNotNull(BattleViewMgr.requestManualExit) and BattleViewMgr.requestManualExit == true then
                BattleViewMgr.afterManualExit = true
                -- 歼灭战手动退出时，等收到这个4025再断开连接，退出游戏
                GameUtils.AfterRequest()
                GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.UISceneHome, hasExcluded = false }, nil, Constants.LoadingType.MainHome)
            else
                -- 另一方什么也不干
            end
        end
    end)
end

function BattleNetworkClient:SetHandler(packageId, func)
    local instance = self:GetBattleRelayGameObject()
    if instance then
        ---@type LuaKLobbyClientEx
        local lobbyClient = self:GetKLobbyClientEx()
        if isNull(lobbyClient) then
            printError("[BattleNetworkClient] 设置回调 连接载体错误")
            return
        end
        ---@param packetId integer
        ---@param packetData table | string
        lobbyClient:SetPacketHandler(packageId, function(packetId, packetData)
            self:RemoveCache(packageId)
            func(packetId, packetData)
        end)
    end
end

function BattleNetworkClient:IsConnected(  )
    return self.isConnected_
end

function BattleNetworkClient:OnConnectHandler(isReconnect)
    -- BattleViewMgr:GetOnlineBattleData 中有个协程一直等待着这个连接成功的标记
    self.isConnected_ = true
    if isReconnect then
        if self.onReconnect then
            self.onReconnect()
        end
    end
end


function BattleNetworkClient:OnDisconnectHandler()
    self.isConnected_ = false
    Events.Broadcast(Constants.EventNames.BattleOnNetworkDisconnected)
end

function BattleNetworkClient.ReadPayloadString(reader, size)
    local bytes = reader:ReadBytes(size)
    return CS.System.Text.Encoding.UTF8.GetString(bytes)
end


function BattleNetworkClient:QuitBattle(quitType)
    if self.quitCo then
        return
    end
    if self.isQuit then
        return
    end
    GameUtils.AfterRequest()
    self.isQuit = true
    self:Disconnect()
    self.quitCo = cs_coroutine.start(function ()
        while BattleViewMgr.battleState == Constants.BattleState.Preloading and not BattleViewMgr.isLoadingFinished do
            --加载中，等待加载完成
            coroutine.yield()
        end
        local quitWord = self:GetQuitWord(quitType)
        self:Log2File(quitWord)
        GameUtils.SecondConfirm(quitWord,
        function()
            -- if BattleViewMgr then
            --     BattleViewMgr:OnDestroy()
            -- end
            GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.UISceneHome, hasExcluded = false }, nil, Constants.LoadingType.MainHome)
        end,
        function()
            -- if BattleViewMgr then
            --     BattleViewMgr:OnDestroy()
            -- end
            GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.UISceneHome, hasExcluded = false }, nil, Constants.LoadingType.MainHome)
        end)
    end)
end

function BattleNetworkClient:GetQuitWord(quitType)
    local switch = {
        [BattleNetworkClient.QuitType.OutofTime] = localize("连接超时，退出战斗"),
        [BattleNetworkClient.QuitType.PingOutofTime] = localize("连接超时，退出战斗 2"),
        [BattleNetworkClient.QuitType.OtherDisconnect] = localize("对方掉线或退出战斗"),
        [BattleNetworkClient.QuitType.Disconnect] = localize("连接中断，退出战斗"),
        [BattleNetworkClient.QuitType.ConnectFailed] = localize("连接失败，退出战斗"),
        [BattleNetworkClient.QuitType.HostDisconnect] = localize("房主终结了游戏"),
        [BattleNetworkClient.QuitType.RoomDestroyed] = localize("网络波动，游戏房间已不存在"),
    }
    return switch[quitType] or switch[BattleNetworkClient.QuitType.Disconnect]
end

function BattleNetworkClient:OnOtherDisconnected(packet, reader, len, source)
    -- if BattleViewMgr.battleState == Constants.BattleState.WaitingForStart then
    --     self:QuitBattle(BattleNetworkClient.QuitType.OtherDisconnect)
    -- end    -- self:QuitBattle(BattleNetworkClient.QuitType.OtherDisconnect)
end


function BattleNetworkClient:Log2File(msg)
    if not Config.BATTLE_TCP_LOG then return end

    local preFix = string.format("\n\n[%s][%f] : ", os.date("%m.%d %H:%M:%S", os.time()), os.clock())
    io.writeFile(self.logFilePath, preFix..msg, "a+")
end

--- 发送消息添加缓存
---@param reqId integer
---@param reqData table
function BattleNetworkClient:AddCache(reqId, reqData, force)
    local needCache = BattleNetworkClient.PacketNeedCache[reqId]
    if (isNotNull(needCache) and needCache == true) or force then
        print("[重发] add:", reqId)
        table.insert(self.waitAckQueue, {reqId = reqId, reqData = reqData})
    end
end

---@param ackId integer
function BattleNetworkClient:RemoveCache(ackId)
    local reqId = BattleNetworkClient.PacketAckMap[ackId]
    if isNotNull(reqId) then
        local findIndex = -1
        for i, req in ipairs(self.waitAckQueue) do
            if req.reqId == reqId then
                findIndex = i
                break
            end
        end
        if findIndex > 0 then
            print("[重发] remove:", reqId)
            table.remove(self.waitAckQueue, findIndex)
        end
    end
end

function BattleNetworkClient:ResendCache()
    for i, v in ipairs(self.waitAckQueue) do
        v.reqData.resend = 1
        print("[重发] send:", v.reqId)
        self:Send( v.reqId, v.reqData, false, 0)
    end
end

return BattleNetworkClient