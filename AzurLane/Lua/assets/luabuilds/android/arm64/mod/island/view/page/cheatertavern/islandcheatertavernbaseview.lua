class = var_0_10000

local var_0_0 = "IslandCheaterTavernBaseView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

function var_0_1.AddListeners(arg_1_0)
	return
end

function var_0_1.RemoveListeners(arg_2_0)
	return
end

function var_0_1.SetActiveState(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0._tf, arg_3_1)

	return
end

function var_0_1.OnCheaterEveryRoundStart(arg_4_0)
	return
end

function var_0_1.OnCheaterEveryRoundStartDone(arg_5_0)
	return
end

function var_0_1.IsSelf(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_6_0 = var_1_10002(var_1_10004)

	return var_2.getRawData(var_6_0).id == arg_6_1
end

function var_0_1.Hide(arg_7_0)
	arg_7_0:OnHide()

	return
end

function var_0_1.Init(arg_8_0)
	local var_8_0 = arg_8_0.parent
	local var_8_1 = var_1.GetIsland(var_8_0)

	arg_8_0.cheaterTavernAgency = var_1.GetCheaterTavernAgency(var_8_1)

	arg_8_0:OnInit()

	return
end

function var_0_1.OnHide(arg_9_0)
	return
end

function var_0_1.OnInit(arg_10_0)
	return
end

return var_0_1
