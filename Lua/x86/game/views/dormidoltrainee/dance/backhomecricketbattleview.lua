local var_0_0 = class("BackHomeCricketBattleView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleView"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()

	arg_3_0.leanTweenAni = {}
end

local function var_0_1(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.transform:GetComponent("ControllerExCollection")
	local var_4_1 = var_4_0:GetController("state")
	local var_4_2 = var_4_0:GetController("effect")

	table.insert(arg_4_0, {
		state = var_4_1,
		effect = var_4_2
	})
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.buffList = {}
	arg_5_0.leftBuffList = {}
	arg_5_0.rightBuffList = {}
	arg_5_0.playerBuffList = LuaList.New(handler(arg_5_0, arg_5_0.indexPlayerItem), arg_5_0.playerListGo_, BackHomeCricketBuffItem)
	arg_5_0.enemyBuffList = LuaList.New(handler(arg_5_0, arg_5_0.indexEnemyItem), arg_5_0.enemyListGo_, BackHomeCricketBuffItem)
	arg_5_0.modeController_ = arg_5_0.mainControllerEx_:GetController("mode")
	arg_5_0.gameStateController_ = arg_5_0.mainControllerEx_:GetController("gameState")
	arg_5_0.showBuffDetailController_ = arg_5_0.mainControllerEx_:GetController("showBuffDetail")
	arg_5_0.stateValueBlueController_ = arg_5_0.mainControllerEx_:GetController("stateValueBlue")
	arg_5_0.stateValueRedController_ = arg_5_0.mainControllerEx_:GetController("stateValueRed")
	arg_5_0.style1Item_ = EnterBattleStyleListItem.New(arg_5_0.style1Go_)
	arg_5_0.style2Item_ = EnterBattleStyleListItem.New(arg_5_0.style2Go_)
	arg_5_0.bubbleTimerList_ = {}
	arg_5_0.stateBlueController_ = arg_5_0.mainControllerEx_:GetController("stateBlue")
	arg_5_0.stateRedController_ = arg_5_0.mainControllerEx_:GetController("stateRed")
	arg_5_0.skillBlueController_ = arg_5_0.mainControllerEx_:GetController("skillBlue")
	arg_5_0.skillRedController_ = arg_5_0.mainControllerEx_:GetController("skillRed")
	arg_5_0.AttrBlueController_ = arg_5_0.mainControllerEx_:GetController("AttrBlue")
	arg_5_0.AttrRedController_ = arg_5_0.mainControllerEx_:GetController("AttrRed")
	arg_5_0.crownController_ = arg_5_0.mainControllerEx_:GetController("crown")
	arg_5_0.bubbleControllerList_ = {
		arg_5_0.stateBlueController_,
		arg_5_0.stateRedController_,
		arg_5_0.skillBlueController_,
		arg_5_0.skillRedController_,
		arg_5_0.AttrBlueController_,
		arg_5_0.AttrRedController_
	}
	arg_5_0.actionBtnControllers = {}

	var_0_1(arg_5_0.actionBtnControllers, arg_5_0.flowerBtn_)
	var_0_1(arg_5_0.actionBtnControllers, arg_5_0.fireworkBtn_)
	var_0_1(arg_5_0.actionBtnControllers, arg_5_0.cheerBtn_)

	arg_5_0.buttonMaskList = {
		arg_5_0.maskImg1_,
		arg_5_0.maskImg2_,
		arg_5_0.maskImg3_
	}
	arg_5_0.danmakuSubview = DanceGameDanmakuSubView.New(arg_5_0.danmakuView_)
end

function var_0_0.OnDanceGameStart(arg_6_0)
	arg_6_0.gameStateController_:SetSelectedState("start")

	local var_6_0 = DormCharacterActionManager.frameTaskRunner:NewTask()

	var_6_0:WaitUntil(function()
		return arg_6_0.gameStartAni_:GetCurrentAnimatorStateInfo(0).normalizedTime > 1
	end, true):Then(function()
		Dorm.storage:RecordData("dance.flags", "start", true)
		arg_6_0.gameStateController_:SetSelectedState("game")
	end)
	var_6_0:Start()
end

function var_0_0.OnDanceGameFinish(arg_9_0)
	arg_9_0.gameStateController_:SetSelectedState("end")
end

function var_0_0.GetStageEffect(arg_10_0, arg_10_1)
	return string.format("IdolTrainee/StageVfx/%s/%s", arg_10_0.stage, arg_10_1)
end

function var_0_0.ResetDanmakuAmount(arg_11_0)
	local var_11_0 = GameDisplayCfg.dorm_idol_stage_bullet_comment_normal.value[1]

	arg_11_0.danmakuSubview:SetExpectDanmakuAmount(var_11_0)
end

function var_0_0.StartDanmakuClimax(arg_12_0)
	local var_12_0 = GameDisplayCfg.dorm_idol_stage_bullet_comment_high_time.value[1]
	local var_12_1 = GameDisplayCfg.dorm_idol_stage_bullet_comment_high.value[1]

	arg_12_0:InterruptDanmakuClimax(false)

	arg_12_0.climaxTimer = Timer.New(function()
		arg_12_0:InterruptDanmakuClimax(true)
	end, var_12_0, false)

	arg_12_0.danmakuSubview:SetExpectDanmakuAmount(var_12_1)
	arg_12_0.danmakuSubview:SetDanmakuFilter(2)
	arg_12_0.climaxTimer:Start()
end

function var_0_0.InterruptDanmakuClimax(arg_14_0, arg_14_1)
	if arg_14_0.climaxTimer then
		arg_14_0.climaxTimer:Stop()

		arg_14_0.climaxTimer = nil

		if arg_14_1 then
			arg_14_0:ResetDanmakuAmount()
			arg_14_0.danmakuSubview:SetDanmakuFilter(1)
		end
	end
end

function var_0_0.AddListeners(arg_15_0)
	local var_15_0

	arg_15_0:AddBtnListener(arg_15_0.flowerBtn_, nil, function()
		if not arg_15_0:CooldownFinish() then
			return
		end

		local var_16_0 = "flower"
		local var_16_1 = DanceGame.actionCountNamespace
		local var_16_2 = arg_15_0:GetStageEffect(var_16_0)

		Dorm.LuaBridge.MiniGameBridge.PlayEffect(Vector3.zero, var_16_2, 6)
		arg_15_0:StartCooldownAndEffect(var_15_0, 1)
		arg_15_0:StartDanmakuClimax()

		local var_16_3 = Dorm.storage:GetData(var_16_1, var_16_0) or 0

		Dorm.storage:RecordData(var_16_1, var_16_0, var_16_3 + 1)
	end)
	arg_15_0:AddBtnListener(arg_15_0.fireworkBtn_, nil, function()
		if not arg_15_0:CooldownFinish() then
			return
		end

		local var_17_0 = "firework"
		local var_17_1 = DanceGame.actionCountNamespace
		local var_17_2 = arg_15_0:GetStageEffect(var_17_0)

		Dorm.LuaBridge.MiniGameBridge.PlayEffect(Vector3.zero, var_17_2, 6)
		arg_15_0:StartCooldownAndEffect(var_15_0, 2)
		arg_15_0:StartDanmakuClimax()

		local var_17_3 = Dorm.storage:GetData(var_17_1, var_17_0) or 0

		Dorm.storage:RecordData(var_17_1, var_17_0, var_17_3 + 1)
	end)
	arg_15_0:AddBtnListener(arg_15_0.cheerBtn_, nil, function()
		if not arg_15_0:CooldownFinish() then
			return
		end

		local var_18_0 = "cheer"
		local var_18_1 = DanceGame.actionCountNamespace
		local var_18_2 = arg_15_0:GetStageEffect("cheer")

		Dorm.LuaBridge.MiniGameBridge.PlayEffect(Vector3.zero, var_18_2, 6)
		arg_15_0:StartCooldownAndEffect(var_15_0, 3)
		arg_15_0:StartDanmakuClimax()

		local var_18_3 = Dorm.storage:GetData(var_18_1, var_18_0) or 0

		Dorm.storage:RecordData(var_18_1, var_18_0, var_18_3 + 1)
	end)
	arg_15_0:AddBtnListener(arg_15_0.skipBtn_, nil, function()
		DanceGame.GetInstance():SkipShow()
	end)
end

function var_0_0.CooldownFinish(arg_20_0)
	return arg_20_0.cooldownTimer == nil
end

function var_0_0.StartCooldownAndEffect(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = nullable(GameSetting, "dorm_idol_dance_support_cooldown", "value", 1) or 5

	arg_21_0.startCooldownTime = Time.time
	arg_21_0.cooldownTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		local var_22_0 = Time.time - arg_21_0.startCooldownTime

		for iter_22_0, iter_22_1 in ipairs(arg_21_0.buttonMaskList) do
			iter_22_1.fillAmount = 1 - var_22_0 / var_21_0
		end

		if var_22_0 > var_21_0 then
			arg_21_0:StopCooldown()

			if arg_21_1 then
				arg_21_1()
			end
		end
	end, -1, true)

	for iter_21_0, iter_21_1 in pairs(arg_21_0.actionBtnControllers) do
		iter_21_1.state:SetSelectedState("lock")

		if iter_21_0 == arg_21_2 then
			iter_21_1.effect:SetSelectedState("true")
		end
	end
end

function var_0_0.StopCooldown(arg_23_0)
	if arg_23_0.cooldownTimer then
		FuncTimerManager.inst:RemoveFuncTimer(arg_23_0.cooldownTimer)

		arg_23_0.cooldownTimer = nil
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.buttonMaskList) do
		iter_23_1.fillAmount = 1
	end

	for iter_23_2, iter_23_3 in pairs(arg_23_0.actionBtnControllers) do
		iter_23_3.state:SetSelectedState("available")
		iter_23_3.effect:SetSelectedState("false")
	end
end

function var_0_0.OnEnter(arg_24_0)
	if arg_24_0.params_.stage then
		arg_24_0.stage = arg_24_0.params_.stage
	end

	arg_24_0.leftScore, arg_24_0.rightScore = 0, 0
	arg_24_0.battleData = BackHomeCricketBattleData:GetSingleBattleData()
	arg_24_0.playerEID = DanceGame.GetInstance():GetPlayerCharaEID()
	arg_24_0.enemyEID = DanceGame.GetInstance():GetOpponentCharaEID()

	arg_24_0.modeController_:SetSelectedState("game")
	arg_24_0:RegisterEvents()
	arg_24_0:RefreshView()
	arg_24_0:UpdateScoreBar()

	if arg_24_0.battleData.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
		arg_24_0.modeController_:SetSelectedState("record")
	end

	arg_24_0.danmakuSubview:OnEnter()
	arg_24_0.danmakuSubview:SetDanmakuFilter(1)
	arg_24_0:ResetDanmakuAmount()
	arg_24_0:ClearBuffContentDisplay()
end

function var_0_0.OnTop(arg_25_0)
	arg_25_0:RefreshBar()
end

function var_0_0.OnExit(arg_26_0)
	arg_26_0:StopShowDetailTimer()
	arg_26_0:ClearBuffContentDisplay()
	manager.windowBar:HideBar()
	arg_26_0:RemoveAllEventListener()
	arg_26_0:InterruptDanmakuClimax(true)
	arg_26_0.danmakuSubview:OnExit()
	arg_26_0:StopCooldown()
	arg_26_0:CancelAllLeanTween()

	for iter_26_0 = 1, 6 do
		if arg_26_0.bubbleTimerList_[iter_26_0] then
			arg_26_0.bubbleControllerList_[iter_26_0]:SetSelectedState("false")
			arg_26_0.bubbleTimerList_[iter_26_0]:Stop()

			arg_26_0.bubbleTimerList_[iter_26_0] = nil
		end
	end

	if arg_26_0.countDownTimer_ then
		arg_26_0.countDownTimer_:Stop()

		arg_26_0.countDownTimer_ = nil
	end
end

function var_0_0.RefreshBar(arg_27_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		DanceGame.GetInstance():GotoResultView()
	end)
end

function var_0_0.RefreshView(arg_29_0)
	arg_29_0:RefreshStageState()

	local var_29_0

	if arg_29_0.battleData.enemyID or arg_29_0.battleData.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
		var_29_0 = IdolTraineePvpBattleCfg[arg_29_0.battleData.stageID]
	else
		var_29_0 = IdolTraineePveBattleCfg[arg_29_0.battleData.stageID]
	end

	arg_29_0.curCountTime_ = IdolStageMusicCfg[var_29_0.bgm].round_time
	arg_29_0.countDownText_.text = arg_29_0.curCountTime_ .. GetTips("SECOND")
end

function var_0_0.RegisterEvents(arg_30_0)
	arg_30_0:RegistEventListener(BACKHOME_CRICKET_REFRESH_BUFF, function(arg_31_0)
		arg_30_0.roundCount = arg_31_0

		arg_30_0:RefreshHeroBuffList()
	end)
	arg_30_0:RegistEventListener(BACKHOME_CRICKET_ROUND_END, function(arg_32_0)
		arg_30_0.roundCount = arg_32_0

		arg_30_0:RefreshScore()
	end)
end

function var_0_0.RefreshStageState(arg_33_0)
	return
end

function var_0_0.ShowCricketBattleResult(arg_34_0, arg_34_1)
	if arg_34_1.is_success then
		print("战斗胜利")
	else
		print("战斗失败")
	end
end

function var_0_0.indexPlayerItem(arg_35_0, arg_35_1, arg_35_2)
	arg_35_2:RefreshUI(arg_35_0.leftBuffList[arg_35_1], arg_35_0.SetBuffContentOnLeft)
end

function var_0_0.indexEnemyItem(arg_36_0, arg_36_1, arg_36_2)
	arg_36_2:RefreshUI(arg_36_0.rightBuffList[arg_36_1], arg_36_0.SetBuffContentOnRight)
end

function var_0_0.RefreshHeroBuffList(arg_37_0)
	local var_37_0 = arg_37_0:FilterBuffList(DormUtils.GetEntityData(arg_37_0.playerEID).buff)
	local var_37_1 = arg_37_0:FilterBuffList(DormUtils.GetEntityData(arg_37_0.enemyEID).buff)
	local var_37_2 = {}
	local var_37_3 = {}

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		var_37_2[iter_37_1.id] = true
	end

	for iter_37_2, iter_37_3 in ipairs(var_37_1) do
		var_37_3[iter_37_3.id] = true
	end

	for iter_37_4, iter_37_5 in ipairs(arg_37_0.leftBuffList) do
		var_37_2[iter_37_5.id] = nil
	end

	for iter_37_6, iter_37_7 in ipairs(arg_37_0.rightBuffList) do
		var_37_3[iter_37_7.id] = nil
	end

	for iter_37_8, iter_37_9 in pairs(var_37_2) do
		local var_37_4, var_37_5 = IdolTraineeTools:GetSkillEffect(iter_37_8)

		if var_37_4 then
			arg_37_0.buff1Text_.text = string.format("%+d%%", var_37_5)

			arg_37_0.stateValueBlueController_:SetSelectedState(var_37_5 > 0 and "add" or "reduce")
			arg_37_0:SetBubblesTimer(1)

			break
		end
	end

	for iter_37_10, iter_37_11 in pairs(var_37_3) do
		local var_37_6, var_37_7 = IdolTraineeTools:GetSkillEffect(iter_37_10)

		if var_37_6 then
			arg_37_0.buff2Text_.text = string.format("%+d%%", var_37_7)

			arg_37_0.stateValueRedController_:SetSelectedState(var_37_7 > 0 and "add" or "reduce")
			arg_37_0:SetBubblesTimer(2)

			break
		end
	end

	arg_37_0.leftBuffList = arg_37_0:FilterBuffList(DormUtils.GetEntityData(arg_37_0.playerEID).buff)
	arg_37_0.rightBuffList = arg_37_0:FilterBuffList(DormUtils.GetEntityData(arg_37_0.enemyEID).buff)

	arg_37_0.playerBuffList:StartScroll(#arg_37_0.leftBuffList)
	arg_37_0.enemyBuffList:StartScroll(#arg_37_0.rightBuffList)
end

local function var_0_2(arg_38_0, arg_38_1)
	local var_38_0 = string.format("特性分=%d", arg_38_0.type)
	local var_38_1 = string.format("技能分=%d", arg_38_0.actionScore)
	local var_38_2 = string.format("回合总分=%d", arg_38_0.isHit)

	print(arg_38_1, var_38_0, var_38_1, var_38_2)
end

function var_0_0.RefreshScore(arg_39_0)
	arg_39_0:ShowScoreBarInfo()
	arg_39_0:ShowBubbleInfo()
end

function var_0_0.UpdateScoreBar(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0

	arg_40_1 = arg_40_1 or arg_40_0.leftScore
	arg_40_2 = arg_40_2 or arg_40_0.rightScore

	local var_40_1 = arg_40_1 + arg_40_2 == 0 and 0.5 or Mathf.Clamp(arg_40_1 / (arg_40_1 + arg_40_2), 0.2, 0.8)

	arg_40_0.scoreImg_.fillAmount = var_40_1
	arg_40_0.barSeperator_.anchoredPosition = Vector3(var_40_1 * arg_40_0.scoreImg_.transform.rect.width, 0, 0)
	arg_40_0.leftScoreText_.text = string.format("%d", arg_40_1)
	arg_40_0.rightScoreText_.text = string.format("%d", arg_40_2)

	if var_40_1 > 0.5 then
		arg_40_0.crownController_:SetSelectedState("left")
	elseif var_40_1 < 0.5 then
		arg_40_0.crownController_:SetSelectedState("right")
	else
		arg_40_0.crownController_:SetSelectedState("equal")
	end
end

local function var_0_3(arg_41_0, arg_41_1, arg_41_2)
	return arg_41_1 * arg_41_2 + arg_41_0 * (1 - arg_41_2)
end

function var_0_0.UpdateScoreBarAni(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	local var_42_0 = arg_42_3 or 1
	local var_42_1 = arg_42_4 or 0.5
	local var_42_2 = arg_42_0.scoreImg_
	local var_42_3 = arg_42_0.leftScore
	local var_42_4 = arg_42_0.rightScore
	local var_42_5 = LeanTween.value(0, 1, var_42_0):setEase(LeanTweenType.easeInOutQuad):setDelay(var_42_1)

	var_42_5:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
		local var_43_0 = var_0_3(var_42_3, arg_42_1, arg_43_0)
		local var_43_1 = var_0_3(var_42_4, arg_42_2, arg_43_0)

		arg_42_0:UpdateScoreBar(var_43_0, var_43_1)
	end))
	var_42_5:setOnComplete(System.Action(function()
		arg_42_0:UpdateScoreBar(arg_42_1, arg_42_2)

		arg_42_0.leanTweenAni[var_42_2] = nil
	end))

	arg_42_0.leanTweenAni[var_42_2] = var_42_5
	arg_42_0.leftScore, arg_42_0.rightScore = arg_42_1, arg_42_2
end

function var_0_0.ShowScoreBarInfo(arg_45_0)
	if arg_45_0.roundCount ~= 0 then
		local var_45_0 = arg_45_0.battleData:GetBattleDataByRound(arg_45_0.roundCount)

		var_0_2(var_45_0.myScore, string.format("myScore at Round %d:", arg_45_0.roundCount))
		var_0_2(var_45_0.enemyScore, string.format("enemyScore at Round %d:", arg_45_0.roundCount))
		arg_45_0:UpdateScoreBarAni(var_45_0.myScore.isHit + arg_45_0.leftScore, var_45_0.enemyScore.isHit + arg_45_0.rightScore)
	else
		arg_45_0:UpdateScoreBar(0, 0)
	end
end

function var_0_0.ShowBubbleInfo(arg_46_0)
	if arg_46_0.roundCount == 0 then
		return
	end

	local var_46_0 = arg_46_0.battleData:GetBattleDataByRound(arg_46_0.roundCount)
	local var_46_1

	if arg_46_0.battleData.enemyID or arg_46_0.battleData.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
		var_46_1 = IdolTraineePvpBattleCfg[arg_46_0.battleData.stageID]
	else
		var_46_1 = IdolTraineePveBattleCfg[arg_46_0.battleData.stageID]
	end

	var_46_1 = var_46_1 or IdolTraineePvpBattleCfg[arg_46_0.battleData.stageID]

	local var_46_2 = var_46_0.myAction.actionID

	if var_46_2 and var_46_1.peculiarity_rate[var_46_2] then
		SetActive(arg_46_0.attr1Sp_, var_46_1.peculiarity_rate[var_46_2] > 100)
		arg_46_0.style1Item_:SetData(var_46_2)
		arg_46_0:StartScoreBubbleAni(arg_46_0.attrNum1Text_, var_46_0.myScore.isHit, var_46_0.myScore.type)
		arg_46_0:SetBubblesTimer(5)
	end

	local var_46_3 = var_46_0.enemyAction.actionID

	if var_46_3 and var_46_1.peculiarity_rate[var_46_3] then
		SetActive(arg_46_0.attr2Sp_, var_46_1.peculiarity_rate[var_46_3] > 100)
		arg_46_0.style2Item_:SetData(var_46_3)
		arg_46_0:StartScoreBubbleAni(arg_46_0.attrNum2Text_, var_46_0.enemyScore.isHit, var_46_0.enemyScore.type)
		arg_46_0:SetBubblesTimer(6)
	end

	local var_46_4 = var_46_0.myAction.skillID

	if var_46_4 and IdolTraineeSkillCfg[var_46_4] then
		arg_46_0.skill1Img_.sprite = IdolTraineeTools:GetSkillIcon(var_46_4)

		arg_46_0:SetBubblesTimer(3)
	end

	local var_46_5 = var_46_0.enemyAction.skillID

	if var_46_5 and IdolTraineeSkillCfg[var_46_5] then
		arg_46_0.skill2Img_.sprite = IdolTraineeTools:GetSkillIcon(var_46_5)

		arg_46_0:SetBubblesTimer(4)
	end
end

local function var_0_4(arg_47_0)
	return string.format("+%d", arg_47_0)
end

function var_0_0.StartScoreBubbleAni(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0 = arg_48_0.leanTweenAni[arg_48_1]

	if var_48_0 then
		LeanTween.cancel(arg_48_1.gameObject, var_48_0.id)
	end

	arg_48_3 = arg_48_3 or 0
	arg_48_1.text = var_0_4(arg_48_3)

	local var_48_1 = LeanTween.value(arg_48_3, arg_48_2, 0.5):setEase(LeanTweenType.easeInOutQuad):setDelay(0.5)

	var_48_1:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
		arg_48_1.text = var_0_4(math.floor(arg_49_0))
	end))
	var_48_1:setOnComplete(System.Action(function()
		arg_48_1.text = var_0_4(arg_48_2)
		arg_48_0.leanTweenAni[arg_48_1] = nil
	end))

	arg_48_0.leanTweenAni[arg_48_1] = var_48_1
end

function var_0_0.CancelAllLeanTween(arg_51_0)
	for iter_51_0, iter_51_1 in pairs(arg_51_0.leanTweenAni) do
		LeanTween.cancel(iter_51_1.id)
	end

	arg_51_0.leanTweenAni = {}
end

function var_0_0.SetBubblesTimer(arg_52_0, arg_52_1)
	arg_52_0.bubbleControllerList_[arg_52_1]:SetSelectedState("true")

	if arg_52_0.bubbleTimerList_[arg_52_1] then
		arg_52_0.bubbleTimerList_[arg_52_1]:Stop()

		arg_52_0.bubbleTimerList_[arg_52_1] = nil
	end

	arg_52_0.bubbleTimerList_[arg_52_1] = Timer.New(function()
		arg_52_0.bubbleControllerList_[arg_52_1]:SetSelectedState("false")

		if arg_52_0.bubbleTimerList_[arg_52_1] then
			arg_52_0.bubbleTimerList_[arg_52_1]:Stop()

			arg_52_0.bubbleTimerList_[arg_52_1] = nil
		end
	end, 1.5, 1)

	arg_52_0.bubbleTimerList_[arg_52_1]:Start()
end

function var_0_0.OnStartCountDownTimer(arg_54_0)
	if arg_54_0.countDownTimer_ then
		arg_54_0.countDownTimer_:Stop()

		arg_54_0.countDownTimer_ = nil
	end

	local var_54_0

	if arg_54_0.battleData.enemyID or arg_54_0.battleData.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
		var_54_0 = IdolTraineePvpBattleCfg[arg_54_0.battleData.stageID]
	else
		var_54_0 = IdolTraineePveBattleCfg[arg_54_0.battleData.stageID]
	end

	arg_54_0.curCountTime_ = IdolStageMusicCfg[var_54_0.bgm].round_time
	arg_54_0.countDownText_.text = arg_54_0.curCountTime_ .. GetTips("SECOND")
	arg_54_0.countDownTimer_ = Timer.New(function()
		arg_54_0.curCountTime_ = arg_54_0.curCountTime_ - 1

		if arg_54_0.curCountTime_ < 0 then
			if arg_54_0.countDownTimer_ then
				arg_54_0.countDownTimer_:Stop()

				arg_54_0.countDownTimer_ = nil
			end
		else
			arg_54_0.countDownText_.text = arg_54_0.curCountTime_ .. GetTips("SECOND")
		end
	end, 1, -1)

	arg_54_0.countDownTimer_:Start()
end

function var_0_0.FilterBuffList(arg_56_0, arg_56_1)
	local var_56_0 = {}

	if arg_56_1 then
		for iter_56_0, iter_56_1 in ipairs(arg_56_1) do
			if not iter_56_1.triggerRound or iter_56_1.triggerRound <= arg_56_0.roundCount then
				table.insert(var_56_0, iter_56_1)
			end
		end
	end

	return var_56_0
end

function var_0_0.Dispose(arg_57_0)
	if arg_57_0.playerBuffList then
		arg_57_0.playerBuffList:Dispose()
	end

	if arg_57_0.enemyBuffList then
		arg_57_0.enemyBuffList:Dispose()
	end

	if arg_57_0.style1Item_ then
		arg_57_0.style1Item_:Dispose()
	end

	if arg_57_0.style2Item_ then
		arg_57_0.style2Item_:Dispose()
	end

	arg_57_0:StopCooldown()
	arg_57_0.danmakuSubview:Dispose()
	var_0_0.super.Dispose(arg_57_0)
end

function var_0_0.StopShowDetailTimer(arg_58_0)
	if arg_58_0.showDetailTimer then
		arg_58_0.showDetailTimer:Stop()

		arg_58_0.showDetailTimer = nil
	end
end

function var_0_0.StartShowDetailTimer(arg_59_0)
	arg_59_0:StopShowDetailTimer()

	local var_59_0 = nullable(GameDisplayCfg, "dorm_idol_stage_show_buff_detail_time", "value", 1) or 2.5

	arg_59_0.showDetailTimer = Timer.New(handler(arg_59_0, arg_59_0.ClearBuffContentDisplay), var_59_0, false)

	arg_59_0.showDetailTimer:Start()
end

function var_0_0.OnBuffIconClick(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_2 then
		arg_60_0:StartShowDetailTimer()
		arg_60_2(arg_60_0, arg_60_1)
	end
end

function var_0_0.SetBuffContentOnLeft(arg_61_0, arg_61_1)
	arg_61_0.leftBuffDetail_.text = IdolTraineeTools:GetBuffDescString(arg_61_1, true, true, true, false)

	arg_61_0.showBuffDetailController_:SetSelectedState("left")
end

function var_0_0.SetBuffContentOnRight(arg_62_0, arg_62_1)
	arg_62_0.rightBuffDetail_.text = IdolTraineeTools:GetBuffDescString(arg_62_1, true, true, true, false)

	arg_62_0.showBuffDetailController_:SetSelectedState("right")
end

function var_0_0.ClearBuffContentDisplay(arg_63_0)
	arg_63_0.showBuffDetailController_:SetSelectedState("none")
end

return var_0_0
