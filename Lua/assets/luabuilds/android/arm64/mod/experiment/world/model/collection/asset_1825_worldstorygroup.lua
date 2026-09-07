local WorldStoryGroup = class("WorldStoryGroup")
local var_0_1 = pg.memory_group

function WorldStoryGroup:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = arg_1_1.id
	self.config = var_0_1[self.configId]

	assert(self.config)

	self.storyIds = self.config.memories

	return
end

function WorldStoryGroup:getStoryIds()
	return self.storyIds
end

return WorldStoryGroup
