local var_0_0 = class("SnowballGameInfoSubView", BaseView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.bubbleDisplayCountdown = 0

	arg_1_0:BindCfgUI()

	arg_1_0.modeController = ControllerUtil.GetController(arg_1_0.transform_, "mode")
	arg_1_0.hitList = {}
	arg_1_0.scoreBubble = {}

	arg_1_0:BindCfgUI(arg_1_0.scoreBubble_, arg_1_0.scoreBubble)

	arg_1_0.scoreBubble.obj = arg_1_0.scoreBubble_
	arg_1_0.scoreBubble.trs = arg_1_0.scoreBubble_.transform
	arg_1_0.scoreBubble.modeController = ControllerUtil.GetController(arg_1_0.scoreBubble_.transform, "type")

	function arg_1_0.scoreBubble.Show(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_2_0.obj:SetActive(false)

		arg_1_0.bubbleDisplayCountdown = 2.5

		local var_2_0 = string.format("%+d", arg_2_2)

		arg_2_0.score1_.text = var_2_0
		arg_2_0.score2_.text = var_2_0
		arg_2_0.score3_.text = var_2_0

		arg_2_0.modeController:SetSelectedState(arg_2_1)

		local var_2_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(UnityEngine.Camera.main, arg_2_3)
		local var_2_2 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
		local var_2_3, var_2_4 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(arg_2_0.trs.parent, var_2_1, var_2_2, nil)

		arg_2_0.trs.localPosition = var_2_4

		arg_2_0.obj:SetActive(true)
	end

	function arg_1_0.scoreBubble.Hide(arg_3_0)
		arg_3_0.obj:SetActive(false)
	end
end

function var_0_0.Update(arg_4_0, arg_4_1)
	if not arg_4_0.started then
		return
	end

	arg_4_0.totalTime = math.max(0, arg_4_0.totalTime - arg_4_1)
	arg_4_0.time_.text = string.format("%2d", math.ceil(arg_4_0.totalTime))
	arg_4_0.countdown = math.max(0, arg_4_0.countdown - arg_4_1)

	if arg_4_0.countdown < 5 and arg_4_0.modeController:GetSelectedState() == "times" then
		arg_4_0.modeController:SetSelectedState("refresh")
	end

	if arg_4_0.modeController:GetSelectedState() == "times" then
		arg_4_0.waveTimeBar_.fillAmount = 1 - arg_4_0.countdown / arg_4_0.curWaveDuration
	else
		arg_4_0.countdownText_.text = GetTipsF(arg_4_0.hasNextWave and "ACTIVITY_SNOWBALL_REFRESH_ENEMY" or "ACTIVITY_SNOWBALL_GAME_END", math.ceil(arg_4_0.countdown))
	end

	local var_4_0 = arg_4_0.bubbleDisplayCountdown - arg_4_1

	if arg_4_0.bubbleDisplayCountdown >= 0 and var_4_0 < 0 then
		arg_4_0.scoreBubble:Hide()
	end

	arg_4_0.bubbleDisplayCountdown = var_4_0
end

function var_0_0.OnEnter(arg_5_0, arg_5_1)
	arg_5_0.score = 0
	arg_5_0.started = false
	arg_5_0.level = arg_5_1.level
	arg_5_0.totalTime = SnowballGameCfg[arg_5_0.level].time_limit
	arg_5_0.hitGuest = 0

	arg_5_0:RegistEventListener(SNOWBALL_GAME_HIT, handler(arg_5_0, arg_5_0.UpdateScore))
	arg_5_0:RegistEventListener(SNOWBALL_GAME_TARGET_NEW_WAVE, handler(arg_5_0, arg_5_0.UpdateWave))
	arg_5_0:RegistEventListener(SNOWBALL_GAME_PLAYER_HIT_GUEST, function()
		arg_5_0.hitGuest = arg_5_0.hitGuest + 1
	end)

	arg_5_0.score_.text = string.format("%d", arg_5_0.score)
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0.hitList = {}

	arg_7_0:RemoveAllEventListener()
	arg_7_0.scoreBubble:Hide()
end

function var_0_0.OnGameStart(arg_8_0)
	arg_8_0.started = true
	arg_8_0.hitGuest = 0
	arg_8_0.score = 0
	arg_8_0.score_.text = string.format("%d", arg_8_0.score)
end

function var_0_0.UpdateScore(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = GameSetting.activity_snowball_score_row_bonus.value[arg_9_1.row] or 0
	local var_9_1 = GameSetting.activity_snowball_score_acc_bonus.value[arg_9_2 and 2 or 1]
	local var_9_2 = SnowballGameUnitCfg[arg_9_1.cfgID].unit_type
	local var_9_3 = (GameSetting.activity_snowball_score.value[var_9_2] or 0) + var_9_1 + var_9_0

	arg_9_0.score = arg_9_0.score + var_9_3

	if arg_9_0.hitList[arg_9_1.cfgID] == nil then
		arg_9_0.hitList[arg_9_1.cfgID] = 1
	else
		arg_9_0.hitList[arg_9_1.cfgID] = arg_9_0.hitList[arg_9_1.cfgID] + 1
	end

	arg_9_0.score_.text = string.format("%d", arg_9_0.score)

	arg_9_0.scoreBubble:Show(var_9_2, var_9_3, arg_9_3)
end

function var_0_0.UpdateWave(arg_10_0, arg_10_1)
	arg_10_0.wave_.text = GetTipsF("ACTIVITY_SNOWBALL_ENEMY_WAVE_NUMS", arg_10_1 + 1, #SnowballGameCfg[arg_10_0.level].refresh_enemy + 1)

	local var_10_0 = nullable(SnowballGameCfg, arg_10_0.level, "refresh_enemy", arg_10_1 + 1, 4)

	arg_10_0.curWaveDuration = var_10_0 or arg_10_0.totalTime
	arg_10_0.countdown = arg_10_0.curWaveDuration
	arg_10_0.hasNextWave = var_10_0 ~= nil

	arg_10_0.modeController:SetSelectedState("times")
end

function var_0_0.RecordFinishTime(arg_11_0)
	arg_11_0.restTimeAfterFinish = arg_11_0.totalTime
end

function var_0_0.CalcRestTimeAfterFinish(arg_12_0)
	return arg_12_0.restTimeAfterFinish or 0
end

return var_0_0
