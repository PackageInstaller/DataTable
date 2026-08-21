local var_0_0 = class("PinballBattleSettlementView", ReduxView)

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
		BattleInstance.OnceMoreBattle(arg_4_0.stageData)
	end)
	arg_4_0:AddBtnListener(arg_4_0.exitBtn_, nil, function()
		DestroyLua()
		PinballAction.EnterPinballGameScene()
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

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.stageData = arg_9_0.params_.stageData

	arg_9_0.winStateController_:SetSelectedState(arg_9_0.params_.isSuccess and "win" or "lose")

	arg_9_0.stageCfg = PinballStageCfg[PinballAction.PlayingStageID]

	local var_9_0 = arg_9_0.stageCfg.skill_unlock
	local var_9_1 = PinballSkillCfg[var_9_0]

	if arg_9_0.params_.isSuccess then
		if PinballAction.PlayingStageID == PinballData:GetChallengeStageID() then
			arg_9_0.middleStateController_:SetSelectedState("score")

			arg_9_0.scoreText_.text = arg_9_0.params_.BH

			SetActive(arg_9_0.newScoreGo_, arg_9_0.params_.BH > PinballData:GetMaxChallengeScore())
		elseif PinballData:GetRoleLevel() > arg_9_0.stageCfg.lv_up then
			arg_9_0.middleStateController_:SetSelectedState("tips")
		else
			arg_9_0.middleStateController_:SetSelectedState("skill")

			local var_9_2 = table.indexof(PinballSkillCfg.get_id_list_by_skill_group[var_9_1.skill_group], var_9_0)

			if var_9_1.skill_type == 1 then
				arg_9_0.skillStateController_:SetSelectedState("unlockActive")

				arg_9_0.activeSkillIcon_.sprite = pureGetSpriteWithoutAtlas(var_9_1.icon)

				saveData("Hella_Pinball", "Unlock_Active_Skill", var_9_0)
			else
				if var_9_2 ~= 1 then
					arg_9_0.skillStateController_:SetSelectedState("upgrade")
				else
					arg_9_0.skillStateController_:SetSelectedState("unlockPassive")
				end

				arg_9_0.passiveSkillIcon_.sprite = pureGetSpriteWithoutAtlas(var_9_1.icon)

				arg_9_0.passiveSkillController_:GetController("level"):SetSelectedState("lv" .. var_9_2)

				arg_9_0.skillFromLevelText_.text = string.format(GetTips("PINBALLGAME_GAME_SKILL_LEVEL"), var_9_2 - 1)
				arg_9_0.skillToLevelText_.text = string.format(GetTips("PINBALLGAME_GAME_SKILL_LEVEL"), var_9_2)
			end

			arg_9_0.fromLevelText_.text = PinballData:GetRoleLevel() - 1
			arg_9_0.toLevelText_.text = arg_9_0.stageCfg.lv_up
			arg_9_0.skillNameText_.text = GetI18NText(var_9_1.name)
			arg_9_0.skillDescText_.text = string.format(GetI18NText(var_9_1.description), unpack(var_9_1.effect))
		end

		manager.audio:PlayEffect("minigame_activity_3_9", "minigame_activity_3_9_xinmo_win", "")
	else
		arg_9_0.middleStateController_:SetSelectedState("tips")
		manager.audio:PlayEffect("minigame_activity_3_9", "minigame_activity_3_9_xinmo_lose", "")
	end

	SetActive(arg_9_0.tipsGo_, false)
end

function var_0_0.OnExit(arg_10_0)
	if arg_10_0.sendTimer_ then
		arg_10_0.sendTimer_:Stop()

		arg_10_0.sendTimer_ = nil
	end
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
