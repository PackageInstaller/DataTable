local var_0_0 = class("ChapterV2MapChapterEndPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Xuheng_PlotMap/XuhengChapterpop01UI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.bgBtn_, nil, function()
		arg_4_0:Back()
	end)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.visitedStr_ = arg_6_0.params_.visitedStr

	saveData("ChapterV2MapData", arg_6_0.visitedStr_, true)
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
