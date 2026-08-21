local var_0_0 = singletonClass("AdvanceMonsterTestData")

function var_0_0.Init(arg_1_0)
	arg_1_0.curStage_ = 0
	arg_1_0.stageData_ = {}
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.curStage_ = arg_2_1.last_stage

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.stage_list) do
		arg_2_0.stageData_[iter_2_1.stage_id] = {
			score = iter_2_1.score,
			affixList = cleanProtoTable(iter_2_1.affix_list)
		}
	end
end

function var_0_0.GetStagePoint(arg_3_0, arg_3_1)
	if arg_3_0.stageData_[arg_3_1] then
		return arg_3_0.stageData_[arg_3_1].score
	else
		return 0
	end
end

function var_0_0.GetCustomList(arg_4_0, arg_4_1)
	if arg_4_0.stageData_[arg_4_1] then
		return arg_4_0.stageData_[arg_4_1].affixList
	else
		return {}
	end
end

function var_0_0.SaveCustomList(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.stageData_[arg_5_1] then
		arg_5_0.stageData_[arg_5_1].affixList = deepClone(arg_5_2)
	else
		arg_5_0.stageData_[arg_5_1] = {
			score = 0,
			affixList = deepClone(arg_5_2)
		}
	end
end

function var_0_0.GetCurStageID(arg_6_0)
	return arg_6_0.curStage_
end

function var_0_0.SetCurStageID(arg_7_0, arg_7_1)
	arg_7_0.curStage_ = arg_7_1
end

return var_0_0
