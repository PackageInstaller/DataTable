local BackHomeCricketBattleView = class("BackHomeCricketBattleView", ReduxView)

function BackHomeCricketBattleView:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolBattleView"
end

function BackHomeCricketBattleView:UIParent()
	return manager.ui.uiMain.transform
end

function BackHomeCricketBattleView:Init()
	self:InitUI()
	self:AddListeners()

	self.leanTweenAni = {}
end

local function var_0_1(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.transform:GetComponent("ControllerExCollection")

	table.insert(arg_4_0, {
		state = var_4_0:GetController("state"),
		effect = var_4_0:GetController("effect")
	})
end

function BackHomeCricketBattleView:InitUI()
	self:BindCfgUI()

	self.buffList = {}
	self.leftBuffList = {}
	self.rightBuffList = {}
	self.playerBuffList = LuaList.New(handler(self, self.indexPlayerItem), self.playerListGo_, BackHomeCricketBuffItem)
	self.enemyBuffList = LuaList.New(handler(self, self.indexEnemyItem), self.enemyListGo_, BackHomeCricketBuffItem)
	self.modeController_ = self.mainControllerEx_:GetController("mode")
	self.gameStateController_ = self.mainControllerEx_:GetController("gameState")
	self.showBuffDetailController_ = self.mainControllerEx_:GetController("showBuffDetail")
	self.stateValueBlueController_ = self.mainControllerEx_:GetController("stateValueBlue")
	self.stateValueRedController_ = self.mainControllerEx_:GetController("stateValueRed")
	self.style1Item_ = EnterBattleStyleListItem.New(self.style1Go_)
	self.style2Item_ = EnterBattleStyleListItem.New(self.style2Go_)
	self.bubbleTimerList_ = {}
	self.stateBlueController_ = self.mainControllerEx_:GetController("stateBlue")
	self.stateRedController_ = self.mainControllerEx_:GetController("stateRed")
	self.skillBlueController_ = self.mainControllerEx_:GetController("skillBlue")
	self.skillRedController_ = self.mainControllerEx_:GetController("skillRed")
	self.AttrBlueController_ = self.mainControllerEx_:GetController("AttrBlue")
	self.AttrRedController_ = self.mainControllerEx_:GetController("AttrRed")
	self.crownController_ = self.mainControllerEx_:GetController("crown")
	self.bubbleControllerList_ = {
		self.stateBlueController_,
		self.stateRedController_,
		self.skillBlueController_,
		self.skillRedController_,
		self.AttrBlueController_,
		self.AttrRedController_
	}
	self.actionBtnControllers = {}

	var_0_1(self.actionBtnControllers, self.flowerBtn_)
	var_0_1(self.actionBtnControllers, self.fireworkBtn_)
	var_0_1(self.actionBtnControllers, self.cheerBtn_)

	self.buttonMaskList = {
		self.maskImg1_,
		self.maskImg2_,
		self.maskImg3_
	}
	self.danmakuSubview = DanceGameDanmakuSubView.New(self.danmakuView_)
end

function BackHomeCricketBattleView:OnDanceGameStart()
	self.gameStateController_:SetSelectedState("start")

	local var_6_0 = DormCharacterActionManager.frameTaskRunner:NewTask()

	var_6_0:WaitUntil(function()
		return self.gameStartAni_:GetCurrentAnimatorStateInfo(0).normalizedTime > 1
	end, true):Then(function()
		Dorm.storage:RecordData("dance.flags", "start", true)
		self.gameStateController_:SetSelectedState("game")
	end)
	var_6_0:Start()
end

function BackHomeCricketBattleView:OnDanceGameFinish()
	self.gameStateController_:SetSelectedState("end")
end

function BackHomeCricketBattleView:GetStageEffect(arg_10_1)
	return string.format("IdolTrainee/StageVfx/%s/%s", self.stage, arg_10_1)
end

function BackHomeCricketBattleView:ResetDanmakuAmount()
	self.danmakuSubview:SetExpectDanmakuAmount(GameDisplayCfg.dorm_idol_stage_bullet_comment_normal.value[1])
end

function BackHomeCricketBattleView:StartDanmakuClimax()
	self:InterruptDanmakuClimax(false)

	self.climaxTimer = Timer.New(function()
		self:InterruptDanmakuClimax(true)
	end, GameDisplayCfg.dorm_idol_stage_bullet_comment_high_time.value[1], false)

	self.danmakuSubview:SetExpectDanmakuAmount(GameDisplayCfg.dorm_idol_stage_bullet_comment_high.value[1])
	self.danmakuSubview:SetDanmakuFilter(2)
	self.climaxTimer:Start()
end

function BackHomeCricketBattleView:InterruptDanmakuClimax(arg_14_1)
	if self.climaxTimer then
		self.climaxTimer:Stop()

		self.climaxTimer = nil

		if arg_14_1 then
			self:ResetDanmakuAmount()
			self.danmakuSubview:SetDanmakuFilter(1)
		end
	end
end

function BackHomeCricketBattleView:AddListeners()
	local var_15_0

	self:AddBtnListener(self.flowerBtn_, nil, function()
		if not self:CooldownFinish() then
			return
		end

		local var_16_0 = "flower"

		Dorm.LuaBridge.MiniGameBridge.PlayEffect(Vector3.zero, self:GetStageEffect("flower"), 6)
		self:StartCooldownAndEffect(var_15_0, 1)
		self:StartDanmakuClimax()
		Dorm.storage:RecordData(DanceGame.actionCountNamespace, var_16_0, (Dorm.storage:GetData(DanceGame.actionCountNamespace, var_16_0) or 0) + 1)
	end)
	self:AddBtnListener(self.fireworkBtn_, nil, function()
		if not self:CooldownFinish() then
			return
		end

		local var_17_0 = "firework"

		Dorm.LuaBridge.MiniGameBridge.PlayEffect(Vector3.zero, self:GetStageEffect("firework"), 6)
		self:StartCooldownAndEffect(var_15_0, 2)
		self:StartDanmakuClimax()
		Dorm.storage:RecordData(DanceGame.actionCountNamespace, var_17_0, (Dorm.storage:GetData(DanceGame.actionCountNamespace, var_17_0) or 0) + 1)
	end)
	self:AddBtnListener(self.cheerBtn_, nil, function()
		if not self:CooldownFinish() then
			return
		end

		local var_18_0 = "cheer"

		Dorm.LuaBridge.MiniGameBridge.PlayEffect(Vector3.zero, self:GetStageEffect("cheer"), 6)
		self:StartCooldownAndEffect(var_15_0, 3)
		self:StartDanmakuClimax()
		Dorm.storage:RecordData(DanceGame.actionCountNamespace, var_18_0, (Dorm.storage:GetData(DanceGame.actionCountNamespace, var_18_0) or 0) + 1)
	end)
	self:AddBtnListener(self.skipBtn_, nil, function()
		DanceGame.GetInstance():SkipShow()
	end)
end

function BackHomeCricketBattleView:CooldownFinish()
	return self.cooldownTimer == nil
end

function BackHomeCricketBattleView:StartCooldownAndEffect(arg_21_1, arg_21_2)
	local var_21_0 = nullable(GameSetting, "dorm_idol_dance_support_cooldown", "value", 1) or 5

	self.startCooldownTime = Time.time
	self.cooldownTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function()
		for iter_22_0, iter_22_1 in ipairs(self.buttonMaskList) do
			iter_22_1.fillAmount = 1 - (Time.time - self.startCooldownTime) / var_21_0
		end

		if Time.time - self.startCooldownTime > var_21_0 then
			self:StopCooldown()

			if arg_21_1 then
				arg_21_1()
			end
		end
	end, -1, true)

	for iter_21_0, iter_21_1 in pairs(self.actionBtnControllers) do
		iter_21_1.state:SetSelectedState("lock")

		if iter_21_0 == arg_21_2 then
			iter_21_1.effect:SetSelectedState("true")
		end
	end
