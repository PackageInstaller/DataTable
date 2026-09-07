local MetaCharacterTaskList = class("MetaCharacterTaskList", import("..BaseVO"))

function MetaCharacterTaskList:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.skillId = self:getConfig("skill_ID")
	self.taskList = {}

	for iter_1_0, iter_1_1 in ipairs((self:getConfig("skill_levelup_task"))) do
		table.insert(self.taskList, (MetaCharacterTask.New({
			taskId = iter_1_1[1],
			star = iter_1_1[2],
			level = iter_1_1[3],
			skillId = self.skillId,
			prev = nil,
			indexofList = iter_1_0
		})))
	end

	return
end

function MetaCharacterTaskList:bindConfigTable()
	return pg.ship_meta_skilltask
end

function MetaCharacterTaskList:getTaskList()
	return self.taskList
end

function MetaCharacterTaskList:getSkillId()
	return self.skillId
end

function MetaCharacterTaskList:getTaskByTaskId(arg_5_1)
	return _.detect(self.taskList, function(arg_6_0)
		return arg_5_1 == arg_6_0.id
	end)
end

return MetaCharacterTaskList
