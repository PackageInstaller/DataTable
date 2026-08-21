local var_0_0 = class("TowerClimbingView")

local function var_0_1(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = GetOrAddComponent(arg_1_0, "EventTriggerListener")

	var_1_0:AddPointDownFunc(function(arg_2_0, arg_2_1)
		if arg_1_1 then
			arg_1_1()
		end

		return
	end)
	var_1_0:AddPointUpFunc(function(arg_3_0, arg_3_1)
		if arg_1_2 then
			arg_1_2()
		end

		return
	end)

	return
end

local function var_0_2(arg_4_0)
	local var_4_0 = GetOrAddComponent(arg_4_0, "EventTriggerListener")

	var_4_0:RemovePointDownFunc()
	var_4_0:RemovePointUpFunc()

	return
end

function var_0_0.Ctor(arg_5_0, arg_5_1)
	pg.DelegateInfo.New(arg_5_0)

	arg_5_0.controller = arg_5_1
	arg_5_0.roomTip = pg.gametip.towerclimbing_gametip.tip

	return
end

function var_0_0.SetUI(arg_6_0, arg_6_1)
	arg_6_0._go = arg_6_1
	arg_6_0._tf = arg_6_1.transform
	arg_6_0.overView = findTF(arg_6_0._tf, "overview")
	arg_6_0.gameView = findTF(arg_6_0._tf, "AD")
	arg_6_0.maps = {
		findTF(arg_6_0._tf, "overview/maps/1"),
		findTF(arg_6_0._tf, "overview/maps/2"),
		findTF(arg_6_0._tf, "overview/maps/3")
	}
	arg_6_0.exitGameBtn = findTF(arg_6_0.gameView, "back")
	arg_6_0.jumpBtn = findTF(arg_6_0.gameView, "prints/right_btn_layout/up")
	arg_6_0.leftLayout = findTF(arg_6_0.gameView, "prints/left_btn_layout")
	arg_6_0.moveBtn = findTF(arg_6_0.leftLayout, "move_btn")
	arg_6_0.quitPanel = findTF(arg_6_0._tf, "quit_panel")
	arg_6_0.quitPanelCancelBtn = arg_6_0.quitPanel:Find("frame/cancel")
	arg_6_0.quitPanelCconfirmBtn = arg_6_0.quitPanel:Find("frame/confirm")
	arg_6_0.resultPanel = findTF(arg_6_0._tf, "result_panel")
	arg_6_0.resultPanelScoreTxt = arg_6_0.resultPanel:Find("frame/curr/Text"):GetComponent(typeof(Text))
	arg_6_0.resultPanelHScoreTxt = arg_6_0.resultPanel:Find("frame/higtest/Text"):GetComponent(typeof(Text))
	arg_6_0.resultPanelEndBtn = arg_6_0.resultPanel:Find("frame/cancel")
	arg_6_0.helpBtn = arg_6_0._tf:Find("overview/logo/help")
	arg_6_0.enterPanel = arg_6_0._tf:Find("enter_panel")
	arg_6_0.enterPanelTxt = arg_6_0.enterPanel:Find("Text"):GetComponent(typeof(Text))

	arg_6_0:ResetParams()

	return
end

function var_0_0.OnEnter(arg_7_0, arg_7_1)
	setActive(arg_7_0.overView, true)
	setActive(arg_7_0.gameView, false)
	onButton(arg_7_0, arg_7_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = arg_7_0.roomTip
		})

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.exitGameBtn, function()
		arg_7_0:ShowQuitPanel()

		return
	end, SFX_PANEL)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.maps) do
		onButton(arg_7_0, iter_7_1, function()
			arg_7_0.controller:StartGame(iter_7_0)

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.DoEnter(arg_11_0, arg_11_1)
	setActive(arg_11_0.overView, false)
	setActive(arg_11_0.gameView, true)

	arg_11_0.inDownCnt = true

	arg_11_0:ActivePanel(arg_11_0.enterPanel, true)

	local var_11_0 = 4

	arg_11_0.timer = Timer.New(function()
		var_11_0 = var_11_0 - 1

		if var_11_0 == 3 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_STEP_PILE_COUNTDOWN)
		end

		arg_11_0.enterPanelTxt.text = var_11_0

		if var_11_0 == 0 then
			arg_11_1()
			arg_11_0:ActivePanel(arg_11_0.enterPanel, false)
			arg_11_0.timer:Stop()

			arg_11_0.timer = nil
			arg_11_0.inDownCnt = nil
		end

		return
	end, 1, -1)

	arg_11_0.timer:Start()
	arg_11_0.timer.func()

	return
end

