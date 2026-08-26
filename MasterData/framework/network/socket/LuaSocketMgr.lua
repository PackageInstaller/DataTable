-- chunkname: @framework/network/socket/LuaSocketMgr.lua

module("framework.network.socket.LuaSocketMgr", package.seeall)

local LuaSocketMgr = class("LuaSocketMgr")

function LuaSocketMgr:ctor()
	self._systemCmds = nil
	self._moduleCmds = nil
	self._preSenders = {}
	self._preReceivers = {}
	self._req2CmdDict = {}
	self._res2CmdDict = {}
	self._csSocketMgr = SLFramework.SocketMgr.Instance
	self._ignoreSomeCmdLog = false
	self._ignoreCmds = {}
	self._headerSize4Send = 11
end

function LuaSocketMgr:setIgnoreSomeCmdLog(cmds)
	if not cmds then
		self._ignoreSomeCmdLog = false

		return
	end

	self._ignoreSomeCmdLog = true

	for _, cmdName in ipairs(cmds) do
		self._ignoreCmds[cmdName] = true
	end
end

function LuaSocketMgr:_canLog(protoName)
	return not self._ignoreSomeCmdLog or not self._ignoreCmds[protoName]
end

function LuaSocketMgr:init(systemCmds, moduleCmds)
	self._systemCmds = systemCmds
	self._moduleCmds = moduleCmds

	for k, v in pairs(self._moduleCmds) do
		if #v == 3 then
			self._req2CmdDict[v[2]] = k
			self._res2CmdDict[v[3]] = k
		elseif #v == 2 then
			self._res2CmdDict[v[2]] = k
		end
	end

	self._csSocketMgr:SetLuaHandler(self._onReceiveMainMsg, self, SocketId.Main)
end

function LuaSocketMgr:reInit()
	self._csSocketMgr:Dispose()
	self._csSocketMgr:SetLuaHandler(self._onReceiveMainMsg, self, SocketId.Main)
end

function LuaSocketMgr:registerPreSender(preSender)
	table.insert(self._preSenders, preSender)
end

function LuaSocketMgr:unregisterPreSender(preSender)
	if not preSender then
		return
	end

	for i, v in ipairs(self._preSenders) do
		if v == preSender then
			table.remove(self._preSenders, i)

			break
		end
	end
end

function LuaSocketMgr:registerPreReceiver(preReceiver)
	table.insert(self._preReceivers, preReceiver)
end

function LuaSocketMgr:unregisterPreReceiver(preReceiver)
	if not preReceiver then
		return
	end

	for i, v in ipairs(self._preReceivers) do
		if v == preReceiver then
			table.remove(self._preReceivers, i)

			break
		end
	end
end

function LuaSocketMgr:setConnectBeginCallback(connectBeginCall, luaTarget, socketId)
	self._csSocketMgr:SetConnectBeginCallback(connectBeginCall, luaTarget, socketId or SocketId.Main)
end

function LuaSocketMgr:setConnectEndCallback(connectEndCall, luaTarget, socketId)
	self._csSocketMgr:setConnectEndCallback(connectEndCall, luaTarget, socketId or SocketId.Main)
end

function LuaSocketMgr:setSeqId(seqId, socketId)
	self._csSocketMgr:SetSeqId(seqId, socketId or SocketId.Main)
end

function LuaSocketMgr:beginConnect(ip, port, socketId)
	return self._csSocketMgr:BeginConnect(ip, port, socketId or SocketId.Main)
end

function LuaSocketMgr:endConnect(socketId)
	self._csSocketMgr:EndConnect(socketId or SocketId.Main)
end

function LuaSocketMgr:isConnected(socketId)
	return self._csSocketMgr:IsConnected(socketId or SocketId.Main)
end

function LuaSocketMgr:sendSysMsg(cmd, dataTable, socketId)
	local isBlockSend

	for _, preSender in ipairs(self._preSenders) do
		isBlockSend = preSender.preSendSysMsg and preSender:preSendSysMsg(cmd, dataTable, socketId or SocketId.Main) or isBlockSend
	end

	if not isBlockSend then
		self:reallySendSysMsg(cmd, dataTable, socketId or SocketId.Main)
	end
end

function LuaSocketMgr:getSysMsgSendBuffLen(cmd, dataTable)
	local buffer = self._systemCmds.GetSendMsg(cmd, dataTable)

	return string.len(buffer) + self._headerSize4Send
end

function LuaSocketMgr:reallySendSysMsg(cmd, dataTable, socketId)
	local buffer = self._systemCmds.GetSendMsg(cmd, dataTable)

	self._csSocketMgr:SendMsg(cmd, buffer, socketId or SocketId.Main)

	local requestName = self._systemCmds.GetRequestName(cmd)

	if canLogNormal and isDebugBuild and self:_canLog(requestName) then
		logNormal(string.format("==> Send Sys Msg, cmd:%d %s size:%d\n%s", cmd, requestName, string.len(buffer), cjson.encode(dataTable)))
	end
end

function LuaSocketMgr:sendMsg(proto, socketId)
	local protoName = proto.__cname
	local cmd = self._req2CmdDict[protoName]

	if cmd then
		local isBlockSend

		for _, preSender in ipairs(self._preSenders) do
			if preSender.blockSendProto then
				isBlockSend = preSender:blockSendProto(cmd, proto, socketId or SocketId.Main)

				if isBlockSend then
					break
				end
			end
		end

		if not isBlockSend then
			for _, preSender in ipairs(self._preSenders) do
				if preSender.preSendProto then
					preSender:preSendProto(cmd, proto, socketId or SocketId.Main)
				end
			end

			self:reallySendMsg(cmd, proto, socketId or SocketId.Main)
		else
			logWarn("LuaSocketMgr block " .. protoName)
		end
	else
		logError("cmd not exist: " .. protoName)
	end
