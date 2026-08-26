-- chunkname: @framework/network/socket/work/WorkSystemLogout.lua

module("framework.network.socket.work.WorkSystemLogout", package.seeall)

local WorkSystemLogout = class("WorkSystemLogout", BaseWork)

function WorkSystemLogout:onStart(context)
	LuaSocketMgr.instance:endConnect()
	PartyGameController.instance:KcpEndConnect()
	self:onDone(true)
end

return WorkSystemLogout
