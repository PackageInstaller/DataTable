local var_0_0 = class("ChapterPlotDayItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.chapterID_ = arg_1_3
	arg_1_0.day_ = arg_1_4

	arg_1_0:BindCfgUI()
	arg_1_0:BindCfgUI()
	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = arg_1_0.controllerEx_:GetController("state")
	arg_1_0.dayImageController_ = arg_1_0.controllerEx_:GetController("default1")
	arg_1_0.newDayController_ = arg_1_0.controllerEx_:GetController("newDay")

	arg_1_0:Show(true)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		if arg_2_0.timeLock_ then
			local var_3_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_2_0.chapterID_][arg_2_0.day_][1]
			local var_3_1 = ChapterMapCfg[var_3_0].activity_id
			local var_3_2 = ActivityData:GetActivityData(var_3_1).startTime
			local var_3_3 = GetTips("UNLOCK")

			ShowTips(string.format(var_3_3, manager.time:GetLostTimeStr(var_3_2)))

			return
		end

		if arg_2_0.isLock_ then
			local var_3_4 = ChapterTools.GetChapterDayList(arg_2_0.chapterID_)
			local var_3_5 = var_3_4[table.keyof(var_3_4, arg_2_0.day_) - 1]
			local var_3_6 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_2_0.chapterID_][var_3_5][1]
			local var_3_7 = ChapterMapCfg[var_3_6]

			if var_3_7.name == "" then
				ShowTips(string.format(GetTips("CLEAR_DAY_ALL_STAGE_THEN_UNLOCK"), var_3_5))
			else
				ShowTips(string.format(GetTips("CLEAR_DAY_ALL_STAGE_THEN_UNLOCK_2"), var_3_7.name))
			end

			return
		end

		if not BattleStageData:GetOperateChapterDay(arg_2_0.chapterID_, arg_2_0.day_) then
			BattleStageAction.OperateChapterDay(arg_2_0.chapterID_, arg_2_0.day_, function()
				BattleFieldData:SaveChapterMapDay(arg_2_0.chapterID_, arg_2_0.day_)
				manager.notify:Invoke(CHAPTER_DAY_CHANGED)
			end)
		else
			BattleFieldData:SaveChapterMapDay(arg_2_0.chapterID_, arg_2_0.day_)
			manager.notify:Invoke(CHAPTER_DAY_CHANGED)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.day_ = arg_5_1
	arg_5_0.selectDay_ = arg_5_2
	arg_5_0.isLock_ = not ChapterTools.IsClearPreChapterDayAllStage(arg_5_0.chapterID_, arg_5_1)

	local var_5_0 = ChapterTools.GetChapterDayList(arg_5_0.chapterID_)

	if table.keyof(var_5_0, arg_5_1) == 2 then
		local var_5_1 = var_5_0[1]

		if ChapterTools.IsNeedOperateFirstDayWatch(arg_5_0.chapterID_, var_5_1) then
			arg_5_0.isLock_ = true
		end
	end

	if ChapterTools.IsLastDay(arg_5_0.chapterID_, arg_5_1) and not BattleStageData:GetOperateChapterDay(arg_5_0.chapterID_, arg_5_1) then
		arg_5_0.isLock_ = true
	end

	local var_5_2 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_5_0.chapterID_][arg_5_1][1]
	local var_5_3 = ChapterMapCfg[var_5_2]

	arg_5_0.timeLock_ = ActivityTools.GetActivityStatus(var_5_3.activity_id) == 0

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_6_0.chapterID_][arg_6_0.day_][1]
	local var_6_1 = ChapterMapCfg[var_6_0]

	if var_6_1.icon_id ~= "" then
		arg_6_0.dayImage_.sprite = getSprite("Atlas/OperationAtlas", var_6_1.icon_id)

		arg_6_0.dayImageController_:SetSelectedState("image")
	else
		arg_6_0.dayText_.text = string.format("%s", arg_6_0.day_)

		arg_6_0.dayImageController_:SetSelectedState("num")
	end

	if arg_6_0.selectDay_ == arg_6_0.day_ then
		arg_6_0.stateController_:SetSelectedState("select")
	elseif arg_6_0.isLock_ or arg_6_0.timeLock_ then
		arg_6_0.stateController_:SetSelectedState("lock")
	else
		arg_6_0.stateController_:SetSelectedState("unlock")
	end

	arg_6_0:RefreshGuild()
	arg_6_0:AddTimer()
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:StopTimer()
	var_0_0.super.Dispose(arg_8_0)
	Object.Destroy(arg_8_0.gameObject_)

	arg_8_0.gameObject_ = nil
	arg_8_0.transform_ = nil
end

function var_0_0.RefreshGuild(arg_9_0)
	if ChapterTools.IsNeedGuildDay(arg_9_0.chapterID_, arg_9_0.day_) then
		arg_9_0.newDayController_:SetSelectedState("true")
	else
		arg_9_0.newDayController_:SetSelectedState("false")
	end
end

function var_0_0.AddTimer(arg_10_0)
	arg_10_0:StopTimer()

	if arg_10_0.timeLock_ then
		local var_10_0 = ChapterMapCfg.get_id_list_by_chapter_id_day[arg_10_0.chapterID_][arg_10_0.day_][1]
		local var_10_1 = ChapterMapCfg[var_10_0].activity_id

		arg_10_0.timer_ = Timer.New(function()
			local var_11_0 = ActivityData:GetActivityData(var_10_1)
			local var_11_1 = manager.time:GetServerTime()

			if var_11_0 and var_11_1 >= var_11_0.startTime then
				arg_10_0.timeLock_ = false

				arg_10_0:RefreshUI()
				arg_10_0:StopTimer()
			end
		end, 1, -1)

		arg_10_0.timer_:Start()
	end
end

function var_0_0.StopTimer(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

return var_0_0
