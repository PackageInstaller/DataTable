local var_0_0 = {}

manager.net:Bind(87003, function(arg_1_0)
	local var_1_0 = GodEaterData.hubLv
	local var_1_1 = GodEaterData.init

	GodEaterData:UpdateData(arg_1_0)

	local var_1_2 = GodEaterData.hubLv

	if var_1_0 ~= var_1_2 and var_1_1 then
		JumpTools.OpenPageByJump("ActivityGodEaterLvUpView", {
			lastlV = var_1_0,
			nowlV = var_1_2
		})
	end

	manager.notify:Invoke(ACTIVITY_GODEATER_LV_INFO)
end)

function var_0_0.DrawHudReward(arg_2_0)
	local var_2_0 = {
		activity_id = arg_2_0
	}

	manager.net:SendWithLoadingNew(87004, var_2_0, 87005, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			getReward2(arg_3_0.reward_list)

			if callback then
				callback()
			end
		else
			ShowTips(arg_3_0.result)
		end
	end)
end

manager.net:Bind(87007, function(arg_4_0)
	GodEaterData:InitGoldMinerData(arg_4_0)
end)

function var_0_0.GoldMinerChangeHero(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {
		activity_id = arg_5_0,
		role_id = arg_5_1
	}

	manager.net:SendWithLoadingNew(87010, var_5_0, 87011, function(arg_6_0)
		if isSuccess(arg_6_0.result) then
			if arg_5_2 then
				arg_5_2()
			end
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

function var_0_0.GoldMinerFinishStage(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_3) do
		if var_7_0[iter_7_1] then
			var_7_0[iter_7_1] = var_7_0[iter_7_1] + 1
		else
			var_7_0[iter_7_1] = 1
		end
	end

	local var_7_1 = {}

	for iter_7_2, iter_7_3 in pairs(var_7_0) do
		table.insert(var_7_1, {
			item_id = iter_7_2,
			num = iter_7_3
		})
	end

	local var_7_2 = {
		activity_id = arg_7_0,
		stage_id = arg_7_1,
		star = arg_7_2,
		prop_list = var_7_1
	}

	manager.net:SendWithLoadingNew(87008, var_7_2, 87009, function(arg_8_0, arg_8_1)
		if isSuccess(arg_8_0.result) then
			if arg_7_4 then
				arg_7_4(arg_8_0, arg_8_1)
			end
		else
			ShowTips(arg_8_0.result)
		end
	end)
end

manager.net:Bind(87013, function(arg_9_0)
	GodEaterData:SetHeroGiftData(arg_9_0)
end)

function var_0_0.UpdateRedPoint()
	GodEaterData:UpdateRedPoint(GodEaterData.activityID)
end

return var_0_0
