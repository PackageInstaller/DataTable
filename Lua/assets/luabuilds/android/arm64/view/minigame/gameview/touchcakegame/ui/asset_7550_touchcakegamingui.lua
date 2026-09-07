local TouchCakeGamingUI = class("TouchCakeGamingUI")
local var_0_1
local var_0_2
local var_0_3

function TouchCakeGamingUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	var_0_1 = TouchCakeGameVo
	var_0_2 = TouchCakeGameEvent
	var_0_3 = TouchCakeGameConst
	self._gameUI = findTF(self._tf, "ui/gamingUI")
	self.btnBack = findTF(self._gameUI, "back")
	self.btnPause = findTF(self._gameUI, "pause")
	self.gameTime = findTF(self._gameUI, "time")
	self.leftTf = findTF(self._gameUI, "left")
	self.rightTf = findTF(self._gameUI, "right")
	self.leftListener = GetComponent(self.leftTf, typeof(EventTriggerListener))
	self.rightListener = GetComponent(self.rightTf, typeof(EventTriggerListener))
	self.effectTf = findTF(self._gameUI, "effect")
	self.comboEffectData = var_0_3.combo_effect

	self.leftListener:AddPointDownFunc(function()
		self._event:emit(var_0_2.PRESS_DIRECT, -1)

		return
	end)
	self.rightListener:AddPointDownFunc(function()
		self._event:emit(var_0_2.PRESS_DIRECT, 1)

		return
	end)
	onButton(self._event, self.btnBack, function()
		if not var_0_1.startSettlement then
			self._event:emit(TouchCakeGameEvent.PAUSE_GAME, true)
			self._event:emit(TouchCakeGameEvent.OPEN_LEVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	onButton(self._event, self.btnPause, function()
		if not var_0_1.startSettlement then
			self._event:emit(TouchCakeGameEvent.PAUSE_GAME, true)
			self._event:emit(TouchCakeGameEvent.OPEN_PAUSE_UI)
		end

		return
	end, SFX_CONFIRM)

	self.scoreTf = findTF(self._gameUI, "score")
	self.comboTf = findTF(self._gameUI, "bgCombo/combo")

	return
end

function TouchCakeGamingUI:show(arg_6_1)
	setActive(self._gameUI, arg_6_1)

	return
end

function TouchCakeGamingUI:update()
	return
end

function TouchCakeGamingUI:start()
	self.subGameStepTime = 0

	self:updateScore()
	self:updateCombo()
	self:show(true)

	return
end

function TouchCakeGamingUI:updateScore()
	setText(self.scoreTf, var_0_1.scoreNum)

	return
end

function TouchCakeGamingUI:updateCombo()
	setText(self.comboTf, var_0_1.comboNum)
	GetComponent(self.comboTf, typeof(Animator)):SetTrigger("combo")

	local var_10_0

	for iter_10_0 = #self.comboEffectData, 1, -1 do
		if var_0_1.comboNum >= self.comboEffectData[iter_10_0][1] then
			var_10_0 = self.comboEffectData[iter_10_0][2]

			break
		end
	end

	self:setChildVisible(self.effectTf, false)

	if var_10_0 then
		setActive(findTF(self.effectTf, var_10_0), true)
	end

	return
end

function TouchCakeGamingUI:setChildVisible(arg_11_1, arg_11_2)
	for iter_11_0 = 1, arg_11_1.childCount do
		setActive(arg_11_1:GetChild(iter_11_0 - 1), arg_11_2)
	end

	return
end

function TouchCakeGamingUI:step(arg_12_1)
	local var_12_0 = math.ceil(var_0_1.gameTime)

	var_12_0 = var_12_0 <= 0 and 0 or var_12_0

	local var_12_1 = math.floor(var_12_0 / 60)
	local var_12_2 = math.floor(var_12_0 % 60)

	setText(self.gameTime, (var_12_1 < 10 and "0" .. tostring(var_12_1) or tostring(var_12_1)) .. " : " .. (var_12_2 < 10 and "0" .. tostring(var_12_2) or tostring(var_12_2)))

	if var_12_0 <= 0 then
		self:show(false)
	elseif var_0_1.startSettlement and isActive(self._gameUI) then
		self:show(false)
	end

	return
end

function TouchCakeGamingUI:dispose()
	ClearEventTrigger(self.leftListener)
	ClearEventTrigger(self.rightListener)

	return
end

function TouchCakeGamingUI:press(arg_14_1, arg_14_2)
	return
end

return TouchCakeGamingUI
