local var_0_0 = g.core.config.talk_show_info
local var_0_1 = g.core.config.talk_show_group_info
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.const.ConstMgr.ChatConst
local var_0_4 = g.core.const.ConstMgr.ShareConst
local ChatCommon = require("app.view.module.chat.common.ChatCommon")
local ChatData = class("ChatData")

ChatData.SHOW_TIME_INTERVAL = 300
ChatData.SHOW_CHATFLOAT_MAX_COUNT = 3

function ChatData:ctor()
	self:initData()
end

function ChatData:initData()
	self._allChatInfo = {}
	self._chatList = {}
	self._sysNoticeList = {}
	self._privateInfo = {}
	self._lastConnectPlayerInfo = {}
	self._topConnectPlayerInfo = nil
	self._curChannelType = 0
	self._channelChatFlag = {}
	self._newInfoNum = {}
	self._lastConnectTime = {}
	self._lastPrivateConnectTime = {}
	self._lastSendConnectTime = {}
	self._curPrivatePlayer = nil
	self._chatFloatInfo = {}
	self._isFirstEnterLayer = true
	self._isFirstEnterHomeLayer = true
	self._leftLimitTimes = {}
	self._redPrivatePlayerList = {}
	self._savePrivateReadInfo = {}
	self._setInfo = {
		0,
		0,
		0,
		0,
		0
	}
	self._isGetset = false
	self._forbidTIme = {}
	self._voiceChatInfo = {}
	self._voicePaths = {}
	self._crossServerMessages = {}
	self._crossServerMsgCache = {}
	self._isRecommand = false
	self._channelHasNewChat = {}
	self._newChatFace = nil
	self._chatFaceMapData = {}
	self._chatFaceListData = {}
	self._allFaceCfgData = {}
	self._insetPacketIdList = {}
	self._viewPlayerList = {}
	self._noticeTipsList = {}
	self._isUnlockWorldPacket = false

	self:init()
	self:loadGuildChatCache()
end

function ChatData:init()
	table.insert(self._chatFloatInfo, {
		content = g.core.lang:get(1048),
		channel = var_0_3.SYSTEM
	})
	self:_initAllFaceCfg()
end

function ChatData:addWorldLeftTimes(arg_4_1)
	local var_4_0 = arg_4_1 or 0

	self._leftLimitTimes[var_0_3.WORLD] = (arg_4_1 or 0) > 0 and var_4_0 or self:getWorldLeftTimes() + var_4_0
end

function ChatData:getWorldLeftTimes()
	return self._leftLimitTimes[var_0_3.WORLD] or 0
end

function ChatData:setPrivatePlayer(arg_6_1)
	self._curPrivatePlayer = arg_6_1
end

function ChatData:getPrivatePlayerId()
	return (self._curPrivatePlayer or nil) and (self._curPrivatePlayer.receiver or self._curPrivatePlayer.id)
end

function ChatData:getPrivatePlayerInfo()
	return self._curPrivatePlayer
end

function ChatData:setVoiceChatInfo(arg_9_1, arg_9_2, arg_9_3)
	self._voiceChatInfo[arg_9_1] = {}
	self._voiceChatInfo[arg_9_1].receiveid = arg_9_1
	self._voiceChatInfo[arg_9_1].channel = arg_9_2
	self._voiceChatInfo[arg_9_1].receivename = arg_9_3
end

function ChatData:getVoiceChatInfo(arg_10_1)
	return self._voiceChatInfo[arg_10_1].receiveid, self._voiceChatInfo[arg_10_1].channel, self._voiceChatInfo[arg_10_1].receivename
end

function ChatData:setVoicePath(arg_11_1, arg_11_2)
	self._voicePaths[arg_11_1] = arg_11_2
end

function ChatData:getVoicePath(arg_12_1)
	return self._voicePaths[arg_12_1]
end

function ChatData:setChannelFlag(arg_13_1, arg_13_2)
	self._channelChatFlag[arg_13_1] = arg_13_2
end

function ChatData:getChannelFlag(arg_14_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_2.FUNCTION_TYPE.CHAT) then
		return false
	end

	if arg_14_1 == var_0_3.ARMY then
		if not g.core.model.User.guildData:hasGuild() then
			return false
		end
	elseif arg_14_1 == var_0_3.TROOPS then
		if g.core.model.User.bioData:getTeamInfo().id == 0 then
			return false
		end
	elseif arg_14_1 == var_0_3.GUILD_WAR then
		if not g.core.model.User.guildWarData:isOpenChat() then
			return false
		end
	elseif arg_14_1 == var_0_3.GVE then
		if not g.core.model.User.gveDataMgr:isOpenChat() then
			return false
		end
	elseif arg_14_1 == var_0_3.BOUNTY then
		if not g.core.model.User.bountyData:isActivityOpen() then
			return false
		end
	elseif arg_14_1 == var_0_3.ANNIVERSARY then
		if not g.core.model.User.anniversaryData:isActivityOpen() then
			return false
		end

		if g.core.model.User.anniversaryData:getCurStage() ~= g.core.const.ConstMgr.AnniversaryConst.STAGE.GAME then
			return false
		end
	end

	return self._channelChatFlag[arg_14_1] or false
end

function ChatData:setChannelType(arg_15_1)
	self._curChannelType = arg_15_1
end

function ChatData:getChannelType()
	return self._curChannelType
end

function ChatData:setChatFloatInfo(arg_17_1)
	if arg_17_1 then
		if arg_17_1.user and self:isInBlackList(arg_17_1.user.id) then
			-- block empty
		elseif not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.CROSS_FRIEND) and arg_17_1.channel and arg_17_1.channel == g.core.const.ConstMgr.ChatConst.AREA then
			-- block empty
		elseif not g.core.model.User.bountyData:isActivityOpen() and arg_17_1.channel and arg_17_1.channel == var_0_3.BOUNTY then
			-- block empty
		elseif arg_17_1.channel and (arg_17_1.channel == var_0_3.TEAM_BATTLE_ZONE or arg_17_1.channel == var_0_3.TEAM_BATTLE) and not g.core.model.User.teamBattleData:isActivityOpen() then
			return
		else
			table.insert(self._chatFloatInfo, arg_17_1)
		end

		if #self._chatFloatInfo > ChatData.SHOW_CHATFLOAT_MAX_COUNT then
			table.remove(self._chatFloatInfo, 1)
		end
	end
end

function ChatData:getChatFloatInfo()
	return self._chatFloatInfo
end

function ChatData:setFirstEnterFlag()
	self._isFirstEnterLayer = false
end

function ChatData:getFirstEnterFlag()
	return self._isFirstEnterLayer
end

function ChatData:setUnreadInfo(arg_21_1, arg_21_2)
	if arg_21_1 == nil or arg_21_1 == 0 then
		return
	end

	local var_21_0 = self._newInfoNum[arg_21_1]

	if self._newInfoNum[arg_21_1] == nil then
		var_21_0 = 0
	end

	var_21_0 = arg_21_2 and arg_21_2 or var_21_0 + 1
	self._newInfoNum[arg_21_1] = var_21_0
end

function ChatData:getUnreadInfo(arg_22_1)
	if self._newInfoNum[arg_22_1] then
		return self._newInfoNum[arg_22_1]
	end

	return 0
end

