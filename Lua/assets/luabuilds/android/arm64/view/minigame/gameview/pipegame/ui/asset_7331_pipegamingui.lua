local PipeGamingUI = class("PipeGamingUI")
local var_0_1

function PipeGamingUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	var_0_1 = PipeGameVo
	self._gameUI = findTF(self._tf, "ui/gamingUI")
	self.btnBack = findTF(self._gameUI, "back")
	self.btnPause = findTF(self._gameUI, "pause")
	self.gameTime = findTF(self._gameUI, "time")

	onButton(self._event, self.btnBack, function()
		if not var_0_1.startSettlement then
			self._event:emit(PipeGameEvent.PAUSE_GAME, true)
			self._event:emit(PipeGameEvent.OPEN_LEVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnPause, function()
		if not var_0_1.startSettlement then
			self._event:emit(PipeGameEvent.PAUSE_GAME, true)
			self._event:emit(PipeGameEvent.OPEN_PAUSE_UI)
		end

		return
	end, SFX_CONFIRM)

	return
end

function PipeGamingUI:show(arg_4_1)
	setActive(self._gameUI, arg_4_1)

	return
end

function PipeGamingUI:update()
	return
end

function PipeGamingUI:start()
	self.subGameStepTime = 0

	self:show(true)

	return
end

function PipeGamingUI:addScore(arg_7_1)
	return
end

function PipeGamingUI:step(arg_8_1)
	setText(self.gameTime, math.floor(var_0_1.gameDragTime))

	if var_0_1.gameDragTime <= 0 then
		self:show(false)
	elseif var_0_1.startSettlement and isActive(self._gameUI) then
		self:show(false)
	end

	return
end

function PipeGamingUI:press(arg_9_1, arg_9_2)
	return
end

return PipeGamingUI
