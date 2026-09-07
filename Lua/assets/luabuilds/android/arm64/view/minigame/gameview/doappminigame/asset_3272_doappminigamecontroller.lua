local DOAPPMiniGameController = class("DOAPPMiniGameController")

function DOAPPMiniGameController:Ctor(arg_1_1, arg_1_2)
	self.binder = arg_1_1

	self:InitTimer()
	self:InitGameUI(arg_1_2)

	return
end

local function var_0_1(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs((arg_2_0:GetComponentsInChildren(typeof(Animator), true):ToTable())) do
		iter_2_1.speed = arg_2_1
	end

	return
end

function DOAPPMiniGameController:InitTimer()
	self.timer = Timer.New(function()
		self:OnTimer(DOAPPGameConfig.TIME_INTERVAL)

		return
	end, DOAPPGameConfig.TIME_INTERVAL, -1)

	if IsUnityEditor and not self.handle then
		self.handle = UpdateBeat:CreateListener(self.AddDebugInput, self)

		UpdateBeat:AddListener(self.handle)
	end

	return
end

function DOAPPMiniGameController:AddDebugInput()
	local var_5_0 = {
		"E",
		"S",
		"W",
		"N"
	}

	for iter_5_0, iter_5_1 in ipairs({
		"D",
		"S",
		"A",
		"W"
	}) do
		if Input.GetKeyDown(KeyCode[iter_5_1]) then
			self.cacheInput = var_5_0[iter_5_0]
		end

		if Input.GetKeyUp(KeyCode[iter_5_1]) and self.cacheInput == var_5_0[iter_5_0] then
			self.cacheInput = nil
		end
	end

	return
end

local var_0_2 = {
	"Light",
	"Heavy",
	"Dodge"
}

function DOAPPMiniGameController:InitGameUI(arg_6_1)
	self.rtViewport = arg_6_1:Find("Viewport")
	self.rtBg = self.rtViewport:Find("MainContent/bg")
	self.rtCharacter = self.rtViewport:Find("MainContent/character")
	self.rtPlayContent = self.rtViewport:Find("MainContent/playContent")
	self.rtBtns = arg_6_1:Find("Controller/middle/btn")

	eachChild(self.rtBtns, function(arg_7_0)
		onButton(self.binder, arg_7_0, function()
			self.selectAction = table.indexof(var_0_2, arg_7_0.name)

			setActive(self.rtBtns, false)
			self:AfterSelect()

			return
		end, SFX_CONFIRM)

		return
	end)
	setActive(self.rtBtns, false)

	self.rtFloatUI = arg_6_1:Find("Controller/middle/targetUI")

	setActive(self.rtFloatUI, false)
	eachChild(self.rtPlayContent:Find("middle/EffectObject"), function(arg_9_0)
		arg_9_0:Find("Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_9_0, false)

			return
		end)

		return
	end)
	eachChild(self.rtPlayContent:Find("middle/EffectOtherObject"), function(arg_11_0)
		arg_11_0:Find("Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_11_0, false)

			return
		end)

		return
	end)

	self.rtPointShow = arg_6_1:Find("Controller/middle/point")
	self.textTime = arg_6_1:Find("Controller/top/panel/time")
	self.rtPoint = arg_6_1:Find("Controller/top/self")
	self.rtPointOther = arg_6_1:Find("Controller/top/others")

	return
end

local var_0_3 = {
	"Misaki",
	"Marie",
	"Tamaki",
	"Luna"
}

function DOAPPMiniGameController:SetCharacter(arg_13_1)
	self.rtTarget = cloneTplTo(self.rtCharacter:Find(arg_13_1), self.rtPlayContent:Find("front"), arg_13_1)

	local var_13_0 = self.rtTarget:Find("Image"):GetComponent(typeof(DftAniEvent))

	var_13_0:SetEndEvent(function()
		if math.abs(self.deltaMove) > 2 then
			self:ReadyPoint()
		else
			self:UpdateReady(self.rtTarget)
		end

		return
	end)
	var_13_0:SetTriggerEvent(function()
		self.countTarget = self.countTarget + 1

		eachChild(self.rtTarget:Find("effect"), function(arg_16_0)
			if arg_16_0.name == self.statusTarget .. "_" .. self.countTarget then
				setActive(arg_16_0, true)
			end

			return
		end)

		return
	end)
	eachChild(self.rtTarget:Find("effect"), function(arg_17_0)
		arg_17_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_17_0, false)

			return
		end)

		return
	end)
	eachChild(self.rtPoint:Find("icon/mask"), function(arg_19_0)
		setActive(arg_19_0, arg_19_0.name == arg_13_1)

		return
	end)

	local var_13_1 = var_0_3[(table.indexof(var_0_3, arg_13_1) + math.random(3) + 3) % 4 + 1]

	self.rtOtherTarget = cloneTplTo(self.rtCharacter:Find(var_13_1), self.rtPlayContent:Find("back"), var_13_1)

	eachChild(self.rtOtherTarget, function(arg_20_0)
		setAnchoredPosition(arg_20_0, {
			x = 5
		})

		return
	end)
	setLocalScale(self.rtOtherTarget, {
		x = -1
	})

	local var_13_2 = self.rtOtherTarget:Find("Image"):GetComponent(typeof(DftAniEvent))

	var_13_2:SetEndEvent(function()
		if math.abs(self.deltaMove) > 2 then
			self:ReadyPoint()
		else
			self:UpdateReady(self.rtOtherTarget)
		end

		return
	end)
	var_13_2:SetTriggerEvent(function()
		self.countOther = self.countOther + 1

		eachChild(self.rtOtherTarget:Find("effect"), function(arg_23_0)
			if arg_23_0.name == self.statusOther .. "_" .. self.countOther then
				setActive(arg_23_0, true)
			end

			return
		end)

		return
	end)
	eachChild(self.rtOtherTarget:Find("effect"), function(arg_24_0)
		arg_24_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
			setActive(arg_24_0, false)

			return
		end)

		return
	end)
	eachChild(self.rtPointOther:Find("icon/mask"), function(arg_26_0)
		setActive(arg_26_0, arg_26_0.name == var_13_1)

		return
	end)

	self.rtEffectObject = self.rtPlayContent:Find("middle/EffectObject")

	return