function ChatData:setLastSendConnectTime(arg_23_1)
	if arg_23_1 == var_0_3.ALL then
		arg_23_1 = var_0_3.WORLD
	end

	self._lastSendConnectTime[arg_23_1] = tonumber(g.core.common.ServerTime:getTime())
end

function ChatData:getLastSendConnectTime(arg_24_1)
	if arg_24_1 == var_0_3.ALL then
		arg_24_1 = var_0_3.WORLD
	end

	return self._lastSendConnectTime[arg_24_1] or 0
end

function ChatData:setAllChatInfo(arg_25_1, arg_25_2)
	if not arg_25_1.user and not arg_25_1.special_id then
		return
	end

	self._allChatInfo[arg_25_1.channel] = self._allChatInfo[arg_25_1.channel] or {}

	if not arg_25_1.user or not self:isInBlackList(arg_25_1.user.id) then
		if arg_25_1.user and self._curChannelType ~= arg_25_1.channel and arg_25_1.user.id ~= g.core.model.User:getId() then
			self._channelHasNewChat[arg_25_1.channel] = not arg_25_2
		end

		local var_25_0 = self._lastConnectTime[arg_25_1.channel] or 0
		local var_25_1 = self._lastConnectTime[var_0_3.ALL] or 0
		local var_25_2 = 0

		if arg_25_1.time then
			var_25_2 = tonumber(arg_25_1.time)
		else
			var_25_2 = g.core.common.ServerTime:getTime()
			arg_25_1.time = var_25_2
		end

		if math.abs(var_25_2 - var_25_0) > ChatData.SHOW_TIME_INTERVAL then
			self:setLastConnectTime(arg_25_1.channel, var_25_2)
			table.insert(self._allChatInfo[arg_25_1.channel], {
				showTime = var_25_2
			})
		end

		if math.abs(var_25_2 - var_25_1) > ChatData.SHOW_TIME_INTERVAL then
			self:setLastConnectTime(var_0_3.ALL, var_25_2)
			table.insert(self._chatList, {
				showTime = var_25_2
			})
		end

		self:checkAndSaveChatData(arg_25_1.channel, arg_25_1)
		table.insert(self._allChatInfo[arg_25_1.channel], arg_25_1)
		table.insert(self._chatList, arg_25_1)
	end
end

function ChatData:checkAndFitChatData(arg_26_1)
	if arg_26_1.records then
		for iter_26_0, iter_26_1 in ipairs(arg_26_1.records.contents or {}) do
			if iter_26_1.param1 then
				iter_26_1.param2 = iter_26_1.param1
				iter_26_1.param1 = tonumber(iter_26_1.param1)
			end
		end
	end
end

function ChatData:checkAndFitBulletScreenData(arg_27_1)
	if arg_27_1.message and arg_27_1.message.param1 then
		arg_27_1.message.param2 = arg_27_1.message.param1
		arg_27_1.message.param1 = tonumber(arg_27_1.message.param1)
	end
end

function ChatData:checkAndFitBulletScreenInfoData(arg_28_1)
	if arg_28_1.messages then
		for iter_28_0, iter_28_1 in ipairs(arg_28_1.messages) do
			if iter_28_1.param1 then
				iter_28_1.param2 = iter_28_1.param1
				iter_28_1.param1 = tonumber(iter_28_1.param1)
			end
		end
	end
end

function ChatData:setRecordHistoryChatData(arg_29_1)
	local var_29_0 = g.core.common.ServerTime:getTime()

	if arg_29_1.records then
		self._allChatInfo[arg_29_1.records.channel_id] = self._allChatInfo[arg_29_1.records.channel_id] or {}

		for iter_29_0, iter_29_1 in ipairs(arg_29_1.records.contents or {}) do
			iter_29_1.time = var_29_0 + iter_29_0

			self:checkShareInfo(iter_29_1)

			if not iter_29_1.user or not self:isInBlackList(iter_29_1.user.id) then
				table.insert(self._allChatInfo[arg_29_1.records.channel_id], iter_29_1)
			end
		end
	end
end

function ChatData:refreshWorldRedPacket()
	self._allChatInfo[var_0_3.WORLD] = self._allChatInfo[var_0_3.WORLD] or {}

	for iter_30_0, iter_30_1 in pairs((g.core.model.User.worldRedPacketData:getPacketDict())) do
		self:_addOneWorldRedPacket(iter_30_1)
	end
end

function ChatData:addWorldRedPacketList(arg_31_1)
	self._allChatInfo[var_0_3.WORLD] = self._allChatInfo[var_0_3.WORLD] or {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_1.world_red_packets or {}) do
		self:_addOneWorldRedPacket(iter_31_1)
	end
end

function ChatData:addWorldRedNotify(arg_32_1)
	self:addWorldRedPacketList(arg_32_1)
end

function ChatData:addWorldRedByUse(arg_33_1)
	self._allChatInfo[var_0_3.WORLD] = self._allChatInfo[var_0_3.WORLD] or {}

	self:_addOneWorldRedPacket(arg_33_1.world_red_packet)
end

function ChatData:_addOneWorldRedPacket(arg_34_1)
	if self._insetPacketIdList[arg_34_1.id] then
		return
	end

	local var_34_0

	if self:isInBlackList(arg_34_1.from_user.id) then
		g.core.model.User.worldRedPacketData:setBlackList(arg_34_1.id)

		do return end

		var_34_0 = {
			worldRedPacketId = arg_34_1.id
		}
	end

	var_34_0.isSelf = g.core.model.User:isSelfById(arg_34_1.from_user.id)
	var_34_0.channel = var_0_3.WORLD

	table.insert(self._allChatInfo[var_0_3.WORLD], var_34_0)
	self:setChatFloatInfo(var_34_0)

	self._insetPacketIdList[arg_34_1.id] = true
end

function ChatData:checkAndSaveChatData(arg_35_1, arg_35_2)
	if arg_35_1 == var_0_3.ARMY then
		self:saveGuildChatData(arg_35_2)
	end
end

function ChatData:saveGuildChatData(arg_36_1)
	return
end

function ChatData:loadGuildChatCache()
	return
end

function ChatData:clearGuildChatCache()
	self._allChatInfo[var_0_3.ARMY] = {}
end

function ChatData:updateGuildChatCache(arg_39_1)
	arg_39_1 = arg_39_1 or {}

	local var_39_0 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.CHAT_GUILD_SAVE_NUM).parameter
	local var_39_1 = table.nums(arg_39_1)

	if var_39_0 < var_39_1 then
		for iter_39_0 = 1, var_39_1 - var_39_0 do
			table.remove(arg_39_1, 1)
		end
	end

	self._guildSaveCache = arg_39_1

	g.core.common.Storage:save("guild_chat_cache.json", self._guildSaveCache)
end

