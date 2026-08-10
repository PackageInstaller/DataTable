local var_0_0 = class("Guide_514", BaseGuide)

function var_0_0.InitSteps(arg_1_0)
	local var_1_0 = {}

	arg_1_0:OnGuideStart()
	table.insert(var_1_0, 51401)
	table.insert(var_1_0, 51402)
	table.insert(var_1_0, 51403)
	table.insert(var_1_0, 51404)
	table.insert(var_1_0, 51405)
	table.insert(var_1_0, 51406)
	table.insert(var_1_0, 51407)

	if not table.keyof(ChipData:GetUnlockChipManagerIDList(), 6) then
		table.insert(var_1_0, 51408)
		table.insert(var_1_0, 51409)
		table.insert(var_1_0, 51410)
	end

	table.insert(var_1_0, 51411)
	table.insert(var_1_0, 51412)
	table.insert(var_1_0, 51413)

	if not table.keyof(ChipData:GetUnlockChipIDList(), 105) then
		table.insert(var_1_0, 51414)
	end

	table.insert(var_1_0, 51415)
	table.insert(var_1_0, 51416)
	table.insert(var_1_0, 51417)
	table.insert(var_1_0, 51418)
	table.insert(var_1_0, 51419)

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

return var_0_0
