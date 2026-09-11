local TetrisGameStageView = class("TetrisGameStageView", ReduxView)

function TetrisGameStageView:UIName()
	return "Widget/Version/Alone_TetrisGameUI/TetrisGamePlayUI"
end

function TetrisGameStageView:UIParent()
	return manager.ui.uiMain.transform
end

function TetrisGameStageView:Init()
	self:InitUI()
end

function TetrisGameStageView:InitUI()
	self:BindCfgUI()
	self:AddUIListener()

	self.skillController = self.controller:GetController("skill")
	self.roundController = self.controller:GetController("round")
	self.machineController = self.controller:GetController("machine")
	self.machineLiziController = self.controller:GetController("machineLizi")
	self.countController = self.controller:GetController("count")
	self.addNumController = self.controller:GetController("score")
	self.comboController = self.controller:GetController("combo")
	self.overController = self.controller:GetController("gameOver")
	self.gameDescController = self.controller:GetController("GameObjective")
	self.roundProgressController = self.controller:GetController("roundProgress")
	self.ultimateController = self.controller:GetController("ultimate")
	self.useUltimateController = self.controller:GetController("Magnification")
	self.remainBlockController = self.controller:GetController("RemainingBlock")
	self.remainLockController = self.controller:GetController("RemainingDesignated")
	self.skillList = LuaList.New(handler(self, self.indexSkill), self.uilistGo_, TetrisGameSkillIconItem)
	self.effectList = {}
	self.effectPosList = {}

	for iter_4_0 = 1, self.effectposnodeTrs_.childCount do
		self.effectPosList[iter_4_0] = self.effectposnodeTrs_:GetChild(iter_4_0 - 1)
	end

	self.scoreItemIndex = 1
	self.tilespacePos = self.tilespaceTrs_.localPosition
	self.blockSpaceList = {}

	for iter_4_1 = 1, 3 do
		self.blockSpaceList[iter_4_1] = TetrisGameBlockSpaceItem.New(self["blockGo_" .. iter_4_1], iter_4_1, self)
	end

	self.progressAniList = {}

	for iter_4_2 = 1, 3 do
		self.progressAniList[iter_4_2] = self[string.format("progressAni%s_", iter_4_2)]
	end

	self.ultimateIcon_.sprite = TetrisGameTools:GetSkillIcon(TetrisGameConst.ultimateID)
	self.ultimateUseTxt_.text = GetTips("TETRIS_GAME_SKILL_USE_ULTIMATE_TIPS")
end

function TetrisGameStageView:OnEnter()
	self.stageID = self.params_.stageID
	self.activityID = TetrisGameData:GetCurActivityID()
	self.callBack = self.params_.callBack

	self:RegisterEvents()

	if self.callBack then
		self.callBack(self.stageGo)
	end

	self.callBack = nil

	self:RefreshView()
end

function TetrisGameStageView:AddUIListener()
	self:AddBtnListener(self.ultimateBtn_, nil, function()
		local var_7_0 = TetrisGameRunTimeManager:GetBlackBoard()

		if var_7_0.isOpenCreateGoalChip then
			ShowTips("TETRIS_GAME_SKILL_UESING")

			return
		end

		if var_7_0.goalRemainChargeValue > 0 then
			ShowTips("TETRIS_GAME_SKILL_PREPARING")

			return
		end

		TetrisGameRunTimeManager:UseCreateGoalChip()
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_block_skill", "")
		self:RefreshBlackBoardData()
	end)
	self:AddBtnListener(self.ultimateCheckBtn_, nil, function()
		JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
			stageID = -1,
			inGame = true,
			skillList = {
				TetrisGameConst.skillType.createGoalChip
			}
		})
	end)
	self:AddBtnListener(self.skillbtnareaBtn_, nil, function()
		JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
			inGame = true,
			stageID = self.stageID,
			skillID = self.skillIDList[1]
		})
	end)
end