end

function LuaSocketMgr:reallySendMsg(cmd, proto, socketId)
	local buffer = proto:SerializeToString()

	self._csSocketMgr:SendMsg(cmd, buffer, socketId or SocketId.Main)

	local requestName = proto.__cname

	if canLogNormal and isDebugBuild and self:_canLog(requestName) then
		logNormal(string.format("==> Send Msg, cmd:%d %s size:%d\n%s", cmd, requestName, string.len(buffer), tostring(proto)))
	end
end

function LuaSocketMgr:_onReceiveMainMsg(resultCode, cmd, data, downTag, socketId)
	local systemCmd = self._systemCmds[cmd]

	if systemCmd then
		local msg = self._systemCmds.GetReceiveMsg(cmd, data)
		local responseName = self._systemCmds.GetResponseName(cmd)

		if canLogNormal and isDebugBuild and self:_canLog(responseName) then
			logNormal(string.format("<== Recv Sys Msg, cmd:%d %s size:%d resultCode:%d downTag:%d\n%s", cmd, responseName, string.len(data), resultCode, downTag, cjson.encode(msg)))
		end

		local isBlockReceive

		for _, preReceiver in ipairs(self._preReceivers) do
			isBlockReceive = preReceiver.preReceiveSysMsg and preReceiver:preReceiveSysMsg(resultCode, cmd, responseName, msg, downTag, socketId) or isBlockReceive
		end

		if not isBlockReceive then
			self:_rpcReceiveMsg(systemCmd[1], true, resultCode, cmd, responseName, msg, downTag, socketId)
		end
	else
		local moduleCmd = self._moduleCmds[cmd]

		if not moduleCmd then
			logError("cmd not exist: " .. cmd)

			return
		end

		if #moduleCmd == 3 then
			if not moduleCmd[3] then
				local responseName = moduleCmd[2]
				local pbName = moduleCmd[1] .. "Module_pb"
				local pbTable = getGlobal(pbName) or addGlobalModule("modules.proto." .. pbName, pbName)

				if not pbTable then
					logError(string.format("pb not exist: %s res = %s", pbName, responseName))

					return
				end

				local resStruct = pbTable[responseName]
				local msg = resStruct()

				msg:ParseFromString(data)

				if canLogNormal and isDebugBuild and self:_canLog(responseName) then
					local colorTagStart = resultCode == 0 and "" or "<color=#FFA500>"
					local colorTagEnd = resultCode == 0 and "" or "</color>"

					logNormal(string.format("%s<== Recv Msg, cmd:%d %s size:%d resultCode:%d downTag:%d%s\n%s", colorTagStart, cmd, responseName, string.len(data), resultCode, downTag, colorTagEnd, tostring(msg)))

					if string.len(data) > 1000 then
						local msgStr = tostring(msg)
						local lines = string.split(msgStr, "\n")
						local count = math.ceil(#lines / 500)

						for i = 1, count do
							local startIdx = (i - 1) * 500 + 1
							local endIdx = math.min(i * 500, #lines)

							logNormal(table.concat(lines, "\n", startIdx, endIdx))
						end
					end
				end

				local isBlockReceive

				for _, preReceiver in ipairs(self._preReceivers) do
					isBlockReceive = preReceiver.preReceiveMsg and preReceiver:preReceiveMsg(resultCode, cmd, responseName, msg, downTag, socketId) or isBlockReceive
				end

				if not isBlockReceive then
					self:_rpcReceiveMsg(moduleCmd[1], false, resultCode, cmd, responseName, msg, downTag, socketId)
				end
			end
		end
	end
end

function LuaSocketMgr:_rpcReceiveMsg(moduleName, isSystemCmd, resultCode, cmd, responseName, msg, downTag, socketId)
	if isSystemCmd then
		SystemLoginRpc.instance:onReceiveMsg(resultCode, cmd, responseName, msg, downTag, socketId)

		return
	end

	local rpc = getGlobal(moduleName .. "Rpc")

	if rpc and rpc["onReceive" .. responseName] then
		rpc.instance:onReceiveMsg(resultCode, cmd, responseName, msg, downTag, socketId)

		return
	else
		local moduleSetting = ModuleMgr.instance:getSetting(moduleName)

		if moduleSetting and moduleSetting.rpc then
			for _, rpcName in ipairs(moduleSetting.rpc) do
				rpc = getGlobal(rpcName)

				if rpc and rpc["onReceive" .. responseName] then
					rpc.instance:onReceiveMsg(resultCode, cmd, responseName, msg, downTag, socketId)

					return
				end
			end
		end
	end

	logError(string.format("cmd_%d onReceive%s = nil, module:%s", cmd, responseName, moduleName))
end

function LuaSocketMgr:getCmdByPbStructName(pbStructName)
	local cmd = self._req2CmdDict[pbStructName]

	cmd = cmd or self._res2CmdDict[pbStructName]

	return cmd
end

function LuaSocketMgr:getCmdSettingDict()
	return self._moduleCmds
end

function LuaSocketMgr:getCmdSetting(cmd)
	return self._moduleCmds[cmd]
end

function LuaSocketMgr:getSysCmdSetting(cmd)
	return self._systemCmds[cmd]
end

function LuaSocketMgr:getSystemCmd()
	return self._systemCmds
end

LuaSocketMgr.instance = LuaSocketMgr.New()

return LuaSocketMgr
