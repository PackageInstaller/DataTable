local var_0_0 = class("WindowPopTipsItem", import("game.extend.ReduxView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.infoHandler_ = handler(arg_1_0, arg_1_0.RefreshInfo)

	manager.notify:RegistListener(WINDOW_BAR_INFO, arg_1_0.infoHandler_)
end

function var_0_0.AddListeners(arg_2_0)
	return
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	arg_3_0:StopTimer()
	manager.notify:RemoveListener(WINDOW_BAR_INFO, arg_3_0.infoHandler_)

	arg_3_0.infoHandler_ = nil
end

function var_0_0.RefreshInfo(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A then
		local var_4_0 = GuildData:GetGuildInfo()

		if var_4_0.id == nil then
			return
		end

		arg_4_0.textNum_.text = GetTips("ACTIVITY_STRONGHOLD_COIN_WEEK_CEIL") .. string.format("%s/%s", var_4_0.curWeekCoin, GuildData:GetMaxWeekCoin())
	else
		return
	end

	arg_4_0:CalcOffsetX(arg_4_2)
	arg_4_0:AddTimer()
end

function var_0_0.Hide(arg_5_0)
	SetActive(arg_5_0.gameObject_, false)
end

function var_0_0.AddTimer(arg_6_0)
	arg_6_0:StopTimer()
	SetActive(arg_6_0.gameObject_, true)

	arg_6_0.timer_ = Timer.New(function()
		arg_6_0:StopTimer()
	end, 3, 1)

	arg_6_0.timer_:Start()
end

function var_0_0.StopTimer(arg_8_0)
	SetActive(arg_8_0.gameObject_, false)

	if arg_8_0.timer_ then
		arg_8_0.timer_:Stop()

		arg_8_0.timer_ = nil
	end
end

function var_0_0.CalcOffsetX(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.transform:InverseTransformPoint(arg_9_0.goRight_.transform:TransformPoint(Vector3.zero))

	arg_9_0.transform_.localPosition = Vector3(var_9_0.x * -1, arg_9_0.transform_.localPosition.y, 0)
end

return var_0_0
