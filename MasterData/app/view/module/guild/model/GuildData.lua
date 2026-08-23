local GuildData = class("GuildData")
local AutoButtonConst = require("app.view.common.const.AutoButtonConst")
local var_0_2 = g.core.config.guild_info
local var_0_3 = g.core.config.guild_icon_info
local var_0_4 = g.core.config.guild_right_info
local var_0_5 = g.core.config.guild_news_info
local var_0_6 = g.core.config.guild_worship_info
local var_0_7 = g.core.config.guild_random_move_info
local var_0_8 = g.core.const.ConstMgr.GuildCommonConst
local var_0_9 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_10 = g.core.common.ModuleUnlock
local var_0_11 = {
	POSITION = 0,
	DONATE = 2,
	FIGHT_VALUE = 1,
	STATE = 3
}

function GuildData:ctor()
	self:initData()
end

function GuildData:initData()
	self._hasGuild = false
	self._signList = {}
	self._signInitList = {}
	self._initFrame = nil
	self._frameList = {}
	self._guildData = {}
	self._guildId = 0
	self._recommendData = {}
	self._memberData = {}
	self._applyData = {}
	self._applyHistory = {}
	self._historyId = {}
	self._msgData = {}
	self._logData = {}
	self._searchData = {}
	self._worshipData = {}
	self._guildLevel = 1
	self._signId = 0
	self._frameId = 0
	self._rightId = 1
	self._joinTime = 0
	self._joinCd = 0
	self._recordId = {}
	self._worshipLog = {}
	self._joinGuildTime = 0
	self._isResponse = false
	self._isWorshipRes = false
	self._redPointData = {}
	self._msgTime = {}
	self._applyNum = 0
	self._memberNum = 0
	self._activeUserNum = 0
	self._sendMergeDict = {}
	self._receiveMergeList = {}
	self._hasMergeApplyRed = false

	self:_updateIconList()
end

function GuildData:onRcvNotifyJoin(arg_3_1, arg_3_2, arg_3_3)
	self._hasGuild = true
	self._recordId = {}

	self:updateGuildData(arg_3_3)

	if self._hasGuild and config.SHOW_BETA_FEEDBACK_BOARD then
		g.core.platform.PlatformProxy:imJoinRoom(self:getGuildId())
	end

	g.core.network.GameNetProxy:send_C2S_FlushRedPoint({})
end

function GuildData:onRcvNotifyMerge()
	g.core.model.User.chatData:clearGuildChatCache()

	self._guildId = 0
	self._hasGuild = true
	self._guildData = {}
	self._memberData = {}
	self._recordId = {}
	self._memberNum = 0
end

function GuildData:onRcvNotifyLeave()
	g.core.platform.PlatformProxy:imLeaveRoom(self._guildData.id)
	g.core.model.User.chatData:clearGuildChatCache()

	self._guildId = 0
	self._hasGuild = false
	self._guildData = {}
	self._memberData = {}
	self._recordId = {}
	self._memberNum = 0
	self._hasMergeApplyRed = false
end

function GuildData:setRecordId()
	table.insert(self._recordId, self._guildId)
end

function GuildData:isRecord()
	for iter_7_0 = 1, #self._recordId do
		if self._recordId[iter_7_0] == self._guildId then
			return true
		end
	end

	return false
end

function GuildData:setHasGuild(arg_8_1)
	self._hasGuild = arg_8_1
end

function GuildData:updateGuildInfo(arg_9_1)
	self._hasMergeApplyRed = false
	self._isResponse = true

	if arg_9_1.ret == g.core.network.proto.RET_OK then
		self._hasGuild = true
	end

	self._joinCd = arg_9_1.join_guild_cool_time
	self._sendMergeDict = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.send_merge_data or {}) do
		self._sendMergeDict[iter_9_1.guild_id] = iter_9_1
	end

	self._receiveMergeList = arg_9_1.receive_merge_data or {}
	self._activeUserNum = arg_9_1.active_num or 0

	self:updateGuildData(arg_9_1)

	self._memberData = arg_9_1.members
	self._memberNum = #self._memberData

	self:_sortMemberData()
	self:_updateMyRightId()
	self:_updateMyJoinTime()
end

function GuildData:updateGuildData(arg_10_1)
	self._hasGuild = true
	self._guildData = arg_10_1.guild

	if not self._guildData then
		return
	end

	self._guildLevel = self._guildData.level
	self._guildId = self._guildData.id
	self._zeroLevel = arg_10_1.zero_hour_level
end

function GuildData:updateGuildApplyState(arg_11_1)
	for iter_11_0 = 1, #arg_11_1 do
		arg_11_1[iter_11_0].isApply = false

		for iter_11_1 = 1, #self._historyId do
			if self._historyId[iter_11_1] == arg_11_1[iter_11_0].id then
				arg_11_1[iter_11_0].isApply = true

				break
			end
		end
	end

	return arg_11_1
end

function GuildData:getGuildAllExp()
	local var_12_0 = self._guildData.exp

	for iter_12_0 = 1, self._guildData.level - 1 do
		var_12_0 = var_12_0 + g.core.config.guild_info.get(iter_12_0).exp
	end

	return var_12_0
end

