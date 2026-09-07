local CutFruitGamingUI = class("CutFruitGamingUI")

function CutFruitGamingUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3

	self:initUI()

	return
end

function CutFruitGamingUI:initUI()
	self._gameUI = findTF(self._tf, "ui/gamingUI")
	self.btnBack = findTF(self._gameUI, "back")
	self.btnPause = findTF(self._gameUI, "pause")
	self.timeTF = findTF(self._gameUI, "top/ad/time")

	onButton(self._event, self.btnBack, function()
		if not self._gameVo.startSettlement then
			self._event:emit(SimpleMGEvent.PAUSE_GAME, true)
			self._event:emit(SimpleMGEvent.OPEN_LEVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnPause, function()
		if not self._gameVo.startSettlement then
			self._event:emit(SimpleMGEvent.PAUSE_GAME, true)
			self._event:emit(SimpleMGEvent.OPEN_PAUSE_UI)
		end

		return
	end, SFX_CONFIRM)

	self.btnUp = findTF(self._gameUI, "up")
	self.btnDown = findTF(self._gameUI, "down")
	self.btnLeft = findTF(self._gameUI, "left")
	self.btnRight = findTF(self._gameUI, "right")

	onButton(self._event, self.btnUp, function()
		self._event:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_UP)

		return
	end)
	onButton(self._event, self.btnDown, function()
		self._event:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_DOWN)

		return
	end)
	onButton(self._event, self.btnLeft, function()
		self._event:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_LEFT)

		return
	end)
	onButton(self._event, self.btnRight, function()
		self._event:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_RIGHT)

		return
	end)

	return
end

function CutFruitGamingUI:Show(arg_9_1)
	setActive(self._gameUI, arg_9_1)

	return
end

function CutFruitGamingUI:Update()
	return
end

function CutFruitGamingUI:Start()
	self.subGameStepTime = 0

	self:Show(true)

	self._editorFlag = self._gameVo:GetEditor()

	local var_11_0 = getProxy(MiniGameProxy):GetHighScore(self._gameVo:GetGameId())

	if not var_11_0 or #var_11_0 <= 0 or not var_11_0[1] then
		-- block empty
	end

	self._score = 0
	self._time = -1

	return
end

function CutFruitGamingUI:Step()
	if self._time ~= self._gameVo:GetTimeInteger() then
		self._time = self._gameVo:GetTimeInteger()

		if self._time < 0 then
			self._time = 0
		end

		setText(self.timeTF, math.floor(self._time))
	end

	if self._score ~= self._gameVo:GetScore() then
		self._score = self._gameVo:GetScore()
	end

	return
end

function CutFruitGamingUI:SetChildVisible(arg_13_1, arg_13_2)
	for iter_13_0 = 1, arg_13_1.childCount do
		setActive(arg_13_1:GetChild(iter_13_0 - 1), arg_13_2)
	end

	return
end

function CutFruitGamingUI:Press(arg_14_1, arg_14_2)
	return
end

return CutFruitGamingUI
