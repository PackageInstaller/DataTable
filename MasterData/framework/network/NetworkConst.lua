-- chunkname: @framework/network/NetworkConst.lua

module("framework.network.NetworkConst", package.seeall)

local NetworkConst = {}

NetworkConst.SocketConnectTimeout = 5
NetworkConst.SystemLoginTimeout = 10
NetworkConst.UnresponsiveMsgMaxTime = 10

return NetworkConst
