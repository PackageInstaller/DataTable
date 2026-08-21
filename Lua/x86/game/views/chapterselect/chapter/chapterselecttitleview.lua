local var_0_0 = class("ChapterSelectTitleView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.titleTagController_ = arg_1_0.titleControllerEx_:GetController("showTag")
end

function var_0_0.OnEnter(arg_2_0, arg_2_1)
	if arg_2_0.chapterClientID_ then
		arg_2_0:UnBindRedPoint()
	end

	arg_2_0.chapterClientID_ = arg_2_1

	arg_2_0:BindRedPoint()
	arg_2_0:RefreshUI()
end

function var_0_0.OnExit(arg_3_0)
	arg_3_0:UnBindRedPoint()

	if arg_3_0.timer_ then
		arg_3_0.timer_:Stop()

		arg_3_0.timer_ = nil
	end

	arg_3_0.chapterClientID_ = nil
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.BindRedPoint(arg_5_0)
	if ChapterClientCfg[arg_5_0.chapterClientID_].toggle == BattleConst.TOGGLE.PLOT then
		manager.redPoint:bindUIandKey(arg_5_0.redPointTransform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, arg_5_0.chapterClientID_))
	elseif ChapterClientCfg[arg_5_0.chapterClientID_].toggle == BattleConst.TOGGLE.SUB_PLOT then
		manager.redPoint:bindUIandKey(arg_5_0.redPointTransform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, arg_5_0.chapterClientID_))
	end
end

function var_0_0.UnBindRedPoint(arg_6_0)
	if ChapterClientCfg[arg_6_0.chapterClientID_].toggle == BattleConst.TOGGLE.PLOT then
		manager.redPoint:unbindUIandKey(arg_6_0.redPointTransform_, string.format("%s_%s", RedPointConst.COMBAT_PLOT, arg_6_0.chapterClientID_))
	elseif ChapterClientCfg[arg_6_0.chapterClientID_].toggle == BattleConst.TOGGLE.SUB_PLOT then
		manager.redPoint:unbindUIandKey(arg_6_0.redPointTransform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, arg_6_0.chapterClientID_))
	end
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = arg_7_0.chapterClientID_
	local var_7_1 = ChapterClientCfg[var_7_0]

	arg_7_0.chapterIndexText_.text = var_7_1.desc
	arg_7_0.chapterNameText_.text = var_7_1.name

	local var_7_2 = ChapterTools.GetChapterShowTypeData(var_7_0)

	arg_7_0.titleTagController_:SetSelectedState(var_7_2)

	if var_7_2 == "limitTime" then
		if arg_7_0.timer_ then
			arg_7_0.timer_:Stop()

			arg_7_0.timer_ = nil
		end

		local var_7_3, var_7_4 = ActivityData:GetActivityTime(ChapterCfg[var_7_1.chapter_list[1]].activity_id)

		arg_7_0.timeText_.text = manager.time:GetLostTimeStr2(var_7_4)
		arg_7_0.timer_ = Timer.New(function()
			arg_7_0.timeText_.text = manager.time:GetLostTimeStr2(var_7_4)
		end, 1, -1)

		arg_7_0.timer_:Start()
	end

	local var_7_5 = ChapterTools.GetChapterClientFinishPercentage(var_7_0)

	arg_7_0.percentageImage_.fillAmount = var_7_5
	arg_7_0.percentageText_.text = string.format("%s<size=28>%%</size>", math.floor(var_7_5 * 100))
end

return var_0_0