function TetrisGameStageView:RemoveScoreTween(arg_10_1)
	if arg_10_1.tween then
		arg_10_1.tween:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(arg_10_1.tween.id)

		arg_10_1.tween = nil
	end
end

function TetrisGameStageView:CreateEffectItem(arg_11_1)
	local var_11_0 = {}

	var_11_0.gameObject = Object.Instantiate((arg_11_1 or nil) and (self.ui_trail_yellowGo_ or self.ui_trail_blueGo_), self.effectnodeTrs_)

	SetActive(var_11_0.gameObject, false)

	var_11_0.transform = var_11_0.gameObject.transform
	var_11_0.isCanUse = true
	var_11_0.isHighScore = arg_11_1
	var_11_0.index = self.scoreItemIndex

	table.insert(self.effectList, var_11_0)

	self.scoreItemIndex = self.scoreItemIndex + 1

	return var_11_0
end

function TetrisGameStageView:ShowScoreTween(arg_12_1, arg_12_2)
	if arg_12_1 <= 10 then
		return
	end

	local var_12_0 = arg_12_1 >= 50
	local var_12_1

	if arg_12_1 >= 50 then
		var_12_1 = 7 + math.floor((arg_12_1 - 50) / 20)
		var_12_1 = math.min(var_12_1, 11)
	else
		var_12_1 = 2 + math.floor(arg_12_1 / 10)
	end

	local var_12_2 = {}

	for iter_12_0, iter_12_1 in pairs(self.effectList or {}) do
		if iter_12_1.isCanUse == true and iter_12_1.isHighScore == var_12_0 then
			table.insert(var_12_2, iter_12_1)
		end

		if var_12_1 <= #var_12_2 then
			break
		end
	end

	for iter_12_2 = 1, var_12_1 - #var_12_2 do
		table.insert(var_12_2, self:CreateEffectItem(var_12_0))
	end

	self:PlayScoreTween(var_12_2, arg_12_2)
end

function TetrisGameStageView:PlayScoreTween(arg_13_1, arg_13_2)
	local var_13_0 = self.effectnodeTrs_:InverseTransformPoint(self.scoreText.transform.position)

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_1 = self.effectPosList[math.random(1, arg_13_2)].transform.localPosition
		local var_13_2 = var_13_1 + Vector3(math.random(-20, 20), math.random(-20, 20), 0)
		local var_13_3 = Mathf.Max(Mathf.Abs(var_13_1.y), 200)
		local var_13_4 = math.random(var_13_3, var_13_3 + var_13_3 / 2)
		local var_13_5

		if var_13_1.y > 0 then
			var_13_4 = -var_13_4
			var_13_5 = Mathf.Lerp(var_13_2.x, var_13_0.x, math.random(50, 100) / 100)
		end

		local var_13_6 = var_13_2 + Vector3(math.random(20, 50), var_13_4, 0)
		local var_13_7 = var_13_2 + Vector3(var_13_5, var_13_4, 0)
		local var_13_8 = iter_13_0 * -0.05

		iter_13_1.isCanUse = false
		iter_13_1.tween = LeanTween.value(iter_13_0 * -0.05, 1, math.random(0.2, 0.4) + 0.1 * iter_13_0):setOnUpdate(LuaHelper.FloatAction(function(arg_14_0)
			if arg_14_0 > 0 then
				iter_13_1.transform.localPosition = Vector2((1 - arg_14_0) * (1 - arg_14_0) * (1 - arg_14_0) * var_13_2.x + 3 * (1 - arg_14_0) * (1 - arg_14_0) * arg_14_0 * var_13_6.x + 3 * (1 - arg_14_0) * arg_14_0 * arg_14_0 * var_13_7.x + arg_14_0 * arg_14_0 * arg_14_0 * var_13_0.x, (1 - arg_14_0) * (1 - arg_14_0) * (1 - arg_14_0) * var_13_2.y + 3 * (1 - arg_14_0) * (1 - arg_14_0) * arg_14_0 * var_13_6.y + 3 * (1 - arg_14_0) * arg_14_0 * arg_14_0 * var_13_7.y + arg_14_0 * arg_14_0 * arg_14_0 * var_13_0.y)

				if var_13_8 <= 0 then
					SetActive(iter_13_1.gameObject, true)
				end
			end

			var_13_8 = arg_14_0
		end)):setOnComplete(LuaHelper.VoidAction(function()
			if iter_13_0 == 1 then
				self.scorenumAni_:Play("UI_TetrisGameMachineUI_special", 0, 0)
			end

			SetActive(iter_13_1.gameObject, false)

			iter_13_1.isCanUse = true
		end)):setEase(LeanTweenType.easeOutCubic)
	end
