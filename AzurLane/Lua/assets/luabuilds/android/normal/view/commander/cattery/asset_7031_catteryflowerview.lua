class = var_0_10000

local var_0_0 = var_0_10000("CatteryFlowerView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.default = var_2.Find(var_1_0, "1")

	local var_1_1 = {}
	local var_1_2 = arg_1_0._tf

	var_1_1[1] = var_3.Find(var_1_2, "2")

	local var_1_3 = arg_1_0._tf

	var_1_1[2] = var_3.Find(var_1_3, "3")

	local var_1_4 = arg_1_0._tf

	var_1_1[3] = var_3.Find(var_1_4, "4")

	local var_1_5 = arg_1_0._tf

	var_1_1[4] = var_3.Find(var_1_5, "5")
	arg_1_0.levels = var_1_1

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:GetCleanLevel()
	local var_2_1 = true

	pairs = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10004(arg_2_0.levels) do
		local var_2_2 = var_2_0 == iter_2_0

		setActive = var_1_10010

		var_1_10010(iter_2_1, var_2_2)

		if var_2_1 and var_2_2 then
			var_2_1 = false
		end
	end

	setActive = var_4

	var_4(arg_2_0.default, var_2_1)

	return
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0.levels = nil

	return
end

return var_0_0
