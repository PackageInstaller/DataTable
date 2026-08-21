local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("SoloHeartDemonEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "Widget/System/Challenge_SoloHeartDemonUI/JapanRegionSoloMain"
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
	manager.redPoint:bindUIandKey(arg_4_0.goBtn_.transform, RedPointConst.SOLO_HEART_DEMON)
	arg_4_0:UpdateView()
	arg_4_0:HideRedPoint()
end

function var_0_1.UpdateView(arg_5_0)
	if arg_5_0.updateTimer_ then
		arg_5_0.updateTimer_:Stop()

		arg_5_0.updateTimer_ = nil
	end

	arg_5_0.remainTime = 0

	for iter_5_0, iter_5_1 in pairs(ActivityCfg.get_id_list_by_activity_template[270]) do
		if ActivityData:GetActivityIsOpen(iter_5_1) then
			arg_5_0.activityId = iter_5_1

			break
		end
	end

	arg_5_0.remainTime = ActivityData:GetActivityData(arg_5_0.activityID_).stopTime
	arg_5_0.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(arg_5_0.remainTime, true)
	arg_5_0.updateTimer_ = Timer.New(function()
		arg_5_0.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(arg_5_0.remainTime, true)
	end, 1, arg_5_0.remainTime - manager.time:GetServerTime() + 1, 1)

	arg_5_0.updateTimer_:Start()

	arg_5_0.describeTxt_.text = GetTips("SOLO_HEART_DEMON_ENTER_DESCRIBE")

	arg_5_0.Controller:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) and "lock" or "unlock")
end

function var_0_1.HideRedPoint(arg_7_0)
	SoloHeartDemonAction.UpdateEnterRedPoint(arg_7_0.activityId)
end

function var_0_1.OnExit(arg_8_0)
	var_0_1.super.OnExit(arg_8_0)

	if arg_8_0.updateTimer_ then
		arg_8_0.updateTimer_:Stop()

		arg_8_0.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(arg_8_0.goBtn_.transform, RedPointConst.SOLO_HEART_DEMON)
end

function var_0_1.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.goBtn_, nil, function()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
			ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON)[2]))
		elseif ActivityData:GetActivityIsOpen(ActivityConst.SOLO_HEART_DEMON) == false then
			ShowTips("SOLO_HEART_DEMON_CLOSED")
		else
			JumpTools.GoToSystem("/soloHeartDemonMain", {
				activityId = arg_9_0.activityId
			})
			SoloHeartDemonAction.UpdateViewRedPoint()
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.descBtn_, nil, function()
		local var_11_0 = GetTips("SOLO_HEART_DEMON_EXPLAIN")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "SOLO_HEART_DEMON_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_11_0
		})
	end)
end

return var_0_1
