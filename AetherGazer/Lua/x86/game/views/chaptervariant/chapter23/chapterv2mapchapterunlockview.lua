local var_0_0 = class("ChapterV2MapChapterUnlockView", ReduxView)

function var_0_0.UIName(arg_1_0)
	local var_1_0 = arg_1_0.params_.chapterId
	local var_1_1 = ChapterV2ChapterCfg[var_1_0]

	if string.isNullOrEmpty(var_1_1.prefab) then
		Debug.LogError(string.format("ChapterV2ChapterCfg[%d]的预制体为空", var_1_0))
	end

	return var_1_1.prefab
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Cacheable(arg_3_0)
	return false
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListeners()
end

function var_0_0.AddListeners(arg_5_0)
	if arg_5_0.bgBtn_ then
		arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
			arg_5_0:Back()
		end)
	else
		Debug.LogError(string.format("%s 预制体没有用于点击返回的按钮", arg_5_0:UIName()))
	end
end

function var_0_0.OnEnter(arg_7_0)
	local var_7_0 = arg_7_0.params_.chapterId

	saveData("ChapterV2MapData", "chapter_pop_" .. var_7_0, true)
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.OnExitInput(arg_9_0)
	JumpTools.Back()

	return true
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
