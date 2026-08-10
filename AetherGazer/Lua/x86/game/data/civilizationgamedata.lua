local var_0_0 = singletonClass("CivilizationGameData")
local var_0_1 = {}

function var_0_0.Init(arg_1_0)
	var_0_1:Init()
end

function var_0_0.GetDataByPara(arg_2_0, arg_2_1)
	return var_0_1[arg_2_1]
end

function var_0_0.InitServerData(arg_3_0, arg_3_1)
	var_0_1:InitServerData(arg_3_1)
end

function var_0_0.UpdateStageData(arg_4_0, arg_4_1)
	var_0_1:UpdateStageData(arg_4_1)
end

function var_0_0.UpdateData(arg_5_0, arg_5_1, arg_5_2)
	var_0_1:UpdateData(arg_5_1, arg_5_2)
end

function var_0_1.Init(arg_6_0)
	arg_6_0.stageDataTable = {}
end

function var_0_1.InitServerData(arg_7_0, arg_7_1)
	arg_7_0.activityId = arg_7_1.activity_id
	arg_7_0.finishStage = arg_7_1.stage_list
	arg_7_0.illu_list = arg_7_1.illustrations_list
end

function var_0_1.UpdateStageData(arg_8_0, arg_8_1)
	if arg_8_1.score then
		arg_8_0.score = math.max(arg_8_1.score, arg_8_0.score or 0)
	end

	arg_8_0.stageDataTable[arg_8_1.reward_id] = true
end

function var_0_1.UpdateData(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 and not table.indexof(arg_9_0.stage_list, arg_9_2) then
		table.insert(arg_9_0.stage_list, arg_9_2)
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if not table.indexof(arg_9_0.illu_list, iter_9_1) then
			table.insert(arg_9_0.illu_list, iter_9_1)
		end
	end
end

return var_0_0
