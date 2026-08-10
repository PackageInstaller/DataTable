local var_0_0 = class("ChessBagKeyItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.emptyController_ = arg_2_0.controllerExCollection_:GetController("empty")
	arg_2_0.typeController_ = arg_2_0.controllerExCollection_:GetController("type")
	arg_2_0.bottomAmountController_ = arg_2_0.controllerExCollection_:GetController("textcom")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.info_ = arg_4_1

	arg_4_0.emptyController_:SetSelectedState("off")
	arg_4_0.typeController_:SetSelectedState("material")
	arg_4_0.bottomAmountController_:SetSelectedState("on")

	arg_4_0.iconImage_.sprite = pureGetSpriteWithoutAtlas(arg_4_0.info_.iconPath)
	arg_4_0.bottomAmountText_.text = arg_4_0.info_.number

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.bottomAmountText_.transform)
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
