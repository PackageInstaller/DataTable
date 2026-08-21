local var_0_0 = class("ChallengeRogueAttributeValueData")

function var_0_0.ExportMethod(arg_1_0)
	return {
		"AttributeUpdate",
		"AttributeClearData",
		"AttributeGetValue",
		"AttributeMechanismSetValue"
	}
end

function var_0_0.Init(arg_2_0)
	arg_2_0.attributeList_ = {}
end

function var_0_0.AttributeUpdate(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1.attr_list) do
		local var_3_0 = iter_3_1.attr_id

		arg_3_0.attributeList_[var_3_0] = iter_3_1.value

		if var_3_0 == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.MECHANISM_VALUE or var_3_0 == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.MECHANISM_THRESHOLD_VALUE then
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
		end
	end
end

function var_0_0.AttributeGetValue(arg_4_0, arg_4_1)
	return arg_4_0.attributeList_[arg_4_1] or RogueTeamAttributeCfg[arg_4_1].default
end

function var_0_0.AttributeClearData(arg_5_0)
	arg_5_0.attributeList_ = {}
end

function var_0_0.AttributeMechanismSetValue(arg_6_0, arg_6_1)
	arg_6_0.attributeList_[ChallengeRogueTeamConst.ATTRIBUTE_ENUM.MECHANISM_VALUE] = arg_6_1
end

return var_0_0
