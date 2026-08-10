local var_0_0 = class("TetrisGameStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_TetrisGameUI/TetrisGamePlayUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.skillController = arg_4_0.controller:GetController("skill")
	arg_4_0.roundController = arg_4_0.controller:GetController("round")
	arg_4_0.machineController = arg_4_0.controller:GetController("machine")
	arg_4_0.machineLiziController = arg_4_0.controller:GetController("machineLizi")
	arg_4_0.countController = arg_4_0.controller:GetController("count")
	arg_4_0.addNumController = arg_4_0.controller:GetController("score")
	arg_4_0.comboController = arg_4_0.controller:GetController("combo")
	arg_4_0.overController = arg_4_0.controller:GetController("gameOver")
	arg_4_0.gameDescController = arg_4_0.controller:GetController("GameObjective")
	arg_4_0.roundProgressController = arg_4_0.controller:GetController("roundProgress")
	arg_4_0.ultimateController = arg_4_0.controller:GetController("ultimate")
	arg_4_0.useUltimateController = arg_4_0.controller:GetController("Magnification")
	arg_4_0.remainBlockController = arg_4_0.controller:GetController("RemainingBlock")
	arg_4_0.remainLockController = arg_4_0.controller:GetController("RemainingDesignated")
	arg_4_0.skillList = LuaList.New(handler(arg_4_0, arg_4_0.indexSkill), arg_4_0.uilistGo_, TetrisGameSkillIconItem)
	arg_4_0.effectList = {}
	arg_4_0.effectPosList = {}

	for iter_4_0 = 1, arg_4_0.effectposnodeTrs_.childCount do
		arg_4_0.effectPosList[iter_4_0] = arg_4_0.effectposnodeTrs_:GetChild(iter_4_0 - 1)
	end

	arg_4_0.scoreItemIndex = 1
	arg_4_0.tilespacePos = arg_4_0.tilespaceTrs_.localPosition
	arg_4_0.blockSpaceList = {}

	for iter_4_1 = 1, 3 do
		local var_4_0 = arg_4_0["blockGo_" .. iter_4_1]

		arg_4_0.blockSpaceList[iter_4_1] = TetrisGameBlockSpaceItem.New(var_4_0, iter_4_1, arg_4_0)
	end

	arg_4_0.progressAniList = {}

	for iter_4_2 = 1, 3 do
		arg_4_0.progressAniList[iter_4_2] = arg_4_0[string.format("progressAni%s_", iter_4_2)]
	end

	arg_4_0.ultimateIcon_.sprite = TetrisGameTools:GetSkillIcon(TetrisGameConst.ultimateID)
	arg_4_0.ultimateUseTxt_.text = GetTips("TETRIS_GAME_SKILL_USE_ULTIMATE_TIPS")
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.stageID = arg_5_0.params_.stageID
	arg_5_0.activityID = TetrisGameData:GetCurActivityID()
	arg_5_0.callBack = arg_5_0.params_.callBack

	arg_5_0:RegisterEvents()

	if arg_5_0.callBack then
		arg_5_0.callBack(arg_5_0.stageGo)
	end

	arg_5_0.callBack = nil

	arg_5_0:RefreshView()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.ultimateBtn_, nil, function()
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
		arg_6_0:RefreshBlackBoardData()
	end)
	arg_6_0:AddBtnListener(arg_6_0.ultimateCheckBtn_, nil, function()
		JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
			stageID = -1,
			inGame = true,
			skillList = {
				TetrisGameConst.skillType.createGoalChip
			}
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.skillbtnareaBtn_, nil, function()
		JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
			inGame = true,
			stageID = arg_6_0.stageID,
			skillID = arg_6_0.skillIDList[1]
		})
	end)
end

function var_0_0.RemoveScoreTween(arg_10_0, arg_10_1)
	if arg_10_1.tween then
		arg_10_1.tween:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(arg_10_1.tween.id)

		arg_10_1.tween = nil
	end
end

