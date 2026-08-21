ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivityChapterPageView", ActivityMainBasePanel)
local var_0_1 = {
	[4312001] = {
		10300,
		10301,
		10302,
		10303,
		10304,
		10305
	}
}

function var_0_0.GetUIName(arg_1_0)
	return ActivityChapterPageCfg[arg_1_0.activityID_].prefab_path
end

function var_0_0.GetTargetChapterID(arg_2_0)
	local var_2_0 = var_0_1[arg_2_0.activityID_]

	if var_2_0 then
		for iter_2_0 = #var_2_0, 1, -1 do
			local var_2_1 = var_2_0[iter_2_0]
			local var_2_2 = ChapterCfg[var_2_1]

			if var_2_2 and #var_2_2.section_id_list > 0 and ChapterTools.IsUnlockChapter(var_2_1) and ChapterTools.IsFinishPreChapter(var_2_1) then
				return var_2_1
			end
		end
	end

	return ChapterTools.GetChapterIDByClient(arg_2_0.chapterClientID_)
end

function var_0_0.Init(arg_3_0)
	var_0_0.super.Init(arg_3_0)

	if arg_3_0.videoGo_ then
		arg_3_0.criManaExMultipleVedio_ = arg_3_0.videoGo_.transform:GetComponent(typeof(CriManaExMultipleVedio))
	end

	if arg_3_0.dlcController_ then
		arg_3_0.getController_ = arg_3_0.dlcController_:GetController("get")
		arg_3_0.timeController_ = arg_3_0.dlcController_:GetController("time")
	end
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:CheckLimitTimeChapter()
	var_0_0.super.OnEnter(arg_4_0)

	if arg_4_0.activityID_ == ActivityConst.ACTIVITY_SUMMER_MAIN_5_2 then
		arg_4_0:RegistEventListener(SUMMER_RACE_SKIN_UPDATE_5_2, handler(arg_4_0, arg_4_0.OnSummerRaceSkinDlc_5_2))
		manager.redPoint:bindUIandKey(arg_4_0.chapterBtn_.transform, RedPointConst.ACTIVITY_COMMON .. "_" .. ActivityConst.ACTIVITY_SUMMER_MAIN_LIMITTIME_5_2)
	else
		manager.redPoint:bindUIandKey(arg_4_0.chapterBtn_.transform, ActivityTools.GetRedPointKey(arg_4_0.activityID_) .. arg_4_0.activityID_)
	end

	if arg_4_0.redTrs_ then
		local var_4_0 = RedPointConst.ACTIVITY_COMMON .. "_" .. ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC

		manager.redPoint:bindUIandKey(arg_4_0.redTrs_, var_4_0)
	end

	if arg_4_0.videoGo_ and ActivityVersionData:GetFirstEnterActivityFlag(arg_4_0.activityID_) then
		arg_4_0.criManaExMultipleVedio_:PlayByIndex(1)
	end

	ActivityVersionData:SetFirstEnterActivityFlag(arg_4_0.activityID_)
	arg_4_0:SetSkinDlcActivityId()

	if arg_4_0.dlcController_ then
		arg_4_0:RefreshDlcController()
	end
end

function var_0_0.OnSummerRaceSkinDlc_5_2(arg_5_0)
	arg_5_0:RefreshDlcController()
end

function var_0_0.RefreshDlcController(arg_6_0)
	local var_6_0 = ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC
	local var_6_1 = AssignmentCfg.get_id_list_by_activity_id[var_6_0] or {}
	local var_6_2 = 0

	for iter_6_0 = 1, 2 do
		local var_6_3 = var_6_1[iter_6_0]

		if var_6_3 and TaskData2:GetTaskComplete(var_6_3) then
			var_6_2 = var_6_2 + 1
		end
	end

	if var_6_2 == 2 then
		if arg_6_0.getController_ then
			arg_6_0.getController_:SetSelectedIndex(1)
		end

		if arg_6_0.timeController_ then
			arg_6_0.timeController_:SetSelectedIndex(0)
		end
	else
		if arg_6_0.getController_ then
			arg_6_0.getController_:SetSelectedIndex(0)
		end

		if arg_6_0.timeController_ then
			arg_6_0.timeController_:SetSelectedIndex(1)
		end
	end
end

