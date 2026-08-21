-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Framework\\CHATRPC.lua

local UIConst = require("UI/UIConst")
local ChatService = require("Network/ChatService")

require("Network/protobuf")

local EventConst = require("EventConst")
local CHATRPC = {}

CHATRPC._agent = false

function CHATRPC.setAgent(agent)
	CHATRPC._agent = agent
end

local protoFrameCache = {
	kCSMsgChatSend = {
		head = {
			cmd = "kCSMsgChatSend"
		},
		["cscp.chat_send_c"] = {}
	},
	kCSMsgChatPull = {
		head = {
			cmd = "kCSMsgChatPull"
		},
		["cscp.chat_pull_c"] = {}
	},
	kCSMsgGSBlock = {
		head = {
			cmd = "kCSMsgGSBlock"
		},
		["cscp.gs_block_c"] = {}
	},
	kCSMsgSharePull = {
		head = {
			cmd = "kCSMsgSharePull"
		},
		["cscp.share_pull_c"] = {}
	}
}

function CHATRPC._packAndSend(clientPkg)
	EventCenter.sendEvent(EventConst.NETWORK_MESSAGE_SEND, clientPkg)

	local buffer = protobuf.encode("cscp.ClientPkg", clientPkg)

	ChatService.send(buffer)
end

function CHATRPC.chatSend(channel, ruid, gid, content, voice_id, voice_time, is_system, qq_extend, other)
	local clientPkg = protoFrameCache.kCSMsgChatSend
	local specEntry = clientPkg["cscp.chat_send_c"]

	specEntry.channel = channel
	specEntry.ruid = ruid
	specEntry.gid = gid
	specEntry.content = content
	specEntry.voice_id = voice_id
	specEntry.voice_time = voice_time
	specEntry.is_system = is_system
	specEntry.qq_extend = qq_extend
	specEntry.other = other

	CHATRPC._packAndSend(clientPkg)
end

function CHATRPC.chatPull(channel, seq, gid)
	local clientPkg = protoFrameCache.kCSMsgChatPull
	local specEntry = clientPkg["cscp.chat_pull_c"]

	specEntry.channel = channel
	specEntry.seq = seq
	specEntry.gid = gid

	CHATRPC._packAndSend(clientPkg)
end

function CHATRPC.gSBlock(uid, openid, hour)
	local clientPkg = protoFrameCache.kCSMsgGSBlock
	local specEntry = clientPkg["cscp.gs_block_c"]

	specEntry.uid = uid
	specEntry.openid = openid
	specEntry.hour = hour

	CHATRPC._packAndSend(clientPkg)
end

function CHATRPC.sharePull(replay_id)
	local clientPkg = protoFrameCache.kCSMsgSharePull
	local specEntry = clientPkg["cscp.share_pull_c"]

	specEntry.replay_id = replay_id

	CHATRPC._packAndSend(clientPkg)
end

function CHATRPC.dispatch(msgTable)
	EventCenter.sendEvent(EventConst.NETWORK_MESSAGE_RECV, msgTable)

	local agent = CHATRPC._agent

	if agent == false then
		return
	end

	local msgID = msgTable.head.cmd
	local ecode = msgTable.head.ecode

	if ecode ~= "kCSErrorNone" and ecode ~= "kCSErrorDefault" then
		local funcName = agent.onErrorCodeResp

		if not funcName or not funcName(agent, msgID, ecode) then
			local msgTitle = Lang.get(29942)
			local msgContent = "CHATRPC.dispatch kCSError, ecode = " .. ecode .. ", msgID = " .. msgID

			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, msgTitle, msgContent)
		end

		local dict2ListFuncName = CHATRPC._msgRespDict2ListMap[msgID]

		if CHATRPC[dict2ListFuncName] then
			local msgList = CHATRPC[dict2ListFuncName](msgTable)
			local msgCBFuncName = CHATRPC._msgRespCBMap[msgID]

			msgCBFuncName = msgCBFuncName .. "Error"

			local funcName = agent[msgCBFuncName]

			if funcName then
				funcName(agent, ecode, unpack(msgList))
			end
		end

		return
	end

	local dict2ListFuncName = CHATRPC._msgRespDict2ListMap[msgID]

	if CHATRPC[dict2ListFuncName] then
		local msgList = CHATRPC[dict2ListFuncName](msgTable)
		local msgCBFuncName = CHATRPC._msgRespCBMap[msgID]
		local funcName = agent[msgCBFuncName]

		if funcName then
			funcName(agent, unpack(msgList))
		end
	end
end

CHATRPC._CachedList0 = {}
CHATRPC._CachedList1 = {}
CHATRPC._CachedList2 = {}

function CHATRPC._dict2ListForChatSend(msgTable)
	local msgBodyTable = msgTable["cscp.chat_send_s"]
	local msgList = CHATRPC._CachedList2

	msgList[1] = msgBodyTable.action or 0
	msgList[2] = msgBodyTable.expire_at or 0

	return msgList
end

function CHATRPC._dict2ListForChatPull(msgTable)
	local msgBodyTable = msgTable["cscp.chat_pull_s"]
	local msgList = CHATRPC._CachedList1

	msgList[1] = msgBodyTable.has_new or 0

	return msgList
end

function CHATRPC._dict2ListForChatNotify(msgTable)
	local msgBodyTable = msgTable["cscp.chat_notify"]
	local msgList = CHATRPC._CachedList1

	msgList[1] = msgBodyTable.msg or {}

	return msgList
end

function CHATRPC._dict2ListForGSBlock(msgTable)
	return CHATRPC._CachedList0
end

function CHATRPC._dict2ListForAttrNotify(msgTable)
	local msgBodyTable = msgTable["cscp.attr_notify"]
	local msgList = CHATRPC._CachedList1

	msgList[1] = msgBodyTable.attr or ""

	return msgList
end

function CHATRPC._dict2ListForSharePull(msgTable)
	local msgBodyTable = msgTable["cscp.share_pull_s"]
	local msgList = CHATRPC._CachedList2

	msgList[1] = msgBodyTable.replay_id or ""
	msgList[2] = msgBodyTable.replay_data or ""

	return msgList
end

CHATRPC._msgRespCBMap = {
	kCSMsgChatPull = "onChatPullResp",
	kCSMsgChatNotify = "onChatNotify",
	kCSMsgChatSend = "onChatSendResp",
	kCSMsgSharePull = "onSharePullResp",
	kCSMsgAttrNotify = "onAttrNotify",
	kCSMsgGSBlock = "onGSBlockResp"
}
CHATRPC._msgRespDict2ListMap = {
	kCSMsgChatPull = "_dict2ListForChatPull",
	kCSMsgChatNotify = "_dict2ListForChatNotify",
	kCSMsgChatSend = "_dict2ListForChatSend",
	kCSMsgSharePull = "_dict2ListForSharePull",
	kCSMsgAttrNotify = "_dict2ListForAttrNotify",
	kCSMsgGSBlock = "_dict2ListForGSBlock"
}
CHATRPC._msgReqBackend = {
	kCSMsgChatSend = CHATRPC.CONNECT_BACKEND_CHAT,
	kCSMsgChatPull = CHATRPC.CONNECT_BACKEND_CHAT,
	kCSMsgGSBlock = CHATRPC.CONNECT_BACKEND_ZONE,
	kCSMsgSharePull = CHATRPC.CONNECT_BACKEND_ZONE
}

if not IsGLDeclared("CHATRPC") or not CHATRPC then
	GLDeclare("CHATRPC", CHATRPC)
end

return CHATRPC