end

function BackHomeCricketBattleView:StopCooldown()
	if self.cooldownTimer then
		FuncTimerManager.inst:RemoveFuncTimer(self.cooldownTimer)

		self.cooldownTimer = nil
	end

	for iter_23_0, iter_23_1 in ipairs(self.buttonMaskList) do
		iter_23_1.fillAmount = 1
	end

	for iter_23_2, iter_23_3 in pairs(self.actionBtnControllers) do
		iter_23_3.state:SetSelectedState("available")
		iter_23_3.effect:SetSelectedState("false")
	end
end

function BackHomeCricketBattleView:OnEnter()
	if self.params_.stage then
		self.stage = self.params_.stage
	end

	self.leftScore, self.rightScore = 0, 0
	self.battleData = BackHomeCricketBattleData:GetSingleBattleData()
	self.playerEID = DanceGame.GetInstance():GetPlayerCharaEID()
	self.enemyEID = DanceGame.GetInstance():GetOpponentCharaEID()

	self.modeController_:SetSelectedState("game")
	self:RegisterEvents()
	self:RefreshView()
	self:UpdateScoreBar()

	if self.battleData.settleType == BackHomeCricketConst.ROOM_TYPE.Video then
		self.modeController_:SetSelectedState("record")
	end

	self.danmakuSubview:OnEnter()
	self.danmakuSubview:SetDanmakuFilter(1)
	self:ResetDanmakuAmount()
	self:ClearBuffContentDisplay()
