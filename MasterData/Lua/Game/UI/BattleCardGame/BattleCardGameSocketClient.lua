-------------------------------------------------------------------------------
-- 和风战牌 - 客户端长连接
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-08-21 14:26:19
-------------------------------------------------------------------------------

local BattleCardGameUtils = import('Game.UI.BattleCardGame.BattleCardGameUtils')

local SOCKET_PROXY_NAME  = '_BattleCardGame_Socket_Proxy_'
local SOCKET_CLIENT_PATH = 'Game.Behaviours.LuaKLobbyClientEx'

local SocketDefines = {
    CLIENT_NAME   = 'CARD',  -- 长连接名字
    PING_DELTA    = 1000,  -- 心跳检测周期（毫秒）
    TIMEOUT_DELTA = 4000,  -- 超时检测周期（毫秒）
    RETRY_TIMES   = 3,     -- 重连尝试次数
}


---@class BattleCardGameSocketClient
local BattleCardGameSocketClient = Class('BattleCardGameSocketClient')


function BattleCardGameSocketClient:__init()
    ---@type UnityEngine.GameObject
    self.socketProxyGo_ = nil

    ---@type LuaKLobbyClientEx
    self.socketClient_ = nil
end


function BattleCardGameSocketClient:__delete()
    self:SocketDestory()
end


-------------------------------------------------
-- public

--- 销毁长连接
function BattleCardGameSocketClient:SocketDestory()
    -- delete proxyGo
    CfUtils.GameObjectDelete(self.socketProxyGo_, true)
    
    -- 因为可能存在切换到A场景创建的，然后结束时先切换到了B场景，所以这里要检查一下
    local missProxyGo = CfUtils.GameObjectFind(SOCKET_PROXY_NAME)
    CfUtils.GameObjectDelete(missProxyGo, true)

    self.socketClient_  = nil
    self.socketProxyGo_ = nil
end


--- 创建长连接
function BattleCardGameSocketClient:SocketCreate()
    self:SocketDestory()

    -- check proxy gameObject
    local missProxyGo   = CfUtils.GameObjectFind(SOCKET_PROXY_NAME)
    self.socketProxyGo_ = missProxyGo or CfUtils.GameObjectCreate(SOCKET_PROXY_NAME)

    -- check socket client
    if not GetLuaBehaviour(self.socketProxyGo_, SOCKET_CLIENT_PATH) then
        AddLuaBehaviour(self.socketProxyGo_, SOCKET_CLIENT_PATH)
    end
    self.socketClient_ = CfUtils.GetLuaScr(self.socketProxyGo_, SOCKET_CLIENT_PATH)

    -- init socket client
    self.socketClient_:SetClientName(SocketDefines.CLIENT_NAME)
    self.socketClient_:SetPingDelta(SocketDefines.PING_DELTA)
    self.socketClient_:SetTimeoutDelta(SocketDefines.TIMEOUT_DELTA)
    self.socketClient_:SetRetryTimes(SocketDefines.RETRY_TIMES)
    self.socketClient_:SetPacketDefineDict(BattleCardGameUtils.PacketDefines)
    -- self.socketClient_:IsOpenLogListen(Config.DEBUG)
    self.socketClient_:IsOpenLogListen(true)

    self.socketClient_.onConnectCb = function(isReconnect)
        Events.Broadcast(BattleCardGameUtils.EventsName.SOCKET_CONNECT)
    end
    self.socketClient_.onTimeoutCb = function()
        Events.Broadcast(BattleCardGameUtils.EventsName.SOCKET_TIMEOUT)
    end
    self.socketClient_.onStopCb = function()
        Events.Broadcast(BattleCardGameUtils.EventsName.SOCKET_STOPPED)
    end

    for packetId, packetDefine in pairs(BattleCardGameUtils.PacketDefines) do
        if packetDefine.PacketEvent then
            self.socketClient_:SetPacketHandler(packetDefine.PacketId, function(_, packetData)
                Events.Broadcast(packetDefine.PacketEvent, packetData)
            end)
        end
    end
end


--- 连接服务器
---@param socketHost string
---@return boolean
function BattleCardGameSocketClient:SocketConnect(socketHost)
    if not self.socketClient_ then
        GameUtils.Toast(localize('长连接未初始化'))
        return false
    end

    self.socketClient_:Connect(socketHost)
    return true
end


--- 重接服务器
---@return boolean
function BattleCardGameSocketClient:SocketReconnect()
    if not self.socketClient_ then
        GameUtils.Toast(localize('长连接未初始化'))
        return false
    end

    self.socketClient_:SetRetryTimes(SocketDefines.RETRY_TIMES)
    self.socketClient_:Reconnect()
    return true
end


--- 发送数据包
---@param packetId integer
---@param packetData table
---@return boolean
function BattleCardGameSocketClient:SendPacket(packetId, packetData)
    if not self.socketClient_ then
        GameUtils.Toast(localize('长连接未初始化'))
        return false
    end

    if not self.socketClient_:IsConnected() then
        GameUtils.Toast(localize('指令_num_发送失败', {_num_ = packetId}))
        return false
    end

    self.socketClient_:SendPacket(packetId, packetData)
    return true
end


return BattleCardGameSocketClient