function var_0_0.CreateEffectItem(arg_11_0, arg_11_1)
	local var_11_0 = {
		gameObject = Object.Instantiate(arg_11_1 and arg_11_0.ui_trail_yellowGo_ or arg_11_0.ui_trail_blueGo_, arg_11_0.effectnodeTrs_)
	}

	SetActive(var_11_0.gameObject, false)

	var_11_0.transform = var_11_0.gameObject.transform
	var_11_0.isCanUse = true
	var_11_0.isHighScore = arg_11_1
	var_11_0.index = arg_11_0.scoreItemIndex

	table.insert(arg_11_0.effectList, var_11_0)

	arg_11_0.scoreItemIndex = arg_11_0.scoreItemIndex + 1

	return var_11_0
end

function var_0_0.ShowScoreTween(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 <= 10 then
		return
	end

	local var_12_0 = arg_12_1 >= 50
	local var_12_1

	if var_12_0 then
		var_12_1 = 7 + math.floor((arg_12_1 - 50) / 20)
		var_12_1 = math.min(var_12_1, 11)
	else
		var_12_1 = 2 + math.floor(arg_12_1 / 10)
	end

	local var_12_2 = {}

	for iter_12_0, iter_12_1 in pairs(arg_12_0.effectList or {}) do
		if iter_12_1.isCanUse == true and iter_12_1.isHighScore == var_12_0 then
			table.insert(var_12_2, iter_12_1)
		end

		if var_12_1 <= #var_12_2 then
			break
		end
	end

	local var_12_3 = var_12_1 - #var_12_2

	for iter_12_2 = 1, var_12_3 do
		table.insert(var_12_2, arg_12_0:CreateEffectItem(var_12_0))
	end

	arg_12_0:PlayScoreTween(var_12_2, arg_12_2)
end

function var_0_0.PlayScoreTween(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.effectnodeTrs_:InverseTransformPoint(arg_13_0.scoreText.transform.position)

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_1 = math.random(1, arg_13_2)
		local var_13_2 = arg_13_0.effectPosList[var_13_1].transform.localPosition
		local var_13_3 = math.random(-20, 20)
		local var_13_4 = math.random(-20, 20)
		local var_13_5 = var_13_2 + Vector3(var_13_3, var_13_4, 0)
		local var_13_6 = Mathf.Abs(var_13_2.y)
		local var_13_7 = Mathf.Max(var_13_6, 200)
		local var_13_8 = math.random(var_13_7, var_13_7 + var_13_7 / 2)

		if var_13_2.y > 0 then
			var_13_8 = -var_13_8
		end

		local var_13_9 = math.random(20, 50)
		local var_13_10 = Mathf.Lerp(var_13_5.x, var_13_0.x, math.random(50, 100) / 100)
		local var_13_11 = var_13_5 + Vector3(var_13_9, var_13_8, 0)
		local var_13_12 = var_13_5 + Vector3(var_13_10, var_13_8, 0)
		local var_13_13 = math.random(0.2, 0.4) + 0.1 * iter_13_0
		local var_13_14 = iter_13_0 * -0.05

		iter_13_1.isCanUse = false
		iter_13_1.tween = LeanTween.value(iter_13_0 * -0.05, 1, var_13_13):setOnUpdate(LuaHelper.FloatAction(function(arg_14_0)
			if arg_14_0 > 0 then
				local var_14_0 = (1 - arg_14_0) * (1 - arg_14_0) * (1 - arg_14_0)
				local var_14_1 = 3 * (1 - arg_14_0) * (1 - arg_14_0) * arg_14_0
				local var_14_2 = 3 * (1 - arg_14_0) * arg_14_0 * arg_14_0
				local var_14_3 = arg_14_0 * arg_14_0 * arg_14_0
				local var_14_4 = var_14_0 * var_13_5.x + var_14_1 * var_13_11.x + var_14_2 * var_13_12.x + var_14_3 * var_13_0.x
				local var_14_5 = var_14_0 * var_13_5.y + var_14_1 * var_13_11.y + var_14_2 * var_13_12.y + var_14_3 * var_13_0.y
				local var_14_6 = Vector2(var_14_4, var_14_5)

				iter_13_1.transform.localPosition = var_14_6

				if var_13_14 <= 0 then
					SetActive(iter_13_1.gameObject, true)
				end
			end

			var_13_14 = arg_14_0
		end)):setOnComplete(LuaHelper.VoidAction(function()
			if iter_13_0 == 1 then
				arg_13_0.scorenumAni_:Play("UI_TetrisGameMachineUI_special", 0, 0)
			end

			SetActive(iter_13_1.gameObject, false)

			iter_13_1.isCanUse = true
		end)):setEase(LeanTweenType.easeOutCubic)
	end
end

function var_0_0.RemoveShakeTween(arg_16_0)
	if arg_16_0.shakeTween then
		arg_16_0.shakeTween:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(arg_16_0.shakeTween.id)

		arg_16_0.shakeTween = nil
	end
end

function var_0_0.PlayShakeTween(arg_17_0, arg_17_1)
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
	local var_17_2
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

	local var_17_4 = #var_17_0.x

	arg_17_0.shakeTween = LeanTween.value(1, var_17_4 - 1, var_17_3):setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
		local var_18_0 = math.floor(arg_18_0)
		local var_18_1 = Mathf.Lerp(var_17_0.x[var_18_0 - 1] or 0, var_17_0.x[var_18_0], arg_18_0 - var_18_0) * var_17_1
		local var_18_2 = Mathf.Lerp(var_17_0.y[var_18_0 - 1] or 0, var_17_0.y[var_18_0], arg_18_0 - var_18_0) * var_17_1

		arg_17_0.tilespaceTrs_.localPosition = arg_17_0.tilespacePos + Vector3(var_18_1, var_18_2, 0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_17_0.tilespaceTrs_.localPosition = arg_17_0.tilespacePos
	end)):setEase(LeanTweenType.easeOutCubic)
end

function var_0_0.UpdateScore(arg_20_0)
	local var_20_0 = TetrisGameRunTimeManager:GetCurRoundBoard()
	local var_20_1 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()
	local var_20_2 = var_20_0.addScore

	arg_20_0:ShowScoreTween(var_20_0.addScore, var_20_0.curRoundDisposeNum)
	arg_20_0:PlayShakeTween(var_20_0.addScore)
	arg_20_0:DelScoreTimer()
	SetActive(arg_20_0.addmarksGo_, true)

	arg_20_0.textaddmarksText_.text = var_20_2
	arg_20_0.textcombo01Text_.text = placeScore
	arg_20_0.scoreTimer = Timer.New(function()
		SetActive(arg_20_0.comboGo_, false)
		SetActive(arg_20_0.addmarksGo_, false)
	end, 1.5)

	arg_20_0.scoreTimer:Start()
end

function var_0_0.DelScoreTimer(arg_22_0)
	SetActive(arg_22_0.comboGo_, false)
	SetActive(arg_22_0.addmarksGo_, false)

	if arg_22_0.scoreTimer then
		arg_22_0.scoreTimer:Stop()

		arg_22_0.scoreTimer = nil
	end
end

function var_0_0.RegisterEvents(arg_23_0)
	arg_23_0:RegistEventListener(TETRIS_GAME_ROUND_END, function()
		arg_23_0:RefreshBlackBoardData()
		arg_23_0:RefreshBlockSpaceList()
	end)
	arg_23_0:RegistEventListener(TETRIS_GAME_TIMER_UPDATE, function(arg_25_0)
		local var_25_0 = TetrisGameRunTimeManager:GetBlackBoard()

		if var_25_0.totalTime > 0 then
			local var_25_1 = math.ceil(var_25_0.totalTime - var_25_0.usedTime)
			local var_25_2 = math.max(0, var_25_1)

			arg_23_0.roundText.text = GetTips("REMAINING_TIME") .. var_25_2
		end
	end)
	arg_23_0:RegistEventListener(TETRIS_GAME_START_GAME, function()
		arg_23_0:OnStartGame()
	end)
end

function var_0_0.CheckIsLose(arg_27_0)
	local var_27_0 = TetrisGameRunTimeManager:GetBlackBoard()
	local var_27_1 = false
	local var_27_2 = ActivityTetrisGameStageCfg[var_27_0.stageID].time

	if ActivityTetrisGameStageCfg[arg_27_0.stageID].type == TetrisGameConst.stageType.endLess and var_27_2 > 0 and var_27_2 - var_27_0.usedTime > 0 then
		var_27_1 = true
	end

	if var_27_0.resultFlag == false or var_27_1 == true then
		return true
	else
		return false
	end
end

function var_0_0.OnGameEndUpdate(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0:DisposeComboTimer()
	arg_28_0:DelOverTimer()

	if arg_28_1 then
		arg_28_0.gameOverTimer = Timer.New(function()
			JumpTools.OpenPageByJump("tetrisGameScorePopView", {
				stageID = arg_28_0.stageID
			})
		end, 0.1)

		arg_28_0.gameOverTimer:Start()
		TetrisGameBridge.OverGameEnd()
	elseif arg_28_0:CheckIsLose() then
		arg_28_0.overController:SetSelectedState("true")

		arg_28_0.gameOverTimer = Timer.New(function()
			JumpTools.OpenPageByJump("tetrisGameScorePopView", {
				stageID = arg_28_0.stageID
			})
		end, 2.2)

		arg_28_0.gameOverTimer:Start()
		TetrisGameBridge.OverGameEnd()
	else
		JumpTools.OpenPageByJump("tetrisGameScorePopView", {
			stageID = arg_28_0.stageID,
			first_clear = arg_28_2
		})
	end
end

function var_0_0.DelOverTimer(arg_31_0)
	if arg_31_0.gameOverTimer then
		arg_31_0.gameOverTimer:Stop()

		arg_31_0.gameOverTimer = nil
	end
end

function var_0_0.OnExit(arg_32_0)
	manager.windowBar:HideBar()
	arg_32_0:RemoveAllEventListener()
	arg_32_0:StopTimer()
	arg_32_0:DelOverTimer()
	arg_32_0:DelScoreTimer()

	if arg_32_0.roundAniTimer then
		arg_32_0.roundAniTimer:Stop()

		arg_32_0.roundAniTimer = nil
	end

	SetActive(arg_32_0.progressBloomGo_, false)
end

function var_0_0.OnTop(arg_33_0)
	arg_33_0:RefreshBar()
end

function var_0_0.SendCancelSDK(arg_34_0)
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

function var_0_0.RefreshBar(arg_35_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if arg_35_0.startTimer then
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

		if ActivityTetrisGameStageCfg[arg_35_0.stageID].type == TetrisGameConst.stageType.endLess then
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
					arg_35_0:SendCancelSDK()
					TetrisGameRunTimeManager:EndGame(true)
					TetrisGameRunTimeManager:ExitGame()
					JumpTools.OpenPageByJump("/tetrisGameChooseStageView", {
						chapterID = ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[arg_35_0.stageID][1],
						stageID = arg_35_0.stageID
					})
				end,
				CancelCallback = function()
					TetrisGameRunTimeManager:PauseGame(false)
				end
			})
		end
	end)
