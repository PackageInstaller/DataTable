local var_0_0 = class("SummerStoryMainItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.chapterID_ = arg_1_2

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
end

function var_0_0.OnEnter(arg_2_0)
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
		arg_5_0:Go("/summerStageMain", {
			theme = ActivityConst.THEME.SUMMER,
			chapterID = arg_5_0.chapterID_
		})
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = #ActivityStoryChapterCfg[arg_7_0.chapterID_].stage_list
	local var_7_1 = 0

	for iter_7_0, iter_7_1 in pairs(StoryStageActivityData:GetStageData(arg_7_0.chapterID_)) do
		if iter_7_1.clear_times > 0 then
			var_7_1 = var_7_1 + 1
		end
	end

	local var_7_2 = var_7_1 / var_7_0

	arg_7_0.progressText_.text = string.format("%d%%", var_7_2 * 100)
	arg_7_0.slider_.fillAmount = var_7_2

	if var_7_2 < 1 then
		arg_7_0.controller_:SetSelectedState("enter")
	else
		arg_7_0.controller_:SetSelectedState("false")
	end
end

return var_0_0
