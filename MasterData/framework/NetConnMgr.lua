-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/network/NetConnMgr.lua

module("framework.network.NetConnMgr", package.seeall)

local NetConnMgr = class("NetConnMgr")

NetConnMgr.DefaultThroughput = 3

function NetConnMgr:ctor()
	self._socketMgr = Framework.SocketMgr.Instance
	self._sysCmdHandler = SysCmdHandler.New()
	self._lisenters = {}
	self._requestExtAndCmdMap = {}
	self._ignoreExtCmds = {}
	self._msgHandlers = {}
	self._msgHandlerObjs = {}
	self._msgSendFilter = nil
	self._msgSendFilterObj = nil
	self._msgReceiveFilter = nil
	self._msgReceiveFilterObj = nil
	self._msgEmpty = {}
end

function NetConnMgr:init(setting, throughput)
	self._setting = setting

	if throughput == nil then
		throughput = NetConnMgr.DefaultThroughput
	end

	self._socketMgr:Init(throughput, self._handleMsg, self)

	if type(self._setting) == "table" then
		for k, v in pairs(self._setting) do
			for k2, v2 in pairs(v) do
				if k2 < 255 and #v2 >= 1 then
					self._requestExtAndCmdMap[v2[1]] = {
						k,
						k2
					}
				end
			end
		end
	end
end

function NetConnMgr:getPbUpStruct(extId, cmd)
	local msg
	local pbName = self:_getPbName(extId)

	if pbName ~= nil then
		local pbTable = _G[pbName .. "_pb"]

		if pbTable ~= nil then
			local structName = self:_getPbUpStructName(extId, cmd)

			if structName ~= nil then
				local structTable = pbTable[structName]

				if structTable ~= nil then
					msg = structTable()
				else
					printError(LogTag.NETWORK, "Cannot find proto struct for extId=" .. extId .. ",structName=" .. structName)
				end
			else
				printError(LogTag.NETWORK, "No proto struct setting for extId=" .. extId .. ",cmd=" .. cmd)
			end
		else
			printError(LogTag.NETWORK, "Cannot find proto file for extId=" .. extId .. ",pbName=" .. pbName)
		end
	else
		printError(LogTag.NETWORK, "No proto setting for extId=" .. extId)
	end

	return msg
end

function NetConnMgr:getCmdInfo2(structName)
	local extCmd = self._requestExtAndCmdMap[structName]
	local extensionId, cmdId

	if extCmd then
		connType = connType or ConnectionType.Logic
		extensionId = extCmd[1]
		cmdId = extCmd[2]
	else
		printError(LogTag.NETWORK, "Cannot find extId and cmd for structName=" .. structName)
	end

	return extensionId, cmdId
end

function NetConnMgr:getCmdInfo(msg)
	local structName = msg._cname
	local extCmd = self._requestExtAndCmdMap[structName]
	local extensionId, cmdId

	if extCmd then
		connType = connType or ConnectionType.Logic
		extensionId = extCmd[1]
		cmdId = extCmd[2]
	else
		printError(LogTag.NETWORK, "Cannot find extId and cmd for structName=" .. structName)
	end

	return extensionId, cmdId
end

function NetConnMgr:addMsgHandler(msgHandler, msgHandlerObj)
	msgHandlerObj = msgHandlerObj or false

	table.insert(self._msgHandlers, msgHandler)
	table.insert(self._msgHandlerObjs, msgHandlerObj)
end

function NetConnMgr:insertMsgHandler(index, msgHandler, msgHandlerObj)
	if index <= 1 then
		index = 1
	elseif index > #self._msgHandlers then
		index = #self._msgHandlers + 1
	end

	msgHandlerObj = msgHandlerObj or false

	table.insert(self._msgHandlers, index, msgHandler)
	table.insert(self._msgHandlerObjs, index, msgHandlerObj)
end

function NetConnMgr:setMsgSendFilter(msgFilter, msgFilterObj)
	self._msgSendFilter = msgFilter
	self._msgSendFilterObj = msgFilterObj
end

function NetConnMgr:setMsgReceiveFilter(msgFilter, msgFilterObj)
	self._msgReceiveFilter = msgFilter
	self._msgReceiveFilterObj = msgFilterObj
end

function NetConnMgr:setConnectCallback(connType, handler, handlerObj)
	self._socketMgr:SetConnectCallback(connType, handler, handlerObj)
end

function NetConnMgr:setDisConnectCallback(connType, handler, handlerObj)
	self._socketMgr:SetDisConnectCallback(connType, handler, handlerObj)
end

