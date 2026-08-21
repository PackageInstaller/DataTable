local var_0_0 = class("ChallengeRogueTeamIllustratedRelicView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/Illustrated/IllustratedRemainsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.relicPanelView_ = ChallengeRogueTeamIllustratedRelicPanel.New(arg_3_0.gameObject_)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_4_0.relicPanelView_:OnEnter(arg_4_0.params_.templateID)
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.relicPanelView_:OnExit()
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.relicPanelView_:Dispose()

	arg_6_0.relicPanelView_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	return
end

function var_0_0.OnTop(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_8_0.relicPanelView_:RefreshUI()
end

return var_0_0
