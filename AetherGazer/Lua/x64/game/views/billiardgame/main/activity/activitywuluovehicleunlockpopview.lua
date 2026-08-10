local var_0_0 = class("ActivityWuluoVehicleUnlockPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_WuLuo/Activity_WuLuo_Main/Activity_WuLuo_BallUnlockPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListner()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListner(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.confirmBtn_, nil, function()
		arg_5_0:Back()
		JumpTools.OpenPageByJump("activityWuluoVehicleInfoPopView", {
			unLockVehicleID = arg_5_0.vehicleId_
		})
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.vehicleId_ = arg_7_0.params_.vehicleID
	arg_7_0.params_.vehicleID = nil
	arg_7_0.cfg_ = MergeBallVehicleCfg[arg_7_0.vehicleId_]

	if arg_7_0.cfg_ then
		arg_7_0.unlockVehicleIcon_.sprite = pureGetSpriteWithoutAtlas(arg_7_0.cfg_.icon)
		arg_7_0.unlockVehicleName_.text = arg_7_0.cfg_.name
	end
end

return var_0_0
