class = var_0_10000

local var_0_0 = "IslandSelectLureOpView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandSelectableOpView"))

function var_0_1.GetDisplayData(arg_1_0)
	local var_1_0 = arg_1_0:GetIsland()
	local var_1_1 = var_1.GetInventoryAgency(var_1_0)

	return (var_1.GetFishingItems(var_1_1))
end

function var_0_1.GetTargetTr(arg_2_0)
	local var_2_0 = arg_2_0:GetView()
	local var_2_1 = var_1.GetSubView

	IslandOpView = var_1_10003

	return var_2_1(var_2_0, var_1_10003).lureBtn
end

function var_0_1.GetSelectedId(arg_3_0)
	local var_3_0 = arg_3_0:GetIsland()
	local var_3_1 = var_1.GetFishingAgency(var_3_0)

	return var_1.GetBaitId(var_3_1)
end

function var_0_1.OnSelected(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.NotifiyMeditor

	IslandBaseMediator = var_1_10004

	local var_4_2 = var_1_10004.EXCHANGE_LURE
	local var_4_3 = arg_4_1
	local var_4_4 = arg_4_0:GetView()
	local var_4_5 = var_6.GetSubView

	IslandOpView = var_1_10008

	var_4_1(var_4_0, var_4_2, var_4_3, var_4_5(var_4_4, var_1_10008).unitId)

	return
end

function var_0_1.IsShowItemCount(arg_5_0)
	return false
end

return var_0_1
