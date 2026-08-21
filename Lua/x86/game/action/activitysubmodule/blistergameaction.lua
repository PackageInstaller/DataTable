local var_0_0 = {}

manager.net:Bind(86001, function(arg_1_0)
	BlisterGameData:InitData(arg_1_0.mini_game_info)
	manager.notify:Invoke(BLISTERGAME_INFO_UPDATE)
end)

function var_0_0.GetBListerReward(arg_2_0, arg_2_1)
	local var_2_0 = {
		point_reward_id_list = {
			arg_2_0
		}
	}

	manager.net:SendWithLoadingNew(60054, var_2_0, 60055, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			getReward2(arg_3_0.reward_list)
			BlisterGameData:RefreshTaskData(arg_2_0)
			manager.notify:Invoke(BLISTERGAME_INFO_UPDATE)

			if arg_2_1 then
				arg_2_1()
			end
		else
			ShowTips(arg_3_0.result)
		end
	end)
end

function var_0_0.SendBlisterGameResult(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if manager.ChessBoardManager and manager.ChessBoardManager:IsBattleBack() then
		if arg_4_4 then
			arg_4_4()
		end

		return
	end

	local var_4_0 = {
		activity_id = arg_4_0,
		stage_id = arg_4_1,
		value = arg_4_2,
		star = arg_4_3
	}

	manager.net:SendWithLoadingNew(86002, var_4_0, 86003, function(arg_5_0)
		if arg_4_4 then
			arg_4_4(arg_5_0)
		end

		if isSuccess(arg_5_0.result) then
			manager.notify:Invoke(BLISTERGAME_INFO_UPDATE)
			BlisterGameData:UpdatePointData(var_4_0)

			if arg_4_4 then
				arg_4_4()
			end
		else
			ShowTips(arg_5_0.result)
		end
	end)
end

function var_0_0.PlayGame(arg_6_0)
	DestroyLua()
	BlisterGameLuaBridge.Launcher(arg_6_0)
end

function var_0_0.UpdateRedPoint(arg_7_0)
	BlisterGameData:UpdateRedPoint(arg_7_0)
end

return var_0_0
