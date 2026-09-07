local SortGamePopUI = class("SortGamePopUI")

function SortGamePopUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
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

function SortGamePopUI:initCountUI()
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		self._event:emit(SimpleMGEvent.COUNT_DOWN)

		return
	end)

	return
end

function SortGamePopUI:initLeavelUI()
	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	setText(findTF(self.leaveUI, "ad/desc"), i18n("mini_game_leave"))
	setText(findTF(self.leaveUI, "ad/btnConfirmDesc"), i18n("ryza_task_confirm"))
	setText(findTF(self.leaveUI, "ad/btnCancelDesc"), i18n("ryza_task_cancel"))
	setActive(self.leaveUI, false)
	onButton(self._event, findTF(self.leaveUI, "ad/btnConfirm"), function()
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function SortGamePopUI:initPauseUI()
	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	setActive(self.pauseUI, false)
	setText(findTF(self.pauseUI, "ad/desc"), i18n("mini_game_pause"))
	setText(findTF(self.pauseUI, "ad/btnDesc"), i18n("mini_game_continue"))
	onButton(self._event, findTF(self.pauseUI, "ad/btnOk"), function()
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function SortGamePopUI:initSettlementUI()
	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	setText(findTF(self.settlementUI, "ad/btnOver/text"), i18n("mini_game_over_game"))
	setText(findTF(self.settlementUI, "ad/HighDesc"), i18n("mini_game_high_score"))
	setText(findTF(self.settlementUI, "ad/CurDesc"), i18n("mini_game_cur_score"))
	setActive(self.settlementUI, false)
	onButton(self._event, findTF(self.settlementUI, "ad/btnOver"), function()
		self:ClearUI()
		self._event:emit(SimpleMGEvent.BACK_MENU)

		return
	end, SFX_CANCEL)

	return
end

function SortGamePopUI:initRankUI()
	self.rankUI = findTF(self._tf, "pop/RankUI")

	self:PopRankUI(false)

	self._rankImg = findTF(self.rankUI, "ad/img")
	self._rankBtnClose = findTF(self.rankUI, "ad/btnClose")
	self._rankContent = findTF(self.rankUI, "ad/list/content")
	self._rankItemTpl = findTF(self.rankUI, "ad/list/content/itemTpl")
	self._rankEmpty = findTF(self.rankUI, "ad/empty")
	self._rankDesc = findTF(self.rankUI, "ad/desc")
	self._rankItems = {}

	setActive(self._rankItemTpl, false)
	onButton(self._event, findTF(self.rankUI, "ad/close"), function()
		self:PopRankUI(false)

		return
	end, SFX_CANCEL)
	onButton(self._event, self._rankBtnClose, function()
		self:PopRankUI(false)

		return
	end, SFX_CANCEL)

	return
end

function SortGamePopUI:setChildVisible(arg_15_1, arg_15_2)
	for iter_15_0 = 1, arg_15_1.childCount do
		setActive(arg_15_1:GetChild(iter_15_0 - 1), arg_15_2)
	end

	return
end

function SortGamePopUI:PopPauseUI()
	if isActive(self.leaveUI) then
		setActive(self.leaveUI, false)
	end

	setActive(self.pauseUI, true)

	return
end

function SortGamePopUI:PopCountUI(arg_17_1)
	setActive(self.countUI, arg_17_1)

	return
end

function SortGamePopUI:PopSettlementUI(arg_18_1)
	setActive(self.settlementUI, arg_18_1)

	return
end

function SortGamePopUI:PopRankUI(arg_19_1)
	setActive(self.rankUI, arg_19_1)

	return
end

function SortGamePopUI:PopLeaveUI()
	if isActive(self.pauseUI) then
		setActive(self.pauseUI, false)
	end

	setActive(self.leaveUI, true)

	return
end

function SortGamePopUI:UpdateRankData(arg_21_1)
	for iter_21_0 = 1, #arg_21_1 do
		if iter_21_0 > #self._rankItems then
			local var_21_1 = tf(instantiate(self._rankItemTpl))

			setActive(var_21_1, false)
			setParent(var_21_1, self._rankContent)
			table.insert(self._rankItems, var_21_1)
		end

		local var_21_2 = self._rankItems[iter_21_0]

		self:SetRankItemData(self._rankItems[iter_21_0], arg_21_1[iter_21_0], iter_21_0)
		setActive(var_21_2, true)
	end

	for iter_21_1 = #arg_21_1 + 1, #self._rankItems do
		setActive(self._rankItems, false)
	end

	setActive(self._rankEmpty, #arg_21_1 == 0)
	setActive(self._rankImg, #arg_21_1 > 0)

	return
end

function SortGamePopUI:SetRankItemData(arg_22_1, arg_22_2, arg_22_3)
	local var_22_1 = arg_22_2.score
	local var_22_3 = getProxy(PlayerProxy):isSelf(arg_22_2.player_id)

	setText(findTF(arg_22_1, "nameText"), arg_22_2.name)
	self:setChildVisible(findTF(arg_22_1, "bg"), false)
	self:setChildVisible(findTF(arg_22_1, "rank"), false)

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

function SortGamePopUI:UpdateSettlementUI()
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_23_0 = self._gameVo:GetScore()
	local var_23_1

	if self._gameVo:GetConfig("game_room") > 0 then
		var_23_1 = getProxy(GameRoomProxy):getRoomScore(self._gameVo:GetConfig("game_room"))
	else
		local var_23_2 = getProxy(MiniGameProxy):GetHighScore(self._gameVo:GetGameId())

		var_23_1 = var_23_2 and #var_23_2 > 0 and var_23_2[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_23_1 < var_23_0)
	self._event:emit(SimpleMGEvent.STORE_SERVER, {
		var_23_0,
		1
	})
	setText(findTF(self.settlementUI, "ad/currentText"), var_23_0)
	setText(findTF(self.settlementUI, "ad/currentText_1"), var_23_0)
	setText(findTF(self.settlementUI, "ad/highText"), var_23_1)
	self._event:emit(SimpleMGEvent.SUBMIT_GAME_SUCCESS, var_23_0)

	return
end

function SortGamePopUI:BackPressed()
	if isActive(self.pauseUI) then
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.PAUSE_GAME, false)
	elseif isActive(self.leaveUI) then
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.LEVEL_GAME, false)
	elseif not isActive(self.pauseUI) and not isActive(self.pauseUI) then
		if not self._gameVo:IsSettlement() then
			self:PopPauseUI()
			self._event:emit(SimpleMGEvent.PAUSE_GAME, true)
		end
	else
		self:ResumeGame()
	end

	return
end

function SortGamePopUI:ResumeGame()
	setActive(self.leaveUI, false)
	setActive(self.pauseUI, false)

	return
end

function SortGamePopUI:UpdateGameUI(arg_26_1)
	setText(self.scoreTf, arg_26_1.scoreNum)
	setText(self.gameTimeS, math.ceil(arg_26_1.gameTime))

	return
end

function SortGamePopUI:ReadyStart()
	self:PopCountUI(true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SortGameConst.SFX_COUNT_DOWN)

	return
end

function SortGamePopUI:ClearUI()
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)

	return
end

return SortGamePopUI
