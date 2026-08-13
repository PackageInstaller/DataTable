class = var_0_10000

local var_0_0 = var_0_10000("TowerClimbingView")

local function var_0_1(arg_1_0, arg_1_1, arg_1_2)
	GetOrAddComponent = var_1_10003

	local var_1_0 = var_1_10003(arg_1_0, "EventTriggerListener")

	var_3.AddPointDownFunc(var_1_0, function(arg_2_0, arg_2_1)
		if arg_1_1 then
			arg_1_1()
		end

		return
	end)
	var_3:AddPointUpFunc(function(arg_3_0, arg_3_1)
		if arg_1_2 then
			arg_1_2()
		end

		return
	end)

	return
end

local function var_0_2(arg_4_0)
	GetOrAddComponent = var_1_10001

	local var_4_0 = var_1_10001(arg_4_0, "EventTriggerListener")

	var_1.RemovePointDownFunc(var_4_0)
	var_1:RemovePointUpFunc()

	return
end

function var_0_0.Ctor(arg_5_0, arg_5_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_5_0)

	arg_5_0.controller = arg_5_1
	pg = var_2
	arg_5_0.roomTip = var_2.gametip.towerclimbing_gametip.tip

	return
end

function var_0_0.SetUI(arg_6_0, arg_6_1)
	arg_6_0._go = arg_6_1
	arg_6_0._tf = arg_6_1.transform
	findTF = var_2
	arg_6_0.overView = var_2(arg_6_0._tf, "overview")
	findTF = var_2
	arg_6_0.gameView = var_2(arg_6_0._tf, "AD")

	local var_6_0 = {}

	findTF = var_3
	var_6_0[1] = var_3(arg_6_0._tf, "overview/maps/1")
	findTF = var_3
	var_6_0[2] = var_3(arg_6_0._tf, "overview/maps/2")
	findTF = var_3
	var_6_0[3] = var_3(arg_6_0._tf, "overview/maps/3")
	arg_6_0.maps = var_6_0
	findTF = var_6_0
	arg_6_0.exitGameBtn = var_6_0(arg_6_0.gameView, "back")
	findTF = var_2
	arg_6_0.jumpBtn = var_2(arg_6_0.gameView, "prints/right_btn_layout/up")
	findTF = var_2
	arg_6_0.leftLayout = var_2(arg_6_0.gameView, "prints/left_btn_layout")
	findTF = var_2
	arg_6_0.moveBtn = var_2(arg_6_0.leftLayout, "move_btn")
	findTF = var_2
	arg_6_0.quitPanel = var_2(arg_6_0._tf, "quit_panel")

	local var_6_1 = arg_6_0.quitPanel

	arg_6_0.quitPanelCancelBtn = var_2.Find(var_6_1, "frame/cancel")

	local var_6_2 = arg_6_0.quitPanel

	arg_6_0.quitPanelCconfirmBtn = var_2.Find(var_6_2, "frame/confirm")
	findTF = var_2
	arg_6_0.resultPanel = var_2(arg_6_0._tf, "result_panel")

	local var_6_3 = arg_6_0.resultPanel
	local var_6_4 = var_2.Find(var_6_3, "frame/curr/Text")
	local var_6_5 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_6_0.resultPanelScoreTxt = var_6_5(var_6_4, var_4(var_5))

	local var_6_6 = arg_6_0.resultPanel
	local var_6_7 = var_2.Find(var_6_6, "frame/higtest/Text")
	local var_6_8 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_6_0.resultPanelHScoreTxt = var_6_8(var_6_7, var_4(var_5))

	local var_6_9 = arg_6_0.resultPanel

	arg_6_0.resultPanelEndBtn = var_2.Find(var_6_9, "frame/cancel")

	local var_6_10 = arg_6_0._tf

	arg_6_0.helpBtn = var_2.Find(var_6_10, "overview/logo/help")

	local var_6_11 = arg_6_0._tf

	arg_6_0.enterPanel = var_2.Find(var_6_11, "enter_panel")

	local var_6_12 = arg_6_0.enterPanel
	local var_6_13 = var_2.Find(var_6_12, "Text")
	local var_6_14 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_6_0.enterPanelTxt = var_6_14(var_6_13, var_4(var_5))

	arg_6_0:ResetParams()

	return
