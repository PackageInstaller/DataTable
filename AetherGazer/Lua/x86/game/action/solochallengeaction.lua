local var_0_0 = {
	initedConst = {}
}

manager.net:Bind(60031, function(arg_1_0)
	local var_1_0 = arg_1_0.info.challenge_id

	if not var_0_0.initedConst[var_1_0] then
		SoloChallengeTools.InitConst(var_1_0)

		var_0_0.initedConst[var_1_0] = true
	end

	SoloChallengeData:SetData(arg_1_0)
end)

function var_0_0.RequireReceive(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = ActivitySoloChallengeCfg[arg_2_0].stage_id[arg_2_1][1]
	local var_2_1 = {
		activity_id = arg_2_0,
		difficult = var_2_0
	}

	manager.net:SendWithLoadingNew(60034, var_2_1, 60035, function(arg_3_0)
		arg_2_2(arg_3_0)
	end)
end

function var_0_0.SaveDifficulty(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ActivitySoloChallengeCfg[arg_4_0].stage_id[arg_4_1][1]
	local var_4_1 = {
		activity_id = arg_4_0,
		difficult = var_4_0
	}

	manager.net:SendWithLoadingNew(60038, var_4_1, 60039, function(arg_5_0)
		if isSuccess(arg_5_0.result) then
			if arg_4_2 ~= nil then
				arg_4_2(arg_5_0, arg_4_0)
			end
		else
			ShowTips(arg_5_0.result)
		end
	end)
end

function var_0_0.ResetData(arg_6_0, arg_6_1)
	manager.net:SendWithLoadingNew(60036, {
		activity_id = arg_6_0
	}, 60037, function(arg_7_0)
		if isSuccess(arg_7_0.result) then
			if arg_6_1 ~= nil then
				arg_6_1(arg_7_0, arg_6_0)
			end
		else
			ShowTips(arg_7_0.result)
		end
	end)
end

function var_0_0.InitRedPoint(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(ActivityCfg[arg_8_0].sub_activity_list) do
		table.insert(var_8_0, string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, arg_8_0, iter_8_1))
	end

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.SOLO_CHALLENGE, arg_8_0), var_8_0)
end

function var_0_0.CloseRedPoint(arg_9_0)
	if ActivityData:GetActivityIsOpen(arg_9_0) then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(ActivityCfg[arg_9_0].sub_activity_list) do
		manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, arg_9_0, iter_9_1), 0)
	end
end

return var_0_0
