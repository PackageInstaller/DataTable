local BoatAdGamingUI = class("BoatAdGamingUI")
local var_0_1

function BoatAdGamingUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	var_0_1 = BoatAdGameVo
	self._gameUI = findTF(self._tf, "ui/gamingUI")
	self.btnBack = findTF(self._gameUI, "back")
	self.btnPause = findTF(self._gameUI, "pause")
	self.gameTime = findTF(self._gameUI, "topRight/timeImg/time")
	self.gameScore = findTF(self._gameUI, "topRight/scoreImg/score")

	onButton(self._event, self.btnBack, function()
		self._event:emit(SimpleMGEvent.PAUSE_GAME, true)
		self._event:emit(SimpleMGEvent.OPEN_LEVEL_UI)

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnPause, function()
		self._event:emit(SimpleMGEvent.PAUSE_GAME, true)
		self._event:emit(SimpleMGEvent.OPEN_PAUSE_UI)

		return
	end, SFX_CONFIRM)

	self.direct = Vector2(0, 0)
	self.joyStickTf = findTF(self._gameUI, "joyStick")
	self.joyStick = MiniGameJoyStick.New(self.joyStickTf)

	self.joyStick:setActiveCallback(function(arg_4_0)
		return
	end)

	return
end

function BoatAdGamingUI:show(arg_5_1)
	setActive(self._gameUI, arg_5_1)

	return
end

function BoatAdGamingUI:update()
	return
end

function BoatAdGamingUI:start()
	self.direct = Vector2(0, 0)
	self.subGameStepTime = 0
	self._char = nil

	return
end

function BoatAdGamingUI:step(arg_8_1)
	self._char = self._char or var_0_1.GetGameChar()
	self.joyStickTf.position = self._char:getWorld()

	setText(self.gameScore, var_0_1.scoreNum)
	setText(self.gameTime, math.floor(var_0_1.gameStepTime))

	if self.leftFlag and self.rightFlag then
		self.direct.x = self.lastDirect
	elseif self.leftFlag then
		self.direct.x = -1
	elseif self.rightFlag then
		self.direct.x = 1
	elseif not self.leftFlag and not self.rightFlag then
		self.direct.x = 0
	end

	self.joyStick:step()
	self.joyStick:setDirectTarget(self.direct)

	var_0_1.joyStickData = self.joyStick:getValue()

	return
end

function BoatAdGamingUI:press(arg_9_1, arg_9_2)
	if arg_9_1 == KeyCode.W then
		-- block empty
	elseif arg_9_1 == KeyCode.S then
		-- block empty
	elseif arg_9_1 == KeyCode.A then
		self.leftFlag = arg_9_2

		if arg_9_2 then
			self.lastDirect = -1
		end
	elseif arg_9_1 == KeyCode.D then
		self.rightFlag = arg_9_2

		if arg_9_2 then
			self.lastDirect = 1
		end
	end

	return
end

return BoatAdGamingUI
