class = var_0_10000

local var_0_0 = "MainActBossSingleBtn"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainBaseActivityBtn"))

function var_0_1.GetEventName(arg_1_0)
	return "event_boss_single"
end

function var_0_1.GetActivity(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.getActivitiesByType

	ActivityConst = var_1_10003

	local var_2_2 = var_2_1(var_2_0, var_1_10003.ACTIVITY_TYPE_BOSSSINGLE)

	_ = var_2_0

	return (var_2_0.detect(var_2_2, function(arg_3_0)
		return not arg_3_0:isEnd()
	end))
end

function var_0_1.GetActivityID(arg_4_0)
	return arg_4_0:GetActivity() and var_1.id
end

function var_0_1.OnInit(arg_5_0)
	setActive = var_1_10001

	var_1_10001(arg_5_0.tipTr.gameObject, arg_5_0:IsShowTip())

	return
end

function var_0_1.CustomOnClick(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.m02
	local var_6_1 = var_1.sendNotification

	GAME = var_1_10003

	local var_6_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	var_6_1(var_6_0, var_6_2, var_1_10004.OTHERWORLD_MAP)

	return
end

function var_0_1.IsShowTip(arg_7_0)
	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.GetActivityID(var_7_0)

	ActivityConst = var_7_0

	if var_7_1 == var_7_0.OTHER_WORLD_TERMINAL_BATTLE_ID then
		OtherworldMapScene = var_7_1

		return var_7_1.IsShowTip()
	end

	return false
end

return var_0_1
