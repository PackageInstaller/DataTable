local var_0_0 = {
	ParseCricketSettle = function(arg_1_0, arg_1_1)
		return {
			totalNum = arg_1_1.sum_score or 0,
			peculiar = arg_1_1.peculiarity_score or 0,
			skillAdd = arg_1_1.skill_add_score or 0,
			skillDec = arg_1_1.skill_decrease_score or 0
		}
	end
}

function var_0_0.AskPvPBattleData(arg_2_0, arg_2_1, arg_2_2)
	manager.net:SendWithLoadingNew(58160, {
		defender_uid = arg_2_1,
		battle_type = FriendsData:IsFriend(arg_2_1) and 1 or 2,
		stage_id = arg_2_2
	}, 58161, var_0_0.OnAskPvPBattle)
end

function var_0_0.AskPvEBattleData(arg_3_0, arg_3_1)
	manager.net:SendWithLoadingNew(58186, {
		stage_id = arg_3_1
	}, 58187, var_0_0.OnAskPvEBattle)
end

function var_0_0.OnAskPvPBattle(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		BackHomeCricketBattleData:InitSingleBattleData(arg_4_0, arg_4_1)
		BackHomeDataManager:GotoBackHomeCricketStage(BackHomeCricketConst.ROOM_TYPE.PVP_STAGE, arg_4_1.stage_id)
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.OnAskPvEBattle(arg_5_0, arg_5_1, arg_5_2)
	if isSuccess(arg_5_0.result) then
		arg_5_1.battle_type = BackHomeCricketConst.ROOM_TYPE.PVE_STAGE

		BackHomeCricketBattleData:InitSingleBattleData(arg_5_0, arg_5_1)
		BackHomeDataManager:GotoBackHomeCricketStage(BackHomeCricketConst.ROOM_TYPE.PVE_STAGE, arg_5_1.stage_id)
	else
		ShowTips(arg_5_0.result)
	end
end

function var_0_0.SendBattleComplete(arg_6_0, arg_6_1)
	local var_6_0 = {
		give_flower_times = Dorm.storage:GetData(DanceGame.actionCountNamespace, "flower") or 0,
		light_fireworks_times = Dorm.storage:GetData(DanceGame.actionCountNamespace, "firework") or 0,
		reinforce_times = Dorm.storage:GetData(DanceGame.actionCountNamespace, "cheer") or 0
	}
	local var_6_1 = {
		battle_type = arg_6_0,
		acc_event = var_6_0
	}

	manager.net:SendWithLoadingNew(58164, var_6_1, 58165, var_0_0.OnBattleResult(arg_6_1))
end

function var_0_0.OnBattleResult(arg_7_0)
	return function(arg_8_0, arg_8_1)
		if isSuccess(arg_8_0.result) then
			local var_8_0 = BackHomeCricketBattleData:GetSingleBattleData()

			if var_8_0 then
				var_8_0:AddCompleteInfo(arg_8_1, arg_8_0)
			end

			if arg_7_0 then
				arg_7_0(arg_8_1, arg_8_0)
			end
		else
			ShowTips(arg_8_0.result)
		end
	end
end

function var_0_0.AskBattleHistorySimpleData(arg_9_0, arg_9_1)
	if arg_9_0 then
		manager.net:SendWithLoadingNew(58184, {
			battle_id = arg_9_0
		}, 58185, function(arg_10_0, arg_10_1)
			if isSuccess(arg_10_0.result) then
				BackHomeCricketBattleData:InitSingleBattleData(arg_10_0, arg_10_1, BackHomeCricketConst.ROOM_TYPE.Video)

				if arg_9_1 then
					arg_9_1()
				end

				BackHomeDataManager:GotoBackHomeCricketStage(BackHomeCricketConst.ROOM_TYPE.PVP_STAGE, arg_10_0.stage_id, BackHomeCricketConst.ROOM_TYPE.Video)
			else
				ShowTips(arg_10_0.result)
			end
		end)
	end
end

return var_0_0
