local var_0_0 = import("game.views.pop.PopFramingBaseView")
local var_0_1 = class("LevelUpView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/Common/Pop/PlayerlvlpopUI"
end

function var_0_1.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.animatorList_ = {
		arg_4_0.animator_1
	}
end

function var_0_1.OnEnter(arg_5_0)
	arg_5_0:RefreshUI()

	arg_5_0.timer_ = FrameTimer.New(function()
		arg_5_0:Update()
	end, 1, -1)

	arg_5_0.timer_:Start()

	arg_5_0.callBack_ = arg_5_0.params_.callback
end

function var_0_1.OnExit(arg_7_0)
	if arg_7_0.timer_ then
		arg_7_0.timer_:Stop()

		arg_7_0.timer_ = nil
	end

	if arg_7_0.callBack_ then
		arg_7_0.callBack_()
	end
end

function var_0_1.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgBtn_, nil, function()
		arg_8_0:Back(true)
	end)
end

function var_0_1.RemoveListeners(arg_10_0)
	return
end

function var_0_1.OnSubscribe(arg_11_0)
	arg_11_0:RefreshUI()
end

function var_0_1.RefreshUI(arg_12_0)
	local var_12_0 = arg_12_0.params_.levelUpInfoList[1].fromLevel
	local var_12_1 = arg_12_0.params_.levelUpInfoList[#arg_12_0.params_.levelUpInfoList].toLevel
	local var_12_2 = GameLevelSetting[var_12_0].fatigue_max
	local var_12_3 = GameLevelSetting[var_12_1].fatigue_max
	local var_12_4 = 0

	for iter_12_0 = var_12_0 + 1, var_12_1 do
		var_12_4 = var_12_4 + GameLevelSetting[iter_12_0].fatigue_upgrade_reward
	end

	arg_12_0.fromLevelText_.text = tostring(var_12_0)
	arg_12_0.toLevelText_.text = tostring(var_12_1)
	arg_12_0.getFatigueText_.text = string.format("+%d", var_12_4)
	arg_12_0.fatigueUpLimitText_.text = string.format("%d(+%d)", var_12_3, var_12_3 - var_12_2)
end

function var_0_1.Update(arg_13_0)
	return
end

function var_0_1.Dispose(arg_14_0)
	var_0_1.super.Dispose(arg_14_0)
end

return var_0_1
