local PipeGamePopUI = class("PipeGamePopUI")
local var_0_1

function PipeGamePopUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	var_0_1 = PipeGameVo

	self:initCountUI()
	self:initLeavelUI()
	self:initPauseUI()
	self:initSettlementUI()
	self:initRankUI()

	return
end

function PipeGamePopUI:initCountUI()
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		self._event:emit(PipeGameEvent.COUNT_DOWN)

		return
	end)

	return
end

function PipeGamePopUI:initLeavelUI()
	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	GetComponent(findTF(self.leaveUI, "ad/desc"), typeof(Image)):SetNativeSize()
	setActive(self.leaveUI, false)
	onButton(self._event, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self._event:emit(PipeGameEvent.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()
		self._event:emit(PipeGameEvent.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function PipeGamePopUI:initPauseUI()
	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	setActive(self.pauseUI, false)
	GetComponent(findTF(self.pauseUI, "ad/desc"), typeof(Image)):SetNativeSize()
	onButton(self._event, findTF(self.pauseUI, "ad/btnOk"), function()
		self:resumeGame()
		self._event:emit(PipeGameEvent.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function PipeGamePopUI:initSettlementUI()
	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	GetComponent(findTF(self.settlementUI, "ad/HighImg"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(self.settlementUI, "ad/CurImg"), typeof(Image)):SetNativeSize()
	setActive(self.settlementUI, false)
	onButton(self._event, findTF(self.settlementUI, "ad/btnOver"), function()
		self:clearUI()
		self._event:emit(PipeGameEvent.BACK_MENU)

		return
	end, SFX_CANCEL)

	return
end

function PipeGamePopUI:initRankUI()
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
	setText(self._rankDesc, i18n(var_0_1.rank_tip))

	return
end

function PipeGamePopUI:updateRankData(arg_15_1)
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

function PipeGamePopUI:setRankItemData(arg_16_1, arg_16_2, arg_16_3)
	local var_16_1 = arg_16_2.score
	local var_16_2 = arg_16_2.time_data
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
	setText(findTF(arg_16_1, "time"), tostring(var_16_2))
	setActive(findTF(arg_16_1, "imgMy"), var_16_3)

	return
end

function PipeGamePopUI:setChildVisible(arg_17_1, arg_17_2)
	for iter_17_0 = 1, arg_17_1.childCount do
		setActive(arg_17_1:GetChild(iter_17_0 - 1), arg_17_2)
	end

	return
end

function PipeGamePopUI:showRank(arg_18_1)
	setActive(self.rankUI, arg_18_1)

	return
end

function PipeGamePopUI:updateSettlementUI()
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_19_0 = var_0_1.scoreNum
	local var_19_1 = math.floor(var_0_1.gameDragTime)
	local var_19_2 = getProxy(MiniGameProxy):GetHighScore(var_0_1.game_id)
	local var_19_3

	if var_19_2 and #var_19_2 > 0 then
		var_19_3 = var_19_2[1] or 0

		local var_19_4

		if var_19_2 and #var_19_2 > 1 then
			var_19_4 = var_19_2[2] or 0
		end
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_19_3 < var_19_0)

	if var_19_0 > 0 and var_19_3 < var_19_0 then
		self._event:emit(PipeGameEvent.STORE_SERVER, {
			var_19_0,
			var_19_1
		})
	elseif var_19_0 > 0 and var_19_0 == var_19_3 and var_19_4 < var_19_1 then
		self._event:emit(PipeGameEvent.STORE_SERVER, {
			var_19_0,
			var_19_1
		})
	end

	local var_19_5 = findTF(self.settlementUI, "ad/highText")

	setText(findTF(self.settlementUI, "ad/currentText"), var_19_0)
	setText(var_19_5, var_19_1)
	self._event:emit(PipeGameEvent.SUBMIT_GAME_SUCCESS)

	return
end

function PipeGamePopUI:backPressed()
	if isActive(self.pauseUI) then
		self:resumeGame()
		self._event:emit(PipeGameEvent.PAUSE_GAME, false)
	elseif isActive(self.leaveUI) then
		self:resumeGame()
		self._event:emit(PipeGameEvent.LEVEL_GAME, false)
	elseif not isActive(self.pauseUI) and not isActive(self.pauseUI) then
		if not var_0_1.startSettlement then
			self:popPauseUI()
			self._event:emit(PipeGameEvent.PAUSE_GAME, true)
		end
	else
		self:resumeGame()
	end

	return
end

function PipeGamePopUI:resumeGame()
	setActive(self.leaveUI, false)
	setActive(self.pauseUI, false)

	return
end

function PipeGamePopUI:popLeaveUI()
	if isActive(self.pauseUI) then
		setActive(self.pauseUI, false)
	end

	setActive(self.leaveUI, true)

	return
end

function PipeGamePopUI:popPauseUI()
	if isActive(self.leaveUI) then
		setActive(self.leaveUI, false)
	end

	setActive(self.pauseUI, true)

	return
end

function PipeGamePopUI:updateGameUI(arg_24_1)
	setText(self.scoreTf, arg_24_1.scoreNum)
	setText(self.gameTimeS, math.ceil(arg_24_1.gameTime))

	return
end

function PipeGamePopUI:readyStart()
	self:popCountUI(true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_COUNT_DOWN)

	return
end

function PipeGamePopUI:popCountUI(arg_26_1)
	setActive(self.countUI, arg_26_1)

	return
end

function PipeGamePopUI:popSettlementUI(arg_27_1)
	setActive(self.settlementUI, arg_27_1)

	return
end

function PipeGamePopUI:clearUI()
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)

	return
end

return PipeGamePopUI
