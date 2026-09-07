local CastleGamingUI = class("CastleGamingUI")

function CastleGamingUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameUI = findTF(self._tf, "ui/gamingUI")
	self.btnBack = findTF(self._gameUI, "back")
	self.btnPause = findTF(self._gameUI, "pause")
	self.gameTime = findTF(self._gameUI, "time")
	self.gameScore = findTF(self._gameUI, "score")
	self.joyStick = CastleGameJoyStick.New(findTF(self._gameUI, "joyStick"))

	onButton(self._event, self.btnBack, function()
		self._event:emit(CastleGameView.PAUSE_GAME, true)
		self._event:emit(CastleGameView.OPEN_LEVEL_UI)

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnPause, function()
		self._event:emit(CastleGameView.PAUSE_GAME, true)
		self._event:emit(CastleGameView.OPEN_PAUSE_UI)

		return
	end, SFX_CONFIRM)

	self.addScoreTf = findTF(self._gameUI, "addScore")
	self.addScoreAnim = GetComponent(findTF(self._gameUI, "addScore/ad"), typeof(Animator))

	return
end

function CastleGamingUI:show(arg_4_1)
	setActive(self._gameUI, arg_4_1)

	return
end

function CastleGamingUI:update()
	return
end

function CastleGamingUI:start()
	setActive(self.addScoreTf, false)

	self.direct = Vector2(0, 0)

	return
end

function CastleGamingUI:addScore(arg_7_1)
	local var_7_0 = findTF(self.addScoreTf, "ad")

	for iter_7_0 = 0, var_7_0.childCount - 1 do
		setActive(var_7_0:GetChild(iter_7_0), false)
	end

	setActive(findTF(var_7_0, arg_7_1.id), true)
	setText(findTF(var_7_0, arg_7_1.id .. "/txt"), "+" .. tostring(arg_7_1.num))

	self.addScoreTf.anchoredPosition = self._gameUI:InverseTransformPoint(arg_7_1.pos)

	setActive(self.addScoreTf, false)
	setActive(self.addScoreTf, true)

	return
end

function CastleGamingUI:step()
	self.joyStick:step()
	setText(self.gameTime, math.floor(CastleGameVo.gameTime))
	setText(self.gameScore, CastleGameVo.scoreNum)

	CastleGameVo.joyStickData = self.joyStick:getValue()

	self.joyStick:setDirectTarget(self.direct)

	return
end

function CastleGamingUI:press(arg_9_1, arg_9_2)
	if arg_9_1 == KeyCode.W then
		if arg_9_2 then
			self.direct.y = 1
		elseif self.direct.y == 1 then
			self.direct.y = 0
		end
	end

	if arg_9_1 == KeyCode.S then
		if arg_9_2 then
			self.direct.y = -1
		elseif self.direct.y == -1 then
			self.direct.y = 0
		end
	end

	if arg_9_1 == KeyCode.A then
		if arg_9_2 then
			self.direct.x = -1
		elseif self.direct.x == -1 then
			self.direct.x = 0
		end
	end

	if arg_9_1 == KeyCode.D then
		if arg_9_2 then
			self.direct.x = 1
		elseif self.direct.x == 1 then
			self.direct.x = 0
		end
	end

	return
end

return CastleGamingUI
