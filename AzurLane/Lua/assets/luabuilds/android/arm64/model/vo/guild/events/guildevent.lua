local var_0_0 = class("GuildEvent", import("...BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.active = false
	arg_1_0.startTime = 0
	arg_1_0.clueCount = 0
	arg_1_0.missions = {}
	arg_1_0.boss = nil
	arg_1_0.durTime = pg.guildset.operation_duration_time.key_value

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.guild_operation_template
end

function var_0_0.GetConsume(arg_3_0)
	return arg_3_0:getConfig("consume")
end

function var_0_0.Active(arg_4_0, arg_4_1)
	arg_4_0:Deactivate()

	arg_4_0.startTime = arg_4_1.start_time
	arg_4_0.endTime = arg_4_0.durTime + arg_4_0.startTime
	arg_4_0.clueCount = arg_4_1.clue_count
	arg_4_0.joinCnt = arg_4_1.join_times
	arg_4_0.isParticipant = arg_4_1.is_participant

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.perfs) do
		({})[iter_4_1.event_id] = iter_4_1.index
	end

	local var_4_1 = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.formation_time) do
		({})[iter_4_3.key] = iter_4_3.value
	end

	local var_4_2 = 0

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.base_events) do
		(function(arg_5_0)
			local var_5_0 = GuildMission.New(arg_5_0)
			local var_5_1 = var_5_0:GetPosition()

			if var_5_1 > var_4_2 then
				var_4_2 = var_5_1
			end

			arg_4_0.missions[var_5_1] = arg_4_0.missions[var_5_1] or {}

			if var_4_0[var_5_0.id] then
				var_5_0:UpdateNodeAnimFlagIndex(var_4_0[var_5_0.id])
			end

			if var_4_1[var_5_0.id] then
				var_5_0:UpdateFormationTime(var_4_1[var_5_0.id])
			end

			table.insert(arg_4_0.missions[var_5_1], var_5_0)

			return
		end)(iter_4_5)
	end

	for iter_4_6, iter_4_7 in ipairs(arg_4_1.completed_events) do
		(function(arg_5_0)
			local var_5_0 = GuildMission.New(arg_5_0)
			local var_5_1 = var_5_0:GetPosition()

			if var_5_1 > var_4_2 then
				var_4_2 = var_5_1
			end

			arg_4_0.missions[var_5_1] = arg_4_0.missions[var_5_1] or {}

			if var_4_0[var_5_0.id] then
				var_5_0:UpdateNodeAnimFlagIndex(var_4_0[var_5_0.id])
			end

			if var_4_1[var_5_0.id] then
				var_5_0:UpdateFormationTime(var_4_1[var_5_0.id])
			end

			table.insert(arg_4_0.missions[var_5_1], var_5_0)

			return
		end)(GuildMission.CompleteData2FullData(iter_4_7))
	end

	arg_4_0.boss = GuildBossMission.New(0 + 1, arg_4_1.daily_count, arg_4_1.fleets)

	if arg_4_1.boss_event and arg_4_1.boss_event.boss_id ~= 0 then
		arg_4_0.boss:Flush(arg_4_1.boss_event)
	end

	arg_4_0.active = true

	return
end

function var_0_0.IsParticipant(arg_6_0)
	return arg_6_0.isParticipant > 0
end

function var_0_0.GetJoinCnt(arg_7_0)
	return arg_7_0.joinCnt
end

function var_0_0.IncreaseJoinCnt(arg_8_0)
	arg_8_0.isParticipant = 1

	if arg_8_0.joinCnt < arg_8_0:GetMaxJoinCnt() then
		arg_8_0.joinCnt = arg_8_0.joinCnt + 1
	else
		getProxy(GuildProxy):getRawData():ReduceExtraBattleCnt(1)
	end

	return
end

function var_0_0.GetExtraJoinCnt(arg_9_0)
	return getProxy(GuildProxy):getRawData():GetExtraBattleCnt()
end

function var_0_0.IsLimitedJoin(arg_10_0)
	local var_10_0 = arg_10_0:GetExtraJoinCnt()

	return not (arg_10_0:GetJoinCnt() < arg_10_0:GetMaxJoinCnt() or var_10_0 > 0)
end

function var_0_0.GetMaxJoinCnt(arg_11_0)
	return pg.guildset.efficiency_param_times.key_value
end

function var_0_0.GetBossMission(arg_12_0)
	return arg_12_0.boss
end

function var_0_0.GetMissions(arg_13_0)
	return arg_13_0.missions
end

function var_0_0.Deactivate(arg_14_0)
	arg_14_0.startTime = 0
	arg_14_0.clueCount = 0
	arg_14_0.missions = {}
	arg_14_0.boss = nil
	arg_14_0.active = false
	arg_14_0.isParticipant = 0

	return
end

function var_0_0.IsExpired(arg_15_0)
	local var_15_0 = pg.TimeMgr.GetInstance()

	return var_15_0:GetServerTime() >= arg_15_0.endTime
end

function var_0_0.IsActive(arg_16_0)
	return arg_16_0.active == true
end

function var_0_0.GetDesc(arg_17_0)
	return arg_17_0:getConfig("profile")
