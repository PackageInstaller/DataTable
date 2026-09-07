local WatermelonGamingUI = class("WatermelonGamingUI")

function WatermelonGamingUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3
	self._gameUI = findTF(self._tf, "ui/gamingUI")
	self.btnBack = findTF(self._gameUI, "back")
	self.btnPause = findTF(self._gameUI, "pause")
	self.gameTime = findTF(self._gameUI, "time")
	self.touchUI = findTF(self._gameUI, "touch")
	self.touchEvent = GetComponent(self.touchUI, typeof(EventTriggerListener))
	self.uiCam = GameObject.Find("UICamera"):GetComponent("Camera")

	self.touchEvent:AddPointDownFunc(function(arg_2_0, arg_2_1)
		self._event:emit(WatermelonGameEvent.CLICK_MOVE, {
			pos = self.uiCam:ScreenToWorldPoint(arg_2_1.position),
			callback = function(arg_3_0)
				self.startDrag = arg_3_0

				return
			end
		})

		return
	end)
	self.touchEvent:AddPointUpFunc(function(arg_4_0, arg_4_1)
		if self.startDrag then
			self._event:emit(WatermelonGameEvent.CLICK_DOWN, (self.uiCam:ScreenToWorldPoint(arg_4_1.position)))
		end

		return
	end)
	self.touchEvent:AddDragFunc(function(arg_5_0, arg_5_1)
		if self.startDrag then
			self._event:emit(WatermelonGameEvent.CLICK_MOVE, {
				pos = self.uiCam:ScreenToWorldPoint(arg_5_1.position)
			})
		end

		return
	end)
	onButton(self._event, self.btnBack, function()
		if not self._gameVo.startSettlement then
			self._event:emit(WatermelonGameEvent.PAUSE_GAME, true)
			self._event:emit(WatermelonGameEvent.OPEN_LEVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnPause, function()
		if not self._gameVo.startSettlement then
			self._event:emit(WatermelonGameEvent.PAUSE_GAME, true)
			self._event:emit(WatermelonGameEvent.OPEN_PAUSE_UI)
		end

		return
	end, SFX_CONFIRM)

	self.direct = Vector2(0, 0)
	self.joyStick = MiniGameJoyStick.New(findTF(self._gameUI, "joyStick"))

	self.joyStick:setActiveCallback(function(arg_8_0)
		return
	end)

	self.btnDown = findTF(self._gameUI, "down")

	onButton(self._event, self.btnDown, function()
		self._event:emit(WatermelonGameEvent.CLICK_DOWN)

		return
	end, SFX_CONFIRM)

	self.scoreHigh = findTF(self._gameUI, "score/high")
	self.scoreCurrent = findTF(self._gameUI, "score/current")
	self.nextBall = findTF(self._gameUI, "next/ball")

	return
end

function WatermelonGamingUI:show(arg_10_1)
	setActive(self._gameUI, arg_10_1)

	return
end

function WatermelonGamingUI:update()
	return
end

function WatermelonGamingUI:start()
	self.subGameStepTime = 0

	self:show(true)

	local var_12_0 = getProxy(MiniGameProxy):GetHighScore(self._gameVo.gameId)

	setText(self.scoreHigh, (var_12_0 and #var_12_0 > 0 or nil) and (var_12_0[1] or 0))
	setText(self.scoreCurrent, 0)
	self:setChildVisible(self.nextBall, false)

	return
end

function WatermelonGamingUI:addScore(arg_13_1)
	setText(self.scoreCurrent, self._gameVo.scoreNum)

	return
end

function WatermelonGamingUI:step(arg_14_1)
	setText(self.gameTime, math.floor(self._gameVo.gameTime))
	self.joyStick:step()
	self.joyStick:setDirectTarget(self.direct)
	self._gameVo:setJoyStickData(self.joyStick:getValue())

	return
end

function WatermelonGamingUI:updateBallId(arg_15_1)
	self:setChildVisible(self.nextBall, false)
	setActive(findTF(self.nextBall, arg_15_1), true)

	return
end

function WatermelonGamingUI:setChildVisible(arg_16_1, arg_16_2)
	for iter_16_0 = 1, arg_16_1.childCount do
		setActive(arg_16_1:GetChild(iter_16_0 - 1), arg_16_2)
	end

	return
end

function WatermelonGamingUI:press(arg_17_1, arg_17_2)
	if arg_17_1 == KeyCode.A then
		if arg_17_2 then
			self.direct.x = -1
		elseif self.direct.x == -1 then
			self.direct.x = 0
		end
	elseif arg_17_1 == KeyCode.D then
		if arg_17_2 then
			self.direct.x = 1
		elseif self.direct.x == 1 then
			self.direct.x = 0
		end
	elseif arg_17_1 == KeyCode.J then
		self._event:emit(WatermelonGameEvent.CLICK_DOWN)
	end

	return
end

return WatermelonGamingUI