function ChatData:setCrossServerMessage(arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = arg_40_1.message or {}

	if var_40_0.user and self:isInBlackList(var_40_0.user.id) then
		return
	end

	if not arg_40_2 then
		table.insert(self._crossServerMessages, var_40_0)
	end

	local var_40_1 = arg_40_1 and arg_40_1.type and self:toChatType(arg_40_1 and arg_40_1.type) or var_0_3.STORM
	local var_40_2 = {
		channel = var_40_1,
		content = var_40_0.content,
		time = var_40_0.time,
		user = var_40_0.user,
		talk = var_40_0.talk,
		args = var_40_0.args
	}

	var_40_2.look = var_40_0.args and var_40_0.args[1]
	var_40_2.share = var_40_0.share
	var_40_2.param1 = var_40_0.param1
	var_40_2.param2 = var_40_0.param2
	var_40_2.invite_id = var_40_0.invite_id
	var_40_2.unique_id = var_40_0.unique_id

	if self:isContainMessage(var_40_2) then
		return
	end

	self:setAllChatInfo(var_40_2, arg_40_3)
	self:checkShareInfo(var_40_2)
	self:setChatFloatInfo(var_40_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_CHAT_BROADCAST, false, 0, var_40_2)
end

function ChatData:isContainMessage(arg_41_1)
	if self._allChatInfo[arg_41_1.channel] then
		for iter_41_0, iter_41_1 in ipairs(self._allChatInfo[arg_41_1.channel]) do
			if iter_41_1.time == arg_41_1.time and iter_41_1.content == arg_41_1.content and iter_41_1.user.id == arg_41_1.user.id then
				return true
			end
		end
	end

	return false
end

function ChatData:setCrossServerMessageAll(arg_42_1)
	self._crossServerMessages = {}

	local var_42_0 = self:getCrossServerMsgCache()

	if var_42_0 then
		self._crossServerMsgCache = var_42_0
	end

	local var_42_1 = clone(self._crossServerMsgCache)

	if arg_42_1 then
		local var_42_2 = arg_42_1.type or self:toSvrChatType(var_0_3.STORM)

		if arg_42_1.messages then
			for iter_42_0, iter_42_1 in ipairs(arg_42_1.messages) do
				local var_42_3 = tostring(iter_42_1.user.id) .. "_" .. tostring(iter_42_1.time)

				self:setCrossServerMessage({
					message = iter_42_1,
					type = var_42_2
				}, checkbool(self._crossServerMsgCache[var_42_3]), true)

				var_42_1[var_42_3] = nil
			end
		end
	end

	for iter_42_2, iter_42_3 in pairs(var_42_1) do
		self._crossServerMsgCache[iter_42_2] = nil
	end

	g.core.common.Storage:save("crossserver_messages.json", {
		data = self._crossServerMsgCache
	})
end

function ChatData:getCrossServerMessages(arg_43_1)
	if arg_43_1 then
		table.sort(self._crossServerMessages, function(arg_44_0, arg_44_1)
			if arg_44_0.time ~= arg_44_1.time then
				return arg_44_0.time < arg_44_1.time
			end
		end)
	end

	return self._crossServerMessages
end

function ChatData:saveCrossServerMsgCache(arg_45_1)
	local var_45_0 = {
		id = arg_45_1.user.id,
		time = arg_45_1.time,
		content = arg_45_1.content
	}

	self._crossServerMsgCache[tostring(var_45_0.id) .. "_" .. tostring(var_45_0.time)] = true

	g.core.common.Storage:save("crossserver_messages.json", {
		data = self._crossServerMsgCache
	})
end

function ChatData:getCrossServerMsgCache()
	local var_46_0 = g.core.common.Storage:load("crossserver_messages.json")

	if var_46_0 and var_46_0.data then
		return var_46_0.data
	end

	return {}
end

function ChatData:setRecommand(arg_47_1)
	self._isRecommand = arg_47_1
end

function ChatData:getRecommand()
	return self._isRecommand
end

function ChatData:clearSomeoneChatInfo(arg_49_1)
	if arg_49_1.user then
		self:clearChatById(arg_49_1.user.id, arg_49_1.channel)
	end
end

function ChatData:clearChatById(arg_50_1, arg_50_2)
	if arg_50_2 == var_0_3.ALL then
		for iter_50_0, iter_50_1 in pairs(self._allChatInfo) do
			for iter_50_2 = #iter_50_1, 1, -1 do
				if iter_50_1[iter_50_2].user and iter_50_1[iter_50_2].user.id == arg_50_1 then
					table.remove(iter_50_1, iter_50_2)
				elseif iter_50_1[iter_50_2].worldRedPacketId and g.core.model.User.worldRedPacketData:isUserPacket(iter_50_1[iter_50_2].worldRedPacketId, arg_50_1) then
					g.core.model.User.worldRedPacketData:setBlackList(iter_50_1[iter_50_2].worldRedPacketId)
					table.remove(iter_50_1, iter_50_2)
				end
			end
		end

		for iter_50_3 = #self._chatList, 1, -1 do
			if self._chatList[iter_50_3].user and self._chatList[iter_50_3].user.id == arg_50_1 then
				table.remove(self._chatList, iter_50_3)
			end
		end
	else
		local var_50_0 = self._allChatInfo[arg_50_2]

		if self._allChatInfo[arg_50_2] then
			for iter_50_4 = #var_50_0, 1, -1 do
				if var_50_0[iter_50_4].user and var_50_0[iter_50_4].user.id == arg_50_1 then
					table.remove(var_50_0, iter_50_4)
				elseif var_50_0[iter_50_4].worldRedPacketId and g.core.model.User.worldRedPacketData:isUserPacket(var_50_0[iter_50_4].worldRedPacketId, arg_50_1) then
					g.core.model.User.worldRedPacketData:setBlackList(var_50_0[iter_50_4].worldRedPacketId)
					table.remove(var_50_0, iter_50_4)
				end
			end
		end

		for iter_50_5 = #self._chatList, 1, -1 do
			if self._chatList[iter_50_5].channel == arg_50_2 and self._chatList[iter_50_5].user and self._chatList[iter_50_5].user.id == arg_50_1 then
				table.remove(self._chatList, iter_50_5)
			end
		end
	end

	if self._chatFloatInfo and #self._chatFloatInfo > 0 then
		for iter_50_6 = #self._chatFloatInfo, 1, -1 do
			if (arg_50_2 == var_0_3.ALL or arg_50_2 == self._chatFloatInfo[iter_50_6].channel) and (self._chatFloatInfo[iter_50_6].user or nil) and self._chatFloatInfo[iter_50_6].user.id == arg_50_1 then
				table.remove(self._chatFloatInfo, iter_50_6)
			elseif self._chatFloatInfo[iter_50_6].worldRedPacketId and g.core.model.User.worldRedPacketData:isUserPacket(self._chatFloatInfo[iter_50_6].worldRedPacketId, arg_50_1) then
				g.core.model.User.worldRedPacketData:setBlackList(self._chatFloatInfo[iter_50_6].worldRedPacketId)
				table.remove(self._chatFloatInfo, iter_50_6)
			end
		end
	end
end

function ChatData:getChatInfoByType(arg_51_1)
	if arg_51_1 == var_0_3.ALL then
		return self:getAllChatList()
	end

	return self._allChatInfo[arg_51_1]
end

function ChatData:getAllChatInfo()
	return self._allChatInfo
end

function ChatData:getAllChatList()
	return self._chatList
end

function ChatData:setForbidTime(arg_54_1)
	self._forbidTIme[self._curChannelType] = self._forbidTIme[self._curChannelType] or 0
	self._forbidTIme[self._curChannelType] = arg_54_1.forbid_time or 0
end

function ChatData:getForbidTime(arg_55_1)
	return self._forbidTIme[arg_55_1] or 0
end

function ChatData:isDuringForbid(arg_56_1)
	return (self._forbidTIme[arg_56_1] or 0) > g.core.common.ServerTime:getTime()
end

function ChatData:_needForbid(arg_57_1)
	return false
end

function ChatData:setSysNoticeData(arg_58_1)
	if self:_needForbid(arg_58_1) then
		return
	end

	if not g.core.config.notice_info.fetch(arg_58_1.id) then
		return
	end

	if arg_58_1.from_user_id and self:isInBlackList(arg_58_1.from_user_id) then
		return
	end

	local var_58_0, var_58_1 = g.core.lang:getBroadCastString({
		id = arg_58_1.id,
		params = arg_58_1.params,
		awards = arg_58_1.awards
	})
	local var_58_2 = g.core.config.notice_info.get(arg_58_1.id)
	local var_58_3 = var_0_3.GroupType[var_58_2.group] or var_0_3.STORM

	if arg_58_1.id ~= 2 or not var_58_1.recruitNum or var_58_1.recruitNum > 1 then
		table.insert(self._sysNoticeList, {
			user = {
				name = var_58_0,
				uid = arg_58_1.from_user_id,
				cfgId = arg_58_1.id
			},
			channel = var_58_3,
			time = tonumber(g.core.common.ServerTime:getTime())
		})
	end

	if var_58_2.show > 0 and g.core.model.User:getLevel() >= var_58_2.min_level then
		table.insert(self._noticeTipsList, {
			cfgId = arg_58_1.id,
			weight = var_58_2.weight,
			content = var_58_0,
			uid = arg_58_1.from_user_id,
			time = tonumber(g.core.common.ServerTime:getTime())
		})
		table.sort(self._noticeTipsList, function(arg_59_0, arg_59_1)
			if arg_59_0.weight ~= arg_59_1.weight then
				return arg_59_0.weight > arg_59_1.weight
			end

			local var_59_0 = arg_59_0.uid and arg_59_0.uid > 0 and arg_59_0.uid == g.core.model.User:getId() and 1 or 0
			local var_59_1 = arg_59_1.uid and arg_59_1.uid > 0 and arg_59_1.uid == g.core.model.User:getId() and 1 or 0

			if var_59_0 ~= var_59_1 then
				return var_59_1 < var_59_0
			end

			if arg_59_0.time ~= arg_59_1.time then
				return arg_59_0.time < arg_59_1.time
			end

			return arg_59_0.cfgId < arg_59_1.cfgId
		end)
	end
end

function ChatData:getTopNoticeTip()
	return table.remove(self._noticeTipsList, 1)
end

function ChatData:getSingleSysNoticeData(arg_61_1)
	local var_61_0 = {}

	if self:_needForbid(arg_61_1) then
		return var_61_0
	end

	if not g.core.config.notice_info.fetch(arg_61_1.id) then
		return var_61_0
	end

	if arg_61_1.from_user_id and self:isInBlackList(arg_61_1.from_user_id) then
		return var_61_0
	end

	local var_61_1, var_61_2 = g.core.lang:getBroadCastString({
		id = arg_61_1.id,
		params = arg_61_1.params,
		awards = arg_61_1.awards
	})

	if arg_61_1.id == 2 and var_61_2.recruitNum and var_61_2.recruitNum <= 1 then
		return var_61_0
	end

	local var_61_3 = var_0_3.GroupType[g.core.config.notice_info.get(arg_61_1.id).group] or var_0_3.STORM

	table.insert(var_61_0, {
		content = var_61_1,
		channel = var_61_3
	})

	return var_61_0
end

function ChatData:getSysNoticeData()
	local var_62_0 = {}

	for iter_62_0 = 1, #self._sysNoticeList do
		table.insert(var_62_0, self._sysNoticeList[iter_62_0])
	end

	for iter_62_1 = 1, #self._viewPlayerList do
		table.insert(var_62_0, self._viewPlayerList[iter_62_1])
	end

	table.sort(var_62_0, function(arg_63_0, arg_63_1)
		return arg_63_0.time < arg_63_1.time
	end)

	return var_62_0
end

function ChatData:_checkRepeatePrivateChat(arg_64_1)
	for iter_64_0, iter_64_1 in pairs(self._privateInfo) do
		for iter_64_2, iter_64_3 in pairs(iter_64_1) do
			if arg_64_1 == (iter_64_3.user or {}).mailId then
				return true
			end
		end
	end

	return false
end

function ChatData:setPrivateChatCotent(arg_65_1)
	if arg_65_1.mail_type ~= var_0_3.EFriendMail then
		return
	end

	local var_65_0 = arg_65_1.mails

	if arg_65_1.mails then
		table.sort(var_65_0, function(arg_66_0, arg_66_1)
			if tonumber(arg_66_0.time) ~= tonumber(arg_66_1.time) then
				return tonumber(arg_66_0.time) < tonumber(arg_66_1.time)
			end
		end)

		for iter_65_0, iter_65_1 in ipairs(var_65_0) do
			local var_65_1 = iter_65_1.keys
			local var_65_2 = iter_65_1.values
			local var_65_3 = {
				id = iter_65_1.sender_id,
				name = iter_65_1.name,
				time = tonumber(iter_65_1.time),
				mailId = iter_65_1.id,
				sub_type = iter_65_1.sub_type,
				voice_path = iter_65_1.voice_path,
				voice_time = iter_65_1.voice_time,
				voice_param = iter_65_1.voice_param
			}

			var_65_3.talk = iter_65_1.talk and tonumber(iter_65_1.talk) or 0
			var_65_3.look = iter_65_1.look and tonumber(iter_65_1.look) or 0
			var_65_3.level = iter_65_1.level
			var_65_3.server_name = iter_65_1.server_name or ""

			if self:_checkRepeatePrivateChat(iter_65_1.id) then
				return
			end

			if var_65_1 and var_65_2 then
				for iter_65_2, iter_65_3 in ipairs(var_65_1) do
					if iter_65_3 == "content" then
						var_65_2[iter_65_2] = g.core.lang:getNormalText(var_65_2[iter_65_2])
					end

					var_65_3[iter_65_3] = var_65_2[iter_65_2]
				end

				var_65_3.base_id = tonumber(var_65_3.baseid)
				var_65_3.avata_id = tonumber(var_65_3.showavatar)
				var_65_3.frame_id = tonumber(var_65_3.showframe)

				local var_65_4 = var_65_3.id == g.core.model.User:getId() and tonumber(var_65_3.receiver) or var_65_3.id
				local var_65_5 = tonumber(var_65_3.time) - (self._lastPrivateConnectTime[var_65_4] or 0)

				if var_65_3.id == g.core.model.User:getId() then
					var_65_3.receiver = tonumber(var_65_3.receiver)

					if var_65_3.receiver then
						self._privateInfo[var_65_3.receiver] = self._privateInfo[var_65_3.receiver] or {}

						if self._lastConnectPlayerInfo[var_65_3.receiver] then
							var_65_3.server_name = self._lastConnectPlayerInfo[var_65_3.receiver].server_name
						end

						self._lastConnectPlayerInfo[var_65_3.receiver] = var_65_3

						if var_65_5 > ChatData.SHOW_TIME_INTERVAL then
							table.insert(self._privateInfo[var_65_3.receiver], {
								showTime = var_65_3.time - 1,
								time = var_65_3.time - 1
							})
							table.insert(self._chatList, {
								showTime = var_65_3.time - 1,
								time = var_65_3.time - 1
							})
						end

						local var_65_6 = {
							user = g.core.model.User:packUser(),
							content = var_65_3.content,
							time = var_65_3.time,
							channel = var_0_3.SINGLE,
							sub_type = var_65_3.sub_type,
							voice_path = var_65_3.voice_path,
							voice_time = var_65_3.voice_time,
							voice_param = var_65_3.voice_param,
							look = tonumber(var_65_3.look),
							talk = var_65_3.talk,
							server_name = var_65_3.server_name
						}

						var_65_6.user.mailId = iter_65_1.id

						if iter_65_1.sub_type == var_0_2.MailConst.SUB_TYPE.SHARE then
							self:checkMailShare(var_65_6)

							var_65_3.content = var_65_6.content
						end

						table.insert(self._privateInfo[var_65_3.receiver], var_65_6)
						table.insert(self._chatList, var_65_6)

						if self:getPrivatePlayerId() ~= var_65_3.receiver then
							local var_65_7 = self:getCachedChat()

							if not var_65_7[tostring(var_65_3.receiver)] or var_65_7[tostring(var_65_3.receiver)] and not var_65_7[tostring(var_65_3.receiver)][tostring(var_65_3.mailId)] then
								self._redPrivatePlayerList[var_65_3.receiver] = var_65_3.receiver
							elseif self:getPrivatePlayerId() ~= 0 then
								self._redPrivatePlayerList[self:getPrivatePlayerId()] = nil
							end
						end
					end
				else
					self._privateInfo[var_65_3.id] = self._privateInfo[var_65_3.id] or {}
					self._lastConnectPlayerInfo[var_65_3.id] = var_65_3

					if var_65_5 > ChatData.SHOW_TIME_INTERVAL then
						table.insert(self._privateInfo[var_65_3.id], {
							showTime = var_65_3.time - 1,
							time = var_65_3.time - 1
						})
						table.insert(self._chatList, {
							showTime = var_65_3.time - 1,
							time = var_65_3.time - 1
						})
					end

					local var_65_8 = {
						user = var_65_3,
						content = var_65_3.content,
						time = var_65_3.time,
						channel = var_0_3.SINGLE,
						sub_type = var_65_3.sub_type,
						voice_path = var_65_3.voice_path,
						voice_time = var_65_3.voice_time,
						voice_param = var_65_3.voice_param,
						look = tonumber(var_65_3.look),
						talk = var_65_3.talk,
						server_name = var_65_3.server_name
					}

					if iter_65_1.sub_type == var_0_2.MailConst.SUB_TYPE.SHARE then
						self:checkMailShare(var_65_8)

						var_65_3.content = var_65_8.content
					end

					table.insert(self._privateInfo[var_65_3.id], var_65_8)
					table.insert(self._chatList, var_65_8)

					if self:getPrivatePlayerId() ~= var_65_3.id then
						local var_65_9 = self:getCachedChat()

						if not var_65_9[tostring(var_65_3.id)] or var_65_9[tostring(var_65_3.id)] and not var_65_9[tostring(var_65_3.id)][tostring(var_65_3.mailId)] then
							self._redPrivatePlayerList[var_65_3.id] = var_65_3.id
						end
					elseif self:getPrivatePlayerId() == var_65_3.id then
						self._redPrivatePlayerList[self:getPrivatePlayerId()] = nil
					end
				end

				self._lastPrivateConnectTime[var_65_4] = var_65_3.time
			end
		end
	end
end

function ChatData:checkMailShare(arg_67_1)
	local var_67_0 = string.split(arg_67_1.content, ";")

	arg_67_1.content = ""
	arg_67_1.share = {
		share_type = tonumber(var_67_0[1])
	}
	arg_67_1.invite_id = tonumber(var_67_0[2])
	arg_67_1.param2 = table.concat({
		var_67_0[3],
		var_67_0[4],
		var_67_0[5]
	}, ";")

	self:checkShareInfo(arg_67_1)
end

function ChatData:getSingleMailInfoContent(arg_68_1)
	if arg_68_1.mails then
		for iter_68_0, iter_68_1 in ipairs(arg_68_1.mails) do
			local var_68_0 = {
				id = iter_68_1.sender_id,
				name = iter_68_1.name,
				time = tonumber(iter_68_1.time),
				mailId = iter_68_1.id,
				channel = var_0_3.SINGLE
			}

			if iter_68_1.keys and iter_68_1.values then
				for iter_68_2, iter_68_3 in ipairs(iter_68_1.keys) do
					var_68_0[iter_68_3] = iter_68_1.values[iter_68_2]
				end

				var_68_0.base_id = tonumber(var_68_0.baseid)

				if iter_68_1.sub_type == var_0_2.MailConst.SUB_TYPE.SHARE then
					self:checkMailShare(var_68_0)
				end

				return var_68_0
			end
		end
	end
end

function ChatData:setPrivateChatPInfo(arg_69_1)
	arg_69_1.time = tonumber(g.core.common.ServerTime:getTime())
	self._lastConnectPlayerInfo[arg_69_1.id] = arg_69_1
end

function ChatData:deletePrivateChatPInfo(arg_70_1)
	if not arg_70_1 then
		return
	end

	arg_70_1 = tonumber(arg_70_1)

	self:deleteTopPrivateChat(arg_70_1)

	self._lastConnectPlayerInfo[arg_70_1] = nil
	self._privateInfo[arg_70_1] = nil
end

function ChatData:changePrivateChatPInfo(arg_71_1)
	if self._lastConnectPlayerInfo[arg_71_1.id] then
		arg_71_1.time = self._lastConnectPlayerInfo[arg_71_1.id].time
		self._lastConnectPlayerInfo[arg_71_1.id] = arg_71_1
	end
end

function ChatData:getPrivateChatPInfoById(arg_72_1)
	if arg_72_1 and arg_72_1.id and self._lastConnectPlayerInfo[arg_72_1.id] then
		return self._lastConnectPlayerInfo[arg_72_1.id]
	end
end

function ChatData:getPrivateChatPInfo()
	local var_73_0 = {}

	self._topConnectPlayerInfo = self._topConnectPlayerInfo or ChatCommon:getTopJson()

	for iter_73_0, iter_73_1 in pairs(self._lastConnectPlayerInfo) do
		iter_73_1.top = self._topConnectPlayerInfo[iter_73_0] or 0
	end

	for iter_73_2, iter_73_3 in pairs(self._lastConnectPlayerInfo) do
		if not self:isInBlackList(iter_73_2) then
			table.insert(var_73_0, iter_73_3)
		end
	end

	if #var_73_0 > 0 then
		table.sort(var_73_0, function(arg_74_0, arg_74_1)
			if arg_74_0.top ~= arg_74_1.top then
				return arg_74_0.top > arg_74_1.top
			end

			if arg_74_0.time ~= arg_74_1.time then
				return arg_74_0.time > arg_74_1.time
			end
		end)
	end

	return var_73_0
end

function ChatData:setTopPrivateChat(arg_75_1)
	if self._lastConnectPlayerInfo[arg_75_1] then
		self._topConnectPlayerInfo = self._topConnectPlayerInfo or ChatCommon:getTopJson()
		self._topConnectPlayerInfo[arg_75_1] = tonumber(g.core.common.ServerTime:getTime())

		ChatCommon:setTopJson(self._topConnectPlayerInfo)
	end
end

function ChatData:getTopPrivateChat(arg_76_1)
	self._topConnectPlayerInfo = self._topConnectPlayerInfo or ChatCommon:getTopJson()

	return self._topConnectPlayerInfo[arg_76_1]
end

function ChatData:deleteTopPrivateChat(arg_77_1)
	if self._lastConnectPlayerInfo[arg_77_1] then
		self._topConnectPlayerInfo = self._topConnectPlayerInfo or ChatCommon:getTopJson()
		self._topConnectPlayerInfo[arg_77_1] = nil

		ChatCommon:setTopJson(self._topConnectPlayerInfo)
	end
end

function ChatData:getPrivateContent(arg_78_1)
	if self._privateInfo[arg_78_1] then
		table.sort(self._privateInfo[arg_78_1], function(arg_79_0, arg_79_1)
			if tonumber(arg_79_0.time) ~= tonumber(arg_79_1.time) then
				return tonumber(arg_79_0.time) < tonumber(arg_79_1.time)
			end
		end)

		return self._privateInfo[arg_78_1]
	end

	return {}
end

function ChatData:setLastConnectTime(arg_80_1, arg_80_2)
	self._lastConnectTime[arg_80_1] = not arg_80_2 and g.core.common.ServerTime:getTime() or arg_80_2
end

function ChatData:getLastConnectTime(arg_81_1)
	return self._lastConnectTime[arg_81_1]
end

function ChatData:setChatSetInfo(arg_82_1)
	self._isGetset = true

	if arg_82_1.config and arg_82_1.config.chat then
		for iter_82_0, iter_82_1 in ipairs(arg_82_1.config.chat) do
			self._setInfo[iter_82_0] = iter_82_1
		end
	end
end

function ChatData:updateSetInfo(arg_83_1)
	if arg_83_1 then
		self._setInfo = arg_83_1
	end
end

function ChatData:getChatSetInfo()
	local var_84_0 = {}

	for iter_84_0, iter_84_1 in ipairs(self._setInfo) do
		if var_0_3.SettingFunctionIds[iter_84_0] == 0 or g.core.common.ModuleUnlock:isModuleUnlock(var_0_3.SettingFunctionIds[iter_84_0]) then
			var_84_0[#var_84_0 + 1] = iter_84_1
		end
	end

	return var_84_0, self._isGetset
end

function ChatData:getPrivatePlayerInfoById(arg_85_1)
	arg_85_1 = tonumber(arg_85_1)

	local var_85_0 = {}
	local var_85_1 = {}

	if self._privateInfo[arg_85_1] then
		for iter_85_0, iter_85_1 in pairs(self._privateInfo[arg_85_1]) do
			if iter_85_1.user and iter_85_1.user.mailId then
				table.insert(var_85_0, 3)
				table.insert(var_85_1, iter_85_1.user.mailId)
			end
		end
	end

	return var_85_0, var_85_1
end

function ChatData:isCanCall(arg_86_1)
	local var_86_0 = tonumber(g.core.common.ServerTime:getTime())
	local var_86_1 = self:getLastSendConnectTime(arg_86_1)
	local var_86_2 = g.core.config.parameter_info.get(var_0_2.PARAMETER_CONST.CHAT_CD_TIME).parameter

	if arg_86_1 == var_0_3.WORLD or arg_86_1 == var_0_3.AREA then
		var_86_2 = g.core.config.parameter_info.get(var_0_2.PARAMETER_CONST.CHAT_WORLD_CD_TIME).parameter
	elseif arg_86_1 == var_0_3.GVE then
		var_86_2 = g.core.config.parameter_info.get(var_0_2.PARAMETER_CONST.CHAT_GVE_CD_LIMIT).parameter
	end

	if var_86_0 - var_86_1 >= tonumber(var_86_2) then
		return true
	end

	return false
end

function ChatData:isInBlackList(arg_87_1)
	local var_87_0 = g.core.model.User.friendData:getBlackList()

	if not var_87_0 then
		return false
	end

	for iter_87_0, iter_87_1 in ipairs(var_87_0) do
		if iter_87_1:getBasicInfo().id == arg_87_1 then
			return true
		end
	end

	return false
end

function ChatData:getCachedChat()
	local var_88_0 = g.core.common.Storage:load("chat_info.json")

	if var_88_0 and var_88_0.data then
		return var_88_0.data
	end

	return {}
end

function ChatData:setCacheChat(arg_89_1, arg_89_2)
	self._savePrivateReadInfo[arg_89_1] = arg_89_2

	g.core.common.Storage:save("chat_info.json", {
		data = self._savePrivateReadInfo
	})
end

function ChatData:savePrivate(arg_90_1, arg_90_2)
	local var_90_0 = g.core.common.Storage:load("chat_info.json")

	if var_90_0 and var_90_0.data then
		self._savePrivateReadInfo = var_90_0.data
	end

	if arg_90_1 and tonumber(arg_90_1) > 0 then
		for iter_90_0, iter_90_1 in pairs(arg_90_2) do
			if iter_90_1.user and iter_90_1.user.mailId then
				self._savePrivateReadInfo[tostring(arg_90_1)] = self._savePrivateReadInfo[tostring(arg_90_1)] or {}
				self._savePrivateReadInfo[tostring(arg_90_1)][tostring(iter_90_1.user.mailId)] = iter_90_1.user.mailId
			end
		end

		g.core.common.Storage:save("chat_info.json", {
			data = self._savePrivateReadInfo
		})
	end
end

function ChatData:deletePrivateFromCache(arg_91_1)
	local var_91_0 = g.core.common.Storage:load("chat_info.json")

	if var_91_0 and var_91_0.data then
		self._savePrivateReadInfo = var_91_0.data
	end

	if arg_91_1 and arg_91_1 > 0 then
		self._savePrivateReadInfo[tostring(arg_91_1)] = nil

		g.core.common.Storage:save("chat_info.json", {
			data = self._savePrivateReadInfo
		})
	end
end

function ChatData:getPrivateRedPointPlayerList()
	local var_92_0 = {}

	for iter_92_0, iter_92_1 in pairs(self._redPrivatePlayerList) do
		if iter_92_1 and iter_92_1 > 0 and not self:isInBlackList(iter_92_1) then
			var_92_0[iter_92_1] = iter_92_1
		end
	end

	return var_92_0
end

function ChatData:setPrivateRedPointPlayerList(arg_93_1)
	if arg_93_1 then
		self._redPrivatePlayerList[arg_93_1] = nil
	end
end

function ChatData:checkShareInfo(arg_94_1)
	if arg_94_1.share then
		if arg_94_1.share.share_type == 1 then
			arg_94_1.content = string.format(g.core.lang:get(1039), (arg_94_1.share.battle_res_share_title or nil) and (arg_94_1.share.battle_res_share_title.enemy_name and g.core.lang:get(1041, {
				name1 = arg_94_1.share.battle_res_share_title.own_name,
				name2 = arg_94_1.share.battle_res_share_title.enemy_name
			}) or g.core.lang:get(1040, {
				name = arg_94_1.share.battle_res_share_title.own_name
			})))
		elseif arg_94_1.share.share_type == 2 then
			if arg_94_1.share.id == 0 then
				arg_94_1.content = g.core.lang:get(1126)
			elseif arg_94_1.share.id == 1 then
				arg_94_1.content = g.core.lang:get(1127)
			end
		elseif arg_94_1.share.share_type == 3 then
			local var_94_1 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			if arg_94_1.share.battle_res_share_title then
				local var_94_2 = 0
				local var_94_3 = arg_94_1.param1 and tonumber(arg_94_1.param1) or 0

				if var_94_3 > 0 and var_94_1.function_id == var_0_2.FUNCTION_TYPE.BIO_MAIN then
					arg_94_1.share.battle_res_share_title.own_name = g.core.config.biography_team_info.get(var_94_3).name
					var_94_2 = g.core.config.biography_team_info.get(var_94_3).fight_power
				end

				if arg_94_1.invite_id == 1 then
					arg_94_1.content = string.gsub(var_94_1.content_1, "#name#", arg_94_1.share.battle_res_share_title.own_name)
				else
					arg_94_1.content = string.gsub(var_94_1.content_1, "#battle_name#", arg_94_1.share.battle_res_share_title.own_name)
					arg_94_1.content = string.gsub(arg_94_1.content, "#power#", var_94_2)
				end
			end

			arg_94_1.title = var_94_1.content_2
		elseif arg_94_1.share.share_type == 4 then
			arg_94_1.content = g.core.config.chat_invite_info.get(arg_94_1.invite_id).content_1
		elseif arg_94_1.share.share_type == 5 then
			local var_94_4 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.content = string.gsub(var_94_4.content_1, "#name#", arg_94_1.user.name)
			arg_94_1.title = var_94_4.content_2
		elseif arg_94_1.share.share_type == 6 then
			local var_94_5 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.content = string.gsub(var_94_5.content_1, "#name#", arg_94_1.user.name)
			arg_94_1.title = var_94_5.content_2
		elseif arg_94_1.share.share_type == 7 then
			local var_94_6 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.content = string.gsub(var_94_6.content_1, "#name#", arg_94_1.user.name)
			arg_94_1.title = var_94_6.content_2
		elseif arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_8 then
			local var_94_7 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.content = string.gsub(var_94_7.content_1, "#name#", arg_94_1.user.name)
			arg_94_1.title = var_94_7.content_2
		elseif arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_10 then
			local var_94_8 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.content = string.gsub(var_94_8.content_1, "#name#", arg_94_1.user.name)
			arg_94_1.title = var_94_8.content_2
		elseif arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_12 or arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_11 then
			local var_94_9 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.content = string.gsub(var_94_9.content_1, "#name#", arg_94_1.user.name)
			arg_94_1.title = var_94_9.content_2
		elseif arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_13 then
			local var_94_10 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.content = string.gsub(var_94_10.content_1, "#name#", arg_94_1.user.guild_name)
			arg_94_1.title = var_94_10.content_2
		elseif arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_14 then
			local var_94_11 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.content = string.gsub(var_94_11.content_1, "#name1#", arg_94_1.user.name)
			arg_94_1.content = string.gsub(arg_94_1.content, "#name2#", (g.core.config.dungeon_stinger_info.fetch(arg_94_1.param1 or 1, arg_94_1.unique_id or 1) or {}).title or "")
			arg_94_1.title = var_94_11.content_2
		elseif arg_94_1.share.share_type == 15 then
			arg_94_1.invite_id = 24

			local var_94_13 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.content = string.gsub(var_94_13.content_1, "#name#", arg_94_1.user.name)
			arg_94_1.title = var_94_13.content_2
		elseif arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_20 then
			local var_94_14 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)
			local var_94_15 = arg_94_1.param1 and tonumber(arg_94_1.param1) or 0

			arg_94_1.content = string.gsub(var_94_14.content_1, "#battle_name#", var_94_15 > 0 and g.core.config.group_battle_map_info.get(var_94_15).name or g.core.model.User.teamPvpData:getMapInfo().name)
			arg_94_1.title = var_94_14.content_2
		elseif arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_21 then
			local var_94_17 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.content = string.gsub(string.gsub(var_94_17.content_1, "#name#", arg_94_1.user.name), "#num#", arg_94_1.param1)
			arg_94_1.title = var_94_17.content_2
		elseif arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_22 then
			local var_94_19 = string.split(arg_94_1.param2 or "", ";")
			local var_94_20 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.content = string.gsub(string.gsub(var_94_20.content_1, "#name#", var_94_19[3]), "#num#", var_94_19[2])
			arg_94_1.title = var_94_20.content_2
		elseif arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_23 then
			local var_94_21 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.title = var_94_21.content_2
			arg_94_1.content = string.gsub(var_94_21.content_1, "#name#", arg_94_1.user.alliance_name or "")
		elseif arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_24 then
			local var_94_22 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)
			local var_94_23 = string.split(arg_94_1.param2, ";")

			if arg_94_1.invite_id == 48 or arg_94_1.invite_id == 49 then
				local var_94_24 = g.core.config.new_slg_boss_info.get(tonumber(var_94_23[1]))

				arg_94_1.title = var_94_22.content_2
				arg_94_1.content = string.gsub(string.gsub(var_94_22.content_1, "#name#", var_94_24.name), "#level#", var_94_24.level)
			elseif arg_94_1.invite_id >= 50 and arg_94_1.invite_id <= 55 then
				arg_94_1.title = var_94_22.content_2
				arg_94_1.content = g.core.lang:getByString(var_94_22.content_1, {
					X = tonumber(var_94_23[1]),
					Y = tonumber(var_94_23[2]),
					level = var_94_23[3],
					name = var_94_23[4]
				})
			end
		elseif arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_25 then
			local var_94_26 = string.split(arg_94_1.param2 or "", ";")
			local var_94_27 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.title = var_94_27.content_2

			local var_94_28 = g.core.config.item_info.fetch((tonumber(var_94_26[2])))

			arg_94_1.content = string.gsub(var_94_27.content_1, "#name#", (var_94_28 or nil) and (var_94_28.name or ""))
		elseif arg_94_1.share.share_type == var_0_4.SHARE_TYPE.TYPE_ID_26 then
			local var_94_29 = g.core.config.chat_invite_info.get(arg_94_1.invite_id)

			arg_94_1.title = var_94_29.content_2
			arg_94_1.content = string.gsub(var_94_29.content_1, "#name#", arg_94_1.teamId or "")
		end
	end
