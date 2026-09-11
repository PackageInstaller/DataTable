local SummerRaceRankData = class("SummerRaceRankData")

function SummerRaceRankData:ExportMethod()
	return {
		"BuildRankBuildData",
		"BuildSummerRaceRankData",
		"BuildRankPageData",
		"ResolveSettlementRank",
		"FormatBattleDuration",
		"NormalizeChallengeRecordResultState",
		"BuildRoundRecordMap",
		"ResolveCompletedRoundFromRecords",
		"BuildChallengeSettlementRecords",
		"BuildSurvivalPracticeSettlementRecords",
		"BuildSettlementRecords",
		"BuildRankBattleInfoPopModel"
	}
end

function SummerRaceRankData:BuildRankBuildData(arg_2_1, arg_2_2)
	local var_2_0

	if type(arg_2_2) == "table" then
		var_2_0 = arg_2_2.extraInfo or nil
	end

	local var_2_1 = {
		rankSlots = {},
		weaponIds = {},
		equipIds = {}
	}

	if type(var_2_0) ~= "table" then
		return var_2_1
	end

	local var_2_2 = {}
	local var_2_3 = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		local var_2_4 = tonumber(iter_2_0)

		if var_2_4 ~= nil and var_2_3[var_2_4] ~= true then
			var_2_3[var_2_4] = true
			var_2_2[#var_2_2 + 1] = var_2_4
		end
	end

	table.sort(var_2_2)

	for iter_2_2 = 1, var_2_2[#var_2_2] or 0 do
		local var_2_5 = tonumber(var_2_0[iter_2_2]) or tonumber(var_2_0[tostring(iter_2_2)])

		if var_2_5 ~= nil and var_2_5 ~= 0 then
			if iter_2_2 == 1 then
				var_2_1.bodyId = var_2_5
			elseif arg_2_1:FindDefById(arg_2_1:_GetWeaponDefs(), var_2_5) ~= nil then
				var_2_1.rankSlots[#var_2_1.rankSlots + 1] = {
					itemId = var_2_5,
					slotType = SummerRaceConst.FILTER.WEAPON
				}
				var_2_1.weaponIds[#var_2_1.weaponIds + 1] = var_2_5
			elseif arg_2_1:FindDefById(arg_2_1:_GetEquipDefs(), var_2_5) ~= nil then
				var_2_1.rankSlots[#var_2_1.rankSlots + 1] = {
					itemId = var_2_5,
					slotType = SummerRaceConst.FILTER.EQUIP
				}
				var_2_1.equipIds[#var_2_1.equipIds + 1] = var_2_5
			else
				var_2_1.rankSlots[#var_2_1.rankSlots + 1] = {
					itemId = var_2_5
				}
				var_2_1.equipIds[#var_2_1.equipIds + 1] = var_2_5
			end
		elseif iter_2_2 > 1 then
			var_2_1.rankSlots[#var_2_1.rankSlots + 1] = {}
		end
	end

	return var_2_1
end

function SummerRaceRankData:BuildSummerRaceRankData(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0

	if type(arg_3_2) ~= "table" then
		do return nil end

		var_3_0 = {
			user_id = arg_3_2.user_id,
			rank = arg_3_2.rank,
			playerName = arg_3_2.nick,
			nick = arg_3_2.nick,
			score = arg_3_2.score,
			difficulty = arg_3_2.difficulty,
			timestamp = arg_3_2.timestamp,
			portrait = arg_3_2.portrait,
			frame = arg_3_2.frame,
			stage_team_list = arg_3_2.stage_team_list,
			staticInfo = arg_3_2.staticInfo,
			extraInfo = arg_3_2.extraInfo
		}
	end

	var_3_0.buildData = arg_3_1:BuildRankBuildData(arg_3_2)
	var_3_0.isSelf = arg_3_3 == true

	return var_3_0
end

function SummerRaceRankData:BuildRankPageData(arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:GetSummerRaceRankActivityId()
	local var_4_1 = var_4_0 ~= 0 and RankData:GetActivityRank(var_4_0, 0) or nil
	local var_4_2 = {}
	local var_4_3
	local var_4_4 = PlayerData:GetPlayerInfo()

	if var_4_4 then
		local var_4_5 = var_4_4.userID or nil

		if var_4_1 ~= nil then
			for iter_4_0 = 1, #(var_4_1.rankList or {}) do
				local var_4_7 = var_4_5 ~= nil and var_4_1.rankList[iter_4_0].user_id == var_4_5
				local var_4_8 = arg_4_1:BuildSummerRaceRankData(var_4_1.rankList[iter_4_0], var_4_5 ~= nil and var_4_1.rankList[iter_4_0].user_id == var_4_5)

				if var_4_8 ~= nil then
					var_4_2[#var_4_2 + 1] = var_4_8

					if var_4_7 then
						var_4_3 = arg_4_1:CloneTable(var_4_8)
					end
				end
			end

			if var_4_1.curRank ~= nil then
				var_4_3 = arg_4_1:BuildSummerRaceRankData(var_4_1.curRank, true)
			end
		end
	end

	return {
		selectedTab = "season",
		rankList = var_4_2,
		selfRank = var_4_3
	}
end

function SummerRaceRankData:ResolveSettlementRank(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:BuildRankPageData(arg_5_2)

	return var_5_0.selfRank and (tonumber(var_5_0.selfRank.rank) or 0) or 0
end

function SummerRaceRankData:FormatBattleDuration(arg_6_1, arg_6_2)
	local var_6_0 = math.max(0, math.floor((tonumber(arg_6_2) or 0) + 0.5))

	return string.format("%02d:%02d", math.floor(var_6_0 / 60), var_6_0 % 60)
end

function SummerRaceRankData:NormalizeChallengeRecordResultState(arg_7_1, arg_7_2)
	local var_7_0 = string.lower(tostring(arg_7_2 or ""))

	if var_7_0 == "win" or var_7_0 == "lose" or var_7_0 == "none" then
		return var_7_0
	end

	return "none"
end

function SummerRaceRankData:BuildRoundRecordMap(arg_8_1, arg_8_2)
	local var_8_0 = {}

	if type(arg_8_2) ~= "table" then
		return var_8_0
	end

	for iter_8_0 = 1, #arg_8_2 do
		if type(arg_8_2[iter_8_0]) == "table" then
			local var_8_1 = math.max(0, math.floor(tonumber(arg_8_2[iter_8_0].round) or 0))

			if var_8_1 > 0 then
				local var_8_2 = {
					resultState = arg_8_1:NormalizeChallengeRecordResultState(arg_8_2[iter_8_0].result)
				}

				var_8_2.durationSec = math.max(0, tonumber(arg_8_2[iter_8_0].durationSec) or 0)
				var_8_2.score = math.max(0, math.floor(tonumber(arg_8_2[iter_8_0].score) or 0))
				var_8_0[var_8_1] = var_8_2
			end
		end
	end

	return var_8_0
end

function SummerRaceRankData:ResolveCompletedRoundFromRecords(arg_9_1, arg_9_2)
	local var_9_0 = 0

	if type(arg_9_2) ~= "table" then
		return var_9_0
	end

	for iter_9_0 = 1, #arg_9_2 do
		if type(arg_9_2[iter_9_0]) == "table" and arg_9_1:NormalizeChallengeRecordResultState(arg_9_2[iter_9_0].result) == "win" then
			var_9_0 = math.max(var_9_0, math.floor(tonumber(arg_9_2[iter_9_0].round) or 0))
		end
	end

	return var_9_0
end

function SummerRaceRankData:BuildChallengeSettlementRecords(arg_10_1, arg_10_2)
	local var_10_0 = math.max(0, math.floor(tonumber(arg_10_2.challengeReachedWave) or tonumber(arg_10_2.destroyedEnemies) or 0))
	local var_10_1 = arg_10_1:BuildRoundRecordMap(arg_10_2.challengeRoundRecords)

	if next(var_10_1) == nil then
		var_10_1 = arg_10_1:BuildRoundRecordMap(arg_10_2.roundRecords)
	end

	local var_10_2 = {}

	for iter_10_0 = 1, 20 do
		local var_10_3 = "none"
		local var_10_4 = 0
		local var_10_5 = 0

		if var_10_1[iter_10_0] ~= nil then
			var_10_3 = var_10_1[iter_10_0].resultState
			var_10_4 = var_10_1[iter_10_0].durationSec
			var_10_5 = var_10_1[iter_10_0].score
		elseif iter_10_0 <= var_10_0 then
			var_10_3 = (arg_10_2.isWin == true or iter_10_0 < var_10_0) and "win" or "lose"
		end

		local var_10_6 = #var_10_2 + 1
		local var_10_7 = {
			enemyAvatarPath = "",
			enemyCount = 1,
			enemyId = 0,
			waveIndex = iter_10_0,
			waveText = string.format(arg_10_1:ResolveTipsText("ACTIVITY_TANK_WAVE"), iter_10_0),
			enemyName = string.format("Wave %d", iter_10_0),
			duration = var_10_4
		}

		var_10_7.timeText = var_10_3 ~= "none" and arg_10_1:FormatBattleDuration(var_10_4) or "--:--"
		var_10_7.resultState = var_10_3
		var_10_7.score = var_10_5
		var_10_2[var_10_6] = var_10_7
	end

	return var_10_2
end

function SummerRaceRankData:BuildSurvivalPracticeSettlementRecords(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0

	if type(arg_11_2.survivalEnemyRecords) == "table" then
		var_11_0 = arg_11_2.survivalEnemyRecords or {}

		local var_11_1

		if #var_11_0 > 0 then
			var_11_1 = #var_11_0 or #arg_11_3
		end
	end

	local var_11_2 = {}

	for iter_11_0 = 1, var_11_1 do
		local var_11_3 = arg_11_3[iter_11_0] or {}
		local var_11_4 = var_11_0[iter_11_0]
		local var_11_5 = var_11_3.enemyId or 0
		local var_11_6 = tonumber(var_11_3.sourceWaveIndex) or tonumber(var_11_3.waveIndex) or 1
		local var_11_7 = "none"
		local var_11_8 = 0
		local var_11_9 = false

		if type(var_11_4) == "table" then
			var_11_6 = math.max(1, math.floor(tonumber(var_11_4.round) or var_11_6))
			var_11_5 = var_11_4.enemyId or var_11_5
			var_11_7 = arg_11_1:NormalizeChallengeRecordResultState(var_11_4.result)
			var_11_8 = math.max(0, tonumber(var_11_4.durationSec) or 0)
			var_11_9 = var_11_4.showTime ~= false
		end

		local var_11_10 = arg_11_1:FindDefById(arg_11_4, var_11_5)
		local var_11_11

		if var_11_10 ~= nil then
			var_11_11 = arg_11_1:ResolveEnemyAvatarPath(var_11_10) or var_11_3.enemyAvatarPath or ""
		end

		local var_11_12 = var_11_7 ~= "none" and var_11_9 and arg_11_1:FormatBattleDuration(var_11_8) or nil
		local var_11_13 = #var_11_2 + 1
		local var_11_14 = {
			enemyCount = 1,
			waveIndex = iter_11_0,
			sourceWaveIndex = var_11_6,
			waveText = string.format(arg_11_1:ResolveTipsText("ACTIVITY_TANK_WAVE"), var_11_6)
		}

		if var_11_10 then
			var_11_14.enemyId = var_11_10.enemyId or var_11_5
		end

		local var_11_15 = {}

		if var_11_10 then
			var_11_15[1] = var_11_10.enemyId or var_11_5
		end

		var_11_14.enemyIds = var_11_15

		if var_11_10 then
			var_11_14.enemyName = var_11_10.enemyName or var_11_3.enemyName or string.format("Wave %d", var_11_6)
		end

		var_11_14.enemyAvatarPath = var_11_11
		var_11_14.duration = var_11_9 and var_11_7 ~= "none" and var_11_8 or 0
		var_11_14.timeText = var_11_12
		var_11_14.resultState = var_11_7
		var_11_2[var_11_13] = var_11_14
	end

	return var_11_2
end

function SummerRaceRankData:BuildSettlementRecords(arg_12_1, arg_12_2)
	if type(arg_12_2) ~= "table" then
		return {}
	end

	if arg_12_2.mode == SummerRaceConst.MODE.CHALLENGE then
		return arg_12_1:BuildChallengeSettlementRecords(arg_12_2)
	end

	local var_12_0 = arg_12_1:FindStageInfoById(arg_12_2.stageId) or arg_12_1:GetDefaultStageDefByModeKey(arg_12_2.mode)
	local var_12_1 = arg_12_1:GetEnemyDefs()
	local var_12_2 = arg_12_1:BuildEnemyWaveDisplayList(var_12_0, var_12_1)
	local var_12_3 = #var_12_2

	if arg_12_2.mode == SummerRaceConst.MODE.SURVIVAL_PRACTICE then
		return arg_12_1:BuildSurvivalPracticeSettlementRecords(arg_12_2, var_12_2, var_12_1)
	end

	local var_12_4 = arg_12_1:BuildRoundRecordMap(arg_12_2.roundRecords)
	local var_12_5 = math.max(0, math.min(var_12_3, tonumber(arg_12_2.destroyedEnemies) or 0))
	local var_12_6
	local var_12_7 = {}

	for iter_12_0, iter_12_1 in pairs(var_12_4) do
		if iter_12_0 >= 1 and iter_12_0 <= var_12_3 then
			if iter_12_1.resultState == "win" then
				var_12_5 = math.max(var_12_5, iter_12_0)
			elseif iter_12_1.resultState == "lose" then
				var_12_6 = math.max(var_12_6 or 0, iter_12_0)
			end
		end
	end

	if var_12_6 ~= nil then
		var_12_5 = math.max(var_12_5, var_12_6 - 1)

		for iter_12_2, iter_12_3 in pairs(var_12_4) do
			if iter_12_3.resultState == "lose" and iter_12_2 ~= var_12_6 then
				var_12_4[iter_12_2] = nil
			end
		end
	elseif arg_12_2.isWin ~= true and var_12_5 < var_12_3 then
		var_12_6 = var_12_5 + 1
	end

	local var_12_8

	if var_12_5 + (var_12_6 ~= nil and 1 or 0) > 0 then
		var_12_8 = math.max(0, tonumber(arg_12_2.battleElapsed) or 0) / (var_12_5 + (var_12_6 ~= nil and 1 or 0))
		var_12_8 = var_12_8 or 0
	end

	for iter_12_4 = #var_12_7 + 1, var_12_3 do
		local var_12_9 = var_12_2[iter_12_4] or {}
		local var_12_10 = tonumber(var_12_9.sourceWaveIndex) or tonumber(var_12_9.waveIndex) or iter_12_4
		local var_12_11 = var_12_4[var_12_10]
		local var_12_12 = "none"
		local var_12_13 = "--:--"
		local var_12_14 = 0

		if var_12_4[var_12_10] ~= nil then
			var_12_12 = var_12_11.resultState
			var_12_14 = var_12_11.durationSec
			var_12_13 = var_12_11.resultState ~= "none" and arg_12_1:FormatBattleDuration(var_12_14) or "--:--"
		elseif iter_12_4 <= var_12_5 then
			var_12_12 = "win"
			var_12_14 = var_12_8
			var_12_13 = arg_12_1:FormatBattleDuration(var_12_8)
		elseif iter_12_4 == var_12_6 then
			var_12_12 = "lose"
			var_12_14 = var_12_8
			var_12_13 = arg_12_1:FormatBattleDuration(var_12_8)
		end

		local var_12_15 = #var_12_7 + 1
		local var_12_16 = {
			waveIndex = iter_12_4,
			sourceWaveIndex = var_12_10
		}

		var_12_16.waveText = var_12_9.waveText or string.format(arg_12_1:ResolveTipsText("ACTIVITY_TANK_WAVE"), var_12_10)
		var_12_16.enemyId = var_12_9.enemyId or 0
		var_12_16.enemyIds = arg_12_1:CloneTable(var_12_9.enemyIds)
		var_12_16.enemyName = var_12_9.enemyName or string.format("Wave %d", var_12_10)
		var_12_16.enemyAvatarPath = var_12_9.enemyAvatarPath or ""
		var_12_16.enemyCount = var_12_9.enemyCount or 1
		var_12_16.duration = var_12_12 ~= "none" and var_12_14 or 0
		var_12_16.timeText = var_12_13
		var_12_16.resultState = var_12_12
		var_12_7[var_12_15] = var_12_16
	end

	return var_12_7
end

function SummerRaceRankData:BuildRankBattleInfoPopModel(arg_13_1, arg_13_2)
	local var_13_0

	if type(arg_13_2) == "table" then
		var_13_0 = arg_13_2.buildData or nil

		if type(var_13_0) ~= "table" then
			local var_13_1 = {}

			if arg_13_2 then
				var_13_1.bodyId = arg_13_2.bodyId or nil
			end

			if arg_13_2 then
				var_13_1.equipIds = arg_13_2.equipIds or {}
			end

			var_13_0 = var_13_1
		end
	end

	local var_13_2 = arg_13_1:BuildBuildSnapshot(var_13_0, nil)
	local var_13_3 = tostring((arg_13_2 or nil) and (arg_13_2.playerName or arg_13_2.nick or ""))
	local var_13_4

	if type(var_13_0) == "table" and type(var_13_0.rankSlots) == "table" then
		var_13_4 = {}

		local var_13_5 = arg_13_1:_GetWeaponDefs()
		local var_13_6 = arg_13_1:_GetEquipDefs()
		local var_13_7 = var_13_2.slotSummary or {}

		for iter_13_0 = 1, math.max(#var_13_0.rankSlots, #var_13_7) do
			local var_13_8 = var_13_0.rankSlots[iter_13_0]
			local var_13_9

			if not var_13_0.rankSlots[iter_13_0] then
				var_13_8 = {}
				var_13_9 = arg_13_1:FindDefById(var_13_5, var_13_8.itemId)
			end

			local var_13_11 = arg_13_1:FindDefById(var_13_6, var_13_8.itemId)

			var_13_4[#var_13_4 + 1] = var_13_9 ~= nil and arg_13_1:BuildSlotData(iter_13_0, SummerRaceConst.FILTER.WEAPON, var_13_9, nil, nil) or var_13_11 ~= nil and arg_13_1:BuildSlotData(iter_13_0, SummerRaceConst.FILTER.EQUIP, var_13_11, nil, nil) or arg_13_1:BuildSlotData(iter_13_0, var_13_8.slotType or (not (var_13_7[iter_13_0] or {}).slotType or nil) and SummerRaceConst.FILTER.WEAPON, nil, nil)
		end
	end

	local var_13_14 = {
		source = "rankDetail",
		nextEnabled = false,
		prevEnabled = false,
		titleText = var_13_3
	}

	if arg_13_2 then
		var_13_14.rank = arg_13_2.rank or nil
	end

	if arg_13_2 then
		var_13_14.score = arg_13_2.score or nil
	end

	var_13_14.hpText = tostring(arg_13_1:RoundToInt(var_13_2.hp))
	var_13_14.vehicleDisplay = arg_13_1:BuildVehicleDisplayModelFromSnapshot(var_13_2)
	var_13_14.slotSummary = var_13_4 or arg_13_1:CloneTable(var_13_2.slotSummary)
	var_13_14.weaponList = arg_13_1:CloneTable(var_13_2.weaponList)
	var_13_14.equipList = arg_13_1:CloneTable(var_13_2.equipList)
	var_13_14.buildData = arg_13_1:CloneTable(var_13_2.buildData)

	return var_13_14
end

return SummerRaceRankData
