class = var_0_10000

local var_0_0 = "IslandActivitySpecialOrderS3Page"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandActivitySpecialOrderPage"))

function var_0_1.getTabTipMapList(arg_1_0)
	return {
		{
			"island_spoperation_btn_2605_2",
			"island_spoperation_tip_2605_3"
		},
		{
			"island_spoperation_btn_2605_1",
			"island_spoperation_tip_2605_2"
		},
		{
			"island_spoperation_btn_2605_3",
			"island_spoperation_tip_2605_1"
		}
	}
end

function var_0_1.getItemTipPrefix(arg_2_0)
	return "island_spoperation_item_2605_"
end

function var_0_1.OnFirstFlush(arg_3_0)
	var_0_1.super.OnFirstFlush(arg_3_0)

	setActive = var_1

	local var_3_0 = arg_3_0.rtTitle

	var_1(var_3.Find(var_3_0, "level"), false)

	return
end

return var_0_1
