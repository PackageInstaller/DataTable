local BattleChallengeResultLayer = class("BattleChallengeResultLayer", import(".BattleResultLayer"))

BattleChallengeResultLayer.DURATION_WIN_FADE_IN = 0.5
BattleChallengeResultLayer.DURATION_LOSE_FADE_IN = 1.5
BattleChallengeResultLayer.DURATION_GRADE_LAST = 1.5
BattleChallengeResultLayer.DURATION_MOVE = 0.7
BattleChallengeResultLayer.DURATION_WIN_SCALE = 0.7
BattleChallengeResultLayer.STATE_DEFEAT = "state_defeat"
BattleChallengeResultLayer.STATE_CLEAR = "state_clear"
BattleChallengeResultLayer.STATE_CONTINUE = "state_continue"
BattleChallengeResultLayer.STATE_QUIT = "state_quit"

function BattleChallengeResultLayer:getUIName()
	return "BattleResultUI"
end

function BattleChallengeResultLayer:setChallengeInfo(arg_2_1, arg_2_2)
	self.challenge = arg_2_1
	self.challengeExpire = arg_2_2

	return
end

function BattleChallengeResultLayer:setShips(arg_3_1)
	self.shipVOs = arg_3_1

	return
end

function BattleChallengeResultLayer:isTotalClear()
	return self.challenge:getMode() == ChallengeProxy.MODE_CASUAL and self.challenge:IsFinish() or self:isFail()
end

function BattleChallengeResultLayer:isFail()
	return self.contextData.score < ys.Battle.BattleConst.BattleScore.S
end

function BattleChallengeResultLayer:init()
	BattleChallengeResultLayer.super.init(self)

	self._challengeBottomPanel = self._blurConatiner:Find("challenge_confirm")

	setText(findTF(self._challengeBottomPanel, "continue_btn/text"), i18n("battle_result_continue_battle"))
	setText(findTF(self._challengeBottomPanel, "quit_btn/text"), i18n("battle_result_quit_battle"))
	setText(findTF(self._challengeBottomPanel, "share_btn/text"), i18n("battle_result_share_battle"))

	self._shareBtn = self._challengeBottomPanel:Find("share_btn")
	self._continueBtn = self._challengeBottomPanel:Find("continue_btn")
	self._quitBtn = self._challengeBottomPanel:Find("quit_btn")
	self._expire = self._main:Find("challenge_expire")
	self._expireTxt = self._expire:Find("text")

	return
end

function BattleChallengeResultLayer:didEnter()
	BattleChallengeResultLayer.super.didEnter(self)
	onButton(self, self._skipBtn, function()
		self:skip()

		return
	end, SFX_CONFIRM)

	return
end

function BattleChallengeResultLayer:setStageName()
	if self.contextData.system and self.contextData.system == SYSTEM_DUEL then
		setText(self._levelText, self.rivalVO.name)
	else
		-- block empty
	end

	if self.challenge:getMode() == ChallengeProxy.MODE_INFINITE then
		setText(self._levelText, pg.expedition_data_template[self.contextData.stageId].name .. " - ROUND " .. self.challenge:getLevel())
	else
		BattleChallengeResultLayer.super.setStageName(self)
	end

	return
end

function BattleChallengeResultLayer:rankAnimaFinish()
	local var_10_0 = self._tf:Find("main/conditions")

	if self.challenge:getMode() == ChallengeProxy.MODE_INFINITE then
		SetActive(var_10_0, false)

		self._stateFlag = BattleChallengeResultLayer.STATE_REPORTED
	else
		SetActive(var_10_0, true)
		self:setCondition(i18n("challenge_combat_score", self.challenge:getLastScore()), true)
		self:setCondition(i18n("challenge_current_score", self.challenge:getScore()), true)
		table.insert(self._delayLeanList, LeanTween.delayedCall(1, System.Action(function()
			self._stateFlag = BattleChallengeResultLayer.STATE_REPORTED

			SetActive(self._bg:Find("jieuan01/tips"), true)

			return
		end)).id)

		self._stateFlag = BattleChallengeResultLayer.STATE_REPORT
	end

	return