end

function ChatData:clearChatByChannel(arg_95_1)
	for iter_95_0, iter_95_1 in pairs(self._chatFloatInfo) do
		if iter_95_1.channel == arg_95_1 then
			self._chatFloatInfo[iter_95_0] = nil
		end
	end

	self._allChatInfo[arg_95_1] = {}
end

function ChatData:setNoChannelChat(arg_96_1)
	self._channelHasNewChat[arg_96_1] = false
end

function ChatData:hasNewPrivateChat()
	return table.nums(self._redPrivatePlayerList) > 0
end

function ChatData:hasNewWorldChat()
	if self._setInfo[3] == 0 then
		return self._channelHasNewChat[var_0_3.WORLD]
	else
		return false
	end
end

function ChatData:hasCrossChat()
	if self._setInfo[5] == 0 then
		return self._channelHasNewChat[var_0_3.AREA]
	else
		return false
	end
end

function ChatData:hasNewArmyChat()
	if not self:getChannelFlag(var_0_3.ARMY) then
		self._channelHasNewChat[var_0_3.ARMY] = false
	end

	if self._setInfo[4] == 0 then
		return self._channelHasNewChat[var_0_3.ARMY]
	else
		return false
	end
end

function ChatData:hasNewTroopsChat()
	if not self:getChannelFlag(var_0_3.TROOPS) then
		self._channelHasNewChat[var_0_3.TROOPS] = false
	end

	return self._channelHasNewChat[var_0_3.TROOPS]
