local var_0_0 = class("SortGamingUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	arg_1_0:initUI()

	return
end

function var_0_0.initUI(arg_2_0)
	arg_2_0._gameUI = findTF(arg_2_0._tf, "ui/gamingUI")
	arg_2_0.btnBack = findTF(arg_2_0._gameUI, "back")
	arg_2_0.btnPause = findTF(arg_2_0._gameUI, "pause")
	arg_2_0.timeTF = findTF(arg_2_0._gameUI, "time/ad/time")
	arg_2_0.scoreTextTf = findTF(arg_2_0._gameUI, "scoreText/ad/score")

	onButton(arg_2_0._event, arg_2_0.btnBack, function()
		if not arg_2_0._gameVo.startSettlement then
			arg_2_0._event:emit(SimpleMGEvent.PAUSE_GAME, true)
			arg_2_0._event:emit(SimpleMGEvent.OPEN_LEVEL_UI)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_2_0._event, arg_2_0.btnPause, function()
		if not arg_2_0._gameVo.startSettlement then
			arg_2_0._event:emit(SimpleMGEvent.PAUSE_GAME, true)
			arg_2_0._event:emit(SimpleMGEvent.OPEN_PAUSE_UI)
		end

		return
	end, SFX_CONFIRM)
	setText(findTF(arg_2_0._gameUI, "time/ad/time_desc"), i18n("pac_game_gaming_time_desc"))
	setText(findTF(arg_2_0._gameUI, "scoreText/ad/score_desc"), i18n("pac_game_gaming_score"))

	arg_2_0._comboTF = findTF(arg_2_0._gameUI, "combo")

	setActive(findTF(arg_2_0._gameUI, "combo"), false)

	arg_2_0._comboProgressSlider = GetComponent(findTF(arg_2_0._gameUI, "combo/ad/progress"), typeof(Slider))
	arg_2_0._wantedTF = findTF(arg_2_0._gameUI, "wanted")
	arg_2_0._wantedProgressSlider = GetComponent(findTF(arg_2_0._gameUI, "wanted/ad/Slider"), typeof(Slider))
	arg_2_0._wantedItemIcon = findTF(arg_2_0._gameUI, "wanted/ad/Slider/icon")
	arg_2_0._wantedPlayerIcon = findTF(arg_2_0._gameUI, "wanted/ad/Icon/mask/icon")
	arg_2_0._playerSpeakIcon = findTF(arg_2_0._gameUI, "playerSpeak/ad/mask/icon")
	arg_2_0._playerSpeakTF = findTF(arg_2_0._gameUI, "playerSpeak")
	arg_2_0._playerSpeakText = findTF(arg_2_0._gameUI, "speak_panel/ad/chat/text")
	arg_2_0._playerSpeakPanel = findTF(arg_2_0._gameUI, "speak_panel")
	arg_2_0._scoreTpl = findTF(arg_2_0._gameUI, "score_tpl")

	setActive(arg_2_0._scoreTpl, false)

	arg_2_0._scoreContent = findTF(arg_2_0._gameUI, "scoreContent")
	arg_2_0._scoreTfPool = {}
	arg_2_0._scoreTfTweenDic = {}
	arg_2_0.comboEffectTf = {
		findTF(arg_2_0._comboTF, "ad/vx_combo01"),
		findTF(arg_2_0._comboTF, "ad/vx_combo02"),
		findTF(arg_2_0._comboTF, "ad/vx_combo03")
	}

	for iter_2_0 = 1, #arg_2_0.comboEffectTf do
		setActive(arg_2_0.comboEffectTf[iter_2_0], false)
	end

	return
end

function var_0_0.CreateScoreTF(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0

	if #arg_5_0._scoreTfPool > 0 then
		var_5_0 = table.remove(arg_5_0._scoreTfPool, 1)

		setActive(var_5_0, true)
	else
		var_5_0 = tf(Instantiate(arg_5_0._scoreTpl))

		setParent(var_5_0, arg_5_0._scoreContent)
		setActive(var_5_0, true)
		GetComponent(findTF(var_5_0, "ad"), typeof(DftAniEvent)):SetEndEvent(function()
			setActive(var_5_0, false)

			return
		end)
	end

	table.insert(arg_5_0._scoreTfTweenDic, {
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

	arg_5_0:SetScoreText(var_5_0, "thousand", arg_5_1 >= 1000 and var_5_1 or nil)
	arg_5_0:SetScoreText(var_5_0, "hundred", arg_5_1 >= 100 and var_5_2 or nil)
	arg_5_0:SetScoreText(var_5_0, "ten", arg_5_1 >= 10 and var_5_3 or nil)
	arg_5_0:SetScoreText(var_5_0, "one", arg_5_1 >= 0 and var_5_4 or nil)

	return
end

function var_0_0.SetScoreText(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
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

function var_0_0.Show(arg_8_0, arg_8_1)
	setActive(arg_8_0._gameUI, arg_8_1)

	return
end

function var_0_0.Update(arg_9_0)
	return
end

function var_0_0.UpdatePlayer(arg_10_0, arg_10_1)
	LoadSpriteAtlasAsync("qicon/" .. arg_10_1, nil, function(arg_11_0)
		setImageSprite(arg_10_0._wantedPlayerIcon, arg_11_0, true)

		return
	end)
	LoadSpriteAtlasAsync("qicon/" .. arg_10_1, nil, function(arg_12_0)
		setImageSprite(arg_10_0._playerSpeakIcon, arg_12_0, true)

		return
	end)

	return
end

function var_0_0.Start(arg_13_0)
	arg_13_0.subGameStepTime = 0

	arg_13_0:Show(true)

	arg_13_0._editorFlag = arg_13_0._gameVo:GetEditor()

	local var_13_0 = getProxy(MiniGameProxy):GetHighScore(arg_13_0._gameVo:GetGameId())

	if not var_13_0 or #var_13_0 <= 0 or not var_13_0[1] then
		-- block empty
	end

	setText(arg_13_0.scoreTextTf, 0)

	arg_13_0._score = 0
	arg_13_0._time = -1
	arg_13_0._comboIndex = 0

	setActive(arg_13_0._wantedTF, false)

	arg_13_0._playerSpeakTime = nil
	arg_13_0._comboTime = nil
	arg_13_0._wantedStepTime = nil

	setActive(arg_13_0._comboTF, false)
	setActive(arg_13_0._wantedTF, false)
	setActive(arg_13_0._playerSpeakPanel, false)
	setActive(arg_13_0._playerSpeakTF, false)

	return
end

function var_0_0.Step(arg_14_0, arg_14_1)
	if arg_14_0._time ~= arg_14_0._gameVo:GetTimeInteger() then
		arg_14_0._time = arg_14_0._gameVo:GetTimeInteger()

		if arg_14_0._time < 0 then
			arg_14_0._time = 0
		end

		setText(arg_14_0.timeTF, string.format("%02d : %02d", math.floor(arg_14_0._time / 60), (math.floor(arg_14_0._time % 60))))
	end

	if arg_14_0._comboTime and arg_14_0._comboTime >= 0 then
		arg_14_0._comboTime = arg_14_0._comboTime - arg_14_1

		if arg_14_0._comboTime and arg_14_0._comboTime <= 0 then
			arg_14_0._comboTime = nil

			setActive(findTF(arg_14_0._gameUI, "combo"), false)
		else
			arg_14_0._comboProgressSlider.value = arg_14_0._comboTime / SortGameConst.combo_time
		end
	end

	if arg_14_0._wantedStepTime and arg_14_0._wantedStepTime >= 0 then
		arg_14_0._wantedStepTime = arg_14_0._wantedStepTime - arg_14_1

		if arg_14_0._wantedStepTime and arg_14_0._wantedStepTime <= 0 then
			arg_14_0._wantedStepTime = nil
		else
			arg_14_0._wantedProgressSlider.value = arg_14_0._wantedStepTime / SortGameConst.wanted_step_time
		end
	end

	if arg_14_0._playerSpeakTime and arg_14_0._playerSpeakTime >= 0 then
		arg_14_0._playerSpeakTime = arg_14_0._playerSpeakTime - arg_14_1

		if arg_14_0._playerSpeakTime and arg_14_0._playerSpeakTime <= 0 then
			arg_14_0._playerSpeakTime = nil

			setActive(arg_14_0._playerSpeakPanel, false)
			setActive(arg_14_0._playerSpeakTF, false)
		end
	end

	arg_14_0:StepScoreTween(arg_14_1)

	return
end

function var_0_0.StepScoreTween(arg_15_0, arg_15_1)
	for iter_15_0 = #arg_15_0._scoreTfTweenDic, 1, -1 do
		if arg_15_0._scoreTfTweenDic[iter_15_0] and not arg_15_0._scoreTfTweenDic[iter_15_0].finish then
			if arg_15_0._scoreTfTweenDic[iter_15_0].show and arg_15_0._scoreTfTweenDic[iter_15_0].show > 0 then
				arg_15_0._scoreTfTweenDic[iter_15_0].show = arg_15_0._scoreTfTweenDic[iter_15_0].show - arg_15_1

				if arg_15_0._scoreTfTweenDic[iter_15_0].show <= 0 then
					arg_15_0._scoreTfTweenDic[iter_15_0].show = nil
				end
			else
				local var_15_0, var_15_1, var_15_2, var_15_3 = arg_15_0:GetSmoothOffset(arg_15_0._scoreTfTweenDic[iter_15_0].start, arg_15_0.scoreTextTf.position, arg_15_1, 0.75, arg_15_0._scoreTfTweenDic[iter_15_0].state)

				if arg_15_0._scoreTfTweenDic[iter_15_0].tf then
					arg_15_0._scoreTfTweenDic[iter_15_0].tf.position = var_15_1
				end

				arg_15_0._scoreTfTweenDic[iter_15_0].state = var_15_3

				if var_15_2 then
					arg_15_0._scoreTfTweenDic[iter_15_0].finish = true

					if arg_15_0._scoreTfTweenDic[iter_15_0].tf then
						GetComponent(findTF(arg_15_0._scoreTfTweenDic[iter_15_0].tf, "ad"), typeof(Animator)):SetTrigger("hide")
						table.insert(arg_15_0._scoreTfPool, arg_15_0._scoreTfTweenDic[iter_15_0].tf)
						arg_15_0:UpdateScore()
					end

					table.remove(arg_15_0._scoreTfTweenDic, iter_15_0)
				end
			end
		end
	end

	return
end

function var_0_0.UpdateScore(arg_16_0)
	if arg_16_0._score ~= arg_16_0._gameVo:GetScore() then
		arg_16_0._score = arg_16_0._gameVo:GetScore()

		setText(arg_16_0.scoreTextTf, arg_16_0._score)
	end

	return
end

function var_0_0.AddScore(arg_17_0, arg_17_1)
	if arg_17_1 and arg_17_1.position and arg_17_1.num then
		arg_17_0:CreateScoreTF(arg_17_1.num, arg_17_1.position)
	else
		arg_17_0:UpdateScore()
	end

	if arg_17_1 and arg_17_1.combo then
		arg_17_0:SetCombo(arg_17_1.combo)
	end

	return
end

function var_0_0.RefreshWantedItem(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 then
		setActive(arg_18_0._wantedTF, true)
		GetSpriteFromAtlasAsync(SortGameConst.ui_atlas, "item_" .. arg_18_1, function(arg_19_0)
			if arg_19_0 then
				arg_18_0._wantedStepTime = SortGameConst.wanted_step_time

				setImageSprite(arg_18_0._wantedItemIcon, arg_19_0, true)
				setActive(arg_18_0._wantedItemIcon, true)
			end

			return
		end)
		arg_18_0:UpdatePlayer(arg_18_2)
	else
		setActive(arg_18_0._wantedTF, false)
	end

	return
end

function var_0_0.SetCombo(arg_20_0, arg_20_1)
	if arg_20_1 == 0 then
		setActive(findTF(arg_20_0._gameUI, "combo"), false)

		return
	end

	arg_20_0._comboIndex = arg_20_1

	for iter_20_0 = 1, #arg_20_0.comboEffectTf do
		setActive(arg_20_0.comboEffectTf[iter_20_0], false)
	end

	for iter_20_1 = #SortGameConst.combo_effect_count, 1, -1 do
		if arg_20_1 >= SortGameConst.combo_effect_count[iter_20_1] then
			setActive(arg_20_0.comboEffectTf[iter_20_1], true)

			break
		end
	end

	arg_20_0._comboTime = SortGameConst.combo_time

	setActive(findTF(arg_20_0._gameUI, "combo"), false)
	setActive(findTF(arg_20_0._gameUI, "combo"), true)
	setText(findTF(arg_20_0._gameUI, "combo/ad/combo_img/combo_desc"), "X " .. arg_20_1)

	return
end

function var_0_0.SetPlayerSpeak(arg_21_0, arg_21_1)
	if arg_21_0._playerSpeakTime then
		return
	end

	if arg_21_1 and arg_21_1.text then
		setActive(arg_21_0._playerSpeakPanel, true)
		setActive(arg_21_0._playerSpeakTF, true)
		setText(arg_21_0._playerSpeakText, arg_21_1.text)

		arg_21_0._playerSpeakTime = arg_21_1.time

		local var_21_0 = arg_21_1.icon or nil

		if var_21_0 then
			arg_21_0:UpdatePlayer(var_21_0)
		end
	else
		setActive(arg_21_0._playerSpeakPanel, false)
		setActive(arg_21_0._playerSpeakTF, false)
	end

	return
end

function var_0_0.StepTimeToScore(arg_22_0)
	if arg_22_0._timeToScoreTimer then
		return
	end

	local var_22_0 = SortGameConst.time_trans_score * arg_22_0._gameVo:GetTimeInteger()
	local var_22_1 = 3
	local var_22_2 = arg_22_0._gameVo:GetTimeInteger() / 3

	arg_22_0._timeToScoreStep = 3 * SortGameConst.time_trans_score
	arg_22_0._timeToScoreTimer = Timer.New(function()
		var_22_2 = var_22_2 - 1

		if var_22_2 <= 0 then
			if arg_22_0._timeToScoreTimer then
				arg_22_0._timeToScoreTimer:Stop()

				arg_22_0._timeToScoreTimer = nil
			end

			arg_22_0._event:emit(SimpleMGEvent.ADD_SCORE, {
				combo = 0,
				num = var_22_0
			})
			setText(arg_22_0.timeTF, string.format("%02d : %02d", 0, 0))
			setText(arg_22_0.scoreTextTf, arg_22_0._gameVo:GetScore())
			arg_22_0._event:emit(SimpleMGEvent.GAME_OVER)

			return
		end

		arg_22_0._time = arg_22_0._time - var_22_1

		setText(arg_22_0.timeTF, string.format("%02d : %02d", math.floor(arg_22_0._time / 60), (math.floor(arg_22_0._time % 60))))

		arg_22_0._score = arg_22_0._score + arg_22_0._timeToScoreStep

		setText(arg_22_0.scoreTextTf, arg_22_0._score)
		arg_22_0:StepScoreTween(0.05)

		return
	end, 0.05, -1)

	arg_22_0._timeToScoreTimer:Start()

	return
end

function var_0_0.SetChildVisible(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0 = 1, arg_24_1.childCount do
		setActive(arg_24_1:GetChild(iter_24_0 - 1), arg_24_2)
	end

	return
end

function var_0_0.Press(arg_25_0, arg_25_1, arg_25_2)
	return
end

function var_0_0.GameOver(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0._scoreTfTweenDic) do
		if iter_26_1.tf then
			setActive(iter_26_1.tf, false)
			table.insert(arg_26_0._scoreTfPool, iter_26_1.tf)
		end
	end

	arg_26_0._scoreTfTweenDic = {}

	return
end

function var_0_0.Dispose(arg_27_0)
	for iter_27_0 = 1, #arg_27_0._scoreTfPool do
		GetComponent(findTF(arg_27_0._scoreTfPool[iter_27_0], "ad"), typeof(DftAniEvent)):SetEndEvent(nil)
	end

	return
end

function var_0_0.GetSmoothOffset(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	if not arg_28_1 or not arg_28_2 then
		return {
			z = 0,
			x = 0,
			y = 0
		}, nil, true, arg_28_5
	end

	local var_28_0 = math.max(arg_28_4 or 0, 0.0001)

	arg_28_5 = arg_28_5 or {
		elapsed = 0,
		currentPos = (function(arg_29_0)
			({}).x = arg_29_0.x or 0
			;({}).y = arg_29_0.y or 0
			;({}).z = arg_29_0.z

			return {}
		end)(arg_28_1)
	}

	local var_28_1 = arg_28_1.x or 0
	local var_28_2 = arg_28_1.y or 0
	local var_28_3 = arg_28_1.z
	local var_28_4 = arg_28_2.x or 0
	local var_28_5 = arg_28_2.y or 0
	local var_28_6 = arg_28_2.z

	arg_28_5.elapsed = math.min(arg_28_5.elapsed + (arg_28_3 or 0), var_28_0)

	local var_28_7 = 0.5 - 0.5 * math.cos(math.pi * (arg_28_5.elapsed / var_28_0))
	local var_28_8 = {
		x = var_28_1 + (var_28_4 - var_28_1) * var_28_7,
		y = var_28_2 + (var_28_5 - var_28_2) * var_28_7
	}

	if var_28_3 ~= nil or var_28_6 ~= nil then
		var_28_8.z = (var_28_3 or 0) + ((var_28_6 or 0) - (var_28_3 or 0)) * var_28_7
	end

	local var_28_9 = {}
	local var_28_10 = arg_28_5.currentPos.x or 0

	var_28_9.x = var_28_8.x - var_28_10

	local var_28_11 = arg_28_5.currentPos.y or 0

	var_28_9.y = var_28_8.y - var_28_11

	if var_28_8.z ~= nil then
		local var_28_12 = arg_28_5.currentPos.z or 0

		var_28_9.z = var_28_8.z - var_28_12
	end

	arg_28_5.currentPos = var_28_8

	local var_28_13 = var_28_0 <= arg_28_5.elapsed

	if var_28_0 <= arg_28_5.elapsed then
		var_28_9.x = var_28_4 - (arg_28_5.currentPos.x - var_28_9.x)
		var_28_9.y = var_28_5 - (arg_28_5.currentPos.y - var_28_9.y)
		arg_28_5.currentPos.x = var_28_4
		arg_28_5.currentPos.y = var_28_5

		if var_28_8.z ~= nil then
			local var_28_14 = var_28_6 or 0
			local var_28_15 = arg_28_5.currentPos.z or 0
			local var_28_16 = var_28_9.z or 0

			var_28_9.z = var_28_14 - (var_28_15 - var_28_16)
			arg_28_5.currentPos.z = var_28_14
		end
	end

	return var_28_9, (function(arg_29_0)
		({}).x = arg_29_0.x or 0
		;({}).y = arg_29_0.y or 0
		;({}).z = arg_29_0.z

		return {}
	end)(arg_28_5.currentPos), var_28_13, arg_28_5
end

return var_0_0
