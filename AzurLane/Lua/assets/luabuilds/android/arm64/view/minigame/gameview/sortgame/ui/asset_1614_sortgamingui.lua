class = var_0_10000

local var_0_0 = var_0_10000("SortGamingUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	arg_1_0:initUI()

	return
end

function var_0_0.initUI(arg_2_0)
	findTF = var_1_10001
	arg_2_0._gameUI = var_1_10001(arg_2_0._tf, "ui/gamingUI")
	findTF = var_1
	arg_2_0.btnBack = var_1(arg_2_0._gameUI, "back")
	findTF = var_1
	arg_2_0.btnPause = var_1(arg_2_0._gameUI, "pause")
	findTF = var_1
	arg_2_0.timeTF = var_1(arg_2_0._gameUI, "time/ad/time")
	findTF = var_1
	arg_2_0.scoreTextTf = var_1(arg_2_0._gameUI, "scoreText/ad/score")
	onButton = var_1

	local var_2_0 = arg_2_0._event
	local var_2_1 = arg_2_0.btnBack

	local function var_2_2()
		if not arg_2_0._gameVo.startSettlement then
			local var_3_0 = arg_2_0._event
			local var_3_1 = var_0.emit

			SimpleMGEvent = var_2_10003

			var_3_1(var_3_0, var_2_10003.PAUSE_GAME, true)

			local var_3_2 = arg_2_0._event
			local var_3_3 = var_0.emit

			SimpleMGEvent = var_3

			var_3_3(var_3_2, var_3.OPEN_LEVEL_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_2_0, var_2_1, var_2_2, var_1_10006)

	onButton = var_1

	local var_2_3 = arg_2_0._event
	local var_2_4 = arg_2_0.btnPause

	local function var_2_5()
		if not arg_2_0._gameVo.startSettlement then
			local var_4_0 = arg_2_0._event
			local var_4_1 = var_0.emit

			SimpleMGEvent = var_2_10003

			var_4_1(var_4_0, var_2_10003.PAUSE_GAME, true)

			local var_4_2 = arg_2_0._event
			local var_4_3 = var_0.emit

			SimpleMGEvent = var_3

			var_4_3(var_4_2, var_3.OPEN_PAUSE_UI)
		end

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_2_3, var_2_4, var_2_5, var_1_10006)

	setText = var_1
	findTF = var_2_3

	local var_2_6 = var_2_3(arg_2_0._gameUI, "time/ad/time_desc")

	i18n = var_2_4

	var_1(var_2_6, var_2_4("pac_game_gaming_time_desc"))

	setText = var_1
	findTF = var_2_6

	local var_2_7 = var_2_6(arg_2_0._gameUI, "scoreText/ad/score_desc")

	i18n = var_4

	var_1(var_2_7, var_4("pac_game_gaming_score"))

	findTF = var_1
	arg_2_0._comboTF = var_1(arg_2_0._gameUI, "combo")
	setActive = var_1
	findTF = var_3

	var_1(var_3(arg_2_0._gameUI, "combo"), false)

	GetComponent = var_1
	findTF = var_3

	local var_2_8 = var_3(arg_2_0._gameUI, "combo/ad/progress")

	typeof = var_4
	Slider = var_6
	arg_2_0._comboProgressSlider = var_1(var_2_8, var_4(var_6))
	findTF = var_1
	arg_2_0._wantedTF = var_1(arg_2_0._gameUI, "wanted")
	GetComponent = var_1
	findTF = var_3

	local var_2_9 = var_3(arg_2_0._gameUI, "wanted/ad/Slider")

	typeof = var_4
	Slider = var_6
	arg_2_0._wantedProgressSlider = var_1(var_2_9, var_4(var_6))
	findTF = var_1
	arg_2_0._wantedItemIcon = var_1(arg_2_0._gameUI, "wanted/ad/Slider/icon")
	findTF = var_1
	arg_2_0._wantedPlayerIcon = var_1(arg_2_0._gameUI, "wanted/ad/Icon/mask/icon")
	findTF = var_1
	arg_2_0._playerSpeakIcon = var_1(arg_2_0._gameUI, "playerSpeak/ad/mask/icon")
	findTF = var_1
	arg_2_0._playerSpeakTF = var_1(arg_2_0._gameUI, "playerSpeak")
	findTF = var_1
	arg_2_0._playerSpeakText = var_1(arg_2_0._gameUI, "speak_panel/ad/chat/text")
	findTF = var_1
	arg_2_0._playerSpeakPanel = var_1(arg_2_0._gameUI, "speak_panel")
	findTF = var_1
	arg_2_0._scoreTpl = var_1(arg_2_0._gameUI, "score_tpl")
	setActive = var_1

	var_1(arg_2_0._scoreTpl, false)

	findTF = var_1
	arg_2_0._scoreContent = var_1(arg_2_0._gameUI, "scoreContent")
	arg_2_0._scoreTfPool = {}
	arg_2_0._scoreTfTweenDic = {}

	local var_2_10 = {}

	findTF = var_1_10002
	var_2_10[1] = var_1_10002(arg_2_0._comboTF, "ad/vx_combo01")
	findTF = var_2
	var_2_10[2] = var_2(arg_2_0._comboTF, "ad/vx_combo02")
	findTF = var_2
	var_2_10[3] = var_2(arg_2_0._comboTF, "ad/vx_combo03")
	arg_2_0.comboEffectTf = var_2_10

	for iter_2_0 = 1, #arg_2_0.comboEffectTf do
		setActive = var_5

		var_5(arg_2_0.comboEffectTf[iter_2_0], false)
	end

	return
