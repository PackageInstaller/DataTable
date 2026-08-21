local var_0_0 = class("BoatAdGamePopUI")
local var_0_1
local var_0_2

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._tf = arg_1_1
	arg_1_0._event = arg_1_2
	var_0_1 = BoatAdGameVo

	arg_1_0:initCountUI()
	arg_1_0:initLeavelUI()
	arg_1_0:initPauseUI()
	arg_1_0:initSettlementUI()
	arg_1_0:initAdWindow()

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

	GetComponent(findTF(arg_5_0.leaveUI, "ad/desc"), typeof(Image)):SetNativeSize()
	setActive(arg_5_0.leaveUI, false)
	onButton(arg_5_0._event, findTF(arg_5_0.leaveUI, "ad/btnOk"), function()
		arg_5_0:resumeGame()
		arg_5_0._event:emit(SimpleMGEvent.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(arg_5_0._event, findTF(arg_5_0.leaveUI, "ad/btnCancel"), function()
		arg_5_0:resumeGame()
		arg_5_0._event:emit(SimpleMGEvent.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initPauseUI(arg_8_0)
	arg_8_0.pauseUI = findTF(arg_8_0._tf, "pop/pauseUI")

	GetComponent(findTF(arg_8_0.pauseUI, "ad/desc"), typeof(Image)):SetNativeSize()
	setActive(arg_8_0.pauseUI, false)
	onButton(arg_8_0._event, findTF(arg_8_0.pauseUI, "ad/btnOk"), function()
		arg_8_0:resumeGame()
		arg_8_0._event:emit(SimpleMGEvent.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initSettlementUI(arg_10_0)
	arg_10_0.settlementUI = findTF(arg_10_0._tf, "pop/SettleMentUI")

	setActive(arg_10_0.settlementUI, false)
	onButton(arg_10_0._event, findTF(arg_10_0.settlementUI, "ad/btnOver"), function()
		arg_10_0:clearUI()
		arg_10_0._event:emit(SimpleMGEvent.BACK_MENU)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.initAdWindow(arg_12_0)
	arg_12_0.adUI = findTF(arg_12_0._tf, "pop/AdUI")

	setActive(arg_12_0.adUI, false)

	arg_12_0.mvContent = findTF(arg_12_0.adUI, "ad/movie/view/content")
	arg_12_0.btnPlay = findTF(arg_12_0.adUI, "ad/movie/btnPlay")
	arg_12_0.btnStop = findTF(arg_12_0.adUI, "ad/movie/btnStop")
	arg_12_0.btnRepeat = findTF(arg_12_0.adUI, "ad/movie/btnRepeat")

	setActive(arg_12_0.btnRepeat, false)
	onButton(arg_12_0._event, findTF(arg_12_0.adUI, "ad/bottom"), function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 3 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if arg_12_0.isLoading then
			return
		end

		setActive(arg_12_0.adUI, false)
		arg_12_0:clearMovie()
		arg_12_0._event:emit(BoatAdGameEvent.CLOSE_AD_UI)

		return
	end, SFX_CANCEL)
	onButton(arg_12_0._event, findTF(arg_12_0.adUI, "ad/bgClose"), function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 3 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if arg_12_0.isLoading then
			return
		end

		setActive(arg_12_0.adUI, false)
		arg_12_0:clearMovie()
		arg_12_0._event:emit(BoatAdGameEvent.CLOSE_AD_UI)

		return
	end, SFX_CANCEL)
	onButton(arg_12_0._event, arg_12_0.btnRepeat, function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 3 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if arg_12_0.mvManaCpkUI and arg_12_0.mvCompleteFlag then
			arg_12_0:loadMv()
		end

		return
	end)

	return
end

function var_0_0.clearMovie(arg_16_0)
	if arg_16_0.mvGo then
		arg_16_0.mvManaCpkUI:SetPlayEndHandler(nil)
		arg_16_0.mvManaCpkUI:StopCpk()
		destroy(arg_16_0.mvGo)

		arg_16_0.mvManaCpkUI = nil
		arg_16_0.mvGo = nil
		arg_16_0.mvName = nil
	end

	return
end

function var_0_0.loadMv(arg_17_0)
	arg_17_0:clearMovie()

	if arg_17_0.isLoading then
		return
	end

	local var_17_0 = "BoatAdMvUI"

	arg_17_0.isLoading = true
	arg_17_0.mvCompleteFlag = false

	setActive(arg_17_0.btnPlay, false)
	setActive(arg_17_0.btnStop, false)
	setActive(arg_17_0.btnRepeat, false)
	PoolMgr.GetInstance():GetUI(var_17_0, true, function(arg_18_0)
		arg_17_0.mvGo = arg_18_0
		arg_17_0.mvName = var_17_0
		arg_17_0.mvManaCpkUI = GetComponent(findTF(arg_17_0.mvGo, "video/cpk"), typeof(CriManaCpkUI))

		arg_17_0.mvManaCpkUI:SetPlayEndHandler(System.Action(function()
			arg_17_0:mvComplete()

			return
		end))
		arg_17_0.mvManaCpkUI:PlayCpk()

		local var_18_0 = PlayerPrefs.GetFloat("bgm_vol", DEFAULT_BGMVOLUME) or 1

		arg_17_0.mvManaCpkUI.player:SetVolume(var_18_0)

		if arg_17_0.isLoading == false then
			arg_17_0:clearMovie()
		else
			arg_17_0.isLoading = false

			setParent(arg_17_0.mvGo, arg_17_0.mvContent)
			setActive(arg_17_0.mvGo, true)
		end

		return
	end)

	return
end

function var_0_0.mvComplete(arg_20_0)
	arg_20_0.mvCompleteFlag = true

	arg_20_0:onPlayerEnd()

	return
end

function var_0_0.onPlayerEnd(arg_21_0)
	setActive(arg_21_0.btnPlay, false)
	setActive(arg_21_0.btnStop, false)
	setActive(arg_21_0.btnRepeat, true)

	return
end

function var_0_0.onPlayerStop(arg_22_0)
	setActive(arg_22_0.btnPlay, true)
	setActive(arg_22_0.btnStop, false)
	setActive(arg_22_0.btnRepeat, false)

	return
end

function var_0_0.onPlayerStart(arg_23_0)
	setActive(arg_23_0.btnPlay, false)
	setActive(arg_23_0.btnStop, true)
	setActive(arg_23_0.btnRepeat, false)

	return
end

function var_0_0.oepnAd(arg_24_0)
	setActive(arg_24_0.adUI, true)

	var_0_2 = Time.realtimeSinceStartup

	arg_24_0:loadMv()

	return
end

function var_0_0.updateSettlementUI(arg_25_0)
	GetComponent(findTF(arg_25_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_25_0 = var_0_1.scoreNum
	local var_25_1

	if var_0_1.GetMiniGameData():getConfig("game_room") > 0 then
		var_25_1 = getProxy(GameRoomProxy):getRoomScore(var_0_1.GetMiniGameData():getConfig("game_room"))
	else
		local var_25_2 = var_0_1.GetMiniGameData():GetRuntimeData("elements")

		var_25_1 = var_25_2 and #var_25_2 > 0 and var_25_2[1] or 0
	end

	setActive(findTF(arg_25_0.settlementUI, "ad/new"), var_25_1 < var_25_0)

	if var_25_1 < var_25_0 then
		var_25_1 = var_25_0

		arg_25_0._event:emit(SimpleMGEvent.STORE_SERVER, var_25_0)
	end

	setText(findTF(arg_25_0.settlementUI, "ad/highText"), var_25_1)
	setText(findTF(arg_25_0.settlementUI, "ad/currentText"), var_25_0)
	arg_25_0._event:emit(SimpleMGEvent.SUBMIT_GAME_SUCCESS, var_25_0)

	return
end

function var_0_0.backPressed(arg_26_0)
	if isActive(arg_26_0.pauseUI) then
		arg_26_0:resumeGame()
		arg_26_0._event:emit(SimpleMGEvent.PAUSE_GAME, false)
	elseif isActive(arg_26_0.leaveUI) then
		arg_26_0:resumeGame()
		arg_26_0._event:emit(SimpleMGEvent.LEVEL_GAME, false)
	elseif not isActive(arg_26_0.pauseUI) and not isActive(arg_26_0.pauseUI) then
		arg_26_0:popPauseUI()
		arg_26_0._event:emit(SimpleMGEvent.PAUSE_GAME, true)
	else
		arg_26_0:resumeGame()
	end

	return
end

function var_0_0.resumeGame(arg_27_0)
	setActive(arg_27_0.leaveUI, false)
	setActive(arg_27_0.pauseUI, false)

	return
end

function var_0_0.popLeaveUI(arg_28_0)
	if isActive(arg_28_0.pauseUI) then
		setActive(arg_28_0.pauseUI, false)
	end

	setActive(arg_28_0.leaveUI, true)

	return
end

function var_0_0.popPauseUI(arg_29_0)
	if isActive(arg_29_0.leaveUI) then
		setActive(arg_29_0.leaveUI, false)
	end

	setActive(arg_29_0.pauseUI, true)

	return
end

function var_0_0.updateGameUI(arg_30_0, arg_30_1)
	setText(arg_30_0.scoreTf, arg_30_1.scoreNum)
	setText(arg_30_0.gameTimeS, math.ceil(arg_30_1.gameTime))

	return
end

function var_0_0.readyStart(arg_31_0)
	arg_31_0:popCountUI(true)
	arg_31_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_COUNT_DOWN)

	return
end

function var_0_0.popCountUI(arg_32_0, arg_32_1)
	setActive(arg_32_0.countUI, arg_32_1)

	return
end

function var_0_0.popSettlementUI(arg_33_0, arg_33_1)
	setActive(arg_33_0.settlementUI, arg_33_1)

	return
end

function var_0_0.clearUI(arg_34_0)
	setActive(arg_34_0.settlementUI, false)
	setActive(arg_34_0.countUI, false)

	return
end

return var_0_0
