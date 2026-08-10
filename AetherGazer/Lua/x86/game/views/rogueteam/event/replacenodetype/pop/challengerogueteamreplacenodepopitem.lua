local var_0_0 = class("ChallengeRogueTeamReplaceNodePopItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("selected")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.selectedID_ == arg_3_0.id_ then
			return
		end

		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SELECTED_NODE_TYPE, arg_3_0.id_)
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id_ = arg_5_1
	arg_5_0.selectedID_ = arg_5_2

	arg_5_0.selectController_:SetSelectedState(tostring(arg_5_2 == arg_5_1))

	local var_5_0 = RogueTeamRoomTypeCfg[arg_5_1]

	arg_5_0.nameText_.text = var_5_0.name
end

return var_0_0
