local var_0_0 = class("ChessBoardQTEFocus", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.parent = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:InitCfgData()
	arg_1_0:Init()
end

function var_0_0.InitCfgData(arg_2_0)
	local var_2_0 = ChessBoardTools.GetChessBoardGameSetting("summer_chessboard_focus_qte")

	arg_2_0.rotateSpeed = var_2_0[1]

	local var_2_1 = var_2_0[2]

	arg_2_0.succeedRangeList = {}
	arg_2_0.perfectRangeList = {}

	for iter_2_0, iter_2_1 in pairs(var_2_1) do
		arg_2_0.succeedRangeList[iter_2_0] = iter_2_1[1]
		arg_2_0.perfectRangeList[iter_2_0] = iter_2_1[2]
	end

	arg_2_0.winValue = var_2_0[3]
	arg_2_0.perfectValue = var_2_0[4]
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.surebtnBtn_, nil, function()
		arg_3_0:SureBtn()
	end)

	arg_3_0.progressControllerList = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.progressControllerList[iter_3_0] = arg_3_0[string.format("item%sControllerexcollection_", iter_3_0)]:GetController("state")
	end
end

function var_0_0.SureBtn(arg_5_0)
	if not arg_5_0.gameStart then
		return
	end

	if arg_5_0.isCheckScore then
		return
	end

	arg_5_0.hitCount = arg_5_0.hitCount + 1

	arg_5_0:CheckScore()
	SetActive(arg_5_0.pointerEffectGo_, true)

	arg_5_0.isCheckScore = true

	arg_5_0:StopDelayTimer()

	arg_5_0.delayTimer = Timer.New(function()
		arg_5_0.isCheckScore = false

		if arg_5_0.hitCount == 3 then
			arg_5_0:OverGame()
		else
			arg_5_0:RandomTargetPos()
		end

		SetActive(arg_5_0.pointerEffectGo_, false)
	end, 0.5)

	arg_5_0.delayTimer:Start()
end

function var_0_0.CheckScore(arg_7_0)
	local var_7_0 = arg_7_0.succeedRangeList[arg_7_0.hitCount]
	local var_7_1 = arg_7_0.perfectRangeList[arg_7_0.hitCount]
	local var_7_2 = (arg_7_0.targetAngle - var_7_0 / 2) % 360
	local var_7_3 = math.abs(var_7_2 - arg_7_0.pointAngle)

	if var_7_3 > 180 then
		var_7_3 = 360 - var_7_3
	end

	local var_7_4 = var_7_3 * 2

	if var_7_4 <= var_7_1 then
		arg_7_0.hitScore = arg_7_0.hitScore + 2

		arg_7_0.progressControllerList[arg_7_0.hitCount]:SetSelectedState("green")
		arg_7_0:RefreshScore()
		manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_chess_qte03_good", "")
	elseif var_7_4 <= var_7_0 then
		arg_7_0.hitScore = arg_7_0.hitScore + 1

		arg_7_0.progressControllerList[arg_7_0.hitCount]:SetSelectedState("yellow")
		arg_7_0:RefreshScore()
		manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_chess_qte03_normal", "")
	else
		arg_7_0.progressControllerList[arg_7_0.hitCount]:SetSelectedState("red")
		manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_chess_qte03_miss", "")
	end
end

function var_0_0.RandomTargetPos(arg_8_0)
	local var_8_0 = arg_8_0.succeedRangeList[arg_8_0.hitCount + 1]
	local var_8_1 = arg_8_0.pointAngle + var_8_0
	local var_8_2 = arg_8_0.pointAngle - var_8_0 + 360
	local var_8_3 = math.random(var_8_1, var_8_2) % 360
	local var_8_4 = arg_8_0.targetTrs_.eulerAngles

	var_8_4.x = 0
	var_8_4.y = 0
	var_8_4.z = var_8_3
	arg_8_0.targetTrs_.eulerAngles = var_8_4
	arg_8_0.targetAngle = var_8_3

	arg_8_0:UpdateImgShow()
end

