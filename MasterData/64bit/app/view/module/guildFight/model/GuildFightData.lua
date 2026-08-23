local GuildFightConst = require("app.view.module.guildFight.const.GuildFightConst")
local var_0_1 = g.core.config.guild_battle_reward_info
local var_0_2 = g.core.config.guild_battle_score_info
local GuildFightData = class("GuildFightData")
local var_0_4 = {
	{
		isAreaFinish = false,
		nameId = 109800,
		id = 1,
		playerList = {}
	},
	{
		isAreaFinish = false,
		nameId = 109801,
		id = 2,
		playerList = {}
	},
	{
		isAreaFinish = false,
		nameId = 109802,
		id = 3,
		playerList = {}
	},
	{
		isAreaFinish = false,
		nameId = 109803,
		id = 4,
		playerList = {}
	},
	{
		isAreaFinish = false,
		nameId = 109804,
		id = 5,
		playerList = {}
	},
	{
		isAreaFinish = false,
		nameId = 109805,
		id = 6,
		playerList = {}
	}
}

local function var_0_5(arg_1_0, arg_1_1)
	if arg_1_0.fightValue ~= arg_1_1.fightValue then
		return arg_1_0.fightValue > arg_1_1.fightValue
	end

	return arg_1_0.index < arg_1_1.index
end

local function var_0_6(arg_2_0, arg_2_1)
	if arg_2_0.fightValue ~= arg_2_1.fightValue then
		return arg_2_0.fightValue < arg_2_1.fightValue
	end

	return arg_2_0.index < arg_2_1.index
end

function GuildFightData:ctor()
	self:initData()
end

function GuildFightData:initData()
	self._selfIds = {}
	self._leftTimes = 0
	self._lastArawdTime = 0
	self._joinGuildTime = 0
	self._guildScore = 0
	self._guildIds = {}
	self._guildTimes = {}
	self._playerList = {}
	self._robotList = {}
	self._chariotList = {}
	self._lastLog = {}
	self._realGuild = {}
	self._chariotResult = {}
	self._battleReport = {}
	self._battleVideo = {}
	self._oriChariotData = {}
	self._battleContent = nil
	self._chariotFightFinishServiceInfo = {}
	self._chariotResultListData = {}
	self._rankAwardInfo = {}
	self._rankList = {}
	self._selfRank = 0
	self._isCrossDayMatching = false

	self:_initRankAward()
end

function GuildFightData:isNormal()
	local var_5_0 = g.core.common.ServerTime:getWeekDay()

	for iter_5_0, iter_5_1 in ipairs(GuildFightConst.CHARIOT) do
		if iter_5_1 == var_5_0 then
			return false, 2
		end
	end

	return true, 1
end

function GuildFightData:resGuildFightInfo(arg_6_1)
	if not arg_6_1 then
		return
	end

	self:_cleanList()
	self:_updateSelfInfo(arg_6_1)
	self:_updateGuildInfo(arg_6_1)

	if arg_6_1.is_match then
		self:_updateUserList(arg_6_1)
		self:_sortList()
	end

	self:_updateRealGuild()
end

function GuildFightData:_cleanList()
	self._playerList = {}
	self._robotList = {}
	self._chariotList = {}
end

function GuildFightData:_updateSelfInfo(arg_8_1)
	if not arg_8_1.self then
		return
	end

	self._selfIds = arg_8_1.self.ids or {}
	self._leftTimes = arg_8_1.self.fight_times or 0
	self._lastArawdTime = arg_8_1.self.last_award_time or 0
	self._joinGuildTime = arg_8_1.self.join_guild_time or 0
	self._selfScore = arg_8_1.self.score or 0
end

function GuildFightData:_updateGuildInfo(arg_9_1)
	if not arg_9_1.guild_info then
		return
	end

	self._guildScore = arg_9_1.guild_info.score or 0
	self._guildIds = arg_9_1.guild_info.ids or {}
	self._guildTimes = arg_9_1.guild_info.times or {}

	table.sort(self._guildIds, function(arg_10_0, arg_10_1)
		return arg_10_0 < arg_10_1
	end)
	table.sort(self._guildTimes, function(arg_11_0, arg_11_1)
		return arg_11_0 < arg_11_1
	end)
end

