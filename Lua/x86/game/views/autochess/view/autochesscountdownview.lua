local var_0_0 = class("AutoChessCountDownView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()

	arg_2_0.updateTimeHandler_ = handler(arg_2_0, arg_2_0.UpdateCountDownTime)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.colorController_ = arg_3_0.controllerEx_:GetController("color")
end

function var_0_0.RegisterEvent(arg_4_0)
	manager.notify:RegistListener(AUTO_CHESS_UPDATE_COUNTDOWN, arg_4_0.updateTimeHandler_)
end

function var_0_0.UpdateCountDownTime(arg_5_0)
	if arg_5_0.countDownTimer_ then
		arg_5_0.countDownTimer_:Stop()

		arg_5_0.countDownTimer_ = nil
	end

	local var_5_0 = AutoChessData:GetEndTimeStamp(AutoChessConst.GAME_TYPE.ONLINE)
	local var_5_1 = var_5_0.endTime - var_5_0.startTime
	local var_5_2 = var_5_0.endTime - manager.time:GetServerTime()

	arg_5_0.countDownText_.text = manager.time:DescCDTime4(var_5_2)
	arg_5_0.timeSlider_.value = var_5_2 / var_5_1

	if var_5_2 > 0 then
		arg_5_0.colorController_:SetSelectedState(var_5_2 <= 10 and "red" or "normal")

		arg_5_0.countDownTimer_ = Timer.New(function()
			local var_6_0 = var_5_0.endTime - manager.time:GetServerTime()

			arg_5_0.countDownText_.text = manager.time:DescCDTime4(var_6_0)

			arg_5_0.colorController_:SetSelectedState(var_6_0 <= 10 and "red" or "normal")
			arg_5_0:RemoveTween()

			arg_5_0.tween_ = LeanTween.value(var_6_0, var_6_0 - 1, 1):setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
				arg_5_0.timeSlider_.value = arg_7_0 / var_5_1
			end)):setOnComplete(LuaHelper.VoidAction(function()
				arg_5_0:RemoveTween()
			end))

			if var_6_0 <= 0 then
				arg_5_0.countDownTimer_:Stop()
				arg_5_0:OnTimeOver()
			end
		end, 1, -1)

		arg_5_0.countDownTimer_:Start()
	else
		arg_5_0:OnTimeOver()
	end
end

function var_0_0.OnTimeOver(arg_9_0)
	arg_9_0.countDownText_.text = "00:00"

	arg_9_0.colorController_:SetSelectedState("normal")
	manager.notify:Invoke(AUTO_CHESS_TIME_OVER)
end

function var_0_0.RemoveTween(arg_10_0)
	if arg_10_0.tween_ then
		arg_10_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_10_0.tween_.id)

		arg_10_0.tween_ = nil
	end
end

function var_0_0.ResetView(arg_11_0)
	arg_11_0:RemoveTween()

	if arg_11_0.countDownTimer_ then
		arg_11_0.countDownTimer_:Stop()

		arg_11_0.countDownTimer_ = nil
	end

	manager.notify:RemoveListener(AUTO_CHESS_UPDATE_COUNTDOWN, arg_11_0.updateTimeHandler_)
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:ResetView()
	var_0_0.super.OnExit(arg_12_0)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:ResetView()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
