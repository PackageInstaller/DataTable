class = var_0_10000

local var_0_0 = "MainLoveLetterDelegationBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseSpcailActBtn"))

function var_0_1.GetContainer(arg_1_0)
	local var_1_0 = arg_1_0.root.parent

	return var_1.Find(var_1_0, "eventPanel")
end

function var_0_1.InShowTime(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	return var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_LOVE_LETTER_UP) and not var_1:isEnd()
end

function var_0_1.GetUIName(arg_3_0)
	return "MainLoveLetterDelegationBtn"
end

function var_0_1.OnClick(arg_4_0)
	local var_4_0 = arg_4_0.event
	local var_4_1 = var_1.emit

	NewMainMediator = var_1_10004

	local var_4_2 = var_1_10004.GO_SCENE

	SCENE = var_1_10005

	var_4_1(var_4_0, var_4_2, var_1_10005.LOVE_LETTER_ACTIVITY)

	return
end

function var_0_1.OnInit(arg_5_0)
	return
end

function var_0_1.OnRegister(arg_6_0)
	return
end

function var_0_1.OnClear(arg_7_0)
	return
end

return var_0_1
