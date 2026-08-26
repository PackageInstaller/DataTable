-- chunkname: @framework/network/socket/work/WorkSocketDispose.lua

module("framework.network.socket.work.WorkSocketDispose", package.seeall)

local WorkSocketDispose = class("WorkSocketDispose", BaseWork)

function WorkSocketDispose:onStart(context)
	LuaSocketMgr.instance:reInit()
	self:onDone(true)
end

return WorkSocketDispose
