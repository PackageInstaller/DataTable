local var_0_0 = class("ChallengeRogueTeamSuitSkillData")

function var_0_0.ExportMethod(arg_1_0)
	return {
		"SuitSkillSetValue",
		"SuitSkillGetID",
		"SuitSkillGetEnergyValue",
		"SuitSkillClear"
	}
end

function var_0_0.Init(arg_2_0)
	arg_2_0.suitSkillID_ = 0
	arg_2_0.energyValue_ = 0
end

function var_0_0.SuitSkillSetValue(arg_3_0, arg_3_1)
	arg_3_0.suitSkillID_ = arg_3_1.suitSkillID
	arg_3_0.energyValue_ = arg_3_1.energyValue
end

function var_0_0.SuitSkillGetID(arg_4_0)
	return arg_4_0.suitSkillID_
end

function var_0_0.SuitSkillGetEnergyValue(arg_5_0)
	return arg_5_0.energyValue_
end

function var_0_0.SuitSkillClear(arg_6_0)
	arg_6_0.suitSkillID_ = 0
	arg_6_0.energyValue_ = 0
end

return var_0_0
