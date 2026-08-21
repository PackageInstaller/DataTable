local var_0_0 = class("SPHeroChallengeBarbuceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeBarbuceUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	arg_3_0.game = require("game.dorm.minigame.Include").Barbuce.New(function()
		local var_4_0 = not nullable(arg_3_0, "startGameFlag")
		local var_4_1 = DormRhythmGameData:GetRunTimeData()
		local var_4_2 = DormRhythmGameData:GetLevelIDByDiff(arg_3_0.diff, arg_3_0.activityID)

		if var_4_0 then
			return var_4_0, DormRhythmGameTools:GetGameResult(var_4_1, var_4_2, arg_3_0.activityID)
		end

		return var_4_0
	end)

	local var_3_0 = SPHeroChallengeData:GetActivityID()

	arg_3_0.heroEID = arg_3_0.game.heroEID
	arg_3_0.heroID = ActivityHeroChallengeCfg[var_3_0].hero_id or 1084
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
	arg_6_0.awardList = LuaList.New(handler(arg_6_0, arg_6_0.RefreshAward), arg_6_0.uilistGo_, CommonItemView)

	arg_6_0:InitAnimationController()
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
	arg_9_0.enterFlag = true
	arg_9_0.info = SPHeroChallengeData:GetCurActivityInfo()
	arg_9_0.activityID = SPHeroChallengeData:GetActivityID()

	arg_9_0:RegisterEvents()
	arg_9_0:ResetStartView()
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
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end)
end

function var_0_0.RegisterEvents(arg_13_0)
	arg_13_0:RegistEventListener(DORM_STOP_RHYTHM_GAME, function(arg_14_0, arg_14_1)
		local var_14_0 = SPHeroChallengeData:GetActivityID()
		local var_14_1 = SPHeroChallengeData.activityCfg[var_14_0].barbuceActiVityID

		if arg_14_0 then
			arg_13_0:RefreshSettleView(arg_14_1)
		else
			SDKTools.SendMessageToSDK("backhome_mg_result", {
				result = 2,
				activity_id = var_14_1
			})
			arg_13_0:ResetStartView()
		end
	end)
	arg_13_0:RegistEventListener(DORM_REFRESH_BATTER_NUM, function(arg_15_0, arg_15_1)
		local var_15_0 = DormRhythmGameData:GetRunTimeData()
		local var_15_1 = DormRhythmGameData:GetLevelIDByDiff(arg_13_0.diff, arg_13_0.activityID)

		if ActivityHeroChallengeBarbecueCfg[var_15_1].fail_max <= var_15_0.mistakeNum then
			arg_13_0:SettlementRhythmGame()

			return
		end

		local var_15_2 = DormRhythmGameTools:CalGameScore(var_15_0, var_15_1, arg_13_0.activityID)
		local var_15_3 = DormRhythmGameTools:GetEffectRank(var_15_2)

		if var_15_3 then
			arg_13_0:SetDormGameEffect(var_15_3)
		end

		arg_13_0:UpdataBatterNum(arg_15_0, var_15_3, arg_15_1)
	end)
	arg_13_0:RegistEventListener(BREAK_GAME_LAST_SUCCESS, function()
		arg_13_0:SettlementRhythmGame()
	end)
	arg_13_0:RegistEventListener(BREAK_GAME_REFRESH_VIEW, function()
		arg_13_0:RefreshStartAwardInfo()
	end)
end

function var_0_0.SettlementRhythmGame(arg_18_0)
	arg_18_0:StopGame()

	local var_18_0 = DormRhythmGameData:GetRunTimeData()
	local var_18_1 = DormRhythmGameData:GetLevelIDByDiff(arg_18_0.diff, arg_18_0.activityID)
	local var_18_2 = DormRhythmGameTools:CalGameScore(var_18_0, var_18_1, arg_18_0.activityID)
	local var_18_3 = DormRhythmGameTools:GetRank(var_18_2)
	local var_18_4 = {
		result = 1,
		stage_id = ActivityHeroChallengeBarbecueCfg.get_id_list_by_difficult[arg_18_0.diff][1],
		index = var_18_3,
		hero_id = arg_18_0.heroID
	}

	SPHeroChallengeAction:SettleBarbecueGame(var_18_4)
end