end

function ChatData:hasNewGuildWarChat()
	if self:getChannelFlag(var_0_3.GUILD_WAR) then
		self._channelHasNewChat[var_0_3.GUILD_WAR] = false
	else
		return self._channelHasNewChat[var_0_3.GUILD_WAR]
	end
end

function ChatData:hasNewBountyChat()
	if not g.core.model.User.bountyData:isActivityOpen() then
		return false
	end

	if self._setInfo[5] == 0 then
		return self._channelHasNewChat[var_0_3.BOUNTY]
	else
		return false
	end
end

function ChatData:hasNewTeamBattleChat()
	if not g.core.model.User.teamBattleData:isActivityOpen() then
		return false
	end

	if self._setInfo[5] == 0 then
		return self._channelHasNewChat[var_0_3.TEAM_BATTLE]
	else
		return false
	end
end

function ChatData:hasNewAllianceChat()
	if not g.core.model.User.allianceData:hasAlliance() then
		return false
	end

	if self._setInfo[5] == 0 then
		return self._channelHasNewChat[var_0_3.ALLIANCE]
	else
		return false
	end
end

function ChatData:hasNewAnniversaryChat()
	if not g.core.model.User.anniversaryData:isActivityOpen() then
		return false
	end

	if self._setInfo[5] == 0 then
		return self._channelHasNewChat[var_0_3.ANNIVERSARY]
	else
		return false
	end
