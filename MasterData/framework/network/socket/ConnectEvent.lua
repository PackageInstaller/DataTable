-- chunkname: @framework/network/socket/ConnectEvent.lua

module("framework.network.socket.ConnectEvent", package.seeall)

local ConnectEvent = {}

ConnectEvent.OnLostConnect = 1
ConnectEvent.OnReconnectSucc = 2
ConnectEvent.OnReconnectFail = 3
ConnectEvent.OnServerKickedOut = 4
ConnectEvent.OnLostMessage = 5
ConnectEvent.OnMsgTimeout = 6
ConnectEvent.OnReconnectSucc_def = 7

return ConnectEvent
