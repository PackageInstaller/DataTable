class = var_0_10000

local var_0_0 = var_0_10000("LanternRiddlesView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controller = arg_1_1
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	return
end

function var_0_0.SetUI(arg_2_0, arg_2_1)
	arg_2_0._tf = arg_2_1
	arg_2_0.questioneTFs = {}
	ipairs = var_2
	pg = var_1_10004

	for iter_2_0, iter_2_1 in var_2(var_1_10004.activity_event_question.all) do
		local var_2_0 = arg_2_0._tf

		var_1_10007 = var_1_10007.Find(var_2_0, "labels/label" .. iter_2_0)
		var_1_10008 = arg_2_0.questioneTFs
		var_1_10008[iter_2_1] = var_1_10007
	end

	local var_2_1 = arg_2_0._tf

	arg_2_0.mainPanel = var_2.Find(var_2_1, "main")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_2.Find(var_2_2, "time/Text")
	local var_2_4 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_2_0.day = var_2_4(var_2_3, var_5(var_1_10007))

	local var_2_5 = arg_2_0.mainPanel
	local var_2_6 = var_2.Find(var_2_5, "frame/time")
	local var_2_7 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007

	local var_2_8 = var_2_7(var_2_6, var_5(var_1_10007))

	i18n = var_3
	var_2_8.text = var_3("LanternRiddle_wait_time_tip")
	setActive = var_3

	var_3(arg_2_0.mainPanel, false)

	onButton = var_3

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.mainPanel

	local function var_2_11()
		local var_3_0 = arg_2_0

		var_0.HideMainPanel(var_3_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_2_9, var_2_10, var_2_11, var_1_10008)

	onButton = var_3

	local var_2_12 = arg_2_0
	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_6.Find(var_2_13, "back")

	local function var_2_15()
		local var_4_0 = arg_2_0.controller

		var_0.ExitGame(var_4_0)

		return
	end

	SFX_PANEL = var_2_13

	var_3(var_2_12, var_2_14, var_2_15, var_2_13)

	onButton = var_3

	local var_2_16 = arg_2_0
	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_6.Find(var_2_17, "back/help")

	local function var_2_19()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		pg = var_2_10004
		var_5_2.helps = var_2_10004.gametip.lanternRiddles_gametip.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_PANEL = var_2_17

	var_3(var_2_16, var_2_18, var_2_19, var_2_17)

	onButton = var_3

	local var_2_20 = arg_2_0
	local var_2_21 = arg_2_0._tf
	local var_2_22 = var_6.Find(var_2_21, "option")

	local function var_2_23()
		local var_6_0 = arg_2_0.controller

		var_0.ExitGameAndGoHome(var_6_0)

		return
	end

	SFX_PANEL = var_2_21

	var_3(var_2_20, var_2_22, var_2_23, var_2_21)

	return
end

function var_0_0.UpdateDay(arg_7_0, arg_7_1)
	math = var_1_10002

	local var_7_0 = var_1_10002.min(arg_7_1, 7)

	arg_7_0.day.text = var_7_0

	return
end

function var_0_0.InitLanternRiddles(arg_8_0, arg_8_1)
	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_1) do
		local var_8_0 = arg_8_0.questioneTFs[iter_8_1.id]
		local var_8_1 = iter_8_1.isUnlock

		onButton = var_1_10009

		local var_8_2 = arg_8_0
		local var_8_3 = var_8_0

		local function var_8_4()
			if not var_8_1 then
				return
			end

			local var_9_0 = arg_8_0

			var_0.ShowMainPanel(var_9_0, iter_8_1)

			return
		end

		SFX_PANEL = var_1_10014

		var_1_10009(var_8_2, var_8_3, var_8_4, var_1_10014)

		setActive = var_1_10009

		var_1_10009(var_8_0:Find("finish"), iter_8_1.isFinish)

		LeanTween = var_1_10009
		var_1_10009 = var_1_10009.isTweening
		go = var_11

		if var_1_10009(var_11(var_8_0)) then
			LeanTween = var_1_10009
			var_1_10009 = var_1_10009.cancel
			go = var_11

			var_1_10009(var_11(var_8_0))
		end

		var_1_10009 = var_8_0:Find("image")

		if var_8_1 and not iter_8_1.isFinish then
			LeanTween = var_1_10010
			var_1_10010 = var_1_10010.rotateZ
			go = var_12

			local var_8_5 = var_1_10010(var_12(var_8_0), 10, 2)
			local var_8_6 = var_1_10010.setLoopPingPong(var_8_5, 0)

			var_1_10010.setFrom(var_8_6, 0)
		end

		setActive = var_1_10010

		var_1_10010(var_1_10009, var_8_1)
	end

	return