function GuildData:updateRecommendGuild(arg_13_1)
	self:resetRecommendList()

	if arg_13_1.guilds then
		for iter_13_0 = 1, #arg_13_1.guilds do
			table.insert(self._recommendData, arg_13_1.guilds[iter_13_0])
		end
	end

	self._joinTime = arg_13_1.start_join_time or 0

	self:updateGuildApplyState(self._recommendData)
end

function GuildData:resetRecommendList()
	self._recommendData = {}
end

function GuildData:updateGuildModify(arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		if self._guildData[iter_15_0] ~= nil then
			if iter_15_0 == "confirm" then
				iter_15_1 = iter_15_1 == 1
			end

			self._guildData[iter_15_0] = iter_15_1
		end
	end
end

function GuildData:updateApplyData(arg_16_1)
	self._applyData = clone(arg_16_1.users) or {}
	self._redPointData.apply_num = #self._applyData
end

function GuildData:hasPlayerWaitApply()
	return self._redPointData.apply_num and self._redPointData.apply_num > 0
end

function GuildData:updateApplyHistory(arg_18_1)
	self._historyId = {}
	self._applyHistory = arg_18_1.guilds or {}

	for iter_18_0 = 1, #self._applyHistory do
		table.insert(self._historyId, self._applyHistory[iter_18_0].id)
	end
end

function GuildData:updateDeleteApply(arg_19_1)
	for iter_19_0 = 1, #self._applyHistory do
		if math.uint64_equal(self._applyHistory[iter_19_0].id, arg_19_1.guild_id) then
			table.remove(self._applyHistory, iter_19_0)

			break
		end
	end

	for iter_19_1 = 1, #self._historyId do
		if math.uint64_equal(self._historyId[iter_19_1], arg_19_1.guild_id) then
			table.remove(self._historyId, iter_19_1)

			break
		end
	end

	self:updateGuildApplyState(self._recommendData)
	self:updateGuildApplyState(self._searchData)
end

function GuildData:updateGuildReqJoin(arg_20_1)
	if not arg_20_1.join then
		table.insert(self._historyId, arg_20_1.guild_id)
		self:updateGuildApplyState(self._recommendData)
		self:updateGuildApplyState(self._searchData)
	else
		self._recordId = {}
		self._hasGuild = true

		g.core.network.GameNetProxy:send_C2S_FlushRedPoint({})
	end
end

function GuildData:updateSearchList(arg_21_1)
	self._searchData = arg_21_1.guilds

	self:updateGuildApplyState(self._searchData)
end

function GuildData:resetSearchList()
	self._searchData = {}
end

function GuildData:updateGuildQuit()
	self._recordId = {}
	self._hasGuild = false
	self._guildId = 0

	g.core.model.User.chatData:clearGuildChatCache()
end

function GuildData:updateAppoint(arg_24_1)
	for iter_24_0 = 1, #self._memberData do
		if arg_24_1.member_id == self._memberData[iter_24_0].user.id then
			self._memberData[iter_24_0].position = arg_24_1.position
		end

		if arg_24_1.position == 1 and self._memberData[iter_24_0].user.id == g.core.model.User:getId() then
			self._memberData[iter_24_0].position = 4
			self._rightId = 4
		end
	end

	self:_sortMemberData()
end

function GuildData:getMemberDataById(arg_25_1)
	for iter_25_0 = 1, #self._memberData do
		if arg_25_1 == self._memberData[iter_25_0].user.id then
			return self._memberData[iter_25_0]
		end
	end

	return nil
end

function GuildData:updateGuildLog(arg_26_1)
	if not arg_26_1.historys then
		return
	end

	table.sort(arg_26_1.historys, function(arg_27_0, arg_27_1)
		if arg_27_0.time ~= arg_27_1.time then
			return arg_27_0.time < arg_27_1.time
		end
	end)

	self._logData = {}
	self._worshipLog = {}

	local var_26_0 = {}
	local var_26_1 = loadCfg("core.config.cfg.language_info")

	for iter_26_0 = #arg_26_1.historys, 1, -1 do
		local var_26_3 = var_0_5.get(arg_26_1.historys[iter_26_0].base_id)

		if var_26_3.type == 1 or var_26_3.type == 3 then
			local var_26_4 = var_26_3.news
			local var_26_5 = g.core.common.ServerTime:getDateMDFormat(arg_26_1.historys[iter_26_0].time)

			if not var_26_0[var_26_5] then
				var_26_0[var_26_5] = true

				table.insert(self._logData, {
					type = 0,
					info = var_26_5
				})
			end

			local var_26_6 = {}

			for iter_26_1 = 1, #arg_26_1.historys[iter_26_0].key do
				var_26_6[arg_26_1.historys[iter_26_0].key[iter_26_1]] = g.core.lang:getServerRealValue(arg_26_1.historys[iter_26_0].key[iter_26_1], arg_26_1.historys[iter_26_0].value[iter_26_1])
			end

			if var_26_3.id == 13 and tonumber(var_26_6.position) then
				var_26_6.position = g.core.config.guild_right_info.get(tonumber(var_26_6.position)).name
			end

			local var_26_7

			if var_26_6.redpacket then
				var_26_6.redpacket = var_26_1.get(var_26_6.redpacket).value
				var_26_7 = {
					type = 1
				}
			end

			var_26_7.info = g.core.utils.String.dealMailStr(var_26_4, var_26_6)

			table.insert(self._logData, var_26_7)

			if var_26_3.id == 1 then
				table.insert(self._worshipLog, arg_26_1.historys[iter_26_0])
			end
		end
	end
end

function GuildData:updateMemberByReview(arg_28_1)
	if arg_28_1.accept then
		local var_28_0 = arg_28_1.remain_member or {}
		local var_28_1 = arg_28_1.apply_id or {}

		if #var_28_1 == 1 then
			if arg_28_1.ret ~= g.core.network.proto.RET_GUILD_LIMIT_TODAY then
				for iter_28_0 = #self._applyData, 1, -1 do
					if math.uint64_equal(self._applyData[iter_28_0].id, var_28_1[1]) then
						table.remove(self._applyData, iter_28_0)
					end
				end
			end
		else
			local var_28_2 = {}

			for iter_28_1 = 1, #var_28_0 do
				for iter_28_2 = 1, #self._applyData do
					if math.uint64_equal(self._applyData[iter_28_2].id, var_28_0[iter_28_1]) then
						table.insert(var_28_2, self._applyData[iter_28_2])
					end
				end
			end

			self._applyData = var_28_2
		end
	else
		for iter_28_3 = 1, #arg_28_1.apply_id do
			for iter_28_4 = #self._applyData, 1, -1 do
				if math.uint64_equal(self._applyData[iter_28_4].id, arg_28_1.apply_id[iter_28_3]) then
					table.remove(self._applyData, iter_28_4)
				end
			end
		end
	end

	self._redPointData.apply_num = #self._applyData

	for iter_28_5 = 1, #(arg_28_1.member or {}) do
		if arg_28_1.accept then
			table.insert(self._memberData, arg_28_1.member[iter_28_5])
		end
	end

	self:_sortMemberData()
end

function GuildData:updateMemberByKickOut(arg_29_1)
	for iter_29_0 = 1, #self._memberData do
		if math.uint64_equal(self._memberData[iter_29_0].user.id, arg_29_1.kick_id) then
			table.remove(self._memberData, iter_29_0)

			return
		end
	end
end

function GuildData:getGuildMemberByPlayerId(arg_30_1)
	for iter_30_0 = 1, #self._memberData do
		if arg_30_1 == self._memberData[iter_30_0].user.id then
			return self._memberData[iter_30_0]
		end
	end
end

function GuildData:updateGuildMessage(arg_31_1)
	self._msgData = arg_31_1.messages or {}
	self._msgTime = {}

	for iter_31_0 = 1, #self._msgData do
		table.insert(self._msgTime, self._msgData[iter_31_0].create_time)
	end

	self:_sortMsg()
end

function GuildData:updateMsg(arg_32_1)
	table.insert(self._msgData, arg_32_1.guild_message)
	self:_sortMsg()
end

function GuildData:_sortMsg()
	table.sort(self._msgData, function(arg_34_0, arg_34_1)
		if arg_34_0.top ~= arg_34_1.top then
			return arg_34_0.top
		end

		if arg_34_0.create_time ~= arg_34_1.create_time then
			return arg_34_0.create_time > arg_34_1.create_time
		end
	end)
end

function GuildData:updateSendCount(arg_35_1)
	g.core.model.User:setSendCount(arg_35_1.guild_send_count)
end

function GuildData:updateWorshipData(arg_36_1)
	self._isWorshipRes = true
	self._worshipData = arg_36_1 or {}
end

function GuildData:updateWorshipAwardId(arg_37_1)
	self._worshipData.awarded_id = self._worshipData.awarded_id or {}

	table.insert(self._worshipData.awarded_id, arg_37_1.index)
end

function GuildData:isWorship(arg_38_1)
	if not self._worshipData.worship_id then
		return false
	end

	for iter_38_0 = 1, #self._worshipData.worship_id do
		if arg_38_1 == self._worshipData.worship_id[iter_38_0] then
			return true
		end
	end

	return false
end

function GuildData:isWorshipAwardReceive(arg_39_1)
	if not self._worshipData.awarded_id then
		return false
	end

	for iter_39_0 = 1, #self._worshipData.awarded_id do
		if arg_39_1 == self._worshipData.awarded_id[iter_39_0] then
			return true
		end
	end

	return false
end

function GuildData:updateWorshipProg(arg_40_1)
	if self._worshipData.worship_id == nil then
		self._worshipData.worship_id = {
			arg_40_1.id
		}
	else
		self._worshipData.worship_id[#self._worshipData.worship_id + 1] = arg_40_1.id
	end

	self._worshipData.progress = self._worshipData.progress + var_0_6.get(arg_40_1.id).worship_value
end

function GuildData:isAnyWorship()
	return checkbool(self._worshipData.worship_id)
end

function GuildData:_sortMemberData()
	local var_42_0 = g.core.common.ServerTime:getTime()

	table.sort(self._memberData, function(arg_43_0, arg_43_1)
		local var_43_0 = arg_43_1.user
		local var_43_1 = arg_43_0.user.id == g.core.model.User:getId()

		if math.uint64_equal(arg_43_0.user.offline_time, 0) then
			local var_43_2 = var_42_0 or arg_43_0.user.offline_time

			if math.uint64_equal(var_43_0.offline_time, 0) then
				local var_43_3 = var_42_0 or var_43_0.offline_time

				if arg_43_0.position ~= arg_43_1.position then
					return arg_43_0.position < arg_43_1.position
				end

				if var_43_1 ~= (arg_43_1.user.id == g.core.model.User:getId()) then
					return var_43_1
				end

				if not math.uint64_equal(var_43_2, var_43_3) then
					return not math.uint64_lt(var_43_2, var_43_3, true)
				end

				if not math.uint64_equal(arg_43_0.user.fight_value, var_43_0.fight_value) then
					return not math.uint64_lt(arg_43_0.user.fight_value, var_43_0.fight_value, true)
				end
			end
		end
	end)
end

function GuildData:_updateMyRightId()
	for iter_44_0 = 1, #self._memberData do
		if self._memberData[iter_44_0].user.id == g.core.model.User:getId() then
			self._rightId = self._memberData[iter_44_0].position

			return
		end
	end
end

function GuildData:_updateMyJoinTime()
	for iter_45_0 = 1, #self._memberData do
		if self._memberData[iter_45_0].user.id == g.core.model.User:getId() then
			self._joinGuildTime = self._memberData[iter_45_0].user.join_guild_time

			return
		end
	end
end

function GuildData:_updateIconList()
	self._signList = {}
	self._frameList = {}

	for iter_46_0 = 1, var_0_3.getLength() do
		local var_46_0 = var_0_3.indexOf(iter_46_0)

		if var_46_0.type == 1 then
			table.insert(self._signList, var_46_0)

			if var_46_0.open_value == 0 then
				table.insert(self._signInitList, var_46_0)
			end
		elseif var_46_0.type == 2 then
			table.insert(self._frameList, var_46_0)

			if var_46_0.open_value == 0 then
				self._initFrame = var_46_0
			end
		end
	end
end

function GuildData:getCfg(arg_47_1)
	if not arg_47_1 or arg_47_1 == 0 then
		arg_47_1 = self._guildLevel
	end

	local var_47_0 = var_0_2.get(arg_47_1)

	if var_47_0.id ~= arg_47_1 then
		for iter_47_0 = 1, var_0_2.getLength() do
			local var_47_1 = var_0_2.indexOf(iter_47_0)

			if var_47_1.level == arg_47_1 then
				var_47_0 = var_47_1

				break
			end
		end
	end

	return var_47_0
end

function GuildData:getMyRightInfo()
	return self:getRightInfoById(self._rightId)
end

function GuildData:getRightInfoById(arg_49_1)
	if arg_49_1 <= 0 then
		return
	end

	return (var_0_4.get(arg_49_1))
end

function GuildData:getAppointArrayById(arg_50_1)
	local var_50_0 = {}

	if arg_50_1 < self._rightId then
		return var_50_0
	end

	if self._rightId == 1 then
		for iter_50_0 = 1, var_0_4.getLength() do
			if arg_50_1 ~= iter_50_0 then
				table.insert(var_50_0, (var_0_4.get(iter_50_0)))
			end
		end
	elseif self._rightId == 2 then
		for iter_50_1 = 2, var_0_4.getLength() do
			if iter_50_1 ~= arg_50_1 and iter_50_1 > self._rightId then
				table.insert(var_50_0, (var_0_4.get(iter_50_1)))
			end
		end
	end

	return var_50_0
end

function GuildData:getMsgWithDelete(arg_51_1, arg_51_2)
	table.remove(arg_51_1, arg_51_2)

	self._msgData = arg_51_1

	return arg_51_1
end

function GuildData:getMsgWithStick(arg_52_1, arg_52_2)
	if arg_52_2 > #arg_52_1 then
		return self._msgData
	end

	local var_52_0 = {
		arg_52_1[arg_52_2]
	}
	local var_52_1 = table.remove(arg_52_1, arg_52_2)

	arg_52_1 = self:getMsgCancelStick(arg_52_1)

	for iter_52_0 = 2, #arg_52_1 + 1 do
		var_52_0[iter_52_0] = arg_52_1[iter_52_0 - 1]
	end

	table.insert(arg_52_1, arg_52_2, var_52_1)

	for iter_52_1, iter_52_2 in ipairs(var_52_0) do
		iter_52_2.top = iter_52_1 == 1
	end

	self._msgData = var_52_0

	return var_52_0
end

function GuildData:getMsgCancelStick(arg_53_1)
	for iter_53_0, iter_53_1 in ipairs(arg_53_1) do
		iter_53_1.top = false
	end

	table.sort(arg_53_1, function(arg_54_0, arg_54_1)
		if arg_54_0.create_time ~= arg_54_1.create_time then
			return arg_54_0.create_time > arg_54_1.create_time
		end
	end)

	self._msgData = arg_53_1

	return arg_53_1
end

function GuildData:getRandomMember(arg_55_1)
	local var_55_0 = {}
	local var_55_1 = clone(self._memberData)

	for iter_55_0 = 1, #var_55_1 do
		if g.core.model.User:getId() == var_55_1[iter_55_0].user.id then
			table.remove(var_55_1, iter_55_0)

			break
		end
	end

	if arg_55_1 > #self._memberData then
		return var_55_1
	end

	for iter_55_1 = 1, arg_55_1 do
		local var_55_2 = math.random(1, #var_55_1)

		table.insert(var_55_0, var_55_1[var_55_2])
		table.remove(var_55_1, var_55_2)
	end

	return var_55_0
end

function GuildData:getShowPlayer()
	local var_56_1 = {}
	local var_56_2 = g.core.model.User:getId()

	for iter_56_0 = 1, #self._memberData do
		if self._memberData[iter_56_0] and self._memberData[iter_56_0].user.id ~= var_56_2 then
			table.insert(var_56_1, self._memberData[iter_56_0])
		end
	end

	local var_56_3 = g.core.common.ServerTime:getTime()

	table.sort(var_56_1, function(arg_57_0, arg_57_1)
		local var_57_0 = arg_57_1.user

		if math.uint64_equal(arg_57_0.user.offline_time, 0) then
			local var_57_1 = var_56_3 or arg_57_0.user.offline_time

			if math.uint64_equal(var_57_0.offline_time, 0) then
				local var_57_2 = var_56_3 or var_57_0.offline_time

				if not math.uint64_equal(var_57_1, var_57_2) then
					return not math.uint64_lt(var_57_1, var_57_2, true)
				end
			end
		end
	end)

	local var_56_4 = 0

	for iter_56_1 = 1, #var_56_1 do
		if var_56_1[iter_56_1].user.offline_time == 0 then
			var_56_4 = var_56_4 + 1
		end
	end

	local var_56_5 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_MEMBER_MIN).parameter
	local var_56_6 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_MEMBER_MAX).parameter
	local var_56_7 = 0
	local var_56_8

	if var_56_4 < var_56_5 then
		var_56_7 = var_56_5
	elseif var_56_5 <= var_56_4 and var_56_4 <= var_56_6 then
		var_56_7 = var_56_4
	elseif var_56_6 < var_56_4 then
		var_56_7 = var_56_6
		var_56_8 = {}
	end

	for iter_56_2 = 1, math.min(var_56_7, #var_56_1) do
		table.insert(var_56_8, var_56_1[iter_56_2])
	end

	return var_56_8
end

function GuildData:getRandomPosByWeight(arg_58_1, arg_58_2)
	local var_58_0 = {}
	local var_58_1 = {}
	local var_58_2 = {}
	local var_58_3 = g.core.model.User.guildStatueData:getStatueTimeStage()

	for iter_58_0 = 1, var_0_7.getLength() do
		local var_58_4 = var_0_7.indexOf(iter_58_0)

		if var_58_3 == 0 then
			table.insert(var_58_0, var_58_4.weight_common)
		else
			table.insert(var_58_0, var_58_4.weight_statue)
		end

		table.insert(var_58_1, var_58_4.id)
	end

	for iter_58_1 = 1, arg_58_1 do
		local var_58_5 = g.core.utils.Table.randomByWeight(var_58_0)

		table.remove(var_58_0, var_58_5)

		local var_58_6 = var_0_7.get((table.remove(var_58_1, var_58_5)))

		table.insert(var_58_2, {
			x = var_58_6.position_X,
			y = var_58_6.position_Y
		})
	end

	if arg_58_2 then
		local var_58_7 = {
			{},
			{}
		}

		for iter_58_2 = 1, arg_58_1 do
			if iter_58_2 <= math.floor(arg_58_1 / 2) then
				table.insert(var_58_7[1], var_58_2[iter_58_2])
			else
				table.insert(var_58_7[2], var_58_2[iter_58_2])
			end
		end

		return var_58_7
	else
		return var_58_2
	end
end

function GuildData:canSendGift()
	local var_59_0 = self:getCfg()
	local var_59_1 = g.core.model.User:getSendCount()

	return var_59_1 < var_59_0.gift_send_num, var_59_0.gift_send_num - var_59_1
end

function GuildData:updateRedPointData(arg_60_1)
	local var_60_0 = arg_60_1.guild_hint or {}

	self._redPointData = var_60_0
	self._hasMergeApplyRed = var_60_0.has_merge_confirm
	self._recordId = {}

	local var_60_1

	if var_60_0 then
		var_60_1 = var_60_0.guild_id or 0
	end

	self._rightId = var_60_0.member_position or 1
	self._guildLevel = var_60_0.guild_level or 1
	self._zeroLevel = var_60_0.zero_hour_level or 1

	local var_60_2 = var_60_1 > 0

	self._guildId = var_60_1

	g.core.model.User.guildWorshipData:updateRedPointData(var_60_0)
	g.core.model.User.GuildFightData:updateGuildFightRedData(var_60_0.guild_battle_hint)

	if var_60_2 then
		table.insert(self._recordId, var_60_1)
	end

	self:setHasGuild(var_60_2)

	self._msgTime = var_60_0.message_time or {}
	self._memberNum = var_60_0.member_num or 0
end

function GuildData:getGuildZeroLevel()
	self._zeroLevel = self._zeroLevel or self._guildLevel

	return self._zeroLevel
end

function GuildData:hasMineGatherRight()
	if self:hasGuild() then
		local var_62_0 = self:getMyRightInfo()

		if var_62_0 then
			return var_62_0.mass == 1
		end
	end

	return false
end

function GuildData:getSortMemberData(arg_63_1, arg_63_2, arg_63_3)
	local var_63_0

	if arg_63_1 == -1 then
		function var_63_0(arg_64_0, arg_64_1)
			if arg_64_0.user.offline_time ~= arg_64_1.user.offline_time then
				if arg_64_0.user.offline_time == 0 then
					return true
				end

				if arg_64_1.user.offline_time == 0 then
					return false
				end

				return arg_64_0.user.offline_time > arg_64_1.user.offline_time
			end

			if arg_64_0.position ~= arg_64_1.position then
				return arg_64_0.position < arg_64_1.position
			end

			if arg_64_0.total_contribute ~= arg_64_1.total_contribute then
				return arg_64_0.total_contribute > arg_64_1.total_contribute
			end

			return arg_64_0.user.id > arg_64_1.user.id
		end
	elseif arg_63_1 == var_0_11.POSITION then
		var_63_0 = arg_63_2 == var_0_8.SORT.UP and function(arg_65_0, arg_65_1)
			if arg_65_0.position ~= arg_65_1.position then
				return arg_65_0.position > arg_65_1.position
			end

			if arg_65_0.user.fight_value ~= arg_65_1.user.fight_value then
				return arg_65_0.user.fight_value < arg_65_1.user.fight_value
			end

			return arg_65_0.user.id < arg_65_1.user.id
		end or function(arg_66_0, arg_66_1)
			if arg_66_0.position ~= arg_66_1.position then
				return arg_66_0.position < arg_66_1.position
			end

			if arg_66_0.user.fight_value ~= arg_66_1.user.fight_value then
				return arg_66_0.user.fight_value > arg_66_1.user.fight_value
			end

			return arg_66_0.user.id < arg_66_1.user.id
		end
	elseif arg_63_1 == var_0_11.FIGHT_VALUE then
		var_63_0 = arg_63_2 == var_0_8.SORT.UP and function(arg_67_0, arg_67_1)
			if arg_67_0.user.fight_value ~= arg_67_1.user.fight_value then
				return arg_67_0.user.fight_value < arg_67_1.user.fight_value
			end

			return arg_67_0.user.id < arg_67_1.user.id
		end or function(arg_68_0, arg_68_1)
			if arg_68_0.user.fight_value ~= arg_68_1.user.fight_value then
				return arg_68_0.user.fight_value > arg_68_1.user.fight_value
			end

			return arg_68_0.user.id < arg_68_1.user.id
		end
	elseif arg_63_1 == var_0_11.DONATE then
		var_63_0 = arg_63_2 == var_0_8.SORT.UP and function(arg_69_0, arg_69_1)
			if arg_69_0.total_contribute ~= arg_69_1.total_contribute then
				return arg_69_0.total_contribute < arg_69_1.total_contribute
			end

			if arg_69_0.user.fight_value ~= arg_69_1.user.fight_value then
				return arg_69_0.user.fight_value < arg_69_1.user.fight_value
			end

			return arg_69_0.user.id < arg_69_1.user.id
		end or function(arg_70_0, arg_70_1)
			if arg_70_0.total_contribute ~= arg_70_1.total_contribute then
				return arg_70_0.total_contribute > arg_70_1.total_contribute
			end

			if arg_70_0.user.fight_value ~= arg_70_1.user.fight_value then
				return arg_70_0.user.fight_value > arg_70_1.user.fight_value
			end

			return arg_70_0.user.id < arg_70_1.user.id
		end
	elseif arg_63_1 == var_0_11.STATE then
		var_63_0 = arg_63_2 == var_0_8.SORT.UP and function(arg_71_0, arg_71_1)
			if arg_71_0.user.offline_time ~= arg_71_1.user.offline_time then
				if arg_71_0.user.offline_time == 0 then
					return false
				end

				if arg_71_1.user.offline_time == 0 then
					return true
				end

				return arg_71_0.user.offline_time < arg_71_1.user.offline_time
			end

			if arg_71_0.user.fight_value ~= arg_71_1.user.fight_value then
				return arg_71_0.user.fight_value < arg_71_1.user.fight_value
			end

			return arg_71_0.user.id < arg_71_1.user.id
		end or function(arg_72_0, arg_72_1)
			if arg_72_0.user.offline_time ~= arg_72_1.user.offline_time then
				if arg_72_0.user.offline_time == 0 then
					return true
				end

				if arg_72_1.user.offline_time == 0 then
					return false
				end

				return arg_72_0.user.offline_time > arg_72_1.user.offline_time
			end

			if arg_72_0.user.fight_value ~= arg_72_1.user.fight_value then
				return arg_72_0.user.fight_value > arg_72_1.user.fight_value
			end

			return arg_72_0.user.id < arg_72_1.user.id
		end
	end

	if arg_63_3 then
		if var_63_0 then
			table.sort(arg_63_3, var_63_0)
		end

		return arg_63_3
	else
		if var_63_0 then
			table.sort(self._memberData, var_63_0)
		end

		return self._memberData
	end
end

function GuildData:getSortApplyData(arg_73_1, arg_73_2)
	local var_73_0

	if arg_73_1 == var_0_11.FIGHT_VALUE then
		var_73_0 = arg_73_2 == var_0_8.SORT.UP and function(arg_74_0, arg_74_1)
			if arg_74_0.fight_value ~= arg_74_1.fight_value then
				return arg_74_0.fight_value < arg_74_1.fight_value
			end

			return arg_74_0.id < arg_74_1.id
		end or function(arg_75_0, arg_75_1)
			if arg_75_0.fight_value ~= arg_75_1.fight_value then
				return arg_75_0.fight_value > arg_75_1.fight_value
			end

			return arg_75_0.id < arg_75_1.id
		end
	elseif arg_73_1 == var_0_11.STATE then
		var_73_0 = arg_73_2 == var_0_8.SORT.UP and function(arg_76_0, arg_76_1)
			if arg_76_0.offline_time ~= arg_76_1.offline_time then
				if arg_76_0.offline_time == 0 then
					return false
				end

				if arg_76_1.offline_time == 0 then
					return true
				end

				return arg_76_0.offline_time < arg_76_1.offline_time
			end

			if arg_76_0.fight_value ~= arg_76_1.fight_value then
				return arg_76_0.fight_value < arg_76_1.fight_value
			end

			return arg_76_0.id < arg_76_1.id
		end or function(arg_77_0, arg_77_1)
			if arg_77_0.offline_time ~= arg_77_1.offline_time then
				if arg_77_0.offline_time == 0 then
					return true
				end

				if arg_77_1.offline_time == 0 then
					return false
				end

				return arg_77_0.offline_time > arg_77_1.offline_time
			end

			if arg_77_0.fight_value ~= arg_77_1.fight_value then
				return arg_77_0.fight_value > arg_77_1.fight_value
			end

			return arg_77_0.id < arg_77_1.id
		end
	end

	if var_73_0 then
		table.sort(self._applyData, var_73_0)
	end

	return self._applyData
end

function GuildData:getMyRightBtn(arg_78_1, arg_78_2, arg_78_3)
	local var_78_0 = AutoButtonConst.getButtonConst()
	local var_78_1 = {
		var_78_0.LINE_UP,
		var_78_0.ADD_FRIEND,
		var_78_0.BLACK_LIST,
		var_78_0.FIGHT
	}

	if arg_78_1 then
		local var_78_2 = self:getMyRightInfo()

		if var_78_2.appoint > 0 then
			table.insert(var_78_1, var_78_0.APPOINTMENT)
		end

		if var_78_2.kick > 0 and arg_78_2 > self._rightId then
			table.insert(var_78_1, var_78_0.REMOVE)
		end
	end

	if var_0_10:isModuleUnlock(var_0_9.HOME_LAND_FURNITURE) then
		local var_78_3 = arg_78_3.user or arg_78_3

		if var_78_3.sid and tostring(var_78_3.sid) == tostring(g.core.platform.ServerListProxy:getSelectedServer().sid) then
			table.insert(var_78_1, var_78_0.FRIEND_FURNITURE)
		end
	end

	return var_78_1
end

function GuildData:getRecommendList(arg_79_1, arg_79_2)
	local var_79_0 = {}

	if arg_79_1 then
		local var_79_1 = self:getUniqueRecommendList(clone(arg_79_2))

		if arg_79_1 == var_0_8.commendType.ALL then
			var_79_0 = var_79_1
		else
			for iter_79_0, iter_79_1 in ipairs(var_79_1) do
				if (iter_79_1.apply_level or 0) <= (g.core.model.User:getLevel() or 0) and ((not iter_79_1.member_num or nil) and 0) ~= self:getCfg(iter_79_1.level).number then
					table.insert(var_79_0, iter_79_1)
				end
			end
		end
	end

	return var_79_0
end

function GuildData:getUniqueRecommendList(arg_80_1)
	local var_80_0 = arg_80_1 or {}
	local var_80_1 = clone(self._recommendData)

	for iter_80_0 = #var_80_1, 1, -1 do
		for iter_80_1, iter_80_2 in ipairs(var_80_0) do
			if iter_80_2.id == var_80_1[iter_80_0].id then
				table.remove(var_80_1, iter_80_0)

				break
			end
		end
	end

	for iter_80_3, iter_80_4 in ipairs(var_80_1) do
		table.insert(var_80_0, #var_80_0 + iter_80_3, iter_80_4)
	end

	return var_80_0
end

function GuildData:getGuildData()
	return self._guildData
end

function GuildData:getGuildLevel()
	return self._guildLevel
end

function GuildData:getGuildId()
	return self._guildId
end

function GuildData:getMemberData()
	return self._memberData
end

function GuildData:getMsgData()
	return self._msgData
end

function GuildData:getSignList()
	return self._signList
end

function GuildData:getSignInitList()
	return self._signInitList
end

function GuildData:getInitFrame()
	return self._initFrame
end

function GuildData:getFrameList()
	return self._frameList
end

function GuildData:getCurSignId()
	return self._signId
end

function GuildData:getCurFrameId()
	return self._frameId
end

function GuildData:getMyRightId()
	return self._rightId
end

function GuildData:hasGuild()
	return self._hasGuild
end

function GuildData:getApplyData()
	return self._applyData
end

function GuildData:getGuildLog()
	return self._logData
end

function GuildData:getWorshipData()
	return self._worshipData
end

function GuildData:getApplyHistory()
	return self._applyHistory
end

function GuildData:getSearchList()
	return self._searchData
end

function GuildData:getJoinTime()
	return self._joinTime
end

function GuildData:getJoinCd()
	return self._joinCd
end

function GuildData:isResponse()
	return self._isResponse
end

function GuildData:isWorshipResponse()
	return self._isWorshipRes
end

function GuildData:getRedPointData()
	return self._redPointData
end

function GuildData:getWorshipLog()
	return self._worshipLog
end

function GuildData:getJoinGuildTime()
	return self._joinGuildTime
end

function GuildData:getMsgTimeArr()
	return self._msgTime
end

function GuildData:getMemberNum()
	return self._memberNum
end

function GuildData:isLeader(arg_108_1)
	if not arg_108_1 or arg_108_1 == g.core.model.User:getId() then
		return self._rightId == 1
	end

	return self._guildData.leader_id == arg_108_1
end

function GuildData:isShowLowActive()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_MERGE) then
		return false
	end

	if not self:isLeader() then
		return false
	end

	return g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_ACTIVE_USER).parameter > self._activeUserNum
end

function GuildData:isShowMerge()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_MERGE) then
		return false
	end

	return self:isLeader()
