local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.config.guild_alliance_honour_info
local var_0_2 = g.core.config.guild_alliance_icon_info
local var_0_3 = g.core.config.guild_alliance_parameter_info
local var_0_4 = g.core.config.guild_alliance_info
local var_0_5 = g.core.config.guild_alliance_dilatation_info
local var_0_6 = g.core.config.guild_alliance_log_info
local var_0_7 = g.core.config.guild_alliance_box_info
local var_0_8 = g.core.config.guild_alliance_honour_text_info
local var_0_9 = g.core.const.ConstMgr.AllianceConst
local AllianceTaskData = require("app.view.module.alliance.model.AllianceTaskData")
local AllianceData = class("AllianceData")

function AllianceData:ctor()
	self:initData()
end

function AllianceData:initData()
	self._boxData = require("app.view.module.alliance.model.AllianceBoxData").new()
	self._hasAlliance = false
	self._areaTime = 0
	self._guildAlliance = {}
	self._id = 0
	self._name = ""
	self._flag = 0
	self._leaderGuildId = 0
	self._viceLeaderGuildIdList = {}
	self._level = 0
	self._exp = 0
	self._confirm = false
	self._applyLevel = 0
	self._guildList = {}
	self._declare = ""
	self._announce = ""
	self._dailyExp = 0
	self._dailyResetTime = 0
	self._leaderOfflineTime = 0
	self._applyList = {}
	self._invitesMap = {}
	self._canInviteGuildList = {}
	self._noticeSetTimeMap = {}
	self._guildSuggestDict = {}
	self._guildApplyIdList = {}
	self._guildInviteIdList = {}
	self._joinAllianceTime = 0
	self._quitAllianceGuildTime = 0
	self._quitAllianceUserTime = 0
	self._isOnlyShowCanJoin = false
	self._popJoinAllianceId = -1
	self._popExpandAllianceDay = -1
	self._popLevelUpAlliance = -1
	self._lastGetUserTime = 0
	self._showUserList = {}
	self._memberList = nil
	self._taskData = AllianceTaskData.new()
	self._serverRedPoint = false
	self._getInfo = false
	self._serverHonourRedPoint = false
	self._dilatationLevelList = {}

	self:_initHonourDilatation()

	self._honourList = {}
	self._honourTextGroupDict = {}

	self:_initHonourTextGroup()
end

function AllianceData:_initHonourDilatation()
	for iter_3_0, iter_3_1 in var_0_5.ipairs() do
		self._dilatationLevelList[iter_3_1.level] = self._dilatationLevelList[iter_3_1.level] or {}

		table.insert(self._dilatationLevelList[iter_3_1.level], iter_3_1)
	end
end

function AllianceData:_initHonourTextGroup()
	for iter_4_0, iter_4_1 in var_0_8.ipairs() do
		self._honourTextGroupDict[iter_4_1.group] = self._honourTextGroupDict[iter_4_1.group] or {}

		table.insert(self._honourTextGroupDict[iter_4_1.group], iter_4_1)
	end
end

function AllianceData:getHonourTextGroup(arg_5_1)
	return self._honourTextGroupDict[arg_5_1] or {}
end

function AllianceData:isOnlyShowCanJoin()
	return self._isOnlyShowCanJoin
end

function AllianceData:setOnlyShowCanJoin(arg_7_1)
	self._isOnlyShowCanJoin = arg_7_1 == true
end

function AllianceData:updateAllianceData(arg_8_1)
	arg_8_1 = arg_8_1 or {}
	self._guildAlliance = arg_8_1
	self._id = arg_8_1.id or 0

	g.core.model.User:setAllianceId(self._id)

	self._name = arg_8_1.name or ""
	self._flag = arg_8_1.flag or 0
	self._leaderGuildId = arg_8_1.leader_guild_id or 0
	self._viceLeaderGuildIdList = arg_8_1.vice_leader_guild_ids or {}
	self._level = arg_8_1.level or 0
	self._exp = arg_8_1.exp or 0
	self._confirm = arg_8_1.confirm or false
	self._applyLevel = arg_8_1.apply_level or 0
	self._declare = arg_8_1.declaration or ""
	self._announce = arg_8_1.announcement or ""
	self._dailyExp = arg_8_1.daily_exp or 0
	self._dailyResetTime = arg_8_1.daily_reset_time or 0
	self._leaderOfflineTime = arg_8_1.leader_offline_time or 0
end

