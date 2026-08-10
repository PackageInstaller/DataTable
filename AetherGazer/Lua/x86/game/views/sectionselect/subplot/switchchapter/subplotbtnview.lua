local var_0_0 = class("SubPlotBtnView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()

	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")

	arg_1_0:SetData(arg_1_3)
	arg_1_0:RefreshItem()
	arg_1_0:Show(true)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()
end

function var_0_0.OnEnter(arg_3_0)
	return
end

function var_0_0.OnExit(arg_4_0)
	arg_4_0:UnBindRedPoint(arg_4_0.chapterID_)
	arg_4_0:StopTimer()
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.transform_ = nil
	arg_5_0.btn_ = nil
	arg_5_0.gameObject_ = nil
	arg_5_0.text_ = nil
	arg_5_0.canvasGroup_ = nil
	arg_5_0.unsubscribeFun = nil
	arg_5_0.selector_ = nil
	arg_5_0.lockGo_ = nil
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0:UnBindRedPoint(arg_6_0.chapterID_)
	arg_6_0:BindRedPoint(arg_6_1)

	arg_6_0.chapterID_ = arg_6_1

	arg_6_0:RefreshItem()
	arg_6_0:Show(true)
	arg_6_0:AddTimer()
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btn_, nil, function()
		if not ChapterTools.IsUnlockChapter(arg_7_0.chapterID_) then
			local var_8_0 = ChapterCfg[arg_7_0.chapterID_].activity_id
			local var_8_1 = ActivityData:GetActivityData(var_8_0)

			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_8_1.startTime)))

			return
		end

		local var_8_2 = getChapterClientCfgByChapterID(arg_7_0.chapterID_)
		local var_8_3 = table.keyof(var_8_2.chapter_list, arg_7_0.chapterID_)

		if var_8_3 > 1 then
			local var_8_4 = var_8_2.chapter_list[var_8_3 - 1]

			if not ChapterTools.IsClearChapter(var_8_4) then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), "", ChapterCfg[var_8_4].subhead))

				return
			end
		end

		BattleStageAction.ClickSubPlot(arg_7_0.chapterID_)
		manager.notify:Invoke(CHANGE_CHAPTER, arg_7_0.chapterID_)
	end)
end

function var_0_0.BindRedPoint(arg_9_0, arg_9_1)
	manager.redPoint:bindUIandKey(arg_9_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_9_1))
end

function var_0_0.UnBindRedPoint(arg_10_0, arg_10_1)
	if arg_10_1 then
		manager.redPoint:unbindUIandKey(arg_10_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_10_1))
	end
end

function var_0_0.RefreshItem(arg_11_0)
	arg_11_0.text_.text = GetI18NText(ChapterCfg[arg_11_0.chapterID_].subhead)
	arg_11_0.text2_.text = GetI18NText(ChapterCfg[arg_11_0.chapterID_].subhead)
end

function var_0_0.Show(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)
end

function var_0_0.SetSiblingIndex(arg_13_0, arg_13_1)
	arg_13_0.transform_:SetSiblingIndex(arg_13_1)
end

function var_0_0.AddTimer(arg_14_0)
	arg_14_0:StopTimer()

	local var_14_0 = getChapterClientCfgByChapterID(arg_14_0.chapterID_)
	local var_14_1 = table.keyof(var_14_0.chapter_list, arg_14_0.chapterID_)

	if var_14_1 > 1 then
		local var_14_2 = var_14_0.chapter_list[var_14_1 - 1]

		if not ChapterTools.IsClearChapter(var_14_2) then
			arg_14_0.lockController_:SetSelectedState("off")

			return
		end
	end

	local var_14_3 = ChapterCfg[arg_14_0.chapterID_].activity_id
	local var_14_4 = ActivityData:GetActivityData(var_14_3)

	if var_14_4.startTime <= manager.time:GetServerTime() then
		arg_14_0.lockController_:SetSelectedState("on")

		return
	end

	arg_14_0.lockController_:SetSelectedState("off")

	arg_14_0.timer_ = Timer.New(function()
		if var_14_4.startTime <= manager.time:GetServerTime() then
			arg_14_0.lockController_:SetSelectedState("on")
			arg_14_0:StopTimer()

			return
		end
	end, 1, -1)

	arg_14_0.timer_:Start()
end

function var_0_0.StopTimer(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

return var_0_0