end

function BackHomeCricketBattleView:OnTop()
	self:RefreshBar()
end

function BackHomeCricketBattleView:OnExit()
	self:StopShowDetailTimer()
	self:ClearBuffContentDisplay()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
	self:InterruptDanmakuClimax(true)
	self.danmakuSubview:OnExit()
	self:StopCooldown()
	self:CancelAllLeanTween()

	for iter_26_0 = 1, 6 do
		if self.bubbleTimerList_[iter_26_0] then
			self.bubbleControllerList_[iter_26_0]:SetSelectedState("false")
			self.bubbleTimerList_[iter_26_0]:Stop()

			self.bubbleTimerList_[iter_26_0] = nil
		end
	end

	if self.countDownTimer_ then
		self.countDownTimer_:Stop()

		self.countDownTimer_ = nil
	end
end

function BackHomeCricketBattleView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		DanceGame.GetInstance():GotoResultView()
	end)
end

function BackHomeCricketBattleView:RefreshView()
	self:RefreshStageState()

	self.curCountTime_ = IdolStageMusicCfg[((self.battleData.enemyID or self.battleData.settleType == BackHomeCricketConst.ROOM_TYPE.Video) and IdolTraineePvpBattleCfg[self.battleData.stageID] or IdolTraineePveBattleCfg[self.battleData.stageID]).bgm].round_time
	self.countDownText_.text = self.curCountTime_ .. GetTips("SECOND")
end

function BackHomeCricketBattleView:RegisterEvents()
	self:RegistEventListener(BACKHOME_CRICKET_REFRESH_BUFF, function(arg_31_0)
		self.roundCount = arg_31_0

		self:RefreshHeroBuffList()
	end)
	self:RegistEventListener(BACKHOME_CRICKET_ROUND_END, function(arg_32_0)
		self.roundCount = arg_32_0

		self:RefreshScore()
	end)
end

function BackHomeCricketBattleView:RefreshStageState()
	return
end

function BackHomeCricketBattleView:ShowCricketBattleResult(arg_34_1)
	if arg_34_1.is_success then
		print("战斗胜利")
	else
		print("战斗失败")
	end
end

function BackHomeCricketBattleView:indexPlayerItem(arg_35_1, arg_35_2)
	arg_35_2:RefreshUI(self.leftBuffList[arg_35_1], self.SetBuffContentOnLeft)
end

function BackHomeCricketBattleView:indexEnemyItem(arg_36_1, arg_36_2)
	arg_36_2:RefreshUI(self.rightBuffList[arg_36_1], self.SetBuffContentOnRight)
end