end

function TetrisGameStageView:RemoveShakeTween()
	if self.shakeTween then
		self.shakeTween:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(self.shakeTween.id)

		self.shakeTween = nil
	end
end

function TetrisGameStageView:PlayShakeTween(arg_17_1)
	if arg_17_1 <= 10 then
		return
	end

	local var_17_0 = {
		x = {
			1,
			0,
			-1,
			-1,
			1,
			0,
			1,
			1,
			-1,
			0
		},
		y = {
			1,
			-2,
			2,
			-1,
			1,
			0,
			-1,
			0,
			1,
			0
		}
	}
	local var_17_1
	local var_17_3

	if arg_17_1 >= 100 then
		var_17_1 = 5
		var_17_3 = 1.5
	elseif arg_17_1 >= 50 then
		var_17_1 = 3
		var_17_3 = 1
	else
		var_17_1 = 2
		var_17_3 = 0.8
	end

	self.shakeTween = LeanTween.value(1, #var_17_0.x - 1, var_17_3):setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
		local var_18_0 = math.floor(arg_18_0)

		self.tilespaceTrs_.localPosition = self.tilespacePos + Vector3(Mathf.Lerp(var_17_0.x[var_18_0 - 1] or 0, var_17_0.x[var_18_0], arg_18_0 - var_18_0) * var_17_1, Mathf.Lerp(var_17_0.y[var_18_0 - 1] or 0, var_17_0.y[var_18_0], arg_18_0 - var_18_0) * var_17_1, 0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self.tilespaceTrs_.localPosition = self.tilespacePos
	end)):setEase(LeanTweenType.easeOutCubic)
end

function TetrisGameStageView:UpdateScore()
	local var_20_0 = TetrisGameRunTimeManager:GetCurRoundBoard()
	local var_20_1 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()

	self:ShowScoreTween(var_20_0.addScore, var_20_0.curRoundDisposeNum)
	self:PlayShakeTween(var_20_0.addScore)
	self:DelScoreTimer()
	SetActive(self.addmarksGo_, true)

	self.textaddmarksText_.text = var_20_0.addScore
	self.textcombo01Text_.text = placeScore
	self.scoreTimer = Timer.New(function()
		SetActive(self.comboGo_, false)
		SetActive(self.addmarksGo_, false)
	end, 1.5)

	self.scoreTimer:Start()
end

function TetrisGameStageView:DelScoreTimer()
	SetActive(self.comboGo_, false)
	SetActive(self.addmarksGo_, false)

	if self.scoreTimer then
		self.scoreTimer:Stop()

		self.scoreTimer = nil
	end
end

function TetrisGameStageView:RegisterEvents()
	self:RegistEventListener(TETRIS_GAME_ROUND_END, function()
		self:RefreshBlackBoardData()
		self:RefreshBlockSpaceList()
	end)
	self:RegistEventListener(TETRIS_GAME_TIMER_UPDATE, function(arg_25_0)
		local var_25_0 = TetrisGameRunTimeManager:GetBlackBoard()

		if var_25_0.totalTime > 0 then
			self.roundText.text = GetTips("REMAINING_TIME") .. math.max(0, (math.ceil(var_25_0.totalTime - var_25_0.usedTime)))
		end
	end)
	self:RegistEventListener(TETRIS_GAME_START_GAME, function()
		self:OnStartGame()
	end)
