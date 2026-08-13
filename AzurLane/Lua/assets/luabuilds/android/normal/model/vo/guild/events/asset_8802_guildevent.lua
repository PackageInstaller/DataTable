class = var_0_10000

local var_0_0 = "GuildEvent"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.active = false
	arg_1_0.startTime = 0
	arg_1_0.clueCount = 0
	arg_1_0.missions = {}
	arg_1_0.boss = nil
	pg = var_2
	arg_1_0.durTime = var_2.guildset.operation_duration_time.key_value

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.guild_operation_template
end

function var_0_1.GetConsume(arg_3_0)
	return arg_3_0:getConfig("consume")
end

function var_0_1.Active(arg_4_0, arg_4_1)
	arg_4_0:Deactivate()

	arg_4_0.startTime = arg_4_1.start_time
	arg_4_0.endTime = arg_4_0.durTime + arg_4_0.startTime
	arg_4_0.clueCount = arg_4_1.clue_count
	arg_4_0.joinCnt = arg_4_1.join_times
	arg_4_0.isParticipant = arg_4_1.is_participant

	local var_4_0 = {}

	ipairs = var_3

	for iter_4_0, iter_4_1 in var_3(arg_4_1.perfs) do
		var_4_0[iter_4_1.event_id] = iter_4_1.index
	end

	local var_4_1 = {}

	ipairs = var_4

	for iter_4_2, iter_4_3 in var_4(arg_4_1.formation_time) do
		var_4_1[iter_4_3.key] = iter_4_3.value
	end

	local var_4_2 = 0

	local function var_4_3(arg_5_0)
		GuildMission = var_2_10001

		local var_5_0 = var_2_10001.New(arg_5_0)

		if var_1.GetPosition(var_5_0) > var_4_2 then
			var_4_2 = var_2
		end

		if not arg_4_0.missions[var_2] then
			arg_4_0.missions[var_2] = {}
		end

		if var_4_0[var_1.id] then
			var_1:UpdateNodeAnimFlagIndex(var_4_0[var_1.id])
		end

		if var_4_1[var_1.id] then
			var_1:UpdateFormationTime(var_4_1[var_1.id])
		end

		table = var_3

		var_3.insert(arg_4_0.missions[var_2], var_1)

		return
	end

	ipairs = var_6

	for iter_4_4, iter_4_5 in var_6(arg_4_1.base_events) do
		var_4_3(iter_4_5)
	end

	ipairs = var_6

	for iter_4_6, iter_4_7 in var_6(arg_4_1.completed_events) do
		local var_4_4 = var_4_3

		GuildMission = var_1_10012

		var_4_4(var_1_10012.CompleteData2FullData(iter_4_7))
	end

	GuildBossMission = var_6
	arg_4_0.boss = var_6.New(var_4_2 + 1, arg_4_1.daily_count, arg_4_1.fleets)

	if arg_4_1.boss_event and arg_4_1.boss_event.boss_id ~= 0 then
		local var_4_5 = arg_4_0.boss

		var_6.Flush(var_4_5, arg_4_1.boss_event)
	end

	arg_4_0.active = true

	return
end

function var_0_1.IsParticipant(arg_6_0)
	return arg_6_0.isParticipant > 0
end

function var_0_1.GetJoinCnt(arg_7_0)
	return arg_7_0.joinCnt
end

function var_0_1.IncreaseJoinCnt(arg_8_0)
	arg_8_0.isParticipant = 1

	if arg_8_0.joinCnt < arg_8_0:GetMaxJoinCnt() then
		arg_8_0.joinCnt = arg_8_0.joinCnt + 1
	else
		getProxy = var_1
		GuildProxy = var_2

		local var_8_0 = var_1(var_2)
		local var_8_1 = var_1.getRawData(var_8_0)

		var_1.ReduceExtraBattleCnt(var_8_1, 1)
	end

	return
end

function var_0_1.GetExtraJoinCnt(arg_9_0)
	getProxy = var_1_10001
	GuildProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)
	local var_9_1 = var_1.getRawData(var_9_0)

	return var_1.GetExtraBattleCnt(var_9_1)
