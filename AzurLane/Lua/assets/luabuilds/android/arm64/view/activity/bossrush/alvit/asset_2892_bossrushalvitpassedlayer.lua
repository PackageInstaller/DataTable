class = var_0_10000

local var_0_0 = "BossRushAlvitPassedLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.BossRush.BossRushPassedCombatLoadLayer"))

var_0_1.GROW_TIME = 0.55

function var_0_1.getUIName(arg_1_0)
	return "BossRushAlvitPassedUI"
end

function var_0_1.didEnter(arg_2_0)
	var_0_1.super.didEnter(arg_2_0)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "Image")

	math = var_1_10002

	local var_2_2 = var_1_10002.random(1, var_2_1.childCount)

	eachChild = var_2_0

	var_2_0(var_2_1, function(arg_3_0)
		setActive = var_2_10001

		local var_3_0 = arg_3_0

		tonumber = var_2_10004

		var_2_10001(var_3_0, var_2_10004(arg_3_0.name) == var_2_2)

		return
	end)

	return
end

return var_0_1
