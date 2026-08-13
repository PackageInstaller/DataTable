class = var_0_10000

local var_0_0 = "XimuLoginPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.LoginTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.items2 = var_1.Find(var_1_0, "items2")

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	var_0_1.super.OnUpdateFlush(arg_2_0)

	removeAllChildren = var_1

	var_1(arg_2_0.items2)

	eachChild = var_1

	var_1(arg_2_0.items, function(arg_3_0)
		local var_3_0 = arg_3_0
		local var_3_1 = arg_3_0.Find(var_3_0, "day/Text")

		setText = var_3_0

		local var_3_2 = var_3_1

		setColorStr = var_2_10004
		getText = var_2_10005

		local var_3_3 = var_2_10005(var_3_1)

		if arg_3_0:GetSiblingIndex() < arg_2_0.nday then
			COLOR_GREY = var_6

			if not var_6 then
				COLOR_WHITE = var_6
			end

			var_3_0(var_3_2, var_2_10004(var_3_3, var_6))

			return
		end
	end)

	for iter_2_0 = arg_2_0.Day, 4, -1 do
		local var_2_0 = arg_2_0.items
		local var_2_1 = var_5.GetChild(var_2_0, iter_2_0 - 1)

		setParent = var_2_0

		var_2_0(var_2_1, arg_2_0.items2, false)
		var_2_1:SetAsFirstSibling()
	end

	return
end

return var_0_1
