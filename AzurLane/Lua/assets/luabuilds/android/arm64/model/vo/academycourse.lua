class = var_0_10000

local var_0_0 = "AcademyCourse"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.MaxStudyTime = 43200

function var_0_1.Ctor(arg_1_0)
	arg_1_0.proficiency = 0

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.class_upgrade_group
end

function var_0_1.getConfig(arg_3_0, arg_3_1)
	pg = var_1_10002

	local var_3_0 = var_1_10002.TimeMgr.GetInstance()
	local var_3_1 = var_2.GetServerWeek(var_3_0)

	return arg_3_0:bindConfigTable()[var_3_1][arg_3_1]
end

function var_0_1.update(arg_4_0, arg_4_1)
	arg_4_0.proficiency = arg_4_1.proficiency

	return
end

function var_0_1.GetProficiency(arg_5_0)
	return arg_5_0.proficiency
end

function var_0_1.getExtraRate(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerWeek(var_6_0) == 7 and 2 or 1
end

function var_0_1.SetProficiency(arg_7_0, arg_7_1)
	arg_7_0.proficiency = arg_7_1

	return
end

return var_0_1
