class = var_0_10000

local var_0_0 = "AvroraTWCBTPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.get = var_1.Find(var_1_1, "get")

	local var_1_2 = arg_1_0.bg

	arg_1_0.go = var_1.Find(var_1_2, "go")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.go

	local function var_2_2()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_3_1(var_3_0, var_2_10003.SPECIAL_BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	getProxy = var_1_10001
	ChapterProxy = var_2_0

	local var_2_3 = var_1_10001(var_2_0)
	local var_2_4 = var_1.isClear(var_2_3, 304)

	setActive = var_2_0

	var_2_0(arg_2_0.go, not var_2_4)

	setActive = var_2_0

	var_2_0(arg_2_0.get, var_2_4)

	return
end

return var_0_1
