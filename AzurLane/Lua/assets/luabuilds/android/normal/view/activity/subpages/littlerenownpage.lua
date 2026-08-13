class = var_0_10000

local var_0_0 = "LittleRenownPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.heartTpl = var_1.Find(var_1_0, "HeartTpl")

	local var_1_1 = arg_1_0.bg

	arg_1_0.heartContainer = var_1.Find(var_1_1, "HeartContainer")
	UIItemList = var_1
	arg_1_0.heartUIItemList = var_1.New(arg_1_0.heartContainer, arg_1_0.heartTpl)

	local var_1_2 = arg_1_0.heartUIItemList

	var_1.make(var_1_2, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_2_1 + 1
			local var_2_1 = arg_1_0.ptData
			local var_2_2 = var_4.GetLevelProgress(var_2_1)
			local var_2_3 = arg_2_2
			local var_2_4 = arg_2_2.Find(var_2_3, "Full")

			setActive = var_2_3

			var_2_3(var_2_4, not (var_2_2 < var_2_0))
		end

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	var_0_1.super.OnUpdateFlush(arg_3_0)

	local var_3_0 = arg_3_0.ptData
	local var_3_1, var_3_2 = var_1.GetLevelProgress(var_3_0)
	local var_3_3 = arg_3_0.heartUIItemList

	var_3.align(var_3_3, var_3_2)

	return
end

return var_0_1
