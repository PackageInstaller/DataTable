local TowerClimbingView = class("TowerClimbingView")

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

function TowerClimbingView:Ctor(arg_5_1)
	pg.DelegateInfo.New(self)

	self.controller = arg_5_1
	self.roomTip = pg.gametip.towerclimbing_gametip.tip

	return
end

function TowerClimbingView:SetUI(arg_6_1)
	self._go = arg_6_1
	self._tf = arg_6_1.transform
	self.overView = findTF(self._tf, "overview")
	self.gameView = findTF(self._tf, "AD")
	self.maps = {
		findTF(self._tf, "overview/maps/1"),
		findTF(self._tf, "overview/maps/2"),
		findTF(self._tf, "overview/maps/3")
	}
	self.exitGameBtn = findTF(self.gameView, "back")
	self.jumpBtn = findTF(self.gameView, "prints/right_btn_layout/up")
	self.leftLayout = findTF(self.gameView, "prints/left_btn_layout")
	self.moveBtn = findTF(self.leftLayout, "move_btn")
	self.quitPanel = findTF(self._tf, "quit_panel")
	self.quitPanelCancelBtn = self.quitPanel:Find("frame/cancel")
	self.quitPanelCconfirmBtn = self.quitPanel:Find("frame/confirm")
	self.resultPanel = findTF(self._tf, "result_panel")
	self.resultPanelScoreTxt = self.resultPanel:Find("frame/curr/Text"):GetComponent(typeof(Text))
	self.resultPanelHScoreTxt = self.resultPanel:Find("frame/higtest/Text"):GetComponent(typeof(Text))
	self.resultPanelEndBtn = self.resultPanel:Find("frame/cancel")
	self.helpBtn = self._tf:Find("overview/logo/help")
	self.enterPanel = self._tf:Find("enter_panel")
	self.enterPanelTxt = self.enterPanel:Find("Text"):GetComponent(typeof(Text))

	self:ResetParams()

	return
end

function TowerClimbingView:OnEnter(arg_7_1)
	setActive(self.overView, true)
	setActive(self.gameView, false)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = self.roomTip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.exitGameBtn, function()
		self:ShowQuitPanel()

		return
	end, SFX_PANEL)

	for iter_7_0, iter_7_1 in ipairs(self.maps) do
		onButton(self, iter_7_1, function()
			self.controller:StartGame(iter_7_0)

			return
		end, SFX_PANEL)
	end

	return
end

function TowerClimbingView:DoEnter(arg_11_1)
	setActive(self.overView, false)
	setActive(self.gameView, true)

	self.inDownCnt = true

	self:ActivePanel(self.enterPanel, true)

	local var_11_0 = 4

	self.timer = Timer.New(function()
		var_11_0 = var_11_0 - 1

		if var_11_0 == 3 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_STEP_PILE_COUNTDOWN)
		end

		self.enterPanelTxt.text = var_11_0

		if var_11_0 == 0 then
			arg_11_1()
			self:ActivePanel(self.enterPanel, false)
			self.timer:Stop()

			self.timer = nil
			self.inDownCnt = nil
		end

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function TowerClimbingView:OnStartGame()
	var_0_1(self.jumpBtn, function()
		self.controller:PlayerJump()
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)

		return
	end)
	self:OnSlip(self.moveBtn, function()
		self.rightOffse = 0.06
		self.leftOffse = 0

		return
	end, function()
		self.rightOffse = 0
		self.leftOffse = -0.06

		return
	end, function()
		self.rightOffse = 0
		self.leftOffse = 0

		return
	end, function()
		self.rightOffse = 0
		self.leftOffse = 0

		return
	end)

	return
end

