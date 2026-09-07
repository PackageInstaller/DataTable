local Guide = class("Guide")

function Guide:Data2GuideStep(arg_1_1)
	if arg_1_1.hideui then
		return GuideHideUIStep.New(arg_1_1)
	elseif arg_1_1.stories then
		return GuideStoryStep.New(arg_1_1)
	elseif arg_1_1.notifies then
		return GuideSendNotifiesStep.New(arg_1_1)
	elseif arg_1_1.showSign then
		return GuideShowSignStep.New(arg_1_1)
	elseif arg_1_1.doFunc then
		return GuideDoFunctionStep.New(arg_1_1)
	elseif arg_1_1.ui then
		return GuideFindUIStep.New(arg_1_1)
	else
		return GuideDoNothingStep.New(arg_1_1)
	end

	return
end

function Guide:Ctor(arg_2_1)
	self.steps = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.events) do
		if arg_2_1.isWorld ~= nil then
			iter_2_1.isWorld = arg_2_1.isWorld
		end

		table.insert(self.steps, (self:Data2GuideStep(iter_2_1)))
	end

	return
end

function Guide:GetStepsWithCode(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self.steps) do
		if not arg_3_1 or iter_3_1:IsMatchWithCode(arg_3_1) then
			table.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

return Guide
