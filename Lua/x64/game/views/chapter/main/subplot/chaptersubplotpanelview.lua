local var_0_0 = class("ChapterSubPlotPanelView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
	arg_1_0.titleTagController_ = arg_1_0.controllerEx_:GetController("showTag")
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.isLock_ = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT)

	manager.redPoint:bindUIandKey(arg_2_0.transform_, RedPointConst.COMBAT_SUB_PLOT)
	arg_2_0:RefreshUI()
end

function var_0_0.OnExit(arg_3_0)
	manager.redPoint:unbindUIandKey(arg_3_0.transform_, RedPointConst.COMBAT_SUB_PLOT)

	if arg_3_0.timer_ then
		arg_3_0.timer_:Stop()

		arg_3_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		JumpTools.GoToSystem("/chapterSubPlotContent", {}, ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT)
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = ChapterTools.GetOpenSubPlotClient()
	local var_7_1 = ChapterClientCfg[var_7_0]
	local var_7_2 = SpritePathCfg.ChapterPaint.path .. var_7_1.chapter_paint_2

	if var_7_1.show_tag_type == ChapterConst.SHOW_TYPE.LIMIT_TIME then
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

	SetSpriteWithoutAtlasAsync(arg_7_0.chapterImage_, var_7_2)
	arg_7_0.titleTagController_:SetSelectedState(ChapterTools.GetChapterShowTypeData(var_7_0))

	arg_7_0.chapterNameText_.text = var_7_1.name
	arg_7_0.chapterDescText_.text = var_7_1.desc

	local var_7_5 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT)

	if var_7_5 then
		arg_7_0.lockText_.text = JumpTools.GetSystemLockedTip(ViewConst.SYSTEM_ID.BATTLE_SUB_PLOT, var_7_5)
	end
end

function var_0_0.RefreshLockState(arg_9_0)
	if arg_9_0.isLock_ then
		arg_9_0.controller_:SetSelectedState("true")
	else
		arg_9_0.controller_:SetSelectedState("false")
	end
end

return var_0_0
