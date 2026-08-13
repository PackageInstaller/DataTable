class = var_0_10000

local var_0_0 = "MainActBossRushBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_series"
end

function var_0_1.GetActivity(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.GetBossRushActivities(var_2_0, false)

	_ = var_2_0

	return (var_2_0.detect(var_2_1, function(arg_3_0)
		return not arg_3_0:isEnd()
	end))
end

function var_0_1.GetActivityID(arg_4_0)
	return arg_4_0:GetActivity() and var_1.id
end

function var_0_1.OnInit(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0.tipTr.gameObject, false)

	if not arg_5_0.config.text_pic or arg_5_0.config.text_pic == "" then
		arg_5_0.hideSubImg = false

		local var_5_0 = arg_5_0._tf
		local var_5_1 = var_1.Find(var_5_0, "Image")

		Vector2 = var_5_0
		var_5_1.anchoredPosition = var_5_0(120, -405)
	end

	return
end

function var_0_1.CustomOnClick(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.m02
	local var_6_1 = var_1.sendNotification

	GAME = var_1_10003

	local var_6_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_6_1(var_6_0, var_6_2, var_1_10004.BOSSRUSH_MAIN)

	return
end

return var_0_1
