ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("IdolCompetitionMenuView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/BackHouseUI/Competition/IdolCompetitionEntranceUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.raceTime_ = nil
	arg_3_0.raceTimeCurShow_ = true
	arg_3_0.timeShowController_ = arg_3_0.mainControllerEx_:GetController("timeShow")
	arg_3_0.subActivityList_ = ActivityCfg[arg_3_0.activityID_].sub_activity_list
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.mainBtn_, nil, function()
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
			ShowTips("IDOL_COMPETITION_UNLOCK")

			return
		end

		DormMinigame.Launch("WT_RK", nil, "idolCompetitionMain")
	end)
	arg_4_0:AddBtnListener(arg_4_0.descBtn_, nil, function()
		local var_6_0 = "IDOL_COMPETITION_MAIN_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_6_0),
			key = var_6_0
		})
	end)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.UpdateBar(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.Show(arg_9_0, arg_9_1)
	SetActive(arg_9_0.gameObject_, arg_9_1)

	if arg_9_1 == true then
		arg_9_0:RefreshUI()
		manager.redPoint:bindUIandKey(arg_9_0.mainBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_9_0.activityID_), arg_9_0.activityID_))
	else
		manager.redPoint:unbindUIandKey(arg_9_0.mainBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(arg_9_0.activityID_), arg_9_0.activityID_))
	end
end

function var_0_0.RefreshUI(arg_10_0)
	for iter_10_0 = 1, 2 do
		local var_10_0 = IdolCompetitionData:GetRacePhase(arg_10_0.subActivityList_[iter_10_0])

		if var_10_0 and var_10_0 == 1 then
			arg_10_0.raceTime_ = IdolCompetitionData:GetRaceRefreshTime(arg_10_0.subActivityList_[iter_10_0])[1]
		end
	end

	arg_10_0:RefreshTimeText()
end

function var_0_0.RefreshTimeText(arg_11_0)
	if arg_11_0.timeText_ then
		arg_11_0.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStrWith2Unit(arg_11_0.stopTime_, true)
	end

	if arg_11_0.raceTimeCurShow_ then
		if not arg_11_0.raceTime_ or manager.time:GetServerTime() >= arg_11_0.raceTime_ then
			arg_11_0.raceTime_ = nil
			arg_11_0.raceTimeCurShow_ = false

			arg_11_0.timeShowController_:SetSelectedState("false")
		else
			arg_11_0.signText_.text = manager.time:GetLostTimeStrWith2Unit(arg_11_0.raceTime_, true) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
		end
	elseif arg_11_0.raceTime_ and manager.time:GetServerTime() < arg_11_0.raceTime_ then
		arg_11_0.raceTimeCurShow_ = true

		arg_11_0.timeShowController_:SetSelectedState("true")

		arg_11_0.signText_.text = manager.time:GetLostTimeStrWith2Unit(arg_11_0.raceTime_, true) .. GetTips("IDOL_COMPETITION_SIGN_TIME_TEXT")
	end
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:StopTimer()
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.UpdateData(arg_13_0)
	arg_13_0:RefreshUI()
end

return var_0_0