function GuildFightData:_updateUserList(arg_12_1)
	if not arg_12_1.users then
		return
	end

	self._isCrossDayMatching = false

	local var_12_0 = arg_12_1.users or {}

	if self:isNormal() then
		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			local var_12_1 = self:_createPlayerUnit(iter_12_1)

			if var_12_1.isRobot then
				table.insert(self._robotList, var_12_1)
			else
				table.insert(self._playerList, var_12_1)
			end
		end
	else
		for iter_12_2, iter_12_3 in pairs((self:_createChariots(var_12_0))) do
			self._chariotList[iter_12_2] = iter_12_3
		end
	end
end

function GuildFightData:_createChariots(arg_13_1)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		var_13_0[iter_13_1.chariot_id] = var_13_0[iter_13_1.chariot_id] or {}

		table.insert(var_13_0[iter_13_1.chariot_id], (self:_createChariotPlayerUnit(iter_13_1)))
	end

	for iter_13_2, iter_13_3 in pairs(var_13_0) do
		table.sort(iter_13_3, var_0_6)
	end

	return var_13_0
end

function GuildFightData:_sortList()
	if self:isNormal() then
		table.sort(self._playerList, var_0_5)
		table.sort(self._robotList, var_0_5)

		for iter_14_0, iter_14_1 in ipairs(self._robotList) do
			table.insert(self._playerList, iter_14_1)
		end
	end
end

function GuildFightData:_createPlayerUnit(arg_15_1)
	if not arg_15_1 then
		return
	end

	local var_15_0 = {
		left = arg_15_1.left,
		isLive = arg_15_1.left > 0,
		index = arg_15_1.index
	}

	if not arg_15_1.show then
		var_15_0.isRobot = true
		var_15_0.user = self:_createRobot(10002)
	else
		var_15_0.isRobot = not (not arg_15_1.show.robot_type or arg_15_1.show.robot_type == 0)
		var_15_0.user = var_15_0.isRobot and self:_createRobot(arg_15_1.show.id) or arg_15_1.show
	end

	if var_15_0.user.base_id == 0 then
		var_15_0.user.base_id = 210000
	end

	var_15_0.fightValue = var_15_0.user.fight_value
	var_15_0.unites = arg_15_1.unites or {
		0,
		0,
		0,
		0
	}

	return var_15_0
end

function GuildFightData:_createChariotPlayerUnit(arg_16_1)
	if not arg_16_1 then
		return
	end

	local var_16_0 = {
		left = arg_16_1.left,
		isLive = arg_16_1.left ~= 0,
		index = arg_16_1.index
	}

	if not arg_16_1.show then
		var_16_0.isRobot = true
		var_16_0.user = self:_createRobot(10002)
	else
		var_16_0.isRobot = not (not arg_16_1.show.robot_type or arg_16_1.show.robot_type == 0)
		var_16_0.user = var_16_0.isRobot and self:_createRobot(arg_16_1.show.id) or arg_16_1.show
	end

	if var_16_0.user.base_id == 0 then
		var_16_0.user.base_id = 210000
	end

	var_16_0.fightValue = var_16_0.user.fight_value
	var_16_0.chariotId = arg_16_1.chariot_id
	var_16_0.unites = arg_16_1.unites or {
		0,
		0,
		0,
		0
	}

	return var_16_0
end

function GuildFightData:_createRobot(arg_17_1)
	local var_17_0 = g.core.config.robot_info.get(arg_17_1):toObject()

	var_17_0.fight_value = var_17_0.fight_power
	var_17_0.base_id = var_17_0.res_id

	local var_17_1 = g.core.config.monster_team_info.get(var_17_0.monster_team_id, 1)

	var_17_0.knights = {}

	for iter_17_0 = 1, 6 do
		if var_17_1["monster_" .. iter_17_0] then
			var_17_0.knights[iter_17_0] = g.core.config.monster_info.get(var_17_1["monster_" .. iter_17_0]).res_id
		end
	end

	return var_17_0
end

function GuildFightData:resNoticeNewUsers(arg_18_1)
	if not arg_18_1 then
		return
	end

	if self:isNormal() then
		self._playerList = {}
		self._robotList = {}
	end

	self:_updateUserList(arg_18_1)
	self:_sortList()
end

function GuildFightData:resNoticeUser(arg_19_1)
	if not arg_19_1 then
		return
	end

	local var_19_0 = arg_19_1.users

	if self:isNormal() then
		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			self:_updatePlayerList(iter_19_1)
		end
	else
		for iter_19_2, iter_19_3 in ipairs(var_19_0) do
			self:_updateChariotList(iter_19_3)
		end
	end
