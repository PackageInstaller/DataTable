class = var_0_10000

local var_0_0 = "NewNavalTacticsLockCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewNavalTacticsBaseCard"))

function var_0_1.UnlockCnt2ShopId(arg_1_0, arg_1_1)
	return ({
		21,
		22
	})[arg_1_1 - 1]
end

function var_0_1.OnInit(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0._tf

	local function var_2_2()
		getProxy = var_2_10000
		NavalAcademyProxy = var_2_10002

		local var_3_0 = var_2_10000(var_2_10002)
		local var_3_1 = var_0.getSkillClassNum(var_3_0)
		local var_3_2 = arg_2_0
		local var_3_3 = var_1.UnlockCnt2ShopId(var_3_2, var_3_1)
		local var_3_4 = arg_2_0
		local var_3_5 = var_2.emit

		NewNavalTacticsLayer = var_2_10005

		var_3_5(var_3_4, var_2_10005.ON_UNLOCK, var_3_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10006)

	return
end

return var_0_1
