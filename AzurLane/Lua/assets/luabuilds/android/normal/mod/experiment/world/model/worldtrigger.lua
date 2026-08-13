class = var_0_10000

local var_0_0 = "WorldTrigger"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	config = "table",
	progress = "number",
	id = "number",
	maxProgress = "number",
	desc = "string"
}

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1

	return
end

function var_0_1.GetProgress(arg_2_0)
	return arg_2_0.progress
end

function var_0_1.GetMaxProgress(arg_3_0)
	return arg_3_0.maxProgress
end

function var_0_1.GetDesc(arg_4_0)
	string = var_1_10001

	return var_1_10001.format("%s(%s/%s)", arg_4_0.desc, arg_4_0.progress, arg_4_0.maxProgress)
end

function var_0_1.IsAchieved(arg_5_0)
	return arg_5_0:GetProgress() >= arg_5_0:GetMaxProgress()
end

return var_0_1
