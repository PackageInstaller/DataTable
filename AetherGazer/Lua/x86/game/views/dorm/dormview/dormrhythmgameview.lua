local var_0_0 = class("DormRhythmGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormMinigameUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.game = require("game.dorm.minigame.Include").Pizhuan.New(function()
		local var_4_0 = not nullable(arg_3_0, "startGameFlag")
		local var_4_1 = DormRhythmGameData:GetRunTimeData()
		local var_4_2 = DormRhythmGameData:GetLevelIDByDiff(arg_3_0.diff)

		if var_4_0 then
			return var_4_0, DormRhythmGameTools:GetGameResult(var_4_1, var_4_2)
		end

		return var_4_0
	end)
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()
	arg_5_0:ResetTimer()

	arg_5_0.goData = {
		itemGo = arg_5_0.itemGo,
		parentTrs = arg_5_0.itemParentTrs,
		deterGo = arg_5_0.deterGo_
	}
	arg_5_0.judgeEffectController = ControllerUtil.GetController(arg_5_0.deterGo_.transform, "effect")
	arg_5_0.judgeAnimator = arg_5_0.deterGo_:GetComponent("Animator")
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.viewController = ControllerUtil.GetController(arg_6_0.gameObject_.transform, "state")
	arg_6_0.countDownController = ControllerUtil.GetController(arg_6_0.gameObject_.transform, "countDown")
	arg_6_0.batterController = ControllerUtil.GetController(arg_6_0.gameObject_.transform, "batter")
	arg_6_0.scoreController = ControllerUtil.GetController(arg_6_0.settlementpanelGo_.transform, "score")
	arg_6_0.shareController = ControllerUtil.GetController(arg_6_0.settlementpanelGo_.transform, "share")

	arg_6_0:InitAnimationController()

	arg_6_0.settlePower = DormCharaterFatigueShowView.New(arg_6_0.settllePowerGo)
	arg_6_0.startPower = DormCharaterFatigueShowView.New(arg_6_0.startPowerGo)
end

function var_0_0.InitAnimationController(arg_7_0)
	arg_7_0.batterAniamtor = arg_7_0.batterGo:GetComponent("Animator")
	arg_7_0.countAnimator = arg_7_0.countGo:GetComponent("Animator")
	arg_7_0.settleAnimator = arg_7_0.settlementpanelGo_:GetComponent("Animator")
end

function var_0_0.ShareExitCallBack(arg_8_0)
	arg_8_0.shareController:SetSelectedState("false")
end

function var_0_0.OnEnter(arg_9_0)
	SetActive(arg_9_0.shareGo_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))

	arg_9_0.heroID = arg_9_0.params_.heroID
	arg_9_0.heroEID = arg_9_0.params_.heroEID

	arg_9_0:RegisterEvents()
	arg_9_0:ResetStartView()
	arg_9_0.settlePower:RefreshView(arg_9_0.heroID)
	arg_9_0.startPower:RefreshView(arg_9_0.heroID)
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.RefreshBar(arg_11_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		arg_11_0:ExitGame()
	end)
end

function var_0_0.RegisterEvents(arg_13_0)
	arg_13_0:RegistEventListener(DORM_STOP_RHYTHM_GAME, function(arg_14_0, arg_14_1)
		if arg_14_0 then
			arg_13_0:RefreshSettleView(arg_14_1)
		else
			arg_13_0:ResetStartView()
		end
	end)
	arg_13_0:RegistEventListener(DORM_REFRESH_BATTER_NUM, function(arg_15_0, arg_15_1)
		local var_15_0 = DormRhythmGameData:GetRunTimeData()
		local var_15_1 = DormRhythmGameData:GetLevelIDByDiff(arg_13_0.diff)

		if BackHomeBreakGameCfg[var_15_1].fail_max <= var_15_0.mistakeNum then
			arg_13_0:SettlementRhythmGame()

			return
		end

		local var_15_2 = DormRhythmGameTools:CalGameScore(var_15_0, var_15_1)
		local var_15_3 = DormRhythmGameTools:GetEffectRank(var_15_2)

		if var_15_3 then
			arg_13_0:SetDormGameEffect(var_15_3)
		end

		arg_13_0:UpdataBatterNum(arg_15_0, var_15_3, arg_15_1)
	end)
	arg_13_0:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function()
		arg_13_0.settlePower:RefreshView(arg_13_0.heroID)
		arg_13_0.startPower:RefreshView(arg_13_0.heroID)
	end)
	arg_13_0:RegistEventListener(BREAK_GAME_LAST_SUCCESS, function()
		arg_13_0:SettlementRhythmGame()
	end)
