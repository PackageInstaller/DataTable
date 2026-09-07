local OreMiniGameController = class("OreMiniGameController")

function OreMiniGameController:Ctor(arg_1_1, arg_1_2)
	self.binder = arg_1_1

	self:InitTimer()
	self:InitGameUI(arg_1_2)
	self:InitControl()
	self:AddListener()

	return
end

local function var_0_1(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs((arg_2_0:GetComponentsInChildren(typeof(Animator), true):ToTable())) do
		iter_2_1.speed = arg_2_1
	end

	return
end

function OreMiniGameController:InitTimer()
	self.timer = Timer.New(function()
		self:OnTimer(OreGameConfig.TIME_INTERVAL)

		return
	end, OreGameConfig.TIME_INTERVAL, -1)
	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function OreMiniGameController:Update()
	self:AddDebugInput()

	return
end

function OreMiniGameController:AddDebugInput()
	if IsUnityEditor and Input.GetKeyDown(KeyCode.Space) then
		self:OnCarryBtnClick()
	end

	return
end

function OreMiniGameController:InitGameUI(arg_7_1)
	self.uiMgr = pg.UIMgr.GetInstance()
	self.rtViewport = arg_7_1:Find("Viewport")
	self.rtCharacter = self.rtViewport:Find("MainContent/character")
	self.bgManjuu = self.rtViewport:Find("MainContent/bg_back/Manjuu_SW")
	self.rtController = arg_7_1:Find("Controller")
	self.rtTop = arg_7_1:Find("Controller/top")
	self.TimeTextM = self.rtTop:Find("title/TIME/Text_M")
	self.TimeTextS = self.rtTop:Find("title/TIME/Text_S")
	self.pointText = self.rtTop:Find("title/SCORE/Text")
	self.rtBottom = arg_7_1:Find("Controller/bottom")
	self.rtPointer = self.rtBottom:Find("capacity/pointer")
	self.rtJoyStick = self.rtBottom:Find("handle_stick")

	onButton(self.binder, self.rtBottom:Find("btn_carry"), function()
		self:OnCarryBtnClick()

		return
	end)

	return
end

function OreMiniGameController:InitControl()
	self.collisionMgr = OreCollisionMgr.New(self.binder)
	self.akashiControl = OreAkashiControl.New(self.binder, self.rtCharacter:Find("Akashi"), self.collisionMgr)
	self.enemiesControl = OreEnemiesControl.New(self.binder, self.rtCharacter:Find("Enemies"), self.collisionMgr)
	self.minersControl = OreMinersControl.New(self.binder, self.rtCharacter:Find("Miners"), self.collisionMgr)
	self.oreGroupControl = OreGroupControl.New(self.binder, self.rtViewport:Find("MainContent/ore_group"), self.collisionMgr)
	self.containerControl = OreContainerControl.New(self.binder, self.rtViewport:Find("MainContent/container"))

	return
end

function OreMiniGameController:AddListener()
	self.binder:bind(OreGameConfig.EVENT_DO_CARRY, function(arg_11_0, arg_11_1)
		self.weight = self.weight + arg_11_1.weight

		self:UpdateWeightUI()

		return
	end)
	self.binder:bind(OreGameConfig.EVENT_DELIVER, function(arg_12_0, arg_12_1)
		self.point = self.point + arg_12_1.point
		self.weight = 0

		self:UpdatePointUI()
		self:UpdateWeightUI()
		self.bgManjuu:GetComponent(typeof(Animator)):Play("Happy")

		return
	end)
	self.binder:bind(OreGameConfig.EVENT_AKASHI_HIT, function(arg_13_0, arg_13_1)
		self.weight = 0

		self:UpdateWeightUI()
		self.bgManjuu:GetComponent(typeof(Animator)):Play("Shock")

		return
	end)

	return
end

function OreMiniGameController:OnCarryBtnClick()
	self.binder:emit(OreGameConfig.EVENT_CHECK_CARRY, {
		weight = self.weight
	})

	return
end

function OreMiniGameController:UpdateTimeUI()
	if self.timeCount < 60 then
		setText(self.TimeTextM, "00")
	else
		setText(self.TimeTextM, string.format("%02d", self.timeCount / 60))
	end

	setText(self.TimeTextS, string.format("%02d", self.timeCount % 60))

	return
end

function OreMiniGameController:UpdateWeightUI()
	if self.weight == 0 then
		setLocalEulerAngles(self.rtPointer, Vector3(0, 0, 90))

		return
	end

	if self.weight == OreGameConfig.MAX_WEIGHT then
		setLocalEulerAngles(self.rtPointer, Vector3(0, 0, -90))

		return
	end

	local var_16_1 = OreGameConfig.CAPACITY

	setLocalEulerAngles(self.rtPointer, Vector3(0, 0, self.weight <= OreGameConfig.CAPACITY.WOOD_BOX and 90 - self.weight * 40 / var_16_1.WOOD_BOX or self.weight <= var_16_1.IRON_BOX and 37 - (self.weight - var_16_1.WOOD_BOX) * 60 / (var_16_1.IRON_BOX - var_16_1.WOOD_BOX) or -37 - (self.weight - var_16_1.IRON_BOX) * 40 / (var_16_1.CART - var_16_1.IRON_BOX)))

	return
end

function OreMiniGameController:UpdatePointUI()
	setText(self.pointText, self.point)

	return
end

function OreMiniGameController:ResetGame()
	self.timeCount = OreGameConfig.PLAY_TIME
	self.point = 0
	self.weight = 0

	self.akashiControl:Reset()
	self.minersControl:Reset()
	self.oreGroupControl:Reset()
	self.collisionMgr:Reset()
	self.enemiesControl:Reset()
	self.containerControl:Reset()
	self:UpdatePointUI()
	self:UpdateWeightUI()
	self:UpdateTimeUI()

	return
end

function OreMiniGameController:StartGame()
	self.isStart = true

	self:ResetGame()
	self:StartTimer()

	return
end

function OreMiniGameController:EndGame()
	self.isStart = false

	self:PauseGame()
	self.binder:openUI("result")

	return
end

function OreMiniGameController:StartTimer()
	if not self.timer.running then
		self.timer:Start()
		self.uiMgr:AttachStickOb(self.rtJoyStick)
	end

	var_0_1(self.rtViewport, 1)

	return
end

function OreMiniGameController:StopTimer()
	if self.timer.running then
		self.timer:Stop()
		self.uiMgr:ClearStick()
	end

	var_0_1(self.rtViewport, 0)

	return
end

function OreMiniGameController:PauseGame()
	self.isPause = true

	self:StopTimer()

	return
end

function OreMiniGameController:ResumeGame()
	self.isPause = false

	self:StartTimer()

	return
end

function OreMiniGameController:OnTimer(arg_25_1)
	self.timeCount = self.timeCount - arg_25_1

	self:UpdateTimeUI()

	if self.timeCount <= 0 then
		self:EndGame()
	end

	self.akashiControl:OnTimer(arg_25_1)
	self.minersControl:OnTimer(arg_25_1)
	self.oreGroupControl:OnTimer(arg_25_1)
	self.collisionMgr:OnTimer(arg_25_1)
	self.enemiesControl:OnTimer(arg_25_1)
	self.containerControl:OnTimer(arg_25_1)

	return
end

function OreMiniGameController:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if self.timer.running then
		self.timer:Stop()

		self.timer = nil

		self.uiMgr:ClearStick()
	end

	return
end

return OreMiniGameController
