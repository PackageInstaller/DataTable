local var_0_0 = class("IslandSelectLureOpView", import(".IslandSelectableOpView"))

function var_0_0.GetDisplayData(arg_1_0)
	return (arg_1_0:GetIsland():GetInventoryAgency():GetFishingItems())
end

function var_0_0.GetTargetTr(arg_2_0)
	return arg_2_0:GetView():GetSubView(IslandOpView).lureBtn
end

function var_0_0.GetSelectedId(arg_3_0)
	return arg_3_0:GetIsland():GetFishingAgency():GetBaitId()
end

function var_0_0.OnSelected(arg_4_0, arg_4_1)
	arg_4_0:NotifiyMeditor(IslandBaseMediator.EXCHANGE_LURE, arg_4_1, arg_4_0:GetView():GetSubView(IslandOpView).unitId)

	return
end

function var_0_0.IsShowItemCount(arg_5_0)
	return false
end

return var_0_0