end

function var_0_0.CreateScoreTF(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0
	local var_5_1 = #arg_5_0._scoreTfPool

	if 0 < var_5_1 then
		table = var_5_1
		var_5_0 = var_5_1.remove(arg_5_0._scoreTfPool, 1)
		setActive = var_5_1

		var_5_1(var_5_0, true)
	else
		tf = var_5_1
		Instantiate = var_1_10006
		var_5_0 = var_5_1(var_1_10006(arg_5_0._scoreTpl))
		GetComponent = var_5_1
		findTF = var_6

		local var_5_2 = var_6(var_5_0, "ad")

		typeof = var_1_10007
		DftAniEvent = var_9
		var_5_1 = var_5_1(var_5_2, var_1_10007(var_9))
		setParent = var_5

		var_5(var_5_0, arg_5_0._scoreContent)

		setActive = var_5

		var_5(var_5_0, true)
		var_5_1:SetEndEvent(function()
			setActive = var_2_10000

			var_2_10000(var_5_0, false)

			return
		end)
	end

	table = var_5_1

	var_5_1.insert(arg_5_0._scoreTfTweenDic, {
		step = 0,
		finish = false,
		show = 0.3,
		tf = var_5_0,
		start = arg_5_2
	})

	var_5_0.position = arg_5_2
	math = var_4

	local var_5_3 = var_4.floor(arg_5_1 / 1000)

	math = var_5

	local var_5_4 = var_5.floor(arg_5_1 % 1000 / 100)

	math = var_6

	local var_5_5 = var_6.floor(arg_5_1 % 100 / 10)

	math = var_7

	local var_5_6 = var_7.floor(arg_5_1 % 10)

	arg_5_0:SetScoreText(var_5_0, "thousand", arg_5_1 >= 1000 and var_5_3 or nil)
	arg_5_0:SetScoreText(var_5_0, "hundred", arg_5_1 >= 100 and var_5_4 or nil)
	arg_5_0:SetScoreText(var_5_0, "ten", arg_5_1 >= 10 and var_5_5 or nil)
	arg_5_0:SetScoreText(var_5_0, "one", arg_5_1 >= 0 and var_5_6 or nil)

	return
end

function var_0_0.SetScoreText(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	findTF = var_1_10004

	local var_7_0 = var_1_10004(arg_7_1, "ad/" .. arg_7_2)

	if not arg_7_3 then
		setActive = var_1_10005

		var_1_10005(var_7_0, false)

		return
	end

	for iter_7_0 = 0, 9 do
		setActive = var_1_10009
		findTF = var_1_10011

		local var_7_1 = var_7_0
		local var_7_2 = "num_"

		tostring = var_1_10015

		var_1_10009(var_1_10011(var_7_1, var_7_2 .. var_1_10015(iter_7_0)), iter_7_0 == arg_7_3)
	end

	return
end

function var_0_0.Show(arg_8_0, arg_8_1)
	setActive = var_1_10002

	var_1_10002(arg_8_0._gameUI, arg_8_1)

	return
end

function var_0_0.Update(arg_9_0)
	return
end

function var_0_0.UpdatePlayer(arg_10_0, arg_10_1)
	LoadSpriteAtlasAsync = var_1_10002

	var_1_10002("qicon/" .. arg_10_1, nil, function(arg_11_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_10_0._wantedPlayerIcon, arg_11_0, true)

		return
	end)

	LoadSpriteAtlasAsync = var_1_10002

	var_1_10002("qicon/" .. arg_10_1, nil, function(arg_12_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_10_0._playerSpeakIcon, arg_12_0, true)

		return
	end)

	return
end

function var_0_0.Start(arg_13_0)
	arg_13_0.subGameStepTime = 0

	arg_13_0:Show(true)

	local var_13_0 = arg_13_0._gameVo

	arg_13_0._editorFlag = var_1.GetEditor(var_13_0)
	getProxy = var_1
	MiniGameProxy = var_13_0

	local var_13_1 = var_1(var_13_0)
	local var_13_2 = var_1.GetHighScore
	local var_13_3 = arg_13_0._gameVo

	if var_13_2(var_13_1, var_4.GetGameId(var_13_3)) then
		local var_13_4 = #var_1

		if not (0 < var_13_4) or not var_1[1] then
			local var_13_5 = 0
		end

		setText = var_13_1

		var_13_1(arg_13_0.scoreTextTf, 0)

		arg_13_0._score = 0
		arg_13_0._time = -1
		arg_13_0._comboIndex = 0
		setActive = var_3

		var_3(arg_13_0._wantedTF, false)

		arg_13_0._playerSpeakTime = nil
		arg_13_0._comboTime = nil
		arg_13_0._wantedStepTime = nil
		setActive = var_3

		var_3(arg_13_0._comboTF, false)

		setActive = var_3

		var_3(arg_13_0._wantedTF, false)

		setActive = var_3

		var_3(arg_13_0._playerSpeakPanel, false)

		setActive = var_3

		var_3(arg_13_0._playerSpeakTF, false)

		return
	end
end

function var_0_0.Step(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._time
	local var_14_1 = arg_14_0._gameVo

	if var_14_0 ~= var_3.GetTimeInteger(var_14_1) then
		var_1_10004 = arg_14_0._gameVo
		arg_14_0._time = var_2.GetTimeInteger(var_1_10004)

		if arg_14_0._time < 0 then
			arg_14_0._time = 0
		end

		math = var_2

		local var_14_2 = var_2.floor(arg_14_0._time / 60)

		math = var_3

		local var_14_3 = var_3.floor(arg_14_0._time % 60)

		setText = var_1_10004

		local var_14_4 = arg_14_0.timeTF

		string = var_1_10007

		var_1_10004(var_14_4, var_1_10007.format("%02d : %02d", var_14_2, var_14_3))
	end

	if arg_14_0._comboTime and arg_14_0._comboTime >= 0 then
		arg_14_0._comboTime = arg_14_0._comboTime - arg_14_1

		if arg_14_0._comboTime and arg_14_0._comboTime <= 0 then
			arg_14_0._comboTime = nil
			setActive = var_2
			findTF = var_1_10004

			var_2(var_1_10004(arg_14_0._gameUI, "combo"), false)
		else
			local var_14_5 = arg_14_0._comboProgressSlider
			local var_14_6 = arg_14_0._comboTime

			SortGameConst = var_1_10004
			var_14_5.value = var_14_6 / var_1_10004.combo_time
		end
	end

	if arg_14_0._wantedStepTime and arg_14_0._wantedStepTime >= 0 then
		arg_14_0._wantedStepTime = arg_14_0._wantedStepTime - arg_14_1

		if arg_14_0._wantedStepTime and arg_14_0._wantedStepTime <= 0 then
			arg_14_0._wantedStepTime = nil
		else
			local var_14_7 = arg_14_0._wantedProgressSlider
			local var_14_8 = arg_14_0._wantedStepTime

			SortGameConst = var_1_10004
			var_14_7.value = var_14_8 / var_1_10004.wanted_step_time
		end
	end

	if arg_14_0._playerSpeakTime and arg_14_0._playerSpeakTime >= 0 then
		arg_14_0._playerSpeakTime = arg_14_0._playerSpeakTime - arg_14_1

		if arg_14_0._playerSpeakTime and arg_14_0._playerSpeakTime <= 0 then
			arg_14_0._playerSpeakTime = nil
			setActive = var_2

			var_2(arg_14_0._playerSpeakPanel, false)

			setActive = var_2

			var_2(arg_14_0._playerSpeakTF, false)
		end
	end

	arg_14_0:StepScoreTween(arg_14_1)

	return
end

function var_0_0.StepScoreTween(arg_15_0, arg_15_1)
	for iter_15_0 = #arg_15_0._scoreTfTweenDic, 1, -1 do
		if arg_15_0._scoreTfTweenDic[iter_15_0] and not var_6.finish then
			if var_6.show and var_6.show > 0 then
				var_6.show = var_6.show - arg_15_1

				if var_6.show <= 0 then
					var_6.show = nil
				end
			else
				local var_15_0, var_15_1, var_15_2, var_15_3 = arg_15_0:GetSmoothOffset(var_6.start, arg_15_0.scoreTextTf.position, arg_15_1, 0.75, var_6.state)

				if var_6.tf then
					var_6.tf.position = var_15_1
				end

				var_6.state = var_15_3

				if var_15_2 then
					var_6.finish = true

					if var_6.tf then
						GetComponent = var_11
						findTF = var_13

						local var_15_4 = var_13(var_6.tf, "ad")

						typeof = var_14
						Animator = var_16

						local var_15_5 = var_11(var_15_4, var_14(var_16))

						var_11.SetTrigger(var_15_5, "hide")

						table = var_11

						var_11.insert(arg_15_0._scoreTfPool, var_6.tf)
						arg_15_0:UpdateScore()
					end

					table = var_11

					var_11.remove(arg_15_0._scoreTfTweenDic, iter_15_0)
				end
			end
		end
	end

	return
end

function var_0_0.UpdateScore(arg_16_0)
	local var_16_0 = arg_16_0._score
	local var_16_1 = arg_16_0._gameVo

	if var_16_0 ~= var_2.GetScore(var_16_1) then
		local var_16_2 = arg_16_0._gameVo

		arg_16_0._score = var_1.GetScore(var_16_2)
		setText = var_1

		var_1(arg_16_0.scoreTextTf, arg_16_0._score)
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
		setActive = var_1_10003

		var_1_10003(arg_18_0._wantedTF, true)

		GetSpriteFromAtlasAsync = var_1_10003
		SortGameConst = var_5

		var_1_10003(var_5.ui_atlas, "item_" .. arg_18_1, function(arg_19_0)
			if arg_19_0 then
				local var_19_0 = arg_18_0

				SortGameConst = var_2_10002
				var_19_0._wantedStepTime = var_2_10002.wanted_step_time
				setImageSprite = var_19_0

				var_19_0(arg_18_0._wantedItemIcon, arg_19_0, true)

				setActive = var_19_0

				var_19_0(arg_18_0._wantedItemIcon, true)
			end

			return
		end)
		arg_18_0:UpdatePlayer(arg_18_2)
	else
		setActive = var_1_10003

		var_1_10003(arg_18_0._wantedTF, false)
	end

	return
end

function var_0_0.SetCombo(arg_20_0, arg_20_1)
	if arg_20_1 == 0 then
		setActive = var_1_10002
		findTF = var_1_10004

		var_1_10002(var_1_10004(arg_20_0._gameUI, "combo"), false)

		return
	end

	arg_20_0._comboIndex = arg_20_1

	for iter_20_0 = 1, #arg_20_0.comboEffectTf do
		setActive = var_1_10006

		var_1_10006(arg_20_0.comboEffectTf[iter_20_0], false)
	end

	SortGameConst = var_2

	for iter_20_1 = #var_2.combo_effect_count, 1, -1 do
		SortGameConst = var_1_10006

		if var_1_10006.combo_effect_count[iter_20_1] <= arg_20_1 then
			setActive = var_1_10006

			var_1_10006(arg_20_0.comboEffectTf[iter_20_1], true)

			break
		end
	end

	SortGameConst = var_2
	arg_20_0._comboTime = var_2.combo_time
	setActive = var_2
	findTF = var_4

	var_2(var_4(arg_20_0._gameUI, "combo"), false)

	setActive = var_2
	findTF = var_4

	var_2(var_4(arg_20_0._gameUI, "combo"), true)

	setText = var_2
	findTF = var_4

	var_2(var_4(arg_20_0._gameUI, "combo/ad/combo_img/combo_desc"), "X " .. arg_20_1)

	return
end

function var_0_0.SetPlayerSpeak(arg_21_0, arg_21_1)
	if arg_21_0._playerSpeakTime then
		return
	end

	local var_21_0

	if arg_21_1 and arg_21_1.text then
		setActive = var_21_0

		var_21_0(arg_21_0._playerSpeakPanel, true)

		setActive = var_21_0

		var_21_0(arg_21_0._playerSpeakTF, true)

		setText = var_21_0

		var_21_0(arg_21_0._playerSpeakText, arg_21_1.text)

		arg_21_0._playerSpeakTime = arg_21_1.time

		if not arg_21_1.icon then
			var_21_0 = nil
		end

		if var_21_0 then
			arg_21_0:UpdatePlayer(var_21_0)
		end
	else
		setActive = var_21_0

		var_21_0(arg_21_0._playerSpeakPanel, false)

		setActive = var_21_0

		var_21_0(arg_21_0._playerSpeakTF, false)
	end

	return
end

function var_0_0.StepTimeToScore(arg_22_0)
	if arg_22_0._timeToScoreTimer then
		return
	end

	SortGameConst = var_1

	local var_22_0 = var_1.time_trans_score
	local var_22_1 = arg_22_0._gameVo
	local var_22_2 = var_22_0 * var_2.GetTimeInteger(var_22_1)
	local var_22_3 = 3
	local var_22_4 = arg_22_0._gameVo
	local var_22_5 = var_3.GetTimeInteger(var_22_4) / var_22_3

	SortGameConst = var_22_1
	arg_22_0._timeToScoreStep = var_22_3 * var_22_1.time_trans_score
	Timer = var_4
	arg_22_0._timeToScoreTimer = var_4.New(function()
		var_22_5 = var_22_5 - 1

		if var_22_5 <= 0 then
			if arg_22_0._timeToScoreTimer then
				local var_23_0 = arg_22_0._timeToScoreTimer

				var_0.Stop(var_23_0)

				arg_22_0._timeToScoreTimer = nil
			end

			local var_23_1 = arg_22_0._event
			local var_23_2 = var_0.emit

			SimpleMGEvent = var_2_10003

			var_23_2(var_23_1, var_2_10003.ADD_SCORE, {
				combo = 0,
				num = var_22_2
			})

			setText = var_23_2

			local var_23_3 = arg_22_0.timeTF

			string = var_3

			var_23_2(var_23_3, var_3.format("%02d : %02d", 0, 0))

			setText = var_23_2

			local var_23_4 = arg_22_0.scoreTextTf

			var_2_10005 = arg_22_0._gameVo

			var_23_2(var_23_4, var_3.GetScore(var_2_10005))

			local var_23_5 = arg_22_0._event
			local var_23_6 = var_0.emit

			SimpleMGEvent = var_3

			var_23_6(var_23_5, var_3.GAME_OVER)

			return
		end

		local var_23_7 = arg_22_0

		var_23_7._time = arg_22_0._time - var_22_3
		math = var_23_7

		local var_23_8 = var_23_7.floor(arg_22_0._time / 60)

		math = var_1

		local var_23_9 = var_1.floor(arg_22_0._time % 60)

		setText = var_2

		local var_23_10 = arg_22_0.timeTF

		string = var_2_10005

		var_2(var_23_10, var_2_10005.format("%02d : %02d", var_23_8, var_23_9))

		local var_23_11 = arg_22_0

		var_23_11._score = arg_22_0._score + arg_22_0._timeToScoreStep
		setText = var_23_11

		var_23_11(arg_22_0.scoreTextTf, arg_22_0._score)

		local var_23_12 = arg_22_0

		var_2.StepScoreTween(var_23_12, 0.05)

		return
	end, 0.05, -1)

	local var_22_6 = arg_22_0._timeToScoreTimer

	var_4.Start(var_22_6)

	return
end

function var_0_0.SetChildVisible(arg_24_0, arg_24_1, arg_24_2)
	for iter_24_0 = 1, arg_24_1.childCount do
		local var_24_0 = arg_24_1:GetChild(iter_24_0 - 1)

		setActive = var_1_10008

		var_1_10008(var_24_0, arg_24_2)
	end

	return
end

function var_0_0.Press(arg_25_0, arg_25_1, arg_25_2)
	return
end

function var_0_0.GameOver(arg_26_0)
	pairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001(arg_26_0._scoreTfTweenDic) do
		if iter_26_1.tf then
			setActive = var_6

			var_6(iter_26_1.tf, false)

			table = var_6

			var_6.insert(arg_26_0._scoreTfPool, iter_26_1.tf)
		end
	end

	arg_26_0._scoreTfTweenDic = {}

	return
end

function var_0_0.Dispose(arg_27_0)
	for iter_27_0 = 1, #arg_27_0._scoreTfPool do
		GetComponent = var_1_10005
		findTF = var_1_10007
		var_1_10007 = var_1_10007(arg_27_0._scoreTfPool[iter_27_0], "ad")
		typeof = var_1_10008
		DftAniEvent = var_10
		var_1_10008 = var_1_10005(var_1_10007, var_1_10008(var_10))

		var_1_10005.SetEndEvent(var_1_10008, nil)
	end

	return
end

function var_0_0.GetSmoothOffset(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4, arg_28_5)
	local function var_28_0(arg_29_0)
		local var_29_0 = {}
		local var_29_1

		if not arg_29_0.x then
			var_29_1 = 0
		end

		var_29_0.x = var_29_1

		local var_29_2

		if not arg_29_0.y then
			var_29_2 = 0
		end

		var_29_0.y = var_29_2
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

	math = var_1_10007

	local var_28_1 = var_1_10007.max(arg_28_4 or 0, 0.0001)

	arg_28_5 = arg_28_5 or {
		elapsed = 0,
		currentPos = var_28_0(arg_28_1)
	}

	local var_28_2

	if not arg_28_1.x then
		var_28_2 = 0
	end

	local var_28_3

	if not arg_28_1.y then
		var_28_3 = 0
	end

	local var_28_4 = arg_28_1.z
	local var_28_5

	if not arg_28_2.x then
		var_28_5 = 0
	end

	local var_28_6

	if not arg_28_2.y then
		var_28_6 = 0
	end

	local var_28_7 = arg_28_2.z

	math = var_1_10014
	arg_28_5.elapsed = var_1_10014.min(arg_28_5.elapsed + (arg_28_3 or 0), var_28_1)

	local var_28_8 = arg_28_5.elapsed / var_28_1

	math = var_1_10015

	local var_28_9 = var_1_10015.cos

	math = var_17

	local var_28_10 = 0.5 - 0.5 * var_28_9(var_17.pi * var_28_8)
	local var_28_11 = {
		x = var_28_2 + (var_28_5 - var_28_2) * var_28_10,
		y = var_28_3 + (var_28_6 - var_28_3) * var_28_10
	}

	if var_28_4 ~= nil or var_28_7 ~= nil then
		var_28_11.z = (var_28_4 or 0) + ((var_28_7 or 0) - var_17) * var_28_10
	end

	local var_28_12 = {}
	local var_28_13 = var_28_11.x
	local var_28_14

	if not arg_28_5.currentPos.x then
		var_28_14 = 0
	end

	var_28_12.x = var_28_13 - var_28_14

	local var_28_15 = var_28_11.y
	local var_28_16

	if not arg_28_5.currentPos.y then
		var_28_16 = 0
	end

	var_28_12.y = var_28_15 - var_28_16

	if var_28_11.z ~= nil then
		local var_28_17 = var_28_11.z
		local var_28_18

		if not arg_28_5.currentPos.z then
			var_28_18 = 0
		end

		var_28_12.z = var_28_17 - var_28_18
	end

	arg_28_5.currentPos = var_28_11

	if var_28_1 <= arg_28_5.elapsed then
		var_28_12.x = var_28_5 - (arg_28_5.currentPos.x - var_28_12.x)
		var_28_12.y = var_28_6 - (arg_28_5.currentPos.y - var_28_12.y)
		arg_28_5.currentPos.x = var_28_5
		arg_28_5.currentPos.y = var_28_6

		if var_28_11.z ~= nil then
			local var_28_19 = var_28_7 or 0
			local var_28_20

			if not arg_28_5.currentPos.z then
				var_28_20 = 0
			end

			local var_28_21

			if not var_28_12.z then
				var_28_21 = 0
			end

			var_28_12.z = var_28_19 - (var_28_20 - var_28_21)
			arg_28_5.currentPos.z = var_28_19
		end
	end

	return var_28_12, var_28_0(arg_28_5.currentPos), var_18, arg_28_5
end

return var_0_0
