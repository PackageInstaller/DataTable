class = var_0_10000

local var_0_0 = "CygentSwimsuitPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	PoolMgr = var_1

	local var_1_0 = var_1.GetInstance()

	var_1.GetSpineChar(var_1_0, "xiaotiane_2", false, function(arg_2_0)
		local var_2_0 = arg_2_0.transform

		Vector3 = var_2_10002
		var_2_0.localScale = var_2_10002(0.7, 0.7, 1)

		local var_2_1 = arg_2_0.transform
		local var_2_2 = var_1.SetParent
		local var_2_3 = arg_1_0.bg

		var_2_2(var_2_1, var_4.Find(var_2_3, "char"), false)

		local var_2_4 = arg_2_0
		local var_2_5 = arg_2_0.GetComponent

		typeof = var_4
		SpineAnimUI = var_2_3

		local var_2_6 = var_2_5(var_2_4, var_4(var_2_3))

		var_1.SetAction(var_2_6, "stand", 0)

		arg_1_0.model = arg_2_0

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	var_0_1.super.OnUpdateFlush(arg_3_0)

	GetImageSpriteFromAtlasAsync = var_1

	local var_3_0 = "numbericon/t1/" .. arg_3_0.nday
	local var_3_1 = ""
	local var_3_2 = arg_3_0.bg

	var_1(var_3_0, var_3_1, var_5.Find(var_3_2, "day1"))

	setText = var_1

	local var_3_3 = arg_3_0.bg

	var_1(var_3.Find(var_3_3, "progress"), "進度:" .. arg_3_0.nday .. "/10")

	return
end

function var_0_1.OnDestroy(arg_4_0)
	var_0_1.super.OnDestroy(arg_4_0)

	if arg_4_0.model then
		local var_4_0 = arg_4_0.model.transform

		Vector3 = var_1_10002
		var_4_0.localScale = var_1_10002.one
		PoolMgr = var_4_0

		local var_4_1 = var_4_0.GetInstance()

		var_1.ReturnSpineChar(var_4_1, "xiaotiane_2", arg_4_0.model)

		arg_4_0.model = nil
	end

	return
end

return var_0_1
