local var_0_0 = singletonClass("IdolCompetitionData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
end

function var_0_0.InitDataFromServer(arg_2_0, arg_2_1)
	var_0_1[arg_2_1.activity_id] = {
		activityID = arg_2_1.activity_id,
		phase = arg_2_1.phase,
		heroSetting = {},
		refreshTime = {}
	}
	var_0_3[arg_2_1.activity_id] = 1

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.hero_setting_list) do
		var_0_1[arg_2_1.activity_id].heroSetting[iter_2_1.stage_id] = {
			stageID = iter_2_1.stage_id,
			heroID = iter_2_1.hero_id
		}
	end

	var_0_1[arg_2_1.activity_id].refreshTime[1] = arg_2_1.refresh_time.start_time
	var_0_1[arg_2_1.activity_id].refreshTime[2] = arg_2_1.refresh_time.round1_time
	var_0_1[arg_2_1.activity_id].refreshTime[3] = arg_2_1.refresh_time.round2_time
	var_0_1[arg_2_1.activity_id].refreshTime[4] = arg_2_1.refresh_time.round3_time
end

function var_0_0.OnRequestSignUpForRace(arg_3_0, arg_3_1, arg_3_2)
	if var_0_1[arg_3_1] then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
			var_0_1[arg_3_1].heroSetting[iter_3_1.stage_id] = {
				stageID = iter_3_1.stage_id,
				heroID = iter_3_1.hero_id
			}
		end
	end
end

function var_0_0.UpdateRacePhaseData(arg_4_0, arg_4_1, arg_4_2)
	var_0_2[arg_4_2] = {
		schedule = {},
		playerInfo = {}
	}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.phase_record_list) do
		var_0_2[arg_4_2].schedule[iter_4_1.phase] = {
			phase = iter_4_1.phase,
			recordData = {}
		}

		if not var_0_3[arg_4_2] or var_0_3[arg_4_2] < iter_4_1.phase then
			var_0_3[arg_4_2] = iter_4_1.phase
		end

		for iter_4_2, iter_4_3 in ipairs(iter_4_1.record_list) do
			var_0_2[arg_4_2].schedule[iter_4_1.phase].recordData[iter_4_2] = {
				player1Score = 0,
				player2Score = 0,
				player1ID = iter_4_3.user1_id,
				player2ID = iter_4_3.user2_id,
				battleData = {},
				result = iter_4_3.final_battle_result
			}

			for iter_4_4, iter_4_5 in ipairs(iter_4_3.battle_detail_list) do
				var_0_2[arg_4_2].schedule[iter_4_1.phase].recordData[iter_4_2].player1Score = var_0_2[arg_4_2].schedule[iter_4_1.phase].recordData[iter_4_2].player1Score + iter_4_5.user1_battle_data.score
				var_0_2[arg_4_2].schedule[iter_4_1.phase].recordData[iter_4_2].player2Score = var_0_2[arg_4_2].schedule[iter_4_1.phase].recordData[iter_4_2].player2Score + iter_4_5.user2_battle_data.score
				var_0_2[arg_4_2].schedule[iter_4_1.phase].recordData[iter_4_2].battleData[iter_4_4] = {
					stageID = iter_4_5.stage_id,
					player1Info = {
						heroID = iter_4_5.user1_battle_data.hero_id,
						score = iter_4_5.user1_battle_data.score,
						npc = iter_4_5.user1_battle_data.is_npc_hero or false,
						advantage = iter_4_5.user1_battle_data.peculiarity_score,
						skillAdd = iter_4_5.user1_battle_data.skill_add_score,
						skillReduce = iter_4_5.user1_battle_data.skill_decrease_score
					},
					player2Info = {
						heroID = iter_4_5.user2_battle_data.hero_id,
						score = iter_4_5.user2_battle_data.score,
						npc = iter_4_5.user2_battle_data.is_npc_hero or false,
						advantage = iter_4_5.user2_battle_data.peculiarity_score,
						skillAdd = iter_4_5.user2_battle_data.skill_add_score,
						skillReduce = iter_4_5.user2_battle_data.skill_decrease_score
					},
					result = iter_4_5.battle_result
				}
			end
		end
	end

	for iter_4_6, iter_4_7 in ipairs(arg_4_1.user_info_list) do
		var_0_2[arg_4_2].playerInfo[iter_4_7.user_id] = {}
		var_0_2[arg_4_2].playerInfo[iter_4_7.user_id].userID = iter_4_7.user_id
		var_0_2[arg_4_2].playerInfo[iter_4_7.user_id].npc = iter_4_7.npc_id or 0

		if iter_4_7.npc_id and iter_4_7.npc_id ~= 0 then
			var_0_2[arg_4_2].playerInfo[iter_4_7.user_id].name = ActivityIdolCompetitionNpcCfg[iter_4_7.npc_id].nick
			var_0_2[arg_4_2].playerInfo[iter_4_7.user_id].head = ActivityIdolCompetitionNpcCfg[iter_4_7.npc_id].icon
			var_0_2[arg_4_2].playerInfo[iter_4_7.user_id].frame = ActivityIdolCompetitionNpcCfg[iter_4_7.npc_id].icon_frame
		elseif iter_4_7.user_base then
			var_0_2[arg_4_2].playerInfo[iter_4_7.user_id].name = iter_4_7.user_base.nick
			var_0_2[arg_4_2].playerInfo[iter_4_7.user_id].head = iter_4_7.user_base.icon
			var_0_2[arg_4_2].playerInfo[iter_4_7.user_id].frame = iter_4_7.user_base.icon_frame
		end
	end
