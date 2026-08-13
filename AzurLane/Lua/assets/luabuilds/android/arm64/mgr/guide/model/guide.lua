class = var_0_10000

local var_0_0 = var_0_10000("Guide")

function var_0_0.Data2GuideStep(arg_1_0, arg_1_1)
	if arg_1_1.hideui then
		GuideHideUIStep = var_2

		return var_2.New(arg_1_1)
	elseif arg_1_1.stories then
		GuideStoryStep = var_2

		return var_2.New(arg_1_1)
	elseif arg_1_1.notifies then
		GuideSendNotifiesStep = var_2

		return var_2.New(arg_1_1)
	elseif arg_1_1.showSign then
		GuideShowSignStep = var_2

		return var_2.New(arg_1_1)
	elseif arg_1_1.doFunc then
		GuideDoFunctionStep = var_2

		return var_2.New(arg_1_1)
	elseif arg_1_1.ui then
		GuideFindUIStep = var_2

		return var_2.New(arg_1_1)
	else
		GuideDoNothingStep = var_2

		return var_2.New(arg_1_1)
	end

	return
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.steps = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1.events) do
		if arg_2_1.isWorld ~= nil then
			iter_2_1.isWorld = arg_2_1.isWorld
		end

		local var_2_0 = arg_2_0:Data2GuideStep(iter_2_1)

		table = var_1_10008

		var_1_10008.insert(arg_2_0.steps, var_2_0)
	end

	return
end

function var_0_0.GetStepsWithCode(arg_3_0, arg_3_1)
	local var_3_0 = {}

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0.steps) do
		if not arg_3_1 or iter_3_1:IsMatchWithCode(arg_3_1) then
			table = var_1_10008

			var_1_10008.insert(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

return var_0_0