function AllianceData:getAllianceData()
	return self._guildAlliance
end

function AllianceData:getBoxData()
	return self._boxData
end

function AllianceData:isInAlliance()
	return self._hasAlliance
end

function AllianceData:getTaskData()
	return self._taskData
end

function AllianceData:onS2CGetInfo(arg_13_1)
	self._guildList = arg_13_1.guilds or {}

	local var_13_0 = g.core.model.User.guildData:getGuildId()

	for iter_13_0, iter_13_1 in ipairs(self._guildList) do
		if iter_13_1.guild_id == var_13_0 then
			self._joinAllianceTime = iter_13_1.join_time

			break
		end
	end

	self._hasAlliance = not not arg_13_1.alliance

	self:updateAllianceData(arg_13_1.alliance)

	self._guildSuggestDict = {}

	for iter_13_2, iter_13_3 in ipairs(arg_13_1.suggestions or {}) do
		self._guildSuggestDict[iter_13_3.alliance_id] = iter_13_3.user_ids
	end

	self._guildApplyIdList = arg_13_1.apply_alliance_ids or {}
	self._guildInviteIdList = arg_13_1.invite_alliance_ids or {}
	self._areaTime = arg_13_1.area_open_time or 0
	self._quitAllianceGuildTime = arg_13_1.last_guild_quit_time or 0
	self._quitAllianceUserTime = arg_13_1.last_user_quit_time or 0

	self._boxData:updateBoxData(arg_13_1.self_box_data or {})

	self._serverRedPoint = false
	self._getInfo = true
end

function AllianceData:onS2CGetBoxInfo(arg_14_1)
	self._boxData:onS2CGetBoxInfo(arg_14_1)
end

function AllianceData:onS2CBoxGet(arg_15_1)
	self._boxData:onS2CBoxGet(arg_15_1)
end

function AllianceData:onS2CBoxOpen(arg_16_1)
	self._boxData:onS2CBoxOpen(arg_16_1)
end

function AllianceData:onS2CBoxNotify(arg_17_1)
	self._boxData:onS2CBoxNotify(arg_17_1)
end

function AllianceData:onS2CBoxGrandNotify(arg_18_1)
	self._boxData:onS2CBoxGrandNotify(arg_18_1)
end

function AllianceData:onS2CBoxSendBox(arg_19_1)
	self._boxData:onS2CBoxSendBox(arg_19_1)
end

function AllianceData:onS2CBoxExchangeBoxAward(arg_20_1)
	self._boxData:onS2CBoxExchangeBoxAward(arg_20_1)
end

function AllianceData:onS2CGuildAllianceTaskList(arg_21_1)
	if arg_21_1.tasks then
		self._taskData:updateTaskData(arg_21_1.tasks)
	end
end

function AllianceData:onS2CGuildAllianceUserList(arg_22_1)
	self._memberList = arg_22_1.list
end

function AllianceData:onS2CHonorGetInfo(arg_23_1)
	self._serverHonourRedPoint = false
	self._honourList = {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_1.guild_honours or {}) do
		for iter_23_2, iter_23_3 in ipairs(iter_23_1.honours or {}) do
			local var_23_1 = {
				tp = iter_23_1.tp,
				honourData = iter_23_3
			}

			var_23_1.info = self:getHonourInfo(var_23_1)

			table.insert(self._honourList, var_23_1)
		end
	end

	table.sort(self._honourList, function(arg_24_0, arg_24_1)
		if arg_24_0.info.id ~= arg_24_1.info.id then
			return arg_24_0.info.id < arg_24_1.info.id
		end

		if arg_24_0.honourData.value ~= arg_24_1.honourData.value then
			return arg_24_1.honourData.value < arg_24_0.honourData.value
		end

		return arg_24_0.honourData.tm < arg_24_1.honourData.tm
	end)
end

function AllianceData:onS2CHonorSendLike(arg_25_1)
	local var_25_0 = arg_25_1.honour_like or {}

	for iter_25_0, iter_25_1 in ipairs(self._honourList) do
		if iter_25_1.tp == arg_25_1.tp and iter_25_1.honourData.uid == var_25_0.uid then
			iter_25_1.honourData = var_25_0

			break
		end
	end
end

