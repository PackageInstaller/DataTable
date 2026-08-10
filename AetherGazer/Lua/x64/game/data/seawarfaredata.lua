local var_0_0 = singletonClass("SeaWarfareData")

function var_0_0.Init(arg_1_0)
	arg_1_0.completedStageDic_ = {}
	arg_1_0.unlockSkillDic_ = {}
end

function var_0_0.InitData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1.stage_id_list) do
		arg_2_0.completedStageDic_[iter_2_1] = true
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.affix) do
		arg_2_0.unlockSkillDic_[iter_2_3] = true
	end
end

function var_0_0.SetStageCompleted(arg_3_0, arg_3_1)
	arg_3_0.completedStageDic_[arg_3_1] = true
end

function var_0_0.IsStageCompleted(arg_4_0, arg_4_1)
	return arg_4_0.completedStageDic_[arg_4_1] == true
end

function var_0_0.IsSkilllock(arg_5_0, arg_5_1)
	return not arg_5_0.unlockSkillDic_[arg_5_1]
end

return var_0_0
