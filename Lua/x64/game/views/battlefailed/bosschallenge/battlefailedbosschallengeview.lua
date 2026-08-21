NewBattleFailedWithButtonView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedWithButtonView")

local var_0_0 = class("BattleFailedBossChallengeView", NewBattleFailedWithButtonView)

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)
end

function var_0_0.OnExit(arg_2_0)
	var_0_0.super.OnExit(arg_2_0)
end

function var_0_0.AddTimer(arg_3_0)
	arg_3_0:StopTimer()

	arg_3_0.timer_ = Timer.New(function()
		arg_3_0:QuitUI()
	end, 20, 1)

	arg_3_0.timer_:Start()
end

function var_0_0.StopTimer(arg_5_0)
	if arg_5_0.timer_ then
		arg_5_0.timer_:Stop()

		arg_5_0.timer_ = nil
	end
end

return var_0_0