end

function TetrisGameStageView:CheckIsLose()
	local var_27_0 = TetrisGameRunTimeManager:GetBlackBoard()

	if var_27_0.resultFlag == false or (ActivityTetrisGameStageCfg[self.stageID].type == TetrisGameConst.stageType.endLess and ActivityTetrisGameStageCfg[var_27_0.stageID].time > 0 and ActivityTetrisGameStageCfg[var_27_0.stageID].time - var_27_0.usedTime > 0) == true then
		return true
	else
		return false
	end
end

function TetrisGameStageView:OnGameEndUpdate(arg_28_1, arg_28_2)
	self:DisposeComboTimer()
	self:DelOverTimer()

	if arg_28_1 then
		self.gameOverTimer = Timer.New(function()
			JumpTools.OpenPageByJump("tetrisGameScorePopView", {
				stageID = self.stageID
			})
		end, 0.1)

		self.gameOverTimer:Start()
		TetrisGameBridge.OverGameEnd()
	elseif self:CheckIsLose() then
		self.overController:SetSelectedState("true")

		self.gameOverTimer = Timer.New(function()
			JumpTools.OpenPageByJump("tetrisGameScorePopView", {
				stageID = self.stageID
			})
		end, 2.2)

		self.gameOverTimer:Start()
		TetrisGameBridge.OverGameEnd()
	else
		JumpTools.OpenPageByJump("tetrisGameScorePopView", {
			stageID = self.stageID,
			first_clear = arg_28_2
		})
	end
end

function TetrisGameStageView:DelOverTimer()
	if self.gameOverTimer then
		self.gameOverTimer:Stop()

		self.gameOverTimer = nil
	end
end

function TetrisGameStageView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:StopTimer()
	self:DelOverTimer()
	self:DelScoreTimer()

	if self.roundAniTimer then
		self.roundAniTimer:Stop()

		self.roundAniTimer = nil
	end

	SetActive(self.progressBloomGo_, false)
end

function TetrisGameStageView:OnTop()
	self:RefreshBar()
end

function TetrisGameStageView:SendCancelSDK()
	local var_34_0 = TetrisGameRunTimeManager:GetBlackBoard()

	if not var_34_0 then
		return
	end

	local var_34_1 = {}

	for iter_34_0, iter_34_1 in pairs(var_34_0.skillUseTimes or {}) do
		table.insert(var_34_1, {
			iter_34_0,
			iter_34_1
		})
	end

	SDKTools.SendMessageToSDK("activity_combat_over", {
		result = 3,
		activity_id = TetrisGameData:GetCurActivityID(),
		stage_id = var_34_0.stageID,
		score = var_34_0.totalScore,
		use_seconds = var_34_0.usedTime,
		battle_times = var_34_0.usedRound,
		skill_list = var_34_1
	})
end

function TetrisGameStageView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if self.startTimer then
			return
		end

		if TetrisGameBridge.CheckIsHaveDragging() then
			return
		end

		local var_36_0 = TetrisGameRunTimeManager:GetBlackBoard()

		if var_36_0 and var_36_0.isGameEnd then
			return
		end

		TetrisGameRunTimeManager:PauseGame(true)

		if ActivityTetrisGameStageCfg[self.stageID].type == TetrisGameConst.stageType.endLess then
			ShowMessageBox({
				content = GetTips("ACTIVITY_TETRIS_GAME_SPECIAL_END"),
				OkCallback = function()
					TetrisGameRunTimeManager:EndGame(false, true, true)
				end,
				CancelCallback = function()
					TetrisGameRunTimeManager:PauseGame(false)
				end
			})
		else
			ShowMessageBox({
				content = GetTips("ACTIVITY_TETRIS_GAME_NOEMAL_END"),
				OkCallback = function()
					self:SendCancelSDK()
					TetrisGameRunTimeManager:EndGame(true)
					TetrisGameRunTimeManager:ExitGame()
					JumpTools.OpenPageByJump("/tetrisGameChooseStageView", {
						chapterID = ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[self.stageID][1],
						stageID = self.stageID
					})
				end,
				CancelCallback = function()
					TetrisGameRunTimeManager:PauseGame(false)
				end
			})
		end
	end)