function AllianceData:onS2CGuildAllianceGetLog(arg_26_1)
	self._guildAllianceLog = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_1.logs or {}) do
		local var_26_0 = g.core.common.ServerTime:getDateObject(iter_26_1.time)
		local var_26_1 = string.format("%4d_%2d_%2d", var_26_0.year, var_26_0.month, var_26_0.day)

		self._guildAllianceLog[var_26_1] = self._guildAllianceLog[var_26_1] or {}

		local var_26_2 = {
			type = iter_26_1.tp,
			time = iter_26_1.time
		}

		var_26_2.logDesc = self:_convertLogStringByTp(iter_26_1.tp, iter_26_1.params or {}, iter_26_1.awards)

		table.insert(self._guildAllianceLog[var_26_1], var_26_2)
	end

	self._allianceLogList = table.values(self._guildAllianceLog)

	self:sortAllianceLog()
end

function AllianceData:sortAllianceLog()
	table.sort(self._allianceLogList, function(arg_28_0, arg_28_1)
		if arg_28_0[1].time ~= arg_28_1[1].time then
			return arg_28_0[1].time > arg_28_1[1].time
		end

		return false
	end)

	for iter_27_0, iter_27_1 in ipairs(self._allianceLogList) do
		table.sort(iter_27_1, function(arg_29_0, arg_29_1)
			if arg_29_0.time ~= arg_29_1.time then
				return arg_29_0.time > arg_29_1.time
			end

			return false
		end)
	end
end

