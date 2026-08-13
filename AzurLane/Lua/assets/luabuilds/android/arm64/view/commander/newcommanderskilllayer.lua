class = var_0_10000

local var_0_0 = "NewCommanderSkillLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CommanderSkillLayer"))

function var_0_1.getUIName(arg_1_0)
	return "NewCommanderSkillUI"
end

function var_0_1.didEnter(arg_2_0)
	var_0_1.super.didEnter(arg_2_0)

	defaultValue = var_1
	arg_2_0.commonFlag = var_1(arg_2_0.contextData.commonFlag, true)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "panel/bg/tags")

	onToggle = var_1_10002

	local var_2_2 = arg_2_0
	local var_2_3 = var_2_1

	local function var_2_4(arg_3_0)
		arg_2_0.commonFlag = arg_3_0

		local var_3_0 = arg_2_0

		var_1.UpdateList(var_3_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_2_2, var_2_3, var_2_4, var_1_10007)

	triggerToggle = var_1_10002

	var_1_10002(var_2_1, arg_2_0.commonFlag)

	return
end

function var_0_1.SetLocaliza(arg_4_0)
	return
end

function var_0_1.GetColor(arg_5_0, arg_5_1)
	return arg_5_1 and "#66472a" or "#a3a2a2"
end

return var_0_1
