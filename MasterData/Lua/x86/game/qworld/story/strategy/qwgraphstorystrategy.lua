QWBaseStoryStrategy = import("game.qworld.story.strategy.BaseStoryStrategy")

local QWGraphStoryStrategy = class("QWGraphStoryStrategy", QWBaseStoryStrategy)

function QWGraphStoryStrategy:OnInit()
	self.graphInstance = nil
end

function QWGraphStoryStrategy:OnStartStory(arg_2_1)
	self.graphInstance = import("game.qworld.generated.story." .. arg_2_1).New()

	if self.graphInstance then
		self.graphInstance:Start()
	else
		Debug.LogError("不存在的故事图: " .. arg_2_1)
	end
end

function QWGraphStoryStrategy:OnEndStory()
	if self.graphInstance then
		self.graphInstance:OnStopStory()

		self.graphInstance = nil
	end
end

function QWGraphStoryStrategy:PreContinueStop()
	if self.graphInstance then
		self.graphInstance:PreContinueStop()

		self.graphInstance = nil
	end
end

function QWGraphStoryStrategy:GetStoryHistory()
	if self.graphInstance then
		return self.graphInstance:GetHistory()
	end

	return {}
end

function QWGraphStoryStrategy:ChangeAutoPlayState(arg_6_1)
	if self.graphInstance then
		self.graphInstance:ChangeAutoPlayState(arg_6_1)
	end
end

function QWGraphStoryStrategy:GetAutoPlayState()
	if self.graphInstance then
		return self.graphInstance:GetAutoPlayState()
	end
end

function QWGraphStoryStrategy:Dispose()
	if self.graphInstance then
		self.graphInstance:PreContinueStop()

		self.graphInstance = nil
	end
end

return QWGraphStoryStrategy
