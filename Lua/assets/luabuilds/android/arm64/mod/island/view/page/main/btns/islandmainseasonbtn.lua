local var_0_0 = class("IslandMainSeasonBtn", import(".IslandMainBaseBtn"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.invitePanel = arg_1_0._tf:Find("invitePanel")
	arg_1_0.inviteSlider = GetComponent(arg_1_0.invitePanel:Find("Slider"), typeof(Image))

	setText(arg_1_0.invitePanel:Find("Text"), i18n("match_ui_matching_invitation"))

	arg_1_0.timer = FrameTimer.New(function()
		arg_1_0:RefreshInvite()

		return
	end, 3, -1)

	arg_1_0.timer:Start()

	return
end

function var_0_0.Dispose(arg_3_0)
	if arg_3_0.timer then
		arg_3_0.timer:Stop()

		arg_3_0.timer = nil
	end

	arg_3_0:StopLeanTween()
	var_0_0.super.Dispose(arg_3_0)

	return
end

function var_0_0.RefreshInvite(arg_4_0)
	local var_4_0 = getProxy(PlayRoomProxy):GetInviteList()

	setActive(arg_4_0.invitePanel, var_4_0[1] ~= nil)

	if var_4_0[1] and arg_4_0.endTime ~= var_4_0[1].timestamp then
		arg_4_0.endTime = var_4_0[1].timestamp

		arg_4_0:StartLeanTween(pg.TimeMgr.GetInstance():GetServerTime(), var_4_0[1].timestamp + pg.gameset.match_refuseCD.key_value)
	end

	return
end

function var_0_0.StartLeanTween(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:StopLeanTween()

	if arg_5_2 <= arg_5_1 then
		return
	end

	LeanTween.value(arg_5_0._tf.gameObject, (arg_5_2 - arg_5_1) / pg.gameset.match_refuseCD.key_value, 0, arg_5_2 - arg_5_1):setOnUpdate(System.Action_float(function(arg_6_0)
		arg_5_0.inviteSlider.fillAmount = arg_6_0

		return
	end)):setOnComplete(System.Action(function()
		arg_5_0:StopLeanTween()

		return
	end))

	return
end

function var_0_0.StopLeanTween(arg_8_0)
	LeanTween.cancel(arg_8_0._tf.gameObject)

	return
end

return var_0_0
