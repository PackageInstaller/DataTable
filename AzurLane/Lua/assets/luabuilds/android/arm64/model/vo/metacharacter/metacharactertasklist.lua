local var_0_0 = class("MetaCharacterTaskList", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.skillId = arg_1_0:getConfig("skill_ID")
	arg_1_0.taskList = {}

	for iter_1_0, iter_1_1 in ipairs((arg_1_0:getConfig("skill_levelup_task"))) do
		local var_1_0 = MetaCharacterTask.New({
			taskId = iter_1_1[1],
			star = iter_1_1[2],
			level = iter_1_1[3],
			skillId = arg_1_0.skillId,
			prev = nil,
			indexofList = iter_1_0
		})

		table.insert(arg_1_0.taskList, var_1_0)
	end

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.ship_meta_skilltask
end

function var_0_0.getTaskList(arg_3_0)
	return arg_3_0.taskList
end

function var_0_0.getSkillId(arg_4_0)
	return arg_4_0.skillId
end

function var_0_0.getTaskByTaskId(arg_5_0, arg_5_1)
	return _.detect(arg_5_0.taskList, function(arg_6_0)
		return arg_5_1 == arg_6_0.id
	end)
end

return var_0_0
