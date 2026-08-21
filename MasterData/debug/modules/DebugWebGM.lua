-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\DebugWebGM.lua

local WebSocket = require("Network/WebSocket")
local json = require("cjson")
local EventConst = require("EventConst")
local tfcapi = require("libconapi")
local UserData = require("Helper/UserData")
local SvrListManager = require("System/SvrListManager")
local UrlConfig = require("Network/UrlConfig")
local DebugBattle = require("Debug/Modules/DebugBattle")
local DebugLuacov = require("Debug/Modules/DebugLuacov")
local FileUtils = Framework.Tools.FileUtils
local DebugWebConnectBase = {}

function DebugWebConnectBase.connect(url, successCB, recvCB)
	local newWs = WebSocket()

	newWs:setRecvCallback(recvCB)
	newWs:setConnectSuccessCB(successCB)
	newWs:connect(url)

	return newWs
end

function DebugWebConnectBase.destroy(ws)
	ws:destroy()
end

function DebugWebConnectBase.disconnect(ws)
	ws:cancel()
end

function DebugWebConnectBase.isConnected(ws)
	return ws:isConnected()
end

function DebugWebConnectBase.send(ws, bytes)
	ws:send(bytes)
end

local DebugWebGM = {}
local self = DebugWebGM

if not IsGLDeclared("DebugWebGM") or not DebugWebGM then
	GLDeclare("DebugWebGM", DebugWebGM)
end

function DebugWebGM.SendOperation_Usecase(param)
	self.send("DebugWebGM_SendOperation_Usecase=" .. param .. ";")
end

local function onReceiveCallback(msg)
	MsgManager.notice(msg)

	local data = {}
	local succ, t = pcall(json.decode, msg)

	if succ and type(t) == "table" then
		data = t
	else
		MsgManager.notice("解析错误")

		return
	end

	if data.type == "proto" then
		local msgStr = loadstring("return " .. data.data)

		succ, msg = pcall(msgStr)

		if succ and type(msg) == "table" then
			RPC._packAndSend(msg)
		end
	elseif data.type == "gm" then
		MsgManager.notice(data.data)
		RPC.executeGM(data.data)
	elseif data.type == "battle_test" then
		MsgManager.notice(data.data)
		DebugBattle.enterBattleTest(null, null, data.data)
	elseif data.type == "battle_test_ai" then
		MsgManager.notice(data.data)
		DebugBattle.enterBattleTestAI(null, null, data.data)
	elseif data.type == "luacov" then
		MsgManager.notice(data.data)

		if data.data == "init" then
			DebugLuacov.init()
		elseif data.data == "output" then
			DebugLuacov.output()
		elseif data.data == "shutdown" then
			DebugLuacov.shutdown()
		elseif data.data == "save_stats" then
			DebugLuacov.save_stats()
		elseif data.data == "merge" then
			DebugLuacov.merge(data.param)
		elseif data.data == "reset" then
			DebugLuacov.reset()
		end
	end
end

local function string_indexOf(s, pattern, init)
	init = init or 0

	local index = string.find(s, pattern, init, true)

	return index or -1
end

local function RPC_dispatch(msgTable)
	EventCenter.sendEvent(EventConst.NETWORK_MESSAGE_RECV, msgTable)

	local agent = RPC._agent

	if agent == false then
		return
	end

	if msgTable.head and msgTable.head.cmd ~= "kCSMsgHeartBeat" and msgTable.head.cmd ~= "kCSMsgChatHeartBeat" then
		local sendMsg = utils.dumpTab(msgTable)

		if msgTable.head.cmd == "kCSMsgRoleLogin" then
			sendMsg = sendMsg .. "\nDebugWebGM_username=" .. UserData.loadCommonData("debug_login_name") .. ";"

			local idx1 = string_indexOf(sendMsg, "zone_first_nid")
			local idx2 = string_indexOf(sendMsg, "=", idx1)
			local idx3 = string_indexOf(sendMsg, ",", idx2)
			local idx4 = string_indexOf(sendMsg, "}", idx2)
			local idx_final = idx3

			if idx4 < idx_final then
				idx_final = idx4
			end

			local substr = string.sub(sendMsg, idx2 + 2, idx_final - 2)
			local nodeid = tonumber(substr)
			local svrname = SvrListManager.getServerName(nodeid)

			if svrname ~= nil then
				sendMsg = sendMsg .. "\nDebugWebGM_svrname=" .. svrname .. ";"
			end

			local spMark = UrlConfig.getSpMark()

			sendMsg = sendMsg .. "\nDebugWebGM_spMark=" .. spMark .. ";"

			local postfix = UrlConfig.postfix

			sendMsg = sendMsg .. "\nDebugWebGM_postfix=" .. postfix .. ";"
		end

		self.send(sendMsg)
	end

	local msgID = msgTable.head.cmd
	local ecode = msgTable.head.ecode

	if RPC.SendTimes[msgID] then
		RPC.SendTimes[msgID] = nil
	end

	if ecode ~= "kCSErrorNone" and ecode ~= "kCSErrorDefault" then
		local checkSpec = msgID == "kCSMsgCDKey" and ecode == "kCSErrorCDKeyUsingTooMany"

		if not checkSpec then
			local funcName = agent.onErrorCodeResp

			if not funcName or not funcName(agent, msgID, ecode) then
				local msgTitle = "服务器异常"
				local msgContent = "RPC.dispatch kCSError, ecode = " .. ecode .. ", msgID = " .. msgID

				UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, msgTitle, msgContent)
			end
		end

		local dict2ListFuncName = RPC._msgRespDict2ListMap[msgID]

		if RPC[dict2ListFuncName] then
			local msgList = RPC[dict2ListFuncName](msgTable)
			local msgCBFuncName = RPC._msgRespCBMap[msgID]

			msgCBFuncName = msgCBFuncName .. "Error"

			local funcName = agent[msgCBFuncName]

			if funcName then
				funcName(agent, ecode, unpack(msgList))
			end
		end

		return
	end

	local dict2ListFuncName = RPC._msgRespDict2ListMap[msgID]

	if RPC[dict2ListFuncName] then
		local msgList = RPC[dict2ListFuncName](msgTable)
		local msgCBFuncName = RPC._msgRespCBMap[msgID]
		local funcName = agent[msgCBFuncName]

		if funcName then
			funcName(agent, unpack(msgList))
		end
	end
