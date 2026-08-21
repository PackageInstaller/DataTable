local var_0_0 = class("Guide_17", BaseGuide)

function var_0_0.InitSteps(arg_1_0)
	local var_1_0 = {}

	arg_1_0:OnGuideStart()
	table.insert(var_1_0, 1702)
	table.insert(var_1_0, 1704)

	arg_1_0._steps = {}

	local var_1_1 = #var_1_0

	for iter_1_0 = 1, var_1_1 do
		local var_1_2 = var_1_0[iter_1_0]
		local var_1_3 = arg_1_0:ProduceStep(var_1_2)

		if var_1_3 then
			table.insert(arg_1_0._steps, var_1_3)
		end
	end
end

function var_0_0.CheckGuide(arg_2_0)
	local var_2_0 = GuideTool.SatisfyCondition(arg_2_0.open_condition)
	local var_2_1 = ActivityData:GetActivityIsOpen(240034) and not DrawData:GetNewbieChooseDrawFlag()

	return var_2_0 and var_2_1
end

return var_0_0
