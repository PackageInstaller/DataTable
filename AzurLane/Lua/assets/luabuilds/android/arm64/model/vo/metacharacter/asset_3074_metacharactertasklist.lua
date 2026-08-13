class = var_0_10000

local var_0_0 = "MetaCharacterTaskList"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.skillId = arg_1_0:getConfig("skill_ID")
	arg_1_0.taskList = {}

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.getConfig(var_1_0, "skill_levelup_task")
	local var_1_2

	ipairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0(var_1_1) do
		MetaCharacterTask = var_1_10009
		var_1_10009 = var_1_10009.New({
			taskId = iter_1_1[1],
			star = iter_1_1[2],
			level = iter_1_1[3],
			skillId = arg_1_0.skillId,
			prev = var_1_2,
			indexofList = iter_1_0
		})
		table = var_1_10010

		var_1_10010.insert(arg_1_0.taskList, var_1_10009)

		var_1_2 = var_1_10009
	end

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.ship_meta_skilltask
end

function var_0_1.getTaskList(arg_3_0)
	return arg_3_0.taskList
end

function var_0_1.getSkillId(arg_4_0)
	return arg_4_0.skillId
end

function var_0_1.getTaskByTaskId(arg_5_0, arg_5_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_5_0.taskList, function(arg_6_0)
		return arg_5_1 == arg_6_0.id
	end)
end

return var_0_1