end

local function RPC_packAndSend(clientPkg)
	if RPC.SendPacksInLimit(clientPkg.head.cmd) then
		return
	end

	if clientPkg.head and clientPkg.head.cmd ~= "kCSMsgHeartBeat" and clientPkg.head.cmd ~= "kCSMsgChatHeartBeat" then
		self.send(utils.dumpTab(clientPkg))
	end

	EventCenter.sendEvent(EventConst.NETWORK_MESSAGE_SEND, clientPkg)

	local connect = RPC._getConnectHandleByCmd(clientPkg.head.cmd)

	if connect == nil then
		return
	end

	if connect >= 0 then
		local buffer = protobuf.encode("csp.ClientPkg", clientPkg)

		tfcapi.sendMsg(connect, buffer, string.len(buffer))
	end
end

local function get_client_path()
	local handle = io.popen("cd")
	local result = handle:read("*a")

	handle:close()

	local path = result:gsub("^%s*(.-)%s*$", "%1")

	path = string.gsub(path, "\\", "/")

	return path
end

local function getProtoPath()
	local client_path = get_client_path()
	local mid_path = "/Assets/"
	local aft_path = FileUtils.GetProtoRelativePath() .. "/plain"
	local proto_path = client_path .. mid_path .. aft_path

	return proto_path
end

local function onConnectCallback()
	MsgManager.notice("连接测试自动化工具成功")

	RPC.dispatch = RPC_dispatch
	RPC._packAndSend = RPC_packAndSend

	local sendMsg = "Connect to antman-tool-meta with some data.\n"
	local client_path = get_client_path()

	sendMsg = sendMsg .. "\nclient_path=" .. client_path .. ";"

	local proto_path = getProtoPath()

	sendMsg = sendMsg .. "\nproto_path=" .. proto_path .. ";"

	local username = UserData.loadCommonData("debug_login_name")

	sendMsg = sendMsg .. "\nDebugWebGM_username=" .. username .. ";"

	if CurAvatar then
		sendMsg = sendMsg .. "\nuid\"" .. CurAvatar.uid .. "\""
		sendMsg = sendMsg .. "\nDebugWebGM_svrname=" .. CurAvatar.serverName .. ";"

		local spMark = UrlConfig.getSpMark()

		sendMsg = sendMsg .. "\nDebugWebGM_spMark=" .. spMark .. ";"

		local postfix = UrlConfig.postfix

		sendMsg = sendMsg .. "\nDebugWebGM_postfix=" .. postfix .. ";"
		sendMsg = sendMsg .. "\nzone_first_nid=" .. SvrListManager.getSelectedSvrID() .. ","
	end

	self.send(sendMsg)
end

function DebugWebGM.send(bytes)
	if self.ws then
		self.ws:send(bytes)
	end
end

function DebugWebGM.close()
	if self.ws then
		MsgManager.notice("断连测试自动化工具成功")
		DebugWebConnectBase.disconnect(self.ws)
	end
end

function DebugWebGM.init()
	if not self.ws then
		MsgManager.notice("尝试连接 自动化工具")

		self.ws = DebugWebConnectBase.connect("ws://127.0.0.1:8888", onConnectCallback, onReceiveCallback)
	end
end

return DebugWebGM
