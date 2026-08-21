local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("MultHeartDemonEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_MultMain"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.Controller = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "lock")
end

function var_0_1.OnEnter(arg_4_0)
	var_0_1.super.OnEnter(arg_4_0)
	manager.redPoint:bindUIandKey(arg_4_0.goBtn_.transform, RedPointConst.MULT_HEART_DEMON)
	arg_4_0:UpdateView()
	arg_4_0:HideRedPoint()
	arg_4_0:AddTimer()
end

function var_0_1.HideRedPoint(arg_5_0)
	MultHeartDemonAction.UpdateEnterRedPoint(arg_5_0.activityId)
end

function var_0_1.RefreshTimeText(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0:CheckAdvanceOpenTime()

	arg_6_0.remainTxt_.text = var_6_1
end

function var_0_1.UpdateView(arg_7_0)
	arg_7_0.titleTxt_.text = GetTips("MULTI_HEART_DEMON_NAME")
	arg_7_0.describeTxt_.text = GetTips("MULTI_HEART_DEMON_DESC")

	arg_7_0.Controller:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) and "lock" or "unlock")
end

function var_0_1.OnExit(arg_8_0)
	var_0_1.super.OnExit(arg_8_0)
	arg_8_0:StopTimer()
	manager.redPoint:unbindUIandKey(arg_8_0.goBtn_.transform, RedPointConst.MULT_HEART_DEMON)
end

function var_0_1.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.goBtn_, nil, function()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MULT_HEART_DEMON) then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.MULT_HEART_DEMON)[2]))
		else
			JumpTools.GoToSystem("/multHeartDemonMain", {
				activityId = arg_9_0.activityId
			})
			MultHeartDemonAction.UpdateViewRedPoint()
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("MULTI_HEART_DEMON_GAMEPLAY_DESC")
		})
	end)
end

return var_0_1
