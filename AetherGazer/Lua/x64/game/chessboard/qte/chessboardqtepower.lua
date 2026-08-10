local var_0_0 = class("ChessBoardQTEPower", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.parent = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:InitCfgData()
	arg_1_0:Init()
end

function var_0_0.InitCfgData(arg_2_0)
	local var_2_0 = ChessBoardTools.GetChessBoardGameSetting("summer_chessboard_power_qte")

	arg_2_0.gameTime = var_2_0[1]
	arg_2_0.hitLvBook = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0[2] or {}) do
		arg_2_0.hitLvBook[iter_2_0 - 1] = iter_2_1
	end

	arg_2_0.winValue = var_2_0[3]
	arg_2_0.perfectValue = var_2_0[4]
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.cellItemList = {}

	for iter_3_0 = 1, 10 do
		arg_3_0.cellItemList[iter_3_0] = arg_3_0[string.format("image%sImg_", iter_3_0)]
	end

	arg_3_0.bloomAniList = {}

	for iter_3_1 = 1, 10 do
		arg_3_0.bloomAniList[iter_3_1] = arg_3_0[string.format("bloom%sAni_", iter_3_1)]
	end

	arg_3_0:AddBtnListener(arg_3_0.hitareaBtn_, nil, function()
		arg_3_0:HitButton()
	end)
end

function var_0_0.HitButton(arg_5_0)
	if not arg_5_0.gameStart then
		return
	end

	local var_5_0 = arg_5_0.btnAni_:GetCurrentAnimatorStateInfo(0)

	arg_5_0.btnAni_:Play("ui_Btn_bloom_cx", 0, 0)
	SetActive(arg_5_0.imgcircleGo_, true)

	arg_5_0.hitCount = arg_5_0.hitCount + 1

	local var_5_1 = arg_5_0.hitLvBook[arg_5_0.hitLv]
	local var_5_2 = arg_5_0.hitLvBook[arg_5_0.hitLv + 1]

	if var_5_2 then
		local var_5_3 = (arg_5_0.hitCount - var_5_1) / (var_5_2 - var_5_1)

		arg_5_0.cellItemList[arg_5_0.hitLv + 1].fillAmount = var_5_3

		if arg_5_0.hitCount == var_5_2 then
			arg_5_0.hitLv = arg_5_0.hitLv + 1
		end
	end

	arg_5_0:PlayClickEffect()
end

function var_0_0.PlayClickEffect(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.bloomAniList) do
		if iter_6_1:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			iter_6_1:Play("ui_bloom_cx", 0, 0)

			break
		end
	end
end

function var_0_0.CountDown(arg_7_0)
	arg_7_0:StopCountDownTimer()

	local var_7_0 = 3

	arg_7_0.countDown1Text_.text = var_7_0
	arg_7_0.countDown2Text_.text = var_7_0

	arg_7_0.countdownAni_:Play("ui_CountDown1_cx", 0, 0)

	arg_7_0.countDownTimer = Timer.New(function()
		var_7_0 = var_7_0 - 1

		if var_7_0 == 0 then
			arg_7_0.parent:ChangeStage()

			arg_7_0.countDown1Text_.text = ""
			arg_7_0.countDown2Text_.text = ""
		else
			arg_7_0.countDown1Text_.text = var_7_0
			arg_7_0.countDown2Text_.text = var_7_0
		end

		if var_7_0 == 2 then
			arg_7_0.countdownAni_:Play("ui_CountDown2_cx", 0, 0)
		elseif var_7_0 == 1 then
			arg_7_0.countdownAni_:Play("ui_CountDown3_cx", 0, 0)
		end

		arg_7_0.countAni_:Play("ui_textNum01_cx", 0, 0)
	end, 1, 3)

	arg_7_0.countDownTimer:Start()
end

function var_0_0.InitGame(arg_9_0)
	arg_9_0.gameStart = false

	SetActive(arg_9_0.gameObject_, true)
	arg_9_0:InitData()

	arg_9_0.tipsText_.text = GetTips("CHESSBOARD_GAME_TIPS_1")
end

function var_0_0.OpenGame(arg_10_0)
	arg_10_0:AddGameTimer()

	arg_10_0.gameStart = true
end

function var_0_0.InitData(arg_11_0)
	arg_11_0.nowTimes = arg_11_0.gameTime
	arg_11_0.hitCount = 0
	arg_11_0.hitLv = 0

	for iter_11_0 = 1, 10 do
		arg_11_0.cellItemList[iter_11_0].fillAmount = 0
	end

	arg_11_0.remaintimeText_.text = string.format("%ss", arg_11_0.nowTimes)
end

function var_0_0.OverGame(arg_12_0)
	arg_12_0:StopTimer()
	arg_12_0.parent:ChangeStage()

	arg_12_0.gameStart = false
end

function var_0_0.GetScore(arg_13_0)
	local var_13_0

	if arg_13_0.hitLv <= arg_13_0.winValue then
		var_13_0 = ChessBoardQTEGameConst.QTEGameResult.Lose
	elseif arg_13_0.hitLv <= arg_13_0.perfectValue then
		var_13_0 = ChessBoardQTEGameConst.QTEGameResult.Win
	else
		var_13_0 = ChessBoardQTEGameConst.QTEGameResult.Perfect
	end

	return var_13_0, arg_13_0.hitLv
end

function var_0_0.AddGameTimer(arg_14_0)
	arg_14_0:StopTimer()

	arg_14_0.nowHitCount = -1
	arg_14_0.remaintimeText_.text = string.format("%ss", arg_14_0.nowTimes)
	arg_14_0.gameTimer = Timer.New(function()
		arg_14_0:CheckEffectShow()
		arg_14_0:UpdateTimerShow()
	end, 1, arg_14_0.gameTime)

	arg_14_0.gameTimer:Start()
end

function var_0_0.CheckEffectShow(arg_16_0)
	if arg_16_0.nowHitCount >= arg_16_0.hitCount and arg_16_0.imgcircleGo_.activeSelf == true then
		SetActive(arg_16_0.imgcircleGo_, false)
		arg_16_0.huanAni_:Play("ui_huan_xs", 0, 0)
	end

	arg_16_0.nowHitCount = arg_16_0.hitCount
end

function var_0_0.UpdateTimerShow(arg_17_0)
	arg_17_0.nowTimes = arg_17_0.nowTimes - 1
	arg_17_0.remaintimeText_.text = string.format("%ss", arg_17_0.nowTimes)

	if arg_17_0.nowTimes == 0 then
		arg_17_0:OverGame()
	end
end

function var_0_0.StopTimer(arg_18_0)
	if arg_18_0.gameTimer then
		arg_18_0.gameTimer:Stop()

		arg_18_0.gameTimer = nil
	end
end

function var_0_0.StopCountDownTimer(arg_19_0)
	if arg_19_0.countDownTimer then
		arg_19_0.countDownTimer:Stop()

		arg_19_0.countDownTimer = nil
	end
end

function var_0_0.OnExit(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.bloomAniList) do
		iter_20_1:Play("ui_bloom_yc", 0, 0)
	end

	arg_20_0:StopTimer()
	arg_20_0:StopCountDownTimer()
	SetActive(arg_20_0.gameObject_, false)
end

function var_0_0.Dispose(arg_21_0)
	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