end

function var_0_0.TryToRequestNewPhaseData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = var_0_3[arg_5_1]

	if not var_5_0 then
		ShowTips("IDOL_COMPETITION_RACE_COMING")

		return
	end

	if var_5_0 >= 4 or not arg_5_0:CheckMeTakePartIn(arg_5_1) then
		arg_5_2()

		return
	end

	if var_5_0 < var_0_1[arg_5_1].phase then
		IdolCompetitionAction.RequestForRaceSchedule(arg_5_1, arg_5_2)
	else
		arg_5_2()
	end
end

function var_0_0.GetRacePlayerInfo(arg_6_0, arg_6_1, arg_6_2)
	if var_0_2[arg_6_1] and var_0_2[arg_6_1].playerInfo[arg_6_2] then
		return var_0_2[arg_6_1].playerInfo[arg_6_2]
	end

	return nil
end

function var_0_0.GetBattleInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not var_0_2[arg_7_1] or not var_0_2[arg_7_1].schedule[arg_7_2] or not var_0_2[arg_7_1].schedule[arg_7_2].recordData[arg_7_3] then
		return true
	end

	return false, arg_7_2 <= var_0_1[arg_7_1].phase, var_0_2[arg_7_1].schedule[arg_7_2].recordData[arg_7_3].player1ID, var_0_2[arg_7_1].schedule[arg_7_2].recordData[arg_7_3].player2ID, var_0_2[arg_7_1].schedule[arg_7_2].recordData[arg_7_3].result
end

function var_0_0.GetBattleDetailInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if var_0_2[arg_8_1] and var_0_2[arg_8_1].schedule[arg_8_2] and var_0_2[arg_8_1].schedule[arg_8_2].recordData[arg_8_3] then
		return var_0_2[arg_8_1].schedule[arg_8_2].recordData[arg_8_3]
	end

	return nil
end

function var_0_0.GetRacePhase(arg_9_0, arg_9_1)
	if var_0_1[arg_9_1] then
		return var_0_1[arg_9_1].phase
	end

	return nil
end

function var_0_0.GetRaceRefreshTime(arg_10_0, arg_10_1)
	if var_0_1[arg_10_1] then
		return var_0_1[arg_10_1].refreshTime
	end

	return nil
end

function var_0_0.CheckMeTakePartIn(arg_11_0, arg_11_1)
	if var_0_1[arg_11_1] then
		for iter_11_0, iter_11_1 in pairs(var_0_1[arg_11_1].heroSetting) do
			return true
		end
	end

	return false
end

function var_0_0.CheckRaceSignState(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(var_0_1) do
		if iter_12_1.phase == 1 then
			local var_12_0 = false

			for iter_12_2, iter_12_3 in pairs(iter_12_1.heroSetting) do
				var_12_0 = true

				break
			end

			if not var_12_0 then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetSignUpInfo(arg_13_0, arg_13_1)
	local var_13_0 = {}

	if var_0_1[arg_13_1] then
		local var_13_1 = ActivityIdolCompetitionCfg[arg_13_1].stage_id_list

		for iter_13_0, iter_13_1 in ipairs(var_13_1) do
			if var_0_1[arg_13_1].heroSetting[iter_13_1] then
				table.insert(var_13_0, clone(var_0_1[arg_13_1].heroSetting[iter_13_1]))
			else
				table.insert(var_13_0, {
					heroID = 0,
					stageID = iter_13_1
				})
			end
		end
	end

	return var_13_0
end

return var_0_0
