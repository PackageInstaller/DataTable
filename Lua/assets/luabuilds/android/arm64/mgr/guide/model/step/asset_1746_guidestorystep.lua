local GuideStoryStep = class("GuideStoryStep", import(".GuideStep"))

function GuideStoryStep:Ctor(arg_1_1)
	GuideStoryStep.super.Ctor(self, arg_1_1)

	self.stories = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.stories) do
		table.insert(self.stories, iter_1_1)
	end

	return
end

function GuideStoryStep:GetType()
	return GuideStep.TYPE_STORY
end

function GuideStoryStep:GetStories()
	return self.stories
end

return GuideStoryStep
