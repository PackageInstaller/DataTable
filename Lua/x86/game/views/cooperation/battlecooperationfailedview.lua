local var_0_0 = class("BattleCooperationFailedView", BattleFailedView)

function var_0_0.OnEnter(arg_1_0)
	BattleInstance.hideBattlePanel()
	arg_1_0:RecordThreeStar()

	arg_1_0.startTime = Time.realtimeSinceStartup
	arg_1_0.isEnd = false

	if arg_1_0.params_.data_math_error then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("COOPERATION_DATA_ERROR"),
			OkCallback = function()
				arg_1_0:Quit()
			end
		})
	else
		arg_1_0:RemoveTimer()

		arg_1_0.timer_ = Timer.New(function()
			arg_1_0:Quit()
		end, arg_1_0.stayTime, 1)

		arg_1_0.timer_:Start()
	end

	arg_1_0.battleTimeText_.text = arg_1_0:GetBattleTime()

	arg_1_0.animator_:Play("battleFailed")
end

function var_0_0.QuitUI(arg_4_0)
	DestroyLua()
	LuaExchangeHelper.GoToMain()

	if CooperationData:GetRoomData() then
		CooperationTools.GotoCooperation()
	else
		CooperationTools.GotoCooperationEntry(arg_4_0.params_.stageData:GetType(), arg_4_0.params_.stageData:GetDest(), arg_4_0.params_.stageData:GetActivityID())
	end
end

function var_0_0.RecordThreeStar(arg_5_0)
	return
end

return var_0_0
