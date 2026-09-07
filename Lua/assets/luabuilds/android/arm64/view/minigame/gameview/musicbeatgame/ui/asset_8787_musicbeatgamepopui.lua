local MusicBeatGamePopUI = class("MusicBeatGamePopUI")
local var_0_1 = {
	"#E59C4B",
	"#56748D",
	"#AB7959"
}
local var_0_2 = "#8B8B8B"

function MusicBeatGamePopUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
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

function MusicBeatGamePopUI:initCountUI()
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		self._event:emit(MusicBeatGameEvent.COUNT_DOWN)

		return
	end)

	return
end

function MusicBeatGamePopUI:initLeavelUI()
	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	setText(findTF(self.leaveUI, "ad/btnCancel/text"), i18n("event_ui_giveup"))
	setText(findTF(self.leaveUI, "ad/btnOk/text"), i18n("word_exist"))
	setText(findTF(self.leaveUI, "ad/desc"), i18n("beat_game_exit_desc"))
	GetComponent(findTF(self.leaveUI, "ad/img_2"), typeof(Image)):SetNativeSize()
	setText(findTF(self.leaveUI, "ad/btnOk/text"), i18n("word_exist"))
	setText(findTF(self.leaveUI, "ad/btnCancel/text"), i18n("word_cancel"))
	setActive(self.leaveUI, false)
	onButton(self._event, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self._event:emit(MusicBeatGameEvent.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()
		self._event:emit(MusicBeatGameEvent.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function MusicBeatGamePopUI:initPauseUI()
	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	setActive(self.pauseUI, false)
	GetComponent(findTF(self.pauseUI, "ad/img_2"), typeof(Image)):SetNativeSize()
	setText(findTF(self.pauseUI, "ad/btnOk/text"), i18n("child2_replay_continue"))
	onButton(self._event, findTF(self.pauseUI, "ad/btnOk"), function()
		self:resumeGame()
		self._event:emit(MusicBeatGameEvent.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function MusicBeatGamePopUI:initSettlementUI()
	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	setText(findTF(self.settlementUI, "ad/btnOver/text"), i18n("ryza_task_confirm"))
	setText(findTF(self.settlementUI, "ad/highScore"), i18n("beat_game_high_score"))
	setText(findTF(self.settlementUI, "ad/currentScore"), i18n("beat_game_current_score"))
	setActive(self.settlementUI, false)
	onButton(self._event, findTF(self.settlementUI, "ad/btnOver"), function()
		self:clearUI()
		self._event:emit(MusicBeatGameEvent.BACK_MENU)

		return
	end, SFX_CANCEL)

	return
end

function MusicBeatGamePopUI:initRankUI()
	self.rankUI = findTF(self._tf, "pop/RankUI")

	self:showRank(false)
	GetComponent(findTF(self.rankUI, "ad/img/score"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(self.rankUI, "ad/img/time"), typeof(Image)):SetNativeSize()
	GetComponent(findTF(self.rankUI, "ad/imgDesc"), typeof(Image)):SetNativeSize()

	self._rankImg = findTF(self.rankUI, "ad/img")
	self._rankBtnClose = findTF(self.rankUI, "ad/btnClose")
	self._rankContent = findTF(self.rankUI, "ad/list/content")
	self._rankItemTpl = findTF(self.rankUI, "ad/list/content/itemTpl")
	self._rankEmpty = findTF(self.rankUI, "ad/empty")
	self._rankDesc = findTF(self.rankUI, "ad/desc")
	self._rankItems = {}
	self.myRankItem = findTF(self.rankUI, "ad/myRankItem")

	setActive(self._rankItemTpl, false)
	onButton(self._event, findTF(self.rankUI, "ad/close"), function()
		self:showRank(false)

		return
	end, SFX_CANCEL)
	onButton(self._event, self._rankBtnClose, function()
		self:showRank(false)

		return
	end, SFX_CANCEL)
	setText(findTF(self.rankUI, "ad/bg/title"), i18n("beat_game_rank"))
	setText(findTF(self._rankItemTpl, "imgMy/text"), i18n("beat_game_my_record"))
	setText(findTF(self.myRankItem, "imgMy/text"), i18n("beat_game_my_record"))

	return
end

function MusicBeatGamePopUI:updateRankData(arg_15_1)
	local var_15_0 = getProxy(PlayerProxy)
	local var_15_1 = var_15_0:getData()

	self:setRankItemData(self.myRankItem, {
		score = 0,
		player_id = var_15_0:getPlayerId(),
		name = var_15_0:getData().name
	}, 0)

	for iter_15_0 = 1, #arg_15_1 do
		if iter_15_0 > #self._rankItems then
			local var_15_3 = tf(instantiate(self._rankItemTpl))

			setActive(var_15_3, false)
			setParent(var_15_3, self._rankContent)
			table.insert(self._rankItems, var_15_3)
		end

		local var_15_4 = self._rankItems[iter_15_0]

		if getProxy(PlayerProxy):isSelf(arg_15_1[iter_15_0].player_id) then
			self:setRankItemData(self.myRankItem, arg_15_1[iter_15_0], iter_15_0)
		end

		self:setRankItemData(var_15_4, arg_15_1[iter_15_0], iter_15_0)
		setActive(var_15_4, true)
	end

	for iter_15_1 = #arg_15_1 + 1, #self._rankItems do
		setActive(self._rankItems, false)
	end

	setActive(self._rankEmpty, #arg_15_1 == 0)
	setActive(self._rankImg, #arg_15_1 > 0)

	return
end

function MusicBeatGamePopUI:setRankItemData(arg_16_1, arg_16_2, arg_16_3)
	local var_16_2 = getProxy(PlayerProxy):isSelf(arg_16_2.player_id)

	setText(findTF(arg_16_1, "nameText"), arg_16_2.name)
	self:setChildVisible(findTF(arg_16_1, "bg"), false)
	self:setChildVisible(findTF(arg_16_1, "rank"), false)

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

function MusicBeatGamePopUI:setChildVisible(arg_17_1, arg_17_2)
	for iter_17_0 = 1, arg_17_1.childCount do
		setActive(arg_17_1:GetChild(iter_17_0 - 1), arg_17_2)
	end

	return
end

function MusicBeatGamePopUI:showRank(arg_18_1)
	setActive(self.rankUI, arg_18_1)

	return
end

function MusicBeatGamePopUI:updateSettlementUI()
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_19_0 = self._gameVo.scoreNum
	local var_19_1 = getProxy(MiniGameProxy):GetHighScore(self._gameVo.gameId)
	local var_19_2

	if var_19_1 and #var_19_1 > 0 then
		var_19_2 = var_19_1[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_19_2 < var_19_0)

	if var_19_0 > 0 and var_19_2 < var_19_0 then
		self._event:emit(MusicBeatGameEvent.STORE_SERVER, {
			var_19_0,
			1
		})
	end

	local var_19_3 = findTF(self.settlementUI, "ad/highText")

	setText(findTF(self.settlementUI, "ad/currentText"), var_19_0)
	setText(var_19_3, var_19_2 < var_19_0 and var_19_0 or var_19_2)
	self._event:emit(MusicBeatGameEvent.SUBMIT_GAME_SUCCESS)

	return
end

function MusicBeatGamePopUI:backPressed()
	if isActive(self.pauseUI) then
		self:resumeGame()
		self._event:emit(MusicBeatGameEvent.PAUSE_GAME, false)
	elseif isActive(self.leaveUI) then
		self:resumeGame()
		self._event:emit(MusicBeatGameEvent.LEVEL_GAME, false)
	elseif not isActive(self.pauseUI) and not isActive(self.pauseUI) then
		if not self._gameVo.startSettlement then
			self:popPauseUI()
			self._event:emit(MusicBeatGameEvent.PAUSE_GAME, true)
		end
	else
		self:resumeGame()
	end

	return
end

function MusicBeatGamePopUI:resumeGame()
	setActive(self.leaveUI, false)
	setActive(self.pauseUI, false)

	return
end

function MusicBeatGamePopUI:popLeaveUI()
	if isActive(self.pauseUI) then
		setActive(self.pauseUI, false)
	end

	setActive(self.leaveUI, true)

	return
end

function MusicBeatGamePopUI:popPauseUI()
	if isActive(self.leaveUI) then
		setActive(self.leaveUI, false)
	end

	setActive(self.pauseUI, true)

	return
end

function MusicBeatGamePopUI:updateGameUI(arg_24_1)
	setText(self.scoreTf, arg_24_1.scoreNum)
	setText(self.gameTimeS, math.ceil(arg_24_1.gameTime))

	return
end

function MusicBeatGamePopUI:readyStart()
	self:popCountUI(true)
	self.countAnimator:Play("count")

	return
end

function MusicBeatGamePopUI:popCountUI(arg_26_1)
	setActive(self.countUI, arg_26_1)

	return
end

function MusicBeatGamePopUI:popSettlementUI(arg_27_1)
	setActive(self.settlementUI, arg_27_1)

	return
end

function MusicBeatGamePopUI:popRankUI(arg_28_1)
	setActive(self.rankUI, arg_28_1)

	return
end

function MusicBeatGamePopUI:clearUI()
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)

	return
end

return MusicBeatGamePopUI
