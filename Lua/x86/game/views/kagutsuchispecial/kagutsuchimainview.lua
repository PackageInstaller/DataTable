local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("KagutsuchiHomeView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionKagutsuchiUI"
end

function var_0_1.Ctor(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.Ctor(arg_2_0, arg_2_1, arg_2_0:GetActivityID())
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_1.AddUIListener(arg_5_0)
	local var_5_0 = arg_5_0:GetActivityID()
	local var_5_1 = ActivityTools.GetRedPointKey(var_5_0) .. var_5_0
	local var_5_2 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_REWARD, var_5_1)
	local var_5_3 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_FISH, var_5_1)
	local var_5_4 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_HANAFUDA, var_5_1)

	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("activity_kagutsuchi_draw1")

		if not ActivityTools.ActivityOpenCheck(var_5_0) then
			return
		end

		JumpTools.OpenPageByJump("/kagutsuchiGacha", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.workBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(var_5_0) then
			return
		end

		KagutsuchiWorkAction:BanRedPoint(var_5_2)
		JumpTools.OpenPageByJump("/kagutsuchiWork", {
			activityID = arg_5_0:GetActivityID()
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.fishBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(var_5_0) then
			return
		end

		KagutsuchiWorkAction:BanRedPoint(var_5_3)
		DormMinigame.Launch("HZ07_diaoyu1")
	end)
	arg_5_0:AddBtnListener(arg_5_0.hanafudaBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(var_5_0) then
			return
		end

		KagutsuchiWorkAction:BanRedPoint(var_5_4)
		JumpTools.OpenPageByJump("/hanafudaGameView", {})
	end)
end

function var_0_1.OnEnter(arg_10_0)
	var_0_1.super.OnEnter(arg_10_0)
	arg_10_0:RefreshUI()

	local var_10_0 = arg_10_0:GetActivityID()
	local var_10_1 = ActivityTools.GetRedPointKey(var_10_0) .. var_10_0
	local var_10_2 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_REWARD, var_10_1)
	local var_10_3 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_FISH, var_10_1)
	local var_10_4 = string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA, var_10_1)
	local var_10_5 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA, var_10_1)

	manager.redPoint:bindUIandKey(arg_10_0.workBtn_.transform, var_10_2)
	manager.redPoint:bindUIandKey(arg_10_0.hanafudaBtn_.transform, var_10_4)
	manager.redPoint:bindUIandKey(arg_10_0.fishBtn_.transform, var_10_3)
	manager.redPoint:bindUIandKey(arg_10_0.rewardBtn_.transform, var_10_5)
end

function var_0_1.OnExit(arg_11_0)
	var_0_1.super.OnExit(arg_11_0)

	local var_11_0 = arg_11_0:GetActivityID()
	local var_11_1 = ActivityTools.GetRedPointKey(var_11_0) .. var_11_0
	local var_11_2 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_REWARD, var_11_1)
	local var_11_3 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_FISH, var_11_1)
	local var_11_4 = string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA, var_11_1)
	local var_11_5 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA, var_11_1)

	manager.redPoint:unbindUIandKey(arg_11_0.workBtn_.transform, var_11_2)
	manager.redPoint:unbindUIandKey(arg_11_0.hanafudaBtn_.transform, var_11_4)
	manager.redPoint:unbindUIandKey(arg_11_0.fishBtn_.transform, var_11_3)
	manager.redPoint:unbindUIandKey(arg_11_0.rewardBtn_.transform, var_11_5)
end

function var_0_1.GetActivityID(arg_12_0)
	return ActivityConst.KAGUTSUCHI_ACTIVITY
end

function var_0_1.RefreshUI(arg_13_0)
	local var_13_0 = arg_13_0:GetActivityID()
	local var_13_1 = ActivityData:GetActivityData(var_13_0)
	local var_13_2 = var_13_1.startTime
	local var_13_3 = var_13_1.stopTime

	arg_13_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_13_0.stopTime_)

	KagutsuchiWorkAction:UpdateRedPoint(var_13_0)
end

return var_0_1
