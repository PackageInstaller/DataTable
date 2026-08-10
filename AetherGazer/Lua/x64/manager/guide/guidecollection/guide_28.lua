local var_0_0 = class("Guide_19", BaseGuide)

function var_0_0.InitSteps(arg_1_0)
	local var_1_0 = {}

	arg_1_0:OnGuideStart()

	if SkuldTravelData:GetSkuldStatu() == 2 then
		table.insert(var_1_0, 2801)
		table.insert(var_1_0, 2802)
		table.insert(var_1_0, 2803)
	end

	table.insert(var_1_0, 2804)
	table.insert(var_1_0, 2805)
	table.insert(var_1_0, 2806)
	table.insert(var_1_0, 2807)
	table.insert(var_1_0, 2808)
	table.insert(var_1_0, 2809)
	table.insert(var_1_0, 2810)

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
	if not GuideTool.SatisfyCondition(arg_2_0.open_condition) then
		return false
	end

	if SkuldTravelData:GetSkuldStatu() == 2 then
		return gameContext:GetOpenPageHandler("skuldTravelResultView") ~= nil
	else
		return gameContext:GetOpenPageHandler("skuldTravelView") ~= nil
	end
end

return var_0_0
