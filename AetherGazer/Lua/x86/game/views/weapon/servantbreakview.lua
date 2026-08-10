local var_0_0 = import("game.views.pop.PopLevelUpBaseView")
local var_0_1 = class("ServantBreakView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Hero_servant/HeroServantLvupPopUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_1.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnBack_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_1.OnEnter(arg_7_0)
	arg_7_0:CheckBack()
	arg_7_0:RefreshBreakSuccess(arg_7_0.params_.stage)
end

function var_0_1.OnExit(arg_8_0)
	return
end

function var_0_1.RefreshBreakSuccess(arg_9_0, arg_9_1)
	arg_9_0.nextLevelTxt_.text = arg_9_1 + 1
	arg_9_0.afterText_.text = arg_9_1
end

function var_0_1.Cacheable(arg_10_0)
	return false
end

return var_0_1
