local NewChallengeResultGradePage = class("NewChallengeResultGradePage", import("..NewBattleResultGradePage"))

function NewChallengeResultGradePage:OnInit()
	NewChallengeResultGradePage.super.OnInit(self)

	self.challenge = getProxy(ChallengeProxy):getUserChallengeInfo(self.contextData.mode)
	self.challengeExpire = getProxy(ChallengeProxy):userSeaonExpire(self.contextData.mode)

	return
end

function NewChallengeResultGradePage:isTotalClear()
	return self.challenge:getMode() == ChallengeProxy.MODE_CASUAL and self.challenge:IsFinish() or self:isFail()
end

function NewChallengeResultGradePage:isFail()
	return self.contextData.score < ys.Battle.BattleConst.BattleScore.S
end

function NewChallengeResultGradePage:GetGetObjectives()
	local var_4_0 = getProxy(ChallengeProxy):getUserChallengeInfo(self.contextData.mode)

	if var_4_0:getMode() == ChallengeProxy.MODE_INFINITE then
		return {}
	else
		local var_4_1 = {}
		local var_4_2, var_4_3 = NewBattleResultUtil.ColorObjective(true)

		table.insert(var_4_1, {
			text = setColorStr(i18n("challenge_combat_score", var_4_0:getLastScore()), var_4_3),
			icon = var_4_2
		})
		table.insert(var_4_1, {
			text = setColorStr(i18n("challenge_current_score", var_4_0:getScore()), var_4_3),
			icon = var_4_2
		})

		return var_4_1
	end

	return
end

function NewChallengeResultGradePage:UpdateChapterName()
	if getProxy(ChallengeProxy):getUserChallengeInfo(self.contextData.mode) == ChallengeProxy.MODE_INFINITE then
		setText(self.gradeChapterName, pg.expedition_data_template[self.contextData.stageId].name .. " - ROUND " .. getProxy(ChallengeProxy):getUserChallengeInfo(self.contextData.mode):getLevel())
	else
		NewChallengeResultGradePage.super.UpdateChapterName(self)
	end

	return
end

function NewChallengeResultGradePage:LoadChallengeRes(arg_6_1)
	setActive(self.bgTr:Find("ResultEffect/Tips"), false)
	LoadAnyAsync("BattleResultItems/Challenge", "", nil, function(arg_7_0)
		if self.exited or IsNil(arg_7_0) then
			if arg_6_1 then
				arg_6_1()
			end

			return
		end

		self:UpdateChallengeInfo(Object.Instantiate(arg_7_0, self._tf).transform)

		if arg_6_1 then
			arg_6_1()
		end

		return
	end)

	return
end

function NewChallengeResultGradePage:UpdateChallengeInfo(arg_8_1)
	setText(arg_8_1:Find("expire"), self.challengeExpire and i18n("challenge_expire_warn") or "")
	setText(findTF(arg_8_1, "continue_btn/text"), i18n("battle_result_continue_battle"))
	setText(findTF(arg_8_1, "quit_btn/text"), i18n("battle_result_quit_battle"))
	setText(findTF(arg_8_1, "share_btn/text"), i18n("battle_result_share_battle"))

	self.continueBtn = findTF(arg_8_1, "continue_btn")
	self.quitBtn = findTF(arg_8_1, "quit_btn")
	self.shareBtn = findTF(arg_8_1, "share_btn")

	local var_8_0 = self:isTotalClear()

	SetActive(self.continueBtn, not var_8_0)
	SetActive(self.quitBtn, not var_8_0)
	SetActive(self.shareBtn, var_8_0)

	return
end

function NewChallengeResultGradePage:RegisterEvent(arg_9_1)
	seriesAsync({
		function(arg_10_0)
			NewChallengeResultGradePage.super.RegisterEvent(self, arg_10_0)

			return
		end,
		function(arg_11_0)
			removeOnButton(self._tf)
			self:LoadChallengeRes(arg_11_0)

			return
		end,
		function(arg_12_0)
			self:RegisterChallengeEvent(arg_9_1)

			return
		end
	})

	return
end

function NewChallengeResultGradePage:RegisterChallengeEvent(arg_13_1)
	if self:isTotalClear() then
		onButton(self, self.shareBtn, function()
			self:emit(NewBattleResultMediator.CHALLENGE_SHARE)

			return
		end, SFX_CONFIRM)
		onButton(self, self._tf, arg_13_1, SFX_CONFIRM)
	else
		onButton(self, self.continueBtn, function()
			self:OnContinue(arg_13_1)

			return
		end, SFX_CONFIRM)
		onButton(self, self.quitBtn, function()
			self:OnQuit(arg_13_1)

			return
		end, SFX_CONFIRM)
	end

	return
end

function NewChallengeResultGradePage:OnContinue(arg_17_1)
	if self:isFail() then
		arg_17_1()
	else
		self.contextData.goToNext = true

		self:emit(NewBattleResultMediator.CHALLENGE_DEFEAT_SCENE, {
			callback = arg_17_1
		})
	end

	return
end

function NewChallengeResultGradePage:OnQuit(arg_18_1)
	if self:isFail() then
		arg_18_1()
	else
		self:emit(NewBattleResultMediator.CHALLENGE_DEFEAT_SCENE, {
			callback = arg_18_1
		})
	end

	return
end

return NewChallengeResultGradePage
