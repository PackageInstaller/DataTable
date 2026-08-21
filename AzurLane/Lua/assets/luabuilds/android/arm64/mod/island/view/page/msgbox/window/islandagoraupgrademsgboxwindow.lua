local var_0_0 = class("IslandAgoraUpgradeMsgboxWindow", import(".IslandCommonMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandAgoraUpgradeMsgBox"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)
	setText(arg_2_0._tf:Find("confirm/Text"), i18n("island_agora_extend"))
	setText(arg_2_0._tf:Find("condition/title/Text"), i18n("island_agora_extend_consume"))
	setText(arg_2_0._tf:Find("capacity/Text"), i18n("island_agora_extend_capacity"))

	arg_2_0.dropTpl = arg_2_0._tf:Find("condition/tpl")
	arg_2_0.dropCntTxt = arg_2_0._tf:Find("condition/tpl/icon_bg/count_bg/count"):GetComponent(typeof(Text))
	arg_2_0.oldCapacityTxt = arg_2_0._tf:Find("capacity/Text_1"):GetComponent(typeof(Text))
	arg_2_0.newCapacityTxt = arg_2_0._tf:Find("capacity/Text_2"):GetComponent(typeof(Text))

	return
end

function var_0_0.OnShow(arg_3_0)
	var_0_0.super.OnShow(arg_3_0)

	local var_3_0 = arg_3_0.settings.island:GetAgoraAgency()

	arg_3_0:UpdateCapacity(var_3_0)
	arg_3_0:UpdateConsume(var_3_0, (arg_3_0.settings.island:GetInventoryAgency()))

	return
end

function var_0_0.FlushBtn(arg_4_0, arg_4_1)
	return
end

function var_0_0.UpdateCapacity(arg_5_0, arg_5_1)
	arg_5_0.oldCapacityTxt.text = arg_5_1:GetCapacity()
	arg_5_0.newCapacityTxt.text = arg_5_1:GetNextCapacity()

	return
end

function var_0_0.UpdateConsume(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1:GetUpgradeConsume()

	updateCustomDrop(arg_6_0.dropTpl, var_6_0)

	local var_6_1 = arg_6_2:GetOwnCount(var_6_0.id)

	arg_6_0.dropCntTxt.text = setColorStr(var_6_1, var_6_1 >= var_6_0.count and "#FFFFFF" or "#EB5F5F") .. "/" .. var_6_0.count

	return
end

return var_0_0
