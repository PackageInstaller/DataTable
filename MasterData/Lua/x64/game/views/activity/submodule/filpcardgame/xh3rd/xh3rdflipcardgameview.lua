local XH3rdFlipCardGameView = class("XH3rdFlipCardGameView", ReduxView)

GameStatus = {
	GameOver = 4,
	MidPaused = 3,
	Paused = 0,
	Observing = 1,
	Flipping = 2
}

function XH3rdFlipCardGameView:UIName()
	return XH3rdFlipCardTool:GetGameUI()
end

function XH3rdFlipCardGameView:UIParent()
	return manager.ui.uiMain.transform
end

function XH3rdFlipCardGameView:Init()
	self.lastGameStatu = nil
	self.statusController = ControllerUtil.GetController(self.transform_, "status")
	self.endController = ControllerUtil.GetController(self.transform_, "end")

	self:InitUI()
	self:AddUIListener()
end

function XH3rdFlipCardGameView:InitUI()
	self:BindCfgUI()
end

function XH3rdFlipCardGameView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		local var_6_0 = XH3rdFlipCardTool:GetGameState()

		if var_6_0 == GameStatus.Paused then
			self:Back()
			self:UnLoadFlipCardScene()
		else
			XH3rdFlipCardTool:ChangeStatus(GameStatus.MidPaused)
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("ACTIVITY_FLIP_CARD_ABANDON"),
				OkCallback = function()
					if var_6_0 == GameStatus.GameOver then
						self:Back()
						XH3rdFlipCardAction:sendSettleFlipCardGameRequest(self.activityId, false, XH3rdFlipCardTool:GetUseTime(), (XH3rdFlipCardTool:GetFlipCardCount()))
						self:UnLoadFlipCardScene()
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
	self:AddBtnListener(self.fastStartBtn_, nil, function()
		XH3rdFlipCardTool:StopObservingCard()
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		if self.hasSendStartRequest then
			return
		end

		self.hasSendStartRequest = true

		XH3rdFlipCardAction:sendStartFlipCardGameRequest(self.activityId)
	end)
	self:AddBtnListener(self.giveUpBtn_, nil, function()
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
	self:AddBtnListener(self.clueBtn_, nil, function()
		JumpTools.OpenPageByJump("xH3rdFlipCardClue", {
			activityID = self.activityId
		})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("xH3rdFlipCardReward", {
			activityID = ActivityCfg[self.activityId].sub_activity_list[#ActivityCfg[self.activityId].sub_activity_list]
		})
	end)
	self:AddBtnListener(self.tokenBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			FlipCardCfg[self.activityId].cost_id,
			0
		})
	end)
end

