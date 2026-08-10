local var_0_0 = class("ChallengeRogueTeamReplaceNodePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/RogueTeam/RogueTeamReplaceNodePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.onSelectedTypeHandler_ = handler(arg_3_0, arg_3_0.OnSelectedType)
	arg_3_0.uiList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, ChallengeRogueTeamReplaceNodePopItem)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.nodeID_ = arg_4_0.params_.selectNodeID

	manager.notify:RegistListener(CHALLENGE_ROGUE_TEAM_SELECTED_NODE_TYPE, arg_4_0.onSelectedTypeHandler_)

	arg_4_0.roomTypeList_ = RogueTeamRoomTypeCfg.get_id_list_by_can_replace[1]

	arg_4_0.uiList_:StartScroll(#arg_4_0.roomTypeList_)

	arg_4_0.okBtn_.interactable = false
end

function var_0_0.OnExit(arg_5_0)
	manager.notify:RemoveListener(CHALLENGE_ROGUE_TEAM_SELECTED_NODE_TYPE, arg_5_0.onSelectedTypeHandler_)

	arg_5_0.selectID_ = nil
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.onSelectedTypeHandler_ = nil

	arg_6_0.uiList_:Dispose()

	arg_6_0.uiList_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.okBtn_, nil, function()
		local var_8_0 = arg_7_0.nodeID_

		ChallengeRogueTeamAction.CloseNodeReplaceWindow(var_8_0, arg_7_0.selectID_, function()
			arg_7_0:Back(2)
		end)
	end)
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.roomTypeList_[arg_10_1]

	arg_10_2:SetData(var_10_0, arg_10_0.selectID_)
end

function var_0_0.OnSelectedType(arg_11_0, arg_11_1)
	arg_11_0.selectID_ = arg_11_1
	arg_11_0.okBtn_.interactable = true

	arg_11_0.uiList_:Refresh()
end

return var_0_0
