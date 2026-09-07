local PacGamingUI = class("PacGamingUI")

function PacGamingUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3

	self:initUI()

	return
end

function PacGamingUI:initUI()
	self._gameUI = findTF(self._tf, "ui/gamingUI")
	self.btnBack = findTF(self._gameUI, "back")
	self.btnPause = findTF(self._gameUI, "pause")
	self.timeTF = findTF(self._gameUI, "top/ad/time")
	self.scoreTF = findTF(self._gameUI, "top/ad/score")

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

	self.direct = Vector2(0, 0)
	self.joyStick = MiniGameJoyStick.New(findTF(self._gameUI, "joyStick"))
	self.joyStick.minDeadNum = 0.25

	self.joyStick:setActiveCallback(function(arg_5_0)
		return
	end)
	setText(findTF(self._gameUI, "top/ad/time_desc"), i18n("pac_game_gaming_time_desc"))
	setText(findTF(self._gameUI, "top/ad/score_desc"), i18n("pac_game_gaming_score"))

	return
end

function PacGamingUI:Show(arg_6_1)
	setActive(self._gameUI, arg_6_1)

	return
end

function PacGamingUI:Update()
	return
end

function PacGamingUI:Start()
	self.subGameStepTime = 0

	self:Show(true)

	self._editorFlag = self._gameVo:GetEditor()

	local var_8_0 = getProxy(MiniGameProxy):GetHighScore(self._gameVo:GetGameId())

	if not var_8_0 or #var_8_0 <= 0 or not var_8_0[1] then
		-- block empty
	end

	setText(self.scoreTF, 0)

	if self._editorFlag then
		setActive(findTF(self._gameUI, "joyStick"), false)
		setActive(findTF(self._gameUI, "top"), false)
		setActive(findTF(self._gameUI, "bg_top"), false)
	end

	self._score = 0
	self._time = -1

	return
end

function PacGamingUI:Step()
	self.joyStick:step()
	self.joyStick:setDirectTarget(self.direct)
	self._gameVo:SetJoyStickData(self.joyStick:getValue())

	if self._time ~= self._gameVo:GetStepTimeInteger() then
		self._time = self._gameVo:GetStepTimeInteger()

		setText(self.timeTF, math.floor(self._time))
	end

	if self._score ~= self._gameVo:GetScore() then
		self._score = self._gameVo:GetScore()

		setText(self.scoreTF, self._score)
	end

	return
end

function PacGamingUI:SetChildVisible(arg_10_1, arg_10_2)
	for iter_10_0 = 1, arg_10_1.childCount do
		setActive(arg_10_1:GetChild(iter_10_0 - 1), arg_10_2)
	end

	return
end

function PacGamingUI:Press(arg_11_1, arg_11_2)
	if arg_11_1 == KeyCode.A then
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
	elseif arg_11_1 == KeyCode.W then
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
	end

	return
end

return PacGamingUI