end

function var_0_0.SettlementRhythmGame(arg_18_0)
	arg_18_0:StopGame()

	local var_18_0 = DormRhythmGameData:GetRunTimeData()
	local var_18_1 = DormRhythmGameData:GetLevelIDByDiff(arg_18_0.diff)
	local var_18_2 = {
		stage_id = arg_18_0.diff,
		percentage_complete = DormRhythmGameTools:CalGameScore(var_18_0, var_18_1),
		hero_id = arg_18_0.heroID
	}

	DormAction:SettlementRhythmGame(var_18_2)
end

function var_0_0.AddUIListener(arg_19_0)
	arg_19_0:AddBtnListener(arg_19_0.startBtn, nil, function()
		local var_20_0, var_20_1 = BackHomeTools.CheckHeroIsLockForAnyFeatureWithTips(arg_19_0.heroID)

		if var_20_0 then
			ShowTips(var_20_1)

			return
		end

		if arg_19_0:CheckFatigue() then
			arg_19_0:StartGame()
		else
			ShowTips(GetTips("DORM_FATIGUE_NOT_ENOUGH"))
		end
	end)

	for iter_19_0 = 1, 3 do
		arg_19_0:AddToggleListener(arg_19_0["level" .. iter_19_0 .. "Tgl"], function(arg_21_0)
			if arg_21_0 then
				arg_19_0:ChoiceDiff(iter_19_0)
			end
		end)
	end

	arg_19_0:AddBtnListener(arg_19_0.leftBtn_, nil, function()
		if not DormRhythmGameData:GetGameRunFlag() then
			return
		end

		local var_22_0 = DormConst.DORM_RHYTHM_BUTTON_TYPE.left

		DormRhythmGameData:ClickDetermination(var_22_0)
	end)
	arg_19_0:AddBtnListener(arg_19_0.rightBtn_, nil, function()
		if not DormRhythmGameData:GetGameRunFlag() then
			return
		end

		local var_23_0 = DormConst.DORM_RHYTHM_BUTTON_TYPE.right

		DormRhythmGameData:ClickDetermination(var_23_0)
	end)
	arg_19_0:AddBtnListener(arg_19_0.exitGame, nil, function()
		arg_19_0:ExitGame()
	end)
	arg_19_0:AddBtnListener(arg_19_0.reStartBtn, nil, function()
		if arg_19_0:CheckFatigue() then
			arg_19_0:ResetStartView()
		else
			ShowTips("DORM_FATIGUE_NOT_ENOUGH")
		end
	end)
	arg_19_0:AddBtnListener(arg_19_0.shareBtn, nil, function()
		local var_26_0 = {
			cardShowUID = true,
			cardShowLv = true,
			logoPos = 2,
			cardPos = 3,
			cardShow = true
		}

		manager.share:Share(function()
			arg_19_0.shareController:SetSelectedState("true")
		end, function()
			arg_19_0.shareController:SetSelectedState("false")
		end, function()
			return
		end, nil, var_26_0)
	end)
	arg_19_0:AddBtnListener(arg_19_0.pauseBtn, nil, function()
		DormRhythmGameData:SetPauseFlag(true)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("DORM_MG_LEAVE_CONFIRM"),
			OkCallback = function()
				arg_19_0:StopGame()
				arg_19_0:ResetStartView()
			end,
			CancelCallback = function()
				DormRhythmGameData:SetPauseFlag(false)
			end,
			MaskCallback = function()
				DormRhythmGameData:SetPauseFlag(false)
			end
		})
	end)
end

function var_0_0.OnQte(arg_34_0, arg_34_1)
	if arg_34_0.startGameFlag then
		arg_34_0.game:OnQte(arg_34_1)
	end
