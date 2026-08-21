local var_0_0 = class("OsirisPlayGameTipsView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Osiris/Activity_Osiris_tips"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_5_0)
	local var_5_0 = ActivityGeneralityChapterCfg[arg_5_0.params_.chapterID + 1]

	arg_5_0.nameText_.text = string.format(GetTips("ACTIVITY_GENERALITY_CHAPTER_UNLOCK"), GetI18NText(var_5_0.chapter_name))

	OsirisPlayGameData:SetFirstUnlock(arg_5_0.params_.chapterID + 1)
	arg_5_0:StopTimer()

	arg_5_0.timer_ = Timer.New(function()
		arg_5_0:StopTimer()
		arg_5_0:Back()
	end, 1.5, 1)

	arg_5_0.timer_:Start()
end

function var_0_0.StopTimer(arg_7_0)
	if arg_7_0.timer_ then
		arg_7_0.timer_:Stop()

		arg_7_0.timer_ = nil
	end
end

function var_0_0.AddUIListener(arg_8_0)
	return
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:StopTimer()
	var_0_0.super.OnExit(arg_9_0)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
