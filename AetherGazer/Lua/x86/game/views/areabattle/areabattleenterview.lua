local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("AreaBattleEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return ActivityAreaBattleData:GetPrefabByActivityID(arg_1_0.activityID_) .. "NormalfightingEnterUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	if arg_2_0.btnControllerEx_ then
		arg_2_0.lockController = arg_2_0.btnControllerEx_:GetController("statelock01")
	end
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_1.OnEnter(arg_4_0)
	local var_4_0 = ActivityData:GetActivityData(arg_4_0.activityID_)

	arg_4_0.startTime_ = var_4_0.startTime
	arg_4_0.stopTime_ = var_4_0.stopTime
	arg_4_0.titleTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_NAME")

	arg_4_0:AddTimer()

	arg_4_0.descTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_DESC_TIPS")
	arg_4_0.btnNameTxt_.text = GetTips("ACTIVITY_AREA_BATTLE_BEGIN_BUTTON")

	arg_4_0:BindRedPoint()
end

function var_0_1.BindRedPoint(arg_5_0)
	manager.redPoint:bindUIandKey(arg_5_0.goBtn_.transform, ActivityTools.GetRedPointKey(arg_5_0.activityID_) .. arg_5_0.activityID_)
end

function var_0_1.RefreshAcvanceStatus(arg_6_0, arg_6_1)
	if arg_6_0.lockController then
		arg_6_0.lockController:SetSelectedState(arg_6_1 and "normal01" or "lock01")
	end
end

function var_0_1.RefreshTimeText(arg_7_0)
	if arg_7_0.timeText_ then
		if not arg_7_0:isHasLeftTimeDes() then
			local var_7_0, var_7_1 = arg_7_0:CheckAdvanceOpenTime()

			arg_7_0.timeText_.text = var_7_1

			arg_7_0:RefreshAcvanceStatus(not var_7_0)
		else
			arg_7_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_7_0.stopTime_, true)
		end
	end
end

function var_0_1.OnExit(arg_8_0)
	var_0_1.super.OnExit(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.goBtn_.transform, RedPointConst.INVITE_MAIN)
	arg_8_0:UnbindRedPoint()
end

function var_0_1.UnbindRedPoint(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.goBtn_.transform, ActivityTools.GetRedPointKey(arg_9_0.activityID_) .. arg_9_0.activityID_)
end

function var_0_1.AddUIListener(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.goBtn_, nil, function()
		JumpTools.GoToSystem("/AreaBattleAreaView", {
			activityId = arg_10_0.activityID_
		})
	end)
	arg_10_0:AddBtnListener(arg_10_0.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_AREA_BATTLE_DESCRIBE")
		})
	end)
	arg_10_0:AddBtnListener(arg_10_0.lockBtn_, nil, function()
		local var_13_0, var_13_1 = arg_10_0:CheckAdvanceOpenTime()

		manager.tips:ShowTips(var_13_1)
	end)
end

return var_0_1
