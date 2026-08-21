local var_0_0 = class("IslandActivitySpecialOrderS2Page", import(".IslandActivitySpecialOrderPage"))

function var_0_0.getTabTipMapList(arg_1_0)
	return {
		{
			"island_spoperation_btn_2602_2",
			"island_spoperation_tip_2602_3"
		},
		{
			"island_spoperation_btn_2602_1",
			"island_spoperation_tip_2602_2"
		},
		{
			"island_spoperation_btn_2602_3",
			"island_spoperation_tip_2602_1"
		}
	}
end

function var_0_0.getItemTipPrefix(arg_2_0)
	return "island_spoperation_item_2602_"
end

function var_0_0.OnFirstFlush(arg_3_0)
	var_0_0.super.OnFirstFlush(arg_3_0)
	setActive(arg_3_0.rtTitle:Find("level"), false)

	return
end

return var_0_0
