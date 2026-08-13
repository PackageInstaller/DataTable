class = var_0_10000

local var_0_0 = var_0_10000("MetaCharacterTask")

var_0_0.STATE_EMPTY = 1
var_0_0.STATE_START = 2
var_0_0.STATE_FINISHED = 3
var_0_0.STATE_SUBMITED = 4

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.taskId = arg_1_1.taskId
	arg_1_0.star = arg_1_1.star
	arg_1_0.level = arg_1_1.level
	arg_1_0.skillId = arg_1_1.skillId
	arg_1_0.isLearned = false
	arg_1_0.prevTask = arg_1_1.prev
	arg_1_0.indexOfTaskList = arg_1_1.indexofList

	return
end

function var_0_0.setIsLearned(arg_2_0)
	arg_2_0.isLearned = true

	return
end

function var_0_0.isLearnedTask(arg_3_0)
	return arg_3_0.isLearned
end

function var_0_0.CanFetch(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getConfig("star")
	local var_4_1 = arg_4_1.level

	return var_4_0 >= arg_4_0.star and var_4_1 >= arg_4_0.level
end

function var_0_0.GetTask(arg_5_0)
	local var_5_0 = arg_5_0

	if arg_5_0.isLearnedTask(var_5_0) then
		Task = var_1

		return var_1.New({
			submitTime = 1,
			id = arg_5_0.taskId
		})
	else
		getProxy = var_1
		TaskProxy = var_5_0

		local var_5_1 = var_1(var_5_0)
		local var_5_2

		if not var_1.getTaskById(var_5_1, arg_5_0.taskId) then
			Task = var_5_2
			var_5_2 = var_5_2.New({
				id = arg_5_0.taskId
			})
		end

		return var_5_2
	end

	return
end

function var_0_0.GetDesc(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.skill_data_template[arg_6_0.skillId]

	if arg_6_0.isLearned then
		i18n = var_2

		return var_2("meta_learn_skill", var_6_0.name)
	else
		i18n1 = var_2

		return var_2(var_6_0.name .. "Lv+1")
	end

	return
end

function var_0_0.GetState(arg_7_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)

	if not var_1.getTaskVO(var_7_0, arg_7_0.taskId) then
		if arg_7_0:isLearnedTask() then
			MetaCharacterTask = var_2

			return var_2.STATE_SUBMITED
		else
			MetaCharacterTask = var_2

			return var_2.STATE_EMPTY
		end
	else
		local var_7_1 = var_1:isFinish()
		local var_7_2 = var_1
		local var_7_3 = var_1.isReceive(var_7_2)

		if var_7_1 and var_7_3 then
			MetaCharacterTask = var_7_2

			return var_7_2.STATE_SUBMITED
		elseif var_7_1 and not var_7_3 then
			MetaCharacterTask = var_7_2

			return var_7_2.STATE_FINISHED
		else
			MetaCharacterTask = var_7_2

			return var_7_2.STATE_START
		end
	end

	return
end

return var_0_0
