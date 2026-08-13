class = var_0_10000

local var_0_0 = "MainRankBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainBaseBtn"))

function var_0_1.OnClick(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.emit

	NewMainMediator = var_1_10004

	local var_1_2 = var_1_10004.GO_SCENE

	SCENE = var_1_10005

	local var_1_3 = var_1_10005.BILLBOARD
	local var_1_4 = {}

	PowerRank = var_1_10007
	var_1_4.index = var_1_10007.TYPE_POWER

	var_1_1(var_1_0, var_1_2, var_1_3, var_1_4)

	return
end

function var_0_1.Flush(arg_2_0)
	local var_2_0 = arg_2_0:IsActive()

	setActive = var_1_10002

	var_1_10002(arg_2_0._tf, var_2_0)

	return
end

function var_0_1.IsActive(arg_3_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.getRawData(var_3_0).level

	pg = var_3_0

	return var_3_1 >= var_3_0.open_systems_limited[6].level
end

return var_0_1
