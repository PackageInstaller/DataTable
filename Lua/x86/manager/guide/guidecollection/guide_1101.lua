local var_0_0 = class("Guide_1101", BaseGuide)

function var_0_0.InitSteps(arg_1_0)
	local var_1_0 = {}

	arg_1_0:OnGuideStart()

	if MythicData:IsShowDifficultySelectView_Guide() then
		table.insert(var_1_0, 1104)
	end

	table.insert(var_1_0, 1105)

	local var_1_1 = 1
	local var_1_2 = arg_1_0._cfg.leaps

	for iter_1_0, iter_1_1 in ipairs(var_1_2) do
		local var_1_3 = iter_1_1[1]
		local var_1_4 = iter_1_1[2]

		if GuideTool.SatisfyCondition({
			{
				"uiName",
				var_1_3
			}
		}) then
			var_1_1 = var_1_4
		end
	end

	arg_1_0._steps = {}

	local var_1_5 = #var_1_0

	for iter_1_2 = var_1_1, var_1_5 do
		local var_1_6 = var_1_0[iter_1_2]
		local var_1_7 = arg_1_0:ProduceStep(var_1_6)

		if var_1_7 then
			table.insert(arg_1_0._steps, var_1_7)
		end
	end
end

return var_0_0
