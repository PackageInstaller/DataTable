SPKailiChallengeDataTemplate = class("SPKailiChallengeDataTemplate")

function SPHeroChallengeActivityTemplate.Ctor(arg_1_0, arg_1_1)
	arg_1_0.activityID = arg_1_1.activity_id
end

function SPHeroChallengeActivityTemplate.InitTrainInfo(arg_2_0, arg_2_1)
	arg_2_0.trainInfo = {}

	if arg_2_1 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			local var_2_0 = SPHeroChallengeAction:ParseTrainInfo(iter_2_1)

			arg_2_0.trainInfo[var_2_0.type] = var_2_0
		end
	end

	for iter_2_2 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
		if not arg_2_0.trainInfo[iter_2_2] then
			arg_2_0.trainInfo[iter_2_2] = SPHeroChallengeAction:ParseTrainInfo(nil, iter_2_2)
		end
	end
end
