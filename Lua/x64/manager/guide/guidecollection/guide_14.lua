local var_0_0 = class("Guide_14", BaseGuide)

function var_0_0.InitSteps(arg_1_0)
	local var_1_0 = {}

	arg_1_0:OnGuideStart()
	table.insert(var_1_0, 1401)
	table.insert(var_1_0, 1402)
	table.insert(var_1_0, 1403)

	local var_1_1 = MatrixData:GetUnlockBeaconList()

	if var_1_1 and #var_1_1 == 0 then
		table.insert(var_1_0, 1404)
		table.insert(var_1_0, 1405)
		table.insert(var_1_0, 1406)
		table.insert(var_1_0, 1407)
	end

	table.insert(var_1_0, 1408)
	table.insert(var_1_0, 1409)
	table.insert(var_1_0, 1410)
	table.insert(var_1_0, 1411)
	table.insert(var_1_0, 1412)
	table.insert(var_1_0, 1413)
	table.insert(var_1_0, 1414)
	table.insert(var_1_0, 1415)

	local var_1_2 = 1
	local var_1_3 = arg_1_0._cfg.leaps

	for iter_1_0, iter_1_1 in ipairs(var_1_3) do
		local var_1_4 = iter_1_1[1]
		local var_1_5 = iter_1_1[2]

		if GuideTool.SatisfyCondition({
			{
				"uiName",
				var_1_4
			}
		}) then
			var_1_2 = var_1_5
		end
	end

	arg_1_0._steps = {}

	local var_1_6 = #var_1_0

	for iter_1_2 = var_1_2, var_1_6 do
		local var_1_7 = var_1_0[iter_1_2]
		local var_1_8 = arg_1_0:ProduceStep(var_1_7)

		if var_1_8 then
			table.insert(arg_1_0._steps, var_1_8)
		end
	end
end

return var_0_0