end

function BattleChallengeResultLayer:displayDefeat()
	local function var_12_0()
		self:skip()

		return
	end

	if self:isFail() then
		self._stateFlag = BattleChallengeResultLayer.STATE_QUIT

		var_12_0()
	else
		self:emit(BattleResultMediator.ON_CHALLENGE_DEFEAT_SCENE, {
			callback = var_12_0
		})
	end

	return
end

function BattleChallengeResultLayer:showRightBottomPanel()
	SetActive(self._expire, self.challengeExpire)
	setText(self._expireTxt, i18n("challenge_expire_warn"))
	SetActive(self._skipBtn, false)

	if not self:isTotalClear() then
		SetActive(self._bg:Find("jieuan01/tips"), false)
	end

	SetActive(self._challengeBottomPanel, true)

	if self:isTotalClear() then
		SetActive(self._continueBtn, false)
		SetActive(self._quitBtn, false)
		SetActive(self._shareBtn, true)
		onButton(self, self._shareBtn, function()
			self:emit(BattleResultMediator.ON_CHALLENGE_SHARE)

			return
		end, SFX_CONFIRM)
		onButton(self, self._bg, function()
			self:skip()

			self._stateFlag = BattleChallengeResultLayer.STATE_CLEAR

			return
		end)
	else
		SetActive(self._continueBtn, true)
		SetActive(self._quitBtn, true)
		SetActive(self._shareBtn, false)
		onButton(self, self._continueBtn, function()
			self:skip()

			self._stateFlag = BattleChallengeResultLayer.STATE_CONTINUE

			return
		end, SFX_CONFIRM)
		onButton(self, self._quitBtn, function()
			self:skip()

			self._stateFlag = BattleChallengeResultLayer.STATE_QUIT

			return
		end, SFX_CONFIRM)
	end

	self._stateFlag = BattleChallengeResultLayer.STATE_DEFEAT

	return
end

function BattleChallengeResultLayer:onBackPressed()
	self:skip()

	return
end

function BattleChallengeResultLayer:skip()
	for iter_20_0, iter_20_1 in ipairs(self._delayLeanList) do
		LeanTween.cancel(iter_20_1)
	end

	if self._stateFlag == BattleChallengeResultLayer.STATE_RANK_ANIMA then
		-- block empty
	elseif self._stateFlag == BattleChallengeResultLayer.STATE_REPORT then
		while self._conditionContainer.childCount > 0 do
			SetActive(self._conditionContainer:GetChild(self._conditionContainer.childCount - 1), true)
		end

		SetActive(self._bg:Find("jieuan01/tips"), true)

		self._stateFlag = BattleChallengeResultLayer.STATE_REPORTED
	elseif self._stateFlag == BattleChallengeResultLayer.STATE_REPORTED then
		self:showRightBottomPanel()
	elseif self._stateFlag == BattleChallengeResultLayer.STATE_DEFEAT then
		if self:isTotalClear() then
			self:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE, {
				goToNext = false
			})
		else
			self:displayDefeat()
		end
	elseif self._stateFlag == BattleChallengeResultLayer.STATE_CONTINUE then
		self:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE, {
			goToNext = true
		})
	elseif self._stateFlag == BattleChallengeResultLayer.STATE_QUIT or self._stateFlag == BattleChallengeResultLayer.STATE_CLEAR then
		self:emit(BattleResultMediator.ON_BACK_TO_LEVEL_SCENE, {
			goToNext = false
		})
	end

	return
end

function BattleChallengeResultLayer:willExit()
	BattleChallengeResultLayer.super.willExit(self)
	LeanTween.cancel(go(self._tf))
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return BattleChallengeResultLayer