end

function var_0_1.IsLimitedJoin(arg_10_0)
	local var_10_0 = arg_10_0:GetJoinCnt()
	local var_10_1 = arg_10_0:GetMaxJoinCnt()
	local var_10_2 = arg_10_0:GetExtraJoinCnt()

	return not (var_10_0 < var_10_1 or var_10_2 > 0)
end

function var_0_1.GetMaxJoinCnt(arg_11_0)
	pg = var_1_10001

	return var_1_10001.guildset.efficiency_param_times.key_value
end

function var_0_1.GetBossMission(arg_12_0)
	return arg_12_0.boss
end

function var_0_1.GetMissions(arg_13_0)
	return arg_13_0.missions
end

function var_0_1.Deactivate(arg_14_0)
	arg_14_0.startTime = 0
	arg_14_0.clueCount = 0
	arg_14_0.missions = {}
	arg_14_0.boss = nil
	arg_14_0.active = false
	arg_14_0.isParticipant = 0

	return
end

function var_0_1.IsExpired(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_15_0) >= arg_15_0.endTime
end

function var_0_1.IsActive(arg_16_0)
	return arg_16_0.active == true
end

function var_0_1.GetDesc(arg_17_0)
	return arg_17_0:getConfig("profile")
end

function var_0_1.GetName(arg_18_0)
	return arg_18_0:getConfig("name")
end

function var_0_1.GetScaleDesc(arg_19_0)
	return arg_19_0:getConfig("scale")
end

function var_0_1.GetDisplayMission(arg_20_0)
	return arg_20_0:getConfig("event_type_list")
end

function var_0_1.GetDisplayAward(arg_21_0)
	return arg_21_0:getConfig("award_display")
end

function var_0_1.IsUnlock(arg_22_0, arg_22_1)
	return arg_22_1 >= arg_22_0:getConfig("unlock_guild_level")
end

function var_0_1.GetTheme(arg_23_0)
	return arg_23_0:getConfig("theme")
end

function var_0_1.GetJoinShips(arg_24_0)
	local var_24_0 = {}

	ipairs = var_1_10002

	for iter_24_0, iter_24_1 in var_1_10002(arg_24_0.missions) do
		ipairs = var_1_10007

		for iter_24_2, iter_24_3 in var_1_10007(iter_24_1) do
			if not iter_24_3:IsFinish() then
				local var_24_1 = iter_24_3
				local var_24_2 = iter_24_3.GetMyShips(var_24_1)

				ipairs = var_24_1

				for iter_24_4, iter_24_5 in var_24_1(var_24_2) do
					table = var_1_10018

					var_1_10018.insert(var_24_0, iter_24_5)
				end
			end
		end
	end

	return var_24_0
end

function var_0_1.GetMissionById(arg_25_0, arg_25_1)
	pairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0.missions) do
		ipairs = var_1_10007

		for iter_25_2, iter_25_3 in var_1_10007(iter_25_1) do
			if iter_25_3.id == arg_25_1 then
				return iter_25_3
			end
		end
	end

	assert = var_2

	var_2(false)

	return
end

function var_0_1.GetJoinShipCnt(arg_26_0)
	local var_26_0 = 0

	pairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0.missions) do
		ipairs = var_1_10007

		for iter_26_2, iter_26_3 in var_1_10007(iter_26_1) do
			var_26_0 = var_26_0 + iter_26_3:GetJoinCnt()
		end
	end

	return var_26_0
end

function var_0_1.GetBossShipIds(arg_27_0)
	local var_27_0 = {}

	if arg_27_0.boss then
		local var_27_1 = arg_27_0.boss

		if var_2.IsActive(var_27_1) then
			local var_27_2 = arg_27_0.boss
			local var_27_3 = var_2.GetMyShipIds(var_27_2)

			ipairs = var_27_2

			for iter_27_0, iter_27_1 in var_27_2(var_27_3) do
				table = var_1_10008

				var_1_10008.insert(var_27_0, iter_27_1)
			end
		end
	end

	return var_27_0
end