end

function var_0_0.OnEnter(arg_7_0, arg_7_1)
	setActive = var_1_10002

	var_1_10002(arg_7_0.overView, true)

	setActive = var_1_10002

	var_1_10002(arg_7_0.gameView, false)

	onButton = var_1_10002

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.helpBtn

	local function var_7_2()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_8_2.type = var_2_10003
		var_8_2.helps = arg_7_0.roomTip

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_7_0, var_7_1, var_7_2, var_1_10006)

	onButton = var_1_10002

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.exitGameBtn

	local function var_7_5()
		local var_9_0 = arg_7_0

		var_0.ShowQuitPanel(var_9_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_7_3, var_7_4, var_7_5, var_1_10006)

	ipairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(arg_7_0.maps) do
		onButton = var_1_10007

		local var_7_6 = arg_7_0
		local var_7_7 = iter_7_1

		local function var_7_8()
			local var_10_0 = arg_7_0.controller

			var_0.StartGame(var_10_0, iter_7_0)

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10007(var_7_6, var_7_7, var_7_8, var_1_10011)
	end

	return
end

function var_0_0.DoEnter(arg_11_0, arg_11_1)
	setActive = var_1_10002

	var_1_10002(arg_11_0.overView, false)

	setActive = var_1_10002

	var_1_10002(arg_11_0.gameView, true)

	arg_11_0.inDownCnt = true

	local var_11_0 = arg_11_0

	arg_11_0.ActivePanel(var_11_0, arg_11_0.enterPanel, true)

	local var_11_1 = 4

	Timer = var_11_0
	arg_11_0.timer = var_11_0.New(function()
		var_11_1 = var_11_1 - 1

		if var_11_1 == 3 then
			pg = var_0

			local var_12_0 = var_0.CriMgr.GetInstance()
			local var_12_1 = var_0.PlaySoundEffect_V3

			SFX_STEP_PILE_COUNTDOWN = var_2_10002

			var_12_1(var_12_0, var_2_10002)
		end

		arg_11_0.enterPanelTxt.text = var_11_1

		if var_11_1 == 0 then
			arg_11_1()

			local var_12_2 = arg_11_0

			var_0.ActivePanel(var_12_2, arg_11_0.enterPanel, false)

			local var_12_3 = arg_11_0.timer

			var_0.Stop(var_12_3)

			arg_11_0.timer = nil
			arg_11_0.inDownCnt = nil
		end

		return
	end, 1, -1)

	local var_11_2 = arg_11_0.timer

	var_3.Start(var_11_2)
	arg_11_0.timer.func()

	return
end

function var_0_0.OnStartGame(arg_13_0)
	var_0_1(arg_13_0.jumpBtn, function()
		local var_14_0 = arg_13_0.controller

		var_0.PlayerJump(var_14_0)

		pg = var_0

		local var_14_1 = var_0.CriMgr.GetInstance()
		local var_14_2 = var_0.PlaySoundEffect_V3

		SFX_PANEL = var_2_10002

		var_14_2(var_14_1, var_2_10002)

		return
	end)
	arg_13_0:OnSlip(arg_13_0.moveBtn, function()
		arg_13_0.rightOffse = 0.06
		arg_13_0.leftOffse = 0

		return
	end, function()
		arg_13_0.rightOffse = 0
		arg_13_0.leftOffse = -0.06

		return
	end, function()
		arg_13_0.rightOffse = 0
		arg_13_0.leftOffse = 0

		return
	end, function()
		arg_13_0.rightOffse = 0
		arg_13_0.leftOffse = 0

		return
	end)

	return
end

