local var_0_0 = class("SimBusInessUnlockNewItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.showItem = SimBusinessShowItem.New(arg_2_0.showItemGo_)
	arg_2_0.typeContorller = arg_2_0.controllers_:GetController("type")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.RefreshView(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.id = arg_4_1

	if arg_4_2 == SimBusinessConst.ShowItmeType.shelf then
		arg_4_0.name_.text = SimBusinessShelfCfg[arg_4_0.id].name

		arg_4_0.typeContorller:SetSelectedState("unlockShelf")
	elseif arg_4_2 == SimBusinessConst.ShowItmeType.good then
		arg_4_0.name_.text = SimBusinessGoodsCfg[arg_4_0.id].name

		arg_4_0.typeContorller:SetSelectedState("unlockGoods")
	end

	arg_4_0.showItem:RefreshView(arg_4_1, arg_4_2)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.showItem:Dispose()
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
