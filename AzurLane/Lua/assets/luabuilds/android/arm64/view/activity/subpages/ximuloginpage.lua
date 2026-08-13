class = var_0_10000

local var_0_0 = "XimuLoginPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.LoginTemplatePage"))

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
		local var_3_0 = arg_3_0:Find("day/Text")

		setText = var_2_10002

		local var_3_1 = var_3_0

		setColorStr = var_2_10005
		getText = var_2_10007

		local var_3_2 = var_2_10007(var_3_0)

		if arg_3_0:GetSiblingIndex() < arg_2_0.nday then
			COLOR_GREY = var_8

			if not var_8 then
				COLOR_WHITE = var_8
			end

			var_2_10002(var_3_1, var_2_10005(var_3_2, var_8))

			return
		end
	end)

	for iter_2_0 = arg_2_0.Day, 4, -1 do
		local var_2_0 = arg_2_0.items
		local var_2_1 = var_5.GetChild(var_2_0, iter_2_0 - 1)

		setParent = var_1_10006

		var_1_10006(var_2_1, arg_2_0.items2, false)
		var_2_1:SetAsFirstSibling()
	end

	return
end

return var_0_1