end

function var_0_0.StartGame(arg_35_0)
	if arg_35_0.diff then
		arg_35_0.startGameFlag = true

		arg_35_0.game:Start(arg_35_0.heroEID)
		arg_35_0:ResetGameView()
	else
		print("未选择游戏难度")
	end
end

function var_0_0.ChoiceDiff(arg_36_0, arg_36_1)
	arg_36_0.diff = arg_36_1
end

function var_0_0.ResetTimer(arg_37_0)
	if var_0_0.timer then
		for iter_37_0, iter_37_1 in pairs(var_0_0.timer) do
			iter_37_1:Stop()
		end
	end

	var_0_0.timer = {}

	local var_37_0 = GameDisplayCfg.dorm_mg_start_time.value[1]

	arg_37_0.countDownController:SetSelectedState("true")

	arg_37_0.countDownText.text = var_37_0
	var_0_0.timer.startTimer = Timer.New(function()
		arg_37_0.countAnimator:Play("batter", 0, 0)

		var_37_0 = var_37_0 - 1

		if var_37_0 <= 0 then
			local var_38_0 = {
				stageID = 1,
				diff = arg_37_0.diff or 1,
				heroID = arg_37_0.heroID,
				goInfo = arg_37_0.goData
			}

			arg_37_0.countDownController:SetSelectedState("false")
			DormRhythmGameData:StartGame(var_38_0)
			var_0_0.timer.startTimer:Stop()
		end

		arg_37_0.countDownText.text = var_37_0
	end, 1, -1)
end

function var_0_0.ResetStartView(arg_39_0)
	arg_39_0:ResetTimer()
	arg_39_0:RefreshBar()
	arg_39_0.viewController:SetSelectedState("start")

	if not arg_39_0.diff then
		arg_39_0.diff = 1
		arg_39_0.level1Tgl.isOn = true
	else
		arg_39_0["level" .. arg_39_0.diff .. "Tgl"].isOn = true
	end

	local var_39_0 = arg_39_0:GetGameNeedFatigue()

	arg_39_0.costFatigueText.text = "x" .. tostring(var_39_0)
end

function var_0_0.ResetGameView(arg_40_0)
	arg_40_0.judgeEffectController:SetSelectedState("none")
	manager.audio:StopEffect()

	local var_40_0 = {
		diff = arg_40_0.diff or 1,
		heroID = arg_40_0.heroID
	}

	arg_40_0.viewController:SetSelectedState("playing")
	manager.windowBar:HideBar()
	arg_40_0.batterController:SetSelectedState("false")
	arg_40_0.timer.startTimer:Start()
	manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_start", "")
	arg_40_0:UpdataMistakeNum()

	arg_40_0.effectLevel = 0
	arg_40_0.curBatterType = nil

	arg_40_0:SetDormGameEffect(0)
end

function var_0_0.awardIndexItem(arg_41_0, arg_41_1, arg_41_2)
	arg_41_2:SetData(arg_41_0.awardList[arg_41_1])
end

