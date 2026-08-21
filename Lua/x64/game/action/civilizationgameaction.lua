local var_0_0 = {}

manager.net:Bind(79511, function(arg_1_0)
	CivilizationGameData:InitServerData(arg_1_0)
end)

local function var_0_1(arg_2_0)
	local var_2_0 = {}

	for iter_2_0 = 0, arg_2_0.Count - 1 do
		table.insert(var_2_0, arg_2_0[iter_2_0])
	end

	return var_2_0
end

function var_0_0.GameOver(arg_3_0, arg_3_1)
	local var_3_0 = CivilizationGameTools.GetNewIlluList(arg_3_1)
	local var_3_1 = {
		activity_id = ActivityConst.ACTIVITY_CIVILIZATION,
		stage_id = arg_3_1.stageID,
		hero_id = arg_3_1.heroID,
		collect_skill = var_0_1(arg_3_1.techList),
		hero_materials = var_0_1(arg_3_1.hexList),
		illustrations_list = var_3_0,
		age = arg_3_1.age,
		sign = arg_3_0
	}

	manager.net:SendWithLoadingNew(79512, var_3_1, 79513, function(arg_4_0, arg_4_1)
		var_0_0.SendMessage(arg_3_1)
		var_0_0.GameOverCallBack(arg_4_0, arg_4_1)
	end)
end

function var_0_0.GameOverCallBack(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		CivilizationGameData:UpdateData(arg_5_1.illustrations_list, arg_5_1.stage_id, arg_5_1.sign)
		JumpTools.OpenPageByJump("/civilizationGameOverView", {
			isWin = arg_5_1.sign,
			stageID = arg_5_1.stage_id
		})
	else
		ShowTips(arg_5_0.result)
	end
end

function var_0_0.SendMessage(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {}
	local var_6_2 = var_0_1(arg_6_0.useSkillID)
	local var_6_3 = var_0_1(arg_6_0.useSkillNum)

	for iter_6_0 = 1, #var_6_2 do
		table.insert(var_6_1, {
			var_6_2[iter_6_0],
			var_6_3[iter_6_0]
		})
	end

	local var_6_4 = {
		activity_id = arg_6_0.activityID,
		stage_id = arg_6_0.stageID,
		result = arg_6_0.result,
		hero_id = arg_6_0.heroID,
		use_seconds = arg_6_0.seconds,
		sequence_id = arg_6_0.age,
		battle_times = arg_6_0.turn,
		point_list = table.toString(var_0_1(arg_6_0.gridList)),
		use_skill_list = table.toString(var_6_1),
		params_list = table.toString(var_0_1(arg_6_0.source)),
		skill_list = table.toString(var_0_1(arg_6_0.unlockSkill))
	}

	SDKTools.SendMessageToSDK("activity_combat_over", var_6_4)
end

return var_0_0