end

local function var_0_4(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0:Find("point")

	for iter_27_0 = var_27_0.childCount, 1, -1 do
		triggerToggle(var_27_0:GetChild(iter_27_0 - 1), iter_27_0 <= arg_27_1)
	end

	return
end

function DOAPPMiniGameController:UpdatePoint()
	var_0_4(self.rtPoint, self.myPoint)
	var_0_4(self.rtPointOther, self.otherPoint)

	return
end

function DOAPPMiniGameController:UpdateReady(arg_29_1)
	onNextTick(function()
		if arg_29_1 == self.rtTarget then
			setActive(self.rtBtns, true)
		elseif arg_29_1 == self.rtOtherTarget then
			setAnchoredPosition(self.rtFloatUI, {
				x = self.deltaMove * 60
			})

			self.otherSelectAction = math.random(3)

			eachChild(self.rtFloatUI, function(arg_31_0)
				setActive(arg_31_0, arg_31_0.name == tostring(self.otherSelectAction))

				return
			end)

			self.selectCountdown = DOAPPGameConfig.SELECT_TIME

			setSlider(self.rtFloatUI:Find(self.otherSelectAction .. "/Slider"), 0, DOAPPGameConfig.SELECT_TIME, DOAPPGameConfig.SELECT_TIME - self.selectCountdown)
			setActive(self.rtFloatUI, true)
			self:AfterSelect()
		else
			assert(false)
		end

		setAnchoredPosition(arg_29_1, {
			x = self.deltaMove * 10
		})

		return
	end)
	quickPlayAnimator(arg_29_1:Find("Image"), "Idle")

	return
end

function DOAPPMiniGameController:PlayEffect(arg_32_1)
	setAnchoredPosition(self.rtEffectObject, {
		x = self.deltaMove * 10
	})

	self.effectCountdownDic[arg_32_1] = DOAPPGameConfig.EFFECT_COUNTDOWN[arg_32_1]

	return
end

function DOAPPMiniGameController:AfterSelect()
	if self.selectAction and self.otherSelectAction then
		setActive(self.rtFloatUI, false)
		switch((self.selectAction - self.otherSelectAction + 3) % 3, {
			[0] = function()
				quickPlayAnimator(self.rtTarget:Find("Image"), "Draw")
				quickPlayAnimator(self.rtOtherTarget:Find("Image"), "Draw")

				self.stopTarget = nil

				self:PlayEffect("Draw")

				self.blockMoveBg = true

				return
			end,
			function()
				self.deltaMove = self.deltaMove + 1

				local var_35_0 = math.abs(self.deltaMove) > 2 and {
					"Win_",
					"Lose_"
				} or {
					"Attack_",
					"Damage_"
				}

				setParent(self.rtTarget, self.rtPlayContent:Find("front"))
				quickPlayAnimator(self.rtTarget:Find("Image"), var_35_0[1] .. var_0_2[self.selectAction])

				self.statusTarget = var_35_0[1] .. var_0_2[self.selectAction]
				self.countTarget = 0

				setParent(self.rtOtherTarget, self.rtPlayContent:Find("back"))
				quickPlayAnimator(self.rtOtherTarget:Find("Image"), var_35_0[2] .. var_0_2[self.otherSelectAction])

				self.statusOther = var_35_0[2] .. var_0_2[self.otherSelectAction]
				self.countOther = 0
				self.rtEffectObject = self.rtPlayContent:Find("middle/EffectObject")
				self.stopTarget = self.rtOtherTarget

				self:PlayEffect(var_0_2[self.selectAction])

				self.blockMoveBg = true

				if math.abs(self.deltaMove) > 2 then
					self.loseDropCountdown = DOAPPGameConfig.LOSE_SOUND_COUNTDOWN[var_0_2[self.otherSelectAction]] + defaultValue(DOAPPGameConfig.EFFECT_STOP_TIME[var_0_2[self.selectAction]], 0)
				end

				return
			end,
			function()
				self.deltaMove = self.deltaMove - 1

				local var_36_0 = math.abs(self.deltaMove) > 2 and {
					"Win_",
					"Lose_"
				} or {
					"Attack_",
					"Damage_"
				}

				setParent(self.rtTarget, self.rtPlayContent:Find("back"))
				quickPlayAnimator(self.rtTarget:Find("Image"), var_36_0[2] .. var_0_2[self.selectAction])

				self.statusTarget = var_36_0[2] .. var_0_2[self.selectAction]
				self.countTarget = 0

				setParent(self.rtOtherTarget, self.rtPlayContent:Find("front"))
				quickPlayAnimator(self.rtOtherTarget:Find("Image"), var_36_0[1] .. var_0_2[self.otherSelectAction])

				self.statusOther = var_36_0[1] .. var_0_2[self.otherSelectAction]
				self.countOther = 0
				self.rtEffectObject = self.rtPlayContent:Find("middle/EffectOtherObject")
				self.stopTarget = self.rtTarget

				self:PlayEffect(var_0_2[self.otherSelectAction])

				self.blockMoveBg = true

				if math.abs(self.deltaMove) > 2 then
					self.loseDropCountdown = DOAPPGameConfig.LOSE_SOUND_COUNTDOWN[var_0_2[self.selectAction]] + defaultValue(DOAPPGameConfig.EFFECT_STOP_TIME[var_0_2[self.otherSelectAction]], 0)
				end

				return
			end
		})

		self.selectAction = nil
		self.otherSelectAction = nil
		self.selectCountdown = nil
	end

	return
end

function DOAPPMiniGameController:ReadyPoint()
	if self.readyPointCount > 0 then
		self.readyPointCount = 0

		if self.deltaMove > 0 then
			self.myPoint = self.myPoint + 1
		else
			self.otherPoint = self.otherPoint + 1
		end

		self:UpdatePoint()

		if self.myPoint > 2 or self.otherPoint > 2 then
			self:EndGame(self.myPoint - self.otherPoint)
		else
			self.nextCountdown = DOAPPGameConfig.NEXT_ROUND_COUNTDOWN

			eachChild(self.rtPointShow:Find("left"), function(arg_38_0)
				setActive(arg_38_0, arg_38_0.name == tostring(self.myPoint))

				return
			end)
			eachChild(self.rtPointShow:Find("right"), function(arg_39_0)
				setActive(arg_39_0, arg_39_0.name == tostring(self.otherPoint))

				return
			end)
			setActive(self.rtPointShow, true)
		end
	else
		self.readyPointCount = self.readyPointCount + 1
	end

	return
end

function DOAPPMiniGameController:GetResultInfo(arg_40_1)
	if arg_40_1 then
		return self.rtOtherTarget.name, self.otherPoint, self.result * -1
	else
		return self.rtTarget.name, self.myPoint, self.result
	end

	return
end

function DOAPPMiniGameController:ResetGame()
	self.timeCount = DOAPPGameConfig.ALL_TIME

	setText(self.textTime, string.format("%02ds", self.timeCount))

	self.deltaMove = 0

	if not IsNil(self.rtTarget) then
		Destroy(self.rtTarget)

		self.rtTarget = nil
	end

	if not IsNil(self.rtOtherTarget) then
		Destroy(self.rtOtherTarget)

		self.rtOtherTarget = nil
	end

	setAnchoredPosition(self.rtViewport:Find("MainContent"), {
		x = 0
	})
	eachChild(self.rtViewport:Find("MainContent/bg"), function(arg_42_0)
		setAnchoredPosition(arg_42_0, {
			x = 0
		})

		return
	end)

	self.myPoint = 0
	self.otherPoint = 0
	self.readyPointCount = 0

	setActive(self.rtPointShow, false)

	self.effectCountdownDic = {}

	return
end

function DOAPPMiniGameController:ReadyGame(arg_43_1)
	self:SetCharacter(arg_43_1.name)
	self:UpdatePoint()
	self:PauseGame()

	return
end

function DOAPPMiniGameController:StartGame()
	self.isStart = true

	self:UpdateReady(self.rtTarget)
	self:UpdateReady(self.rtOtherTarget)
	self:ResumeGame()

	return
end

function DOAPPMiniGameController:EndGame(arg_45_1)
	self.isStart = false

	self:PauseGame()

	self.result = arg_45_1 or 0

	self.binder:openUI("result")

	return
end

function DOAPPMiniGameController:ResumeGame()
	self.isPause = false

	self.timer:Start()
	var_0_1(self.rtViewport, 1)

	return
end

function DOAPPMiniGameController:PauseGame()
	self.isPause = true

	self.timer:Stop()
	var_0_1(self.rtViewport, 0)

	return
end

function DOAPPMiniGameController:OnTimer(arg_48_1)
	self.timeCount = self.timeCount - arg_48_1

	setText(self.textTime, string.format("%02ds", self.timeCount))

	if self.timeCount <= 0 then
		self:EndGame(self.myPoint - self.otherPoint)

		return
	end

	if self.selectCountdown then
		self.selectCountdown = self.selectCountdown - arg_48_1

		setSlider(self.rtFloatUI:Find(self.otherSelectAction .. "/Slider"), 0, DOAPPGameConfig.SELECT_TIME, DOAPPGameConfig.SELECT_TIME - self.selectCountdown)
		setText(self.rtFloatUI:Find(self.otherSelectAction .. "/Text"), string.format("%2d%%", (DOAPPGameConfig.SELECT_TIME - self.selectCountdown) * 100 / DOAPPGameConfig.SELECT_TIME))

		if self.selectCountdown <= 0 then
			self.selectAction = (self.otherSelectAction + 1) % 3 + 1

			setActive(self.rtBtns, false)
			self:AfterSelect()
		end
	end

	if self.nextCountdown then
		self.nextCountdown = self.nextCountdown - arg_48_1

		if self.nextCountdown <= 0 then
			self.nextCountdown = nil

			setActive(self.rtPointShow, false)

			self.deltaMove = 0

			self:UpdateReady(self.rtTarget)
			self:UpdateReady(self.rtOtherTarget)
		end
	end

	for iter_48_0, iter_48_1 in pairs(self.effectCountdownDic) do
		self.effectCountdownDic[iter_48_0] = self.effectCountdownDic[iter_48_0] - arg_48_1

		if self.effectCountdownDic[iter_48_0] <= 0 then
			self.effectCountdownDic[iter_48_0] = nil

			setActive(self.rtEffectObject:Find(iter_48_0), true)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(DOAPPGameConfig.SOUND_EFFECT_PP)

			self.blockMoveBg = false

			if self.stopTarget then
				self.stopCount = DOAPPGameConfig.EFFECT_STOP_TIME[iter_48_0]

				if self.stopCount then
					onNextTick(function()
						var_0_1(self.stopTarget, 0)

						return
					end)
				end
			end
		end
	end

	if self.stopCount then
		self.stopCount = self.stopCount - arg_48_1

		if self.stopCount <= 0 then
			self.stopCount = nil

			var_0_1(self.stopTarget, 1)
		end
	end

	if self.loseDropCountdown then
		self.loseDropCountdown = self.loseDropCountdown - arg_48_1

		if self.loseDropCountdown <= 0 then
			self.loseDropCountdown = nil

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(DOAPPGameConfig.SOUND_EFFECT_DROP)
		end
	end

	if not self.blockMoveBg then
		local function var_48_0(arg_50_0, arg_50_1)
			local var_50_0 = arg_50_0.anchoredPosition.x / arg_50_1
			local var_50_1 = arg_50_0.anchoredPosition.x / arg_50_1 < self.deltaMove and {
				var_50_0,
				self.deltaMove
			} or {
				self.deltaMove,
				var_50_0
			}

			setAnchoredPosition(arg_50_0, {
				x = math.clamp(arg_50_0.anchoredPosition.x / arg_50_1 + (self.deltaMove - arg_50_0.anchoredPosition.x / arg_50_1 > 0 and 1 or -1) * (arg_48_1 / DOAPPGameConfig.BG_MOVE_TIME), unpack(var_50_1)) * arg_50_1
			})

			return
		end

		local var_48_1 = self.rtViewport:Find("MainContent")

		if var_48_1.anchoredPosition.x ~= self.deltaMove * DOAPPGameConfig.BG_DISTANCE then
			var_48_0(var_48_1, -1 * DOAPPGameConfig.BG_DISTANCE)

			local var_48_2 = var_48_1:Find("bg")

			for iter_48_2 = 1, var_48_2.childCount - 1 do
				var_48_0(var_48_2:GetChild(iter_48_2 - 1), (iter_48_2 - var_48_2.childCount) * DOAPPGameConfig.BG_DISTANCE)
			end
		end
	end

	return
end

function DOAPPMiniGameController:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	return
end

return DOAPPMiniGameController
