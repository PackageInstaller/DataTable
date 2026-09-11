local PinballSettlementView = class("PinballSettlementView", ReduxView)

function PinballSettlementView:UIName()
	return "Widget/System/Activity_Hel/Activity_Hel_Pinball/Hel_Pinball_Settle"
end

function PinballSettlementView:UIParent()
	return manager.ui.uiPop.transform
end

function PinballSettlementView:Init()
	self:InitUI()
end

function PinballSettlementView:InitUI()
	self:BindCfgUI()

	self.waitingForServer_ = true

	self:AddBtnListener(self.restartBtn_, nil, function()
		if self.waitingForServer_ then
			return
		end

		self:Back()
		PinballLuaBridge.GameRestart()
		PinballAction.RecordStartTime()
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		if self.waitingForServer_ then
			return
		end

		manager.story:CheckBattleStory(PinballStageCfg[PinballAction.PlayingStageID].barrier_id, (self.params_.remainHp > 0 or nil) and (manager.story.WIN or manager.story.LOSE), function()
			PinballBridge:Enter(PinballGame, {
				isEnter = true,
				isEnterHome = true
			})
			manager.story:RemovePlayer()
		end)
	end)
	self:AddBtnListener(self.activeSkillBtn_, nil, function()
		if self.tipsGoActive_ then
			SetActive(self.tipsGo_, false)

			self.tipsGoActive_ = false
		else
			SetActive(self.tipsGo_, true)

			self.tipsGoActive_ = true
		end
	end)
	self:AddBtnListener(self.passiveSkillBtn_, nil, function()
		if self.tipsGoActive_ then
			SetActive(self.tipsGo_, false)

			self.tipsGoActive_ = false
		else
			SetActive(self.tipsGo_, true)

			self.tipsGoActive_ = true
		end
	end)

	self.winStateController_ = self.mainControllerEx_:GetController("state")
	self.middleStateController_ = self.middleControllerEx_:GetController("middleState")
	self.skillStateController_ = self.skillControllerEx_:GetController("skillState")
end

function PinballSettlementView:OnEnter()
	self.winStateController_:SetSelectedState(self.params_.result == 1 and "win" or "lose")

	self.stageCfg = PinballStageCfg[PinballAction.PlayingStageID]

	local var_10_0 = PinballSkillCfg[self.stageCfg.skill_unlock]

	if self.params_.result == 1 then
		if PinballAction.PlayingStageID == PinballData:GetChallengeStageID() then
			self.middleStateController_:SetSelectedState("score")

			self.scoreText_.text = self.params_.challengeScore

			SetActive(self.newScoreGo_, self.params_.challengeScore > PinballData:GetMaxChallengeScore())
		elseif PinballData:GetRoleLevel() >= self.stageCfg.lv_up then
			self.middleStateController_:SetSelectedState("tips")
		else
			self.middleStateController_:SetSelectedState("skill")

			local var_10_1 = table.indexof(PinballSkillCfg.get_id_list_by_skill_group[var_10_0.skill_group], self.stageCfg.skill_unlock)

			if var_10_0.skill_type == 1 then
				self.skillStateController_:SetSelectedState("unlockActive")

				self.activeSkillIcon_.sprite = pureGetSpriteWithoutAtlas(var_10_0.icon)

				saveData("Hella_Pinball", "Unlock_Active_Skill", self.stageCfg.skill_unlock)
			else
				if var_10_1 ~= 1 then
					self.skillStateController_:SetSelectedState("upgrade")
				else
					self.skillStateController_:SetSelectedState("unlockPassive")
				end

				self.passiveSkillIcon_.sprite = pureGetSpriteWithoutAtlas(var_10_0.icon)

				self.passiveSkillController_:GetController("level"):SetSelectedState("lv" .. var_10_1)

				for iter_10_0, iter_10_1 in ipairs(PinballSkillCfg.get_id_list_by_skill_group[var_10_0.skill_group]) do
					local var_10_2 = table.indexof(PinballData:GetExraEquipSkill(), iter_10_1)

					if var_10_2 and var_10_2 > 0 then
						self.preSkillIndex = table.indexof(PinballSkillCfg.get_id_list_by_skill_group[var_10_0.skill_group], iter_10_1)

						break
					else
						self.preSkillIndex = 1
					end
				end

				self.skillFromLevelText_.text = string.format(GetTips("PINBALLGAME_GAME_SKILL_LEVEL"), self.preSkillIndex)
				self.skillToLevelText_.text = string.format(GetTips("PINBALLGAME_GAME_SKILL_LEVEL"), var_10_1)
			end

			self.fromLevelText_.text = PinballData:GetRoleLevel()
			self.toLevelText_.text = self.stageCfg.lv_up
			self.skillNameText_.text = GetI18NText(var_10_0.name)
			self.skillDescText_.text = string.format(GetI18NText(var_10_0.description), unpack(var_10_0.effect))
		end

		manager.audio:PlayEffect("minigame_activity_3_9", "minigame_activity_3_9_xinmo_win", "")
		PinballAction.SendLevelFinish(self.params_.challengeScore, self.params_.BH, self.params_.callback)

		self.waitingForServer_ = true
		self.sendTimer_ = Timer.New(function()
			self.waitingForServer_ = false

			if self.sendTimer_ then
				self.sendTimer_:Stop()

				self.sendTimer_ = nil
			end
		end, 1.5, 1)

		self.sendTimer_:Start()
	else
		self.waitingForServer_ = false

		self.middleStateController_:SetSelectedState("tips")
		manager.audio:PlayEffect("minigame_activity_3_9", "minigame_activity_3_9_xinmo_lose", "")
		self.params_.callback()
	end

	SetActive(self.tipsGo_, false)
end

function PinballSettlementView:OnExit()
	if self.sendTimer_ then
		self.sendTimer_:Stop()

		self.sendTimer_ = nil
	end
end

function PinballSettlementView:Dispose()
	PinballSettlementView.super.Dispose(self)
end

return PinballSettlementView
