local var_0_0 = class("AchievementStoryInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/AchievementsUI/AchievementStoryInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = AchievementStoryCfg[arg_4_0.params_.storyID]

	SetActive(arg_4_0.imageBg_.gameObject, var_4_0.bg ~= "")

	if var_4_0.bg ~= "" then
		arg_4_0.imageBg_.sprite = getSpriteViaConfig("Loading", var_4_0.bg)
	end

	arg_4_0.textTitle_.text = GetI18NText(var_4_0.name)
	arg_4_0.textContent_.text = GetI18NText(var_4_0.desc)
	arg_4_0.scrollView_.verticalNormalizedPosition = 1
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buttonClose_, nil, function()
		arg_7_0:Back()
	end)
end

return var_0_0
