local LaunchBallGamingUI = class("LaunchBallGamingUI")

function LaunchBallGamingUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameUI = findTF(self._tf, "ui/gamingUI")
	self.btnBack = findTF(self._gameUI, "back")
	self.btnPause = findTF(self._gameUI, "pause")
	self.gameTime = findTF(self._gameUI, "time")
	self.gameScore = findTF(self._gameUI, "score")

	onButton(self._event, self.btnBack, function()
		self._event:emit(LaunchBallGameView.PAUSE_GAME, true)
		self._event:emit(LaunchBallGameView.OPEN_LEVEL_UI)

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnPause, function()
		self._event:emit(LaunchBallGameView.PAUSE_GAME, true)
		self._event:emit(LaunchBallGameView.OPEN_PAUSE_UI)

		return
	end, SFX_CONFIRM)

	self.direct = Vector2(0, 0)
	self.skill = findTF(self._gameUI, "Skill")
	self.skillAnim = GetComponent(findTF(self.skill, "ad/anim"), typeof(Animator))

	onButton(self._event, self.skill, function()
		self._event:emit(LaunchBallGameView.PRESS_SKILL)

		return
	end)

	self.skillCd = findTF(self.skill, "ad/black")

	return
end

function LaunchBallGamingUI:show(arg_5_1)
	setActive(self._gameUI, arg_5_1)

	return
end

function LaunchBallGamingUI:update()
	return
end

function LaunchBallGamingUI:start()
	self.direct = Vector2(0, 0)
	self.subGameStepTime = 0

	return
end

function LaunchBallGamingUI:addScore(arg_8_1)
	return
end

function LaunchBallGamingUI:step()
	if LaunchBallGameVo.enemyStopTime and LaunchBallGameVo.enemyStopTime > 0 then
		self.subGameStepTime = self.subGameStepTime + LaunchBallGameVo.deltaTime
	end

	setText(self.gameTime, math.floor(LaunchBallGameVo.gameStepTime - self.subGameStepTime))
	setText(self.gameScore, LaunchBallGameVo.scoreNum)

	if LaunchBallGameVo.pressSkill and LaunchBallGameVo.pressSkill.time > 0 then
		setFillAmount(self.skillCd, LaunchBallGameVo.pressSkill.time / LaunchBallGameVo.pressSkill.data.cd_time)

		if not isActive(self.skillCd) then
			self.skillAnim:Play("empty")
			setActive(self.skillCd, true)
		end
	elseif isActive(self.skillCd) then
		setActive(self.skillCd, false)
		self.skillAnim:Play("Skill")
	end

	return
end

function LaunchBallGamingUI:press(arg_10_1, arg_10_2)
	if arg_10_1 == KeyCode.W then
		if arg_10_2 then
			self.direct.y = 1
		elseif self.direct.y == 1 then
			self.direct.y = 0
		end
	end

	if arg_10_1 == KeyCode.S then
		if arg_10_2 then
			self.direct.y = -1
		elseif self.direct.y == -1 then
			self.direct.y = 0
		end
	end

	if arg_10_1 == KeyCode.A then
		if arg_10_2 then
			self.direct.x = -1
		elseif self.direct.x == -1 then
			self.direct.x = 0
		end
	end

	if arg_10_1 == KeyCode.D then
		if arg_10_2 then
			self.direct.x = 1
		elseif self.direct.x == 1 then
			self.direct.x = 0
		end
	end

	return
end

return LaunchBallGamingUI
