local SailBoatGamingUI = class("SailBoatGamingUI")
local var_0_1

function SailBoatGamingUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	var_0_1 = SailBoatGameVo
	self._gameUI = findTF(self._tf, "ui/gamingUI")
	self.btnBack = findTF(self._gameUI, "back")
	self.btnPause = findTF(self._gameUI, "pause")
	self.gameTime = findTF(self._gameUI, "time")
	self.gameScore = findTF(self._gameUI, "score")
	self.btnSkill = findTF(self._gameUI, "skill")
	self.skillCount = findTF(self._gameUI, "skill/amount")
	self.progress = GetComponent(findTF(self._gameUI, "progress"), typeof(Slider))
	self.powerTf = findTF(self._gameUI, "power")

	onButton(self._event, self.btnSkill, function()
		if self.skillTime > 0 then
			return
		end

		if var_0_1.UseSkill() then
			self._event:emit(SailBoatGameView.USE_SKILL)

			self.skillTime = var_0_1.skillTime

			setActive(self.powerTf, false)
			setActive(self.powerTf, true)
		end

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnBack, function()
		self._event:emit(SailBoatGameView.PAUSE_GAME, true)
		self._event:emit(SailBoatGameView.OPEN_LEVEL_UI)

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnPause, function()
		self._event:emit(SailBoatGameView.PAUSE_GAME, true)
		self._event:emit(SailBoatGameView.OPEN_PAUSE_UI)

		return
	end, SFX_CONFIRM)

	self.direct = Vector2(0, 0)
	self.joyStick = MiniGameJoyStick.New(findTF(self._gameUI, "joyStick"))

	self.joyStick:setActiveCallback(function(arg_5_0)
		return
	end)

	self._hpTf = findTF(self._gameUI, "hp")
	self._hpSlider = GetComponent(self._hpTf, typeof(Slider))
	self._powerEnemy = findTF(self._gameUI, "powerEnemy")

	return
end

function SailBoatGamingUI:show(arg_6_1)
	setActive(self._gameUI, arg_6_1)

	return
end

function SailBoatGamingUI:update()
	return
end

function SailBoatGamingUI:start()
	self.direct = Vector2(0, 0)
	self.subGameStepTime = 0
	self.maxProgress = var_0_1.GetRoundData().progress
	self.powers = Clone(var_0_1.GetRoundData().powers)

	setText(self.skillCount, var_0_1.GetSkill())

	self.skillTime = 0
	self._char = nil

	setActive(self._powerEnemy, false)
	setActive(self.powerTf, false)

	return
end

function SailBoatGamingUI:addScore(arg_9_1)
	return
end

function SailBoatGamingUI:step(arg_10_1)
	if not self._char then
		self._char = var_0_1.GetGameChar()
		self._hpSlider.minValue = 0
		self._hpSlider.maxValue = self._char:getMaxHp()
	end

	local var_10_0 = var_0_1.gameTime

	setText(self.gameScore, var_0_1.scoreNum)
	setText(self.gameTime, math.floor(var_10_0))

	self.progress.value = var_0_1.gameStepTime / self.maxProgress

	self.joyStick:step()
	self.joyStick:setDirectTarget(self.direct)

	if self.skillTime > 0 then
		self.skillTime = self.skillTime - arg_10_1
	end

	SailBoatGameVo.joyStickData = self.joyStick:getValue()

	setText(self.skillCount, var_0_1.GetSkill())

	local var_10_1 = self._char:getHpPos()

	self._hpTf.position = var_10_1
	self.powerTf.position = var_10_1
	self._hpSlider.value = self._char:getHp()

	for iter_10_0 = #self.powers, 1, -1 do
		if var_0_1.gameStepTime > self.powers[iter_10_0] then
			table.remove(self.powers, iter_10_0)
			setActive(self._powerEnemy, false)
			setActive(self._powerEnemy, true)
		end
	end

	return
end

function SailBoatGamingUI:press(arg_11_1, arg_11_2)
	if arg_11_1 == KeyCode.W then
		if arg_11_2 then
			self.direct.y = 1
		elseif self.direct.y == 1 then
			self.direct.y = 0
		end
	elseif arg_11_1 == KeyCode.S then
		if arg_11_2 then
			self.direct.y = -1
		elseif self.direct.y == -1 then
			self.direct.y = 0
		end
	elseif arg_11_1 == KeyCode.A then
		if arg_11_2 then
			self.direct.x = -1
		elseif self.direct.x == -1 then
			self.direct.x = 0
		end
	elseif arg_11_1 == KeyCode.D then
		if arg_11_2 then
			self.direct.x = 1
		elseif self.direct.x == 1 then
			self.direct.x = 0
		end
	end

	return
end

return SailBoatGamingUI