function var_0_0.OnSlip(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	GetOrAddComponent = var_1_10006

	local var_19_0 = var_1_10006(arg_19_1, "EventTriggerListener")

	GameObject = var_7

	local var_19_1 = var_7.Find("UICamera")
	local var_19_2 = var_7.GetComponent(var_19_1, "Camera")
	local var_19_3 = var_7.WorldToScreenPoint(var_19_2, arg_19_0.leftLayout.position)
	local var_19_4 = 0
	local var_19_5 = 10

	local function var_19_6(arg_20_0, arg_20_1)
		var_19_4 = arg_20_1.position.x - var_19_3.x

		if var_19_4 < -var_19_5 then
			if arg_19_3 then
				arg_19_3()
			end
		elseif var_19_4 > var_19_5 then
			if arg_19_2 then
				arg_19_2()
			end
		elseif arg_19_5 then
			arg_19_5()
		end

		return
	end

	var_19_0:AddPointDownFunc(function(arg_21_0, arg_21_1)
		var_19_4 = 0

		var_19_6(arg_21_0, arg_21_1)

		return
	end)
	var_19_0:AddDragFunc(var_19_6)
	var_19_0:AddPointUpFunc(function(arg_22_0, arg_22_1)
		var_19_4 = 0

		if arg_19_4 then
			arg_19_4()
		end

		return
	end)

	return
end

function var_0_0.ClearSlip(arg_23_0, arg_23_1)
	GetOrAddComponent = var_1_10002

	local var_23_0 = var_1_10002(arg_23_1, "EventTriggerListener")

	var_2.RemovePointDownFunc(var_23_0)
	var_2:RemovePointUpFunc()
	var_2:RemoveDragFunc()

	return
end

function var_0_0.Update(arg_24_0)
	arg_24_0:AddDebugInput()

	arg_24_0.hrzOffse = arg_24_0.leftOffse + arg_24_0.rightOffse

	local var_24_0 = arg_24_0.controller

	var_1.OnStickChange(var_24_0, arg_24_0.hrzOffse)

	return
end

function var_0_0.AddDebugInput(arg_25_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		Input = var_1_10001

		local var_25_0 = var_1_10001.GetKeyDown

		KeyCode = var_1_10002

		if var_25_0(var_1_10002.A) then
			arg_25_0.leftOffse = -0.06
		end

		Input = var_1

		local var_25_1 = var_1.GetKeyUp

		KeyCode = var_2

		if var_25_1(var_2.A) then
			arg_25_0.leftOffse = 0
		end

		Input = var_1

		local var_25_2 = var_1.GetKeyDown

		KeyCode = var_2

		if var_25_2(var_2.D) then
			arg_25_0.rightOffse = 0.06
		end

		Input = var_1

		local var_25_3 = var_1.GetKeyUp

		KeyCode = var_2

		if var_25_3(var_2.D) then
			arg_25_0.rightOffse = 0
		end

		Input = var_1

		local var_25_4 = var_1.GetKeyDown

		KeyCode = var_2

		if var_25_4(var_2.Space) then
			local var_25_5 = arg_25_0.controller

			var_1.PlayerJump(var_25_5)

			pg = var_1

			local var_25_6 = var_1.CriMgr.GetInstance()
			local var_25_7 = var_1.PlaySoundEffect_V3

			SFX_PANEL = var_1_10003

			var_25_7(var_25_6, var_1_10003)
		end
	end

	return
end

function var_0_0.OnCreateMap(arg_26_0, arg_26_1, arg_26_2)
	TowerClimbingMap = var_1_10003
	arg_26_0.map = var_1_10003.New(arg_26_0, arg_26_1)

	local var_26_0 = arg_26_0.map

	var_3.Init(var_26_0, arg_26_2)

	return
end

function var_0_0.ResetParams(arg_27_0)
	arg_27_0.leftOffse = 0
	arg_27_0.rightOffse = 0
	arg_27_0.hrzOffse = 0

	return
end

function var_0_0.OnEndGame(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	arg_28_0:ResetParams()

	removeOnButton = var_4

	var_4(arg_28_0.jumpBtn)
	arg_28_0:ShowResultPanel(arg_28_1, arg_28_2, arg_28_3)

	return
end

function var_0_0.OnExitGame(arg_29_0)
	setActive = var_1_10001

	var_1_10001(arg_29_0.overView, true)

	setActive = var_1_10001

	var_1_10001(arg_29_0.gameView, false)

	if arg_29_0.map then
		local var_29_0 = arg_29_0.map

		var_1.Dispose(var_29_0)
	end

	return
end

function var_0_0.ShowQuitPanel(arg_30_0)
	arg_30_0:ActivePanel(arg_30_0.quitPanel, true)

	onButton = var_1

	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.quitPanelCconfirmBtn

	local function var_30_2()
		local var_31_0 = arg_30_0

		var_0.ActivePanel(var_31_0, arg_30_0.quitPanel, false)

		local var_31_1 = arg_30_0.controller

		var_0.EndGame(var_31_1)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_30_0, var_30_1, var_30_2, var_1_10005)

	onButton = var_1

	local var_30_3 = arg_30_0
	local var_30_4 = arg_30_0.quitPanelCancelBtn

	local function var_30_5()
		local var_32_0 = arg_30_0

		var_0.ActivePanel(var_32_0, arg_30_0.quitPanel, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_30_3, var_30_4, var_30_5, var_1_10005)

	return
end

function var_0_0.ShowResultPanel(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_0:ActivePanel(arg_33_0.resultPanel, true)

	arg_33_0.resultPanelScoreTxt.text = arg_33_1

	local var_33_0

	if arg_33_0.highScores and arg_33_3 <= #arg_33_0.highScores then
		var_33_0 = arg_33_0.resultPanelHScoreTxt
		var_33_0.text = arg_33_0.highScores[arg_33_3]
	else
		var_33_0 = arg_33_0.resultPanelHScoreTxt
		var_33_0.text = arg_33_2
	end

	onButton = var_33_0

	local var_33_1 = arg_33_0
	local var_33_2 = arg_33_0.resultPanelEndBtn

	local function var_33_3()
		local var_34_0 = arg_33_0

		var_0.ActivePanel(var_34_0, arg_33_0.resultPanel, false)

		local var_34_1 = arg_33_0.controller

		var_0.ExitGame(var_34_1)

		return
	end

	SFX_PANEL = var_1_10008

	var_33_0(var_33_1, var_33_2, var_33_3, var_1_10008)

	return
end

function var_0_0.SetHighScore(arg_35_0, arg_35_1)
	arg_35_0.highScores = arg_35_1

	return
end

function var_0_0.setRoomTip(arg_36_0, arg_36_1)
	arg_36_0.roomTip = arg_36_1

	return
end

function var_0_0.ActivePanel(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_2 then
		pg = var_1_10003

		local var_37_0 = var_1_10003.UIMgr.GetInstance()

		var_1_10003.BlurPanel(var_37_0, arg_37_1)
	else
		pg = var_1_10003

		local var_37_1 = var_1_10003.UIMgr.GetInstance()

		var_1_10003.UnOverlayPanel(var_37_1, arg_37_1, arg_37_0._tf)
	end

	setActive = var_1_10003

	var_1_10003(arg_37_1, arg_37_2)

	return
end

function var_0_0.onBackPressed(arg_38_0)
	if arg_38_0.inDownCnt then
		return true
	end

	if arg_38_0.controller.IsStarting then
		arg_38_0:ShowQuitPanel()

		return true
	end

	isActive = var_1

	if var_1(arg_38_0.resultPanel) then
		arg_38_0:ActivePanel(arg_38_0.resultPanel, false)

		local var_38_0 = arg_38_0.controller

		var_1.ExitGame(var_38_0)

		return true
	end

	return false
end

function var_0_0.Dispose(arg_39_0)
	if arg_39_0.timer then
		local var_39_0 = arg_39_0.timer

		var_1.Stop(var_39_0)

		arg_39_0.timer = nil
	end

	var_0_2(arg_39_0.jumpBtn)
	arg_39_0:ClearSlip(arg_39_0.moveBtn)

	pg = var_1

	var_1.DelegateInfo.Dispose(arg_39_0)

	if arg_39_0.map then
		local var_39_1 = arg_39_0.map

		var_1.Dispose(var_39_1)
	end

	return
end

return var_0_0
