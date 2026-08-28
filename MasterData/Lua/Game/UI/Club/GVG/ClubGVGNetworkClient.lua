--region import
local CS = CS

---@type ClubGVGConstants
local ClubGVGConstants = import("Game.UI.Club.GVG.ClubGVGConstants")
--endregion

--region defines
--endregion

---@class ClubGVGNetworkClient
local ClubGVGNetworkClient = Class('ClubGVGNetworkClient')

ClubGVGNetworkClient.PacketNameDict = {
    [ClubGVGConstants.PackageId.PlayerEnterGVG]        = "连接gvg服务器",
    [ClubGVGConstants.PackageId.Report]                = "战报",
    [ClubGVGConstants.PackageId.WinningStreak]         = "连胜",
    [ClubGVGConstants.PackageId.KillWinningStreak]     = "终结连胜",
    [ClubGVGConstants.PackageId.PlayerEnterGVGSuccess] = "连接gvg服务器成功",
}

-- 断线丢包时需要重发的消息
ClubGVGNetworkClient.PacketNeedCache = {}

-- 服务器回包和客户端请求的映射
ClubGVGNetworkClient.PacketAckMap = {}

---@param packageId2Handler table<integer, fun(packetId:integer, packetData:table):void>
function ClubGVGNetworkClient:__init(packageId2Handler)
    ---@type UnityEngine.GameObject
    self._go = nil
    ---@type LuaKLobbyClientEx
    self._lobbyClient = nil
    ---@type table[] @ 还未收到服务器回复的消息
    self._waitAckQueue = {}
    self._packageId2Handler = packageId2Handler
    self._playerId = GameUtils.GetPlayerId()

    self:InitClient()
end


function ClubGVGNetworkClient:__delete()
    self._packageId2Handler = nil
    self._onConnectSuccessCallback = nil
end


function ClubGVGNetworkClient:InitClient()
    ---@type LuaKLobbyClientEx
    local lobbyClient = self:GetKLobbyClientEx()
    if isNull(lobbyClient) then
        printError("[GVGNetworkClient] 网络初始化错误")
        return
    end

    lobbyClient:SetClientName('GVG')
    lobbyClient:SetPingDelta(ClubGVGConstants.PingTime)
    lobbyClient:SetTimeoutDelta(ClubGVGConstants.TimeoutTime)
    lobbyClient:SetRetryTimes(ClubGVGConstants.RetryTimeMax)
    lobbyClient:SetPacketNameDict(ClubGVGNetworkClient.PacketNameDict)
    lobbyClient:IsOpenLogListen(Config.DEBUG)

    self:RegClientHandler(lobbyClient)
end


---@param lobbyClient LuaKLobbyClientEx
function ClubGVGNetworkClient:RegClientHandler(lobbyClient)
    lobbyClient.onConnectCb = Bind(self, self.OnConnectHandler)
    lobbyClient.onTimeoutCb = Bind(self, self.OnTimeoutHandler)

    -- Register
    for packageId, handler in pairs(self._packageId2Handler or {}) do
        self:SetHandler(packageId, handler)
    end
end


function ClubGVGNetworkClient:Connect(address, port)
    local instance = self:GetNetWorkContainer()
    if isNull(instance) then return end
    ---@type LuaKLobbyClientEx
    local lobbyClient = self:GetKLobbyClientEx()
    if isNull(lobbyClient) then
        printError("[GVGNetworkClient] 连接错误")
        return
    end
    lobbyClient:Connect(address, port)
end


function ClubGVGNetworkClient:Disconnect()
    local instance = self:GetNetWorkContainer()
    if instance then
        ---@type LuaKLobbyClientEx
        local lobbyClient = self:GetKLobbyClientEx()
        if isNull(lobbyClient) then
            printError("[GVGNetworkClient] 断开连接错误")
            return
        end
        lobbyClient:Disconnect()
    end
end


function ClubGVGNetworkClient:IsConnected()
    local instance = self:GetNetWorkContainer()
    if instance then
        ---@type LuaKLobbyClientEx
        local lobbyClient = self:GetKLobbyClientEx()
        if isNotNull(lobbyClient) then
            return lobbyClient:IsConnected()
        end
    end
    return false