end

function var_0_0.GetName(arg_18_0)
	return arg_18_0:getConfig("name")
end

function var_0_0.GetScaleDesc(arg_19_0)
	return arg_19_0:getConfig("scale")
end

function var_0_0.GetDisplayMission(arg_20_0)
	return arg_20_0:getConfig("event_type_list")
end

function var_0_0.GetDisplayAward(arg_21_0)
	return arg_21_0:getConfig("award_display")
end

function var_0_0.IsUnlock(arg_22_0, arg_22_1)
	return arg_22_1 >= arg_22_0:getConfig("unlock_guild_level")
end

function var_0_0.GetTheme(arg_23_0)
	return arg_23_0:getConfig("theme")
end

function var_0_0.GetJoinShips(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.missions) do
		for iter_24_2, iter_24_3 in ipairs(iter_24_1) do
			if not iter_24_3:IsFinish() then
				for iter_24_4, iter_24_5 in ipairs((iter_24_3:GetMyShips())) do
					table.insert({}, iter_24_5)
				end
			end
		end
	end

	return {}
end

function var_0_0.GetMissionById(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.missions) do
		for iter_25_2, iter_25_3 in ipairs(iter_25_1) do
			if iter_25_3.id == arg_25_1 then
				return iter_25_3
			end
		end
	end

	assert(false)

	return
end

function var_0_0.GetJoinShipCnt(arg_26_0)
	local var_26_0 = 0

	for iter_26_0, iter_26_1 in pairs(arg_26_0.missions) do
		for iter_26_2, iter_26_3 in ipairs(iter_26_1) do
			var_26_0 = var_26_0 + iter_26_3:GetJoinCnt()
		end
	end

	return var_26_0
end

function var_0_0.GetBossShipIds(arg_27_0)
	if arg_27_0.boss and arg_27_0.boss:IsActive() then
		for iter_27_0, iter_27_1 in ipairs((arg_27_0.boss:GetMyShipIds())) do
			table.insert({}, iter_27_1)
		end
	end

	return {}
end

function var_0_0.GetMissionCnt(arg_28_0)
	local var_28_0 = 0

	for iter_28_0, iter_28_1 in pairs(arg_28_0.missions) do
		for iter_28_2, iter_28_3 in ipairs(iter_28_1) do
			var_28_0 = var_28_0 + 1
		end
	end

	return var_28_0
end

function var_0_0.GetMainMissionCntAndFinishCnt(arg_29_0)
	local var_29_0 = 0
	local var_29_1 = 0

	for iter_29_0, iter_29_1 in pairs(arg_29_0.missions) do
		for iter_29_2, iter_29_3 in ipairs(iter_29_1) do
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

function var_0_0.GetMissionFinishCnt(arg_30_0)
	local var_30_0 = 0

	for iter_30_0, iter_30_1 in pairs(arg_30_0.missions) do
		for iter_30_2, iter_30_3 in ipairs(iter_30_1) do
			if iter_30_3:IsFinish() then
				var_30_0 = var_30_0 + 1
			end
		end
	end

	return var_30_0
end

function var_0_0.GetCanFormationMisstions(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.missions) do
		for iter_31_2, iter_31_3 in ipairs(iter_31_1) do
			if (function(arg_32_0)
				if arg_32_0:IsFinish() then
					return false
				end

				local var_32_0 = arg_31_0.missions[arg_32_0:GetPosition() - 1]

				if var_32_0 then
					for iter_32_0, iter_32_1 in pairs(var_32_0) do
						if iter_32_1:IsMain() and iter_32_1:IsFinish() then
							return true
						end
					end
				else
					return true
				end

				return false
			end)(iter_31_3) and iter_31_3:CanFormation() and not iter_31_3:IsFinish() then
				table.insert({}, iter_31_3)
			end
		end
	end

	return {}
end

function var_0_0.AnyMissionCanFormation(arg_33_0)
	return #arg_33_0:GetCanFormationMisstions() > 0
end

function var_0_0.AnyMissionFirstFleetCanFroamtion(arg_34_0)
	local var_34_0 = _.detect(arg_34_0:GetCanFormationMisstions(), function(arg_35_0)
		return arg_35_0:FirstFleetCanFormation() or arg_35_0:IsFinish() and not arg_35_0:IsFinishedByServer()
	end)

	return var_34_0 ~= nil, var_34_0
end

function var_0_0.GetUnlockMission(arg_36_0)
	local var_36_0 = 0

	for iter_36_0, iter_36_1 in pairs(arg_36_0.missions) do
		for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
			if iter_36_3:IsMain() and (iter_36_3:IsFinishedByServer() or iter_36_3:IsFinish()) then
				var_36_0 = iter_36_0
			end
		end
	end

	for iter_36_4, iter_36_5 in ipairs(arg_36_0.missions[var_36_0 + 1] or {}) do
		if iter_36_5:IsMain() then
			return iter_36_5
		end
	end

	return nil
end

function var_0_0.GetLeftTime(arg_37_0)
	return arg_37_0.endTime - pg.TimeMgr.GetInstance():GetServerTime()
end

return var_0_0