function TowerClimbingView:OnSlip(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = GetOrAddComponent(arg_19_1, "EventTriggerListener")
	local var_19_1 = GameObject.Find("UICamera"):GetComponent("Camera"):WorldToScreenPoint(self.leftLayout.position)
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
	var_19_0:AddDragFunc(var_19_4)
	var_19_0:AddPointUpFunc(function(arg_22_0, arg_22_1)
		var_19_2 = 0

		if arg_19_4 then
			arg_19_4()
		end

		return
	end)

	return
end

function TowerClimbingView:ClearSlip(arg_23_1)
	local var_23_0 = GetOrAddComponent(arg_23_1, "EventTriggerListener")

	var_23_0:RemovePointDownFunc()
	var_23_0:RemovePointUpFunc()
	var_23_0:RemoveDragFunc()

	return
end

function TowerClimbingView:Update()
	self:AddDebugInput()

	self.hrzOffse = self.leftOffse + self.rightOffse

	self.controller:OnStickChange(self.hrzOffse)

	return
end

function TowerClimbingView:AddDebugInput()
	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.A) then
			self.leftOffse = -0.06
		end

		if Input.GetKeyUp(KeyCode.A) then
			self.leftOffse = 0
		end

		if Input.GetKeyDown(KeyCode.D) then
			self.rightOffse = 0.06
		end

		if Input.GetKeyUp(KeyCode.D) then
			self.rightOffse = 0
		end

		if Input.GetKeyDown(KeyCode.Space) then
			self.controller:PlayerJump()
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)
		end
	end

	return
end

function TowerClimbingView:OnCreateMap(arg_26_1, arg_26_2)
	self.map = TowerClimbingMap.New(self, arg_26_1)

	self.map:Init(arg_26_2)

	return
end

function TowerClimbingView:ResetParams()
	self.leftOffse = 0
	self.rightOffse = 0
	self.hrzOffse = 0

	return
end

function TowerClimbingView:OnEndGame(arg_28_1, arg_28_2, arg_28_3)
	self:ResetParams()
	removeOnButton(self.jumpBtn)
	self:ShowResultPanel(arg_28_1, arg_28_2, arg_28_3)

	return
end

function TowerClimbingView:OnExitGame()
	setActive(self.overView, true)
	setActive(self.gameView, false)

	if self.map then
		self.map:Dispose()
	end

	return
end

function TowerClimbingView:ShowQuitPanel()
	self:ActivePanel(self.quitPanel, true)
	onButton(self, self.quitPanelCconfirmBtn, function()
		self:ActivePanel(self.quitPanel, false)
		self.controller:EndGame()

		return
	end, SFX_PANEL)
	onButton(self, self.quitPanelCancelBtn, function()
		self:ActivePanel(self.quitPanel, false)

		return
	end, SFX_PANEL)

	return
end

function TowerClimbingView:ShowResultPanel(arg_33_1, arg_33_2, arg_33_3)
	self:ActivePanel(self.resultPanel, true)

	self.resultPanelScoreTxt.text = arg_33_1
	self.resultPanelHScoreTxt.text = self.highScores and arg_33_3 <= #self.highScores and self.highScores[arg_33_3] or arg_33_2

	onButton(self, self.resultPanelEndBtn, function()
		self:ActivePanel(self.resultPanel, false)
		self.controller:ExitGame()

		return
	end, SFX_PANEL)

	return
end

function TowerClimbingView:SetHighScore(arg_35_1)
	self.highScores = arg_35_1

	return
end

function TowerClimbingView:setRoomTip(arg_36_1)
	self.roomTip = arg_36_1

	return
end

function TowerClimbingView:ActivePanel(arg_37_1, arg_37_2)
	if arg_37_2 then
		pg.UIMgr.GetInstance():BlurPanel(arg_37_1)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_37_1, self._tf)
	end

	setActive(arg_37_1, arg_37_2)

	return
end

function TowerClimbingView:onBackPressed()
	if self.inDownCnt then
		return true
	end

	if self.controller.IsStarting then
		self:ShowQuitPanel()

		return true
	end

	if isActive(self.resultPanel) then
		self:ActivePanel(self.resultPanel, false)
		self.controller:ExitGame()

		return true
	end

	return false
end

function TowerClimbingView:Dispose()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	var_0_2(self.jumpBtn)
	self:ClearSlip(self.moveBtn)
	pg.DelegateInfo.Dispose(self)

	if self.map then
		self.map:Dispose()
	end

	return
end

return TowerClimbingView
