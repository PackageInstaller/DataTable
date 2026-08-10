BattleFailedView = import("game.views.battleFailed.BattleFailedView")

local var_0_0 = class("XH3rdWaterBattleCooperationFailedView", BattleFailedView)

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)

	local var_1_0, var_1_1 = arg_1_0.params_.stageData:GetIsCooperation()

	if var_1_0 then
		SetActive(arg_1_0.btnBattleCount_.gameObject, false)
	else
		SetActive(arg_1_0.btnBattleCount_.gameObject, true)
	end
end

function var_0_0.OnExit(arg_2_0)
	var_0_0.super.OnExit(arg_2_0)
end

function var_0_0.GoToBattleStatistics(arg_3_0)
	if arg_3_0.isEnd then
		return
	end

	arg_3_0.toStat_ = true

	arg_3_0:RemoveTimer()
	JumpTools.OpenPageByJump("xH3rdWaterBattleStatistics", {
		stageData = arg_3_0.stageData,
		battleTime = arg_3_0:GetBattleTime()
	})
end

function var_0_0.Quit(arg_4_0)
	arg_4_0.isEnd = true

	arg_4_0:RemoveTimer()

	arg_4_0.timer_ = Timer.New(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()

		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			CooperationTools.GotoCooperationEntry(arg_4_0.params_.stageData:GetType(), arg_4_0.params_.stageData:GetDest(), arg_4_0.params_.stageData:GetActivityID())
		end
	end, 1, 1)

	arg_4_0.timer_:Start()
	arg_4_0.animator_:Play("battleFailed_out")
end

function var_0_0.RecordThreeStar(arg_6_0)
	return
end

return var_0_0