end

function var_0_0.OnStartGame(arg_41_0)
	arg_41_0.lastRaminBoradCount = -1
	arg_41_0.stageID = TetrisGameRunTimeManager:GetBlackBoard().stageID

	arg_41_0:DisposeComboTimer()
	arg_41_0:DelScoreTimer()

	arg_41_0.machineSlider.value = 0
	arg_41_0.ultimateSlider_.value = 0

	TetrisGameRunTimeManager:SetMachineInfoState(arg_41_0.machineSlider.value >= 1)
	arg_41_0:RefreshView()
	arg_41_0.machinenodeAni_:Play("UI_TetrisGameMachineUI_normal", 0, 0)
	arg_41_0.machineLiziController:SetSelectedState("hide")
	arg_41_0.overController:SetSelectedState("false")
	TetrisGameRunTimeManager:StartGame()

	arg_41_0.guideTimer_ = Timer.New(function()
		if not manager.guide:IsPlaying() then
			arg_41_0.guideTimer_:Stop()

			arg_41_0.guideTimer_ = nil

			if #arg_41_0.skillIDList > 0 then
				JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
					inGame = true,
					stageID = arg_41_0.stageID,
					skillID = arg_41_0.skillIDList[1],
					closeCallBack = function()
						arg_41_0:OpenCountDown()
						arg_41_0:RealCheckWeakGuide()
					end
				})
			else
				arg_41_0:OpenCountDown()
			end

			for iter_42_0, iter_42_1 in pairs(arg_41_0.progressAniList) do
				iter_42_1:Play("UI_progress_cx", 0, 1)
			end
		end
	end, 0.1, -1)

	arg_41_0.guideTimer_:Start()
