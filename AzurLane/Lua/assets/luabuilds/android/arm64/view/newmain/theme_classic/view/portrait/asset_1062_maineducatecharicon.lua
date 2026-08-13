class = var_0_10000

local var_0_0 = "MainEducateCharIcon"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseIcon"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.iconTr = arg_1_1:Find("icon")

	local var_1_0 = arg_1_0.iconTr
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.iconImg = var_1_1(var_1_0, var_5(var_1_10007))

	return
end

function var_0_1.Load(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0.iconTr, true)

	GetImageSpriteFromAtlasAsync = var_1_10002

	var_1_10002("SquareIcon/" .. arg_2_1, "", arg_2_0.iconTr, true)

	return
end

function var_0_1.Unload(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0.iconTr, false)

	arg_3_0.iconImg.sprite = nil

	return
end

return var_0_1
