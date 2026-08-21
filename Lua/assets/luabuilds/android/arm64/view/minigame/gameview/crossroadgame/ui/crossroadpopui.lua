local var_0_0 = class("CrossRoadPopUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	arg_1_0:initCountUI()
	arg_1_0:initLeavelUI()
	arg_1_0:initSettlementUI()

	return
end

function var_0_0.initCountUI(arg_2_0)
	arg_2_0.countUI = findTF(arg_2_0._tf, "pop/CountUI")
	arg_2_0.countAnimator = GetComponent(arg_2_0.countUI, typeof(Animator))
	arg_2_0.countDft = GetOrAddComponent(arg_2_0.countUI, typeof(DftAniEvent))

	arg_2_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_2_0.countDft:SetEndEvent(function()
		arg_2_0._event:emit(SimpleMGEvent.COUNT_DOWN)

		return
	end)

	return
end

function var_0_0.initLeavelUI(arg_5_0)
	arg_5_0.leaveUI = findTF(arg_5_0._tf, "pop/LeaveUI")

	setText(findTF(arg_5_0.leaveUI, "ad/desc"), i18n("mini_game_leave"))
	setActive(arg_5_0.leaveUI, false)
	onButton(arg_5_0._event, findTF(arg_5_0.leaveUI, "ad/btnConfirm"), function()
		arg_5_0:ResumeGame()
		arg_5_0._event:emit(CrossRoadGameView.LEAVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(arg_5_0._event, findTF(arg_5_0.leaveUI, "ad/btnCancel"), function()
		arg_5_0:ResumeGame()
		arg_5_0._event:emit(CrossRoadGameView.LEAVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initSettlementUI(arg_8_0)
	arg_8_0.settlementUI = findTF(arg_8_0._tf, "pop/SettleMentUI")
	arg_8_0.curRoleText = findTF(arg_8_0.settlementUI, "ad/1/layout2/curRoleText")
	arg_8_0.curRoleTextCnt = findTF(arg_8_0.settlementUI, "ad/1/layout2/curRoleText_Cnt")
	arg_8_0.curScoreText = findTF(arg_8_0.settlementUI, "ad/1/layout1/currentText")
	arg_8_0.curScoreTextCnt = findTF(arg_8_0.settlementUI, "ad/1/layout1/currentText_Cnt")

	setActive(arg_8_0.settlementUI, false)
	onButton(arg_8_0._event, findTF(arg_8_0.settlementUI, "ad/btnOver"), function()
		arg_8_0:ClearUI()
		arg_8_0._event:emit(SimpleMGEvent.BACK_MENU)

		return
	end, SFX_CANCEL)
	onButton(arg_8_0._event, findTF(arg_8_0.settlementUI, "ad/btnAgain"), function()
		arg_8_0:ClearUI()
		arg_8_0._event:emit(CrossRoadGameView.AGAIN)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.setChildVisible(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0 = 1, arg_11_1.childCount do
		setActive(arg_11_1:GetChild(iter_11_0 - 1), arg_11_2)
	end

	return
end

function var_0_0.PopPauseUI(arg_12_0)
	if isActive(arg_12_0.leaveUI) then
		setActive(arg_12_0.leaveUI, false)
	end

	return
end

function var_0_0.PopCountUI(arg_13_0, arg_13_1)
	setActive(arg_13_0.countUI, arg_13_1)

	return
end

function var_0_0.PopSettlementUI(arg_14_0, arg_14_1)
	setActive(arg_14_0.settlementUI, arg_14_1)

	return
end

function var_0_0.PopLeaveUI(arg_15_0)
	setActive(arg_15_0.leaveUI, true)

	return
end

function var_0_0.UpdateSettlementUI(arg_16_0)
	GetComponent(findTF(arg_16_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_16_0 = arg_16_0._gameVo:GetScore()
	local var_16_1 = arg_16_0._gameVo:GetRoleCnt()

	setText(arg_16_0.curScoreText, i18n("mini_game_crossroad_score"))
	setText(arg_16_0.curScoreTextCnt, var_16_0)
	setText(arg_16_0.curRoleText, i18n("mini_game_crossroad_cnt"))
	setText(arg_16_0.curRoleTextCnt, var_16_1)
	arg_16_0._event:emit(SimpleMGEvent.SUBMIT_GAME_SUCCESS, {
		num = var_16_0,
		cnt = var_16_1
	})

	return
end

function var_0_0.BackPressed(arg_17_0)
	if isActive(arg_17_0.leaveUI) then
		arg_17_0:ResumeGame()
		arg_17_0._event:emit(CrossRoadGameView.LEAVEL_GAME, false)
	else
		setActive(arg_17_0.leaveUI, true)
		arg_17_0._event:emit(SimpleMGEvent.PAUSE_GAME, true)
	end

	return
end

function var_0_0.ResumeGame(arg_18_0)
	setActive(arg_18_0.leaveUI, false)

	return
end

function var_0_0.UpdateGameUI(arg_19_0, arg_19_1)
	setText(arg_19_0.scoreTf, arg_19_1.scoreNum)
	setText(arg_19_0.gameTimeS, math.ceil(arg_19_1.gameTime))

	return
end

function var_0_0.ReadyStart(arg_20_0)
	arg_20_0:PopCountUI(true)
	arg_20_0.countAnimator:Play("cross_count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(WatermelonGameConst.SFX_COUNT_DOWN)

	return
end

function var_0_0.ClearUI(arg_21_0)
	setActive(arg_21_0.settlementUI, false)
	setActive(arg_21_0.countUI, false)

	return
end

return var_0_0