end

function GuildData:isShowMergeBtn(arg_111_1)
	if self:hasSendMerge(arg_111_1.id) then
		return true
	end

	if arg_111_1.merge_confirm then
		return false, 430015
	end

	if arg_111_1.level < g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.SHOW_MERGE_BTN_LEVEL).parameter then
		return false, 430014
	end

	local var_111_0 = GuildData:getMergeLockTime()
	local var_111_1 = g.core.common.ServerTime:getTime()

	for iter_111_0, iter_111_1 in pairs(self._sendMergeDict) do
		if iter_111_1.is_confirm and var_111_1 < iter_111_1.merge_time + var_111_0 then
			return false, 430015
		end
	end

	for iter_111_2, iter_111_3 in ipairs(self._receiveMergeList) do
		if iter_111_3.is_confirm and var_111_1 < iter_111_3.merge_time + var_111_0 then
			return false, 430015
		end
	end

	return true
end

function GuildData:hasSendMerge(arg_112_1)
	return checkbool(self._sendMergeDict[arg_112_1])
end

function GuildData:getMergeData(arg_113_1)
	return self._sendMergeDict[arg_113_1] or {}
end

function GuildData:getReceiveMergeData(arg_114_1)
	for iter_114_0, iter_114_1 in ipairs(self._receiveMergeList) do
		if iter_114_1.guild_id == arg_114_1 then
			return iter_114_1
		end
	end

	return {}