function var_0_0.AddUIListener(arg_19_0)
	arg_19_0:AddBtnListener(arg_19_0.startBtn, nil, function()
		arg_19_0:StartGame()
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
		arg_19_0:ResetStartView()
	end)
	arg_19_0:AddBtnListener(arg_19_0.reStartBtn, nil, function()
		arg_19_0:ResetStartView()
		arg_19_0:StartGame()
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

				local var_31_0 = SPHeroChallengeData:GetActivityID()
				local var_31_1 = SPHeroChallengeData.activityCfg[var_31_0].barbuceActiVityID

				SDKTools.SendMessageToSDK("backhome_mg_result", {
					result = 3,
					activity_id = var_31_1
				})
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

function var_0_0.StartGame(arg_34_0)
	if arg_34_0.diff then
		arg_34_0.startGameFlag = true

		if not arg_34_0.enterFlag then
			arg_34_0.game:PlayStartAnim()
		end

		arg_34_0.game:Start()
		arg_34_0:ResetGameView()

		arg_34_0.enterFlag = false
	else
		print("未选择游戏难度")
	end
end

function var_0_0.ChoiceDiff(arg_35_0, arg_35_1)
	arg_35_0.diff = arg_35_1
end

function var_0_0.ResetTimer(arg_36_0)
	if var_0_0.timer then
		for iter_36_0, iter_36_1 in pairs(var_0_0.timer) do
			iter_36_1:Stop()
		end
	end

	var_0_0.timer = {}

	local var_36_0 = GameDisplayCfg.dorm_mg_start_time.value[1]

	arg_36_0.countDownController:SetSelectedState("true")

	arg_36_0.countDownText.text = var_36_0
	var_0_0.timer.startTimer = Timer.New(function()
		arg_36_0.countAnimator:Play("batter", 0, 0)

		var_36_0 = var_36_0 - 1

		if var_36_0 <= 0 then
			local var_37_0 = arg_36_0.diff or 1
			local var_37_1 = {
				diff = var_37_0,
				heroID = arg_36_0.heroID,
				stageID = ActivityHeroChallengeBarbecueCfg.get_id_list_by_difficult[var_37_0][1],
				goInfo = arg_36_0.goData,
				activityID = arg_36_0.activityID
			}

			arg_36_0.countDownController:SetSelectedState("false")
			DormRhythmGameData:StartGame(var_37_1)
			var_0_0.timer.startTimer:Stop()
		end

		arg_36_0.countDownText.text = var_36_0
	end, 1, -1)
end

function var_0_0.ResetStartView(arg_38_0)
	arg_38_0:ResetTimer()
	arg_38_0:RefreshBar()
	arg_38_0.viewController:SetSelectedState("start")

	if not arg_38_0.diff then
		arg_38_0.diff = 1
		arg_38_0.level1Tgl.isOn = true
	else
		arg_38_0["level" .. arg_38_0.diff .. "Tgl"].isOn = true
	end

	local var_38_0 = arg_38_0:GetGameNeedFatigue()

	arg_38_0.costFatigueText.text = "x" .. tostring(var_38_0)

	arg_38_0:RefreshStartAwardInfo()
end

function var_0_0.RefreshStartAwardInfo(arg_39_0)
	local var_39_0 = GameSetting.activity_hero_challenge_barbecue_coin_limit.value[1]

	arg_39_0.refreshtimeText_.text = SPHeroChallengeTools:GetBarbuceGameAwardRefreshTime()

	arg_39_0:RefreshShowReward()
end

function var_0_0.ResetGameView(arg_40_0)
	arg_40_0.judgeEffectController:SetSelectedState("none")
	manager.audio:StopEffect()
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

	local var_42_0 = DormRhythmGameData:GetResultInfo()

	arg_42_0.successNum.text = tostring(var_42_0.successfulNum)
	arg_42_0.mistakeNum.text = tostring(var_42_0.mistakeNum)
	arg_42_0.maxBatterNum.text = tostring(var_42_0.maxBatterNum)

	local var_42_1 = DormRhythmGameData:GetRunTimeData()
	local var_42_2 = DormRhythmGameData:GetLevelIDByDiff(arg_42_0.diff, arg_42_0.activityID)
	local var_42_3 = DormRhythmGameTools:CalGameScore(var_42_1, var_42_2, arg_42_0.activityID)
	local var_42_4 = DormRhythmGameTools:GetRank(var_42_3)
	local var_42_5 = DormConst.DORM_RHYTHMGAME_RANK[var_42_4]

	if var_42_5 then
		arg_42_0.scoreController:SetSelectedState(var_42_5)
	end

	local var_42_6 = DormRhythmGameData:GetLevelIDByDiff(arg_42_0.diff, arg_42_0.activityID)
	local var_42_7 = ActivityHeroChallengeBarbecueCfg[var_42_6].reward_list_coin[1][1]
	local var_42_8 = SpHeroChallengeConst.accelerateID

	arg_42_0.awardIcon1.sprite = ItemTools.getItemSprite(var_42_7)
	arg_42_0.awardIcon2.sprite = ItemTools.getItemSprite(var_42_8)

	local var_42_9 = 0
	local var_42_10 = 0

	if arg_42_1 then
		for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
			if var_42_7 == iter_42_1.id then
				var_42_9 = iter_42_1.num
			end

			if var_42_8 == iter_42_1.id then
				var_42_10 = iter_42_1.num
			end
		end
	end

	arg_42_0.awardtext1.text = var_42_9
	arg_42_0.awardtext2.text = var_42_10

	local var_42_11 = SPHeroChallengeData:GetBrabuceGameAwardNum()
	local var_42_12 = GameSetting.activity_hero_challenge_barbecue_coin_limit.value[1]

	if var_42_11 == var_42_12 then
		arg_42_0.curAwardText1.text = string.format("<color='#FF000B'>%d</color>", var_42_11) .. "/" .. var_42_12
	else
		arg_42_0.curAwardText1.text = var_42_11 .. "/" .. var_42_12
	end

	local var_42_13 = GameSetting.activity_hero_challenge_barbecue_ticket_limit.value[1]
	local var_42_14 = SPHeroChallengeData:GetBarbuceAccelerateNum()

	if var_42_14 == var_42_13 then
		arg_42_0.curAwardText2.text = string.format("<color='#FF000B'>%d</color>", var_42_14) .. "/" .. var_42_13
	else
		arg_42_0.curAwardText2.text = var_42_14 .. "/" .. var_42_13
	end
end

function var_0_0.GetGameNeedFatigue(arg_43_0)
	if DormitoryData:GetDailyCurrency() >= GameSetting.dorm_mg_reward_daily_max.value[1] then
		return 0
	else
		return GameSetting.dorm_mg_break_cost.value[1]
	end
end

function var_0_0.UpdataBatterNum(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = false
	local var_44_1 = DormRhythmGameData:GetRunTimeData()
	local var_44_2 = var_44_1.batterNum

	if var_44_2 > 0 then
		if arg_44_0.curBatterType == arg_44_1 then
			local var_44_3 = true
		end
	elseif arg_44_0.curBatterType == DormConst.DORM_RHYTHM_BUTTON_TYPE.fail then
		local var_44_4 = true
	end

	local var_44_5 = arg_44_0.effectLevel

	if arg_44_2 then
		arg_44_0.effectLevel = arg_44_2
	end

	if var_44_1 then
		arg_44_0.batterNum.text = string.format(GetTips("DORM_MG_BREAK_COMBO_COUNT"), var_44_2)

		if var_44_2 > 0 then
			arg_44_0.batterController:SetSelectedState("true")
			arg_44_0.batterAniamtor:Play("batter", 0, 0)
			arg_44_0.judgeEffectController:SetSelectedState("none")

			if not arg_44_3 then
				arg_44_0.judgeAnimator:Play("New Animation", -1, 0)
				arg_44_0.judgeAnimator:Update(0)

				if arg_44_1 == DormConst.DORM_RHYTHM_BUTTON_TYPE.left then
					manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit01", "")
					arg_44_0.judgeEffectController:SetSelectedState("blue")

					arg_44_0.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.left
				else
					manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit03", "")
					arg_44_0.judgeEffectController:SetSelectedState("red")

					arg_44_0.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.right
				end
			end
		else
			arg_44_0.batterController:SetSelectedState("false")
			arg_44_0:UpdataMistakeItem()

			if not arg_44_3 then
				arg_44_0.judgeAnimator:Play("GameObject_defeated", -1, 0)
				arg_44_0.judgeAnimator:Update(0)
				manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit02", "")

				arg_44_0.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.fail
			end
		end
	end
end

function var_0_0.UpdataMistakeItem(arg_45_0)
	if arg_45_0.mistakeList then
		for iter_45_0, iter_45_1 in ipairs(arg_45_0.mistakeList) do
			if iter_45_1.flag then
				iter_45_1.flag = false

				iter_45_1.controller:SetSelectedState("false")

				break
			end
		end
	end
end

function var_0_0.UpdataMistakeNum(arg_46_0)
	if arg_46_0.diff then
		local var_46_0 = DormRhythmGameData:GetLevelIDByDiff(arg_46_0.diff, arg_46_0.activityID)
		local var_46_1 = ActivityHeroChallengeBarbecueCfg[var_46_0].fail_max

		arg_46_0.mistakeList = {}

		for iter_46_0 = 1, var_46_1 do
			local var_46_2 = Object.Instantiate(arg_46_0.bgpowerGo_, arg_46_0.mistakeTrs)
			local var_46_3 = {
				flag = true,
				index = iter_46_0,
				go = var_46_2,
				controller = ControllerUtil.GetController(var_46_2.transform, "state")
			}

			var_46_3.controller:SetSelectedState("true")

			arg_46_0.mistakeList[iter_46_0] = var_46_3
		end
	end
end

function var_0_0.StopGame(arg_47_0)
	DormRhythmGameData:StopGame()

	arg_47_0.startGameFlag = false

	arg_47_0:ResetTimer()

	if arg_47_0.mistakeList then
		for iter_47_0, iter_47_1 in ipairs(arg_47_0.mistakeList) do
			Object.Destroy(iter_47_1.go)
		end

		arg_47_0.mistakeList = nil
	end
end

function var_0_0.SelDiff(arg_48_0, arg_48_1)
	arg_48_0.diff = arg_48_1
end

function var_0_0.ExitGame(arg_49_0)
	manager.audio:StopEffect()
	DormRhythmGameData:Dispose()
	arg_49_0.game:Abort()
	LuaExchangeHelper.GoToMain()
	OpenPageUntilLoaded("/spHeroChallengeMainView", {})
end

function var_0_0.SetDormGameEffect(arg_50_0, arg_50_1)
	return
end

function var_0_0.RefreshShowReward(arg_51_0)
	local var_51_0 = DormRhythmGameData:GetLevelIDByDiff(arg_51_0.diff, arg_51_0.activityID)
	local var_51_1 = ActivityHeroChallengeBarbecueCfg[var_51_0].reward_list_coin[1][1]
	local var_51_2 = #ActivityHeroChallengeBarbecueCfg[var_51_0].reward_list_ticket
	local var_51_3 = ActivityHeroChallengeBarbecueCfg[var_51_0].reward_list_ticket[var_51_2][1]

	arg_51_0.icon1Img_.sprite = ItemTools.getItemSprite(var_51_1)
	arg_51_0.icon2Img_.sprite = ItemTools.getItemSprite(SpHeroChallengeConst.accelerateID)

	local var_51_4 = SPHeroChallengeData:GetBrabuceGameAwardNum()
	local var_51_5 = GameSetting.activity_hero_challenge_barbecue_coin_limit.value[1]

	if var_51_4 == var_51_5 then
		arg_51_0.num1Text_.text = string.format("<color='#FF000B'>%d</color>", var_51_4) .. "/" .. var_51_5
	else
		arg_51_0.num1Text_.text = var_51_4 .. "/" .. var_51_5
	end

	local var_51_6 = GameSetting.activity_hero_challenge_barbecue_ticket_limit.value[1]
	local var_51_7 = SPHeroChallengeData:GetBarbuceAccelerateNum()

	if var_51_7 == var_51_6 then
		arg_51_0.num2Text_.text = string.format("<color='#FF000B'>%d</color>", var_51_7) .. "/" .. var_51_6
	else
		arg_51_0.num2Text_.text = var_51_7 .. "/" .. var_51_6
	end
end

function var_0_0.RefreshAward(arg_52_0, arg_52_1, arg_52_2)
	CommonTools.SetCommonData(arg_52_2, {
		id = arg_52_0.showRewardList[arg_52_1][1],
		number = arg_52_0.showRewardList[arg_52_1][2],
		clickFun = function()
			ShowPopItem(POP_ITEM, {
				arg_52_0.showRewardList[arg_52_1][1]
			})
		end
	})
end

function var_0_0.Dispose(arg_54_0)
	if arg_54_0.rewardList then
		for iter_54_0, iter_54_1 in pairs(arg_54_0.rewardList) do
			iter_54_1:Dispose()
		end
	end

	if arg_54_0.awardList then
		arg_54_0.awardList:Dispose()
	end

	if var_0_0.timer then
		for iter_54_2, iter_54_3 in pairs(var_0_0.timer) do
			iter_54_3:Stop()
		end
	end

	DormRhythmGameData:Dispose()
	var_0_0.super.Dispose(arg_54_0)
end

return var_0_0
