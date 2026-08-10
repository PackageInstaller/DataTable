local var_0_0 = class("VehicleSelectItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = arg_3_0.transCon_:GetController("status")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.vehicleId_ = arg_4_1
	arg_4_0.vehicleCfg_ = MergeBallVehicleCfg[arg_4_0.vehicleId_]
	arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas(arg_4_0.vehicleCfg_.icon)
	arg_4_0.isLock_ = arg_4_2
	arg_4_0.isSelect_ = arg_4_3

	if arg_4_0.isLock_ then
		arg_4_0.statusController_:SetSelectedState("lock")
	else
		arg_4_0:ShowSelect(arg_4_0.isSelect_)
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		if arg_5_0.isLock_ then
			ShowTips("MERGE_BALL_VEHICLE_LOCKED")

			return
		end

		arg_5_0.clickFunc_(arg_5_0)
	end)
end

function var_0_0.RegisterClickListener(arg_7_0, arg_7_1)
	arg_7_0.clickFunc_ = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.ShowSelect(arg_9_0, arg_9_1)
	arg_9_0.isSelect_ = arg_9_1

	arg_9_0.statusController_:SetSelectedState(arg_9_0.isSelect_ and "select" or "normal")
end

return var_0_0