function BackHomeCricketBattleView:RefreshHeroBuffList()
	local var_37_0 = {}
	local var_37_1 = {}

	for iter_37_0, iter_37_1 in ipairs((self:FilterBuffList(DormUtils.GetEntityData(self.playerEID).buff))) do
		var_37_0[iter_37_1.id] = true
	end

	for iter_37_2, iter_37_3 in ipairs((self:FilterBuffList(DormUtils.GetEntityData(self.enemyEID).buff))) do
		var_37_1[iter_37_3.id] = true
	end

	for iter_37_4, iter_37_5 in ipairs(self.leftBuffList) do
		var_37_0[iter_37_5.id] = nil
	end

	for iter_37_6, iter_37_7 in ipairs(self.rightBuffList) do
		var_37_1[iter_37_7.id] = nil
	end

	for iter_37_8, iter_37_9 in pairs(var_37_0) do
		local var_37_2, var_37_3 = IdolTraineeTools:GetSkillEffect(iter_37_8)

		if var_37_2 then
			self.buff1Text_.text = string.format("%+d%%", var_37_3)

			self.stateValueBlueController_:SetSelectedState(var_37_3 > 0 and "add" or "reduce")
			self:SetBubblesTimer(1)

			break
		end
	end

	for iter_37_10, iter_37_11 in pairs(var_37_1) do
		local var_37_4, var_37_5 = IdolTraineeTools:GetSkillEffect(iter_37_10)

		if var_37_4 then
			self.buff2Text_.text = string.format("%+d%%", var_37_5)

			self.stateValueRedController_:SetSelectedState(var_37_5 > 0 and "add" or "reduce")
			self:SetBubblesTimer(2)

			break
		end
	end

	self.leftBuffList = self:FilterBuffList(DormUtils.GetEntityData(self.playerEID).buff)
	self.rightBuffList = self:FilterBuffList(DormUtils.GetEntityData(self.enemyEID).buff)

	self.playerBuffList:StartScroll(#self.leftBuffList)
	self.enemyBuffList:StartScroll(#self.rightBuffList)
end

local function var_0_2(arg_38_0, arg_38_1)
	print(arg_38_1, string.format("特性分=%d", arg_38_0.type), string.format("技能分=%d", arg_38_0.actionScore), (string.format("回合总分=%d", arg_38_0.isHit)))
end

function BackHomeCricketBattleView:RefreshScore()
	self:ShowScoreBarInfo()
	self:ShowBubbleInfo()
end

function BackHomeCricketBattleView:UpdateScoreBar(arg_40_1, arg_40_2)
	arg_40_1 = arg_40_1 or self.leftScore
	arg_40_2 = arg_40_2 or self.rightScore

	local var_40_1 = arg_40_1 + arg_40_2 == 0 and 0.5 or Mathf.Clamp(arg_40_1 / (arg_40_1 + arg_40_2), 0.2, 0.8)

	self.scoreImg_.fillAmount = var_40_1
	self.barSeperator_.anchoredPosition = Vector3(var_40_1 * self.scoreImg_.transform.rect.width, 0, 0)
	self.leftScoreText_.text = string.format("%d", arg_40_1)
	self.rightScoreText_.text = string.format("%d", arg_40_2)

	if var_40_1 > 0.5 then
		self.crownController_:SetSelectedState("left")
	elseif var_40_1 < 0.5 then
		self.crownController_:SetSelectedState("right")
	else
		self.crownController_:SetSelectedState("equal")
	end
end

local function var_0_3(arg_41_0, arg_41_1, arg_41_2)
	return arg_41_1 * arg_41_2 + arg_41_0 * (1 - arg_41_2)
end

function BackHomeCricketBattleView:UpdateScoreBarAni(arg_42_1, arg_42_2, arg_42_3, arg_42_4)
	local var_42_0 = self.scoreImg_
	local var_42_1 = self.leftScore
	local var_42_2 = self.rightScore
	local var_42_3 = LeanTween.value(0, 1, arg_42_3 or 1):setEase(LeanTweenType.easeInOutQuad):setDelay(arg_42_4 or 0.5)

	var_42_3:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
		self:UpdateScoreBar(var_0_3(var_42_1, arg_42_1, arg_43_0), (var_0_3(var_42_2, arg_42_2, arg_43_0)))
	end))
	var_42_3:setOnComplete(System.Action(function()
		self:UpdateScoreBar(arg_42_1, arg_42_2)

		self.leanTweenAni[var_42_0] = nil
	end))

	self.leanTweenAni[var_42_0] = var_42_3
	self.leftScore, self.rightScore = arg_42_1, arg_42_2
