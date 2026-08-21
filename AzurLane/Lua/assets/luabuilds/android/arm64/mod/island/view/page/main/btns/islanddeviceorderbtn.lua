local var_0_0 = class("IslandDeviceOrderBtn", import(".IslandDeviceBaseBtn"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.normalTxt = arg_1_0.unlockTF:Find("normal/Text"):GetComponent(typeof(Text))
	arg_1_0.urgencyTxt = arg_1_0.unlockTF:Find("urgency/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.FlushDataUI(arg_2_0)
	local var_2_0 = getProxy(IslandProxy):GetIsland():GetOrderAgency()
	local var_2_1 = var_2_0:GetMaxFinishCount()

	arg_2_0.normalTxt.text = var_2_1 - var_2_0:GetFinishCnt() .. "/" .. var_2_1
	arg_2_0.urgencyTxt.text = var_2_0:GetLeftUrgentCnt() .. "/" .. var_2_0:GetMaxUrgentFinishCnt()

	return
end

return var_0_0
