local var_0_0 = class("ChallengeRogueTeamMapPreviewView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikeMapPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.mapView_ = ChallengeRogueTeamMapPreviewNode.New(arg_3_0.scrollViewGo_)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.mapView_:OnEnter()
	arg_4_0.mapView_:RefreshUI()
	manager.rogueTeamMapPreviewBtnBar:ShowBar()
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.PREVIEW)
end

function var_0_0.OnEnterOver(arg_5_0)
	arg_5_0.mapView_:SetOpenSectionInfoFlag(false)
	arg_5_0.mapView_:OnEnterOver()
	arg_5_0.mapView_:SetOpenSectionInfoFlag(true)
end

function var_0_0.OnTop(arg_6_0)
	arg_6_0.mapView_:OnTop()
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0.mapView_:OnExit()
	manager.rogueTeamMapPreviewBtnBar:ShowState(ChallengeRogueTeamConst.MAP_BTN_WINDOW.OTHER)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.mapView_:Dispose()

	arg_8_0.mapView_ = nil

	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.closeBtn_, nil, function()
		arg_9_0:Back()
	end)
end

return var_0_0
