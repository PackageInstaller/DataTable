class = var_0_10000

local var_0_0 = "RoyalFortunePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0.bg

	arg_1_0.painting = var_1.Find(var_1_0, "painting")

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	var_0_1.super.OnUpdateFlush(arg_2_0)

	local var_2_0

	if arg_2_0:IsLastTaskFinish() then
		math = var_2_0
		var_2_0 = var_2_0.random(#arg_2_0.taskGroup)
		GetImageSpriteFromAtlasAsync = var_2

		var_2("ui/activityuipage/royalfortunepage_atlas", var_2_0, arg_2_0.painting)
	else
		GetImageSpriteFromAtlasAsync = var_2_0

		var_2_0("ui/activityuipage/royalfortunepage_atlas", arg_2_0.nday, arg_2_0.painting)
	end

	return
end

function var_0_1.IsLastTaskFinish(arg_3_0)
	if arg_3_0.nday ~= #arg_3_0.taskGroup then
		return false
	end

	local var_3_0 = arg_3_0.taskGroup[#arg_3_0.taskGroup]
	local var_3_1 = true

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(var_3_0) do
		local var_3_2 = arg_3_0.taskProxy
		local var_3_3 = var_8.getTaskVO(var_3_2, iter_3_1)

		if var_8.getTaskStatus(var_3_3) ~= 2 then
			var_3_1 = false
		end
	end

	return var_3_1
end

return var_0_1
