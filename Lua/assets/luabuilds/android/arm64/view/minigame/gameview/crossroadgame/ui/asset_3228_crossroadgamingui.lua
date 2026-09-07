local CrossRoadGamingUI = class("CrossRoadGamingUI")

function CrossRoadGamingUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3

	self:initUI()

	return
end

function CrossRoadGamingUI:initUI()
	self._gameUI = findTF(self._tf, "ui/gamingUI")
	self.btnBack = findTF(self._gameUI, "back")
	self.lifeTF = findTF(self._gameUI, "top/ad/life")
	self.scoreTF = findTF(self._gameUI, "top/ad/score")
	self.joyStick = findTF(self._gameUI, "joyStick")
	self.movebtnGroup = self.joyStick:Find("left_btn_layout/move_btn")
	self.moveLeftBtn = self.movebtnGroup:Find("left")
	self.moveRightBtn = self.movebtnGroup:Find("right")
	self.workBtn = self.joyStick:Find("right_btn_layout")
	self.goBtn = self.workBtn:Find("go/img")
	self.stopBtn = self.workBtn:Find("stop/img")
	self.time = 0
	self._life = 0
	self.joyData = {
		go = false,
		stop = false,
		left = false,
		right = false
	}

	onButton(self._event, self.btnBack, function()
		if not self._gameVo.startSettlement then
			self._event:emit(SimpleMGEvent.PAUSE_GAME, true)
			self._event:emit(CrossRoadGameView.OPEN_LEAVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	self:bindEventTrigger(self.moveLeftBtn, "left")
	self:bindEventTrigger(self.moveRightBtn, "right")
	self:bindEventTrigger(self.goBtn, "go")
	self:bindEventTrigger(self.stopBtn, "stop")

	return
end

function CrossRoadGamingUI:bindEventTrigger(arg_4_1, arg_4_2)
	GetOrAddComponent(arg_4_1, "EventTriggerListener"):AddPointDownFunc(function()
		self:setJoyData(arg_4_2, true)

		return
	end)
	GetOrAddComponent(arg_4_1, "EventTriggerListener"):AddPointUpFunc(function()
		self:setJoyData(arg_4_2, false)

		return
	end)

	return
end

function CrossRoadGamingUI:setJoyData(arg_7_1, arg_7_2)
	self.joyData[arg_7_1] = arg_7_2

	self._gameVo:SetJoyStickData(self.joyData)

	return
end

function CrossRoadGamingUI:Show(arg_8_1)
	setActive(self._gameUI, arg_8_1)

	return
end

function CrossRoadGamingUI:Start()
	self.subGameStepTime = 0

	self:Show(true)
	self._gameVo:SetJoyStickData(self.joyData)

	local var_9_0 = getProxy(MiniGameProxy):GetHighScore(self._gameVo:GetGameId())

	if not var_9_0 or #var_9_0 <= 0 or not var_9_0[1] then
		-- block empty
	end

	setText(self.scoreTF, 0)

	if self._editorFlag then
		setActive(findTF(self._gameUI, "joyStick"), false)
		setActive(findTF(self._gameUI, "top"), false)
		setActive(findTF(self._gameUI, "bg_top"), false)
	end

	self._score = 0
	self._time = -1

	return
end

function CrossRoadGamingUI:Step()
	self:AddDebugInput()

	if self._score ~= self._gameVo:GetScore() then
		self._score = self._gameVo:GetScore()

		setText(self.scoreTF, self._score)
	end

	if self._life ~= self._gameVo:GetLife() then
		self._life = self._gameVo:GetLife()

		setText(self.lifeTF, "X" .. self._life)
	end

	return
end

function CrossRoadGamingUI:AddDebugInput()
	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.A) then
			self:setJoyData("left", true)
		end

		if Input.GetKeyUp(KeyCode.A) then
			self:setJoyData("left", false)
		end

		if Input.GetKeyDown(KeyCode.D) then
			self:setJoyData("right", true)
		end

		if Input.GetKeyUp(KeyCode.D) then
			self:setJoyData("right", false)
		end

		if Input.GetKeyDown(KeyCode.J) then
			self:setJoyData("go", true)
		end

		if Input.GetKeyUp(KeyCode.J) then
			self:setJoyData("go", false)
		end

		if Input.GetKeyDown(KeyCode.K) then
			self:setJoyData("stop", true)
		end

		if Input.GetKeyUp(KeyCode.K) then
			self:setJoyData("stop", false)
		end
	end

	return
end

function CrossRoadGamingUI:SetChildVisible(arg_12_1, arg_12_2)
	for iter_12_0 = 1, arg_12_1.childCount do
		setActive(arg_12_1:GetChild(iter_12_0 - 1), arg_12_2)
	end

	return
end

return CrossRoadGamingUI