end

function var_0_0.RefreshLanterRiddles(arg_10_0, arg_10_1)
	arg_10_0:InitLanternRiddles(arg_10_1)

	return
end

function var_0_0.ShowMainPanel(arg_11_0, arg_11_1)
	pg = var_1_10002

	local var_11_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_11_0, arg_11_0.mainPanel)

	setActive = var_2

	var_2(arg_11_0.mainPanel, true)

	setActive = var_2

	local var_11_1 = arg_11_0.mainPanel

	var_2(var_4.Find(var_11_1, "frame/label_game"), arg_11_1.type == 2)

	setActive = var_2

	local var_11_2 = arg_11_0.mainPanel

	var_2(var_4.Find(var_11_2, "frame/label_his"), arg_11_1.type == 1)

	setText = var_2

	local var_11_3 = arg_11_0.mainPanel

	var_2(var_4.Find(var_11_3, "frame/Text"), arg_11_1.text)
	arg_11_0:UpdateMainPanelTime()

	local var_11_4 = arg_11_1.answers
	local var_11_5 = arg_11_0.mainPanel
	local var_11_6 = var_3.Find(var_11_5, "frame/answers")
	local var_11_7 = arg_11_1.isFinish

	for iter_11_0 = 1, 4 do
		local var_11_8 = var_11_4[iter_11_0][1]
		local var_11_9 = var_11_4[iter_11_0][2]
		local var_11_10 = var_11_6:GetChild(iter_11_0 - 1)

		setText = var_1_10012

		var_1_10012(var_11_10:Find("Text"), var_11_8)

		setActive = var_1_10012

		var_1_10012(var_11_10:Find("right"), var_11_7 and iter_11_0 == arg_11_1.rightIndex)

		setActive = var_1_10012

		var_1_10012(var_11_10:Find("false"), var_11_9)

		onButton = var_1_10012

		local var_11_11 = arg_11_0
		local var_11_12 = var_11_10

		local function var_11_13()
			if arg_11_1.isFinish then
				return
			end

			if var_11_9 then
				return
			end

			pg = var_0

			local var_12_0 = var_0.TimeMgr.GetInstance()
			local var_12_1 = var_0.GetServerTime(var_12_0)
			local var_12_2 = arg_11_0.controller

			if var_12_1 < var_1.GetLockTime(var_12_2) then
				pg = var_12_0

				local var_12_3 = var_12_0.TipsMgr.GetInstance()
				local var_12_4 = var_2.ShowTips

				i18n = var_2_10005

				var_12_4(var_12_3, var_2_10005("lanternRiddles_wait_for_reanswer"))

				return
			end

			local var_12_5 = arg_11_0.controller

			var_2.SelectAnswer(var_12_5, arg_11_1.id, iter_11_0)

			return
		end

		SFX_PANEL = var_17

		var_1_10012(var_11_11, var_11_12, var_11_13, var_17)
	end

	return
end

