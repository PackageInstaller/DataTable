-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\ChatMixin.lua

local ResChatMisc = require("ClientData/ResChatMisc")
local ResZChatTrigger = require("ClientData/ResZChatTrigger")
local ChatService = require("Network/ChatService")
local ResRedPacketThankContent = require("ClientData/ResRedPacketThankContent")
local ResItem = require("ClientData/ResItem")
local ResClanBattleSysMsg = require("ClientData/ResClanBattleSysMsg")
local ResClanBattleMemberAchieve = require("ClientData/ResClanBattleMemberAchieve")
local ResClanBattleClanAchieve = require("ClientData/ResClanBattleClanAchieve")
local ResColor = require("ClientData/ResColor")
local ResClanBattleSkill = require("ClientData/ResClanBattleSkill")
local ResChatDynamicIcon = require("ClientData/ResChatDynamicIcon")
local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResItemClientConfig = require("ClientData/ResItemClientConfig")
local ResDrawPoolClient = require("ClientData/ResDrawPoolClient")
local ResDrawMisc = require("ClientData/ResDrawMisc")
local ResHero = require("ClientData/ResHero")
local ResGiftDrawMisc = require("ClientData/ResGiftDrawMisc")
local ResMasterNotice = require("ClientData/ResMasterNotice")
local Const = Const
local GameFsm = GameFsm
local ChatMixin = {}
local repeatMap = {}
local pullHistory = {}
local redPacketClaimMap = {}
local redPacketThxMap = {}
local fakeSeq = 0
local pullHistoryFlag = false

function ChatMixin:initChatMixin(baseData, syncData)
	RedDotManager.setKeyState(UIConst.RD_HINT_CHAT_PRIVATE, false)
	RPC.wChatRegister()

	ClientUtils.record.checkRecord = {}

	self:initChatFlag(baseData.necessary.misc)
end

function ChatMixin:initChatFlag(data)
	return
end

function ChatMixin:postinitChatMixin(...)
	MsgManager.initMsg()
end

function ChatMixin:destroyChatMixin(...)
	repeatMap = {}
	redPacketClaimMap = {}
	redPacketThxMap = {}
	pullHistoryFlag = false
	self.checkMsgJumpMap = {}

	ChatService.disconnect()
	MsgManager.saveMsg()
end

function ChatMixin:onZChatRegisterResp(uid, pos, identity, connkey, connip, connport)
	return
end

function ChatMixin:onWChatRegisterResp(uid, token, world_id, zone_id, clan_gid)
	pullHistoryFlag = true
	self.chatWorldGid = world_id
	self.chatZoneId = zone_id
	self.chatCircleId = clan_gid

	ChatService.connect(token, Slot(self._onWChatConnectSuccess, self))
end

function ChatMixin:getCircleChatId(...)
	return self.chatCircleId
end

function ChatMixin:_onWChatConnectSuccess(...)
	if pullHistoryFlag == true then
		pullHistoryFlag = false

		CHATRPC.chatPull(Const.CHANNEL_WORLD, 0, self.chatWorldGid)
		CHATRPC.chatPull(Const.CHANNEL_SERVER, 0, self.chatZoneId)

		local newestSeq = MsgManager.getNewestPrivateSeq()

		CHATRPC.chatPull(Const.CHANNEL_PRIVATE, newestSeq)

		if self:isInCircle() == true and self:getCircleChatId() ~= nil then
			CHATRPC.chatPull(Const.CHANNEL_GUILD, 0, self:getCircleChatId())

			pullHistory[Const.CHANNEL_GUILD] = true
		end

		pullHistory[Const.CHANNEL_WORLD] = true
		pullHistory[Const.CHANNEL_SERVER] = true
	end
end