end

function BackHomeCricketBattleView:ShowScoreBarInfo()
	if self.roundCount ~= 0 then
		local var_45_0 = self.battleData:GetBattleDataByRound(self.roundCount)

		var_0_2(var_45_0.myScore, string.format("myScore at Round %d:", self.roundCount))
		var_0_2(var_45_0.enemyScore, string.format("enemyScore at Round %d:", self.roundCount))
		self:UpdateScoreBarAni(var_45_0.myScore.isHit + self.leftScore, var_45_0.enemyScore.isHit + self.rightScore)
	else
		self:UpdateScoreBar(0, 0)
	end
end

function BackHomeCricketBattleView:ShowBubbleInfo()
	if self.roundCount == 0 then
		return
	end

	local var_46_0 = self.battleData:GetBattleDataByRound(self.roundCount)
	local var_46_1 = (self.battleData.enemyID or self.battleData.settleType == BackHomeCricketConst.ROOM_TYPE.Video) and IdolTraineePvpBattleCfg[self.battleData.stageID] or IdolTraineePveBattleCfg[self.battleData.stageID]

	var_46_1 = var_46_1 or IdolTraineePvpBattleCfg[self.battleData.stageID]

	local var_46_2 = var_46_0.myAction.actionID

	if var_46_0.myAction.actionID and var_46_1.peculiarity_rate[var_46_2] then
		SetActive(self.attr1Sp_, var_46_1.peculiarity_rate[var_46_2] > 100)
		self.style1Item_:SetData(var_46_2)
		self:StartScoreBubbleAni(self.attrNum1Text_, var_46_0.myScore.isHit, var_46_0.myScore.type)
		self:SetBubblesTimer(5)
	end

	local var_46_3 = var_46_0.enemyAction.actionID

	if var_46_0.enemyAction.actionID and var_46_1.peculiarity_rate[var_46_3] then
		SetActive(self.attr2Sp_, var_46_1.peculiarity_rate[var_46_3] > 100)
		self.style2Item_:SetData(var_46_3)
		self:StartScoreBubbleAni(self.attrNum2Text_, var_46_0.enemyScore.isHit, var_46_0.enemyScore.type)
		self:SetBubblesTimer(6)
	end

	local var_46_4 = var_46_0.myAction.skillID

	if var_46_0.myAction.skillID and IdolTraineeSkillCfg[var_46_4] then
		self.skill1Img_.sprite = IdolTraineeTools:GetSkillIcon(var_46_4)

		self:SetBubblesTimer(3)
	end

	local var_46_5 = var_46_0.enemyAction.skillID

	if var_46_0.enemyAction.skillID and IdolTraineeSkillCfg[var_46_5] then
		self.skill2Img_.sprite = IdolTraineeTools:GetSkillIcon(var_46_5)

		self:SetBubblesTimer(4)
	end
end

local function var_0_4(arg_47_0)
	return string.format("+%d", arg_47_0)
end

function BackHomeCricketBattleView:StartScoreBubbleAni(arg_48_1, arg_48_2, arg_48_3)
	if self.leanTweenAni[arg_48_1] then
		LeanTween.cancel(arg_48_1.gameObject, self.leanTweenAni[arg_48_1].id)
	end

	arg_48_3 = arg_48_3 or 0
	arg_48_1.text = var_0_4(arg_48_3)

	local var_48_0 = LeanTween.value(arg_48_3, arg_48_2, 0.5):setEase(LeanTweenType.easeInOutQuad):setDelay(0.5)

	var_48_0:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
		arg_48_1.text = var_0_4(math.floor(arg_49_0))
	end))
	var_48_0:setOnComplete(System.Action(function()
		arg_48_1.text = var_0_4(arg_48_2)
		self.leanTweenAni[arg_48_1] = nil
	end))

	self.leanTweenAni[arg_48_1] = var_48_0
end

function BackHomeCricketBattleView:CancelAllLeanTween()
	for iter_51_0, iter_51_1 in pairs(self.leanTweenAni) do
		LeanTween.cancel(iter_51_1.id)
	end

	self.leanTweenAni = {}
end