function var_0_0.UpdateMainPanelTime(arg_13_0)
	arg_13_0:RemoveTimer()

	pg = var_1

	local var_13_0 = var_1.TimeMgr.GetInstance()
	local var_13_1 = var_1.GetServerTime(var_13_0)
	local var_13_2 = arg_13_0.controller
	local var_13_3 = var_13_1 <= var_2.GetLockTime(var_13_2)

	setActive = var_13_0

	local var_13_4 = arg_13_0.mainPanel

	var_13_0(var_5.Find(var_13_4, "frame/time"), var_13_3)

	if var_13_3 then
		arg_13_0:AddTimer()
	end

	return
end

function var_0_0.OnUpdateAnswer(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0.mainPanel
	local var_14_1 = var_4.Find(var_14_0, "frame/answers")
	local var_14_2 = var_4.GetChild(var_14_1, arg_14_2 - 1)

	setActive = var_14_0

	var_14_0(var_14_2:Find("right"), arg_14_3)

	setActive = var_14_0

	var_14_0(var_14_2:Find("false"), not arg_14_3)

	if not arg_14_3 then
		arg_14_0:UpdateMainPanelTime()

		pg = var_14_0

		local var_14_3 = var_14_0.TipsMgr.GetInstance()

		var_14_0 = var_14_0.ShowTips
		i18n = var_9

		var_14_0(var_14_3, var_9("lanternRiddles_answer_is_wrong"))
	else
		pg = var_14_0

		local var_14_4 = var_14_0.TipsMgr.GetInstance()
		local var_14_5 = var_6.ShowTips

		i18n = var_9

		var_14_5(var_14_4, var_9("lanternRiddles_answer_is_right"))

		local var_14_6 = arg_14_0.questioneTFs[arg_14_1.id]

		setActive = var_7

		var_7(var_14_6:Find("finish"), arg_14_1.isFinish)

		LeanTween = var_7

		local var_14_7 = var_7.isTweening

		go = var_9

		if var_14_7(var_9(var_14_6)) then
			LeanTween = var_7

			local var_14_8 = var_7.cancel

			go = var_9

			var_14_8(var_9(var_14_6))
		end
	end

	return
end

function var_0_0.HideMainPanel(arg_15_0)
	arg_15_0:RemoveTimer()

	setActive = var_1

	var_1(arg_15_0.mainPanel, false)

	pg = var_1

	local var_15_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_15_0, arg_15_0.mainPanel, arg_15_0._tf)

	return
end

function var_0_0.AddTimer(arg_16_0)
	local var_16_0 = arg_16_0.controller
	local var_16_1 = var_1.GetLockTime(var_16_0)
	local var_16_2 = arg_16_0.mainPanel
	local var_16_3 = var_2.Find(var_16_2, "frame/time/Text")
	local var_16_4 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007

	local var_16_5 = var_16_4(var_16_3, var_5(var_1_10007))

	Timer = var_16_0
	arg_16_0.timer = var_16_0.New(function()
		pg = var_2_10000

		local var_17_0 = var_2_10000.TimeMgr.GetInstance()
		local var_17_1 = var_0.GetServerTime(var_17_0)

		if var_16_1 - var_17_1 <= 0 then
			local var_17_2 = arg_16_0

			var_2.RemoveTimer(var_17_2)

			setActive = var_2

			local var_17_3 = arg_16_0.mainPanel

			var_2(var_4.Find(var_17_3, "frame/time"), false)
		else
			local var_17_4 = var_16_5

			pg = var_2_10003

			local var_17_5 = var_2_10003.TimeMgr.GetInstance()

			var_17_4.text = var_3.DescCDTime(var_17_5, var_1)
		end

		return
	end, 1, -1)

	local var_16_6 = arg_16_0.timer

	var_3.Start(var_16_6)
	arg_16_0.timer.func()

	return
end

function var_0_0.RemoveTimer(arg_18_0)
	if arg_18_0.timer then
		local var_18_0 = arg_18_0.timer

		var_1.Stop(var_18_0)

		arg_18_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:RemoveTimer()
	arg_19_0:HideMainPanel()

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_19_0)

	return
end

return var_0_0