function ChatMixin:onWChatChannelUpdateResp(channels, code)
	if channels ~= nil then
		for _, channel in ipairs(channels) do
			if channel.type == Const.CHANNEL_TO_TYPE[Const.CHANNEL_WORLD] then
				self.chatWorldGid = channel.gid
			elseif channel.type == Const.CHANNEL_TO_TYPE[Const.CHANNEL_GUILD] then
				self.chatCircleId = channel.gid

				if self.needSendCircleJoinMsg == true then
					self:_sendWhenJoin()

					self.needSendCircleJoinMsg = nil
				end
			end
		end
	end
end

function ChatMixin:onAttrNotify(attr)
	local data = ClientUtils.string2Table(attr)

	self.isGs = data.gs == 1
	ClientUtils.record.forbidChat = data.block == 1
	ClientUtils.record.nextChatFreeTime = data.mutetm
end

function ChatMixin:onGSBlockResp(...)
	MsgManager.notice(Lang.get(1819))
end

local function sortByTime(v1, v2)
	return (v1.time or 0) < (v2.time or 0)
end

function ChatMixin:onChatSystemNotify(channel, msg, history, sub_channel)
	local needServerLan = RegionConst.SERVER_LANUAGE_MAP[RegionUtils.curLanguage]

	for i, msgItem in ipairs(msg) do
		msgItem.channel = channel
		msgItem.sub_channel = Const.CHANNEL_NONE
		msgItem.sattr = {}
		msgItem.share = -1
		msgItem.other = ""
		msgItem.share_content = {}

		if needServerLan then
			for _, info in ipairs(msgItem.multi_language_content or {}) do
				if info.language == needServerLan then
					msgItem.content = info.content
				end
			end
		end
	end

	self:onChatNotify(msg)
end