function var_0_0.SetSkinDlcActivityId(arg_7_0)
	local var_7_0 = ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC

	if ActivityData:GetActivityIsOpen(var_7_0) then
		arg_7_0.skinDlcActivityId = var_7_0

		local var_7_1 = ActivityData:GetActivityData(arg_7_0.skinDlcActivityId)

		arg_7_0.startDlcTime_ = var_7_1.startTime
		arg_7_0.stopDlcTime_ = var_7_1.stopTime

		arg_7_0:AddDlcTimer()
	end
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:StopDlcTimer()
	arg_8_0:RemoveAllEventListener()
	var_0_0.super.OnExit(arg_8_0)

	if arg_8_0.activityID_ == ActivityConst.ACTIVITY_SUMMER_MAIN_5_2 then
		manager.redPoint:unbindUIandKey(arg_8_0.chapterBtn_.transform, RedPointConst.ACTIVITY_COMMON .. "_" .. ActivityConst.ACTIVITY_SUMMER_MAIN_LIMITTIME_5_2)
	else
		manager.redPoint:unbindUIandKey(arg_8_0.chapterBtn_.transform, ActivityTools.GetRedPointKey(arg_8_0.activityID_) .. arg_8_0.activityID_)
	end

	if arg_8_0.redTrs_ then
		local var_8_0 = RedPointConst.ACTIVITY_COMMON .. "_" .. ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC

		manager.redPoint:unbindUIandKey(arg_8_0.redTrs_, var_8_0)
	end
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.chapterBtn_, nil, function()
		if ActivityTools.CheckActivityIsSuspended(arg_9_0.activityID_) then
			return
		end

		if not arg_9_0:IsActivityTime() then
			return
		end

		if ActivityChapterPageCfg[arg_9_0.activityID_].chapter_type == 1 then
			local var_10_0 = arg_9_0:GetTargetChapterID()

			if ChapterTools.IsFinishPreChapter(var_10_0) then
				OperationRecorder.RecordButtonTouch({
					button_name = "activity_story_chapter_jump",
					chapter_id = arg_9_0.chapterClientID_
				})
				ChapterTools.GotoChapterSection(var_10_0)

				return
			end

			ShowTips("TIME_OVER")
		else
			OperationRecorder.RecordButtonTouch({
				button_name = "activity_story_chapter_jump",
				chapter_id = arg_9_0.chapterClientID_
			})
			JumpTools.Jump2SubPlot(arg_9_0.chapterClientID_, nil, true)
		end
	end)

	if arg_9_0.dlcBtn_ then
		arg_9_0:AddBtnListener(arg_9_0.dlcBtn_, nil, function()
			JumpTools.OpenPageByJump("summerRaceSkinPopView_5_2")
		end)
	end
end

function var_0_0.CheckLimitTimeChapter(arg_12_0)
	arg_12_0.chapterClientID_ = ActivityChapterPageCfg[arg_12_0.activityID_].chapter_client_id

	if arg_12_0.timeGo_ then
		if ChapterTools.GetChapterShowTypeData(arg_12_0.chapterClientID_) == "limitTime" then
			arg_12_0.timeText_ = arg_12_0.timeGo_.transform:Find("iconbg/texttime"):GetComponent("Text")

			arg_12_0.timeGo_:SetActive(true)
		else
			arg_12_0.timeGo_:SetActive(false)
		end
	end
end

function var_0_0.AddDlcTimer(arg_13_0)
	arg_13_0:StopDlcTimer()
	arg_13_0:RefreshDlcTimeText()

	arg_13_0.dlc_timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_13_0.stopDlcTime_ then
			return
		end

		arg_13_0:RefreshTimeText()
	end, 1, -1)

	arg_13_0.dlc_timer_:Start()
end

function var_0_0.StopDlcTimer(arg_15_0)
	if arg_15_0.dlc_timer_ then
		arg_15_0.dlc_timer_:Stop()

		arg_15_0.dlc_timer_ = nil
	end
end

function var_0_0.RefreshDlcTimeText(arg_16_0)
	if arg_16_0.timeDlcText_ then
		arg_16_0.timeDlcText_.text = manager.time:GetLostTimeStrWith2Unit(arg_16_0.stopTime_, true)
	end
end

return var_0_0
