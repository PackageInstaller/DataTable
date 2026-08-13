class = var_0_10000

local var_0_0 = "MainConcealablePanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBasePanel"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0.initPosition = {}
	ipairs = var_4

	for iter_1_0, iter_1_1 in var_4(arg_1_0.btns) do
		if not iter_1_1:IsFixed() then
			table = var_9

			var_9.insert(arg_1_0.initPosition, iter_1_1._tf.localPosition)
		end
	end

	arg_1_0.isChanged = false

	return
end

function var_0_1.Init(arg_2_0)
	var_0_1.super.Init(arg_2_0)
	arg_2_0:CalcLayout()

	return
end

function var_0_1.Refresh(arg_3_0)
	var_0_1.super.Refresh(arg_3_0)
	arg_3_0:CalcLayout()

	return
end

function var_0_1.CalcLayout(arg_4_0)
	local var_4_0 = {}

	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.btns) do
		if not iter_4_1:IsFixed() then
			isActive = var_7

			if var_7(iter_4_1._tf) then
				table = var_7

				var_7.insert(var_4_0, iter_4_1._tf)
			end
		end
	end

	if #var_4_0 >= #arg_4_0.initPosition and not arg_4_0.isChanged then
		return
	end

	arg_4_0:FillEmptySlot(var_4_0)

	arg_4_0.isChanged = not var_2

	return
end

function var_0_1.FillEmptySlot(arg_5_0, arg_5_1)
	local var_5_0 = #arg_5_0.initPosition

	for iter_5_0 = #arg_5_1, 1, -1 do
		arg_5_1[iter_5_0].localPosition = arg_5_0.initPosition[var_5_0]
		var_5_0 = var_5_0 - 1
	end

	return
end

return var_0_1