function BackHomeCricketBattleView:SetBubblesTimer(arg_52_1)
	self.bubbleControllerList_[arg_52_1]:SetSelectedState("true")

	if self.bubbleTimerList_[arg_52_1] then
		self.bubbleTimerList_[arg_52_1]:Stop()

		self.bubbleTimerList_[arg_52_1] = nil
	end

	self.bubbleTimerList_[arg_52_1] = Timer.New(function()
		self.bubbleControllerList_[arg_52_1]:SetSelectedState("false")

		if self.bubbleTimerList_[arg_52_1] then
			self.bubbleTimerList_[arg_52_1]:Stop()

			self.bubbleTimerList_[arg_52_1] = nil
		end
	end, 1.5, 1)

	self.bubbleTimerList_[arg_52_1]:Start()
end

function BackHomeCricketBattleView:OnStartCountDownTimer()
	if self.countDownTimer_ then
		self.countDownTimer_:Stop()

		self.countDownTimer_ = nil
	end

	self.curCountTime_ = IdolStageMusicCfg[((self.battleData.enemyID or self.battleData.settleType == BackHomeCricketConst.ROOM_TYPE.Video) and IdolTraineePvpBattleCfg[self.battleData.stageID] or IdolTraineePveBattleCfg[self.battleData.stageID]).bgm].round_time
	self.countDownText_.text = self.curCountTime_ .. GetTips("SECOND")
	self.countDownTimer_ = Timer.New(function()
		self.curCountTime_ = self.curCountTime_ - 1

		if self.curCountTime_ < 0 then
			if self.countDownTimer_ then
				self.countDownTimer_:Stop()

				self.countDownTimer_ = nil
			end
		else
			self.countDownText_.text = self.curCountTime_ .. GetTips("SECOND")
		end
	end, 1, -1)

	self.countDownTimer_:Start()
end

function BackHomeCricketBattleView:FilterBuffList(arg_56_1)
	local var_56_0 = {}

	if arg_56_1 then
		for iter_56_0, iter_56_1 in ipairs(arg_56_1) do
			if not iter_56_1.triggerRound or iter_56_1.triggerRound <= self.roundCount then
				table.insert(var_56_0, iter_56_1)
			end
		end
	end

	return var_56_0
end

function BackHomeCricketBattleView:Dispose()
	if self.playerBuffList then
		self.playerBuffList:Dispose()
	end

	if self.enemyBuffList then
		self.enemyBuffList:Dispose()
	end

	if self.style1Item_ then
		self.style1Item_:Dispose()
	end

	if self.style2Item_ then
		self.style2Item_:Dispose()
	end

	self:StopCooldown()
	self.danmakuSubview:Dispose()
	BackHomeCricketBattleView.super.Dispose(self)
end

function BackHomeCricketBattleView:StopShowDetailTimer()
	if self.showDetailTimer then
		self.showDetailTimer:Stop()

		self.showDetailTimer = nil
	end
end

function BackHomeCricketBattleView:StartShowDetailTimer()
	self:StopShowDetailTimer()

	self.showDetailTimer = Timer.New(handler(self, self.ClearBuffContentDisplay), nullable(GameDisplayCfg, "dorm_idol_stage_show_buff_detail_time", "value", 1) or 2.5, false)

	self.showDetailTimer:Start()
end

function BackHomeCricketBattleView:OnBuffIconClick(arg_60_1, arg_60_2)
	if arg_60_2 then
		self:StartShowDetailTimer()
		arg_60_2(self, arg_60_1)
	end
end

function BackHomeCricketBattleView:SetBuffContentOnLeft(arg_61_1)
	self.leftBuffDetail_.text = IdolTraineeTools:GetBuffDescString(arg_61_1, true, true, true, false)

	self.showBuffDetailController_:SetSelectedState("left")
end

function BackHomeCricketBattleView:SetBuffContentOnRight(arg_62_1)
	self.rightBuffDetail_.text = IdolTraineeTools:GetBuffDescString(arg_62_1, true, true, true, false)

	self.showBuffDetailController_:SetSelectedState("right")
end

function BackHomeCricketBattleView:ClearBuffContentDisplay()
	self.showBuffDetailController_:SetSelectedState("none")
end

return BackHomeCricketBattleView