function AllianceData:_convertLogStringByTp(arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = ""
	local var_30_1 = var_0_6.get(arg_30_1)

	if arg_30_1 == 12 then
		local var_30_3 = var_0_7.get(tonumber(arg_30_2[3] or 1))
		local var_30_4 = {}

		var_30_4.name = arg_30_2[1] or ""
		var_30_4.num = arg_30_2[2] or 0

		if var_30_3 then
			var_30_4.boxname = var_30_3.name or ""
		end

		var_30_0 = g.core.lang:getByString(var_30_1.des, var_30_4)
	elseif arg_30_1 == 13 then
		local var_30_5 = var_0_7.get(tonumber(arg_30_2[2]) or 1)
		local var_30_6 = {}

		for iter_30_0, iter_30_1 in ipairs(arg_30_3 or {}) do
			if iter_30_1.type == g.core.common.Goods.TYPE_GOLD then
				iter_30_1.value = iter_30_1.value or 0
			end

			local var_30_7 = g.core.common.Goods:convert(iter_30_1)

			var_30_6[var_30_7.type .. var_30_7.value] = var_30_6[var_30_7.type .. var_30_7.value] or {
				size = 0,
				name = var_30_7.name
			}
			var_30_6[var_30_7.type .. var_30_7.value].size = var_30_6[var_30_7.type .. var_30_7.value].size + var_30_7.size
		end

		local var_30_9 = {}

		for iter_30_2, iter_30_3 in pairs(var_30_6) do
			table.insert(var_30_9, iter_30_3.name .. "x" .. iter_30_3.size)
		end

		local var_30_10 = var_30_1.des
		local var_30_11 = {}

		var_30_11.name = arg_30_2[1] or ""

		if var_30_5 then
			var_30_11.boxname = var_30_5.name or ""
		end

		var_30_11.awards = table.concat(var_30_9, ",")
		var_30_0 = g.core.lang:getByString(var_30_10, var_30_11)
	else
		local var_30_12 = {}
		local var_30_13 = 1

		for iter_30_4 in string.gmatch(string.gsub(var_30_1.des, "%b[]", ""), "#(.-)#") do
			var_30_12[iter_30_4] = arg_30_2[var_30_13] or ""
			var_30_13 = var_30_13 + 1
		end

		var_30_0 = g.core.lang:getByString(var_30_1.des, var_30_12)
	end

	return var_30_0
end

function AllianceData:getAllianceLogList()
	return self._allianceLogList
end

function AllianceData:onS2CApplyList(arg_32_1)
	self._applyList = arg_32_1.apply_guilds or {}
end

function AllianceData:onS2CInviteList(arg_33_1)
	self._invitesMap = {}

	for iter_33_0, iter_33_1 in ipairs(arg_33_1.invite_guilds or {}) do
		self._invitesMap[iter_33_1.guild_id] = iter_33_1
	end
end

function AllianceData:onS2CCreate(arg_34_1)
	self._hasAlliance = true

	self:updateAllianceData(arg_34_1.alliance)
end

function AllianceData:onS2CApply(arg_35_1)
	table.insert(self._guildApplyIdList, arg_35_1.alliance_id)
end

function AllianceData:onS2CCancelApply(arg_36_1)
	for iter_36_0, iter_36_1 in ipairs(self._guildApplyIdList) do
		if iter_36_1 == arg_36_1.alliance_id then
			table.remove(self._guildApplyIdList, iter_36_0)

			break
		end
	end
end

function AllianceData:onS2CApproveApply(arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(self._applyList) do
		if iter_37_1.guild_id == arg_37_1.guild_id then
			table.remove(self._applyList, iter_37_0)

			break
		end
	end

	if arg_37_1.agree then
		self._guildList = arg_37_1.guilds or {}
	end
end

function AllianceData:onS2CInvite(arg_38_1)
	if arg_38_1.invite then
		self._invitesMap[arg_38_1.invite.guild_id] = arg_38_1.invite
	end
end

function AllianceData:onS2CCancelInvite(arg_39_1)
	self._invitesMap[arg_39_1.guild_id] = nil
end

function AllianceData:onS2CApproveInvite(arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(self._guildInviteIdList) do
		if iter_40_1 == arg_40_1.alliance_id then
			table.remove(self._guildInviteIdList, iter_40_0)

			break
		end
	end

	if arg_40_1.agree then
		self._hasAlliance = true
	end
end

function AllianceData:onS2CSuggest(arg_41_1)
	self._guildSuggestDict[arg_41_1.alliance_id] = self._guildSuggestDict[arg_41_1.alliance_id] or {}

	table.insert(self._guildSuggestDict[arg_41_1.alliance_id], g.core.model.User:getId())
end

function AllianceData:onS2CQuit(arg_42_1)
	self._hasAlliance = false

	local var_42_0 = var_0_0:getTime()

	self._quitAllianceUserTime = var_42_0
	self._quitAllianceGuildTime = var_42_0

	self:updateAllianceData({})
end

function AllianceData:onS2CKick(arg_43_1)
	self:tickGuild(arg_43_1.guild_id)
end

function AllianceData:tickGuild(arg_44_1)
	for iter_44_0, iter_44_1 in ipairs(self._guildList) do
		if iter_44_1.guild_id == arg_44_1 then
			table.remove(self._guildList, iter_44_0)

			break
		end
	end

	for iter_44_2, iter_44_3 in ipairs(self._viceLeaderGuildIdList) do
		if iter_44_3 == arg_44_1 then
			table.remove(self._viceLeaderGuildIdList, iter_44_2)

			break
		end
	end
end

function AllianceData:onS2CKickNotice(arg_45_1)
	local var_45_0 = var_0_0:getTime()

	self._quitAllianceUserTime = var_45_0
	self._quitAllianceGuildTime = var_45_0

	self:tickGuild(arg_45_1.guild_id)
end

function AllianceData:onS2CDismiss(arg_46_1)
	self._hasAlliance = false

	local var_46_0 = var_0_0:getTime()

	self._quitAllianceUserTime = var_46_0
	self._quitAllianceGuildTime = var_46_0
end

function AllianceData:onS2CAppoint(arg_47_1)
	if arg_47_1.grade == var_0_9.GRADE.LEADER then
		self._leaderGuildId = arg_47_1.guild_id
	elseif arg_47_1.grade == var_0_9.GRADE.VICE_LEADER then
		table.insert(self._viceLeaderGuildIdList, arg_47_1.guild_id)
	elseif arg_47_1.grade == var_0_9.GRADE.MEMBER then
		for iter_47_0, iter_47_1 in ipairs(self._viceLeaderGuildIdList) do
			if iter_47_1 == arg_47_1.guild_id then
				table.remove(self._viceLeaderGuildIdList, iter_47_0)

				break
			end
		end
	end
end

function AllianceData:updateRedPoint(arg_48_1)
	self._hasAlliance = arg_48_1.has_alliance == true
	self._level = arg_48_1.level or 0
	self._quitAllianceGuildTime = arg_48_1.last_guild_quit_time or 0
	self._serverRedPoint = arg_48_1.is_hint or false
	self._serverHonourRedPoint = arg_48_1.is_honour_hint or false
end

function AllianceData:onS2CImpeach(arg_49_1)
	return
end

function AllianceData:onS2CModifyContent(arg_50_1)
	if arg_50_1.tp == 1 then
		self._name = arg_50_1.content
	elseif arg_50_1.tp == 2 then
		self._declare = arg_50_1.content
	elseif arg_50_1.tp == 3 then
		self._announce = arg_50_1.content
	end
end

function AllianceData:onS2CModifySetting(arg_51_1)
	self._confirm = arg_51_1.confirm
	self._applyLevel = arg_51_1.apply_level or self._applyLevel
end

function AllianceData:onS2CTaskAward(arg_52_1)
	self._taskData:onTaskAward(arg_52_1.id)
end

function AllianceData:onS2CDismissNotice(arg_53_1)
	self._hasAlliance = false

	local var_53_0 = var_0_0:getTime()

	self._quitAllianceUserTime = var_53_0
	self._quitAllianceGuildTime = var_53_0

	self:updateAllianceData({})
end

function AllianceData:onS2CGuildList(arg_54_1)
	self._canInviteGuildList = arg_54_1.guild_ids or {}
end

function AllianceData:onS2CDisplayUserList(arg_55_1)
	self._showUserList = {}

	local var_55_0 = g.core.model.User:getId()

	for iter_55_0, iter_55_1 in ipairs(arg_55_1.user_ids or {}) do
		if iter_55_1 ~= var_55_0 then
			table.insert(self._showUserList, iter_55_1)
		end
	end
end

function AllianceData:onS2CNoticeState(arg_56_1)
	if arg_56_1.state == 0 then
		self._hasAlliance = false

		local var_56_0 = var_0_0:getTime()

		self._quitAllianceUserTime = var_56_0
		self._quitAllianceGuildTime = var_56_0
		self._memberList = nil

		self:updateAllianceData({})
	else
		self._hasAlliance = true
	end
end

function AllianceData:getParams(arg_57_1)
	return var_0_3.get(arg_57_1).parameter
end

function AllianceData:getGuildInviteList()
	return self._guildInviteIdList
end

function AllianceData:myIsApply(arg_59_1)
	for iter_59_0, iter_59_1 in ipairs(self._guildApplyIdList) do
		if iter_59_1 == arg_59_1 then
			return true
		end
	end

	return false
end

function AllianceData:myIsSuggest(arg_60_1)
	local var_60_0 = g.core.model.User:getId()

	for iter_60_0, iter_60_1 in ipairs(self._guildSuggestDict[arg_60_1] or {}) do
		if iter_60_1 == var_60_0 then
			return true
		end
	end

	return false
end

function AllianceData:getGuildSuggestNum(arg_61_1)
	return #(self._guildSuggestDict[arg_61_1] or {})
end

function AllianceData:getGuildApplyList()
	return self._guildApplyIdList
end

function AllianceData:isLeader(arg_63_1)
	arg_63_1 = arg_63_1 or g.core.model.User:getGuildId()

	return self._leaderGuildId == arg_63_1
end

function AllianceData:isViceLeader(arg_64_1)
	arg_64_1 = arg_64_1 or g.core.model.User:getGuildId()

	for iter_64_0, iter_64_1 in ipairs(self._viceLeaderGuildIdList) do
		if iter_64_1 == arg_64_1 then
			return true
		end
	end

	return false
end

function AllianceData:isImpeachEnable()
	if self._leaderOfflineTime ~= 0 then
		return var_0_0:getTime() - self._leaderOfflineTime >= self:getParams(var_0_9.PARAMETER.IMPEACH_TIME) * 86400
	end

	return false
end

function AllianceData:getLeaderGuildId()
	return self._leaderGuildId
end

function AllianceData:getGrade(arg_67_1)
	if self:isLeader(arg_67_1) then
		return var_0_9.GRADE.LEADER
	end

	if self:isViceLeader(arg_67_1) then
		return var_0_9.GRADE.VICE_LEADER
	end

	return var_0_9.GRADE.MEMBER
end

function AllianceData:getGradeNum(arg_68_1)
	if arg_68_1 == var_0_9.GRADE.LEADER then
		return 1
	elseif arg_68_1 == var_0_9.GRADE.VICE_LEADER then
		return #self._viceLeaderGuildIdList
	elseif arg_68_1 == var_0_9.GRADE.MEMBER then
		return #self._guildList - #self._viceLeaderGuildIdList - 1
	end

	return 0
end

function AllianceData:getMyGrade()
	if not g.core.model.User.guildData:isLeader() then
		return var_0_9.GRADE.MEMBER
	end

	local var_69_0 = g.core.model.User.guildData:getGuildId()

	if self:isLeader(var_69_0) then
		return var_0_9.GRADE.LEADER
	end

	if self:isViceLeader(var_69_0) then
		return var_0_9.GRADE.VICE_LEADER
	end

	return var_0_9.GRADE.MEMBER
end

function AllianceData:getGradeByUid(arg_70_1, arg_70_2)
	local var_70_0 = var_0_9.GRADE.MEMBER

	if arg_70_1 then
		local var_70_1 = self:getGrade(arg_70_1.id)

		if var_70_1 ~= var_0_9.GRADE.MEMBER then
			arg_70_2 = arg_70_2 or g.core.model.User:getId()
			var_70_0 = arg_70_2 == arg_70_1.leader_id and var_70_1 or var_0_9.GRADE.MEMBER
		end
	end

	return var_70_0
end

function AllianceData:hasAlliance()
	return self._hasAlliance
end

function AllianceData:getAllianceApplyList()
	return self._applyList
end

function AllianceData:getAllianceInviteByGuildId(arg_73_1)
	return self._invitesMap[arg_73_1]
end

function AllianceData:getAllianceGuilds()
	return self._guildList or {}
end

function AllianceData:getMyAllianceGuild()
	local var_75_0 = g.core.model.User.guildData:getGuildId()

	for iter_75_0, iter_75_1 in ipairs(self:getAllianceGuilds()) do
		if iter_75_1.guild_id == var_75_0 then
			return iter_75_1
		end
	end

	return {}
end

function AllianceData:getAllianceId()
	return self._id
end

function AllianceData:getAllianceName()
	return self._name
end

function AllianceData:getAllianceLevel()
	if not self._hasAlliance then
		return 0
	end

	return self._level
end

function AllianceData:getAllianceFlag()
	return self._flag
end

function AllianceData:getAllianceExp()
	return self._exp
end

function AllianceData:getDailyExp()
	return self._dailyExp
end

function AllianceData:getGuildNum()
	return #self._guildList
end

function AllianceData:getAllianceGuildMaxNum(arg_83_1)
	local var_83_0 = self:getAreaTimeDay()
	local var_83_1 = 0

	for iter_83_0, iter_83_1 in ipairs(self._dilatationLevelList[arg_83_1 or self:getAllianceLevel()] or {}) do
		if var_83_0 < iter_83_1.days then
			break
		end

		var_83_1 = iter_83_1.num_amend
	end

	return var_83_1
end

function AllianceData:getAllianceGuildMaxNumByLv(arg_84_1)
	return self:getAllianceGuildMaxNum(arg_84_1)
end

function AllianceData:getGuildAllianceInfo()
	if self._level > 0 then
		return var_0_4.fetch(self._level) or {}
	end

	return {}
end

function AllianceData:getNextGuildAllianceInfo()
	local var_86_0 = self:getGuildAllianceInfo().next_level

	return var_86_0 > 0 and var_0_4.get(var_86_0) or nil
end

function AllianceData:getAllianceDeclare()
	if self._declare == "" then
		return g.core.lang:get(428518)
	end

	return self._declare
end

function AllianceData:getAllianceAnnounce()
	if self._announce == "" then
		return g.core.lang:get(428522)
	end

	return self._announce
end

function AllianceData:setNoticeSetTime(arg_89_1, arg_89_2)
	self._noticeSetTimeMap[arg_89_1] = arg_89_2
end

function AllianceData:getNoticeSetTime(arg_90_1)
	return self._noticeSetTimeMap[arg_90_1] or 0
end

function AllianceData:getAllianceApplySetting()
	return self._confirm, (self._applyLevel > 0 or nil) and (self._applyLevel or 1)
end

function AllianceData:getCanInviteGuildList()
	return self._canInviteGuildList
end

function AllianceData:isNeedPopJoinAlliance()
	if not self._hasAlliance then
		return false
	end

	if self._popJoinAllianceId == -1 then
		self:loadPopJsonCache()
	end

	return self._popJoinAllianceId ~= self._id
end

function AllianceData:savePopJoinAlliance()
	if self._popJoinAllianceId ~= self._id then
		self._popJoinAllianceId = self._id

		self:savePopJsonCache()
	end
end

function AllianceData:isNeedPopExpandAlliance()
	if not self._hasAlliance then
		return false
	end

	if self._popExpandAllianceDay <= 0 then
		self:loadPopJsonCache()
	end

	local var_95_0 = self:getCurDilatationDay()

	return self._popExpandAllianceDay ~= var_95_0 and var_95_0 > 1
end

function AllianceData:savePopExpandAlliance()
	local var_96_0 = self:getCurDilatationDay()

	if self._popExpandAllianceDay ~= var_96_0 then
		self._popExpandAllianceDay = var_96_0

		self:savePopJsonCache()
	end
end

function AllianceData:isNeedPopLevelUpAlliance()
	if not self._hasAlliance then
		return false
	end

	if self._popLevelUpAlliance == -1 then
		self:loadPopJsonCache()
	end

	if self:getAllianceLevel() > 1 then
		return self._popLevelUpAlliance ~= self:getAllianceLevel()
	end

	return false
end

function AllianceData:savePopLevelUpAlliance()
	local var_98_0 = self:getAllianceLevel()

	if self._popLevelUpAlliance ~= var_98_0 then
		self._popLevelUpAlliance = var_98_0

		self:savePopJsonCache()
	end
end

function AllianceData:loadPopJsonCache()
	local var_99_0 = g.core.common.Storage:load("alliance_need_pop.json") or {}

	self._popJoinAllianceId = var_99_0.popAllianceId or 0
	self._popExpandAllianceDay = var_99_0.popAllianceExpand or 0
	self._popLevelUpAlliance = var_99_0.popAllianceLevel or 0
end

function AllianceData:savePopJsonCache()
	g.core.common.Storage:save("alliance_need_pop.json", {
		popAllianceId = self._popJoinAllianceId,
		popAllianceExpand = self._popExpandAllianceDay,
		popAllianceLevel = self._popLevelUpAlliance
	})
end

function AllianceData:checkNeedGetUserTime()
	local var_101_0 = g.core.common.ServerTime:getTime()

	if var_101_0 - self._lastGetUserTime > var_0_9.GET_USER_TIME then
		self._lastGetUserTime = var_101_0

		return true
	end

	return false
end

function AllianceData:getShowUserList()
	return self._showUserList
end

function AllianceData:getFlagRes(arg_103_1)
	arg_103_1 = arg_103_1 or self._flag

	return var_0_2.get(arg_103_1).res
end

function AllianceData:getFlagColor(arg_104_1)
	arg_104_1 = arg_104_1 or self._flag

	return var_0_2.get(arg_104_1).color
end

function AllianceData:getAreaTimeDay()
	return var_0_0:getDays(self._areaTime, (var_0_0:getTime()))
end

function AllianceData:getCurDilatationDay()
	local var_106_0 = self:getAreaTimeDay()
	local var_106_1 = 0

	for iter_106_0, iter_106_1 in ipairs(self._dilatationLevelList[1]) do
		if var_106_0 < iter_106_1.days then
			break
		end

		var_106_1 = iter_106_1.days
	end

	return var_106_1
end

function AllianceData:getDilatationList()
	return self._dilatationLevelList
end

function AllianceData:isCanRewardTask()
	return self._taskData:isCanRewardTask()
end

function AllianceData:canGetBoxInTime()
	if self._quitAllianceUserTime == 0 then
		return true
	end

	if var_0_0:getTime() - self._joinAllianceTime >= self:getParams(var_0_9.PARAMETER.CHANGE_ALLIANCE_GET_BOX_TIME) then
		return true
	end

	return false
end

function AllianceData:canSendBoxInJoinAllianceTime()
	if self._quitAllianceUserTime == 0 then
		return true
	end

	if var_0_0:getTime() - self._joinAllianceTime < self:getParams(var_0_9.PARAMETER.CHANGE_ALLIANCE_SEND_BOX_TIME) then
		return false
	end

	return true
end

function AllianceData:canSendBoxInDayTime()
	local var_111_0 = var_0_0:getTimeFromZero((var_0_0:getTime()))

	if var_111_0 <= self:getParams(var_0_9.PARAMETER.BOX_SENDS_START_TIME) * 3600 or self:getParams(var_0_9.PARAMETER.BOX_SEND_END_TIME) * 3600 <= var_111_0 then
		return false
	end

	return true
end

function AllianceData:canJoinAlliance()
	return self:geCanJoinAllianceTime() <= 0
end

function AllianceData:geCanJoinAllianceTime()
	local var_113_0 = var_0_0:getTime() - self._quitAllianceGuildTime
	local var_113_1 = self:getParams(var_0_9.PARAMETER.QUIT_ALLIANCE_CD) - var_113_0

	return (g.core.model.User.areaMergeData:getMergeAreaStage() == g.core.const.ConstMgr.AreaMergeConst.STAGE.MERGE or nil) and self:getParams(var_0_9.PARAMETER.MERGE_AREA_QUIT_ALLIANCE_CD) - var_113_0
end

function AllianceData:getGuildServerName(arg_114_1)
	local var_114_0 = ""

	if arg_114_1.server_name and arg_114_1.server_name ~= "" then
		var_114_0 = arg_114_1.server_name
	else
		local var_114_1 = g.core.platform.ServerListProxy:getServerBySid(arg_114_1.sid)

		var_114_0 = var_114_1 and var_114_1.name or ""
	end

	return var_114_0
end

function AllianceData:getAllianceMemberList()
	if not self._hasAlliance then
		self._memberList = nil

		return
	end

	if not self._memberList then
		g.core.network.GameNetProxy:send_C2S_GuildAlliance_UserList({})

		return
	end

	return self._memberList
end

function AllianceData:hasAllianceInviteList(arg_116_1)
	if self._serverRedPoint then
		return true
	end

	return #self._guildInviteIdList > 0
end

function AllianceData:hasRedSendBox(arg_117_1)
	if not self:hasAlliance() then
		return false
	end

	if self._serverRedPoint then
		return true
	end

	return self._boxData:hasRedSendBox(arg_117_1)
end

function AllianceData:hasRedOpenBox(arg_118_1)
	if not self:hasAlliance() then
		return false
	end

	if self._serverRedPoint then
		return true
	end

	return self._boxData:hasRedOpenBox(arg_118_1)
end

function AllianceData:hasRedBoxScoreAward(arg_119_1)
	if not self:hasAlliance() then
		return false
	end

	if self._serverRedPoint then
		return true
	end

	return self._boxData:hasRedBoxScoreAward(arg_119_1)
end

function AllianceData:hasRedGetBox(arg_120_1)
	if not self:hasAlliance() then
		return false
	end

	if self._serverRedPoint then
		return true
	end

	return self._boxData:hasRedGetBox(arg_120_1)
end

function AllianceData:hasGuildApply()
	if self._serverRedPoint then
		return true
	end

	if #self._applyList > 0 then
		return g.core.config.guild_alliance_right_info.get((self:getGradeByUid(g.core.model.User.guildData:getGuildData(), (g.core.model.User:getId())))).audit == 1
	end

	return false
end

function AllianceData:getHonorList()
	return self._honourList
end

function AllianceData:getHonourByIndex(arg_123_1)
	if arg_123_1 < 1 then
		arg_123_1 = 1
	end

	if arg_123_1 > #self._honourList then
		arg_123_1 = #self._honourList
	end

	return self._honourList[arg_123_1]
end

function AllianceData:getHonourInfo(arg_124_1)
	local var_124_0

	for iter_124_0, iter_124_1 in var_0_1.ipairs() do
		if iter_124_1.honour_type == arg_124_1.tp and iter_124_1.honour_value <= arg_124_1.honourData.value and (not var_124_0 or var_124_0.honour_value < iter_124_1.honour_value) then
			var_124_0 = iter_124_1
		end
	end

	return var_124_0
end

function AllianceData:hasRedHonourLike(arg_125_1)
	if not self:hasAlliance() then
		return false
	end

	local var_125_0 = g.core.common.ServerTime:secondsFromToday()

	if var_125_0 < AllianceData:getParams(var_0_9.PARAMETER.HONOUR_START) * 3600 then
		return false
	end

	if var_125_0 >= AllianceData:getParams(var_0_9.PARAMETER.HONOUR_END) * 3600 then
		return false
	end

	if self._serverHonourRedPoint then
		return true
	end

	for iter_125_0, iter_125_1 in ipairs(self._honourList) do
		if iter_125_1.honourData.self_like == 0 then
			return true
		end
	end

	return false
end

function AllianceData:hasRedTaskCanRewardDaily(arg_126_1)
	if not self:hasAlliance() then
		return false
	end

	if self._serverRedPoint then
		return true
	elseif not self._getInfo then
		return false
	end

	return self:getTaskData():isCanRewardDailyTask(arg_126_1)
end

function AllianceData:hasRedTaskCanRewardAchievement(arg_127_1)
	if not self:hasAlliance() then
		return false
	end

	if self._serverRedPoint then
		return true
	elseif not self._getInfo then
		return false
	end

	return self:getTaskData():isCanRewardAchievementTask(arg_127_1)
end

return AllianceData
