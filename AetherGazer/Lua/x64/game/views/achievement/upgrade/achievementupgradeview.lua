local var_0_0 = class("AchievementUpgradeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/AchievementsUI/AchievementUpgradeUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = arg_4_0.params_.currentPoint / arg_4_0.params_.upgradePoint

	LeanTween.value(arg_4_0.gameObject_, var_4_0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
		arg_4_0.slider_.value = arg_5_0
	end)):setOnComplete(System.Action(function()
		arg_4_0.canCancel_ = true

		LeanTween.cancel(arg_4_0.gameObject_)
	end))
end

function var_0_0.OnExit(arg_7_0)
	LeanTween.cancel(arg_7_0.gameObject_)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.buttonClose_, nil, function()
		if arg_9_0.canCancel_ then
			arg_9_0:Back()
		end
	end)
end

return var_0_0
