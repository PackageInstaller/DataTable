class = var_0_10000

local var_0_0 = "MainRankBtn4Mellow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainRankBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_1:Find("root/Image")
	local var_1_1 = var_3.GetComponent

	typeof = var_5
	Image = var_6
	arg_1_0.rankImage = var_1_1(var_1_0, var_5(var_6))

	return
end

function var_0_1.Flush(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.IsActive(var_2_0)

	setActive = var_2_0

	local var_2_2 = arg_2_0._tf

	var_2_0(var_3.Find(var_2_2, "root/lock"), not var_2_1)

	if var_2_1 then
		Color = var_2_0

		if not var_2_0(1, 1, 1, 1) then
			Color = var_2_0
			var_2_0 = var_2_0(0.3, 0.3, 0.3, 1)
		end

		arg_2_0.rankImage.color = var_2_0

		return
	end
end

return var_0_1
