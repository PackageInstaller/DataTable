local var_0_0 = class("Guide_4601", BaseGuide)

function var_0_0.InitSteps(arg_1_0)
	local var_1_0 = {}

	arg_1_0:OnGuideStart()

	local var_1_1 = PolyhedronData:GetUnlockBeaconList()

	if var_1_1 and #var_1_1 == 0 then
		table.insert(var_1_0, 4605)
		table.insert(var_1_0, 4606)
		table.insert(var_1_0, 4607)
		table.insert(var_1_0, 4608)
	end

	table.insert(var_1_0, 4609)
	table.insert(var_1_0, 4610)
	table.insert(var_1_0, 4611)
	table.insert(var_1_0, 4612)

	local var_1_2 = PolyhedronData:GetUnlockHeroList()

	if var_1_2 and #var_1_2 <= 1 then
		table.insert(var_1_0, 4613)
		table.insert(var_1_0, 4614)
		table.insert(var_1_0, 4615)
		table.insert(var_1_0, 4616)
		table.insert(var_1_0, 4617)
	end

	table.insert(var_1_0, 4618)
	table.insert(var_1_0, 4619)
	table.insert(var_1_0, 4620)
	table.insert(var_1_0, 4621)

	local var_1_3 = 1
	local var_1_4 = arg_1_0._cfg.leaps

	for iter_1_0, iter_1_1 in ipairs(var_1_4) do
		local var_1_5 = iter_1_1[1]
		local var_1_6 = iter_1_1[2]

		if GuideTool.SatisfyCondition({
			{
				"uiName",
				var_1_5
			}
		}) then
			var_1_3 = var_1_6
		end
	end

	arg_1_0._steps = {}

	local var_1_7 = #var_1_0

	for iter_1_2 = var_1_3, var_1_7 do
		local var_1_8 = var_1_0[iter_1_2]
		local var_1_9 = arg_1_0:ProduceStep(var_1_8)

		if var_1_9 then
			table.insert(arg_1_0._steps, var_1_9)
		end
	end
end

return var_0_0
