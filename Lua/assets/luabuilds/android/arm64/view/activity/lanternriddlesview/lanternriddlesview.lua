local var_0_0 = class("LanternRiddlesView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controller = arg_1_1

	pg.DelegateInfo.New(arg_1_0)

	return
end

function var_0_0.SetUI(arg_2_0, arg_2_1)
	arg_2_0._tf = arg_2_1
	arg_2_0.questioneTFs = {}

	for iter_2_0, iter_2_1 in ipairs(pg.activity_event_question.all) do
		arg_2_0.questioneTFs[iter_2_1] = arg_2_0._tf:Find("labels/label" .. iter_2_0)
	end

	arg_2_0.mainPanel = arg_2_0._tf:Find("main")
	arg_2_0.day = arg_2_0._tf:Find("time/Text"):GetComponent(typeof(Text))
	arg_2_0.mainPanel:Find("frame/time"):GetComponent(typeof(Text)).text = i18n("LanternRiddle_wait_time_tip")

	setActive(arg_2_0.mainPanel, false)
	onButton(arg_2_0, arg_2_0.mainPanel, function()
		arg_2_0:HideMainPanel()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._tf:Find("back"), function()
		arg_2_0.controller:ExitGame()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._tf:Find("back/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.lanternRiddles_gametip.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._tf:Find("option"), function()
		arg_2_0.controller:ExitGameAndGoHome()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateDay(arg_7_0, arg_7_1)
	arg_7_0.day.text = math.min(arg_7_1, 7)

	return
end

function var_0_0.InitLanternRiddles(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_0 = iter_8_1.isUnlock

		onButton(arg_8_0, arg_8_0.questioneTFs[iter_8_1.id], function()
			if not var_8_0 then
				return
			end

			arg_8_0:ShowMainPanel(iter_8_1)

			return
		end, SFX_PANEL)
		setActive(arg_8_0.questioneTFs[iter_8_1.id]:Find("finish"), iter_8_1.isFinish)

		if LeanTween.isTweening(go(arg_8_0.questioneTFs[iter_8_1.id])) then
			LeanTween.cancel(go(arg_8_0.questioneTFs[iter_8_1.id]))
		end

		local var_8_1 = arg_8_0.questioneTFs[iter_8_1.id]:Find("image")

		if iter_8_1.isUnlock and not iter_8_1.isFinish then
			LeanTween.rotateZ(go(arg_8_0.questioneTFs[iter_8_1.id]), 10, 2):setLoopPingPong(0):setFrom(0)
		end

		setActive(var_8_1, iter_8_1.isUnlock)
	end

	return
end

function var_0_0.RefreshLanterRiddles(arg_10_0, arg_10_1)
	arg_10_0:InitLanternRiddles(arg_10_1)

	return
end

function var_0_0.ShowMainPanel(arg_11_0, arg_11_1)
	pg.UIMgr.GetInstance():BlurPanel(arg_11_0.mainPanel)
	setActive(arg_11_0.mainPanel, true)
	setActive(arg_11_0.mainPanel:Find("frame/label_game"), arg_11_1.type == 2)
	setActive(arg_11_0.mainPanel:Find("frame/label_his"), arg_11_1.type == 1)
	setText(arg_11_0.mainPanel:Find("frame/Text"), arg_11_1.text)
	arg_11_0:UpdateMainPanelTime()

	local var_11_0 = arg_11_0.mainPanel:Find("frame/answers")

	for iter_11_0 = 1, 4 do
		local var_11_1 = arg_11_1.answers[iter_11_0][2]
		local var_11_2 = var_11_0:GetChild(iter_11_0 - 1)

		setText(var_11_2:Find("Text"), arg_11_1.answers[iter_11_0][1])
		setActive(var_11_2:Find("right"), arg_11_1.isFinish and iter_11_0 == arg_11_1.rightIndex)
		setActive(var_11_2:Find("false"), arg_11_1.answers[iter_11_0][2])
		onButton(arg_11_0, var_11_2, function()
			if arg_11_1.isFinish then
				return
			end

			if var_11_1 then
				return
			end

			local var_12_0 = pg.TimeMgr.GetInstance()

			if var_12_0:GetServerTime() < arg_11_0.controller:GetLockTime() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("lanternRiddles_wait_for_reanswer"))

				return
			end

			arg_11_0.controller:SelectAnswer(arg_11_1.id, iter_11_0)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.UpdateMainPanelTime(arg_13_0)
	arg_13_0:RemoveTimer()

	local var_13_0 = pg.TimeMgr.GetInstance():GetServerTime() <= arg_13_0.controller:GetLockTime()

	setActive(arg_13_0.mainPanel:Find("frame/time"), var_13_0)

	if var_13_0 then
		arg_13_0:AddTimer()
	end

	return
end

function var_0_0.OnUpdateAnswer(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0.mainPanel:Find("frame/answers"):GetChild(arg_14_2 - 1)

	setActive(var_14_0:Find("right"), arg_14_3)
	setActive(var_14_0:Find("false"), not arg_14_3)

	if not arg_14_3 then
		arg_14_0:UpdateMainPanelTime()
		pg.TipsMgr.GetInstance():ShowTips(i18n("lanternRiddles_answer_is_wrong"))
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("lanternRiddles_answer_is_right"))
		setActive(arg_14_0.questioneTFs[arg_14_1.id]:Find("finish"), arg_14_1.isFinish)

		if LeanTween.isTweening(go(arg_14_0.questioneTFs[arg_14_1.id])) then
			LeanTween.cancel(go(arg_14_0.questioneTFs[arg_14_1.id]))
		end
	end

	return
end

function var_0_0.HideMainPanel(arg_15_0)
	arg_15_0:RemoveTimer()
	setActive(arg_15_0.mainPanel, false)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_15_0.mainPanel, arg_15_0._tf)

	return
end

function var_0_0.AddTimer(arg_16_0)
	local var_16_0 = arg_16_0.controller:GetLockTime()
	local var_16_1 = arg_16_0.mainPanel:Find("frame/time/Text"):GetComponent(typeof(Text))

	arg_16_0.timer = Timer.New(function()
		local var_17_0 = var_16_0 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_17_0 <= 0 then
			arg_16_0:RemoveTimer()
			setActive(arg_16_0.mainPanel:Find("frame/time"), false)
		else
			local var_17_1 = var_16_1

			var_17_1.text = pg.TimeMgr.GetInstance():DescCDTime(var_17_0)
		end

		return
	end, 1, -1)

	arg_16_0.timer:Start()
	arg_16_0.timer.func()

	return
end

function var_0_0.RemoveTimer(arg_18_0)
	if arg_18_0.timer then
		arg_18_0.timer:Stop()

		arg_18_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:RemoveTimer()
	arg_19_0:HideMainPanel()
	pg.DelegateInfo.Dispose(arg_19_0)

	return
end

return var_0_0