end

function TetrisGameStageView:OnStartGame()
	self.lastRaminBoradCount = -1
	self.stageID = TetrisGameRunTimeManager:GetBlackBoard().stageID

	self:DisposeComboTimer()
	self:DelScoreTimer()

	self.machineSlider.value = 0
	self.ultimateSlider_.value = 0

	TetrisGameRunTimeManager:SetMachineInfoState(self.machineSlider.value >= 1)
	self:RefreshView()
	self.machinenodeAni_:Play("UI_TetrisGameMachineUI_normal", 0, 0)
	self.machineLiziController:SetSelectedState("hide")
	self.overController:SetSelectedState("false")
	TetrisGameRunTimeManager:StartGame()

	self.guideTimer_ = Timer.New(function()
		if not manager.guide:IsPlaying() then
			self.guideTimer_:Stop()

			self.guideTimer_ = nil

			if #self.skillIDList > 0 then
				JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
					inGame = true,
					stageID = self.stageID,
					skillID = self.skillIDList[1],
					closeCallBack = function()
						self:OpenCountDown()
						self:RealCheckWeakGuide()
					end
				})
			else
				self:OpenCountDown()
			end

			for iter_42_0, iter_42_1 in pairs(self.progressAniList) do
				iter_42_1:Play("UI_progress_cx", 0, 1)
			end
		end
	end, 0.1, -1)

	self.guideTimer_:Start()
end

function TetrisGameStageView:OpenCountDown()
	self:StopTimer()
	self.countController:SetSelectedState("false")
end

function TetrisGameStageView:RefreshView()
	self:UpdataViewState()
	self:RefreshBlackBoardData()
	self:RefreshBlockSpaceList()
end

function TetrisGameStageView:RefreshBlockSpaceList()
	for iter_46_0, iter_46_1 in pairs(self.blockSpaceList) do
		iter_46_1:RefreshUI()
	end
end

function TetrisGameStageView:RefreshMachineSlider(arg_47_1)
	self:RemoveTween()

	local var_47_0 = self.machineSlider.value
	local var_47_1 = self.machineSlider.value
	local var_47_2 = 0.14

	self.machineTween = LeanTween.value(self.machineGo_, 0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
		local var_48_0 = Mathf.Lerp(var_47_0, arg_47_1, arg_48_0)

		self.machineSlider.value = var_48_0
		self.ultimateSlider_.value = var_48_0

		if var_47_1 > var_47_2 and var_48_0 < var_47_2 then
			self.machineLiziController:SetSelectedState("hide")
		end

		if var_47_1 < var_47_2 and var_48_0 > var_47_2 then
			self.machineLiziController:SetSelectedState("show")
		end

		var_47_1 = var_48_0
	end)):setOnComplete(LuaHelper.VoidAction(function()
		self:RemoveTween()

		self.machineSlider.value = arg_47_1
		self.ultimateSlider_.value = arg_47_1
	end)):setEase(LeanTweenType.linear)

	TetrisGameRunTimeManager:SetMachineInfoState(arg_47_1 >= 1)
end

function TetrisGameStageView:RefreshMachineText()
	local var_50_0 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()
	local var_50_1, var_50_2 = TetrisGameRunTimeManager:GetCurScoreRate()

	self.machineText.text = ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[self.stageID][1] == 2 and "" or "x" .. var_50_1

	if var_50_1 > 1 then
		local var_50_3 = self.machinenodeAni_:GetCurrentAnimatorClipInfo(0)

		self.machinenodeAni_:Play("UI_TetrisGameMachineUI_special", 0, 0)
	else
		self.machinenodeAni_:Play("UI_TetrisGameMachineUI_normal", 0, 0)
	end
end

