class = var_0_10000

local var_0_0 = "IslandAgoraUpgradeMsgboxWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandCommonMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandAgoraUpgradeMsgBox"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "confirm/Text")

	i18n = var_2_0

	var_1(var_2_1, var_2_0("island_agora_extend"))

	setText = var_1

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "condition/title/Text")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("island_agora_extend_consume"))

	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_2.Find(var_2_4, "capacity/Text")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("island_agora_extend_capacity"))

	local var_2_6 = arg_2_0._tf

	arg_2_0.dropTpl = var_1.Find(var_2_6, "condition/tpl")

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_1.Find(var_2_7, "condition/tpl/icon_bg/count_bg/count")
	local var_2_9 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.dropCntTxt = var_2_9(var_2_8, var_3(var_4))

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_1.Find(var_2_10, "capacity/Text_1")
	local var_2_12 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.oldCapacityTxt = var_2_12(var_2_11, var_3(var_4))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "capacity/Text_2")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.newCapacityTxt = var_2_15(var_2_14, var_3(var_4))

	return
end

function var_0_1.OnShow(arg_3_0)
	var_0_1.super.OnShow(arg_3_0)

	local var_3_0 = arg_3_0.settings.island
	local var_3_1 = var_1.GetAgoraAgency(var_3_0)
	local var_3_2 = var_1:GetInventoryAgency()

	arg_3_0:UpdateCapacity(var_3_1)
	arg_3_0:UpdateConsume(var_3_1, var_3_2)

	return
end

function var_0_1.FlushBtn(arg_4_0, arg_4_1)
	return
end

function var_0_1.UpdateCapacity(arg_5_0, arg_5_1)
	arg_5_0.oldCapacityTxt.text = arg_5_1:GetCapacity()
	arg_5_0.newCapacityTxt.text = arg_5_1:GetNextCapacity()

	return
end

function var_0_1.UpdateConsume(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.GetUpgradeConsume(var_6_0)

	updateCustomDrop = var_6_0

	var_6_0(arg_6_0.dropTpl, var_6_1)

	local var_6_2 = arg_6_2:GetOwnCount(var_6_1.id)
	local var_6_3 = arg_6_0.dropCntTxt

	setColorStr = var_6
	var_6_3.text = var_6(var_6_2, var_6_2 >= var_6_1.count and "#FFFFFF" or "#EB5F5F") .. "/" .. var_6_1.count

	return
end

return var_0_1
