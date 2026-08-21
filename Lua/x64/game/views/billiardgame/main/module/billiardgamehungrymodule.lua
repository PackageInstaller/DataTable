local var_0_0 = class("BilliardGameHungryModuel", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.foodItemController = {}

	for iter_2_0 = 1, 6 do
		arg_2_0.foodItemController[iter_2_0] = arg_2_0[string.format("itemControl%d_", iter_2_0)]:GetController("status")
	end
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.RefreshHungry(arg_4_0)
	local var_4_0 = BilliardGameMgr:GetLogicData().hungryVal

	for iter_4_0 = 1, 6 do
		arg_4_0.foodItemController[iter_4_0]:SetSelectedState(var_4_0 <= iter_4_0 and "on" or "off")
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
