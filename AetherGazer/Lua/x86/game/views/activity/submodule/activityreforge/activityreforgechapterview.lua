local var_0_0 = class("ActivityReforgeChapterView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeChapterUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0.gameHelpKey_ = "ACTIVITY_REFORGE_GAMEHELPKEY"

	arg_4_0:BindCfgUI()

	arg_4_0.curSelectIndex_ = 1
	arg_4_0.btnControllerList_ = {}

	for iter_4_0 = 1, 4 do
		arg_4_0.btnControllerList_[iter_4_0] = arg_4_0["chapterListContEx" .. iter_4_0 .. "_"]:GetController("status")
	end

	arg_4_0.bossChartController_ = arg_4_0.controllerEx_:GetController("bosschart")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.goldInfoBtn_, nil, function()
		JumpTools.OpenPageByJump("activityReforgeGoldInfoView")
	end)
	arg_5_0:AddBtnListener(arg_5_0.taskBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeTaskView", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.skillBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewType = 1,
			activityID = arg_5_0.activityID_,
			chapterActivityID = arg_5_0.chapterActivityID_,
			levelID = arg_5_0.levelID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.levelBtn_, nil, function()
		JumpTools.OpenPageByJump("/activityReforgeLevelView", {
			activityID = arg_5_0.activityID_,
			chapterActivityID = arg_5_0.chapterIDList_[arg_5_0.curSelectIndex_]
		})
	end)

	for iter_5_0 = 1, 4 do
		arg_5_0:AddBtnListener(arg_5_0["chapterBtn" .. iter_5_0 .. "_"], nil, function()
			if iter_5_0 ~= arg_5_0.curSelectIndex_ then
				return
			end

			JumpTools.OpenPageByJump("/activityReforgeLevelView", {
				activityID = arg_5_0.activityID_,
				chapterActivityID = arg_5_0.chapterIDList_[iter_5_0]
			})
		end)
		arg_5_0:AddBtnListener(arg_5_0["chapterListBtn" .. iter_5_0 .. "_"], nil, function()
			if iter_5_0 == arg_5_0.curSelectIndex_ then
				return
			end

			local var_11_0 = arg_5_0.chapterIDList_[iter_5_0]

			if ActivityTools.GetActivityIsOpenWithTip(var_11_0) then
				if ActivityReforgeData:GetChapterIsUnlock(var_11_0) then
					arg_5_0.curSelectIndex_ = iter_5_0

					arg_5_0:RefreshUI()
					arg_5_0.bossAni_:Play("boss02_refresh")
				else
					ShowTips("ACTIVITY_REFORGE_CHPATER_LOCK")
				end
			end
		end)
	end
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.activityID_ = arg_12_0.params_.ActivityID
	arg_12_0.chapterIDList_ = ActivityCfg[arg_12_0.activityID_].sub_activity_list
	arg_12_0.goldMaxNum_.text = ActivityReforgeData:GetGoldMaxNum(arg_12_0.activityID_)

	arg_12_0:CreateTimer()
	arg_12_0:RefreshUI()
	arg_12_0:BindRedPoint()
	arg_12_0:CheckCacheAddGoldNum()
end

function var_0_0.BindRedPoint(arg_13_0)
	local var_13_0 = RedPointConst.ACTIVITY_REFORGE_SKILL .. arg_13_0.activityID_

	manager.redPoint:bindUIandKey(arg_13_0.skillBtn_.transform, var_13_0)

	local var_13_1 = RedPointConst.ACTIVITY_REFORGE_TASK .. arg_13_0.activityID_

	manager.redPoint:bindUIandKey(arg_13_0.taskBtn_.transform, var_13_1)

	for iter_13_0 = 1, 4 do
		local var_13_2 = arg_13_0.chapterIDList_[iter_13_0]
		local var_13_3 = RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. var_13_2

		manager.redPoint:bindUIandKey(arg_13_0["chapterListBtn" .. iter_13_0 .. "_"].transform, var_13_3)
	end
end

