local var_0_0 = class("MainFdConcealablePanel", import(".MainConcealablePanel"))

function var_0_0.FillEmptySlot(arg_1_0, arg_1_1)
	for iter_1_0 = 1, #arg_1_1 do
		arg_1_1[iter_1_0].localPosition = arg_1_0.initPosition[iter_1_0]
	end

	return
end

return var_0_0