function TetrisGameStageView:RemoveTween()
	if self.machineTween then
		self.machineTween:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(self.machineGo_)

		self.machineTween = nil
	end
end

function TetrisGameStageView:UpdateRoundShow(arg_52_1)
	self.roundText.text = arg_52_1.totalTime > 0 and GetTips("REMAINING_TIME") .. math.max(0, (math.ceil(arg_52_1.totalTime - arg_52_1.usedTime))) or arg_52_1.finishType == TetrisGameConst.finishType.chipCount and string.format(GetTips("TETRIS_GAME_ROUND"), arg_52_1.usedRound + (self.isPlayRoundAni and -1 or 0)) or string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN"), arg_52_1.usedRound + (self.isPlayRoundAni and -1 or 0), arg_52_1.finish_condition)

	if arg_52_1.finishType == TetrisGameConst.finishType.chipCount then
		if arg_52_1.finish_condition - arg_52_1.useChipCount <= GameSetting.tetris_game_chip_remain_count.value[1] then
			if self.lastRaminBoradCount ~= arg_52_1.finish_condition - arg_52_1.useChipCount then
				self.blockRemainAni_:Play("UI_red_cx", 0, 0)

				self.lastRaminBoradCount = arg_52_1.finish_condition - arg_52_1.useChipCount
			end

			self.remainBlockController:SetSelectedState("insufficient")
		else
			self.remainBlockController:SetSelectedState("normal")
		end
	else
		self.remainBlockController:SetSelectedState("insufficient")
	end
end

function TetrisGameStageView:RefreshBlackBoardData()
	local var_53_0 = TetrisGameRunTimeManager:GetBlackBoard()
	local var_53_1 = TetrisGameRunTimeManager:GetCurRoundBoard()
	local var_53_2 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()

	self:UpdateRoundProgress()

	if var_53_0 then
		self.scoreText.text = var_53_0.totalScore

		self.roundController:SetSelectedState("blue")

		if var_53_0.totalTime > 0 or var_53_0.finishType == TetrisGameConst.finishType.chipCount then
			if var_53_0.finishType ~= TetrisGameConst.finishType.chipCount then
				self.roundController:SetSelectedState("red")
			end

			self.gameDescController:SetSelectedState("infinite")
		else
			self.gameDescController:SetSelectedState("normal")
		end

		self:UpdateRoundShow(var_53_0)

		if var_53_1 and var_53_1.addScore > 0 then
			self:UpdateScore()
		end

		self:RefreshMachineText()

		if not var_53_2.chargeTimer and var_53_2.chargeFlag then
			if self.machineSlider.value ~= 1 and var_53_0.chargeNum == var_53_0.chargeNumMax then
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_block_ratio_up", "")
			end

			if self.machineSlider.value > 0 and var_53_0.chargeNum == 0 then
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_block_ratio_down", "")
			end

			self:RefreshMachineSlider(var_53_0.chargeNumMax == 0 and 0 or var_53_0.chargeNum / var_53_0.chargeNumMax)
		end

		if var_53_0.finishType == TetrisGameConst.finishType.chipCount then
			self.remainCanPlaceChip_.text = var_53_0.finish_condition - var_53_0.useChipCount
		end

		if var_53_2.isUseCreateGoalChip then
			if var_53_0.isOpenCreateGoalChip then
				self.ultimateController:SetSelectedState("using")
				self.useUltimateController:SetSelectedState("exceed")
			else
				self.useUltimateController:SetSelectedState("normal")

				if var_53_0.goalRemainChargeValue > 0 then
					self.ultimateController:SetSelectedState("charge")
				else
					self.ultimateController:SetSelectedState("normal")
				end

				self.ultimateChargeValue_.text = var_53_0.goalRemainChargeValue
				self.ultimateProgress_.fillAmount = (var_53_2.goalChargeNeedValue - var_53_0.goalRemainChargeValue) / var_53_2.goalChargeNeedValue
			end
		else
			self.useUltimateController:SetSelectedState("normal")
			self.ultimateController:SetSelectedState("none")
		end
	end

	self:RefreshSkillIconList()
	self:RefreshLockRemain(var_53_0, var_53_2)