end

function ChatData:getBioTeamBattleAddFriendChatMessage(arg_107_1)
	local var_107_1 = g.core.config.chat_invite_info.fetch(4) or {}

	return (var_107_1 and var_107_1.content_1 or nil) and string.gsub(var_107_1.content_1, "#name#", (arg_107_1.inviter or {}).name or "")
end

function ChatData:updateChatFaceData()
	self._chatFaceMapData = {}
	self._chatFaceListData = {}

	local var_108_0 = g.core.common.ServerTime:getTime()

	for iter_108_0 = 1, var_0_1.getLength() do
		local var_108_1 = var_0_1.indexOf(iter_108_0).toObject()

		if var_108_1 and var_108_1.function_type == 2 then
			if not (var_108_1.time_type == 2 and var_108_0 - var_108_1.time_num > 0) then
				local var_108_3 = self:_getFaceCfgByGroupId(var_108_1.group)

				if var_108_3 then
					if var_108_1.free == 1 then
						self._chatFaceMapData[var_108_1.group] = self._chatFaceMapData[var_108_1.group] or {}
						self._chatFaceMapData[var_108_1.group] = {
							faces = var_108_3,
							groupInfo = var_108_1
						}

						table.insert(self._chatFaceListData, {
							faces = var_108_3,
							groupInfo = var_108_1
						})
					elseif g.core.model.User:getPropChatById(var_108_1.group) then
						self._chatFaceMapData[var_108_1.group] = self._chatFaceMapData[var_108_1.group] or {}

						local var_108_4 = self:_getFaceCfgByGroupId(var_108_1.group)

						self._chatFaceMapData[var_108_1.group] = {
							faces = var_108_4,
							groupInfo = var_108_1
						}

						table.insert(self._chatFaceListData, {
							faces = var_108_4,
							groupInfo = var_108_1
						})
					end
				end
			end
		end
	end