end

function GuildData:getReceiveMergeList()
	return self._receiveMergeList
end

function GuildData:getMergeLockTime()
	return g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_MERGE_LOCK_TIME).parameter
end

function GuildData:onS2CRequest(arg_117_1)
	self._sendMergeDict[arg_117_1.merge_data.guild_id] = arg_117_1.merge_data
end

function GuildData:onS2CCancel(arg_118_1)
	self._sendMergeDict[arg_118_1.target_guild] = nil

	for iter_118_0, iter_118_1 in ipairs(self._receiveMergeList) do
		if iter_118_1.guild_id == arg_118_1.target_guild then
			table.remove(self._receiveMergeList, iter_118_0)

			break
		end
	end
end

function GuildData:onS2CAgree(arg_119_1)
	self._sendMergeDict = {}
	self._receiveMergeList = {}

	table.insert(self._receiveMergeList, arg_119_1.merge_data)
end

function GuildData:isLockUser(arg_120_1)
	arg_120_1 = arg_120_1 or g.core.model.User:getId()

	for iter_120_0, iter_120_1 in pairs(self._sendMergeDict) do
		if iter_120_1.is_confirm then
			for iter_120_2, iter_120_3 in pairs(iter_120_1.send_members or {}) do
				if iter_120_3.id == arg_120_1 then
					return true
				end
			end
		end
	end

	for iter_120_4, iter_120_5 in ipairs(self._receiveMergeList) do
		if iter_120_5.is_confirm then
			for iter_120_6, iter_120_7 in pairs(iter_120_5.send_members or {}) do
				if iter_120_7.id == arg_120_1 then
					return true
				end
			end
		end
	end

	return false
