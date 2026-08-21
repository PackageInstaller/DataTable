local var_0_0 = class("ChatMutedView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/LineReportTipsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = ChatData:GetMutedData()
	local var_4_1 = SettingData:GetCurrentLanguage()

	arg_4_0.textContent_.text = var_4_0.i18nInfo[var_4_1] or var_4_0.mutedContent

	local var_4_2 = GetTips("MUTE_TIME_TEXT")
	local var_4_3 = GetTips("MUTE_TIME_FORMAT")

	arg_4_0.textTime_.text = var_4_2 .. manager.time:DescCTime(var_4_0.mutedTimestamp, var_4_3)
	arg_4_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= var_4_0.mutedTimestamp then
			arg_4_0:Back()

			return
		end
	end, 1, -1)

	arg_4_0.timer_:Start()
	ChatData:SetShowMutedTips(true)
end

function var_0_0.OnExit(arg_6_0)
	if arg_6_0.timer_ then
		arg_6_0.timer_:Stop()

		arg_6_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.buttonClose_, nil, function()
		arg_8_0:Back()
	end)
	arg_8_0:AddBtnListener(arg_8_0.buttonSure_, nil, function()
		arg_8_0:Back()
	end)
end

return var_0_0
