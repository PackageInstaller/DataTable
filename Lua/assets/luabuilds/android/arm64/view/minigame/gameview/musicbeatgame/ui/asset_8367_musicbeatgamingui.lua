local MusicBeatGamingUI = class("MusicBeatGamingUI")

function MusicBeatGamingUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3
	self._gameUI = findTF(self._tf, "ui/gamingUI")
	self.btnBack = findTF(self._gameUI, "back")
	self.btnPause = findTF(self._gameUI, "pause")

	onButton(self._event, self.btnBack, function()
		if not self._gameVo.startSettlement then
			self._event:emit(MusicBeatGameEvent.PAUSE_GAME, true)
			self._event:emit(MusicBeatGameEvent.OPEN_LEVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnPause, function()
		if not self._gameVo.startSettlement then
			self._event:emit(MusicBeatGameEvent.PAUSE_GAME, true)
			self._event:emit(MusicBeatGameEvent.OPEN_PAUSE_UI)
		end

		return
	end, SFX_CONFIRM)

	self.scoreCurrent = findTF(self._gameUI, "score/text")

	return
end

function MusicBeatGamingUI:show(arg_4_1)
	setActive(self._gameUI, arg_4_1)

	return
end

function MusicBeatGamingUI:update()
	return
end

function MusicBeatGamingUI:start()
	self.subGameStepTime = 0

	self:show(true)

	local var_6_0 = getProxy(MiniGameProxy):GetHighScore(self._gameVo.gameId)

	if not var_6_0 or #var_6_0 <= 0 or not var_6_0[1] then
		-- block empty
	end

	setText(self.scoreCurrent, 0)

	return
end

function MusicBeatGamingUI:addScore(arg_7_1)
	setText(self.scoreCurrent, self._gameVo.scoreNum)

	return
end

function MusicBeatGamingUI:step(arg_8_1)
	return
end

function MusicBeatGamingUI:setChildVisible(arg_9_1, arg_9_2)
	for iter_9_0 = 1, arg_9_1.childCount do
		setActive(arg_9_1:GetChild(iter_9_0 - 1), arg_9_2)
	end

	return
end

function MusicBeatGamingUI:press(arg_10_1, arg_10_2)
	if arg_10_1 == KeyCode.A then
		-- block empty
	elseif arg_10_1 == KeyCode.D then
		-- block empty
	end

	return
end

return MusicBeatGamingUI
