local var_0_0 = class("RaceTrialBattleItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.raceCon_ = ControllerUtil.GetController(arg_3_0.transform_, "race")
	arg_3_0.viewCon_ = ControllerUtil.GetController(arg_3_0.transform_, "view")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if manager.time:GetServerTime() < arg_4_0.openTime_ then
			local var_5_0 = arg_4_0.openTime_ - manager.time:GetServerTime()

			ShowTips(string.format(GetTips("OPEN_TIME"), arg_4_0:GetTimeText(var_5_0)))

			return
		end

		if not ActivityData:GetActivityIsOpen(arg_4_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("/raceTrialReady", {
			activityID = arg_4_0.activityID_,
			mainActivityID = arg_4_0.mainActivityID_
		})
		RaceTrialData:SetBattleRedPointOn(false, arg_4_0.activityID_)
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.activityID_ = arg_7_1
	arg_7_0.cfg_ = ActivityRaceTrialCfg[arg_7_0.activityID_]
	arg_7_0.data_ = RaceTrialData:GetBattleData(arg_7_0.activityID_) or {}
	arg_7_0.mainActivityID_ = arg_7_2

	local var_7_0 = ActivityData:GetActivityData(arg_7_0.activityID_)

	arg_7_0.openTime_ = var_7_0.startTime
	arg_7_0.endTime_ = var_7_0.stopTime

	if arg_7_0.nameText_ then
		arg_7_0.nameText_.text = GetI18NText(arg_7_0.cfg_.name)
	end

	local var_7_1 = manager.time:GetServerTime()

	if var_7_1 >= arg_7_0.openTime_ and var_7_1 < arg_7_0.endTime_ then
		arg_7_0:RefreshOpen()
	else
		arg_7_0:RefreshClose()
	end

	arg_7_0:RefreshRedPoint()
	arg_7_0:RefreshRace()
end

function var_0_0.RefreshRedPoint(arg_8_0)
	if manager.redPoint:getTipValue(string.format("%s_%s_%s", RedPointConst.ACTIVITY_RACE_TRIAL, arg_8_0.mainActivityID_, arg_8_0.activityID_)) > 0 then
		SetActive(arg_8_0.redGo_, true)
	else
		SetActive(arg_8_0.redGo_, false)
	end
end

function var_0_0.RefreshRace(arg_9_0)
	if arg_9_0.raceCon_ then
		arg_9_0.raceCon_:SetSelectedState(tostring(arg_9_0.cfg_.race))
	end

	arg_9_0.raceIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/OsirisUI/RaceTrial/" .. arg_9_0.cfg_.race)
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

function var_0_0.StartTimer(arg_11_0)
	arg_11_0:StopTimer()

	if arg_11_0.endTime_ <= manager.time:GetServerTime() then
		arg_11_0.timeCntText_.text = GetTips("TIME_OVER")

		return
	end

	local var_11_0 = arg_11_0.openTime_ - manager.time:GetServerTime()

	arg_11_0.timeCntText_.text = string.format(GetTips("OPEN_TIME"), arg_11_0:GetTimeText(var_11_0))

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.lockRect_)

	arg_11_0.timer_ = Timer.New(function()
		var_11_0 = arg_11_0.openTime_ - manager.time:GetServerTime()

		if var_11_0 <= 0 then
			arg_11_0.timer_:Stop()

			arg_11_0.timer_ = nil

			arg_11_0:RefreshUI(arg_11_0.activityID_, arg_11_0.mainActivityID_)
		end

		arg_11_0.timeCntText_.text = string.format(GetTips("OPEN_TIME"), arg_11_0:GetTimeText(var_11_0))
	end, 1, -1)

	arg_11_0.timer_:Start()
end

function var_0_0.RefreshOpen(arg_13_0)
	if arg_13_0.data_.point > 0 then
		arg_13_0.viewCon_:SetSelectedState("open")

		arg_13_0.scoreText_.text = arg_13_0.data_.point
	else
		arg_13_0.viewCon_:SetSelectedState("none")
	end
end

function var_0_0.RefreshClose(arg_14_0)
	arg_14_0.viewCon_:SetSelectedState("close")
	arg_14_0:StartTimer()
end

function var_0_0.GetTimeText(arg_15_0, arg_15_1)
	local var_15_0 = ""

	if arg_15_1 / 86400 >= 1 then
		var_15_0 = math.ceil(arg_15_1 / 86400) .. GetTips("DAY")
	elseif arg_15_1 / 3600 >= 1 then
		var_15_0 = math.ceil(arg_15_1 / 3600) .. GetTips("HOUR")
	elseif arg_15_1 / 60 >= 1 then
		var_15_0 = math.ceil(arg_15_1 / 60) .. GetTips("MINUTE")
	else
		var_15_0 = 1 .. GetTips("MINUTE")
	end

	return var_15_0
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:StopTimer()
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:StopTimer()
	arg_17_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