function var_0_0.RefreshSettleView(arg_42_0, arg_42_1)
	arg_42_0.viewController:SetSelectedState("settlement")
	arg_42_0.settleAnimator:Play("settle", -1, 0)
	arg_42_0.settleAnimator:Update(0)
	arg_42_0.settlePower:RefreshView(arg_42_0.heroID)

	local var_42_0 = DormRhythmGameData:GetResultInfo()

	arg_42_0.successNum.text = tostring(var_42_0.successfulNum)
	arg_42_0.mistakeNum.text = tostring(var_42_0.mistakeNum)
	arg_42_0.maxBatterNum.text = tostring(var_42_0.maxBatterNum)

	if not arg_42_0.rewardList then
		arg_42_0.rewardList = {}
	end

	for iter_42_0, iter_42_1 in pairs(arg_42_0.rewardList) do
		arg_42_0.rewardList[iter_42_0]:Show(false)
	end

	if arg_42_1 and arg_42_1[1] and arg_42_1[1].num > 0 then
		for iter_42_2, iter_42_3 in ipairs(arg_42_1) do
			if arg_42_0.rewardList[iter_42_2] then
				local var_42_1 = clone(ItemTemplateData)

				var_42_1.id = iter_42_3.id
				var_42_1.number = iter_42_3.num

				function var_42_1.clickFun(arg_43_0)
					ShowPopItem(POP_ITEM, {
						arg_43_0.id,
						arg_43_0.number
					})
				end

				arg_42_0.rewardList[iter_42_2]:SetData(var_42_1)
			else
				local var_42_2 = Object.Instantiate(arg_42_0.itemGo_, arg_42_0.rewardParent_)

				arg_42_0.rewardList[iter_42_2] = CommonItemView.New(var_42_2, true)

				local var_42_3 = clone(ItemTemplateData)

				var_42_3.id = iter_42_3.id
				var_42_3.number = iter_42_3.num

				function var_42_3.clickFun(arg_44_0)
					ShowPopItem(POP_ITEM, {
						arg_44_0.id,
						arg_44_0.number
					})
				end

				arg_42_0.rewardList[iter_42_2]:SetData(var_42_3)
			end

			arg_42_0.rewardList[iter_42_2]:Show(true)
		end
	end

	local var_42_4 = DormRhythmGameData:GetRunTimeData()
	local var_42_5 = DormRhythmGameData:GetLevelIDByDiff(arg_42_0.diff)
	local var_42_6 = DormRhythmGameTools:CalGameScore(var_42_4, var_42_5)
	local var_42_7 = DormRhythmGameTools:GetRank(var_42_6)
	local var_42_8 = DormConst.DORM_RHYTHMGAME_RANK[var_42_7]

	if var_42_8 then
		arg_42_0.scoreController:SetSelectedState(var_42_8)
	end

	local var_42_9 = DormitoryData:GetDailyCurrency()

	arg_42_0.reduceFatigue.text = "x" .. tostring(arg_42_0:GetGameNeedFatigue())

	if var_42_9 >= GameSetting.dorm_mg_reward_daily_max.value[1] then
		arg_42_0.awardText.text = string.format(GetTips("DORM_MG_REWARD_MAX_INFO"), var_42_9, GameSetting.dorm_mg_reward_daily_max.value[1])
	else
		arg_42_0.awardText.text = string.format(GetTips("DORM_MG_REWARD_INFO"), var_42_9, GameSetting.dorm_mg_reward_daily_max.value[1])
	end
end

function var_0_0.GetGameNeedFatigue(arg_45_0)
	if DormitoryData:GetDailyCurrency() >= GameSetting.dorm_mg_reward_daily_max.value[1] then
		return 0
	else
		return GameSetting.dorm_mg_break_cost.value[1]
	end
end

