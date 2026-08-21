local var_0_0 = class("MusicBeatGamePopUI")
local var_0_1 = {
	"#E59C4B",
	"#56748D",
	"#AB7959"
}
local var_0_2 = "#8B8B8B"

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
		arg_2_0._event:emit(MusicBeatGameEvent.COUNT_DOWN)

		return
	end)

	return
end

function var_0_0.initLeavelUI(arg_5_0)
	arg_5_0.leaveUI = findTF(arg_5_0._tf, "pop/LeaveUI")

	setText(findTF(arg_5_0.leaveUI, "ad/btnCancel/text"), i18n("event_ui_giveup"))
	setText(findTF(arg_5_0.leaveUI, "ad/btnOk/text"), i18n("word_exist"))
	setText(findTF(arg_5_0.leaveUI, "ad/desc"), i18n("beat_game_exit_desc"))
	GetComponent(findTF(arg_5_0.leaveUI, "ad/img_2"), typeof(Image)):SetNativeSize()
	setText(findTF(arg_5_0.leaveUI, "ad/btnOk/text"), i18n("word_exist"))
	setText(findTF(arg_5_0.leaveUI, "ad/btnCancel/text"), i18n("word_cancel"))
	setActive(arg_5_0.leaveUI, false)
	onButton(arg_5_0._event, findTF(arg_5_0.leaveUI, "ad/btnOk"), function()
		arg_5_0:resumeGame()
		arg_5_0._event:emit(MusicBeatGameEvent.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(arg_5_0._event, findTF(arg_5_0.leaveUI, "ad/btnCancel"), function()
		arg_5_0:resumeGame()
		arg_5_0._event:emit(MusicBeatGameEvent.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initPauseUI(arg_8_0)
	arg_8_0.pauseUI = findTF(arg_8_0._tf, "pop/pauseUI")

	setActive(arg_8_0.pauseUI, false)
	GetComponent(findTF(arg_8_0.pauseUI, "ad/img_2"), typeof(Image)):SetNativeSize()
	setText(findTF(arg_8_0.pauseUI, "ad/btnOk/text"), i18n("child2_replay_continue"))
	onButton(arg_8_0._event, findTF(arg_8_0.pauseUI, "ad/btnOk"), function()
		arg_8_0:resumeGame()
		arg_8_0._event:emit(MusicBeatGameEvent.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initSettlementUI(arg_10_0)
	arg_10_0.settlementUI = findTF(arg_10_0._tf, "pop/SettleMentUI")

	setText(findTF(arg_10_0.settlementUI, "ad/btnOver/text"), i18n("ryza_task_confirm"))
	setText(findTF(arg_10_0.settlementUI, "ad/highScore"), i18n("beat_game_high_score"))
	setText(findTF(arg_10_0.settlementUI, "ad/currentScore"), i18n("beat_game_current_score"))
	setActive(arg_10_0.settlementUI, false)
	onButton(arg_10_0._event, findTF(arg_10_0.settlementUI, "ad/btnOver"), function()
		arg_10_0:clearUI()
		arg_10_0._event:emit(MusicBeatGameEvent.BACK_MENU)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initRankUI(arg_12_0)
	arg_12_0.rankUI = findTF(arg_12_0._tf, "pop/RankUI")

	arg_12_0:showRank(false)
	GetComponent(findTF(arg_12_0.rankUI, "ad/img/score"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(arg_12_0.rankUI, "ad/img/time"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(arg_12_0.rankUI, "ad/imgDesc"), typeof(Image)):SetNativeSize()

	arg_12_0._rankImg = findTF(arg_12_0.rankUI, "ad/img")
	arg_12_0._rankBtnClose = findTF(arg_12_0.rankUI, "ad/btnClose")
	arg_12_0._rankContent = findTF(arg_12_0.rankUI, "ad/list/content")
	arg_12_0._rankItemTpl = findTF(arg_12_0.rankUI, "ad/list/content/itemTpl")
	arg_12_0._rankEmpty = findTF(arg_12_0.rankUI, "ad/empty")
	arg_12_0._rankDesc = findTF(arg_12_0.rankUI, "ad/desc")
	arg_12_0._rankItems = {}
	arg_12_0.myRankItem = findTF(arg_12_0.rankUI, "ad/myRankItem")

	setActive(arg_12_0._rankItemTpl, false)
	onButton(arg_12_0._event, findTF(arg_12_0.rankUI, "ad/close"), function()
		arg_12_0:showRank(false)

		return
	end, SFX_CANCEL)
	onButton(arg_12_0._event, arg_12_0._rankBtnClose, function()
		arg_12_0:showRank(false)

		return
	end, SFX_CANCEL)
	setText(findTF(arg_12_0.rankUI, "ad/bg/title"), i18n("beat_game_rank"))
	setText(findTF(arg_12_0._rankItemTpl, "imgMy/text"), i18n("beat_game_my_record"))
	setText(findTF(arg_12_0.myRankItem, "imgMy/text"), i18n("beat_game_my_record"))

	return
end

function var_0_0.updateRankData(arg_15_0, arg_15_1)
	local var_15_0 = getProxy(PlayerProxy)
	local var_15_1 = var_15_0:getData()

	arg_15_0:setRankItemData(arg_15_0.myRankItem, {
		score = 0,
		player_id = var_15_0:getPlayerId(),
		name = var_15_0:getData().name
	}, 0)

	for iter_15_0 = 1, #arg_15_1 do
		if iter_15_0 > #arg_15_0._rankItems then
			local var_15_3 = tf(instantiate(arg_15_0._rankItemTpl))

			setActive(var_15_3, false)
			setParent(var_15_3, arg_15_0._rankContent)
			table.insert(arg_15_0._rankItems, var_15_3)
		end

		local var_15_4 = arg_15_0._rankItems[iter_15_0]
		local var_15_5 = getProxy(PlayerProxy)

		if var_15_5:isSelf(arg_15_1[iter_15_0].player_id) then
			arg_15_0:setRankItemData(arg_15_0.myRankItem, arg_15_1[iter_15_0], iter_15_0)
		end

		arg_15_0:setRankItemData(var_15_4, arg_15_1[iter_15_0], iter_15_0)
		setActive(var_15_4, true)
	end

	for iter_15_1 = #arg_15_1 + 1, #arg_15_0._rankItems do
		setActive(arg_15_0._rankItems, false)
	end

	setActive(arg_15_0._rankEmpty, #arg_15_1 == 0)
	setActive(arg_15_0._rankImg, #arg_15_1 > 0)

	return
end

function var_0_0.setRankItemData(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_2 = getProxy(PlayerProxy):isSelf(arg_16_2.player_id)

	setText(findTF(arg_16_1, "nameText"), arg_16_2.name)
	arg_16_0:setChildVisible(findTF(arg_16_1, "bg"), false)
	arg_16_0:setChildVisible(findTF(arg_16_1, "rank"), false)

	if arg_16_3 > 0 and arg_16_3 <= 3 then
		setActive(findTF(arg_16_1, "bg/" .. arg_16_3), true)
		setActive(findTF(arg_16_1, "rank/" .. arg_16_3), true)
		setText(findTF(arg_16_1, "score"), setColorStr(arg_16_2.score, var_0_1[arg_16_3]))
	elseif var_16_2 then
		setActive(findTF(arg_16_1, "bg/me"), true)
		setActive(findTF(arg_16_1, "rank/count"), true)
		setText(findTF(arg_16_1, "score"), setColorStr(arg_16_2.score, var_0_2))
	else
		setActive(findTF(arg_16_1, "bg/other"), true)
		setActive(findTF(arg_16_1, "rank/count"), true)
		setText(findTF(arg_16_1, "score"), setColorStr(arg_16_2.score, var_0_2))
	end

	setText(findTF(arg_16_1, "rank/count"), tostring(arg_16_3))
	setActive(findTF(arg_16_1, "imgMy"), var_16_2)

	return
end

function var_0_0.setChildVisible(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0 = 1, arg_17_1.childCount do
		setActive(arg_17_1:GetChild(iter_17_0 - 1), arg_17_2)
	end

	return
end

function var_0_0.showRank(arg_18_0, arg_18_1)
	setActive(arg_18_0.rankUI, arg_18_1)

	return
end

function var_0_0.updateSettlementUI(arg_19_0)
	GetComponent(findTF(arg_19_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_19_0 = arg_19_0._gameVo.scoreNum
	local var_19_1 = getProxy(MiniGameProxy):GetHighScore(arg_19_0._gameVo.gameId)

	if var_19_1 and #var_19_1 > 0 then
		local var_19_2 = var_19_1[1] or 0

		setActive(findTF(arg_19_0.settlementUI, "ad/new"), var_19_2 < var_19_0)

		if var_19_0 > 0 and var_19_2 < var_19_0 then
			arg_19_0._event:emit(MusicBeatGameEvent.STORE_SERVER, {
				var_19_0,
				1
			})
		end

		local var_19_3 = findTF(arg_19_0.settlementUI, "ad/highText")

		setText(findTF(arg_19_0.settlementUI, "ad/currentText"), var_19_0)
		setText(var_19_3, var_19_2 < var_19_0 and var_19_0 or var_19_2)
		arg_19_0._event:emit(MusicBeatGameEvent.SUBMIT_GAME_SUCCESS)

		return
	end
end

function var_0_0.backPressed(arg_20_0)
	if isActive(arg_20_0.pauseUI) then
		arg_20_0:resumeGame()
		arg_20_0._event:emit(MusicBeatGameEvent.PAUSE_GAME, false)
	elseif isActive(arg_20_0.leaveUI) then
		arg_20_0:resumeGame()
		arg_20_0._event:emit(MusicBeatGameEvent.LEVEL_GAME, false)
	elseif not isActive(arg_20_0.pauseUI) and not isActive(arg_20_0.pauseUI) then
		if not arg_20_0._gameVo.startSettlement then
			arg_20_0:popPauseUI()
			arg_20_0._event:emit(MusicBeatGameEvent.PAUSE_GAME, true)
		end
	else
		arg_20_0:resumeGame()
	end

	return
end

function var_0_0.resumeGame(arg_21_0)
	setActive(arg_21_0.leaveUI, false)
	setActive(arg_21_0.pauseUI, false)

	return
end

function var_0_0.popLeaveUI(arg_22_0)
	if isActive(arg_22_0.pauseUI) then
		setActive(arg_22_0.pauseUI, false)
	end

	setActive(arg_22_0.leaveUI, true)

	return
end

function var_0_0.popPauseUI(arg_23_0)
	if isActive(arg_23_0.leaveUI) then
		setActive(arg_23_0.leaveUI, false)
	end

	setActive(arg_23_0.pauseUI, true)

	return
end

function var_0_0.updateGameUI(arg_24_0, arg_24_1)
	setText(arg_24_0.scoreTf, arg_24_1.scoreNum)
	setText(arg_24_0.gameTimeS, math.ceil(arg_24_1.gameTime))

	return
end

function var_0_0.readyStart(arg_25_0)
	arg_25_0:popCountUI(true)
	arg_25_0.countAnimator:Play("count")

	return
end

function var_0_0.popCountUI(arg_26_0, arg_26_1)
	setActive(arg_26_0.countUI, arg_26_1)

	return
end

function var_0_0.popSettlementUI(arg_27_0, arg_27_1)
	setActive(arg_27_0.settlementUI, arg_27_1)

	return
end

function var_0_0.popRankUI(arg_28_0, arg_28_1)
	setActive(arg_28_0.rankUI, arg_28_1)

	return
end

function var_0_0.clearUI(arg_29_0)
	setActive(arg_29_0.settlementUI, false)
	setActive(arg_29_0.countUI, false)

	return
end

return var_0_0