end

function GuildData:getCanMergeList()
	local var_121_0 = {}

	for iter_121_0, iter_121_1 in pairs(self._sendMergeDict) do
		if iter_121_1.is_confirm then
			for iter_121_2, iter_121_3 in ipairs(iter_121_1.send_members or {}) do
				var_121_0[iter_121_3.user.id] = true
			end
		end
	end

	for iter_121_4, iter_121_5 in ipairs(self._receiveMergeList) do
		if iter_121_5.is_confirm then
			for iter_121_6, iter_121_7 in ipairs(iter_121_5.send_members or {}) do
				var_121_0[iter_121_7.user.id] = true
			end
		end
	end

	local var_121_3 = {}

	for iter_121_8, iter_121_9 in ipairs(self._memberData) do
		if not var_121_0[iter_121_9.user.id] then
			table.insert(var_121_3, iter_121_9)
		end
	end

	return var_121_3
end

function GuildData:getCanPlayerExitGuildOrAlliance()
	if g.core.model.User.newSlgData:isOpen() and g.core.model.User.newSlgData:isPlaying() and g.core.model.User.newSlgData:isCityBattleTime() then
		return false, g.core.lang:get(429047)
	end

	return true
end

function GuildData:hasApplyMergeDataRed()
	if self._hasMergeApplyRed then
		return true
	end

	for iter_123_0, iter_123_1 in ipairs(self._receiveMergeList) do
		if not iter_123_1.is_confirm then
			return true
		end
	end

	return false
end

return GuildData