function var_0_0.UnBindRedPoint(arg_14_0)
	local var_14_0 = RedPointConst.ACTIVITY_REFORGE_SKILL .. arg_14_0.activityID_

	manager.redPoint:unbindUIandKey(arg_14_0.skillBtn_.transform, var_14_0)

	local var_14_1 = RedPointConst.ACTIVITY_REFORGE_TASK .. arg_14_0.activityID_

	manager.redPoint:unbindUIandKey(arg_14_0.taskBtn_.transform, var_14_1)

	for iter_14_0 = 1, 4 do
		local var_14_2 = arg_14_0.chapterIDList_[iter_14_0]
		local var_14_3 = RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. var_14_2

		manager.redPoint:unbindUIandKey(arg_14_0["chapterListBtn" .. iter_14_0 .. "_"].transform, var_14_3)
	end
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(arg_15_0.gameHelpKey_)
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()
	arg_16_0:UnBindRedPoint()
	arg_16_0:StopTimer()
	arg_16_0:StopAddGoldNumTimer()
end

function var_0_0.CreateTimer(arg_17_0)
	arg_17_0.activityID_ = arg_17_0.activityID_
	arg_17_0.stopTime_ = ActivityData:GetActivityData(arg_17_0.activityID_).stopTime

	if manager.time:GetServerTime() < arg_17_0.stopTime_ then
		arg_17_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_17_0.stopTime_)
	else
		arg_17_0:StopTimer()

		arg_17_0.timeText_.text = GetTips("TIME_OVER")
	end

	if arg_17_0.timer_ == nil then
		arg_17_0.timer_ = Timer.New(function()
			if manager.time:GetServerTime() < arg_17_0.stopTime_ then
				arg_17_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(arg_17_0.stopTime_)
			else
				arg_17_0:StopTimer()

				arg_17_0.timeText_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)

		arg_17_0.timer_:Start()
	end
end

function var_0_0.StopTimer(arg_19_0)
	if arg_19_0.timer_ then
		arg_19_0.timer_:Stop()

		arg_19_0.timer_ = nil
	end
end

function var_0_0.StopAddGoldNumTimer(arg_20_0)
	if arg_20_0.addGoldNumCacheTimer_ then
		arg_20_0.addGoldNumCacheTimer_:Stop()

		arg_20_0.addGoldNumCacheTimer_ = nil
	end
end

function var_0_0.RefreshUI(arg_21_0)
	for iter_21_0 = 1, 4 do
		local var_21_0 = arg_21_0.chapterIDList_[iter_21_0]

		if ActivityReforgeData:GetChapterIsUnlock(var_21_0) then
			if arg_21_0.curSelectIndex_ == iter_21_0 then
				arg_21_0.btnControllerList_[iter_21_0]:SetSelectedState("on")
			else
				arg_21_0.btnControllerList_[iter_21_0]:SetSelectedState("off")
			end
		else
			arg_21_0.btnControllerList_[iter_21_0]:SetSelectedState("lock")
		end
	end

	local var_21_1 = arg_21_0.chapterIDList_[arg_21_0.curSelectIndex_]
	local var_21_2 = ActivityReforgeChapterCfg[var_21_1]

	arg_21_0.nameText_.text = var_21_2.chapter_name
	arg_21_0.desText_.text = var_21_2.chapter_des

	arg_21_0.bossChartController_:SetSelectedState(arg_21_0.curSelectIndex_)
end

function var_0_0.CheckCacheAddGoldNum(arg_22_0)
	local var_22_0 = ActivityReforgeData:GetCacheAddGoldNum()

	if var_22_0 > 0 then
		arg_22_0.goldAddText_.text = "+" .. var_22_0

		SetActive(arg_22_0.goldAddGo_, true)
		arg_22_0:StopAddGoldNumTimer()

		arg_22_0.addGoldNumCacheTimer_ = Timer.New(function()
			arg_22_0:StopAddGoldNumTimer()
			SetActive(arg_22_0.goldAddGo_, false)

			arg_22_0.goldMaxNum_.text = ActivityReforgeData:SubGoldMaxNum(arg_22_0.activityID_, var_22_0)

			ActivityReforgeData:ClearCacheAddGoldNum()
		end, 2, 1)

		arg_22_0.addGoldNumCacheTimer_:Start()
	else
		SetActive(arg_22_0.goldAddGo_, false)
	end
end

function var_0_0.Dispose(arg_24_0)
	arg_24_0:StopTimer()
	arg_24_0:StopAddGoldNumTimer()
	arg_24_0.super.Dispose(arg_24_0)
end

return var_0_0