end

function TetrisGameStageView:RefreshSkillIconList()
	for iter_54_0, iter_54_1 in pairs((self.skillList:GetItemList())) do
		iter_54_1:RefreshCountShow()
	end
end

function TetrisGameStageView:RefreshLockRemain(arg_55_1, arg_55_2)
	if arg_55_1.isUseLock then
		self.remainLockController:SetSelectedState("on")

		self.lockRemainCountTxt_.text = string.format(GetTips("TETRIS_GAME_SKILL_LOCK_NUM_TIPS"), arg_55_2.forceChangeChip and arg_55_2.lockExistRound - arg_55_1.lockRound + 1 or (arg_55_2.lockExistRound - arg_55_1.lockRound) * 3 + 3 - arg_55_1.usedLogicRound % 3)
	else
		self.remainLockController:SetSelectedState("off")
	end
end

function TetrisGameStageView:UpdateRoundProgress(arg_56_1)
	local var_56_0 = TetrisGameRunTimeManager:GetBlackBoard()
	local var_56_1 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()

	if var_56_1 and var_56_1.forceChangeChip then
		self.roundProgressController:SetSelectedState("hide")
		self:PlaysForceRoundAni()
	elseif var_56_0 then
		if var_56_0.usedLogicRound % 3 == 0 then
			if var_56_0.usedLogicRound < 3 or arg_56_1 then
				self.roundProgressController:SetSelectedState("normal")
			else
				self.roundProgressController:SetSelectedState("three")
				self.progressAniList[3]:Play("UI_progress_cx", 0, 0)
				self:PlayRoundAni()
			end
		elseif var_56_0.usedLogicRound % 3 == 1 then
			self.roundProgressController:SetSelectedState("one")
			self.progressAniList[1]:Play("UI_progress_cx", 0, 0)
		elseif var_56_0.usedLogicRound % 3 == 2 then
			self.roundProgressController:SetSelectedState("two")
			self.progressAniList[2]:Play("UI_progress_cx", 0, 0)
		end
	else
		self.roundProgressController:SetSelectedState("normal")
	end
end

function TetrisGameStageView:PlayRoundAni()
	if self.roundAniTimer then
		self.roundAniTimer:Stop()

		self.roundAniTimer = nil
	end

	SetActive(self.progressBloomGo_, false)

	self.isPlayRoundAni = true
	self.roundAniTimer = Timer.New(function()
		SetActive(self.progressBloomGo_, true)
		self:UpdateRoundProgress(true)

		self.isPlayRoundAni = false

		self:UpdateRoundShow(TetrisGameRunTimeManager:GetBlackBoard())
	end, 1)

	self.roundAniTimer:Start()
end

function TetrisGameStageView:PlaysForceRoundAni()
	SetActive(self.progressBloomGo_, false)
	SetActive(self.progressBloomGo_, true)
end

function TetrisGameStageView:OnComboTimerUpdate()
	self:DisposeComboTimer()

	local var_60_0 = ActivityTetrisGameSkillCfg[TetrisGameConst.skillType.combom].params_2[1]
	local var_60_1 = ActivityTetrisGameSkillCfg[TetrisGameConst.skillType.combom].params_2[1]
	local var_60_2 = TetrisGameRunTimeManager:GetBlackBoard()
	local var_60_3 = TetrisGameRunTimeManager:GetCurRoundBoard()

	var_60_2.comboTime = ActivityTetrisGameSkillCfg[TetrisGameConst.skillType.combom].params_2[1]
	self.comboTimer = Timer.New(function()
		if not var_60_2.pauseGameFlag then
			var_60_1 = var_60_1 - 0.1
			var_60_2.comboTime = var_60_1

			self:RefreshMachineSlider(math.max(var_60_1 / var_60_0, 0))

			if var_60_1 <= 0 then
				self:DisposeComboTimer()

				var_60_2.comboCount = 0
				var_60_2.chargeNum = 0

				TetrisGameRunTimeManager:UpdateComboScoreRateCompute()
				self:RefreshMachineText()
			end
		end
	end, 0.1, -1)

	self.comboTimer:Start()
	SetActive(self.machinenEffectObj_, true)