end

function GuildFightData:_updatePlayerList(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(self._playerList) do
		if iter_20_1.index == arg_20_1.index then
			self._playerList[iter_20_0] = self:_createPlayerUnit(arg_20_1)

			break
		end
	end
end

function GuildFightData:_updateChariotList(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(self._chariotList) do
		for iter_21_2 = 1, #iter_21_1 do
			if iter_21_1[iter_21_2].index == arg_21_1.index then
				iter_21_1[iter_21_2] = self:_createChariotPlayerUnit(arg_21_1)

				break
			end
		end
	end
end

function GuildFightData:isDestory(arg_22_1)
	local var_22_0 = true

	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		if iter_22_1.isLive then
			var_22_0 = false

			break
		end
	end

	return var_22_0
end

function GuildFightData:getPlayerIdByData(arg_23_1)
	if self:isNormal() then
		for iter_23_0, iter_23_1 in ipairs(self._playerList) do
			if arg_23_1.index == iter_23_1.index then
				return iter_23_0
			end
		end
	end

	return 1
end

function GuildFightData:isRobotById(arg_24_1)
	local var_24_0 = self:getTargetById(arg_24_1)

	if var_24_0.isRobot ~= nil then
		return var_24_0.isRobot
	elseif var_24_0[1] and var_24_0[1].isRobot ~= nil then
		return var_24_0[1].isRobot
	end

	return false
end

function GuildFightData:getScoreInfoById(arg_25_1)
	if not self:getTargetById(arg_25_1) then
		return nil
	end

	if self:isRobotById(arg_25_1) then
		arg_25_1 = 999
	end

	for iter_25_0, iter_25_1 in ipairs((var_0_2.match(function(arg_26_0)
		return self:calInfoType(arg_26_0.score_type)
	end))) do
		if arg_25_1 <= iter_25_1.score_value then
			return iter_25_1
		end
	end

	return nil
end

function GuildFightData:getIndexByFightValue(arg_27_1)
	local var_27_0 = {}

	if not self._playerList[1] then
		return 1
	end

	local var_27_1 = math.abs(self._playerList[1].fightValue - arg_27_1)

	for iter_27_0, iter_27_1 in ipairs(self._playerList) do
		local var_27_2 = math.abs(iter_27_1.fightValue - arg_27_1)

		var_27_0[iter_27_0] = var_27_2

		if iter_27_0 > 1 then
			var_27_1 = math.min(var_27_1, var_27_2)
		end
	end

	for iter_27_2, iter_27_3 in ipairs(var_27_0) do
		if iter_27_3 == var_27_1 then
			return iter_27_2
		end
	end

	return 1
end

function GuildFightData:getChariotIdByFightValue(arg_28_1)
	local var_28_0 = {}

	if not self._chariotList[1] or #self._chariotList[1] ~= GuildFightConst.CHARIOTNUM then
		return 1
	end

	local var_28_1 = math.abs((self._chariotList[1][1].fightValue + self._chariotList[1][2].fightValue + self._chariotList[1][3].fightValue) / 3 - arg_28_1)

	for iter_28_0, iter_28_1 in ipairs(self._chariotList) do
		if #iter_28_1 ~= GuildFightConst.CHARIOTNUM then
			return 1
		end

		local var_28_2 = math.abs((iter_28_1[1].fightValue + iter_28_1[2].fightValue + iter_28_1[3].fightValue) / 3 - arg_28_1)

		var_28_0[iter_28_0] = var_28_2

		if iter_28_0 > 1 then
			var_28_1 = math.min(var_28_1, var_28_2)
		end
	end

	for iter_28_2, iter_28_3 in ipairs(var_28_0) do
		if iter_28_3 == var_28_1 then
			return iter_28_2
		end
	end

	return 0
end

function GuildFightData:getChariotPosByIndex(arg_29_1, arg_29_2)
	if not self._oriChariotData then
		return 1
	end

	for iter_29_0, iter_29_1 in ipairs(self._oriChariotData) do
		if iter_29_1.index == arg_29_2 then
			return iter_29_0
		end
	end

	return 1
end

function GuildFightData:calInfoType(arg_30_1)
	if self:isNormal() then
		return arg_30_1 == GuildFightConst.TARGET_TYPE.NOR_PLAYER or arg_30_1 == GuildFightConst.TARGET_TYPE.NOR_ROBOT
	else
		return arg_30_1 == GuildFightConst.TARGET_TYPE.CHARIOT_PLAYER or arg_30_1 == GuildFightConst.TARGET_TYPE.CHARIOT_ROBOT
	end
end

function GuildFightData:_calRobotInfoType(arg_31_1)
	if self:isNormal() then
		return arg_31_1 == GuildFightConst.TARGET_TYPE.NOR_ROBOT
	else
		return arg_31_1 == GuildFightConst.TARGET_TYPE.CHARIOT_ROBOT
	end
end

function GuildFightData:_calPlayerInfoType(arg_32_1)
	if self:isNormal() then
		return arg_32_1 == GuildFightConst.TARGET_TYPE.NOR_PLAYER
	else
		return arg_32_1 == GuildFightConst.TARGET_TYPE.CHARIOT_PLAYER
	end
end

function GuildFightData:canFight()
	return self._leftTimes > 0
end

function GuildFightData:resUpdateScore(arg_34_1)
	if not arg_34_1 then
		return
	end

	self._guildScore = arg_34_1.score

	for iter_34_0, iter_34_1 in ipairs(arg_34_1.ids or {}) do
		table.insert(self._guildIds, iter_34_1)
	end

	if #self._guildIds > #self._guildTimes then
		for iter_34_2 = 1, #self._guildIds - #self._guildTimes do
			self._guildTimes[#self._guildTimes + 1] = g.core.common.ServerTime:getTime()
		end

		self:_updateRealGuild()
	end
end

function GuildFightData:getBoxNum()
	return #self:getAwardInfo()
end

function GuildFightData:getAwardInfo()
	local var_36_0, var_36_1 = self:isNormal()
	local var_36_2 = {}

	for iter_36_0, iter_36_1 in var_0_1.ipairs() do
		if iter_36_1.battle_type == var_36_1 then
			table.insert(var_36_2, iter_36_1:toObject())
		end
	end

	table.sort(var_36_2, function(arg_37_0, arg_37_1)
		if arg_37_0.target_score ~= arg_37_1.target_score then
			return arg_37_0.target_score < arg_37_1.target_score
		end

		return false
	end)

	return var_36_2
end

function GuildFightData:getTargetMaxScoreByType(arg_38_1)
	local var_38_0 = 0

	if arg_38_1 then
		for iter_38_0 = 1, var_0_1.getLength() do
			local var_38_1 = var_0_1.indexOf(iter_38_0)

			if var_38_1.battle_type == arg_38_1 and var_38_0 < var_38_1.target_score then
				var_38_0 = var_38_1.target_score
			end
		end
	end

	return var_38_0
end

function GuildFightData:getAwards(arg_39_1)
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(self:getAwardInfo()) do
		if arg_39_1 == iter_39_0 then
			var_39_0 = self:_createAwardsUnit(iter_39_1)

			break
		end
	end

	return var_39_0
end

function GuildFightData:_createAwardsUnit(arg_40_1)
	local var_40_0 = {}

	for iter_40_0 = 1, GuildFightConst.AWARDMAX do
		if arg_40_1["reward_type_" .. iter_40_0] and arg_40_1["reward_type_" .. iter_40_0] > 0 then
			table.insert(var_40_0, {
				type = arg_40_1["reward_type_" .. iter_40_0],
				value = arg_40_1["reward_value_" .. iter_40_0],
				size = arg_40_1["reward_size_" .. iter_40_0]
			})
		end
	end

	return var_40_0
end

function GuildFightData:_updateRealGuild()
	self._realGuild = {}

	for iter_41_0 = 1, self:getBoxNum() do
		local var_41_0 = {
			isAward = self:isAward(iter_41_0)
		}

		if not self._guildTimes[iter_41_0] then
			var_41_0.timeJ = true
			var_41_0.scoreJ = false
		else
			var_41_0.timeJ = self._guildTimes[iter_41_0] > self._joinGuildTime
			var_41_0.scoreJ = true
		end

		table.insert(self._realGuild, var_41_0)
	end
end

function GuildFightData:getBoxState(arg_42_1)
	if not self._realGuild[arg_42_1] then
		return
	end

	local var_42_0 = 0
	local var_42_1

	if self._realGuild[arg_42_1].scoreJ then
		var_42_0 = 2

		if not self._realGuild[arg_42_1].isAward and self._realGuild[arg_42_1].timeJ then
			var_42_0 = 1
		end

		if not self._realGuild[arg_42_1].timeJ then
			var_42_1 = 0
		end
	end

	return var_42_0, var_42_1
end

function GuildFightData:hasAward()
	for iter_43_0 = 1, GuildFightConst.AWARDMAX do
		if self:getBoxState(iter_43_0) == 1 then
			return true
		end
	end

	return false
end

function GuildFightData:isAward(arg_44_1)
	for iter_44_0, iter_44_1 in ipairs(self._selfIds) do
		if iter_44_1 == self._guildIds[arg_44_1] then
			return true
		end
	end

	return false
end

function GuildFightData:resAwardsInfo(arg_45_1)
	if arg_45_1 and arg_45_1.id then
		table.insert(self._selfIds, arg_45_1.id)
		self:_updateRealGuild()
	end
end

function GuildFightData:resHistoryInfo(arg_46_1)
	if not arg_46_1 then
		return
	end

	local var_46_0 = arg_46_1.records or {}

	self._lastLog = {}

	for iter_46_0 = #var_46_0, 1, -1 do
		local var_46_1 = var_46_0[iter_46_0]

		if var_46_0[iter_46_0].dfd_id > 0 then
			local var_46_2 = var_0_2.get(var_46_1.dfd_id)
			local var_46_3

			if var_46_2.score_type == 1 or var_46_2.score_type == 3 then
				var_46_3 = g.core.config.guild_news_info.get(GuildFightConst.RECORD1)
			elseif var_46_2.score_type == 2 or var_46_2.score_type == 4 then
				var_46_3 = g.core.config.guild_news_info.get(GuildFightConst.RECORD2)
			end

			if var_46_3 and var_46_3.type == 4 then
				table.insert(self._lastLog, {
					text = string.gsub(string.gsub(string.gsub(var_46_3.news, "#name1#", var_46_1.atk_name), "#name2#", var_46_2.name), "#score#", var_46_1.score),
					id = var_46_1.index
				})
			end
		end
	end
end

function GuildFightData:_initRankAward()
	for iter_47_0, iter_47_1 in ipairs((g.core.config.rank_award_info.match("rank_type", GuildFightConst.RANKTYPE))) do
		self._rankAwardInfo[#self._rankAwardInfo + 1] = iter_47_1
	end
end

function GuildFightData:getRankAward(arg_48_1)
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in ipairs(self._rankAwardInfo) do
		if arg_48_1 >= iter_48_1.min_rank and arg_48_1 <= iter_48_1.max_rank then
			var_48_0 = iter_48_1

			break
		end
	end

	local var_48_2 = {}

	for iter_48_2 = 1, 4 do
		if var_48_0["reward_type" .. iter_48_2] and var_48_0["reward_type" .. iter_48_2] > 0 then
			table.insert(var_48_2, {
				type = var_48_0["reward_type" .. iter_48_2],
				value = var_48_0["reward_value" .. iter_48_2],
				size = var_48_0["reward_size" .. iter_48_2]
			})
		end
	end

	return var_48_2
end

function GuildFightData:getRankAwardData(arg_49_1)
	for iter_49_0, iter_49_1 in ipairs(self._rankAwardInfo) do
		if arg_49_1 == iter_49_0 then
			return iter_49_1
		end
	end

	return {}
end

function GuildFightData:resRankList(arg_50_1)
	if not arg_50_1 then
		return
	end

	self._selfRank = arg_50_1.self_rank or 0
	self._rankList = arg_50_1.rank_units or {}
end

function GuildFightData:recordOriData(arg_51_1)
	self._oriChariotData = clone(self:getChariot(arg_51_1))
end

function GuildFightData:resBattleReport(arg_52_1)
	self._battleContent = arg_52_1

	if not arg_52_1 then
		return
	end

	self._battleReport = {}

	for iter_52_0, iter_52_1 in ipairs(arg_52_1.battle_id or {}) do
		self._battleReport[#self._battleReport + 1] = g.core.battle.BattleProxy:getGuildFightReport(iter_52_1)
	end
end

function GuildFightData:resBattleResult(arg_53_1)
	if not arg_53_1 then
		return
	end

	self._chariotResult = arg_53_1.results or {}

	local var_53_0 = arg_53_1.score or 0

	self._selfScore = self._selfScore + var_53_0

	if self:isNormal() then
		if var_53_0 ~= 0 then
			self._leftTimes = math.max(self._leftTimes - 1, 0)
		end
	else
		self._leftTimes = math.max(self._leftTimes - 1, 0)
	end
end

function GuildFightData:calAndGetBattleResult(arg_54_1, arg_54_2)
	if not arg_54_1 then
		return
	end

	local var_54_0 = {}
	local var_54_2 = {}
	local var_54_3 = self:getResultData()
	local var_54_4 = self:getChariotPosByIndex(arg_54_2, var_54_3[1].index)

	for iter_54_0 = 1, var_54_4 - 1 do
		local var_54_5 = {
			index = arg_54_1[iter_54_0].index
		}

		var_54_5.dfd_hp_left = 0
		var_54_5.is_win = false
		var_54_0[iter_54_0] = var_54_5
	end

	local var_54_6 = 1

	for iter_54_1 = var_54_4, #arg_54_1 do
		if var_54_3[var_54_6] then
			var_54_0[iter_54_1] = var_54_3[var_54_6]
			var_54_2[var_54_6] = var_54_3[var_54_6]
		else
			local var_54_7 = {
				index = arg_54_1[iter_54_1].index
			}

			var_54_7.dfd_hp_left = 100
			var_54_7.is_win = false
			var_54_0[iter_54_1] = var_54_7
			var_54_2[var_54_6] = var_54_7
		end

		var_54_6 = var_54_6 + 1
	end

	self._chariotResultListData = var_54_0

	return var_54_0, var_54_3, var_54_2
end

function GuildFightData:clearBattleVideo()
	self._battleVideo = {}
end

function GuildFightData:insertBattleVideo(arg_56_1)
	table.insert(self._battleVideo, arg_56_1)
end

function GuildFightData:getBattleVideoByBattleId(arg_57_1)
	for iter_57_0, iter_57_1 in ipairs(self._battleVideo) do
		if iter_57_1.battle_id == arg_57_1 then
			return iter_57_1
		end
	end

	return nil
end

function GuildFightData:getAwardIds()
	return self._selfIds
end

function GuildFightData:getLeftTimes()
	return self._leftTimes
end

function GuildFightData:getGuildScore()
	return self._guildScore
end

function GuildFightData:getPlayerList()
	return self._playerList
end

function GuildFightData:getChariotList()
	return self._chariotList
end

function GuildFightData:getTargetById(arg_63_1)
	return self:getList()[arg_63_1]
end

function GuildFightData:getChariot(arg_64_1)
	return self._chariotList[arg_64_1]
end

function GuildFightData:getPlayer(arg_65_1)
	return self._playerList[arg_65_1]
end

function GuildFightData:getResultData()
	return self._chariotResult
end

function GuildFightData:getOriChariot()
	return self._oriChariotData
end

function GuildFightData:getBattleReport()
	return self._battleReport
end

function GuildFightData:getSelfRank()
	return self._selfRank
end

function GuildFightData:getRankList()
	return self._rankList
end

function GuildFightData:getRankAwardInfo()
	return self._rankAwardInfo
end

function GuildFightData:getLogData()
	return self._lastLog
end

function GuildFightData:getSelfScore()
	return self._selfScore
end

function GuildFightData:getGuildIds()
	return self._guildIds
end

function GuildFightData:getBattleContent()
	return self._battleContent
end

function GuildFightData:getChariotFightFinishServiceInfo()
	return self._chariotFightFinishServiceInfo
end

function GuildFightData:getChariotFightResultListData()
	return self._chariotResultListData
end

function GuildFightData:getList()
	if self:isNormal() then
		return self._playerList
	else
		return self._chariotList
	end
end

function GuildFightData:updateNormalAreaData()
	for iter_79_0, iter_79_1 in ipairs(var_0_4) do
		local var_79_0 = math.floor(#self._playerList / GuildFightConst.NORMAL_AREA_NUM)
		local var_79_1 = iter_79_1.id * var_79_0

		if iter_79_1.id == GuildFightConst.NORMAL_AREA_NUM then
			var_79_1 = var_79_1 + math.fmod(#self._playerList, GuildFightConst.NORMAL_AREA_NUM)
		end

		local var_79_2 = {}
		local var_79_3 = true

		for iter_79_2 = (iter_79_1.id - 1) * var_79_0 + 1, var_79_1 do
			if self._playerList[iter_79_2] then
				if self._playerList[iter_79_2].left > 0 then
					var_79_3 = false
				end

				table.insert(var_79_2, self._playerList[iter_79_2])
			end
		end

		var_0_4[iter_79_1.id].isAreaFinish = var_79_3
		var_0_4[iter_79_1.id].playerList = var_79_2
	end
end

function GuildFightData:getAllNormalAreaData(arg_80_1)
	self:updateNormalAreaData()

	if arg_80_1 then
		return clone(var_0_4[arg_80_1])
	else
		return clone(var_0_4)
	end
end

function GuildFightData:getSimilarFightValuePlayerIndexByData(arg_81_1)
	local var_81_0 = clone(arg_81_1)

	for iter_81_0, iter_81_1 in ipairs(var_81_0) do
		iter_81_1.sortIndex = iter_81_0
	end

	for iter_81_2 = #var_81_0, -1 do
		if var_81_0[iter_81_2].left <= 0 then
			table.remove(var_81_0, iter_81_2)
		end
	end

	table.insert(var_81_0, {
		sortIndex = 0,
		isSelf = true,
		fightValue = g.core.model.User:getFightValue()
	})
	table.sort(var_81_0, function(arg_82_0, arg_82_1)
		if arg_82_0.fightValue ~= arg_82_1.fightValue then
			return arg_82_0.fightValue > arg_82_1.fightValue
		else
			return arg_82_0.sortIndex > arg_82_1.sortIndex
		end
	end)

	local var_81_1 = 1

	for iter_81_3, iter_81_4 in ipairs(var_81_0) do
		if iter_81_4.isSelf then
			var_81_1 = iter_81_3

			break
		end
	end

	if var_81_0[var_81_1 + 1] then
		return var_81_0[var_81_1 + 1].sortIndex
	elseif var_81_0[var_81_1 - 1] then
		return var_81_0[var_81_1 - 1].sortIndex
	else
		return 1
	end
end

function GuildFightData:isChariotFinishByData(arg_83_1)
	local var_83_0 = true

	if not next(arg_83_1) then
		return
	end

	for iter_83_0, iter_83_1 in ipairs(arg_83_1) do
		if iter_83_1.left > 0 then
			var_83_0 = false

			break
		end
	end

	return var_83_0
end

function GuildFightData:setChariotFightFinishServiceInfo(arg_84_1)
	self._chariotFightFinishServiceInfo = clone(arg_84_1)
end

function GuildFightData:getGuildFightCanGetAwardId()
	local var_85_0 = {}

	for iter_85_0 = 1, self:getBoxNum() do
		local var_85_1, var_85_2 = self:getBoxState(iter_85_0)

		if ((var_85_2 or nil) and var_85_2) == 1 then
			table.insert(var_85_0, iter_85_0)
		end
	end

	return var_85_0
end

function GuildFightData:isHasGuildFightCanGetAward()
	return #self:getGuildFightCanGetAwardId() > 0
end

function GuildFightData:updateGuildFightRedData(arg_87_1)
	arg_87_1 = arg_87_1 or {}
	self._guildIds = arg_87_1.ids or {}
	self._selfIds = arg_87_1.guild_battle_ids or {}
	self._guildTimes = arg_87_1.times or {}
	self._joinGuildTime = arg_87_1.join_guild_time or 0

	self:_updateRealGuild()
end

function GuildFightData:setMatchState(arg_88_1)
	self._isCrossDayMatching = arg_88_1
end

function GuildFightData:getMatchState()
	return self._isCrossDayMatching
end

function GuildFightData:isInOpenTime()
	if g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.GUILD_FIGHT_CHANGE_TIME).parameter > g.core.common.ServerTime:getTime() then
		return true
	end

	local var_90_0 = g.core.common.ServerTime:getWeekDayByTimeTamp((g.core.common.ServerTime:getTime()))

	if var_90_0 == 0 then
		var_90_0 = 7
	end

	return var_90_0 == 2 or var_90_0 == 4 or var_90_0 == 6
end

function GuildFightData:hasRedInChallengeCount()
	if not self:isInOpenTime() then
		return false
	end

	return self:canFight()
end

function GuildFightData:getCurStateTargetScore()
	local var_92_0 = self:getGuildScore()

	for iter_92_0, iter_92_1 in ipairs((self:getAwardInfo())) do
		if var_92_0 <= iter_92_1.target_score then
			return iter_92_1.target_score
		end
	end
end

return GuildFightData
