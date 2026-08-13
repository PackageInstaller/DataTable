class = var_0_10000

local var_0_0 = "IslandDeviceOrderBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandDeviceBaseBtn"))

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	local var_1_0 = arg_1_0.unlockTF
	local var_1_1 = var_1.Find(var_1_0, "normal/Text")
	local var_1_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_1_0.normalTxt = var_1_2(var_1_1, var_4(var_1_10006))

	local var_1_3 = arg_1_0.unlockTF
	local var_1_4 = var_1.Find(var_1_3, "urgency/Text")
	local var_1_5 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_1_0.urgencyTxt = var_1_5(var_1_4, var_4(var_1_10006))

	return
end

function var_0_1.FlushDataUI(arg_2_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.GetIsland(var_2_0)
	local var_2_2 = var_1.GetOrderAgency(var_2_1)
	local var_2_3 = var_1.GetMaxFinishCount(var_2_2)
	local var_2_4 = var_1:GetFinishCnt()

	arg_2_0.normalTxt.text = var_2_3 - var_2_4 .. "/" .. var_2_3

	local var_2_5 = var_1:GetMaxUrgentFinishCnt()
	local var_2_6 = var_1:GetLeftUrgentCnt()

	arg_2_0.urgencyTxt.text = var_2_6 .. "/" .. var_2_5

	return
end

return var_0_1