function ChatMixin:onChatNotify(msg)
	local isJump = false
	local channel

	if #msg > 0 then
		table.sort(msg, sortByTime)

		channel = msg[1].channel
	end

	if channel == nil then
		return
	end

	if channel == Const.CHANNEL_PRIVATE then
		local playerUid = self.uid

		for i = 1, #msg do
			local msgitem = msg[i]

			self:checkMyChatAttr(msgitem)
			self:checkMsg(msgitem)

			local senderUid = msgitem.suid
			local receiverUid = msgitem.ruid
			local oppoUid = playerUid == senderUid and receiverUid or senderUid

			if not MsgManager.isPrivateRepeat(msgitem.seq) and not self:inMyBlackList(oppoUid) and not MsgManager.isInShield(msgitem.suid) then
				MsgManager.receiveFromServer(channel, msgitem)
			end
		end
	else
		if channel == Const.CHANNEL_BP_PVP and #msg > 0 then
			self:updataTopPvpBulletSeqMaxId(msg[#msg].seq)
		end

		local historyCache

		for i = 1, #msg do
			isJump = false

			local msgitem = msg[i]

			if channel == Const.CHANNEL_WORLD or channel == Const.CHANNEL_SERVER or channel == Const.CHANNEL_GUILD then
				if repeatMap[msgitem.seq] then
					isJump = true
				else
					repeatMap[msgitem.seq] = msgitem
				end

				if channel == Const.CHANNEL_WORLD and CurAvatar:forbidWorldChannel() then
					isJump = true
				end
			end

			self:checkMyChatAttr(msgitem)

			if isJump == false and not MsgManager.isInShield(msgitem.suid) and not self:checkMsg(msgitem) then
				msgitem.hideBulletHistory = false

				if pullHistory[channel] == true then
					historyCache = historyCache or {}

					table.insert(historyCache, msgitem)
				else
					MsgManager.receiveFromServer(channel, msgitem)
				end
			end
		end

		if historyCache ~= nil then
			for i = 1, #historyCache do
				local msgitem = historyCache[i]

				if i < #historyCache - Const.BULLET_NUM_LIMIT then
					msgitem.hideBulletHistory = true
				end

				MsgManager.receiveFromServer(channel, msgitem)
			end

			pullHistory[channel] = nil
		end
	end
end

function ChatMixin:onChatPullResp(hasNew)
	if hasNew == 1 then
		local ui = UIManager.tryGetUI("topPvpBpMainDlg")

		if ui and ui:getVisible() then
			local showFlag = ui.showBulletFlag

			if showFlag == true then
				local reqId = ui.maxReq
				local roomData = ui.roomdata

				if reqId and roomData then
					CHATRPC.chatPull("kMsgChannelTypeBarrage", reqId, roomData.room_id)
				end
			end
		end
	end
end

function ChatMixin:checkMsg(msg)
	self:checkMsgLegal(msg)
	self:checkLargeEmoji(msg)
	self:checkShareMsg(msg)

	local isSpec, isJump = self:checkSpecialSysNotice(msg)

	if not isSpec then
		isJump = self:checkJumpRedThxMsg(msg)
		isJump = isJump or self:checkRedPacket(msg)
	end

	if msg.share_content then
		msg.share_content.other = ""
	end

	return isJump
end

function ChatMixin:checkSpecialSysNotice(msg)
	if msg.time and msg.time < 1625367360 then
		msg.share_content.specData = {}

		return
	end

	if msg == nil or msg.content == nil or msg.channel == Const.MAIN_CHANNEL_SYSTEM then
		return
	end

	if msg.share == Const.CHAT_SHARE_TYPE.SPE_NOTICE and msg.share_content.other then
		local msgTable = protobuf.decode("csp.CSSpecialNoticeData", msg.share_content.other)

		msg.share_content.specData = {}

		if msgTable then
			local isJump = false
			local type = msgTable.notice_type

			if type == Const.CHAT_SPEC_NOTICE_TYPE.TRIGGER then
				isJump = self:_decodeTriggerNotice(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.CIRCLE_BATTLE then
				isJump = self:_decodeCircleBattleNotice(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.CIRCLE_SHARE then
				isJump = self:_decodeCircleShareNotice(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.DYNAMIC_ICON then
				isJump = self:_decodeDynamicIconData(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.HOUSE_SHARE then
				isJump = self:_decodeHouseShareNotice(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.VALENTINE_SHARE then
				isJump = self:_decodeValentineShareNotice(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.DRAW then
				isJump = self:_decodeDrawNotice(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.GIFT_DRAW then
				isJump = self:_decodeGiftDrawNotice(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.MASTER_APPLY then
				isJump = self:_decodeMasterApplyNotice(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.APPRENTICE_APPLY then
				isJump = self:_decodeApprenticeApplyNotice(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.DEVELOP_GUIDE_REQ then
				isJump = self:_decodeDevelopGuideReqNotice(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.DEVELOP_GUIDE_RESP then
				isJump = self:_decodeDevelopGuideRespNotice(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.BATTLE_GUIDE_REQ then
				isJump = self:_decodeBattleGuideReqNotice(msg, msgTable)
			elseif type == Const.CHAT_SPEC_NOTICE_TYPE.BATTLE_GUIDE_RESP then
				isJump = self:_decodeBattleGuideRespNotice(msg, msgTable)
			end

			return true, isJump
		end
	end
end

function ChatMixin:_decodeDynamicIconData(msg, msgTable)
	local data = msgTable.dynamic_expression

	data.notice_type = msgTable.notice_type

	local info = ResChatDynamicIcon[data.id]

	if info then
		msg.content = info.icon_name
	end

	msg.share_content.specData = data
end

function ChatMixin:_decodeCircleShareNotice(msg, msgTable)
	local data = msgTable.clan_share

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_WORLD
	msg.share_content.specData = data
end

function ChatMixin:_decodeHouseShareNotice(msg, msgTable)
	local data = msgTable.share_house

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_WORLD
	msg.share_content.specData = data

	if ResInfoNotice[286] then
		msg.content = ResInfoNotice[286].content
	end
end

function ChatMixin:_decodeGiftDrawNotice(msg, msgTable)
	local data = msgTable.gift_draw

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_WORLD
	msg.share_content.specData = data
	msg.content = ""

	local actId = data.act_id
	local levelId = data.level
	local lackNum = data.lack_num

	if ResGiftDrawMisc[actId] then
		msg.content = utils.format(ResGiftDrawMisc[actId].share_content or "%1s", lackNum)
	end
end

function ChatMixin:_decodeValentineShareNotice(msg, msgTable)
	local data = msgTable.chat_game

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_WORLD
	msg.share_content.specData = data
	msg.content = ClientUtils.getValentineShareContent(data.template_id, data.gift_id) or ""
end

function ChatMixin:_decodeDrawNotice(msg, msgTable)
	local data = msgTable.draw

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_SERVER
	msg.sub_channel = Const.WORLD_CHANNEL_SYSTEM
	msg.share_content.specData = data

	local poolId = data.draw_type
	local poolConfig = ResDrawPoolClient[poolId]

	if not poolConfig then
		return true
	end

	local name, serverName = utils.GetPlayerName(data.name or "")
	local heroId = data.id
	local quality = data.star
	local heroName = ResHero[heroId].full_name
	local strFormat = ResDrawMisc[1].system_msg
	local strStar = ""

	if quality == 5 then
		strStar = "<0305>"
	elseif quality == 6 then
		strStar = "<0306>"
	end

	msg.content = utils.format(strFormat, name, poolConfig.title, strStar, heroName)
end

function ChatMixin:_decodeTriggerNotice(msg, msgTable)
	local data = msgTable.trigger_data

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_WORLD
	msg.sub_channel = Const.WORLD_CHANNEL_SYSTEM
	msg.share_content.specData = data

	local id = data.id
	local info = ResZChatTrigger[id]

	if info then
		if info.trigger_type == 1 or info.trigger_type == 2 then
			local name, serverName = utils.GetPlayerName(data.trigger_param[1] or "")

			msg.content = utils.format(info.msg_content, serverName, name)
		elseif info.trigger_type == 3 then
			local name, serverName = utils.GetPlayerName(data.trigger_param[1] or "")
			local round = tonumber(data.trigger_param[2]) or 1

			msg.content = utils.format(info.msg_content, serverName, name, round)
		end

		data.background_type = info.msg_background
	end

	data.background_type = ""
	msg.sattr.name = ""
end

function ChatMixin:_decodeCircleBattleNotice(msg, msgTable)
	local data = msgTable.clan_battle

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_GUILD
	msg.sub_channel = Const.GUILD_CHANNEL_SYSTEM
	msg.sattr.name = ""
	msg.share_content.specData = data

	local id = data.type
	local info = ResClanBattleSysMsg[id]
	local isJump = false

	if info then
		local name, serverName = utils.GetPlayerName(data.name or "")
		local playerName = serverName .. "-" .. name
		local content = ""

		if info.type == 4 then
			local achieve = ResClanBattleMemberAchieve[data.param1]

			if achieve then
				content = utils.format(info.msg, playerName, achieve.name, achieve.score)
			else
				isJump = true
			end
		elseif info.type == 5 then
			local achieve = ResClanBattleClanAchieve[data.param1]

			if achieve then
				content = utils.format(info.msg, playerName, achieve.name, achieve.score)
			else
				isJump = true
			end
		elseif info.type == 6 then
			local skillInfo = ResClanBattleSkill[data.param1]

			if skillInfo then
				content = utils.format(info.msg, playerName, skillInfo.name)
			else
				isJump = true
			end
		elseif info.type == 7 then
			content = utils.format(info.msg, name)
			msg.sub_channel = Const.CHANNEL_NONE
			msg.sattr.name = name
		else
			content = utils.format(info.msg, playerName)
		end

		msg.content = content
	else
		isJump = true
	end

	return isJump
end

function ChatMixin:_decodeMasterApplyNotice(msg, msgTable)
	local data = msgTable.master_apply

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_PRIVATE
	msg.share_content.specData = data
	msg.content = ResMasterNotice[1].desc

	return false
end

function ChatMixin:_decodeApprenticeApplyNotice(msg, msgTable)
	local data = msgTable.apprentice_apply

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_PRIVATE
	msg.share_content.specData = data
	msg.content = ResMasterNotice[2].desc

	return false
end

function ChatMixin:_decodeDevelopGuideReqNotice(msg, msgTable)
	local data = msgTable.develop_guide_c

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_PRIVATE
	msg.share_content.specData = data
	msg.content = ResMasterNotice[3].desc

	return false
end

function ChatMixin:_decodeDevelopGuideRespNotice(msg, msgTable)
	local data = msgTable.develop_guide_s

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_PRIVATE
	msg.share_content.specData = data
	msg.content = ResMasterNotice[4].desc

	return false
end

function ChatMixin:_decodeBattleGuideReqNotice(msg, msgTable)
	local data = msgTable.battle_guide_c

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_PRIVATE
	msg.share_content.specData = data
	msg.content = ResMasterNotice[5].desc

	return false
end

function ChatMixin:_decodeBattleGuideRespNotice(msg, msgTable)
	local data = msgTable.battle_guide_s

	data.notice_type = msgTable.notice_type
	msg.channel = Const.CHANNEL_PRIVATE
	msg.share_content.specData = data
	msg.content = ResMasterNotice[6].desc

	return false
end

function ChatMixin:checkJumpRedThxMsg(msg)
	self.checkMsgJumpMap = self.checkMsgJumpMap or {}

	local isJump = false

	if msg == nil or msg.content == nil or msg.channel == Const.MAIN_CHANNEL_SYSTEM or msg.channel == Const.CHANNEL_PRIVATE then
		return isJump
	end

	local data = self:parseMsgOtherInfo(msg.other)

	if data and #data > 0 then
		local type = data[1]
		local seq = data[2]

		if msg.sattr.uid == self.uid then
			-- block empty
		elseif type == Const.CUSTOM_MSG_DATA_TYPE.RED_THX and seq then
			if not self.checkMsgJumpMap[seq] then
				self.checkMsgJumpMap[seq] = 1
			elseif (self.checkMsgJumpMap[seq] or 0) > Const.THX_MSG_NUM then
				isJump = true
			else
				self.checkMsgJumpMap[seq] = self.checkMsgJumpMap[seq] + 1
			end
		end
	end

	return isJump
end

function ChatMixin:checkMsgLegal(msg)
	if msg == nil then
		return
	end

	local content = string.gsub(msg.content, "<%D.->", self._htmlFilter)

	content = string.gsub(content, "<%d->", self._emojiFilter)

	if content then
		msg.content = content
	end
end

function ChatMixin._htmlFilter(a)
	if string.match(a, "</?[cC].") then
		return a
	else
		return "*"
	end
end

function ChatMixin._emojiFilter(a)
	if MsgManager.isLegalEmoji(a) then
		return a
	else
		return "*"
	end
end

function ChatMixin:checkLargeEmoji(msg)
	local result = utils.isLargeEmoji(msg.content)

	if result then
		msg.content = result
	end
end

function ChatMixin:checkRedPacket(msg)
	local isJump = false

	if msg == nil or msg.content == nil or msg.channel == Const.MAIN_CHANNEL_SYSTEM or msg.channel == Const.CHANNEL_PRIVATE then
		return isJump
	end

	if msg.share == Const.CHAT_SHARE_TYPE.RED_PACKET and msg.share_content.other then
		local msgTable = protobuf.decode("csp.CSResPacketShareSpec", msg.share_content.other)

		msg.share_content.specData = nil

		if msgTable then
			msg.share_content.specData = msgTable
		end
	end

	local data = self:parseMsgOtherInfo(msg.other)

	if data and #data > 0 then
		local type = data[1]
		local seq = data[2]

		if #data == 1 then
			seq = data[1]
		end

		msg.redPacketData = {}

		if seq then
			local redMsg = repeatMap[seq]

			if redMsg and redMsg.sattr.uid == self.uid and type ~= Const.CUSTOM_MSG_DATA_TYPE.RED_THX or msg.ruid == self.uid then
				local strs = utils.splitString(msg.content, "|")

				if strs and #strs >= 3 then
					local name = strs[1]
					local itemId = tonumber(strs[2])
					local num = strs[3]
					local itemInfo = ResItem[itemId]
					local rdConfig = ResItemClientConfig[itemId]
					local sendName = Lang.get(1820)

					if msg.sattr.uid ~= self.uid then
						sendName = utils.GetPlayerName(msg.sattr.name)
						sendName = self:subMsgName(sendName)
						sendName = utils.getColorfulStr(sendName, ResColor.QUALITYORANGE)
					end

					if redMsg and redMsg.sattr.uid == self.uid then
						name = Lang.get(1820)
					else
						name = self:subMsgName(name)
						name = utils.getColorfulStr(name, ResColor.QUALITYORANGE)
					end

					local emojiIcon = "<0312>"
					local color = "RED01"

					if itemInfo.extend_args2 == 1 then
						emojiIcon = "<0311>"
						color = "QUALITYRED"
					end

					if rdConfig and rdConfig.red_pack_emoji then
						emojiIcon = rdConfig.red_pack_emoji
					end

					local content = utils.format(Lang.get(30813), emojiIcon, sendName, name or "", utils.getColorfulStr(itemInfo.name, ResColor[color]), num or 0)

					msg.content = content
				end
			else
				isJump = true
			end

			if type == Const.CUSTOM_MSG_DATA_TYPE.RED_THX then
				isJump = false
			elseif msg.ruid ~= self.uid then
				local isFold = self:recordRedPacketThxInfo(msg, seq)

				isJump = isFold or isJump
			end
		end
	end

	return isJump
end

function ChatMixin:checkShareMsg(msg)
	if msg == nil or msg.content == nil or msg.channel == Const.MAIN_CHANNEL_SYSTEM then
		return
	end

	if msg.share == Const.CHAT_SHARE_TYPE.REPLAY and msg.share_content.other then
		msg.share_content.specData = nil

		local msgTable = protobuf.decode("csp.CSPVEBattleShareSpec", msg.share_content.other)

		if msgTable then
			msg.share_content.specData = msgTable
		end
	end
end

function ChatMixin:checkMyChatAttr(msgItem)
	if msgItem ~= nil and msgItem.suid == self.uid and (msgItem.sattr == nil or msgItem.sattr.uid == "") then
		if self.fakeChatAttr == nil then
			self.fakeChatAttr = {}
		end

		self.fakeChatAttr.uid = self.uid
		self.fakeChatAttr.name = self.name
		self.fakeChatAttr.gender = self.gender
		self.fakeChatAttr.level = self:getLevel()
		self.fakeChatAttr.head = self.head
		self.fakeChatAttr.head_frame_id = self.headFramdId
		self.fakeChatAttr.head_frame_end_time = self.head_frame_end_time
		self.fakeChatAttr.vip = self.vipLevel
		self.fakeChatAttr.vip_hide = self:getVipShowState()
		self.fakeChatAttr.clangid = self.circleRoleData.clangid
		msgItem.sattr = self.fakeChatAttr
	end

	local serverId

	if Const.CHANNEL_TO_TYPE[msgItem.channel] ~= nil or msgItem.channel == Const.CHANNEL_BP_PVP then
		msgItem.sattr.name, msgItem.sattr.serverName, serverId = utils.GetPlayerName(msgItem.sattr.name)
	end

	if tonumber(msgItem.seq) < 1000000 then
		msgItem.sub_channel = msgItem.sub_channel or Const.CHANNEL_NONE
	else
		msgItem.sub_channel = Const.CHANNEL_NONE
	end

	msgItem.sattr.serverId = serverId or 0
	msgItem.sattr.serverName = ""
end

function ChatMixin:recordRedPacketClaimInfo(seq, msg, claimed)
	redPacketClaimMap[self.uid] = redPacketClaimMap[self.uid] or {}

	if redPacketClaimMap[self.uid][seq] == nil then
		local data = {
			claimed = claimed,
			msg = msg
		}

		redPacketClaimMap[self.uid][seq] = data
	else
		local data = redPacketClaimMap[self.uid][seq]

		data.claimed = claimed

		if not data.msg then
			data.msg = msg
		end
	end
end

function ChatMixin:getRedPacketClaimInfo(seq)
	if redPacketClaimMap[self.uid] then
		return redPacketClaimMap[self.uid][seq]
	end
end

function ChatMixin:isRedPacketClaimed(seq)
	if redPacketClaimMap[self.uid] and redPacketClaimMap[self.uid][seq] then
		return redPacketClaimMap[self.uid][seq].claimed
	end

	return false
end

function ChatMixin:recordRedPacketThxInfo(msg, seq)
	redPacketThxMap[self.uid] = redPacketThxMap[self.uid] or {}
	redPacketThxMap[self.uid][seq] = redPacketThxMap[self.uid][seq] or {}

	local list = redPacketThxMap[self.uid][seq]

	msg.redPacketData.index = 0

	if #list < Const.MAX_THX_MSG_NUM then
		table.insert(list, msg)

		msg.redPacketData.index = #list

		if #list >= Const.FOLD_MSG_NUM then
			local data = list[Const.FOLD_MSG_NUM]

			data.redPacketData.more = data.redPacketData.more or {}
			data.redPacketData.isFold = true

			if #list > Const.FOLD_MSG_NUM then
				table.insert(data.redPacketData.more, msg)
			end
		end

		return msg.redPacketData.index > Const.FOLD_MSG_NUM
	end

	return true
end

function ChatMixin:getRedPacketThxInfo(seq)
	if redPacketThxMap[self.uid] then
		return redPacketThxMap[self.uid][seq]
	end
end

function ChatMixin:receiveFakeSystemMsg(content, channel, sub_channel)
	channel = channel or Const.MAIN_CHANNEL_SYSTEM

	local msg = {}
	local msgItem = {}

	msgItem.seq = self:_getFakeSeq()
	msgItem.content = content
	msgItem.sattr = {}
	msgItem.sattr.name = ""
	msgItem.sattr.serverName = ""
	msgItem.channel = channel
	msgItem.sub_channel = sub_channel or Const.CHANNEL_NONE
	msgItem.time = ClientUtils.getServerTime()
	msg[1] = msgItem

	self:onChatNotify(msg)
end

function ChatMixin:receiveFakeGuildSystemMsg(content)
	local msg = {}
	local msgItem = {}

	msgItem.seq = self:_getFakeSeq()
	msgItem.gid = self:getCircleChatId()
	msgItem.content = content
	msgItem.sattr = {}
	msgItem.sattr.name = ""
	msgItem.sattr.serverName = ""
	msgItem.channel = Const.CHANNEL_GUILD
	msgItem.sub_channel = Const.GUILD_CHANNEL_SYSTEM
	msgItem.time = ClientUtils.getServerTime()
	msg[1] = msgItem

	self:onChatNotify(msg)
end

function ChatMixin:receiveFakePersonMsg(content, ruid)
	local msg = {}
	local msgItem = {}

	msgItem.seq = self:_getFakeSeq()
	msgItem.content = content
	msgItem.sattr = nil
	msgItem.suid = self.uid
	msgItem.ruid = ruid
	msgItem.channel = Const.CHANNEL_PRIVATE
	msgItem.time = ClientUtils.getServerTime()
	msg[1] = msgItem

	self:onChatNotify(msg)
end

function ChatMixin:receiveFakeWordMsg(content, other)
	local msg = {}
	local msgItem = {}

	msgItem.seq = self:_getFakeSeq()
	msgItem.content = content
	msgItem.sattr = nil
	msgItem.suid = self.uid
	msgItem.ruid = self.uid
	msgItem.channel = Const.CHANNEL_WORLD
	msgItem.share_content = {}
	msgItem.other = other
	msgItem.time = ClientUtils.getServerTime()
	msg[1] = msgItem

	self:onChatNotify(msg)
end

function ChatMixin:_getFakeSeq(...)
	fakeSeq = fakeSeq + 1

	return fakeSeq
end

function ChatMixin:onGagInfoNotify(gagflag, gagfreetime, gagreason)
	return
end

function ChatMixin:onChatSendResp(action, expire_at)
	if action == 400 then
		local content = utils.format("発言禁止されました\n%1sに解除されます", ClientUtils.timeStampToTimeFormat(expire_at))

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", content)
	end
end

function ChatMixin:isLockConditionChat(...)
	local conditionId = ResChatMisc[1].common_condition_id

	if ConditionLimitManager.inLimitState(conditionId) then
		local unlockDesc = ConditionLimitManager.getLimitUnlockDesc(conditionId)

		MsgManager.notice(string.format(Lang.get(1817), unlockDesc))

		return true
	else
		return false
	end
end

function ChatMixin:isChatLimit(...)
	local conditionId = ResChatMisc[1].common_condition_id

	if ConditionLimitManager.inLimitState(conditionId) then
		return true
	end

	return false
end

function ChatMixin:isForbidChat(...)
	if RegionUtils.isJP() then
		return false
	end

	if ClientUtils.record.forbidChat then
		MsgManager.notice(Lang.get(1821))

		return true
	end

	local leftTime = (ClientUtils.record.nextChatFreeTime or 0) - ClientUtils.getServerTime()

	if leftTime <= 0 then
		return false
	else
		local leftTimeStr = utils.calcTimeTxt(leftTime)

		MsgManager.notice(string.format(Lang.get(1818), leftTimeStr))

		return true
	end
end

function ChatMixin:getMsgBlessingContent(msg)
	if msg == nil or msg.content == nil or msg.channel == Const.MAIN_CHANNEL_SYSTEM or msg.share ~= Const.CHAT_SHARE_TYPE.RED_PACKET then
		return ""
	end

	local specData = msg.share_content.specData
	local itemInfo = ResItemClientConfig[specData.item_id]

	if itemInfo and itemInfo.red_pack_appr then
		local id = itemInfo.red_pack_appr
		local contentInfo = ResRedPacketThankContent[id][specData.index or 1]

		if contentInfo then
			return contentInfo.content
		end
	end

	return ""
end

function ChatMixin:getFormatOtherData(...)
	local param = {
		...
	}
	local str = tostring(param[1])

	for i, p in ipairs(param) do
		if i ~= 1 then
			str = str .. "|" .. tostring(p)
		end
	end

	return str
end

function ChatMixin:parseMsgOtherInfo(other)
	if other == nil or other == "" then
		return
	end

	local strs = utils.splitString(other, "|")

	return strs
end

function ChatMixin:subMsgName(name)
	local len = utils.utf8len(name)

	if len > 4 then
		name = utils.utf8Substring(name, 1, 4)

		return name .. "..."
	else
		return name
	end
end

function ChatMixin:onHouseShareResp(...)
	self.houseShareTime = ClientUtils.getServerTime()

	MsgManager.notice(Lang.get(1813))
	UIManager.getUI("chatDlg", true)
end

return ChatMixin