function var_0_0.OnStartGame(arg_13_0)
	var_0_1(arg_13_0.jumpBtn, function()
		arg_13_0.controller:PlayerJump()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)

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
	local var_19_0 = GetOrAddComponent(arg_19_1, "EventTriggerListener")
	local var_19_1 = GameObject.Find("UICamera"):GetComponent("Camera"):WorldToScreenPoint(arg_19_0.leftLayout.position)
	local var_19_2 = 0
	local var_19_3 = 10

	local function var_19_4(arg_20_0, arg_20_1)
		var_19_2 = arg_20_1.position.x - var_19_1.x

		if var_19_2 < -var_19_3 then
			if arg_19_3 then
				arg_19_3()
			end
		elseif var_19_2 > var_19_3 then
			if arg_19_2 then
				arg_19_2()
			end
		elseif arg_19_5 then
			arg_19_5()
		end

		return
	end

	var_19_0:AddPointDownFunc(function(arg_21_0, arg_21_1)
		var_19_2 = 0

		var_19_4(arg_21_0, arg_21_1)

		return
	end)
	var_19_0:AddDragFunc(function(arg_20_0, arg_20_1)
		var_19_2 = arg_20_1.position.x - var_19_1.x

		if var_19_2 < -var_19_3 then
			if arg_19_3 then
				arg_19_3()
			end
		elseif var_19_2 > var_19_3 then
			if arg_19_2 then
				arg_19_2()
			end
		elseif arg_19_5 then
			arg_19_5()
		end

		return
	end)
	var_19_0:AddPointUpFunc(function(arg_22_0, arg_22_1)
		var_19_2 = 0

		if arg_19_4 then
			arg_19_4()
		end

		return
	end)

	return
end

function var_0_0.ClearSlip(arg_23_0, arg_23_1)
	local var_23_0 = GetOrAddComponent(arg_23_1, "EventTriggerListener")

	var_23_0:RemovePointDownFunc()
	var_23_0:RemovePointUpFunc()
	var_23_0:RemoveDragFunc()

	return
end

function var_0_0.Update(arg_24_0)
	arg_24_0:AddDebugInput()

	arg_24_0.hrzOffse = arg_24_0.leftOffse + arg_24_0.rightOffse

	arg_24_0.controller:OnStickChange(arg_24_0.hrzOffse)

	return
end

function var_0_0.AddDebugInput(arg_25_0)
	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.A) then
			arg_25_0.leftOffse = -0.06
		end

		if Input.GetKeyUp(KeyCode.A) then
			arg_25_0.leftOffse = 0
		end

		if Input.GetKeyDown(KeyCode.D) then
			arg_25_0.rightOffse = 0.06
		end

		if Input.GetKeyUp(KeyCode.D) then
			arg_25_0.rightOffse = 0
		end

		if Input.GetKeyDown(KeyCode.Space) then
			arg_25_0.controller:PlayerJump()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)
		end
	end

	return
end

function var_0_0.OnCreateMap(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.map = TowerClimbingMap.New(arg_26_0, arg_26_1)

	arg_26_0.map:Init(arg_26_2)

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
	removeOnButton(arg_28_0.jumpBtn)
	arg_28_0:ShowResultPanel(arg_28_1, arg_28_2, arg_28_3)

	return
end

function var_0_0.OnExitGame(arg_29_0)
	setActive(arg_29_0.overView, true)
	setActive(arg_29_0.gameView, false)

	if arg_29_0.map then
		arg_29_0.map:Dispose()
	end

	return
end

function var_0_0.ShowQuitPanel(arg_30_0)
	arg_30_0:ActivePanel(arg_30_0.quitPanel, true)
	onButton(arg_30_0, arg_30_0.quitPanelCconfirmBtn, function()
		arg_30_0:ActivePanel(arg_30_0.quitPanel, false)
		arg_30_0.controller:EndGame()

		return
	end, SFX_PANEL)
	onButton(arg_30_0, arg_30_0.quitPanelCancelBtn, function()
		arg_30_0:ActivePanel(arg_30_0.quitPanel, false)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ShowResultPanel(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_0:ActivePanel(arg_33_0.resultPanel, true)

	arg_33_0.resultPanelScoreTxt.text = arg_33_1
	arg_33_0.resultPanelHScoreTxt.text = arg_33_0.highScores and arg_33_3 <= #arg_33_0.highScores and arg_33_0.highScores[arg_33_3] or arg_33_2

	onButton(arg_33_0, arg_33_0.resultPanelEndBtn, function()
		arg_33_0:ActivePanel(arg_33_0.resultPanel, false)
		arg_33_0.controller:ExitGame()

		return
	end, SFX_PANEL)

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
		pg.UIMgr.GetInstance():BlurPanel(arg_37_1)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_37_1, arg_37_0._tf)
	end

	setActive(arg_37_1, arg_37_2)

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

	if isActive(arg_38_0.resultPanel) then
		arg_38_0:ActivePanel(arg_38_0.resultPanel, false)
		arg_38_0.controller:ExitGame()

		return true
	end

	return false
end

function var_0_0.Dispose(arg_39_0)
	if arg_39_0.timer then
		arg_39_0.timer:Stop()

		arg_39_0.timer = nil
	end

	var_0_2(arg_39_0.jumpBtn)
	arg_39_0:ClearSlip(arg_39_0.moveBtn)
	pg.DelegateInfo.Dispose(arg_39_0)

	if arg_39_0.map then
		arg_39_0.map:Dispose()
	end

	return
end

return var_0_0
