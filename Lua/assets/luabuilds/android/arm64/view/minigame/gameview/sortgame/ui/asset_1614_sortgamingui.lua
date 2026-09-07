local SortGamingUI = class("SortGamingUI")

function SortGamingUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3

	self:initUI()

	return
end

function SortGamingUI:initUI()
	self._gameUI = findTF(self._tf, "ui/gamingUI")
	self.btnBack = findTF(self._gameUI, "back")
	self.btnPause = findTF(self._gameUI, "pause")
	self.timeTF = findTF(self._gameUI, "time/ad/time")
	self.scoreTextTf = findTF(self._gameUI, "scoreText/ad/score")

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
	setText(findTF(self._gameUI, "time/ad/time_desc"), i18n("pac_game_gaming_time_desc"))
	setText(findTF(self._gameUI, "scoreText/ad/score_desc"), i18n("pac_game_gaming_score"))

	self._comboTF = findTF(self._gameUI, "combo")

	setActive(findTF(self._gameUI, "combo"), false)

	self._comboProgressSlider = GetComponent(findTF(self._gameUI, "combo/ad/progress"), typeof(Slider))
	self._wantedTF = findTF(self._gameUI, "wanted")
	self._wantedProgressSlider = GetComponent(findTF(self._gameUI, "wanted/ad/Slider"), typeof(Slider))
	self._wantedItemIcon = findTF(self._gameUI, "wanted/ad/Slider/icon")
	self._wantedPlayerIcon = findTF(self._gameUI, "wanted/ad/Icon/mask/icon")
	self._playerSpeakIcon = findTF(self._gameUI, "playerSpeak/ad/mask/icon")
	self._playerSpeakTF = findTF(self._gameUI, "playerSpeak")
	self._playerSpeakText = findTF(self._gameUI, "speak_panel/ad/chat/text")
	self._playerSpeakPanel = findTF(self._gameUI, "speak_panel")
	self._scoreTpl = findTF(self._gameUI, "score_tpl")

	setActive(self._scoreTpl, false)

	self._scoreContent = findTF(self._gameUI, "scoreContent")
	self._scoreTfPool = {}
	self._scoreTfTweenDic = {}
	self.comboEffectTf = {
		findTF(self._comboTF, "ad/vx_combo01"),
		findTF(self._comboTF, "ad/vx_combo02"),
		findTF(self._comboTF, "ad/vx_combo03")
	}

	for iter_2_0 = 1, #self.comboEffectTf do
		setActive(self.comboEffectTf[iter_2_0], false)
	end

	return
end

function SortGamingUI:CreateScoreTF(arg_5_1, arg_5_2)
	local var_5_0

	if #self._scoreTfPool > 0 then
		var_5_0 = table.remove(self._scoreTfPool, 1)

		setActive(var_5_0, true)
	else
		var_5_0 = tf(Instantiate(self._scoreTpl))

		setParent(var_5_0, self._scoreContent)
		setActive(var_5_0, true)
		GetComponent(findTF(var_5_0, "ad"), typeof(DftAniEvent)):SetEndEvent(function()
			setActive(var_5_0, false)

			return
		end)
	end

	table.insert(self._scoreTfTweenDic, {
		step = 0,
		finish = false,
		show = 0.3,
		tf = var_5_0,
		start = arg_5_2
	})

	var_5_0.position = arg_5_2

	local var_5_1 = math.floor(arg_5_1 / 1000)
	local var_5_2 = math.floor(arg_5_1 % 1000 / 100)
	local var_5_3 = math.floor(arg_5_1 % 100 / 10)
	local var_5_4 = math.floor(arg_5_1 % 10)

	self:SetScoreText(var_5_0, "thousand", arg_5_1 >= 1000 and var_5_1 or nil)
	self:SetScoreText(var_5_0, "hundred", arg_5_1 >= 100 and var_5_2 or nil)
	self:SetScoreText(var_5_0, "ten", arg_5_1 >= 10 and var_5_3 or nil)
	self:SetScoreText(var_5_0, "one", arg_5_1 >= 0 and var_5_4 or nil)

	return
end

