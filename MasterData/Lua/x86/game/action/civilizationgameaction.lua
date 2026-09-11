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
	manager.net:SendWithLoadingNew(79512, {
		activity_id = ActivityConst.ACTIVITY_CIVILIZATION,
		stage_id = arg_3_1.stageID,
		hero_id = arg_3_1.heroID,
		collect_skill = var_0_1(arg_3_1.techList),
		hero_materials = var_0_1(arg_3_1.hexList),
		illustrations_list = CivilizationGameTools.GetNewIlluList(arg_3_1),
		age = arg_3_1.age,
		sign = arg_3_0
	}, 79513, function(arg_4_0, arg_4_1)
		var_0_0.SendMessage(arg_3_1)
		var_0_0.GameOverCallBack(arg_4_0, arg_4_1)
	end)
end

function var_0_0:GameOverCallBack(arg_5_1)
	if isSuccess(self.result) then
		CivilizationGameData:UpdateData(arg_5_1.illustrations_list, arg_5_1.stage_id, arg_5_1.sign)
		JumpTools.OpenPageByJump("/civilizationGameOverView", {
			isWin = arg_5_1.sign,
			stageID = arg_5_1.stage_id
		})
	else
		ShowTips(self.result)
	end
end

function var_0_0:SendMessage()
	local var_6_1 = {}
	local var_6_2 = var_0_1(self.useSkillID)
	local var_6_3 = var_0_1(self.useSkillNum)

	for iter_6_0 = 1, #var_6_2 do
		table.insert(var_6_1, {
			var_6_2[iter_6_0],
			var_6_3[iter_6_0]
		})
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = self.activityID,
		stage_id = self.stageID,
		result = self.result,
		hero_id = self.heroID,
		use_seconds = self.seconds,
		sequence_id = self.age,
		battle_times = self.turn,
		point_list = table.toString(var_0_1(self.gridList)),
		use_skill_list = table.toString(var_6_1),
		params_list = table.toString(var_0_1(self.source)),
		skill_list = table.toString(var_0_1(self.unlockSkill))
	})
end

return var_0_0
