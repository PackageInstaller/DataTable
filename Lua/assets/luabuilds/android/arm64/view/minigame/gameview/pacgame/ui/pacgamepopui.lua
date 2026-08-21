local var_0_0 = class("WatermelonGamePopUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	arg_1_0:initCountUI()
	arg_1_0:initLeavelUI()
	arg_1_0:initPauseUI()
	arg_1_0:initSettlementUI()

	return
end

function var_0_0.initCountUI(arg_2_0)
	arg_2_0.countUI = findTF(arg_2_0._tf, "pop/CountUI")
	arg_2_0.countAnimator = GetComponent(findTF(arg_2_0.countUI, "count"), typeof(Animator))
	arg_2_0.countDft = GetOrAddComponent(findTF(arg_2_0.countUI, "count"), typeof(DftAniEvent))

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
	setText(findTF(arg_5_0.leaveUI, "ad/btnConfirmDesc"), i18n("ryza_task_confirm"))
	setText(findTF(arg_5_0.leaveUI, "ad/btnCancelDesc"), i18n("ryza_task_cancel"))
	setActive(arg_5_0.leaveUI, false)
	onButton(arg_5_0._event, findTF(arg_5_0.leaveUI, "ad/btnConfirm"), function()
		arg_5_0:ResumeGame()
		arg_5_0._event:emit(SimpleMGEvent.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(arg_5_0._event, findTF(arg_5_0.leaveUI, "ad/btnCancel"), function()
		arg_5_0:ResumeGame()
		arg_5_0._event:emit(SimpleMGEvent.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initPauseUI(arg_8_0)
	arg_8_0.pauseUI = findTF(arg_8_0._tf, "pop/pauseUI")

	setActive(arg_8_0.pauseUI, false)
	setText(findTF(arg_8_0.pauseUI, "ad/desc"), i18n("mini_game_pause"))
	setText(findTF(arg_8_0.pauseUI, "ad/btnDesc"), i18n("mini_game_continue"))
	onButton(arg_8_0._event, findTF(arg_8_0.pauseUI, "ad/btnOk"), function()
		arg_8_0:ResumeGame()
		arg_8_0._event:emit(SimpleMGEvent.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initSettlementUI(arg_10_0)
	arg_10_0.settlementUI = findTF(arg_10_0._tf, "pop/SettleMentUI")

	setText(findTF(arg_10_0.settlementUI, "ad/btnOver/text"), i18n("mini_game_over_game"))
	setText(findTF(arg_10_0.settlementUI, "ad/HighDesc"), i18n("mini_game_high_score"))
	setText(findTF(arg_10_0.settlementUI, "ad/CurDesc"), i18n("mini_game_cur_score"))
	setActive(arg_10_0.settlementUI, false)
	onButton(arg_10_0._event, findTF(arg_10_0.settlementUI, "ad/btnOver"), function()
		arg_10_0:ClearUI()
		arg_10_0._event:emit(SimpleMGEvent.BACK_MENU)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.setChildVisible(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0 = 1, arg_12_1.childCount do
		setActive(arg_12_1:GetChild(iter_12_0 - 1), arg_12_2)
	end

	return
end

function var_0_0.PopPauseUI(arg_13_0)
	if isActive(arg_13_0.leaveUI) then
		setActive(arg_13_0.leaveUI, false)
	end

	setActive(arg_13_0.pauseUI, true)

	return
end

function var_0_0.PopCountUI(arg_14_0, arg_14_1)
	setActive(arg_14_0.countUI, arg_14_1)

	return
end

function var_0_0.PopSettlementUI(arg_15_0, arg_15_1)
	setActive(arg_15_0.settlementUI, arg_15_1)

	return
end

function var_0_0.PopLeaveUI(arg_16_0)
	if isActive(arg_16_0.pauseUI) then
		setActive(arg_16_0.pauseUI, false)
	end

	setActive(arg_16_0.leaveUI, true)

	return
end

function var_0_0.UpdateSettlementUI(arg_17_0)
	GetComponent(findTF(arg_17_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_17_0 = arg_17_0._gameVo:GetScore()
	local var_17_1

	if arg_17_0._gameVo:GetConfig("game_room") > 0 then
		var_17_1 = getProxy(GameRoomProxy):getRoomScore(arg_17_0._gameVo:GetConfig("game_room"))
	else
		local var_17_2 = getProxy(MiniGameProxy):GetHighScore(arg_17_0._gameVo:GetGameId())

		var_17_1 = var_17_2 and #var_17_2 > 0 and var_17_2[1] or 0
	end

	setActive(findTF(arg_17_0.settlementUI, "ad/new"), var_17_1 < var_17_0)

	if var_17_0 > 0 and var_17_1 < var_17_0 then
		arg_17_0._event:emit(SimpleMGEvent.STORE_SERVER, {
			var_17_0,
			1
		})
	end

	local var_17_3 = findTF(arg_17_0.settlementUI, "ad/highText")

	setText(findTF(arg_17_0.settlementUI, "ad/currentText"), var_17_0)
	setText(var_17_3, var_17_1)
	arg_17_0._event:emit(SimpleMGEvent.SUBMIT_GAME_SUCCESS, var_17_0)

	return
end

function var_0_0.BackPressed(arg_18_0)
	if isActive(arg_18_0.pauseUI) then
		arg_18_0:ResumeGame()
		arg_18_0._event:emit(SimpleMGEvent.PAUSE_GAME, false)
	elseif isActive(arg_18_0.leaveUI) then
		arg_18_0:ResumeGame()
		arg_18_0._event:emit(SimpleMGEvent.LEVEL_GAME, false)
	elseif not isActive(arg_18_0.pauseUI) and not isActive(arg_18_0.pauseUI) then
		if not arg_18_0._gameVo:IsSettlement() then
			arg_18_0:PopPauseUI()
			arg_18_0._event:emit(SimpleMGEvent.PAUSE_GAME, true)
		end
	else
		arg_18_0:ResumeGame()
	end

	return
end

function var_0_0.ResumeGame(arg_19_0)
	setActive(arg_19_0.leaveUI, false)
	setActive(arg_19_0.pauseUI, false)

	return
end

function var_0_0.UpdateGameUI(arg_20_0, arg_20_1)
	setText(arg_20_0.scoreTf, arg_20_1.scoreNum)
	setText(arg_20_0.gameTimeS, math.ceil(arg_20_1.gameTime))

	return
end

function var_0_0.ReadyStart(arg_21_0)
	arg_21_0:PopCountUI(true)
	arg_21_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(WatermelonGameConst.SFX_COUNT_DOWN)

	return
end

function var_0_0.ClearUI(arg_22_0)
	setActive(arg_22_0.settlementUI, false)
	setActive(arg_22_0.countUI, false)

	return
end

return var_0_0
