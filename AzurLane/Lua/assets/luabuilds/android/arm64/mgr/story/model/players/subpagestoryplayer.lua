class = var_0_10000

local var_0_0 = "SubPageStoryPlayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".StoryPlayer"))

function var_0_1.OnEnter(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.OpenPage(var_2_0, arg_1_1, arg_2_0)

			return
		end
	}, arg_1_3)

	return
end

function var_0_1.OpenPage(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1:GetSubPageCls().New

	pg = var_1_10006
	arg_3_0.page = var_3_0(var_1_10006.NewStoryMgr.GetInstance()._tf)

	local var_3_1 = arg_3_0.page

	var_4.ExecuteAction(var_3_1, "Show", arg_3_2)

	return
end

function var_0_1.RegisetEvent(arg_4_0, arg_4_1, arg_4_2)
	var_0_1.super.RegisetEvent(arg_4_0, arg_4_1, arg_4_2)

	if arg_4_0.page then
		local var_4_0 = arg_4_0.page

		var_3.Destroy(var_4_0)
	end

	arg_4_0.page = nil
	triggerButton = var_3

	var_3(arg_4_0._go)

	return
end

return var_0_1
