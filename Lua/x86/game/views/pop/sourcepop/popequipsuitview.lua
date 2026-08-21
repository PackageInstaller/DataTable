local var_0_0 = class("PopEquipSuitView", import("game.views.sectionSelect.equip.SuitSelectView"))

function var_0_0.InitUI(arg_1_0)
	arg_1_0.super.InitUI(arg_1_0)

	arg_1_0.popController = arg_1_0.controller:GetController("state")
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.super.OnEnter(arg_2_0)
end

function var_0_0.UpdateData(arg_3_0)
	arg_3_0.suitList_ = {}

	table.insert(arg_3_0.suitList_, arg_3_0.params_.suitId)
end

function var_0_0.OnExit(arg_4_0)
	arg_4_0.super.OnExit(arg_4_0)
end

return var_0_0
