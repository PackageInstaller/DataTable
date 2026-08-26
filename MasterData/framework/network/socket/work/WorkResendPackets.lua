-- chunkname: @framework/network/socket/work/WorkResendPackets.lua

module("framework.network.socket.work.WorkResendPackets", package.seeall)

local WorkResendPackets = class("WorkResendPackets", BaseWork)

WorkResendPackets.NonResendCmdDict = {}

function WorkResendPackets:onStart()
	local unresponsiveMsgList = ConnectAliveMgr.instance:getUnresponsiveMsgList()

	ConnectAliveMgr.instance:clearUnresponsiveMsgList()

	local temp = {}

	for i = 1, #unresponsiveMsgList do
		local msgTable = unresponsiveMsgList[i]

		if not WorkResendPackets.NonResendCmdDict[msgTable.cmd] then
			msgTable.time = Time.realtimeSinceStartup

			LuaSocketMgr.instance:sendMsg(msgTable.msg, msgTable.socketId)
			table.insert(temp, msgTable.msg.__cname)
		end
	end

	if #temp > 0 then
		logNormal("前端补包协议：" .. table.concat(temp, ","))
	end

	self:onDone(true)
end

return WorkResendPackets