end

function var_0_0.OpenCountDown(arg_44_0)
	arg_44_0:StopTimer()
	arg_44_0.countController:SetSelectedState("false")
end

function var_0_0.RefreshView(arg_45_0)
	arg_45_0:UpdataViewState()
	arg_45_0:RefreshBlackBoardData()
	arg_45_0:RefreshBlockSpaceList()
end

function var_0_0.RefreshBlockSpaceList(arg_46_0)
	for iter_46_0, iter_46_1 in pairs(arg_46_0.blockSpaceList) do
		iter_46_1:RefreshUI()
	end
end

function var_0_0.RefreshMachineSlider(arg_47_0, arg_47_1)
	arg_47_0:RemoveTween()

	local var_47_0 = 0.5
	local var_47_1 = arg_47_0.machineSlider.value
	local var_47_2 = var_47_1
	local var_47_3 = 0.14

	arg_47_0.machineTween = LeanTween.value(arg_47_0.machineGo_, 0, 1, var_47_0):setOnUpdate(LuaHelper.FloatAction(function(arg_48_0)
		local var_48_0 = Mathf.Lerp(var_47_1, arg_47_1, arg_48_0)

		arg_47_0.machineSlider.value = var_48_0
		arg_47_0.ultimateSlider_.value = var_48_0

		if var_47_2 > var_47_3 and var_48_0 < var_47_3 then
			arg_47_0.machineLiziController:SetSelectedState("hide")
		end

		if var_47_2 < var_47_3 and var_48_0 > var_47_3 then
			arg_47_0.machineLiziController:SetSelectedState("show")
		end

		var_47_2 = var_48_0
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_47_0:RemoveTween()

		arg_47_0.machineSlider.value = arg_47_1
		arg_47_0.ultimateSlider_.value = arg_47_1
	end)):setEase(LeanTweenType.linear)

	TetrisGameRunTimeManager:SetMachineInfoState(arg_47_1 >= 1)
