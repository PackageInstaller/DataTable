local var_0_0 = class("ChessBoardQTEHitBalloon", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.parent = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:InitCfgData()
	arg_1_0:Init()
end

function var_0_0.InitCfgData(arg_2_0)
	local var_2_0 = ChessBoardTools.GetChessBoardGameSetting("summer_chessboard_balloon_qte")

	arg_2_0.gameTime = var_2_0[1]
	arg_2_0.maxExistCount = var_2_0[2]
	arg_2_0.winValue = var_2_0[3]
	arg_2_0.perfectValue = var_2_0[4]
end

local var_0_1 = Vector2(9999, 9999)

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.balloonList = {}
	arg_3_0.usePosList = {}
	arg_3_0.effectList = {}
	arg_3_0.clickHandle_ = handler(arg_3_0, arg_3_0.HitBalloonItem)

	for iter_3_0 = 1, arg_3_0.maxExistCount do
		arg_3_0.balloonList[iter_3_0] = ChessBoardQTEBallonItem.New(arg_3_0[string.format("bubbles%sGo_", iter_3_0)], iter_3_0)

		arg_3_0.balloonList[iter_3_0]:SetBtnClick(arg_3_0.clickHandle_)
	end

	for iter_3_1 = 1, arg_3_0.bubbleeffectlistTrs_.childCount do
		arg_3_0.effectList[iter_3_1] = arg_3_0:CreateEffectItem(iter_3_1)
	end

	arg_3_0.ballWidth = arg_3_0.bubbles1Go_.transform.sizeDelta.x / 2
	arg_3_0.ballHeight = arg_3_0.bubbles1Go_.transform.sizeDelta.y / 2
end

function var_0_0.CreateEffectItem(arg_4_0, arg_4_1)
	local var_4_0 = {
		transform = arg_4_0.bubbleeffectlistTrs_:GetChild(arg_4_1 - 1)
	}

	var_4_0.animator = var_4_0.transform:GetComponent("Animator")

	return var_4_0
end

function var_0_0.CheckIsNotMeetPos(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = math.abs(arg_5_1 - arg_5_3)
	local var_5_1 = math.abs(arg_5_2 - arg_5_4)

	return var_5_0 < arg_5_0.ballWidth and var_5_1 < arg_5_0.ballHeight - 50
end

function var_0_0.CalculateBalloonPos(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 then
		return var_0_1
	end

	local var_6_0 = arg_6_0.bubblecontentTrs_.rect
	local var_6_1 = var_6_0.width / 2
	local var_6_2 = var_6_0.height / 2
	local var_6_3 = -var_6_1 + arg_6_0.ballWidth
	local var_6_4 = var_6_1 - arg_6_0.ballWidth
	local var_6_5 = -var_6_2 + arg_6_0.ballHeight
	local var_6_6 = var_6_2 - arg_6_0.ballHeight
	local var_6_7 = arg_6_0.balloonList[arg_6_2]
	local var_6_8 = var_6_7.posX
	local var_6_9 = var_6_7.posY
	local var_6_10 = 100

	while var_6_10 > 0 do
		local var_6_11 = math.random(var_6_3, var_6_4)
		local var_6_12 = math.random(var_6_5, var_6_6)
		local var_6_13 = true

		for iter_6_0, iter_6_1 in pairs(arg_6_0.balloonList) do
			local var_6_14 = iter_6_1.posX or 9999
			local var_6_15 = iter_6_1.posY or 9999

			if arg_6_0:CheckIsNotMeetPos(var_6_11, var_6_12, var_6_14, var_6_15) then
				var_6_13 = false

				break
			end
		end

		if var_6_13 then
			var_6_8, var_6_9 = var_6_11, var_6_12

			break
		end

		var_6_10 = var_6_10 - 1
	end

	return Vector2(var_6_8, var_6_9)
end

function var_0_0.HitBalloonItem(arg_7_0, arg_7_1)
	if not arg_7_0.gameStart then
		return
	end

	if arg_7_1.hitState == true then
		return
	end

	arg_7_0.hitCount = arg_7_0.hitCount + 1
	arg_7_1.hitState = true

	arg_7_0:ShowEffect(arg_7_1.transform_.localPosition)
	arg_7_0:RefreshScore()
	arg_7_1:ClickEffect()
	arg_7_0:ShowBalloon(arg_7_1.index)
end

function var_0_0.ShowBalloon(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.balloonList[arg_8_1]
	local var_8_1 = arg_8_0:CalculateBalloonPos(true, arg_8_1)

	var_8_0:SetPos(var_8_1)

	var_8_0.hitState = false
	var_8_0.posX = var_8_1.x
	var_8_0.posY = var_8_1.y
end

function var_0_0.ShowEffect(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.effectList) do
		if iter_9_1.animator:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			iter_9_1.animator:Play("ui_bloom_cx", 0, 0)

			iter_9_1.transform.localPosition = arg_9_1

			break
		end
	end
end

function var_0_0.RefreshScore(arg_10_0)
	arg_10_0.textnumAni_:Play("Fx_scoretext_cx", 0, 0)

	arg_10_0.scoreText_.text = arg_10_0.hitCount
end

function var_0_0.CountDown(arg_11_0)
	arg_11_0:StopCountDownTimer()
	SetActive(arg_11_0.countDownGo_, true)

	local var_11_0 = 3

	arg_11_0.countTimeText_.text = var_11_0
	arg_11_0.countDownTimer = Timer.New(function()
		var_11_0 = var_11_0 - 1

		if var_11_0 == 0 then
			SetActive(arg_11_0.countDownGo_, false)
			arg_11_0.parent:ChangeStage()
		else
			arg_11_0.countTimeText_.text = var_11_0
		end

		arg_11_0.countAni_:Play("ui_CountDownTime_cx", 0, 0)
	end, 1, 3)

	arg_11_0.countDownTimer:Start()
end

function var_0_0.InitGame(arg_13_0)
	arg_13_0.gameStart = false

	SetActive(arg_13_0.gameObject_, true)
	arg_13_0:InitData()

	arg_13_0.tipsText_.text = GetTips("CHESSBOARD_GAME_TIPS_3")
end

function var_0_0.OpenGame(arg_14_0)
	arg_14_0:AddGameTimer()

	arg_14_0.gameStart = true
end

function var_0_0.InitData(arg_15_0)
	arg_15_0.nowTimes = arg_15_0.gameTime
	arg_15_0.hitCount = 0

	for iter_15_0 = 1, arg_15_0.maxExistCount do
		arg_15_0:ShowBalloon(iter_15_0)
	end

	arg_15_0:RefreshScore()

	arg_15_0.remaintimeText_.text = string.format("%ss", arg_15_0.nowTimes)
end

function var_0_0.OverGame(arg_16_0)
	arg_16_0:StopTimer()
	arg_16_0.parent:ChangeStage()

	arg_16_0.gameStart = false
end

function var_0_0.GetScore(arg_17_0)
	local var_17_0

	if arg_17_0.hitCount < arg_17_0.winValue then
		var_17_0 = ChessBoardQTEGameConst.QTEGameResult.Lose
	elseif arg_17_0.hitCount < arg_17_0.perfectValue then
		var_17_0 = ChessBoardQTEGameConst.QTEGameResult.Win
	else
		var_17_0 = ChessBoardQTEGameConst.QTEGameResult.Perfect
	end

	return var_17_0, arg_17_0.hitCount
end

function var_0_0.AddGameTimer(arg_18_0)
	arg_18_0:StopTimer()

	arg_18_0.remaintimeText_.text = string.format("%ss", arg_18_0.nowTimes)
	arg_18_0.gameTimer = Timer.New(function()
		arg_18_0:UpdateTimerShow()
	end, 1, arg_18_0.gameTime)

	arg_18_0.gameTimer:Start()
end

function var_0_0.UpdateTimerShow(arg_20_0)
	arg_20_0.nowTimes = arg_20_0.nowTimes - 1
	arg_20_0.remaintimeText_.text = string.format("%ss", arg_20_0.nowTimes)

	if arg_20_0.nowTimes == 0 then
		arg_20_0:OverGame()
	end
end

function var_0_0.StopTimer(arg_21_0)
	if arg_21_0.gameTimer then
		arg_21_0.gameTimer:Stop()

		arg_21_0.gameTimer = nil
	end
end

function var_0_0.StopCountDownTimer(arg_22_0)
	if arg_22_0.countDownTimer then
		arg_22_0.countDownTimer:Stop()

		arg_22_0.countDownTimer = nil
	end
end

function var_0_0.OnExit(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.effectList) do
		iter_23_1.animator:Play("ui_bloom_yc", 0, 0)
	end

	arg_23_0:StopCountDownTimer()
	arg_23_0:StopTimer()
	SetActive(arg_23_0.gameObject_, false)
end

function var_0_0.Dispose(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0.balloonList) do
		iter_24_1:Dispose()

		iter_24_1 = nil
	end

	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