function NetConnMgr:disconnect(connType)
	self._socketMgr:DisConnect(connType)
end

function NetConnMgr:connect(ip, port, connType)
	return self._socketMgr:BeginConnect(ip, port, connType)
end

function NetConnMgr:resetSeqNo(connType)
	connType = connType or ConnectionType.Logic

	self._socketMgr:ResetSeqNo(connType)
end

function NetConnMgr:resetUpTag(connType)
	connType = connType or ConnectionType.Logic

	self._socketMgr:ResetUpTag(connType)
end

function NetConnMgr:ignoreLog(extId, cmd)
	local cmds = self._ignoreExtCmds[extId]

	if not cmds then
		cmds = {}
		self._ignoreExtCmds[extId] = cmds
	end

	cmds[cmd] = true

	self._socketMgr:IgnoreLog(extId, cmd)
end

function NetConnMgr:isIgnored(extId, cmd)
	local cmds = self._ignoreExtCmds[extId]

	if cmds then
		if cmds[cmd] then
			return true
		end

		return false
	end

	return false
end

function NetConnMgr:sendEmptyMsg(extId, cmd, connType)
	connType = connType or ConnectionType.Logic

	if (self._msgSendFilter or nil) and (self._msgSendFilterObj and self._msgSendFilter(self._msgSendFilterObj, extId, cmd, nil, connType) or self._msgSendFilter(extId, cmd, nil, connType)) then
		self._socketMgr:SendEmptyMsg(extId, cmd, connType)
	end
end

function NetConnMgr:sendSysMsg(cmdId, msg, connType)
	connType = connType or ConnectionType.Logic

	local data = self._sysCmdHandler:GetSendMsg(cmdId, msg, connType)

	if (self._msgSendFilter or nil) and (self._msgSendFilterObj and self._msgSendFilter(self._msgSendFilterObj, -1, cmdId, data, connType) or self._msgSendFilter(-1, cmdId, data, connType)) then
		self._socketMgr:SendSysMsg(-1, cmdId, data, connType)
	end
end

function NetConnMgr:sendMsg(msg, connType)
	local structName = msg._cname
	local extCmd = self._requestExtAndCmdMap[structName]

	if extCmd then
		connType = connType or ConnectionType.Logic

		local data = msg:SerializeToString()

		if (self._msgSendFilter or nil) and (self._msgSendFilterObj and self._msgSendFilter(self._msgSendFilterObj, extCmd[1], extCmd[2], data, connType) or self._msgSendFilter(extCmd[1], extCmd[2], data, connType)) then
			if enableLog and not self:isIgnored(extCmd[1], extCmd[2]) then
				printInfo(string.format("--->SendMsg,structName = %s, msg=%s", structName, self:_dumpMsg(msg)))
			end

			self._socketMgr:SendProtoMsg(extCmd[1], extCmd[2], data, connType)
		end
	else
		printError(LogTag.NETWORK, "Cannot find extId and cmd for structName=" .. structName)
	end
end

function NetConnMgr:forceSendMsg(extId, cmd, data, connType)
	if enableLog and not self:isIgnored(extId, cmd) then
		printInfo(string.format("--->force sendMsg,extId = %s,cmd = %s, msg=%s", extId, cmd, data))
	end

	if data == nil then
		self._socketMgr:SendEmptyMsg(extId, cmd, connType)
	else
		self._socketMgr:SendProtoMsg(extId, cmd, data, connType)
	end
end

function NetConnMgr:_dumpMsg(pbMsg, pre)
	pre = pre or ""

	if pbMsg._fields ~= nil and _G.next(pbMsg._fields) ~= nil then
		local sb = StringBuffer.New()

		pre = pre .. "    "

		sb:append("{\n")

		local tp = pre .. "    "

		for k, v in pairs(pbMsg._fields) do
			sb:append(tp)
			sb:append(k.name)
			sb:append(" = ")

			if v then
				if type(v) ~= "table" then
					sb:append(tostring(v))
				else
					sb:append(self:_dumpMsg(v, pre))
				end
			else
				sb:append(tostring(k.default_value))
			end

			sb:append("\n")
		end

		sb:append(pre .. "}")

		return sb:toString()
	else
		local sb = StringBuffer.New()

		pre = pre .. "    "

		sb:append("{\n")

		local tp = pre .. "    "

		for k, v in ipairs(pbMsg) do
			sb:append(tp)
			sb:append(k)
			sb:append(" = ")

			if v then
				if type(v) ~= "table" then
					sb:append(tostring(v))
				else
					sb:append(self:_dumpMsg(v, pre))
				end
			else
				sb:append("nil")
			end

			sb:append("\n")
		end

		sb:append(pre .. "}")

		return sb:toString()
	end

	return "null"