function var_0_0.UpdataBatterNum(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = false
	local var_46_1 = DormRhythmGameData:GetRunTimeData()
	local var_46_2 = var_46_1.batterNum

	if var_46_2 > 0 then
		if arg_46_0.curBatterType == arg_46_1 then
			var_46_0 = true
		end
	elseif arg_46_0.curBatterType == DormConst.DORM_RHYTHM_BUTTON_TYPE.fail then
		var_46_0 = true
	end

	local var_46_3 = arg_46_0.effectLevel

	if arg_46_2 then
		arg_46_0.effectLevel = arg_46_2
	end

	if arg_46_0.effectLevel ~= var_46_3 or var_46_0 then
		manager.audio:StopEffect()

		local var_46_4 = arg_46_0.effectLevel

		if arg_46_0.effectLevel == 4 then
			var_46_4 = 3
		end

		if var_46_4 > 0 then
			manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_energy0" .. var_46_4 .. "_loop", "")
		end
	end

	if var_46_1 then
		arg_46_0.batterNum.text = string.format(GetTips("DORM_MG_BREAK_COMBO_COUNT"), var_46_2)

		if var_46_2 > 0 then
			arg_46_0.batterController:SetSelectedState("true")
			arg_46_0.batterAniamtor:Play("batter", 0, 0)
			arg_46_0.judgeEffectController:SetSelectedState("none")

			if not arg_46_3 then
				arg_46_0.judgeAnimator:Play("New Animation", -1, 0)
				arg_46_0.judgeAnimator:Update(0)

				if arg_46_1 == DormConst.DORM_RHYTHM_BUTTON_TYPE.left then
					manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit01", "")
					arg_46_0.judgeEffectController:SetSelectedState("blue")

					arg_46_0.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.left
				else
					manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit03", "")
					arg_46_0.judgeEffectController:SetSelectedState("red")

					arg_46_0.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.right
				end
			end
		else
			arg_46_0.batterController:SetSelectedState("false")
			arg_46_0:UpdataMistakeItem()

			if not arg_46_3 then
				arg_46_0.judgeAnimator:Play("GameObject_defeated", -1, 0)
				arg_46_0.judgeAnimator:Update(0)
				manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit02", "")

				arg_46_0.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.fail
			end
		end
	end
end

function var_0_0.UpdataMistakeItem(arg_47_0)
	if arg_47_0.mistakeList then
		for iter_47_0, iter_47_1 in ipairs(arg_47_0.mistakeList) do
			if iter_47_1.flag then
				iter_47_1.flag = false

				iter_47_1.controller:SetSelectedState("false")

				break
			end
		end
	end
end

function var_0_0.UpdataMistakeNum(arg_48_0)
	if arg_48_0.diff then
		local var_48_0 = DormRhythmGameData:GetLevelIDByDiff(arg_48_0.diff)
		local var_48_1 = BackHomeBreakGameCfg[var_48_0].fail_max

		arg_48_0.mistakeList = {}

		for iter_48_0 = 1, var_48_1 do
			local var_48_2 = Object.Instantiate(arg_48_0.bgpowerGo_, arg_48_0.mistakeTrs)
			local var_48_3 = {
				flag = true,
				index = iter_48_0,
				go = var_48_2,
				controller = ControllerUtil.GetController(var_48_2.transform, "state")
			}

			var_48_3.controller:SetSelectedState("true")

			arg_48_0.mistakeList[iter_48_0] = var_48_3
		end
	end
end

function var_0_0.StopGame(arg_49_0)
	DormRhythmGameData:StopGame()

	arg_49_0.startGameFlag = false

	arg_49_0:ResetTimer()

	if arg_49_0.mistakeList then
		for iter_49_0, iter_49_1 in ipairs(arg_49_0.mistakeList) do
			Object.Destroy(iter_49_1.go)
		end

		arg_49_0.mistakeList = nil
	end
end

function var_0_0.SelDiff(arg_50_0, arg_50_1)
	arg_50_0.diff = arg_50_1
end

function var_0_0.ExitGame(arg_51_0)
	manager.audio:StopEffect()
	DormRhythmGameData:Dispose()
	JumpTools.OpenPageByJump("/heroInteractView")
	arg_51_0.game:Abort()
end

function var_0_0.CheckFatigue(arg_52_0)
	local var_52_0 = DormData:GetHeroTemplateInfo(arg_52_0.heroID)

	if var_52_0 then
		if var_52_0:GetFatigue() < arg_52_0:GetGameNeedFatigue() then
			return false
		end

		return true
	else
		print("未找到人物信息")
	end
end

function var_0_0.SetDormGameEffect(arg_53_0, arg_53_1)
	if arg_53_1 <= 0 then
		arg_53_1 = require("game.dorm.minigame.Include").Pizhuan.QTE_LEVEL_RESET
	end

	arg_53_0:OnQte(arg_53_1)
end

function var_0_0.Dispose(arg_54_0)
	if arg_54_0.rewardList then
		for iter_54_0, iter_54_1 in ipairs(arg_54_0.rewardList) do
			arg_54_0.rewardList[iter_54_0]:Dispose()

			arg_54_0.rewardList[iter_54_0] = nil
		end
	end

	if var_0_0.timer then
		for iter_54_2, iter_54_3 in pairs(var_0_0.timer) do
			iter_54_3:Stop()
		end
	end

	if arg_54_0.settlePower then
		arg_54_0.settlePower:Dispose(arg_54_0)
	end

	if arg_54_0.startPower then
		arg_54_0.startPower:Dispose(arg_54_0)
	end

	DormRhythmGameData:Dispose()
	var_0_0.super.Dispose(arg_54_0)
end

return var_0_0
