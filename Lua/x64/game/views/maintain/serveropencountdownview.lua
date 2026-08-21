local var_0_0 = class("ServerOpenCountdownView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/PopUp/ServerUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		local var_6_0 = {
			gameAppId = _G.ChannelLoginInfo.channelAppId,
			token = _G.ChannelLoginInfo.channelToken
		}

		OperationAction.OpenOperationUrl("FORUM_URL", var_6_0)
		SDKTools.SendMessageToSDK("direction", {
			direction_type = 8,
			direction_channel = 3
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		OperationAction.OpenNormalUrl("https://open.ys4fun.com/web-api/pass/linkrouter/qqun")
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.now_ = arg_9_0.params_.now
	arg_9_0.currentServerTime_ = manager.time:GetServerTime()
	arg_9_0.passedSeconds_ = 0

	if not arg_9_0.timer_ then
		arg_9_0.timer_ = Timer.New(function()
			arg_9_0:UpdateTime()
		end, 0.2, -1)
	end

	arg_9_0.timer_:Start()
	arg_9_0:UpdateTime()

	if tostring(_G.CHANNEL_MASTER_ID) == "1" or GameToSDK.PLATFORM_ID == 1 then
		SetActive(arg_9_0.okBtn_.gameObject, true)
		SetActive(arg_9_0.cancelBtn_.gameObject, true)
	else
		SetActive(arg_9_0.okBtn_.gameObject, false)
		SetActive(arg_9_0.cancelBtn_.gameObject, false)
	end
end

function var_0_0.UpdateTime(arg_11_0)
	arg_11_0.passedSeconds_ = manager.time:GetServerTime() - arg_11_0.currentServerTime_
	arg_11_0.contentText_.text = arg_11_0.params_.content

	local var_11_0 = arg_11_0.params_.countdown
	local var_11_1 = ""
	local var_11_2 = arg_11_0.params_.countdown - (arg_11_0.params_.now + arg_11_0.passedSeconds_)
	local var_11_3 = math.floor(var_11_2 / 86400)
	local var_11_4 = math.floor(var_11_2 / 3600) - var_11_3 * 24
	local var_11_5 = math.floor(var_11_2 / 60) - var_11_3 * 24 * 60 - var_11_4 * 60

	if var_11_2 >= 86400 then
		var_11_1 = TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_1].desc
		var_11_1 = string.format(var_11_1, var_11_3, var_11_4, var_11_5)
	elseif var_11_2 >= 3600 then
		var_11_1 = TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_2].desc
		var_11_1 = string.format(var_11_1, var_11_4, var_11_5)
	elseif var_11_2 >= 600 then
		var_11_1 = TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_3].desc
		var_11_1 = string.format(var_11_1, var_11_5)
	elseif var_11_2 > 0 then
		var_11_1 = TipsCfg[TipsCfg.get_id_list_by_define.SERVER_OPEN_COUNTDOWN_4].desc
	else
		arg_11_0:Back()
	end

	arg_11_0.countdownText_.text = var_11_1
end

function var_0_0.OnExit(arg_12_0)
	if arg_12_0.timer_ then
		arg_12_0.timer_:Stop()

		arg_12_0.timer_ = nil
	end
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