end

function var_0_0.RefreshMachineText(arg_50_0)
	local var_50_0 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()
	local var_50_1, var_50_2 = TetrisGameRunTimeManager:GetCurScoreRate()

	if ActivityTetrisGameChapterCfg.get_id_list_by_tetris_stage_list[arg_50_0.stageID][1] == 2 then
		arg_50_0.machineText.text = ""
	else
		arg_50_0.machineText.text = "x" .. var_50_1
	end

	if var_50_1 > 1 then
		local var_50_3 = arg_50_0.machinenodeAni_:GetCurrentAnimatorClipInfo(0)

		arg_50_0.machinenodeAni_:Play("UI_TetrisGameMachineUI_special", 0, 0)
	else
		arg_50_0.machinenodeAni_:Play("UI_TetrisGameMachineUI_normal", 0, 0)
	end
end

function var_0_0.RemoveTween(arg_51_0)
	if arg_51_0.machineTween then
		arg_51_0.machineTween:setOnComplete(nil):setOnUpdate(nil):setEase(nil)
		LeanTween.cancel(arg_51_0.machineGo_)

		arg_51_0.machineTween = nil
	end
end

function var_0_0.UpdateRoundShow(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_1.usedRound + (arg_52_0.isPlayRoundAni and -1 or 0)

	if arg_52_1.totalTime > 0 then
		local var_52_1 = math.ceil(arg_52_1.totalTime - arg_52_1.usedTime)
		local var_52_2 = math.max(0, var_52_1)

		arg_52_0.roundText.text = GetTips("REMAINING_TIME") .. var_52_2
	elseif arg_52_1.finishType == TetrisGameConst.finishType.chipCount then
		arg_52_0.roundText.text = string.format(GetTips("TETRIS_GAME_ROUND"), var_52_0)
	else
		arg_52_0.roundText.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN"), var_52_0, arg_52_1.finish_condition)
	end

	if arg_52_1.finishType == TetrisGameConst.finishType.chipCount then
		local var_52_3 = arg_52_1.finish_condition - arg_52_1.useChipCount

		if var_52_3 <= GameSetting.tetris_game_chip_remain_count.value[1] then
			if arg_52_0.lastRaminBoradCount ~= var_52_3 then
				arg_52_0.blockRemainAni_:Play("UI_red_cx", 0, 0)

				arg_52_0.lastRaminBoradCount = var_52_3
			end

			arg_52_0.remainBlockController:SetSelectedState("insufficient")
		else
			arg_52_0.remainBlockController:SetSelectedState("normal")
		end
	else
		arg_52_0.remainBlockController:SetSelectedState("insufficient")
	end
end

function var_0_0.RefreshBlackBoardData(arg_53_0)
	local var_53_0 = TetrisGameRunTimeManager:GetBlackBoard()
	local var_53_1 = TetrisGameRunTimeManager:GetCurRoundBoard()
	local var_53_2 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()

	arg_53_0:UpdateRoundProgress()

	if var_53_0 then
		arg_53_0.scoreText.text = var_53_0.totalScore

		arg_53_0.roundController:SetSelectedState("blue")

		if var_53_0.totalTime > 0 or var_53_0.finishType == TetrisGameConst.finishType.chipCount then
			if var_53_0.finishType ~= TetrisGameConst.finishType.chipCount then
				arg_53_0.roundController:SetSelectedState("red")
			end

			arg_53_0.gameDescController:SetSelectedState("infinite")
		else
			arg_53_0.gameDescController:SetSelectedState("normal")
		end

		arg_53_0:UpdateRoundShow(var_53_0)

		if var_53_1 and var_53_1.addScore > 0 then
			arg_53_0:UpdateScore()
		end

		arg_53_0:RefreshMachineText()

		if not var_53_2.chargeTimer and var_53_2.chargeFlag then
			if arg_53_0.machineSlider.value ~= 1 and var_53_0.chargeNum == var_53_0.chargeNumMax then
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_block_ratio_up", "")
			end

			if arg_53_0.machineSlider.value > 0 and var_53_0.chargeNum == 0 then
				manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_block_ratio_down", "")
			end

			arg_53_0:RefreshMachineSlider(var_53_0.chargeNumMax == 0 and 0 or var_53_0.chargeNum / var_53_0.chargeNumMax)
		end

		if var_53_0.finishType == TetrisGameConst.finishType.chipCount then
			arg_53_0.remainCanPlaceChip_.text = var_53_0.finish_condition - var_53_0.useChipCount
		end

		if var_53_2.isUseCreateGoalChip then
			if var_53_0.isOpenCreateGoalChip then
				arg_53_0.ultimateController:SetSelectedState("using")
				arg_53_0.useUltimateController:SetSelectedState("exceed")
			else
				arg_53_0.useUltimateController:SetSelectedState("normal")

				if var_53_0.goalRemainChargeValue > 0 then
					arg_53_0.ultimateController:SetSelectedState("charge")
				else
					arg_53_0.ultimateController:SetSelectedState("normal")
				end

				arg_53_0.ultimateChargeValue_.text = var_53_0.goalRemainChargeValue

				local var_53_3 = var_53_2.goalChargeNeedValue

				arg_53_0.ultimateProgress_.fillAmount = (var_53_3 - var_53_0.goalRemainChargeValue) / var_53_3
			end
		else
			arg_53_0.useUltimateController:SetSelectedState("normal")
			arg_53_0.ultimateController:SetSelectedState("none")
		end
	end

	arg_53_0:RefreshSkillIconList()
	arg_53_0:RefreshLockRemain(var_53_0, var_53_2)
end

function var_0_0.RefreshSkillIconList(arg_54_0)
	local var_54_0 = arg_54_0.skillList:GetItemList()

	for iter_54_0, iter_54_1 in pairs(var_54_0) do
		iter_54_1:RefreshCountShow()
	end
end

function var_0_0.RefreshLockRemain(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_1.isUseLock then
		arg_55_0.remainLockController:SetSelectedState("on")

		local var_55_0 = arg_55_2.forceChangeChip
		local var_55_1 = 0
		local var_55_2 = arg_55_2.lockExistRound
		local var_55_3 = arg_55_1.lockRound

		if var_55_0 then
			var_55_1 = var_55_2 - var_55_3 + 1
		else
			var_55_1 = (var_55_2 - var_55_3) * 3 + 3 - arg_55_1.usedLogicRound % 3
		end

		arg_55_0.lockRemainCountTxt_.text = string.format(GetTips("TETRIS_GAME_SKILL_LOCK_NUM_TIPS"), var_55_1)
	else
		arg_55_0.remainLockController:SetSelectedState("off")
	end
end

function var_0_0.UpdateRoundProgress(arg_56_0, arg_56_1)
	local var_56_0 = TetrisGameRunTimeManager:GetBlackBoard()
	local var_56_1 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()

	if var_56_1 and var_56_1.forceChangeChip then
		arg_56_0.roundProgressController:SetSelectedState("hide")
		arg_56_0:PlaysForceRoundAni()
	elseif var_56_0 then
		local var_56_2 = var_56_0.usedLogicRound
		local var_56_3 = var_56_2 % 3

		if var_56_3 == 0 then
			if var_56_2 < 3 or arg_56_1 then
				arg_56_0.roundProgressController:SetSelectedState("normal")
			else
				arg_56_0.roundProgressController:SetSelectedState("three")
				arg_56_0.progressAniList[3]:Play("UI_progress_cx", 0, 0)
				arg_56_0:PlayRoundAni()
			end
		elseif var_56_3 == 1 then
			arg_56_0.roundProgressController:SetSelectedState("one")
			arg_56_0.progressAniList[1]:Play("UI_progress_cx", 0, 0)
		elseif var_56_3 == 2 then
			arg_56_0.roundProgressController:SetSelectedState("two")
			arg_56_0.progressAniList[2]:Play("UI_progress_cx", 0, 0)
		end
	else
		arg_56_0.roundProgressController:SetSelectedState("normal")
	end
end

function var_0_0.PlayRoundAni(arg_57_0)
	if arg_57_0.roundAniTimer then
		arg_57_0.roundAniTimer:Stop()

		arg_57_0.roundAniTimer = nil
	end

	SetActive(arg_57_0.progressBloomGo_, false)

	arg_57_0.isPlayRoundAni = true
	arg_57_0.roundAniTimer = Timer.New(function()
		SetActive(arg_57_0.progressBloomGo_, true)
		arg_57_0:UpdateRoundProgress(true)

		arg_57_0.isPlayRoundAni = false

		arg_57_0:UpdateRoundShow(TetrisGameRunTimeManager:GetBlackBoard())
	end, 1)

	arg_57_0.roundAniTimer:Start()
end

function var_0_0.PlaysForceRoundAni(arg_59_0)
	SetActive(arg_59_0.progressBloomGo_, false)
	SetActive(arg_59_0.progressBloomGo_, true)
end

function var_0_0.OnComboTimerUpdate(arg_60_0)
	arg_60_0:DisposeComboTimer()

	local var_60_0 = ActivityTetrisGameSkillCfg[TetrisGameConst.skillType.combom].params_2[1]
	local var_60_1 = var_60_0
	local var_60_2 = TetrisGameRunTimeManager:GetBlackBoard()
	local var_60_3 = TetrisGameRunTimeManager:GetCurRoundBoard()

	var_60_2.comboTime = var_60_1
	arg_60_0.comboTimer = Timer.New(function()
		if not var_60_2.pauseGameFlag then
			var_60_1 = var_60_1 - 0.1
			var_60_2.comboTime = var_60_1

			arg_60_0:RefreshMachineSlider(math.max(var_60_1 / var_60_0, 0))

			if var_60_1 <= 0 then
				arg_60_0:DisposeComboTimer()

				var_60_2.comboCount = 0
				var_60_2.chargeNum = 0

				TetrisGameRunTimeManager:UpdateComboScoreRateCompute()
				arg_60_0:RefreshMachineText()
			end
		end
	end, 0.1, -1)

	arg_60_0.comboTimer:Start()
	SetActive(arg_60_0.machinenEffectObj_, true)
end

function var_0_0.DisposeComboTimer(arg_62_0)
	if arg_62_0.comboTimer then
		arg_62_0.comboTimer:Stop()

		arg_62_0.comboTimer = nil
	end

	SetActive(arg_62_0.machinenEffectObj_, false)

	if arg_62_0.comboEffectTimer then
		arg_62_0.comboEffectTimer:Stop()

		arg_62_0.comboEffectTimer = nil
	end
end

function var_0_0.UpdataViewState(arg_63_0)
	local var_63_0 = TetrisGameRunTimeManager:GetBlackBoard()
	local var_63_1 = TetrisGameRunTimeManager:GetSkillEffectBlackBoard()

	if var_63_0 then
		arg_63_0.machineController:SetSelectedState("off")

		if var_63_1.chargeFlag then
			arg_63_0.machineController:SetSelectedState("on")
		end

		local var_63_2 = TetrisGameRunTimeManager:GetSkillBlackBoard()

		arg_63_0:RefreshSkillList()

		local var_63_3 = 0

		for iter_63_0, iter_63_1 in pairs(var_63_2) do
			if ActivityTetrisGameSkillCfg[iter_63_0].type == TetrisGameConst.skillUseType.normal then
				var_63_3 = var_63_3 + 1
			end
		end

		if var_63_3 == 0 then
			arg_63_0.skillController:SetSelectedState("off")
		else
			arg_63_0.skillController:SetSelectedState("on")
		end

		if var_63_0.totalTime <= 0 then
			arg_63_0.roundText.text = GetTips("TETRIS_GAME_UNLIMITE_TIME")
		end
	end
end

function var_0_0.StopTimer(arg_64_0)
	if arg_64_0.startTimer then
		arg_64_0.startTimer:Stop()

		arg_64_0.startTimer = nil
	end

	if arg_64_0.guideTimer_ then
		arg_64_0.guideTimer_:Stop()

		arg_64_0.guideTimer_ = nil
	end
end

function var_0_0.RefreshSkillList(arg_65_0)
	arg_65_0.skillIDList = {}

	if ActivityTetrisGameStageCfg[arg_65_0.stageID].type == TetrisGameConst.stageType.endLess then
		arg_65_0.skillIDList = TetrisGameData:GetSkillList()
	else
		arg_65_0.skillIDList = ActivityTetrisGameStageCfg[arg_65_0.stageID].skill_list
	end

	arg_65_0.skillList:StartScroll(#arg_65_0.skillIDList)

	if ActivityTetrisGameStageCfg[arg_65_0.stageID].type == TetrisGameConst.stageType.endLess then
		TetrisGameRunTimeManager:InitRecordSkillUse(TetrisGameData:GetEndlessSkillList())
	else
		TetrisGameRunTimeManager:InitRecordSkillUse(arg_65_0.skillIDList)
	end
end

function var_0_0.indexSkill(arg_66_0, arg_66_1, arg_66_2)
	arg_66_2:RefreshUI(arg_66_0.skillIDList[arg_66_1])
	arg_66_2:RegisterClickFunc(handler(arg_66_0, arg_66_0.ClickSkillItem))
end

function var_0_0.ClickSkillItem(arg_67_0, arg_67_1)
	if TetrisGameBridge.CheckIsHaveDragging() then
		return
	end

	JumpTools.OpenPageByJump("tetrisGameGetSkillView", {
		inGame = true,
		stageID = arg_67_0.stageID,
		skillID = arg_67_1
	})
end

function var_0_0.CheckWeakGuide(arg_68_0)
	return
end

function var_0_0.Dispose(arg_69_0)
	arg_69_0:StopTimer()
	arg_69_0:DisposeComboTimer()
	arg_69_0:DelScoreTimer()
	arg_69_0:RemoveTween()
	arg_69_0:RemoveShakeTween()

	for iter_69_0, iter_69_1 in ipairs(arg_69_0.effectList) do
		arg_69_0:RemoveScoreTween(iter_69_1)
	end

	if arg_69_0.skillList then
		arg_69_0.skillList:Dispose()

		arg_69_0.skillList = nil
	end

	if arg_69_0.blockSpaceList then
		for iter_69_2, iter_69_3 in pairs(arg_69_0.blockSpaceList) do
			iter_69_3:Dispose()
		end
	end

	var_0_0.super.Dispose(arg_69_0)
end

return var_0_0
