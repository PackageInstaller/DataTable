local var_0_0 = class("Guide")

function var_0_0.Data2GuideStep(arg_1_0, arg_1_1)
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

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.steps = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.events) do
		if arg_2_1.isWorld ~= nil then
			iter_2_1.isWorld = arg_2_1.isWorld
		end

		table.insert(arg_2_0.steps, (arg_2_0:Data2GuideStep(iter_2_1)))
	end

	return
end

function var_0_0.GetStepsWithCode(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.steps) do
		if not arg_3_1 or iter_3_1:IsMatchWithCode(arg_3_1) then
			table.insert({}, iter_3_1)
		end
	end

	return {}
end

return var_0_0
