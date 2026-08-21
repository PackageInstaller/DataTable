local var_0_0 = class("IslandCheaterTavernBaseView", import("view.base.BasePanel"))

function var_0_0.AddListeners(arg_1_0)
	return
end

function var_0_0.RemoveListeners(arg_2_0)
	return
end

function var_0_0.SetActiveState(arg_3_0, arg_3_1)
	setActive(arg_3_0._tf, arg_3_1)

	return
end

function var_0_0.OnCheaterEveryRoundStart(arg_4_0)
	return
end

function var_0_0.OnCheaterEveryRoundStartDone(arg_5_0)
	return
end

function var_0_0.IsSelf(arg_6_0, arg_6_1)
	local var_6_0 = getProxy(PlayerProxy)

	return var_6_0:getRawData().id == arg_6_1
end

function var_0_0.Hide(arg_7_0)
	arg_7_0:OnHide()

	return
end

function var_0_0.Init(arg_8_0)
	arg_8_0.cheaterTavernAgency = arg_8_0.parent:GetIsland():GetCheaterTavernAgency()

	arg_8_0:OnInit()

	return
end

function var_0_0.OnHide(arg_9_0)
	return
end

function var_0_0.OnInit(arg_10_0)
	return
end

return var_0_0