function var_0_0.UpdateImgShow(arg_9_0)
	local var_9_0 = arg_9_0.hitCount + 1
	local var_9_1 = arg_9_0.succeedRangeList[var_9_0]
	local var_9_2 = arg_9_0.perfectRangeList[var_9_0]

	if var_9_1 and var_9_2 then
		arg_9_0.imgyellowImg_.fillAmount = var_9_1 / 360
		arg_9_0.imggreenImg_.fillAmount = var_9_2 / 360

		local var_9_3 = -(var_9_1 - var_9_2) / 2
		local var_9_4 = arg_9_0.imggreenTrs_.localEulerAngles

		var_9_4.x = 0
		var_9_4.y = 0
		var_9_4.z = var_9_3
		arg_9_0.imggreenTrs_.localEulerAngles = var_9_4
	end
end

function var_0_0.RefreshScore(arg_10_0)
	arg_10_0.textnumAni_:Play("Fx_scoretext_cx", 0, 0)

	arg_10_0.scoreText_.text = arg_10_0.hitScore
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

	arg_13_0:InitData()
	SetActive(arg_13_0.gameObject_, true)

	arg_13_0.tipsText_.text = GetTips("CHESSBOARD_GAME_TIPS_2")
end

function var_0_0.OpenGame(arg_14_0)
	arg_14_0.gameStart = true

	arg_14_0:AddGameTimer()
end

function var_0_0.InitData(arg_15_0)
	arg_15_0.hitCount = 0
	arg_15_0.hitScore = 0
	arg_15_0.pointAngle = 0
	arg_15_0.targetAngle = 0

	for iter_15_0, iter_15_1 in pairs(arg_15_0.progressControllerList) do
		iter_15_1:SetSelectedState("empty")
	end

	arg_15_0:RefreshScore()
	arg_15_0:RandomTargetPos()
	arg_15_0:UpdateTimerShow()
end

function var_0_0.OverGame(arg_16_0)
	arg_16_0.gameStart = false

	arg_16_0:StopTimer()
	arg_16_0.parent:ChangeStage()
end

function var_0_0.GetScore(arg_17_0)
	local var_17_0

	if arg_17_0.hitScore < arg_17_0.winValue then
		var_17_0 = ChessBoardQTEGameConst.QTEGameResult.Lose
	elseif arg_17_0.hitScore < arg_17_0.perfectValue then
		var_17_0 = ChessBoardQTEGameConst.QTEGameResult.Win
	else
		var_17_0 = ChessBoardQTEGameConst.QTEGameResult.Perfect
	end

	return var_17_0, arg_17_0.hitScore
end

function var_0_0.AddGameTimer(arg_18_0)
	arg_18_0:StopTimer()

	arg_18_0.gameTimer = FrameTimer.New(function()
		arg_18_0:UpdateTimerShow()
	end, 1, -1)

	arg_18_0.gameTimer:Start()
end

function var_0_0.UpdateTimerShow(arg_20_0)
	if arg_20_0.isCheckScore then
		return
	end

	arg_20_0.pointAngle = (arg_20_0.pointAngle - arg_20_0.rotateSpeed) % 360

	local var_20_0 = arg_20_0.pointerTrs_.eulerAngles

	var_20_0.x = 0
	var_20_0.y = 0
	var_20_0.z = arg_20_0.pointAngle
	arg_20_0.pointerTrs_.eulerAngles = var_20_0
end

function var_0_0.StopCountDownTimer(arg_21_0)
	if arg_21_0.countDownTimer then
		arg_21_0.countDownTimer:Stop()

		arg_21_0.countDownTimer = nil
	end
end

function var_0_0.StopTimer(arg_22_0)
	if arg_22_0.gameTimer then
		arg_22_0.gameTimer:Stop()

		arg_22_0.gameTimer = nil
	end
end

function var_0_0.StopDelayTimer(arg_23_0)
	if arg_23_0.delayTimer then
		arg_23_0.delayTimer:Stop()

		arg_23_0.delayTimer = nil
	end
end

function var_0_0.OnExit(arg_24_0)
	arg_24_0:StopDelayTimer()
	arg_24_0:StopCountDownTimer()
	arg_24_0:StopTimer()
	SetActive(arg_24_0.gameObject_, false)
end

function var_0_0.Dispose(arg_25_0)
	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