end

function NetConnMgr:_handleMsg(status, extId, cmd, data, downTag, connType)
	local msg, structName

	if extId == -1 then
		structName, msg = self._sysCmdHandler:GetReceiveMsg(cmd, data)
	else
		local pbName = self:_getPbName(extId)

		if pbName ~= nil then
			local pbTable = _G[pbName .. "_pb"]

			if pbTable ~= nil then
				structName = self:_getPbDownStructName(extId, cmd)

				if structName ~= nil then
					local structTable = pbTable[structName]

					if structTable ~= nil then
						msg = structTable()

						if data ~= nil then
							msg:ParseFromString(data)
						end

						if enableLog and not self:isIgnored(extId, cmd) then
							local dumpMsg = self:_dumpMsg(msg)

							printInfo(string.format("--->RecvMsg,extId=%s,cmd=%s,status=%s,structName=%s,msg=%s", extId, cmd, status, structName, dumpMsg))
						end
					else
						printError(LogTag.NETWORK, "Cannot find proto struct for extId=" .. extId .. ",structName=" .. structName)
					end
				else
					printError(LogTag.NETWORK, "No proto struct setting for extId=" .. extId .. ",cmd=" .. cmd)
				end
			else
				printError(LogTag.NETWORK, "Cannot find proto file for extId=" .. extId .. ",pbName=" .. pbName)
			end
		else
			printError(LogTag.NETWORK, "No proto setting for extId=" .. extId)
		end
	end

	if msg == nil then
		msg = self._msgEmpty
	end

	if self._msgReceiveFilter then
		if not (self._msgReceiveFilterObj and self._msgReceiveFilter(self._msgReceiveFilterObj, extId, cmd, status, structName, msg, downTag, connType) or self._msgReceiveFilter(extId, cmd, status, structName, msg, downTag, connType)) then
			return
		end
	end

	if structName then
		for i = 1, #self._msgHandlers do
			if self._msgHandlerObjs[i] then
				if enableTrycall then
					trycall(self._msgHandlers[i], self._msgHandlerObjs[i], extId, cmd, status, structName, msg, downTag, connType)
				else
					self._msgHandlers[i](self._msgHandlerObjs[i], extId, cmd, status, structName, msg, downTag, connType)
				end
			elseif enableTrycall then
				trycall(self._msgHandlers[i], extId, cmd, status, structName, msg, downTag, connType)
			else
				self._msgHandlers[i](extId, cmd, status, structName, msg, downTag, connType)
			end
		end
	end
end

function NetConnMgr:_getPbName(extId)
	local extArr = self._setting[extId]

	if extArr then
		return extArr[255]
	end

	return nil
end

function NetConnMgr:_getPbUpStructName(extId, cmd)
	print(extId, cmd)

	local extArr = self._setting[extId]

	if extArr then
		local cmdArr = extArr[cmd]

		for k, v in pairs(cmdArr) do
			print(k, v)
		end

		if cmdArr then
			return cmdArr[1]
		end
	end

	return nil
end

function NetConnMgr:_getPbDownStructName(extId, cmd)
	local extArr = self._setting[extId]

	if extArr then
		local cmdArr = extArr[cmd]

		if cmdArr then
			return cmdArr[#cmdArr]
		end
	end

	return nil
end

function NetConnMgr:nodelay(nodelayFlag, interval, resend, nc, connType)
	connType = connType or ConnectionType.Battle

	self._socketMgr:NoDelay(nodelayFlag, interval, resend, nc, connType)
end

function NetConnMgr:setWndSize(sndwnd, rcvwnd, connType)
	connType = connType or ConnectionType.Battle

	self._socketMgr:SetWndSize(sndwnd, rcvwnd, connType)
end

function NetConnMgr:setTimeout(timeout, connType)
	connType = connType or ConnectionType.Battle

	self._socketMgr:SetTimeout(timeout, connType)
end

function NetConnMgr:setMtu(mtu, connType)
	connType = connType or ConnectionType.Battle

	self._socketMgr:SetMtu(mtu, connType)
end

function NetConnMgr:setMinRto(minRto, connType)
	connType = connType or ConnectionType.Battle

	self._socketMgr:SetMinRto(minRto, connType)
end

function NetConnMgr:getStat(connType)
	connType = connType or ConnectionType.Battle

	return (self._socketMgr:GetStat(connType))
end

NetConnMgr.instance = NetConnMgr.New()

return NetConnMgr
