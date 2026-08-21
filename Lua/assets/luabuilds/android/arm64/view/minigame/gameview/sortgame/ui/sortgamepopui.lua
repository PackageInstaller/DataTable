local var_0_0 = class("SortGamePopUI")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	arg_1_0._gameVo = arg_1_3

	arg_1_0:initCountUI()
	arg_1_0:initLeavelUI()
	arg_1_0:initPauseUI()
	arg_1_0:initSettlementUI()
	arg_1_0:initRankUI()

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

function var_0_0.initRankUI(arg_12_0)
	arg_12_0.rankUI = findTF(arg_12_0._tf, "pop/RankUI")

	arg_12_0:PopRankUI(false)

	arg_12_0._rankImg = findTF(arg_12_0.rankUI, "ad/img")
	arg_12_0._rankBtnClose = findTF(arg_12_0.rankUI, "ad/btnClose")
	arg_12_0._rankContent = findTF(arg_12_0.rankUI, "ad/list/content")
	arg_12_0._rankItemTpl = findTF(arg_12_0.rankUI, "ad/list/content/itemTpl")
	arg_12_0._rankEmpty = findTF(arg_12_0.rankUI, "ad/empty")
	arg_12_0._rankDesc = findTF(arg_12_0.rankUI, "ad/desc")
	arg_12_0._rankItems = {}

	setActive(arg_12_0._rankItemTpl, false)
	onButton(arg_12_0._event, findTF(arg_12_0.rankUI, "ad/close"), function()
		arg_12_0:PopRankUI(false)

		return
	end, SFX_CANCEL)
	onButton(arg_12_0._event, arg_12_0._rankBtnClose, function()
		arg_12_0:PopRankUI(false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.setChildVisible(arg_15_0, arg_15_1, arg_15_2)
	for iter_15_0 = 1, arg_15_1.childCount do
		setActive(arg_15_1:GetChild(iter_15_0 - 1), arg_15_2)
	end

	return
end

function var_0_0.PopPauseUI(arg_16_0)
	if isActive(arg_16_0.leaveUI) then
		setActive(arg_16_0.leaveUI, false)
	end

	setActive(arg_16_0.pauseUI, true)

	return
end

function var_0_0.PopCountUI(arg_17_0, arg_17_1)
	setActive(arg_17_0.countUI, arg_17_1)

	return
end

function var_0_0.PopSettlementUI(arg_18_0, arg_18_1)
	setActive(arg_18_0.settlementUI, arg_18_1)

	return
end

function var_0_0.PopRankUI(arg_19_0, arg_19_1)
	setActive(arg_19_0.rankUI, arg_19_1)

	return
end

function var_0_0.PopLeaveUI(arg_20_0)
	if isActive(arg_20_0.pauseUI) then
		setActive(arg_20_0.pauseUI, false)
	end

	setActive(arg_20_0.leaveUI, true)

	return
end

function var_0_0.UpdateRankData(arg_21_0, arg_21_1)
	for iter_21_0 = 1, #arg_21_1 do
		if iter_21_0 > #arg_21_0._rankItems then
			local var_21_1 = tf(instantiate(arg_21_0._rankItemTpl))

			setActive(var_21_1, false)
			setParent(var_21_1, arg_21_0._rankContent)
			table.insert(arg_21_0._rankItems, var_21_1)
		end

		local var_21_2 = arg_21_0._rankItems[iter_21_0]

		arg_21_0:SetRankItemData(arg_21_0._rankItems[iter_21_0], arg_21_1[iter_21_0], iter_21_0)
		setActive(var_21_2, true)
	end

	for iter_21_1 = #arg_21_1 + 1, #arg_21_0._rankItems do
		setActive(arg_21_0._rankItems, false)
	end

	setActive(arg_21_0._rankEmpty, #arg_21_1 == 0)
	setActive(arg_21_0._rankImg, #arg_21_1 > 0)

	return
end

function var_0_0.SetRankItemData(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_3 = getProxy(PlayerProxy):isSelf(arg_22_2.player_id)

	setText(findTF(arg_22_1, "nameText"), arg_22_2.name)
	arg_22_0:setChildVisible(findTF(arg_22_1, "bg"), false)
	arg_22_0:setChildVisible(findTF(arg_22_1, "rank"), false)

	if arg_22_3 <= 3 then
		setActive(findTF(arg_22_1, "bg/" .. arg_22_3), true)
		setActive(findTF(arg_22_1, "rank/" .. arg_22_3), true)
	elseif var_22_3 then
		setActive(findTF(arg_22_1, "bg/me"), true)
		setActive(findTF(arg_22_1, "rank/count"), true)
	else
		setActive(findTF(arg_22_1, "bg/other"), true)
		setActive(findTF(arg_22_1, "rank/count"), true)
	end

	setText(findTF(arg_22_1, "rank/count"), tostring(arg_22_3))
	setText(findTF(arg_22_1, "score"), tostring(var_22_1))
	setActive(findTF(arg_22_1, "imgMy"), var_22_3)

	return
end

function var_0_0.UpdateSettlementUI(arg_23_0)
	GetComponent(findTF(arg_23_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_23_0 = arg_23_0._gameVo:GetScore()
	local var_23_1

	if arg_23_0._gameVo:GetConfig("game_room") > 0 then
		var_23_1 = getProxy(GameRoomProxy):getRoomScore(arg_23_0._gameVo:GetConfig("game_room"))
	else
		local var_23_2 = getProxy(MiniGameProxy):GetHighScore(arg_23_0._gameVo:GetGameId())

		var_23_1 = var_23_2 and #var_23_2 > 0 and var_23_2[1] or 0
	end

	setActive(findTF(arg_23_0.settlementUI, "ad/new"), var_23_1 < var_23_0)
	arg_23_0._event:emit(SimpleMGEvent.STORE_SERVER, {
		var_23_0,
		1
	})
	setText(findTF(arg_23_0.settlementUI, "ad/currentText"), var_23_0)
	setText(findTF(arg_23_0.settlementUI, "ad/currentText_1"), var_23_0)
	setText(findTF(arg_23_0.settlementUI, "ad/highText"), var_23_1)
	arg_23_0._event:emit(SimpleMGEvent.SUBMIT_GAME_SUCCESS, var_23_0)

	return
end

function var_0_0.BackPressed(arg_24_0)
	if isActive(arg_24_0.pauseUI) then
		arg_24_0:ResumeGame()
		arg_24_0._event:emit(SimpleMGEvent.PAUSE_GAME, false)
	elseif isActive(arg_24_0.leaveUI) then
		arg_24_0:ResumeGame()
		arg_24_0._event:emit(SimpleMGEvent.LEVEL_GAME, false)
	elseif not isActive(arg_24_0.pauseUI) and not isActive(arg_24_0.pauseUI) then
		if not arg_24_0._gameVo:IsSettlement() then
			arg_24_0:PopPauseUI()
			arg_24_0._event:emit(SimpleMGEvent.PAUSE_GAME, true)
		end
	else
		arg_24_0:ResumeGame()
	end

	return
end

function var_0_0.ResumeGame(arg_25_0)
	setActive(arg_25_0.leaveUI, false)
	setActive(arg_25_0.pauseUI, false)

	return
end

function var_0_0.UpdateGameUI(arg_26_0, arg_26_1)
	setText(arg_26_0.scoreTf, arg_26_1.scoreNum)
	setText(arg_26_0.gameTimeS, math.ceil(arg_26_1.gameTime))

	return
end

function var_0_0.ReadyStart(arg_27_0)
	arg_27_0:PopCountUI(true)
	arg_27_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SortGameConst.SFX_COUNT_DOWN)

	return
end

function var_0_0.ClearUI(arg_28_0)
	setActive(arg_28_0.settlementUI, false)
	setActive(arg_28_0.countUI, false)

	return
end

return var_0_0
