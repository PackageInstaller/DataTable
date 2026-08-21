local var_0_0 = class("BossRushAlvitPassedLayer", import("view.activity.BossRush.BossRushPassedCombatLoadLayer"))

var_0_0.GROW_TIME = 0.55

function var_0_0.getUIName(arg_1_0)
	return "BossRushAlvitPassedUI"
end

function var_0_0.didEnter(arg_2_0)
	var_0_0.super.didEnter(arg_2_0)

	local var_2_0 = arg_2_0._tf:Find("Image")
	local var_2_1 = math.random(1, var_2_0.childCount)

	eachChild(var_2_0, function(arg_3_0)
		setActive(arg_3_0, tonumber(arg_3_0.name) == var_2_1)

		return
	end)

	return
end

return var_0_0
