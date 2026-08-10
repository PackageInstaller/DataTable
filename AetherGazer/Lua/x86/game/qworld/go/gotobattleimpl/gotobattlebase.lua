local var_0_0 = class("GotoBattleBase")

function var_0_0.GetStageType(arg_1_0)
	return arg_1_0.stageType or 0
end

function var_0_0.GetStageId(arg_2_0)
	return arg_2_0.stageId or 0
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	arg_3_0.stageType = arg_3_1
end

function var_0_0.OnEnter(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.stageType = arg_4_1[1]
	arg_4_0.stageId = arg_4_1[2]

	arg_4_0:LaunchBattle()
end

function var_0_0.LaunchBattle(arg_5_0)
	local var_5_0 = arg_5_0:GetStageData()

	BattleController.GetInstance():LaunchBattle(var_5_0)
end

function var_0_0.GetStageData(arg_6_0)
	return BattleStageFactory.Produce(arg_6_0:GetStageType(), arg_6_0:GetStageId())
end

return var_0_0
