local var_0_0 = class("ChallengeRogueTeamReplaceNodeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/RogueTeam/RogueTeamReplaceNodeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.mapView_ = ChallengeRogueTeamMapReplaceNode.New(arg_3_0.scrollViewGo_)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	ChallengeRogueTeamTools.RegistWindowBarClick()
	arg_4_0.mapView_:OnEnter()
	arg_4_0.mapView_:RefreshUI()
end

function var_0_0.OnEnterOver(arg_5_0)
	arg_5_0.mapView_:OnEnterOver()
end

function var_0_0.OnTop(arg_6_0)
	arg_6_0.mapView_:OnTop()
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
	arg_7_0.mapView_:OnExit()
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.mapView_:Dispose()

	arg_8_0.mapView_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.AddListeners(arg_9_0)
	return
end

return var_0_0
