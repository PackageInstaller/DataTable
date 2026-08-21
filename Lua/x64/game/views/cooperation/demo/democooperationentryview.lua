local var_0_0 = class("DemoCooperationEntryView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 2
end

function var_0_0.UIName(arg_2_0)
	return "UI/Cooperation/Demo/DemoCooperationUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_createRoomBtn, function()
		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			local var_7_0 = CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO, arg_6_0.activity_id)

			CooperationAction.CreateRoom(arg_6_0.activity_id, BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO, {
				var_7_0
			})
		end
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_quickJoinBtn, function()
		if CooperationData:GetIsMatching() then
			CooperationAction.CancelMatching()
		else
			local var_8_0 = CooperationData:GetCooperationHero(BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO, arg_6_0.activity_id)

			CooperationAction.StartMatching(arg_6_0.activity_id, BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO, {
				var_8_0
			})
		end
	end)
	arg_6_0:AddBtnListener(nil, arg_6_0.m_inviteBtn, function()
		JumpTools.OpenPageByJump("cooperationApply", {
			room_type = BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO
		})
	end)
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activity_id = ActivityConst.COOPERATION_DEMO

	local var_11_0 = ActivityCooperationDemoCfg[arg_11_0.activity_id]

	arg_11_0.m_stageName.text = GetI18NText(var_11_0.stage_name)
	arg_11_0.m_stageDes.text = GetI18NText(var_11_0.stage_des)

	arg_11_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_12_0)
	local var_12_0 = CooperationData:GetIsMatching()

	arg_12_0.m_matchingLab.text = var_12_0 and GetTips("COOPERATION_MATCHING") or GetTips("COOPERATION_START_MATCH")
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()

	if CooperationData:GetIsMatching() then
		CooperationAction.CancelMatching()
	end
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

function var_0_0.OnCooperationIsMatchingChange(arg_15_0)
	arg_15_0:RefreshUI()
end

return var_0_0
