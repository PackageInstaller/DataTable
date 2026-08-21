local var_0_0 = class("WatermelonGamePopUI")

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
		arg_2_0._event:emit(WatermelonGameEvent.COUNT_DOWN)

		return
	end)

	return
end

function var_0_0.initLeavelUI(arg_5_0)
	arg_5_0.leaveUI = findTF(arg_5_0._tf, "pop/LeaveUI")

	GetComponent(findTF(arg_5_0.leaveUI, "ad/desc"), typeof(Image)):SetNativeSize()
	setActive(arg_5_0.leaveUI, false)
	onButton(arg_5_0._event, findTF(arg_5_0.leaveUI, "ad/btnOk"), function()
		arg_5_0:resumeGame()
		arg_5_0._event:emit(WatermelonGameEvent.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(arg_5_0._event, findTF(arg_5_0.leaveUI, "ad/btnCancel"), function()
		arg_5_0:resumeGame()
		arg_5_0._event:emit(WatermelonGameEvent.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initPauseUI(arg_8_0)
	arg_8_0.pauseUI = findTF(arg_8_0._tf, "pop/pauseUI")

	setActive(arg_8_0.pauseUI, false)
	GetComponent(findTF(arg_8_0.pauseUI, "ad/desc"), typeof(Image)):SetNativeSize()
	onButton(arg_8_0._event, findTF(arg_8_0.pauseUI, "ad/btnOk"), function()
		arg_8_0:resumeGame()
		arg_8_0._event:emit(WatermelonGameEvent.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initSettlementUI(arg_10_0)
	arg_10_0.settlementUI = findTF(arg_10_0._tf, "pop/SettleMentUI")

	GetComponent(findTF(arg_10_0.settlementUI, "ad/HighImg"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(arg_10_0.settlementUI, "ad/CurImg"), typeof(Image)):SetNativeSize()
	setActive(arg_10_0.settlementUI, false)
	onButton(arg_10_0._event, findTF(arg_10_0.settlementUI, "ad/btnOver"), function()
		arg_10_0:clearUI()
		arg_10_0._event:emit(WatermelonGameEvent.BACK_MENU)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initRankUI(arg_12_0)
	arg_12_0.rankUI = findTF(arg_12_0._tf, "pop/RankUI")

	arg_12_0:popRankUI(false)
	GetComponent(findTF(arg_12_0.rankUI, "ad/img/score"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(arg_12_0.rankUI, "ad/img/time"), typeof(Image)):SetNativeSize()

	arg_12_0._rankImg = findTF(arg_12_0.rankUI, "ad/img")
	arg_12_0._rankBtnClose = findTF(arg_12_0.rankUI, "ad/btnClose")
	arg_12_0._rankContent = findTF(arg_12_0.rankUI, "ad/list/content")
	arg_12_0._rankItemTpl = findTF(arg_12_0.rankUI, "ad/list/content/itemTpl")
	arg_12_0._rankEmpty = findTF(arg_12_0.rankUI, "ad/empty")
	arg_12_0._rankDesc = findTF(arg_12_0.rankUI, "ad/desc")
	arg_12_0._rankItems = {}

	setActive(arg_12_0._rankItemTpl, false)
	onButton(arg_12_0._event, findTF(arg_12_0.rankUI, "ad/close"), function()
		arg_12_0:popRankUI(false)

		return
	end, SFX_CANCEL)
	onButton(arg_12_0._event, arg_12_0._rankBtnClose, function()
		arg_12_0:popRankUI(false)

		return
	end, SFX_CANCEL)
	setText(arg_12_0._rankDesc, i18n(WatermelonGameConst.rank_tip))

	return
end

function var_0_0.updateRankData(arg_15_0, arg_15_1)
	for iter_15_0 = 1, #arg_15_1 do
		if iter_15_0 > #arg_15_0._rankItems then
			local var_15_1 = tf(instantiate(arg_15_0._rankItemTpl))

			setActive(var_15_1, false)
			setParent(var_15_1, arg_15_0._rankContent)
			table.insert(arg_15_0._rankItems, var_15_1)
		end

		local var_15_2 = arg_15_0._rankItems[iter_15_0]

		arg_15_0:setRankItemData(arg_15_0._rankItems[iter_15_0], arg_15_1[iter_15_0], iter_15_0)
		setActive(var_15_2, true)
	end

	for iter_15_1 = #arg_15_1 + 1, #arg_15_0._rankItems do
		setActive(arg_15_0._rankItems, false)
	end

	setActive(arg_15_0._rankEmpty, #arg_15_1 == 0)
	setActive(arg_15_0._rankImg, #arg_15_1 > 0)

	return
end

function var_0_0.setRankItemData(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_3 = getProxy(PlayerProxy):isSelf(arg_16_2.player_id)

	setText(findTF(arg_16_1, "nameText"), arg_16_2.name)
	arg_16_0:setChildVisible(findTF(arg_16_1, "bg"), false)
	arg_16_0:setChildVisible(findTF(arg_16_1, "rank"), false)

	if arg_16_3 <= 3 then
		setActive(findTF(arg_16_1, "bg/" .. arg_16_3), true)
		setActive(findTF(arg_16_1, "rank/" .. arg_16_3), true)
	elseif var_16_3 then
		setActive(findTF(arg_16_1, "bg/me"), true)
		setActive(findTF(arg_16_1, "rank/count"), true)
	else
		setActive(findTF(arg_16_1, "bg/other"), true)
		setActive(findTF(arg_16_1, "rank/count"), true)
	end

	setText(findTF(arg_16_1, "rank/count"), tostring(arg_16_3))
	setText(findTF(arg_16_1, "score"), tostring(var_16_1))
	setActive(findTF(arg_16_1, "imgMy"), var_16_3)

	return
end

function var_0_0.setChildVisible(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0 = 1, arg_17_1.childCount do
		setActive(arg_17_1:GetChild(iter_17_0 - 1), arg_17_2)
	end

	return
end

function var_0_0.initRankUI(arg_18_0)
	arg_18_0.rankUI = findTF(arg_18_0._tf, "pop/RankUI")

	arg_18_0:showRank(false)
	GetComponent(findTF(arg_18_0.rankUI, "ad/img/score"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(arg_18_0.rankUI, "ad/img/time"), typeof(Image)):SetNativeSize()

	arg_18_0._rankImg = findTF(arg_18_0.rankUI, "ad/img")
	arg_18_0._rankBtnClose = findTF(arg_18_0.rankUI, "ad/btnClose")
	arg_18_0._rankContent = findTF(arg_18_0.rankUI, "ad/list/content")
	arg_18_0._rankItemTpl = findTF(arg_18_0.rankUI, "ad/list/content/itemTpl")
	arg_18_0._rankEmpty = findTF(arg_18_0.rankUI, "ad/empty")
	arg_18_0._rankDesc = findTF(arg_18_0.rankUI, "ad/desc")
	arg_18_0._rankItems = {}

	setActive(arg_18_0._rankItemTpl, false)
	onButton(arg_18_0._event, findTF(arg_18_0.rankUI, "ad/close"), function()
		arg_18_0:showRank(false)

		return
	end, SFX_CANCEL)
	onButton(arg_18_0._event, arg_18_0._rankBtnClose, function()
		arg_18_0:showRank(false)

		return
	end, SFX_CANCEL)
	setText(arg_18_0._rankDesc, i18n(WatermelonGameConst.rank_tip))

	return
end

function var_0_0.showRank(arg_21_0, arg_21_1)
	setActive(arg_21_0.rankUI, arg_21_1)

	return
end

function var_0_0.updateSettlementUI(arg_22_0)
	GetComponent(findTF(arg_22_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_22_0 = arg_22_0._gameVo.scoreNum
	local var_22_1

	if arg_22_0._gameVo.mgData:getConfig("game_room") > 0 then
		var_22_1 = getProxy(GameRoomProxy):getRoomScore(arg_22_0._gameVo.mgData:getConfig("game_room"))
	else
		local var_22_2 = getProxy(MiniGameProxy):GetHighScore(arg_22_0._gameVo.gameId)

		var_22_1 = var_22_2 and #var_22_2 > 0 and var_22_2[1] or 0
	end

	setActive(findTF(arg_22_0.settlementUI, "ad/new"), var_22_1 < var_22_0)

	if var_22_0 > 0 and var_22_1 < var_22_0 then
		arg_22_0._event:emit(WatermelonGameEvent.STORE_SERVER, {
			var_22_0,
			1
		})
	end

	local var_22_3 = findTF(arg_22_0.settlementUI, "ad/highText")

	setText(findTF(arg_22_0.settlementUI, "ad/currentText"), var_22_0)
	setText(var_22_3, var_22_1)
	arg_22_0._event:emit(WatermelonGameEvent.SUBMIT_GAME_SUCCESS, var_22_0)

	return
end

function var_0_0.backPressed(arg_23_0)
	if isActive(arg_23_0.pauseUI) then
		arg_23_0:resumeGame()
		arg_23_0._event:emit(WatermelonGameEvent.PAUSE_GAME, false)
	elseif isActive(arg_23_0.leaveUI) then
		arg_23_0:resumeGame()
		arg_23_0._event:emit(WatermelonGameEvent.LEVEL_GAME, false)
	elseif not isActive(arg_23_0.pauseUI) and not isActive(arg_23_0.pauseUI) then
		if not arg_23_0._gameVo.startSettlement then
			arg_23_0:popPauseUI()
			arg_23_0._event:emit(WatermelonGameEvent.PAUSE_GAME, true)
		end
	else
		arg_23_0:resumeGame()
	end

	return
end

function var_0_0.resumeGame(arg_24_0)
	setActive(arg_24_0.leaveUI, false)
	setActive(arg_24_0.pauseUI, false)

	return
end

function var_0_0.popLeaveUI(arg_25_0)
	if isActive(arg_25_0.pauseUI) then
		setActive(arg_25_0.pauseUI, false)
	end

	setActive(arg_25_0.leaveUI, true)

	return
end

function var_0_0.popPauseUI(arg_26_0)
	if isActive(arg_26_0.leaveUI) then
		setActive(arg_26_0.leaveUI, false)
	end

	setActive(arg_26_0.pauseUI, true)

	return
end

function var_0_0.updateGameUI(arg_27_0, arg_27_1)
	setText(arg_27_0.scoreTf, arg_27_1.scoreNum)
	setText(arg_27_0.gameTimeS, math.ceil(arg_27_1.gameTime))

	return
end

function var_0_0.readyStart(arg_28_0)
	arg_28_0:popCountUI(true)
	arg_28_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(WatermelonGameConst.SFX_COUNT_DOWN)

	return
end

function var_0_0.popCountUI(arg_29_0, arg_29_1)
	setActive(arg_29_0.countUI, arg_29_1)

	return
end

function var_0_0.popSettlementUI(arg_30_0, arg_30_1)
	setActive(arg_30_0.settlementUI, arg_30_1)

	return
end

function var_0_0.popRankUI(arg_31_0, arg_31_1)
	setActive(arg_31_0.rankUI, arg_31_1)

	return
end

function var_0_0.clearUI(arg_32_0)
	setActive(arg_32_0.settlementUI, false)
	setActive(arg_32_0.countUI, false)

	return
end

return var_0_0