end

function ChatData:_initAllFaceCfg()
	self._allFaceCfgData = {}

	for iter_109_0 = 1, var_0_0.getLength() do
		local var_109_0 = var_0_0.indexOf(iter_109_0).toObject()

		if var_109_0 then
			self._allFaceCfgData[var_109_0.group] = self._allFaceCfgData[var_109_0.group] or {}

			table.insert(self._allFaceCfgData[var_109_0.group], clone(var_109_0))
		end
	end
end

function ChatData:_getFaceCfgByGroupId(arg_110_1)
	return self._allFaceCfgData[arg_110_1]
end

function ChatData:getAllChatFaceData()
	return self._chatFaceMapData
end

function ChatData:getAllChatFaceDataByGroup(arg_112_1)
	return self._chatFaceMapData[arg_112_1]
end

function ChatData:getChatFaceListData()
	return self._chatFaceListData
end

function ChatData:isChatFaceGroupTimeExpire(arg_114_1)
	return (self._chatFaceMapData[arg_114_1] and self._chatFaceMapData[arg_114_1].groupInfo and self._chatFaceMapData[arg_114_1].groupInfo.time_type == 2 or nil) and g.core.common.ServerTime:getTime() - (self._chatFaceMapData[arg_114_1].groupInfo.time_num or 0) > 0
