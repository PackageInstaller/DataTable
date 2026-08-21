local var_0_0 = class("XH3rdFlipCardGameView", ReduxView)

GameStatus = {
	GameOver = 4,
	MidPaused = 3,
	Paused = 0,
	Observing = 1,
	Flipping = 2
}

function var_0_0.UIName(arg_1_0)
	return XH3rdFlipCardTool:GetGameUI()
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.lastGameStatu = nil
	arg_3_0.statusController = ControllerUtil.GetController(arg_3_0.transform_, "status")
	arg_3_0.endController = ControllerUtil.GetController(arg_3_0.transform_, "end")

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		local var_6_0 = XH3rdFlipCardTool:GetGameState()

		if var_6_0 == GameStatus.Paused then
			arg_5_0:Back()
			arg_5_0:UnLoadFlipCardScene()
		else
			XH3rdFlipCardTool:ChangeStatus(GameStatus.MidPaused)
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_FLIP_CARD_ABANDON"),
				OkCallback = function()
					if var_6_0 == GameStatus.GameOver then
						arg_5_0:Back()

						local var_7_0 = XH3rdFlipCardTool:GetUseTime()
						local var_7_1 = XH3rdFlipCardTool:GetFlipCardCount()

						XH3rdFlipCardAction:sendSettleFlipCardGameRequest(arg_5_0.activityId, false, var_7_0, var_7_1)
						arg_5_0:UnLoadFlipCardScene()
					else
						XH3rdFlipCardTool:GiveUp()
					end
				end,
				CancelCallback = function()
					XH3rdFlipCardTool:ChangeStatus(var_6_0)
				end,
				MaskCallback = function()
					XH3rdFlipCardTool:ChangeStatus(var_6_0)
				end
			})
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.fastStartBtn_, nil, function()
		XH3rdFlipCardTool:StopObservingCard()
	end)
	arg_5_0:AddBtnListener(arg_5_0.startBtn_, nil, function()
		if arg_5_0.hasSendStartRequest then
			return
		end

		arg_5_0.hasSendStartRequest = true

		XH3rdFlipCardAction:sendStartFlipCardGameRequest(arg_5_0.activityId)
	end)
	arg_5_0:AddBtnListener(arg_5_0.giveUpBtn_, nil, function()
		local var_12_0 = XH3rdFlipCardTool:GetGameState()

		if var_12_0 == GameStatus.GameOver then
			return
		end

		XH3rdFlipCardTool:ChangeStatus(GameStatus.MidPaused)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("ACTIVITY_FLIP_CARD_ABANDON"),
			OkCallback = function()
				XH3rdFlipCardTool:GiveUp()
			end,
			CancelCallback = function()
				XH3rdFlipCardTool:ChangeStatus(var_12_0)
			end,
			MaskCallback = function()
				XH3rdFlipCardTool:ChangeStatus(var_12_0)
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.clueBtn_, nil, function()
		JumpTools.OpenPageByJump("xH3rdFlipCardClue", {
			activityID = arg_5_0.activityId
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("xH3rdFlipCardReward", {
			activityID = ActivityCfg[arg_5_0.activityId].sub_activity_list[#ActivityCfg[arg_5_0.activityId].sub_activity_list]
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.tokenBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			FlipCardCfg[arg_5_0.activityId].cost_id,
			0
		})
	end)
end

function var_0_0.OnEnter(arg_19_0)
	arg_19_0.activityId = arg_19_0.params_.activityId
	arg_19_0.hasSendStartRequest = false

	local var_19_0 = ActivityData:GetActivityData(arg_19_0.activityId)

	arg_19_0.startTime_ = var_19_0.startTime
	arg_19_0.stopTime_ = var_19_0.stopTime

	XH3rdFlipCardTool:LoadScene(arg_19_0.activityId, function()
		var_0_0:OnSceneLoaded()
	end)

	arg_19_0.refreshHandler_ = handler(arg_19_0, arg_19_0.RefreshGameOverStateUI)
	arg_19_0.updateHandler_ = handler(arg_19_0, arg_19_0.OnUpdateData)

	manager.notify:RegistListener(FLIP_CARD_GAME_RESULT, arg_19_0.refreshHandler_)
	manager.notify:RegistListener(FLIP_CARD_START_GAME_RESULT, function()
		arg_19_0.hasSendStartRequest = false
	end)
	manager.notify:RegistListener(FLIP_CARD_VIEW_CARD_RESULT, function()
		arg_19_0:InitCard()
	end)
	manager.notify:RegistListener(FLIP_CARD_UPDATE_DATA, arg_19_0.updateHandler_)
	manager.redPoint:bindUIandKey(arg_19_0.rewardBtnTrans_, string.format("%s_%s_mainTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, ActivityCfg[arg_19_0.activityId].sub_activity_list[#ActivityCfg[arg_19_0.activityId].sub_activity_list]))
	manager.redPoint:bindUIandKey(arg_19_0.clueBtnTrans_, string.format("%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, arg_19_0.activityId))
	manager.redPoint:bindUIandKey(arg_19_0.startBtn_.transform, string.format("%s_%s_canGetClue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, arg_19_0.activityId))
end

function var_0_0.OnUpdateData(arg_23_0)
	if XH3rdFlipCardTool:GetGameState() == GameStatus.Paused then
		arg_23_0:RefreshPausedStateUI()
	end
end

function var_0_0.OnEnterOver(arg_24_0)
	arg_24_0:RefreshPausedStateUI()
	arg_24_0:AddTimer()
	arg_24_0:SetUIText()
end

function var_0_0.AddTimer(arg_25_0)
	arg_25_0:StopTimer()

	arg_25_0.stateTimer_ = Timer.New(function()
		arg_25_0:CheckGameStatus()
	end, 0.1, -1, true)

	arg_25_0.stateTimer_:Start()

	arg_25_0.remainTimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(arg_25_0.stopTime_, nil, true)
	arg_25_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > arg_25_0.stopTime_ then
			return
		end

		arg_25_0.remainTimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(arg_25_0.stopTime_, nil, true)

		arg_25_0:SetUnlockTimeText()
	end, 1, -1)

	arg_25_0.timer_:Start()
end

function var_0_0.StopTimer(arg_28_0)
	if arg_28_0.timer_ then
		arg_28_0.timer_:Stop()

		arg_28_0.timer_ = nil
	end

	if arg_28_0.stateTimer_ then
		arg_28_0.stateTimer_:Stop()

		arg_28_0.stateTimer_ = nil
	end
end

function var_0_0.ResetAnimator(arg_29_0, arg_29_1, arg_29_2)
	arg_29_1:Play(arg_29_2, 0, 0)
	arg_29_1:Update(0)

	arg_29_1.enabled = false
end

function var_0_0.OnSceneLoaded(arg_30_0)
	arg_30_0.sceneLoaded_ = true

	arg_30_0:InitCard()
end

function var_0_0.InitCard(arg_31_0)
	local var_31_0 = #XH3rdFlipCardData.data.unlock_card_list

	if var_31_0 < 6 then
		XH3rdFlipCardTool:SetCardNum(4, 2)
	elseif var_31_0 >= 6 and var_31_0 < 9 then
		XH3rdFlipCardTool:SetCardNum(6, 2)
	else
		XH3rdFlipCardTool:SetCardNum(6, 3)
	end

	XH3rdFlipCardTool:InitGame()
end

function var_0_0.SetUIText(arg_32_0)
	local var_32_0 = XH3rdFlipCardTool:GetGameState()

	if var_32_0 == GameStatus.Observing then
		arg_32_0.timeTitleText_.text = GetTips("ACTIVITY_FLIP_CARD_TIME_NAME_1")
	elseif var_32_0 == GameStatus.Flipping then
		arg_32_0.timeTitleText_.text = GetTips("ACTIVITY_FLIP_CARD_TIME_NAME_2")
	end
end

function var_0_0.CheckGameStatus(arg_33_0)
	local var_33_0 = XH3rdFlipCardTool:GetGameState()

	if var_33_0 ~= GameStatus.Observing and arg_33_0.startTimeTimer then
		arg_33_0.startTimeTimer:Stop()

		arg_33_0.startTimeTimer = nil
	end

	if var_33_0 == GameStatus.Observing then
		arg_33_0.leftTimeText_.text = XH3rdFlipCardTool:GetObservingLeftTime()
	elseif var_33_0 == GameStatus.Flipping then
		if not arg_33_0.isShowStartTips then
			SetActive(arg_33_0.startPopImg_, true)
			manager.audio.PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_start_auto")

			arg_33_0.isShowStartTips = true
			arg_33_0.showTimer = Timer.New(function()
				SetActive(arg_33_0.startPopImg_, false)

				arg_33_0.showTimer = nil
			end, 0.6, 1, true)

			arg_33_0.showTimer:Start()
		end

		arg_33_0.leftTimeText_.text = XH3rdFlipCardTool:GetFlippingLeftTime()
	end

	if arg_33_0.lastGameStatu ~= var_33_0 then
		if var_33_0 == GameStatus.GameOver then
			local var_33_1 = XH3rdFlipCardTool.GetIsSuccess()

			if var_33_1 then
				manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter")
				manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo")
			else
				manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail")
				manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error")
			end

			local var_33_2 = XH3rdFlipCardTool:GetUseTime()
			local var_33_3 = XH3rdFlipCardTool:GetFlipCardCount()

			XH3rdFlipCardAction:sendSettleFlipCardGameRequest(arg_33_0.activityId, var_33_1, var_33_2, var_33_3)
		elseif var_33_0 == GameStatus.Observing then
			arg_33_0.startTimeTimer = Timer.New(function()
				local var_35_0 = XH3rdFlipCardTool:GetObservingLeftTime()

				if XH3rdFlipCardTool:GetGameState() ~= GameStatus.Observing then
					arg_33_0.startTimeTimer:Stop()

					arg_33_0.startTimeTimer = nil

					return
				end

				if var_35_0 >= 1 then
					manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_time01")
				elseif var_35_0 < 1 then
					manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_time02")
					arg_33_0.startTimeTimer:Stop()

					arg_33_0.startTimeTimer = nil
				end
			end, 1, -1, true)

			arg_33_0.startTimeTimer:Start()
		elseif var_33_0 == GameStatus.Paused then
			manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
			arg_33_0:RefreshPausedStateUI()

			arg_33_0.isShowStartTips = false
		elseif var_33_0 == GameStatus.Flipping then
			-- block empty
		end

		arg_33_0:SetUIText()
		arg_33_0.statusController:SetSelectedIndex(var_33_0)

		arg_33_0.lastGameStatu = var_33_0
	end
end

function var_0_0.RefreshPausedStateUI(arg_36_0)
	local var_36_0 = #XH3rdFlipCardData:GetClueList(arg_36_0.activityId)
	local var_36_1 = #FlipCardCfg[arg_36_0.activityId].details

	arg_36_0.clueText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_CLUE_COLLECTION_PROGRESS"), var_36_0, var_36_1)

	local var_36_2 = FlipCardCfg[arg_36_0.activityId].cost_id

	arg_36_0.tokenImg_.sprite = ItemTools.getItemSprite(var_36_2)
	arg_36_0.startItemImg_.sprite = ItemTools.getItemSprite(var_36_2)
	arg_36_0.tokenNumberText_.text = ItemTools.getItemNum(var_36_2)

	local var_36_3 = #XH3rdFlipCardData.data.unlock_card_list + #XH3rdFlipCardData.data.new_card_list
	local var_36_4 = false

	if var_36_3 < 6 then
		arg_36_0.clueNumText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_11_UNLOCK_CLUE"), 2)
		arg_36_0.clueProgressNum_.text = #XH3rdFlipCardData:GetClueList(arg_36_0.activityId) .. "/2"
		var_36_4 = #XH3rdFlipCardData:GetClueList(arg_36_0.activityId) == 2
	elseif var_36_3 >= 6 and var_36_3 < 9 then
		arg_36_0.clueNumText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_11_UNLOCK_CLUE"), 4)
		arg_36_0.clueProgressNum_.text = #XH3rdFlipCardData:GetClueList(arg_36_0.activityId) .. "/4"
		var_36_4 = #XH3rdFlipCardData:GetClueList(arg_36_0.activityId) == 4
	else
		arg_36_0.clueNumText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_11_UNLOCK_CLUE"), 4)
		arg_36_0.clueProgressNum_.text = #XH3rdFlipCardData:GetClueList(arg_36_0.activityId) .. "/4"
	end

	arg_36_0.clueController_:GetController("achieve"):SetSelectedState(tostring(var_36_4))
	arg_36_0:SetUnlockTimeText()
	SetActive(arg_36_0.clueGo_, var_36_3 < 9)
	SetActive(arg_36_0.unlockGo_, var_36_3 == 9)

	arg_36_0.cardNumText_.text = var_36_3 .. "/" .. #FlipCardCfg[arg_36_0.activityId].normal_card + #FlipCardCfg[arg_36_0.activityId].special_card

	arg_36_0:CheckHasNewCard()
end

function var_0_0.SetUnlockTimeText(arg_37_0)
	local var_37_0 = #XH3rdFlipCardData.data.unlock_card_list + #XH3rdFlipCardData.data.new_card_list
	local var_37_1 = 1

	if var_37_0 < 6 then
		var_37_1 = 1
	elseif var_37_0 < 9 then
		var_37_1 = 2
	end

	arg_37_0.timeUnlockText_.text = ""

	if XH3rdFlipCardData:GetUnOpenActivtiyTimeText(var_37_1) then
		arg_37_0.timeUnlockText_.text = XH3rdFlipCardData:GetUnOpenActivtiyTimeText(var_37_1)
	end

	SetActive(arg_37_0.timeUnlockGo_, var_37_0 < 9 and var_37_0 >= 6)
	arg_37_0.timeUnlockController_:GetController("achieve"):SetSelectedState(tostring(not XH3rdFlipCardData:GetUnOpenActivtiyTimeText(var_37_1)))
end

function var_0_0.CheckHasNewCard(arg_38_0)
	if #XH3rdFlipCardData:GetNewCardList() > 0 then
		JumpTools.OpenPageByJump("cORGflipCardUnlockCardPop")
	end
end

function var_0_0.RefreshGameOverStateUI(arg_39_0, arg_39_1)
	JumpTools.OpenPageByJump("cORGflipCardResultPop", {
		clueID = arg_39_1
	})
end

function var_0_0.UnLoadFlipCardScene(arg_40_0)
	arg_40_0.sceneLoaded_ = false

	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	XH3rdFlipCardTool:UnLoadScene()
end

function var_0_0.OnExit(arg_41_0)
	arg_41_0:StopTimer()
	manager.notify:RemoveListener(FLIP_CARD_GAME_RESULT, arg_41_0.refreshHandler_)
	manager.notify:RemoveListener(FLIP_CARD_START_GAME_RESULT, function()
		arg_41_0.hasSendStartRequest = false
	end)
	manager.notify:RemoveListener(FLIP_CARD_VIEW_CARD_RESULT, function()
		arg_41_0:InitCard()
	end)
	manager.notify:RemoveListener(FLIP_CARD_UPDATE_DATA, arg_41_0.updateHandler_)

	if arg_41_0.startTimeTimer then
		arg_41_0.startTimeTimer:Stop()

		arg_41_0.startTimeTimer = nil
	end

	arg_41_0.refreshHandler_ = nil

	manager.redPoint:unbindUIandKey(arg_41_0.rewardBtnTrans_, string.format("%s_%s_mainTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, ActivityCfg[arg_41_0.activityId].sub_activity_list[#ActivityCfg[arg_41_0.activityId].sub_activity_list]))
	manager.redPoint:unbindUIandKey(arg_41_0.clueBtnTrans_, string.format("%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, arg_41_0.activityId))
	manager.redPoint:unbindUIandKey(arg_41_0.startBtn_.transform, string.format("%s_%s_canGetClue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, arg_41_0.activityId))
end

return var_0_0