function XH3rdFlipCardGameView:OnEnter()
	self.activityId = self.params_.activityId
	self.hasSendStartRequest = false

	local var_19_0 = ActivityData:GetActivityData(self.activityId)

	self.startTime_ = var_19_0.startTime
	self.stopTime_ = var_19_0.stopTime

	XH3rdFlipCardTool:LoadScene(self.activityId, function()
		XH3rdFlipCardGameView:OnSceneLoaded()
	end)

	self.refreshHandler_ = handler(self, self.RefreshGameOverStateUI)
	self.updateHandler_ = handler(self, self.OnUpdateData)

	manager.notify:RegistListener(FLIP_CARD_GAME_RESULT, self.refreshHandler_)
	manager.notify:RegistListener(FLIP_CARD_START_GAME_RESULT, function()
		self.hasSendStartRequest = false
	end)
	manager.notify:RegistListener(FLIP_CARD_VIEW_CARD_RESULT, function()
		self:InitCard()
	end)
	manager.notify:RegistListener(FLIP_CARD_UPDATE_DATA, self.updateHandler_)
	manager.redPoint:bindUIandKey(self.rewardBtnTrans_, string.format("%s_%s_mainTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, ActivityCfg[self.activityId].sub_activity_list[#ActivityCfg[self.activityId].sub_activity_list]))
	manager.redPoint:bindUIandKey(self.clueBtnTrans_, string.format("%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, self.activityId))
	manager.redPoint:bindUIandKey(self.startBtn_.transform, string.format("%s_%s_canGetClue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, self.activityId))
end

function XH3rdFlipCardGameView:OnUpdateData()
	if XH3rdFlipCardTool:GetGameState() == GameStatus.Paused then
		self:RefreshPausedStateUI()
	end
end

function XH3rdFlipCardGameView:OnEnterOver()
	self:RefreshPausedStateUI()
	self:AddTimer()
	self:SetUIText()
end

function XH3rdFlipCardGameView:AddTimer()
	self:StopTimer()

	self.stateTimer_ = Timer.New(function()
		self:CheckGameStatus()
	end, 0.1, -1, true)

	self.stateTimer_:Start()

	self.remainTimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self.remainTimeText_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(self.stopTime_, nil, true)

		self:SetUnlockTimeText()
	end, 1, -1)

	self.timer_:Start()
end

function XH3rdFlipCardGameView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.stateTimer_ then
		self.stateTimer_:Stop()

		self.stateTimer_ = nil
	end
end

function XH3rdFlipCardGameView:ResetAnimator(arg_29_1, arg_29_2)
	arg_29_1:Play(arg_29_2, 0, 0)
	arg_29_1:Update(0)

	arg_29_1.enabled = false
end

function XH3rdFlipCardGameView:OnSceneLoaded()
	self.sceneLoaded_ = true

	self:InitCard()
end

function XH3rdFlipCardGameView:InitCard()
	if #XH3rdFlipCardData.data.unlock_card_list < 6 then
		XH3rdFlipCardTool:SetCardNum(4, 2)
	elseif #XH3rdFlipCardData.data.unlock_card_list >= 6 and #XH3rdFlipCardData.data.unlock_card_list < 9 then
		XH3rdFlipCardTool:SetCardNum(6, 2)
	else
		XH3rdFlipCardTool:SetCardNum(6, 3)
	end

	XH3rdFlipCardTool:InitGame()
end

function XH3rdFlipCardGameView:SetUIText()
	local var_32_0 = XH3rdFlipCardTool:GetGameState()

	if var_32_0 == GameStatus.Observing then
		self.timeTitleText_.text = GetTips("ACTIVITY_FLIP_CARD_TIME_NAME_1")
	elseif var_32_0 == GameStatus.Flipping then
		self.timeTitleText_.text = GetTips("ACTIVITY_FLIP_CARD_TIME_NAME_2")
	end
end

function XH3rdFlipCardGameView:CheckGameStatus()
	local var_33_0 = XH3rdFlipCardTool:GetGameState()

	if var_33_0 ~= GameStatus.Observing and self.startTimeTimer then
		self.startTimeTimer:Stop()

		self.startTimeTimer = nil
	end

	if var_33_0 == GameStatus.Observing then
		self.leftTimeText_.text = XH3rdFlipCardTool:GetObservingLeftTime()
	elseif var_33_0 == GameStatus.Flipping then
		if not self.isShowStartTips then
			SetActive(self.startPopImg_, true)
			manager.audio.PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_start_auto")

			self.isShowStartTips = true
			self.showTimer = Timer.New(function()
				SetActive(self.startPopImg_, false)

				self.showTimer = nil
			end, 0.6, 1, true)

			self.showTimer:Start()
		end

		self.leftTimeText_.text = XH3rdFlipCardTool:GetFlippingLeftTime()
	end

	if self.lastGameStatu ~= var_33_0 then
		if var_33_0 == GameStatus.GameOver then
			local var_33_1 = XH3rdFlipCardTool.GetIsSuccess()

			if var_33_1 then
				manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter")
				manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_bingo")
			else
				manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_fail")
				manager.audio:PlayEffect("minigame_activity_2_8", "minigame_activity_2_8_dati_error")
			end

			XH3rdFlipCardAction:sendSettleFlipCardGameRequest(self.activityId, var_33_1, XH3rdFlipCardTool:GetUseTime(), (XH3rdFlipCardTool:GetFlipCardCount()))
		elseif var_33_0 == GameStatus.Observing then
			self.startTimeTimer = Timer.New(function()
				local var_35_0 = XH3rdFlipCardTool:GetObservingLeftTime()

				if XH3rdFlipCardTool:GetGameState() ~= GameStatus.Observing then
					self.startTimeTimer:Stop()

					self.startTimeTimer = nil

					return
				end

				if var_35_0 >= 1 then
					manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_time01")
				elseif var_35_0 < 1 then
					manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_time02")
					self.startTimeTimer:Stop()

					self.startTimeTimer = nil
				end
			end, 1, -1, true)

			self.startTimeTimer:Start()
		elseif var_33_0 == GameStatus.Paused then
			manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_flip_enter", "")
			self:RefreshPausedStateUI()

			self.isShowStartTips = false
		elseif var_33_0 == GameStatus.Flipping then
			-- block empty
		end

		self:SetUIText()
		self.statusController:SetSelectedIndex(var_33_0)

		self.lastGameStatu = var_33_0
	end
end

function XH3rdFlipCardGameView:RefreshPausedStateUI()
	self.clueText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_CLUE_COLLECTION_PROGRESS"), #XH3rdFlipCardData:GetClueList(self.activityId), #FlipCardCfg[self.activityId].details)
	self.tokenImg_.sprite = ItemTools.getItemSprite(FlipCardCfg[self.activityId].cost_id)
	self.startItemImg_.sprite = ItemTools.getItemSprite(FlipCardCfg[self.activityId].cost_id)
	self.tokenNumberText_.text = ItemTools.getItemNum(FlipCardCfg[self.activityId].cost_id)

	local var_36_0 = #XH3rdFlipCardData.data.unlock_card_list + #XH3rdFlipCardData.data.new_card_list
	local var_36_1 = false

	if #XH3rdFlipCardData.data.unlock_card_list + #XH3rdFlipCardData.data.new_card_list < 6 then
		self.clueNumText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_11_UNLOCK_CLUE"), 2)
		self.clueProgressNum_.text = #XH3rdFlipCardData:GetClueList(self.activityId) .. "/2"
		var_36_1 = #XH3rdFlipCardData:GetClueList(self.activityId) == 2
	elseif var_36_0 >= 6 and var_36_0 < 9 then
		self.clueNumText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_11_UNLOCK_CLUE"), 4)
		self.clueProgressNum_.text = #XH3rdFlipCardData:GetClueList(self.activityId) .. "/4"
		var_36_1 = #XH3rdFlipCardData:GetClueList(self.activityId) == 4
	else
		self.clueNumText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_EXPLAIN_3_11_UNLOCK_CLUE"), 4)
		self.clueProgressNum_.text = #XH3rdFlipCardData:GetClueList(self.activityId) .. "/4"
	end

	self.clueController_:GetController("achieve"):SetSelectedState(tostring(var_36_1))
	self:SetUnlockTimeText()
	SetActive(self.clueGo_, var_36_0 < 9)
	SetActive(self.unlockGo_, var_36_0 == 9)

	self.cardNumText_.text = var_36_0 .. "/" .. #FlipCardCfg[self.activityId].normal_card + #FlipCardCfg[self.activityId].special_card

	self:CheckHasNewCard()
end

function XH3rdFlipCardGameView:SetUnlockTimeText()
	local var_37_0 = #XH3rdFlipCardData.data.unlock_card_list + #XH3rdFlipCardData.data.new_card_list
	local var_37_1 = 1

	if #XH3rdFlipCardData.data.unlock_card_list + #XH3rdFlipCardData.data.new_card_list < 6 then
		var_37_1 = 1
	elseif var_37_0 < 9 then
		var_37_1 = 2
	end

	self.timeUnlockText_.text = ""

	if XH3rdFlipCardData:GetUnOpenActivtiyTimeText(var_37_1) then
		self.timeUnlockText_.text = XH3rdFlipCardData:GetUnOpenActivtiyTimeText(var_37_1)
	end

	SetActive(self.timeUnlockGo_, var_37_0 < 9 and var_37_0 >= 6)
	self.timeUnlockController_:GetController("achieve"):SetSelectedState(tostring(not XH3rdFlipCardData:GetUnOpenActivtiyTimeText(var_37_1)))
end

function XH3rdFlipCardGameView:CheckHasNewCard()
	if #XH3rdFlipCardData:GetNewCardList() > 0 then
		JumpTools.OpenPageByJump("cORGflipCardUnlockCardPop")
	end
end

function XH3rdFlipCardGameView:RefreshGameOverStateUI(arg_39_1)
	JumpTools.OpenPageByJump("cORGflipCardResultPop", {
		clueID = arg_39_1
	})
end

function XH3rdFlipCardGameView:UnLoadFlipCardScene()
	self.sceneLoaded_ = false

	manager.ui:ResetMainCamera()

	manager.ui.mainCameraCom_.orthographic = false

	XH3rdFlipCardTool:UnLoadScene()
end

function XH3rdFlipCardGameView:OnExit()
	self:StopTimer()
	manager.notify:RemoveListener(FLIP_CARD_GAME_RESULT, self.refreshHandler_)
	manager.notify:RemoveListener(FLIP_CARD_START_GAME_RESULT, function()
		self.hasSendStartRequest = false
	end)
	manager.notify:RemoveListener(FLIP_CARD_VIEW_CARD_RESULT, function()
		self:InitCard()
	end)
	manager.notify:RemoveListener(FLIP_CARD_UPDATE_DATA, self.updateHandler_)

	if self.startTimeTimer then
		self.startTimeTimer:Stop()

		self.startTimeTimer = nil
	end

	self.refreshHandler_ = nil

	manager.redPoint:unbindUIandKey(self.rewardBtnTrans_, string.format("%s_%s_mainTask", RedPointConst.ACTIVITY_2_2_FLIP_CARD, ActivityCfg[self.activityId].sub_activity_list[#ActivityCfg[self.activityId].sub_activity_list]))
	manager.redPoint:unbindUIandKey(self.clueBtnTrans_, string.format("%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, self.activityId))
	manager.redPoint:unbindUIandKey(self.startBtn_.transform, string.format("%s_%s_canGetClue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, self.activityId))
end

return XH3rdFlipCardGameView
