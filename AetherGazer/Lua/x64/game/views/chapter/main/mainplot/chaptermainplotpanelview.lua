local var_0_0 = class("ChapterMainPanelView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()

	arg_1_0.chapterImage_.immediate = true

	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "early")
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.showChapterClientID_, arg_2_0.activityID_ = ChapterTools.GetOptimalChapterClientID()

	arg_2_0:RefreshUI()
end

function var_0_0.OnExit(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		JumpTools.GoToSystem("/chapterMapContent")
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = ChapterClientCfg[arg_7_0.showChapterClientID_]
	local var_7_1 = SpritePathCfg.ChapterPaint.path .. var_7_0.chapter_paint_2

	arg_7_0.chapterImage_.spriteAsync = var_7_1
	arg_7_0.chapterNameText_.text = var_7_0.name
	arg_7_0.chapterDescText_.text = var_7_0.desc

	arg_7_0:RefreshActivityState()
end

function var_0_0.RefreshActivityState(arg_8_0)
	if arg_8_0.activityID_ ~= 0 then
		arg_8_0.controller_:SetSelectedState("yes")
	else
		arg_8_0.controller_:SetSelectedState("no")
	end
end

return var_0_0
