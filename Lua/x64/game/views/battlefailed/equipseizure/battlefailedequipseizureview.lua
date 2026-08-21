BattleFailedView = import("game.views.battleFailed.BattleFailedView")

local var_0_0 = class("BattleFailedEquipSeizureView", BattleFailedView)

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)
	arg_1_0:AddTimer()
end

function var_0_0.OnExit(arg_2_0)
	var_0_0.super.OnExit(arg_2_0)
	arg_2_0:StopTimer()
end

function var_0_0.AddTimer(arg_3_0)
	arg_3_0:StopTimer()

	arg_3_0.timer_ = Timer.New(function()
		arg_3_0:Quit()
	end, 20, 1)

	arg_3_0.timer_:Start()
end

function var_0_0.StopTimer(arg_5_0)
	if arg_5_0.timer_ then
		arg_5_0.timer_:Stop()

		arg_5_0.timer_ = nil
	end
end

function var_0_0.QuitUI(arg_6_0)
	gameContext:Go("/battleScorResult", {
		stageData = arg_6_0.params_.stageData,
		rewardList = arg_6_0.params_.rewardList,
		score = arg_6_0.params_.score,
		battleResult = arg_6_0.params_.battleResult
	})
end

return var_0_0