end

function TetrisGameStageView:DisposeComboTimer()
	if self.comboTimer then
		self.comboTimer:Stop()

		self.comboTimer = nil
	end

	SetActive(self.machinenEffectObj_, false)

	if self.comboEffectTimer then
		self.comboEffectTimer:Stop()

		self.comboEffectTimer = nil
	end
end

function TetrisGameStageView:UpdataViewState()
	local var_63_0 = TetrisGameRunTimeManager:GetBlackBoard()

	if var_63_0 then
		self.machineController:SetSelectedState("off")

		if TetrisGameRunTimeManager:GetSkillEffectBlackBoard().chargeFlag then
			self.machineController:SetSelectedState("on")
		end

		local var_63_1 = TetrisGameRunTimeManager:GetSkillBlackBoard()

		self:RefreshSkillList()

		local var_63_2 = 0

		for iter_63_0, iter_63_1 in pairs(var_63_1) do
			if ActivityTetrisGameSkillCfg[iter_63_0].type == TetrisGameConst.skillUseType.normal then
				var_63_2 = var_63_2 + 1
			end
		end

		if var_63_2 == 0 then
			self.skillController:SetSelectedState("off")
		else
			self.skillController:SetSelectedState("on")
		end

		if var_63_0.totalTime <= 0 then
			self.roundText.text = GetTips("TETRIS_GAME_UNLIMITE_TIME")
		end
	end
end

function TetrisGameStageView:StopTimer()
	if self.startTimer then
		self.startTimer:Stop()

		self.startTimer = nil
	end

	if self.guideTimer_ then
		self.guideTimer_:Stop()

		self.guideTimer_ = nil
	end
end

function TetrisGameStageView:RefreshSkillList()
	self.skillIDList = {}
	self.skillIDList = ActivityTetrisGameStageCfg[self.stageID].type == TetrisGameConst.stageType.endLess and TetrisGameData:GetSkillList() or ActivityTetrisGameStageCfg[self.stageID].skill_list

	self.skillList:StartScroll(#self.skillIDList)

	if ActivityTetrisGameStageCfg[self.stageID].type == TetrisGameConst.stageType.endLess then
		TetrisGameRunTimeManager:InitRecordSkillUse(TetrisGameData:GetEndlessSkillList())
	else
		TetrisGameRunTimeManager:InitRecordSkillUse(self.skillIDList)
	end
end

function TetrisGameStageView:indexSkill(arg_66_1, arg_66_2)
	arg_66_2:RefreshUI(self.skillIDList[arg_66_1])
	arg_66_2:RegisterClickFunc(handler(self, self.ClickSkillItem))
end

function TetrisGameStageView:ClickSkillItem(arg_67_1)
	if TetrisGameBridge.CheckIsHaveDragging() then
		return
	end

	JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
		inGame = true,
		stageID = self.stageID,
		skillID = arg_67_1
	})
end

function TetrisGameStageView:CheckWeakGuide()
	return
end

function TetrisGameStageView:Dispose()
	self:StopTimer()
	self:DisposeComboTimer()
	self:DelScoreTimer()
	self:RemoveTween()
	self:RemoveShakeTween()

	for iter_69_0, iter_69_1 in ipairs(self.effectList) do
		self:RemoveScoreTween(iter_69_1)
	end

	if self.skillList then
		self.skillList:Dispose()

		self.skillList = nil
	end

	if self.blockSpaceList then
		for iter_69_2, iter_69_3 in pairs(self.blockSpaceList) do
			iter_69_3:Dispose()
		end
	end

	TetrisGameStageView.super.Dispose(self)
end

return TetrisGameStageView
