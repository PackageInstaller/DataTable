local var_0_0 = class("MultHeartDemonOverView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_victory"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0.Back()
	end)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
	Object.Destroy(arg_7_0.gameObject_)
end

return var_0_0