function var_0_1.GetMissionCnt(arg_28_0)
	local var_28_0 = 0

	pairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0.missions) do
		ipairs = var_1_10007

		for iter_28_2, iter_28_3 in var_1_10007(iter_28_1) do
			var_28_0 = var_28_0 + 1
		end
	end

	return var_28_0
end

function var_0_1.GetMainMissionCntAndFinishCnt(arg_29_0)
	local var_29_0 = 0
	local var_29_1 = 0

	pairs = var_1_10003

	for iter_29_0, iter_29_1 in var_1_10003(arg_29_0.missions) do
		ipairs = var_1_10008

		for iter_29_2, iter_29_3 in var_1_10008(iter_29_1) do
			if iter_29_3:IsMain() then
				var_29_0 = var_29_0 + 1
			end

			if iter_29_3:IsMain() and iter_29_3:IsFinish() then
				var_29_1 = var_29_1 + 1
			end
		end
	end

	return var_29_0, var_29_1
end

function var_0_1.GetMissionFinishCnt(arg_30_0)
	local var_30_0 = 0

	pairs = var_1_10002

	for iter_30_0, iter_30_1 in var_1_10002(arg_30_0.missions) do
		ipairs = var_1_10007

		for iter_30_2, iter_30_3 in var_1_10007(iter_30_1) do
			if iter_30_3:IsFinish() then
				var_30_0 = var_30_0 + 1
			end
		end
	end

	return var_30_0
end

function var_0_1.GetCanFormationMisstions(arg_31_0)
	local function var_31_0(arg_32_0)
		if arg_32_0:IsFinish() then
			return false
		end

		local var_32_0 = arg_32_0:GetPosition()

		if arg_31_0.missions[var_32_0 - 1] then
			pairs = var_3

			for iter_32_0, iter_32_1 in var_3(var_2) do
				if iter_32_1:IsMain() and iter_32_1:IsFinish() then
					return true
				end
			end
		else
			return true
		end

		return false
	end

	local var_31_1 = {}

	pairs = var_1_10003

	for iter_31_0, iter_31_1 in var_1_10003(arg_31_0.missions) do
		ipairs = var_1_10008

		for iter_31_2, iter_31_3 in var_1_10008(iter_31_1) do
			if var_31_0(iter_31_3) and iter_31_3:CanFormation() and not iter_31_3:IsFinish() then
				table = var_13

				var_13.insert(var_31_1, iter_31_3)
			end
		end
	end

	return var_31_1
end

function var_0_1.AnyMissionCanFormation(arg_33_0)
	return #arg_33_0:GetCanFormationMisstions() > 0
end

function var_0_1.AnyMissionFirstFleetCanFroamtion(arg_34_0)
	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0.GetCanFormationMisstions(var_34_0)

	_ = var_34_0

	return var_34_0.detect(var_34_1, function(arg_35_0)
		local var_35_0

		if not arg_35_0:FirstFleetCanFormation() and arg_35_0:IsFinish() then
			var_35_0 = not arg_35_0:IsFinishedByServer()
		end

		return var_35_0
	end) ~= nil, var_2
end

function var_0_1.GetUnlockMission(arg_36_0)
	local var_36_0 = 0

	pairs = var_1_10002

	for iter_36_0, iter_36_1 in var_1_10002(arg_36_0.missions) do
		ipairs = var_1_10007

		for iter_36_2, iter_36_3 in var_1_10007(iter_36_1) do
			if iter_36_3:IsMain() and (iter_36_3:IsFinishedByServer() or iter_36_3:IsFinish()) then
				var_36_0 = iter_36_0
			end
		end
	end

	local var_36_1 = arg_36_0.missions[var_36_0 + 1]

	ipairs = var_3

	for iter_36_4, iter_36_5 in var_3(var_36_1 or {}) do
		if iter_36_5:IsMain() then
			return iter_36_5
		end
	end

	return nil
end

function var_0_1.GetLeftTime(arg_37_0)
	pg = var_1_10001

	local var_37_0 = var_1_10001.TimeMgr.GetInstance()
	local var_37_1 = var_1.GetServerTime(var_37_0)

	return arg_37_0.endTime - var_37_1
end

return var_0_1
