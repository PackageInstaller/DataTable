local MetaCharacterTask = class("MetaCharacterTask")

MetaCharacterTask.STATE_EMPTY = 1
MetaCharacterTask.STATE_START = 2
MetaCharacterTask.STATE_FINISHED = 3
MetaCharacterTask.STATE_SUBMITED = 4

function MetaCharacterTask:Ctor(arg_1_1)
	self.taskId = arg_1_1.taskId
	self.star = arg_1_1.star
	self.level = arg_1_1.level
	self.skillId = arg_1_1.skillId
	self.isLearned = false
	self.prevTask = arg_1_1.prev
	self.indexOfTaskList = arg_1_1.indexofList

	return
end

function MetaCharacterTask:setIsLearned()
	self.isLearned = true

	return
end

function MetaCharacterTask:isLearnedTask()
	return self.isLearned
end

function MetaCharacterTask:CanFetch(arg_4_1)
	return arg_4_1:getConfig("star") >= self.star and arg_4_1.level >= self.level
end

function MetaCharacterTask:GetTask()
	if self:isLearnedTask() then
		return Task.New({
			submitTime = 1,
			id = self.taskId
		})
	else
		local var_5_0 = getProxy(TaskProxy):getTaskById(self.taskId)

		var_5_0 = var_5_0 or Task.New({
			id = self.taskId
		})

		return var_5_0
	end

	return
end

function MetaCharacterTask:GetDesc()
	if self.isLearned then
		return i18n("meta_learn_skill", pg.skill_data_template[self.skillId].name)
	else
		return i18n1(pg.skill_data_template[self.skillId].name .. "Lv+1")
	end

	return
end

function MetaCharacterTask:GetState()
	local var_7_0 = getProxy(TaskProxy):getTaskVO(self.taskId)

	if not var_7_0 then
		if self:isLearnedTask() then
			return MetaCharacterTask.STATE_SUBMITED
		else
			return MetaCharacterTask.STATE_EMPTY
		end
	else
		local var_7_1 = var_7_0:isFinish()
		local var_7_2 = var_7_0:isReceive()

		if var_7_1 and var_7_2 then
			return MetaCharacterTask.STATE_SUBMITED
		elseif var_7_1 and not var_7_2 then
			return MetaCharacterTask.STATE_FINISHED
		else
			return MetaCharacterTask.STATE_START
		end
	end

	return
end

return MetaCharacterTask
