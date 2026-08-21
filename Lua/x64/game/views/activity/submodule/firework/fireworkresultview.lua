local var_0_0 = class("FireWorkResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/Firework/FireworkMakingUI"
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

	arg_4_0.stateController = ControllerUtil.GetController(arg_4_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.m_mask, nil, function()
		local var_6_0 = arg_5_0.params_.fire_activity_id

		if arg_5_0.isWin then
			JumpTools.OpenPageByJump("/fireWorkShow", {
				fire_activity_id = var_6_0
			})
		else
			JumpTools.OpenPageByJump("fireWorkMake", {
				start = true,
				fire_activity_id = var_6_0
			})
		end
	end)
end

function var_0_0.OnTop(arg_7_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.isWin = arg_8_0.params_.isWin

	if arg_8_0.isWin then
		arg_8_0.stateController:SetSelectedIndex(1)
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_good", "")
	else
		arg_8_0.stateController:SetSelectedIndex(0)
		manager.audio:PlayEffect("minigame_activity_spring_festival", "minigame_activity_spring_festival_no", "")
	end
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