function SortGamingUI:SetScoreText(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = findTF(arg_7_1, "ad/" .. arg_7_2)

	if not arg_7_3 then
		setActive(var_7_0, false)

		return
	end

	for iter_7_0 = 0, 9 do
		setActive(findTF(var_7_0, "num_" .. tostring(iter_7_0)), iter_7_0 == arg_7_3)
	end

	return
end

function SortGamingUI:Show(arg_8_1)
	setActive(self._gameUI, arg_8_1)

	return
end

function SortGamingUI:Update()
	return
end

function SortGamingUI:UpdatePlayer(arg_10_1)
	LoadSpriteAtlasAsync("qicon/" .. arg_10_1, nil, function(arg_11_0)
		setImageSprite(self._wantedPlayerIcon, arg_11_0, true)

		return
	end)
	LoadSpriteAtlasAsync("qicon/" .. arg_10_1, nil, function(arg_12_0)
		setImageSprite(self._playerSpeakIcon, arg_12_0, true)

		return
	end)

	return
end

function SortGamingUI:Start()
	self.subGameStepTime = 0

	self:Show(true)

	self._editorFlag = self._gameVo:GetEditor()

	local var_13_0 = getProxy(MiniGameProxy):GetHighScore(self._gameVo:GetGameId())

	if not var_13_0 or #var_13_0 <= 0 or not var_13_0[1] then
		-- block empty
	end

	setText(self.scoreTextTf, 0)

	self._score = 0
	self._time = -1
	self._comboIndex = 0

	setActive(self._wantedTF, false)

	self._playerSpeakTime = nil
	self._comboTime = nil
	self._wantedStepTime = nil

	setActive(self._comboTF, false)
	setActive(self._wantedTF, false)
	setActive(self._playerSpeakPanel, false)
	setActive(self._playerSpeakTF, false)

	return
end

function SortGamingUI:Step(arg_14_1)
	if self._time ~= self._gameVo:GetTimeInteger() then
		self._time = self._gameVo:GetTimeInteger()

		if self._time < 0 then
			self._time = 0
		end

		setText(self.timeTF, string.format("%02d : %02d", math.floor(self._time / 60), (math.floor(self._time % 60))))
	end

	if self._comboTime and self._comboTime >= 0 then
		self._comboTime = self._comboTime - arg_14_1

		if self._comboTime and self._comboTime <= 0 then
			self._comboTime = nil

			setActive(findTF(self._gameUI, "combo"), false)
		else
			self._comboProgressSlider.value = self._comboTime / SortGameConst.combo_time
		end
	end

	if self._wantedStepTime and self._wantedStepTime >= 0 then
		self._wantedStepTime = self._wantedStepTime - arg_14_1

		if self._wantedStepTime and self._wantedStepTime <= 0 then
			self._wantedStepTime = nil
		else
			self._wantedProgressSlider.value = self._wantedStepTime / SortGameConst.wanted_step_time
		end
	end

	if self._playerSpeakTime and self._playerSpeakTime >= 0 then
		self._playerSpeakTime = self._playerSpeakTime - arg_14_1

		if self._playerSpeakTime and self._playerSpeakTime <= 0 then
			self._playerSpeakTime = nil

			setActive(self._playerSpeakPanel, false)
			setActive(self._playerSpeakTF, false)
		end
	end

	self:StepScoreTween(arg_14_1)

	return
end

function SortGamingUI:StepScoreTween(arg_15_1)
	for iter_15_0 = #self._scoreTfTweenDic, 1, -1 do
		if self._scoreTfTweenDic[iter_15_0] and not self._scoreTfTweenDic[iter_15_0].finish then
			if self._scoreTfTweenDic[iter_15_0].show and self._scoreTfTweenDic[iter_15_0].show > 0 then
				self._scoreTfTweenDic[iter_15_0].show = self._scoreTfTweenDic[iter_15_0].show - arg_15_1

				if self._scoreTfTweenDic[iter_15_0].show <= 0 then
					self._scoreTfTweenDic[iter_15_0].show = nil
				end
			else
				local var_15_0, var_15_1, var_15_2, var_15_3 = self:GetSmoothOffset(self._scoreTfTweenDic[iter_15_0].start, self.scoreTextTf.position, arg_15_1, 0.75, self._scoreTfTweenDic[iter_15_0].state)

				if self._scoreTfTweenDic[iter_15_0].tf then
					self._scoreTfTweenDic[iter_15_0].tf.position = var_15_1
				end

				self._scoreTfTweenDic[iter_15_0].state = var_15_3

				if var_15_2 then
					self._scoreTfTweenDic[iter_15_0].finish = true

					if self._scoreTfTweenDic[iter_15_0].tf then
						GetComponent(findTF(self._scoreTfTweenDic[iter_15_0].tf, "ad"), typeof(Animator)):SetTrigger("hide")
						table.insert(self._scoreTfPool, self._scoreTfTweenDic[iter_15_0].tf)
						self:UpdateScore()
					end

					table.remove(self._scoreTfTweenDic, iter_15_0)
				end
			end
		end
	end

	return
end

function SortGamingUI:UpdateScore()
	if self._score ~= self._gameVo:GetScore() then
		self._score = self._gameVo:GetScore()

		setText(self.scoreTextTf, self._score)
	end

	return
end

function SortGamingUI:AddScore(arg_17_1)
	if arg_17_1 and arg_17_1.position and arg_17_1.num then
		self:CreateScoreTF(arg_17_1.num, arg_17_1.position)
	else
		self:UpdateScore()
	end

	if arg_17_1 and arg_17_1.combo then
		self:SetCombo(arg_17_1.combo)
	end

	return
end

function SortGamingUI:RefreshWantedItem(arg_18_1, arg_18_2)
	if arg_18_1 then
		setActive(self._wantedTF, true)
		GetSpriteFromAtlasAsync(SortGameConst.ui_atlas, "item_" .. arg_18_1, function(arg_19_0)
			if arg_19_0 then
				self._wantedStepTime = SortGameConst.wanted_step_time

				setImageSprite(self._wantedItemIcon, arg_19_0, true)
				setActive(self._wantedItemIcon, true)
			end

			return
		end)
		self:UpdatePlayer(arg_18_2)
	else
		setActive(self._wantedTF, false)
	end

	return
end

function SortGamingUI:SetCombo(arg_20_1)
	if arg_20_1 == 0 then
		setActive(findTF(self._gameUI, "combo"), false)

		return
	end

	self._comboIndex = arg_20_1

	for iter_20_0 = 1, #self.comboEffectTf do
		setActive(self.comboEffectTf[iter_20_0], false)
	end

	for iter_20_1 = #SortGameConst.combo_effect_count, 1, -1 do
		if arg_20_1 >= SortGameConst.combo_effect_count[iter_20_1] then
			setActive(self.comboEffectTf[iter_20_1], true)

			break
		end
	end

	self._comboTime = SortGameConst.combo_time

	setActive(findTF(self._gameUI, "combo"), false)
	setActive(findTF(self._gameUI, "combo"), true)
	setText(findTF(self._gameUI, "combo/ad/combo_img/combo_desc"), "X " .. arg_20_1)

	return
end

function SortGamingUI:SetPlayerSpeak(arg_21_1)
	if self._playerSpeakTime then
		return
	end

	if arg_21_1 and arg_21_1.text then
		setActive(self._playerSpeakPanel, true)
		setActive(self._playerSpeakTF, true)
		setText(self._playerSpeakText, arg_21_1.text)

		self._playerSpeakTime = arg_21_1.time

		local var_21_0 = arg_21_1.icon or nil

		if var_21_0 then
			self:UpdatePlayer(var_21_0)
		end
	else
		setActive(self._playerSpeakPanel, false)
		setActive(self._playerSpeakTF, false)
	end

	return
end

function SortGamingUI:StepTimeToScore()
	if self._timeToScoreTimer then
		return
	end

	local var_22_0 = SortGameConst.time_trans_score * self._gameVo:GetTimeInteger()
	local var_22_1 = 3
	local var_22_2 = self._gameVo:GetTimeInteger() / 3

	self._timeToScoreStep = 3 * SortGameConst.time_trans_score
	self._timeToScoreTimer = Timer.New(function()
		var_22_2 = var_22_2 - 1

		if var_22_2 <= 0 then
			if self._timeToScoreTimer then
				self._timeToScoreTimer:Stop()

				self._timeToScoreTimer = nil
			end

			self._event:emit(SimpleMGEvent.ADD_SCORE, {
				combo = 0,
				num = var_22_0
			})
			setText(self.timeTF, string.format("%02d : %02d", 0, 0))
			setText(self.scoreTextTf, self._gameVo:GetScore())
			self._event:emit(SimpleMGEvent.GAME_OVER)

			return
		end

		self._time = self._time - var_22_1

		setText(self.timeTF, string.format("%02d : %02d", math.floor(self._time / 60), (math.floor(self._time % 60))))

		self._score = self._score + self._timeToScoreStep

		setText(self.scoreTextTf, self._score)
		self:StepScoreTween(0.05)

		return
	end, 0.05, -1)

	self._timeToScoreTimer:Start()

	return
end

function SortGamingUI:SetChildVisible(arg_24_1, arg_24_2)
	for iter_24_0 = 1, arg_24_1.childCount do
		setActive(arg_24_1:GetChild(iter_24_0 - 1), arg_24_2)
	end

	return
end

function SortGamingUI:Press(arg_25_1, arg_25_2)
	return
end

function SortGamingUI:GameOver()
	for iter_26_0, iter_26_1 in pairs(self._scoreTfTweenDic) do
		if iter_26_1.tf then
			setActive(iter_26_1.tf, false)
			table.insert(self._scoreTfPool, iter_26_1.tf)
		end
	end

	self._scoreTfTweenDic = {}

	return
end

function SortGamingUI:Dispose()
	for iter_27_0 = 1, #self._scoreTfPool do
		GetComponent(findTF(self._scoreTfPool[iter_27_0], "ad"), typeof(DftAniEvent)):SetEndEvent(nil)
	end

	return
end

function SortGamingUI:GetSmoothOffset(arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	local function var_28_0(arg_29_0)
		local var_29_0 = {}

		var_29_0.x = arg_29_0.x or 0
		var_29_0.y = arg_29_0.y or 0
		var_29_0.z = arg_29_0.z

		return var_29_0
	end

	if not arg_28_1 or not arg_28_2 then
		return {
			z = 0,
			x = 0,
			y = 0
		}, nil, true, arg_28_5
	end

	local var_28_1 = math.max(arg_28_4 or 0, 0.0001)

	arg_28_5 = arg_28_5 or {
		elapsed = 0,
		currentPos = var_28_0(arg_28_1)
	}

	local var_28_2 = arg_28_1.x or 0
	local var_28_3 = arg_28_1.y or 0
	local var_28_4 = arg_28_1.z
	local var_28_5 = arg_28_2.x or 0
	local var_28_6 = arg_28_2.y or 0
	local var_28_7 = arg_28_2.z

	arg_28_5.elapsed = math.min(arg_28_5.elapsed + (arg_28_3 or 0), var_28_1)

	local var_28_8 = 0.5 - 0.5 * math.cos(math.pi * (arg_28_5.elapsed / var_28_1))
	local var_28_9 = {
		x = var_28_2 + (var_28_5 - var_28_2) * var_28_8,
		y = var_28_3 + (var_28_6 - var_28_3) * var_28_8
	}

	if var_28_4 ~= nil or var_28_7 ~= nil then
		var_28_9.z = (var_28_4 or 0) + ((var_28_7 or 0) - (var_28_4 or 0)) * var_28_8
	end

	local var_28_10 = {}

	var_28_10.x = var_28_9.x - (arg_28_5.currentPos.x or 0)
	var_28_10.y = var_28_9.y - (arg_28_5.currentPos.y or 0)

	if var_28_9.z ~= nil then
		var_28_10.z = var_28_9.z - (arg_28_5.currentPos.z or 0)
	end

	arg_28_5.currentPos = var_28_9

	if var_28_1 <= arg_28_5.elapsed then
		var_28_10.x = var_28_5 - (arg_28_5.currentPos.x - var_28_10.x)
		var_28_10.y = var_28_6 - (arg_28_5.currentPos.y - var_28_10.y)
		arg_28_5.currentPos.x = var_28_5
		arg_28_5.currentPos.y = var_28_6

		if var_28_9.z ~= nil then
			local var_28_12 = var_28_7 or 0

			var_28_10.z = var_28_12 - ((arg_28_5.currentPos.z or 0) - (var_28_10.z or 0))
			arg_28_5.currentPos.z = var_28_12
		end
	end

	return var_28_10, var_28_0(arg_28_5.currentPos), var_28_1 <= arg_28_5.elapsed, arg_28_5
end

return SortGamingUI
