local var_0_0 = class("Guide_15", BaseGuide)

function var_0_0.InitSteps(arg_1_0)
	local var_1_0 = {}

	arg_1_0:OnGuideStart()
	table.insert(var_1_0, 1501)

	local var_1_1 = MatrixData:GetMatrixPhaseData()

	if var_1_1 and var_1_1:GetPhase() == 1 then
		table.insert(var_1_0, 1502)
	end

	arg_1_0._steps = {}

	local var_1_2 = #var_1_0

	for iter_1_0 = 1, var_1_2 do
		local var_1_3 = var_1_0[iter_1_0]
		local var_1_4 = arg_1_0:ProduceStep(var_1_3)

		if var_1_4 then
			table.insert(arg_1_0._steps, var_1_4)
		end
	end
end

return var_0_0
