class = var_0_10000

local var_0_0 = "SelectSkinCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SkinAtlasCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0._tf

	arg_1_0.ownTr = var_2.Find(var_1_0, "own")

	local var_1_1 = arg_1_0._tf

	arg_1_0.timeLimitTr = var_2.Find(var_1_1, "timelimit")

	return
end

function var_0_1.Update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	var_0_1.super.Update(arg_2_0, arg_2_1, arg_2_2)

	isActive = var_5

	local var_2_0

	if not var_5(arg_2_0.usingTr) then
		isActive = var_2_0
		var_2_0 = var_2_0(arg_2_0.unavailableTr)
	end

	setAnchoredPosition = var_6

	var_6(arg_2_0.timeLimitTr, {
		y = var_2_0 and -40 or 0
	})

	setActive = var_6

	var_6(arg_2_0.timeLimitTr, arg_2_3)

	setActive = var_6

	var_6(arg_2_0.ownTr, arg_2_4)

	return
end

return var_0_1