end


function ClubGVGNetworkClient:Dispose(  )
    local go = self._go
    if isNotNull(go) then
        CfUtils.SafeDelete(go, true)
    end
    self._go = nil

    go = CfUtils.GameObjectFind(ClubGVGConstants.Name.NetworkContainerName)
    if isNotNull(go) then
        CfUtils.SafeDelete(go, true)
    end
end


function ClubGVGNetworkClient:Send( packageId, data, force, addCache)
    addCache = addCache or 1
    if addCache == 1 then
        self:AddCache(packageId, data)
    end
    
    if not self:IsConnected() then return end     -- 如果没有连接，那么不真的发送，但是会缓存发送内容，等重连时重新发送

    ---@type LuaKLobbyClientEx
    local lobbyClient = self:GetKLobbyClientEx()
    if isNull(lobbyClient) then
        printError("[GVGNetworkClient] 发送消息错误")
        return
    end

    data.playerId = self._playerId
    lobbyClient:SendPacket(packageId, data)
end


function ClubGVGNetworkClient:RemoveCache(ackId)
    local reqId = ClubGVGNetworkClient.PacketAckMap[ackId]
    if isNotNull(reqId) then
        local findIndex = -1
        for i, req in ipairs(self._waitAckQueue) do
            if req.reqId == reqId then
                findIndex = i
                break
            end
        end
        if findIndex > 0 then
            print("[重发] remove:", reqId)
            table.remove(self._waitAckQueue, findIndex)
        end
    end
end

function ClubGVGNetworkClient:AddCache(reqId, reqData)
    local needCache = ClubGVGNetworkClient.PacketNeedCache[reqId]
    if needCache ~=nil and needCache == true then
        print("[重发] add:", reqId)
        table.insert(self._waitAckQueue, {reqId = reqId, reqData = reqData})
    end
end

function ClubGVGNetworkClient:ResendCache()
    for i, v in ipairs(self._waitAckQueue) do
        v.reqData.resend = 1
        print("[重发] send:", v.reqId)
        self:Send( v.reqId, v.reqData, false, 0)
    end
end


function ClubGVGNetworkClient:OnConnectHandler(isReconnect)
    if self._onConnectSuccessCallback then
        self._onConnectSuccessCallback(isReconnect)
    end
    self:ResendCache()
end


function ClubGVGNetworkClient:OnTimeoutHandler()
    Events.Broadcast(ClubGVGConstants.EventNames.ClinetContentTimeout)
end


---获取战斗需要的依赖的对象节点
---@return UnityEngine.GameObject
function ClubGVGNetworkClient:GetNetWorkContainer()
    if isNull(self._go) then
        self._go = CfUtils.GameObjectCreate(ClubGVGConstants.Name.NetworkContainerName)
    end
    return self._go
end


---@return LuaKLobbyClientEx
function ClubGVGNetworkClient:GetKLobbyClientEx()
    local instance = self:GetNetWorkContainer()
    if isNull(instance) then
        return nil
    end
    if isNull(self._lobbyClient) then
        local ClientLuaPath = ClubGVGConstants.LuaPath.ClientLuaPath
        local lb = GetLuaBehaviour(instance, ClientLuaPath) or AddLuaBehaviour(instance, ClientLuaPath)
        if isNull(lb) then
            return nil
        end
        if isNull(lb.Env) then
            lb:Init()
        end
        self._lobbyClient = lb.Env
    end
    return self._lobbyClient
end


---@param packageId integer
---@param func fun(packageId:integer, packageData:table):void
function ClubGVGNetworkClient:SetHandler(packageId, func)
    local instance = self:GetNetWorkContainer()
    if instance then
        ---@type LuaKLobbyClientEx
        local lobbyClient = self:GetKLobbyClientEx()
        if isNull(lobbyClient) then
            printError("[GVGNetworkClient] 设置回调失败")
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


---@param cb fun(isReconnect:boolean):void
function ClubGVGNetworkClient:SetOnConnectSuccessCallback(cb)
    self._onConnectSuccessCallback = cb
end


return ClubGVGNetworkClient
