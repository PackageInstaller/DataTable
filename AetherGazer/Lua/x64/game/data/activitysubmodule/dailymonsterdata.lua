local var_0_0 = singletonClass("DailyMonsterData")

function var_0_0.InitData(arg_1_0, arg_1_1)
	arg_1_0.activityId_ = arg_1_1.activity_id
	arg_1_0.benefitActivityId_ = 343725

	arg_1_0:InitOpenStage(arg_1_1.data)
end

function var_0_0.InitOpenStage(arg_2_0, arg_2_1)
	arg_2_0.openStage_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0.openStage_[iter_2_1.stage_id] = {
			firstPass = iter_2_1.first_pass
		}
	end
end

function var_0_0.GetActivityId(arg_3_0)
	return arg_3_0.activityId_
end

function var_0_0.GetBenefitActivityId(arg_4_0)
	return arg_4_0.benefitActivityId_
end

function var_0_0.GetOpenStage(arg_5_0)
	return arg_5_0.openStage_
end

function var_0_0.GetOpenStageById(arg_6_0, arg_6_1)
	return arg_6_0.openStage_[arg_6_1]
end

function var_0_0.UpdateStagePass(arg_7_0, arg_7_1)
	if arg_7_0.openStage_[arg_7_1] then
		arg_7_0.openStage_[arg_7_1].firstPass = 1
	end
end

function var_0_0.SetBattleType(arg_8_0, arg_8_1)
	arg_8_0.battleType_ = arg_8_1
end

function var_0_0.GetBattleType(arg_9_0)
	return arg_9_0.battleType_
end

return var_0_0
