local var_0_0 = {}

manager.net:Bind(84201, function(arg_1_0)
	SPKaliChallengeData:InitData(arg_1_0)
	manager.notify:Invoke(ACTIVITY_KALI_INFO)
end)

function var_0_0.RollAffix(arg_2_0)
	local var_2_0 = {
		activity_id = arg_2_0
	}
	local var_2_1 = GameSetting.activity_kali_cost_item.value[1]
	local var_2_2 = ItemTools.getItemNum(var_2_1)
	local var_2_3 = GameSetting.activity_kali_cost_item.value[2]

	manager.net:SendWithLoadingNew(84202, var_2_0, 84203, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			SPKaliChallengeData:UpdateKaliAffix({
				activity_id = arg_2_0,
				affix_list = arg_3_0.affix_list,
				lucky = arg_3_0.lucky
			})
			manager.notify:Invoke(ACTIVITY_KALI_INFO)

			if callback then
				callback()
			end
		else
			ShowTips(arg_3_0.result)
		end
	end)
end

manager.net:Bind(84211, function(arg_4_0)
	TugGameData:InitTugData(arg_4_0)
	manager.notify:Invoke(ACTIVITY_KALI_INFO)
end)

function var_0_0.SendTugGameResult(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {
		activity_id = arg_5_0,
		stage_id = arg_5_1
	}

	manager.net:SendWithLoadingNew(84212, var_5_0, 84213, function(arg_6_0)
		if isSuccess(arg_6_0.result) then
			getReward2(arg_6_0.item_list)
			TugGameData:UpdateStage(var_5_0)
			manager.notify:Invoke(ACTIVITY_KALI_INFO)

			local var_6_0 = {}

			for iter_6_0, iter_6_1 in ipairs(arg_6_0.item_list or {}) do
				table.insert(var_6_0, {
					iter_6_1.id,
					iter_6_1.num
				})
			end

			SDKTools.SendMessageToSDK("activity_combat_over", {
				result = 1,
				activity_id = arg_5_0,
				stage_id = arg_5_1,
				reward_list = var_6_0,
				use_seconds = arg_5_2 or 0
			})

			if callback then
				callback()
			end
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

manager.net:Bind(84221, function(arg_7_0)
	SpShooGameData:InitData(arg_7_0)
	manager.notify:Invoke(ACTIVITY_KALI_INFO)
end)

function var_0_0.SendShootGameResult(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {
		activity_id = arg_8_0,
		score = arg_8_1
	}

	manager.net:SendWithLoadingNew(84222, var_8_0, 84223, function(arg_9_0)
		if isSuccess(arg_9_0.result) then
			getReward2(arg_9_0.item_list)
			SpShooGameData:UpdateStage(var_8_0, arg_9_0.item_list)
			manager.notify:Invoke(ACTIVITY_KALI_INFO)

			if arg_8_2 then
				arg_8_2(arg_9_0)
			end
		else
			ShowTips(arg_9_0.result)
		end
	end)
end

return var_0_0