end

function ChatData:hasNewFaceGroup(arg_115_1)
	local var_115_0 = g.core.common.Storage:load("chat_new_face_group.json") or {}

	local function var_115_1(arg_116_0)
		if arg_116_0 == 1 or arg_116_0 == "1" then
			return false
		else
			return not var_115_0[arg_116_0]
		end
	end

	if arg_115_1.groupId then
		return var_115_1(tostring(arg_115_1.groupId))
	else
		for iter_115_0, iter_115_1 in pairs(self._chatFaceMapData) do
			if var_115_1(tostring(iter_115_0)) then
				return true
			end
		end

		return false
	end
end

function ChatData:setFaceGroupRecord(arg_117_1)
	local var_117_0 = g.core.common.Storage:load("chat_new_face_group.json") or {}

	var_117_0[tostring(arg_117_1)] = var_117_0[tostring(arg_117_1)] or "1"

	g.core.common.Storage:save("chat_new_face_group.json", var_117_0)
end

function ChatData:isCrossServerChat(arg_118_1)
	return checkbool(var_0_3.CrossType[arg_118_1])
end

function ChatData:isFriendCrossServer(arg_119_1)
	return g.core.platform.ServerListProxy:isOtherServerUser(arg_119_1)
end

function ChatData:toSvrChatType(arg_120_1)
	if self:isCrossServerChat(arg_120_1) then
		return var_0_3.CrossType[arg_120_1]
	else
		return var_0_3[arg_120_1]
	end
end

function ChatData:toChatType(arg_121_1)
	return table.keyof(var_0_3.CrossType, arg_121_1) or arg_121_1
end

function ChatData:isChatCostHorn(arg_122_1)
	return arg_122_1 == var_0_3.STORM or arg_122_1 == var_0_3.WRESTAREA or arg_122_1 == var_0_3.WRESTALL
end

function ChatData:appendViewPlayerUser(arg_123_1)
	if arg_123_1 and arg_123_1.view_user then
		if arg_123_1.view_user.id and self:isInBlackList(arg_123_1.view_user.id) then
			return false
		end

		local var_123_0 = {
			viewUser = arg_123_1.view_user,
			channel = var_0_3.SYSTEM,
			time = tonumber(g.core.common.ServerTime:getTime())
		}

		table.insert(self._chatFloatInfo, var_123_0)
		table.insert(self._viewPlayerList, var_123_0)

		return true
	end
end

function ChatData:setFirstEnterFlag()
	self._isFirstEnterHomeLayer = false
end

function ChatData:getFirstEnterFlag()
	return self._isFirstEnterHomeLayer
end

return ChatData
