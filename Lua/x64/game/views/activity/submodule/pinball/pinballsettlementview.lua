local var_0_0 = class("PinballSettlementView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hel/Activity_Hel_Pinball/Hel_Pinball_Settle"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.waitingForServer_ = true

	arg_4_0:AddBtnListener(arg_4_0.restartBtn_, nil, function()
		if arg_4_0.waitingForServer_ then
			return
		end

		arg_4_0:Back()
		PinballLuaBridge.GameRestart()
		PinballAction.RecordStartTime()
	end)
	arg_4_0:AddBtnListener(arg_4_0.exitBtn_, nil, function()
		if arg_4_0.waitingForServer_ then
			return
		end

		manager.story:CheckBattleStory(PinballStageCfg[PinballAction.PlayingStageID].barrier_id, arg_4_0.params_.remainHp > 0 and manager.story.WIN or manager.story.LOSE, function()
			PinballBridge:Enter(PinballGame, {
				isEnter = true,
				isEnterHome = true
			})
			manager.story:RemovePlayer()
		end)
	end)
	arg_4_0:AddBtnListener(arg_4_0.activeSkillBtn_, nil, function()
		if arg_4_0.tipsGoActive_ then
			SetActive(arg_4_0.tipsGo_, false)

			arg_4_0.tipsGoActive_ = false
		else
			SetActive(arg_4_0.tipsGo_, true)

			arg_4_0.tipsGoActive_ = true
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.passiveSkillBtn_, nil, function()
		if arg_4_0.tipsGoActive_ then
			SetActive(arg_4_0.tipsGo_, false)

			arg_4_0.tipsGoActive_ = false
		else
			SetActive(arg_4_0.tipsGo_, true)

			arg_4_0.tipsGoActive_ = true
		end
	end)

	arg_4_0.winStateController_ = arg_4_0.mainControllerEx_:GetController("state")
	arg_4_0.middleStateController_ = arg_4_0.middleControllerEx_:GetController("middleState")
	arg_4_0.skillStateController_ = arg_4_0.skillControllerEx_:GetController("skillState")
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.winStateController_:SetSelectedState(arg_10_0.params_.result == 1 and "win" or "lose")

	arg_10_0.stageCfg = PinballStageCfg[PinballAction.PlayingStageID]

	local var_10_0 = arg_10_0.stageCfg.skill_unlock
	local var_10_1 = PinballSkillCfg[var_10_0]

	if arg_10_0.params_.result == 1 then
		if PinballAction.PlayingStageID == PinballData:GetChallengeStageID() then
			arg_10_0.middleStateController_:SetSelectedState("score")

			arg_10_0.scoreText_.text = arg_10_0.params_.challengeScore

			SetActive(arg_10_0.newScoreGo_, arg_10_0.params_.challengeScore > PinballData:GetMaxChallengeScore())
		elseif PinballData:GetRoleLevel() >= arg_10_0.stageCfg.lv_up then
			arg_10_0.middleStateController_:SetSelectedState("tips")
		else
			arg_10_0.middleStateController_:SetSelectedState("skill")

			local var_10_2 = table.indexof(PinballSkillCfg.get_id_list_by_skill_group[var_10_1.skill_group], var_10_0)

			if var_10_1.skill_type == 1 then
				arg_10_0.skillStateController_:SetSelectedState("unlockActive")

				arg_10_0.activeSkillIcon_.sprite = pureGetSpriteWithoutAtlas(var_10_1.icon)

				saveData("Hella_Pinball", "Unlock_Active_Skill", var_10_0)
			else
				if var_10_2 ~= 1 then
					arg_10_0.skillStateController_:SetSelectedState("upgrade")
				else
					arg_10_0.skillStateController_:SetSelectedState("unlockPassive")
				end

				arg_10_0.passiveSkillIcon_.sprite = pureGetSpriteWithoutAtlas(var_10_1.icon)

				arg_10_0.passiveSkillController_:GetController("level"):SetSelectedState("lv" .. var_10_2)

				for iter_10_0, iter_10_1 in ipairs(PinballSkillCfg.get_id_list_by_skill_group[var_10_1.skill_group]) do
					local var_10_3 = table.indexof(PinballData:GetExraEquipSkill(), iter_10_1)

					if var_10_3 and var_10_3 > 0 then
						arg_10_0.preSkillIndex = table.indexof(PinballSkillCfg.get_id_list_by_skill_group[var_10_1.skill_group], iter_10_1)

						break
					else
						arg_10_0.preSkillIndex = 1
					end
				end

				arg_10_0.skillFromLevelText_.text = string.format(GetTips("PINBALLGAME_GAME_SKILL_LEVEL"), arg_10_0.preSkillIndex)
				arg_10_0.skillToLevelText_.text = string.format(GetTips("PINBALLGAME_GAME_SKILL_LEVEL"), var_10_2)
			end

			arg_10_0.fromLevelText_.text = PinballData:GetRoleLevel()
			arg_10_0.toLevelText_.text = arg_10_0.stageCfg.lv_up
			arg_10_0.skillNameText_.text = GetI18NText(var_10_1.name)
			arg_10_0.skillDescText_.text = string.format(GetI18NText(var_10_1.description), unpack(var_10_1.effect))
		end

		manager.audio:PlayEffect("minigame_activity_3_9", "minigame_activity_3_9_xinmo_win", "")
		PinballAction.SendLevelFinish(arg_10_0.params_.challengeScore, arg_10_0.params_.BH, arg_10_0.params_.callback)

		arg_10_0.waitingForServer_ = true
		arg_10_0.sendTimer_ = Timer.New(function()
			arg_10_0.waitingForServer_ = false

			if arg_10_0.sendTimer_ then
				arg_10_0.sendTimer_:Stop()

				arg_10_0.sendTimer_ = nil
			end
		end, 1.5, 1)

		arg_10_0.sendTimer_:Start()
	else
		arg_10_0.waitingForServer_ = false

		arg_10_0.middleStateController_:SetSelectedState("tips")
		manager.audio:PlayEffect("minigame_activity_3_9", "minigame_activity_3_9_xinmo_lose", "")
		arg_10_0.params_.callback()
	end

	SetActive(arg_10_0.tipsGo_, false)
end

function var_0_0.OnExit(arg_12_0)
	if arg_12_0.sendTimer_ then
		arg_12_0.sendTimer_:Stop()

		arg_12_0.sendTimer_ = nil
	end
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
