local var_0_0 = class("RaceTrialBattleItem_3_8", RaceTrialBattleItem)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.stateController = arg_1_0.controllers_:GetController("state")
end

function var_0_0.AddUIListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		local var_3_0, var_3_1 = ActivityTools.GetActivityStatusWithTips(arg_2_0.activityID)

		if var_3_0 ~= ActivityConst.ACTIVITY_STATE.ACTIVING then
			if var_3_1 then
				ShowTips(var_3_1)
			end

			return
		end

		JumpTools.OpenPageByJump("/raceTrialReady", {
			activityID = arg_2_0.activityID,
			mainActivityID = arg_2_0.mainActivityID
		})
		RaceTrialData:SetBattleRedPointOn(false, arg_2_0.activityID)
	end)
end

local var_0_1 = {
	Clear = 2,
	Lock = 0,
	NotClear = 1
}

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.mainActivityID = arg_4_2

	if arg_4_0.activityID ~= arg_4_1 then
		arg_4_0.ani_:Play("UI_stageItem_cx", 0, 0)
	end

	arg_4_0.activityID = arg_4_1

	arg_4_0:RefreshRace()

	local var_4_0, var_4_1 = ActivityTools.GetActivityStatusWithTips(arg_4_1)

	if var_4_0 ~= 1 then
		arg_4_0:RefreshState(var_0_1.Lock, var_4_1 or "--")
	else
		arg_4_0:RefreshScore()
	end

	if var_4_0 ~= 2 then
		arg_4_0:StartTimer()
	end

	arg_4_0:RefreshRedPoint()
end

function var_0_0.RefreshScore(arg_5_0)
	local var_5_0 = (RaceTrialData:GetBattleData(arg_5_0.activityID) or {}).point or 0

	if var_5_0 > 0 then
		arg_5_0:RefreshState(var_0_1.Clear, var_5_0)
	else
		arg_5_0:RefreshState(var_0_1.NotClear)
	end
end

function var_0_0.StartTimer(arg_6_0)
	arg_6_0:StopTimer()

	arg_6_0.timer_ = Timer.New(function()
		local var_7_0, var_7_1 = ActivityTools.GetActivityStatusWithTips(arg_6_0.activityID)

		if var_7_0 == ActivityConst.ACTIVITY_STATE.OVER then
			arg_6_0:RefreshState(var_0_1.Lock, var_7_1)
			arg_6_0:StopTimer()
		elseif var_7_0 == ActivityConst.ACTIVITY_STATE.ACTIVING then
			arg_6_0:RefreshScore()
		else
			arg_6_0:RefreshState(var_0_1.Lock, var_7_1 or "--")
		end

		arg_6_0:RefreshRedPoint()
	end, 0.99, -1)

	arg_6_0.timer_:Start()
end

function var_0_0.RefreshRedPoint(arg_8_0)
	local var_8_0 = manager.redPoint:getTipValue(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, arg_8_0.mainActivityID, arg_8_0.activityID))

	manager.redPoint:SetRedPointIndependent(arg_8_0.transform_, var_8_0 > 0)
end

function var_0_0.RefreshRace(arg_9_0)
	local var_9_0 = ActivityRaceTrialCfg[arg_9_0.activityID]
	local var_9_1 = var_9_0.race

	arg_9_0.name_.text = var_9_0.name

	for iter_9_0, iter_9_1 in ipairs(RaceEffectCfg.all) do
		local var_9_2 = arg_9_0[string.format("raceBg%d_", iter_9_1)]

		if var_9_2 then
			SetActive(var_9_2, var_9_1 == iter_9_1)
		end
	end
end

function var_0_0.RefreshState(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == var_0_1.Clear then
		arg_10_0.stateController:SetSelectedState("clear")

		arg_10_0.scoreText_.text = arg_10_2 or "--"
	elseif arg_10_1 == var_0_1.NotClear then
		arg_10_0.stateController:SetSelectedState("notClear")
	else
		arg_10_0.stateController:SetSelectedState("lock")

		arg_10_0.lockMsg_.text = arg_10_2
	end
end

return var_0_0
