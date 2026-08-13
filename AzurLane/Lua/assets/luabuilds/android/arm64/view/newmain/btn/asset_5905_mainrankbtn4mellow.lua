class = var_0_10000

local var_0_0 = "MainRankBtn4Mellow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainRankBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_1:Find("root/Image")
	local var_1_1 = var_3.GetComponent

	typeof = var_6
	Image = var_1_10008
	arg_1_0.rankImage = var_1_1(var_1_0, var_6(var_1_10008))

	return
end

function var_0_1.Flush(arg_2_0)
	local var_2_0 = arg_2_0:IsActive()

	setActive = var_1_10002

	local var_2_1 = arg_2_0._tf

	var_1_10002(var_4.Find(var_2_1, "root/lock"), not var_2_0)

	if var_2_0 then
		Color = var_1_10002

		if not var_1_10002(1, 1, 1, 1) then
			Color = var_1_10002
			var_1_10002 = var_1_10002(0.3, 0.3, 0.3, 1)
		end

		arg_2_0.rankImage.color = var_1_10002

		return
	end
end

return var_0_1
