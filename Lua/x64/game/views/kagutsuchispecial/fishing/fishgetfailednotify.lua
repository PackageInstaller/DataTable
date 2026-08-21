local var_0_0 = class("FishGetFailedNotify", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingLosePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.okBtn_, nil, JumpTools.Back)
end

function var_0_0.OnEnter(arg_4_0)
	return
end

return var_0_0
