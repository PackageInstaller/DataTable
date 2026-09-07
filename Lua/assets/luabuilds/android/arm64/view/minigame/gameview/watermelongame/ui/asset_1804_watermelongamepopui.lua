local WatermelonGamePopUI = class("WatermelonGamePopUI")

function WatermelonGamePopUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3

	self:initCountUI()
	self:initLeavelUI()
	self:initPauseUI()
	self:initSettlementUI()
	self:initRankUI()

	return
end

function WatermelonGamePopUI:initCountUI()
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		self._event:emit(WatermelonGameEvent.COUNT_DOWN)

		return
	end)

	return
end

function WatermelonGamePopUI:initLeavelUI()
	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	GetComponent(findTF(self.leaveUI, "ad/desc"), typeof(Image)):SetNativeSize()
	setActive(self.leaveUI, false)
	onButton(self._event, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self._event:emit(WatermelonGameEvent.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()
		self._event:emit(WatermelonGameEvent.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function WatermelonGamePopUI:initPauseUI()
	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	setActive(self.pauseUI, false)
	GetComponent(findTF(self.pauseUI, "ad/desc"), typeof(Image)):SetNativeSize()
	onButton(self._event, findTF(self.pauseUI, "ad/btnOk"), function()
		self:resumeGame()
		self._event:emit(WatermelonGameEvent.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function WatermelonGamePopUI:initSettlementUI()
	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	GetComponent(findTF(self.settlementUI, "ad/HighImg"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(self.settlementUI, "ad/CurImg"), typeof(Image)):SetNativeSize()
	setActive(self.settlementUI, false)
	onButton(self._event, findTF(self.settlementUI, "ad/btnOver"), function()
		self:clearUI()
		self._event:emit(WatermelonGameEvent.BACK_MENU)

		return
	end, SFX_CANCEL)

	return
end

function WatermelonGamePopUI:initRankUI()
	self.rankUI = findTF(self._tf, "pop/RankUI")

	self:popRankUI(false)
	GetComponent(findTF(self.rankUI, "ad/img/score"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(self.rankUI, "ad/img/time"), typeof(Image)):SetNativeSize()

	self._rankImg = findTF(self.rankUI, "ad/img")
	self._rankBtnClose = findTF(self.rankUI, "ad/btnClose")
	self._rankContent = findTF(self.rankUI, "ad/list/content")
	self._rankItemTpl = findTF(self.rankUI, "ad/list/content/itemTpl")
	self._rankEmpty = findTF(self.rankUI, "ad/empty")
	self._rankDesc = findTF(self.rankUI, "ad/desc")
	self._rankItems = {}

	setActive(self._rankItemTpl, false)
	onButton(self._event, findTF(self.rankUI, "ad/close"), function()
		self:popRankUI(false)

		return
	end, SFX_CANCEL)
	onButton(self._event, self._rankBtnClose, function()
		self:popRankUI(false)

		return
	end, SFX_CANCEL)
	setText(self._rankDesc, i18n(WatermelonGameConst.rank_tip))

	return
end

function WatermelonGamePopUI:updateRankData(arg_15_1)
	for iter_15_0 = 1, #arg_15_1 do
		if iter_15_0 > #self._rankItems then
			local var_15_1 = tf(instantiate(self._rankItemTpl))

			setActive(var_15_1, false)
			setParent(var_15_1, self._rankContent)
			table.insert(self._rankItems, var_15_1)
		end

		local var_15_2 = self._rankItems[iter_15_0]

		self:setRankItemData(self._rankItems[iter_15_0], arg_15_1[iter_15_0], iter_15_0)
		setActive(var_15_2, true)
	end

	for iter_15_1 = #arg_15_1 + 1, #self._rankItems do
		setActive(self._rankItems, false)
	end

	setActive(self._rankEmpty, #arg_15_1 == 0)
	setActive(self._rankImg, #arg_15_1 > 0)

	return
end

function WatermelonGamePopUI:setRankItemData(arg_16_1, arg_16_2, arg_16_3)
	local var_16_1 = arg_16_2.score
	local var_16_3 = getProxy(PlayerProxy):isSelf(arg_16_2.player_id)

	setText(findTF(arg_16_1, "nameText"), arg_16_2.name)
	self:setChildVisible(findTF(arg_16_1, "bg"), false)
	self:setChildVisible(findTF(arg_16_1, "rank"), false)

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

function WatermelonGamePopUI:setChildVisible(arg_17_1, arg_17_2)
	for iter_17_0 = 1, arg_17_1.childCount do
		setActive(arg_17_1:GetChild(iter_17_0 - 1), arg_17_2)
	end

	return
end

function WatermelonGamePopUI:initRankUI()
	self.rankUI = findTF(self._tf, "pop/RankUI")

	self:showRank(false)
	GetComponent(findTF(self.rankUI, "ad/img/score"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(self.rankUI, "ad/img/time"), typeof(Image)):SetNativeSize()

	self._rankImg = findTF(self.rankUI, "ad/img")
	self._rankBtnClose = findTF(self.rankUI, "ad/btnClose")
	self._rankContent = findTF(self.rankUI, "ad/list/content")
	self._rankItemTpl = findTF(self.rankUI, "ad/list/content/itemTpl")
	self._rankEmpty = findTF(self.rankUI, "ad/empty")
	self._rankDesc = findTF(self.rankUI, "ad/desc")
	self._rankItems = {}

	setActive(self._rankItemTpl, false)
	onButton(self._event, findTF(self.rankUI, "ad/close"), function()
		self:showRank(false)

		return
	end, SFX_CANCEL)
	onButton(self._event, self._rankBtnClose, function()
		self:showRank(false)

		return
	end, SFX_CANCEL)
	setText(self._rankDesc, i18n(WatermelonGameConst.rank_tip))

	return
end

function WatermelonGamePopUI:showRank(arg_21_1)
	setActive(self.rankUI, arg_21_1)

	return
end

function WatermelonGamePopUI:updateSettlementUI()
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_22_0 = self._gameVo.scoreNum
	local var_22_1

	if self._gameVo.mgData:getConfig("game_room") > 0 then
		var_22_1 = getProxy(GameRoomProxy):getRoomScore(self._gameVo.mgData:getConfig("game_room"))
	else
		local var_22_2 = getProxy(MiniGameProxy):GetHighScore(self._gameVo.gameId)

		var_22_1 = var_22_2 and #var_22_2 > 0 and var_22_2[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_22_1 < var_22_0)

	if var_22_0 > 0 and var_22_1 < var_22_0 then
		self._event:emit(WatermelonGameEvent.STORE_SERVER, {
			var_22_0,
			1
		})
	end

	local var_22_3 = findTF(self.settlementUI, "ad/highText")

	setText(findTF(self.settlementUI, "ad/currentText"), var_22_0)
	setText(var_22_3, var_22_1)
	self._event:emit(WatermelonGameEvent.SUBMIT_GAME_SUCCESS, var_22_0)

	return
end

function WatermelonGamePopUI:backPressed()
	if isActive(self.pauseUI) then
		self:resumeGame()
		self._event:emit(WatermelonGameEvent.PAUSE_GAME, false)
	elseif isActive(self.leaveUI) then
		self:resumeGame()
		self._event:emit(WatermelonGameEvent.LEVEL_GAME, false)
	elseif not isActive(self.pauseUI) and not isActive(self.pauseUI) then
		if not self._gameVo.startSettlement then
			self:popPauseUI()
			self._event:emit(WatermelonGameEvent.PAUSE_GAME, true)
		end
	else
		self:resumeGame()
	end

	return
end

function WatermelonGamePopUI:resumeGame()
	setActive(self.leaveUI, false)
	setActive(self.pauseUI, false)

	return
end

function WatermelonGamePopUI:popLeaveUI()
	if isActive(self.pauseUI) then
		setActive(self.pauseUI, false)
	end

	setActive(self.leaveUI, true)

	return
end

function WatermelonGamePopUI:popPauseUI()
	if isActive(self.leaveUI) then
		setActive(self.leaveUI, false)
	end

	setActive(self.pauseUI, true)

	return
end

function WatermelonGamePopUI:updateGameUI(arg_27_1)
	setText(self.scoreTf, arg_27_1.scoreNum)
	setText(self.gameTimeS, math.ceil(arg_27_1.gameTime))

	return
end

function WatermelonGamePopUI:readyStart()
	self:popCountUI(true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(WatermelonGameConst.SFX_COUNT_DOWN)

	return
end

function WatermelonGamePopUI:popCountUI(arg_29_1)
	setActive(self.countUI, arg_29_1)

	return
end

function WatermelonGamePopUI:popSettlementUI(arg_30_1)
	setActive(self.settlementUI, arg_30_1)

	return
end

function WatermelonGamePopUI:popRankUI(arg_31_1)
	setActive(self.rankUI, arg_31_1)

	return
end

function WatermelonGamePopUI:clearUI()
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)

	return
end

return WatermelonGamePopUI
