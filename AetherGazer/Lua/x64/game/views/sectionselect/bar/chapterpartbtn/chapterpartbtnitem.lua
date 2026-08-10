local var_0_0 = class("ChpaterPartBtnItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.index_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.choiceController_ = ControllerUtil.GetController(arg_1_0.transform_, "choice")
	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
end

function var_0_0.OnEnter(arg_2_0)
	return
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:UnBindRedPoint(arg_3_0.chapterID_)

	arg_3_0.chapterID_ = nil

	arg_3_0:StopTimer()
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		if arg_5_0.selectChapterID_ == arg_5_0.chapterID_ then
			return
		end

		if arg_5_0.toggleType_ == BattleConst.TOGGLE.PLOT then
			ChapterTools.GotoChapterSection(arg_5_0.chapterID_)
		else
			JumpTools.Jump2SubPlotByChapterID(arg_5_0.chapterID_)
		end
	end)
end

function var_0_0.SetChapterID(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.selectChapterID_ = arg_7_2

	arg_7_0:UnBindRedPoint(arg_7_0.chapterID_)
	arg_7_0:BindRedPoint(arg_7_1)

	arg_7_0.chapterID_ = arg_7_1
	arg_7_0.toggleType_ = getChapterClientCfgByChapterID(arg_7_0.chapterID_).toggle

	local var_7_0 = arg_7_1 == arg_7_2

	arg_7_0.choiceController_:SetSelectedState(tostring(var_7_0))
	arg_7_0:UpdateNameText()
	arg_7_0:AddTimer()
end

local var_0_1 = {
	{
		"MAIN_STORY_TAB_1",
		"MAIN_STORY_TAB_2"
	},
	{
		"MAIN_STORY_TAB_1",
		"MAIN_STORY_TAB_3"
	},
	{
		"MAIN_STORY_TAB_1",
		"MAIN_STORY_TAB_2",
		"MAIN_STORY_TAB_3"
	}
}

function var_0_0.UpdateNameText(arg_8_0)
	local var_8_0 = getChapterClientCfgByChapterID(arg_8_0.chapterID_)

	if var_8_0.id == ChapterConst.CHAPTER_CLIENT_XUHENG_PART_2_2 or var_8_0.id == ChapterConst.CHAPTER_CLIENT_21 then
		local var_8_1 = #var_8_0.chapter_list

		if SettingData:GetCurrentLanguage() == "en" and var_8_1 == 2 then
			arg_8_0.nameText_.text = GetTips(var_0_1[1][arg_8_0.index_])
		else
			arg_8_0.nameText_.text = GetTips(var_0_1[var_8_1][arg_8_0.index_])
		end
	else
		arg_8_0.nameText_.text = ChapterCfg[arg_8_0.chapterID_].subhead
	end
end

function var_0_0.BindRedPoint(arg_9_0, arg_9_1)
	if arg_9_0.toggleType_ == nil then
		arg_9_0.toggleType_ = getChapterClientCfgByChapterID(arg_9_1).toggle
	end

	if arg_9_0.toggleType_ == BattleConst.TOGGLE.PLOT then
		manager.redPoint:bindUIandKey(arg_9_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, arg_9_1))
	else
		manager.redPoint:bindUIandKey(arg_9_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_9_1))
	end
end

function var_0_0.UnBindRedPoint(arg_10_0, arg_10_1)
	if arg_10_1 then
		if arg_10_0.toggleType_ == BattleConst.TOGGLE.PLOT then
			manager.redPoint:unbindUIandKey(arg_10_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER, arg_10_1))
		else
			manager.redPoint:unbindUIandKey(arg_10_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_10_1))
		end
	end
end

function var_0_0.AddTimer(arg_11_0)
	arg_11_0:StopTimer()

	local var_11_0 = getChapterClientCfgByChapterID(arg_11_0.chapterID_)
	local var_11_1 = table.keyof(var_11_0.chapter_list, arg_11_0.chapterID_)

	if var_11_1 > 1 then
		local var_11_2 = var_11_0.chapter_list[var_11_1 - 1]

		if not ChapterTools.IsClearChapter(var_11_2) then
			arg_11_0.lockController_:SetSelectedState("lock")

			return
		end
	end

	local var_11_3

	if arg_11_0.toggleType_ == BattleConst.TOGGLE.PLOT then
		var_11_3 = ChapterCfg[arg_11_0.chapterID_].unlock_activity_id
	else
		var_11_3 = ChapterCfg[arg_11_0.chapterID_].activity_id
	end

	local var_11_4

	if arg_11_0.toggleType_ == BattleConst.TOGGLE.PLOT then
		var_11_4 = ActivityData:GetActivityData(var_11_3).startTime
	else
		var_11_4 = ActivityData:GetActivityRefreshTime(var_11_3)
	end

	if var_11_4 <= manager.time:GetServerTime() then
		arg_11_0.lockController_:SetSelectedState("unlock")

		return
	end

	arg_11_0.lockController_:SetSelectedState("lock")

	arg_11_0.timer_ = Timer.New(function()
		if var_11_4 <= manager.time:GetServerTime() then
			arg_11_0.lockController_:SetSelectedState("unlock")
			arg_11_0:StopTimer()

			return
		end
	end, 1, -1)

	arg_11_0.timer_:Start()
end

function var_0_0.SetActive(arg_13_0, arg_13_1)
	SetActive(arg_13_0.gameObject_, arg_13_1)
end

function var_0_0.StopTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()

		arg_14_0.timer_ = nil
	end
end

return var_0_0
