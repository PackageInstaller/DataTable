-- chunkname: @framework/network/socket/pre/AliveCheckPreSender.lua

module("framework.network.socket.pre.AliveCheckPreSender", package.seeall)

local AliveCheckPreSender = class("AliveCheckPreSender", BasePreSender)

function AliveCheckPreSender:ctor()
	AliveCheckPreSender.super.ctor(self)

	self._sendCmdInfoList = {}
end

function AliveCheckPreSender:getFirstUnresponsiveMsg()
	return self._sendCmdInfoList[1]
end

function AliveCheckPreSender:getUnresponsiveMsgList()
	return self._sendCmdInfoList
end

function AliveCheckPreSender:clear()
	self._sendCmdInfoList = {}
end

function AliveCheckPreSender:preSendSysMsg(cmd, dataTable, socketId)
	return
end

function AliveCheckPreSender:preSendProto(cmd, proto, socketId)
	local sendInfo = {}

	sendInfo.cmd = cmd
	sendInfo.msg = proto
	sendInfo.socketId = socketId
	sendInfo.time = Time.realtimeSinceStartup

	table.insert(self._sendCmdInfoList, sendInfo)
end

function AliveCheckPreSender:onReceiveMsg(cmd)
	for i, v in ipairs(self._sendCmdInfoList) do
		if v.cmd == cmd then
			table.remove(self._sendCmdInfoList, i)

			if i ~= 1 then
				if self._sendCmdInfoList[1] then
					logError("打个log：消息不是按顺序收到的！跳跃了 " .. i - 1 .. " 个包 期待的cmd = " .. self._sendCmdInfoList[1])
				end
			end

			break
		end
	end
end

function AliveCheckPreSender:ignoreUnimportantCmds(cmd)
	for i = #self._sendCmdInfoList, 1, -1 do
		local sendInfo = self._sendCmdInfoList[i]

		if GameMsgLockState.IgnoreCmds[sendInfo.cmd] then
			table.remove(self._sendCmdInfoList, i)
		end
	end
end

return AliveCheckPreSender
