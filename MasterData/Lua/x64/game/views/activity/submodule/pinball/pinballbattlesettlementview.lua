local PinballBattleSettlementView = class("PinballBattleSettlementView", ReduxView)

function PinballBattleSettlementView:UIName()
	return "Widget/System/Activity_Hel/Activity_Hel_Pinball/Hel_Pinball_Settle"
end

function PinballBattleSettlementView:UIParent()
	return manager.ui.uiPop.transform
end

function PinballBattleSettlementView:Init()
	self:InitUI()
end

function PinballBattleSettlementView:InitUI()
	self:BindCfgUI()

	self.waitingForServer_ = true

	self:AddBtnListener(self.restartBtn_, nil, function()
		BattleInstance.OnceMoreBattle(self.stageData)
	end)
	self:AddBtnListener(self.exitBtn_, nil, function()
		DestroyLua()
		PinballAction.EnterPinballGameScene()
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

function PinballBattleSettlementView:OnEnter()
	self.stageData = self.params_.stageData

	self.winStateController_:SetSelectedState(self.params_.isSuccess and "win" or "lose")

	self.stageCfg = PinballStageCfg[PinballAction.PlayingStageID]

	local var_9_0 = PinballSkillCfg[self.stageCfg.skill_unlock]

	if self.params_.isSuccess then
		if PinballAction.PlayingStageID == PinballData:GetChallengeStageID() then
			self.middleStateController_:SetSelectedState("score")

			self.scoreText_.text = self.params_.BH

			SetActive(self.newScoreGo_, self.params_.BH > PinballData:GetMaxChallengeScore())
		elseif PinballData:GetRoleLevel() > self.stageCfg.lv_up then
			self.middleStateController_:SetSelectedState("tips")
		else
			self.middleStateController_:SetSelectedState("skill")

			local var_9_1 = table.indexof(PinballSkillCfg.get_id_list_by_skill_group[var_9_0.skill_group], self.stageCfg.skill_unlock)

			if var_9_0.skill_type == 1 then
				self.skillStateController_:SetSelectedState("unlockActive")

				self.activeSkillIcon_.sprite = pureGetSpriteWithoutAtlas(var_9_0.icon)

				saveData("Hella_Pinball", "Unlock_Active_Skill", self.stageCfg.skill_unlock)
			else
				if var_9_1 ~= 1 then
					self.skillStateController_:SetSelectedState("upgrade")
				else
					self.skillStateController_:SetSelectedState("unlockPassive")
				end

				self.passiveSkillIcon_.sprite = pureGetSpriteWithoutAtlas(var_9_0.icon)

				self.passiveSkillController_:GetController("level"):SetSelectedState("lv" .. var_9_1)

				self.skillFromLevelText_.text = string.format(GetTips("PINBALLGAME_GAME_SKILL_LEVEL"), var_9_1 - 1)
				self.skillToLevelText_.text = string.format(GetTips("PINBALLGAME_GAME_SKILL_LEVEL"), var_9_1)
			end

			self.fromLevelText_.text = PinballData:GetRoleLevel() - 1
			self.toLevelText_.text = self.stageCfg.lv_up
			self.skillNameText_.text = GetI18NText(var_9_0.name)
			self.skillDescText_.text = string.format(GetI18NText(var_9_0.description), unpack(var_9_0.effect))
		end

		manager.audio:PlayEffect("minigame_activity_3_9", "minigame_activity_3_9_xinmo_win", "")
	else
		self.middleStateController_:SetSelectedState("tips")
		manager.audio:PlayEffect("minigame_activity_3_9", "minigame_activity_3_9_xinmo_lose", "")
	end

	SetActive(self.tipsGo_, false)
end

function PinballBattleSettlementView:OnExit()
	if self.sendTimer_ then
		self.sendTimer_:Stop()

		self.sendTimer_ = nil
	end
end

function PinballBattleSettlementView:Dispose()
	PinballBattleSettlementView.super.Dispose(self)
end

return PinballBattleSettlementView
