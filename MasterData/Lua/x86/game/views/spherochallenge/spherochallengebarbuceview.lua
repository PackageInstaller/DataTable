local SPHeroChallengeBarbuceView = class("SPHeroChallengeBarbuceView", ReduxView)

function SPHeroChallengeBarbuceView:UIName()
	return "Widget/System/SPHeroChallenge/SPHeroChallengeBarbuceUI"
end

function SPHeroChallengeBarbuceView:UIParent()
	return manager.ui.uiMain.transform
end

function SPHeroChallengeBarbuceView:OnCtor()
	self.game = require("game.dorm.minigame.Include").Barbuce.New(function()
		local var_4_0 = not nullable(self, "startGameFlag")

		if var_4_0 then
			return var_4_0, DormRhythmGameTools:GetGameResult(DormRhythmGameData:GetRunTimeData(), DormRhythmGameData:GetLevelIDByDiff(self.diff, self.activityID), self.activityID)
		end

		return var_4_0
	end)
	self.heroEID = self.game.heroEID

	local var_3_0 = ActivityHeroChallengeCfg[SPHeroChallengeData:GetActivityID()].hero_id

	if not ActivityHeroChallengeCfg[SPHeroChallengeData:GetActivityID()].hero_id then
		self.heroID = 1084
	end
end

function SPHeroChallengeBarbuceView:Init()
	self:InitUI()
	self:AddUIListener()
	self:ResetTimer()

	self.goData = {
		itemGo = self.itemGo,
		parentTrs = self.itemParentTrs,
		deterGo = self.deterGo_
	}
	self.judgeEffectController = ControllerUtil.GetController(self.deterGo_.transform, "effect")
	self.judgeAnimator = self.deterGo_:GetComponent("Animator")
end

function SPHeroChallengeBarbuceView:InitUI()
	self:BindCfgUI()

	self.viewController = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.countDownController = ControllerUtil.GetController(self.gameObject_.transform, "countDown")
	self.batterController = ControllerUtil.GetController(self.gameObject_.transform, "batter")
	self.scoreController = ControllerUtil.GetController(self.settlementpanelGo_.transform, "score")
	self.shareController = ControllerUtil.GetController(self.settlementpanelGo_.transform, "share")
	self.awardList = LuaList.New(handler(self, self.RefreshAward), self.uilistGo_, CommonItemView)

	self:InitAnimationController()
end

function SPHeroChallengeBarbuceView:InitAnimationController()
	self.batterAniamtor = self.batterGo:GetComponent("Animator")
	self.countAnimator = self.countGo:GetComponent("Animator")
	self.settleAnimator = self.settlementpanelGo_:GetComponent("Animator")
end

function SPHeroChallengeBarbuceView:ShareExitCallBack()
	self.shareController:SetSelectedState("false")
end

function SPHeroChallengeBarbuceView:OnEnter()
	self.enterFlag = true
	self.info = SPHeroChallengeData:GetCurActivityInfo()
	self.activityID = SPHeroChallengeData:GetActivityID()

	self:RegisterEvents()
	self:ResetStartView()
end

function SPHeroChallengeBarbuceView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function SPHeroChallengeBarbuceView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		DestroyLua()
		LuaExchangeHelper.GoToMain()
	end)
end

function SPHeroChallengeBarbuceView:RegisterEvents()
	self:RegistEventListener(DORM_STOP_RHYTHM_GAME, function(arg_14_0, arg_14_1)
		if arg_14_0 then
			self:RefreshSettleView(arg_14_1)
		else
			SDKTools.SendMessageToSDK("backhome_mg_result", {
				result = 2,
				activity_id = SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].barbuceActiVityID
			})
			self:ResetStartView()
		end
	end)
	self:RegistEventListener(DORM_REFRESH_BATTER_NUM, function(arg_15_0, arg_15_1)
		local var_15_0 = DormRhythmGameData:GetRunTimeData()
		local var_15_1 = DormRhythmGameData:GetLevelIDByDiff(self.diff, self.activityID)

		if ActivityHeroChallengeBarbecueCfg[var_15_1].fail_max <= var_15_0.mistakeNum then
			self:SettlementRhythmGame()

			return
		end

		local var_15_2 = DormRhythmGameTools:GetEffectRank((DormRhythmGameTools:CalGameScore(var_15_0, var_15_1, self.activityID)))

		if var_15_2 then
			self:SetDormGameEffect(var_15_2)
		end

		self:UpdataBatterNum(arg_15_0, var_15_2, arg_15_1)
	end)
	self:RegistEventListener(BREAK_GAME_LAST_SUCCESS, function()
		self:SettlementRhythmGame()
	end)
	self:RegistEventListener(BREAK_GAME_REFRESH_VIEW, function()
		self:RefreshStartAwardInfo()
	end)
end

function SPHeroChallengeBarbuceView:SettlementRhythmGame()
	self:StopGame()
	SPHeroChallengeAction:SettleBarbecueGame({
		result = 1,
		stage_id = ActivityHeroChallengeBarbecueCfg.get_id_list_by_difficult[self.diff][1],
		index = DormRhythmGameTools:GetRank((DormRhythmGameTools:CalGameScore(DormRhythmGameData:GetRunTimeData(), DormRhythmGameData:GetLevelIDByDiff(self.diff, self.activityID), self.activityID))),
		hero_id = self.heroID
	})
end

function SPHeroChallengeBarbuceView:AddUIListener()
	self:AddBtnListener(self.startBtn, nil, function()
		self:StartGame()
	end)

	for iter_19_0 = 1, 3 do
		self:AddToggleListener(self["level" .. iter_19_0 .. "Tgl"], function(arg_21_0)
			if arg_21_0 then
				self:ChoiceDiff(iter_19_0)
			end
		end)
	end

	self:AddBtnListener(self.leftBtn_, nil, function()
		if not DormRhythmGameData:GetGameRunFlag() then
			return
		end

		DormRhythmGameData:ClickDetermination(DormConst.DORM_RHYTHM_BUTTON_TYPE.left)
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		if not DormRhythmGameData:GetGameRunFlag() then
			return
		end

		DormRhythmGameData:ClickDetermination(DormConst.DORM_RHYTHM_BUTTON_TYPE.right)
	end)
	self:AddBtnListener(self.exitGame, nil, function()
		self:ResetStartView()
	end)
	self:AddBtnListener(self.reStartBtn, nil, function()
		self:ResetStartView()
		self:StartGame()
	end)
	self:AddBtnListener(self.shareBtn, nil, function()
		manager.share:Share(function()
			self.shareController:SetSelectedState("true")
		end, function()
			self.shareController:SetSelectedState("false")
		end, function()
			return
		end, nil, {
			cardShowUID = true,
			cardShowLv = true,
			logoPos = 2,
			cardPos = 3,
			cardShow = true
		})
	end)
	self:AddBtnListener(self.pauseBtn, nil, function()
		DormRhythmGameData:SetPauseFlag(true)
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("DORM_MG_LEAVE_CONFIRM"),
			OkCallback = function()
				self:StopGame()
				self:ResetStartView()
				SDKTools.SendMessageToSDK("backhome_mg_result", {
					result = 3,
					activity_id = SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].barbuceActiVityID
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

function SPHeroChallengeBarbuceView:StartGame()
	if self.diff then
		self.startGameFlag = true

		if not self.enterFlag then
			self.game:PlayStartAnim()
		end

		self.game:Start()
		self:ResetGameView()

		self.enterFlag = false
	else
		print("未选择游戏难度")
	end
end

function SPHeroChallengeBarbuceView:ChoiceDiff(arg_35_1)
	self.diff = arg_35_1
end

function SPHeroChallengeBarbuceView:ResetTimer()
	if SPHeroChallengeBarbuceView.timer then
		for iter_36_0, iter_36_1 in pairs(SPHeroChallengeBarbuceView.timer) do
			iter_36_1:Stop()
		end
	end

	SPHeroChallengeBarbuceView.timer = {}

	local var_36_0 = GameDisplayCfg.dorm_mg_start_time.value[1]

	self.countDownController:SetSelectedState("true")

	self.countDownText.text = GameDisplayCfg.dorm_mg_start_time.value[1]
	SPHeroChallengeBarbuceView.timer.startTimer = Timer.New(function()
		self.countAnimator:Play("batter", 0, 0)

		var_36_0 = var_36_0 - 1

		if var_36_0 <= 0 then
			local var_37_0 = self.diff or 1
			local var_37_1 = {
				diff = var_37_0,
				heroID = self.heroID,
				stageID = ActivityHeroChallengeBarbecueCfg.get_id_list_by_difficult[var_37_0][1],
				goInfo = self.goData,
				activityID = self.activityID
			}

			self.countDownController:SetSelectedState("false")
			DormRhythmGameData:StartGame(var_37_1)
			SPHeroChallengeBarbuceView.timer.startTimer:Stop()
		end

		self.countDownText.text = var_36_0
	end, 1, -1)
end

function SPHeroChallengeBarbuceView:ResetStartView()
	self:ResetTimer()
	self:RefreshBar()
	self.viewController:SetSelectedState("start")

	if not self.diff then
		self.diff = 1
		self.level1Tgl.isOn = true
	else
		self["level" .. self.diff .. "Tgl"].isOn = true
	end

	self.costFatigueText.text = "x" .. tostring((self:GetGameNeedFatigue()))

	self:RefreshStartAwardInfo()
end

function SPHeroChallengeBarbuceView:RefreshStartAwardInfo()
	self.refreshtimeText_.text = SPHeroChallengeTools:GetBarbuceGameAwardRefreshTime()

	self:RefreshShowReward()
end

function SPHeroChallengeBarbuceView:ResetGameView()
	self.judgeEffectController:SetSelectedState("none")
	manager.audio:StopEffect()
	self.viewController:SetSelectedState("playing")
	manager.windowBar:HideBar()
	self.batterController:SetSelectedState("false")
	self.timer.startTimer:Start()
	manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_start", "")
	self:UpdataMistakeNum()

	self.effectLevel = 0
	self.curBatterType = nil

	self:SetDormGameEffect(0)
end

function SPHeroChallengeBarbuceView:awardIndexItem(arg_41_1, arg_41_2)
	arg_41_2:SetData(self.awardList[arg_41_1])
end

function SPHeroChallengeBarbuceView:RefreshSettleView(arg_42_1)
	self.viewController:SetSelectedState("settlement")
	self.settleAnimator:Play("settle", -1, 0)
	self.settleAnimator:Update(0)

	local var_42_0 = DormRhythmGameData:GetResultInfo()

	self.successNum.text = tostring(var_42_0.successfulNum)
	self.mistakeNum.text = tostring(var_42_0.mistakeNum)
	self.maxBatterNum.text = tostring(var_42_0.maxBatterNum)

	local var_42_1 = DormConst.DORM_RHYTHMGAME_RANK[DormRhythmGameTools:GetRank((DormRhythmGameTools:CalGameScore(DormRhythmGameData:GetRunTimeData(), DormRhythmGameData:GetLevelIDByDiff(self.diff, self.activityID), self.activityID)))]

	if var_42_1 then
		self.scoreController:SetSelectedState(var_42_1)
	end

	self.awardIcon1.sprite = ItemTools.getItemSprite(ActivityHeroChallengeBarbecueCfg[DormRhythmGameData:GetLevelIDByDiff(self.diff, self.activityID)].reward_list_coin[1][1])
	self.awardIcon2.sprite = ItemTools.getItemSprite(SpHeroChallengeConst.accelerateID)

	local var_42_2 = 0
	local var_42_3 = 0

	if arg_42_1 then
		for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
			if ActivityHeroChallengeBarbecueCfg[DormRhythmGameData:GetLevelIDByDiff(self.diff, self.activityID)].reward_list_coin[1][1] == iter_42_1.id then
				var_42_2 = iter_42_1.num
			end

			if SpHeroChallengeConst.accelerateID == iter_42_1.id then
				var_42_3 = iter_42_1.num
			end
		end
	end

	self.awardtext1.text = var_42_2
	self.awardtext2.text = var_42_3

	local var_42_4 = SPHeroChallengeData:GetBrabuceGameAwardNum()

	self.curAwardText1.text = var_42_4 == GameSetting.activity_hero_challenge_barbecue_coin_limit.value[1] and string.format("<color='#FF000B'>%d</color>", var_42_4) .. "/" .. GameSetting.activity_hero_challenge_barbecue_coin_limit.value[1] or var_42_4 .. "/" .. GameSetting.activity_hero_challenge_barbecue_coin_limit.value[1]

	local var_42_5 = GameSetting.activity_hero_challenge_barbecue_ticket_limit.value[1]
	local var_42_6 = SPHeroChallengeData:GetBarbuceAccelerateNum()

	self.curAwardText2.text = var_42_6 == GameSetting.activity_hero_challenge_barbecue_ticket_limit.value[1] and string.format("<color='#FF000B'>%d</color>", var_42_6) .. "/" .. var_42_5 or var_42_6 .. "/" .. var_42_5
end

function SPHeroChallengeBarbuceView:GetGameNeedFatigue()
	if DormitoryData:GetDailyCurrency() >= GameSetting.dorm_mg_reward_daily_max.value[1] then
		return 0
	else
		return GameSetting.dorm_mg_break_cost.value[1]
	end
end

function SPHeroChallengeBarbuceView:UpdataBatterNum(arg_44_1, arg_44_2, arg_44_3)
	local var_44_1 = DormRhythmGameData:GetRunTimeData()
	local var_44_2 = var_44_1.batterNum

	if var_44_1.batterNum > 0 then
		if self.curBatterType == arg_44_1 then
			-- block empty
		end
	elseif self.curBatterType == DormConst.DORM_RHYTHM_BUTTON_TYPE.fail then
		-- block empty
	end

	if arg_44_2 then
		self.effectLevel = arg_44_2
	end

	if var_44_1 then
		self.batterNum.text = string.format(GetTips("DORM_MG_BREAK_COMBO_COUNT"), var_44_2)

		if var_44_2 > 0 then
			self.batterController:SetSelectedState("true")
			self.batterAniamtor:Play("batter", 0, 0)
			self.judgeEffectController:SetSelectedState("none")

			if not arg_44_3 then
				self.judgeAnimator:Play("New Animation", -1, 0)
				self.judgeAnimator:Update(0)

				if arg_44_1 == DormConst.DORM_RHYTHM_BUTTON_TYPE.left then
					manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit01", "")
					self.judgeEffectController:SetSelectedState("blue")

					self.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.left
				else
					manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit03", "")
					self.judgeEffectController:SetSelectedState("red")

					self.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.right
				end
			end
		else
			self.batterController:SetSelectedState("false")
			self:UpdataMistakeItem()

			if not arg_44_3 then
				self.judgeAnimator:Play("GameObject_defeated", -1, 0)
				self.judgeAnimator:Update(0)
				manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit02", "")

				self.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.fail
			end
		end
	end
end

function SPHeroChallengeBarbuceView:UpdataMistakeItem()
	if self.mistakeList then
		for iter_45_0, iter_45_1 in ipairs(self.mistakeList) do
			if iter_45_1.flag then
				iter_45_1.flag = false

				iter_45_1.controller:SetSelectedState("false")

				break
			end
		end
	end
end

function SPHeroChallengeBarbuceView:UpdataMistakeNum()
	if self.diff then
		self.mistakeList = {}

		for iter_46_0 = 1, ActivityHeroChallengeBarbecueCfg[DormRhythmGameData:GetLevelIDByDiff(self.diff, self.activityID)].fail_max do
			local var_46_0 = Object.Instantiate(self.bgpowerGo_, self.mistakeTrs)
			local var_46_1 = {
				flag = true,
				index = iter_46_0,
				go = var_46_0,
				controller = ControllerUtil.GetController(var_46_0.transform, "state")
			}

			var_46_1.controller:SetSelectedState("true")

			self.mistakeList[iter_46_0] = var_46_1
		end
	end
end

function SPHeroChallengeBarbuceView:StopGame()
	DormRhythmGameData:StopGame()

	self.startGameFlag = false

	self:ResetTimer()

	if self.mistakeList then
		for iter_47_0, iter_47_1 in ipairs(self.mistakeList) do
			Object.Destroy(iter_47_1.go)
		end

		self.mistakeList = nil
	end
end

function SPHeroChallengeBarbuceView:SelDiff(arg_48_1)
	self.diff = arg_48_1
end

function SPHeroChallengeBarbuceView:ExitGame()
	manager.audio:StopEffect()
	DormRhythmGameData:Dispose()
	self.game:Abort()
	LuaExchangeHelper.GoToMain()
	OpenPageUntilLoaded("/spHeroChallengeMainView", {})
end

function SPHeroChallengeBarbuceView:SetDormGameEffect(arg_50_1)
	return
end

function SPHeroChallengeBarbuceView:RefreshShowReward()
	self.icon1Img_.sprite = ItemTools.getItemSprite(ActivityHeroChallengeBarbecueCfg[DormRhythmGameData:GetLevelIDByDiff(self.diff, self.activityID)].reward_list_coin[1][1])
	self.icon2Img_.sprite = ItemTools.getItemSprite(SpHeroChallengeConst.accelerateID)

	local var_51_2 = SPHeroChallengeData:GetBrabuceGameAwardNum()

	self.num1Text_.text = var_51_2 == GameSetting.activity_hero_challenge_barbecue_coin_limit.value[1] and string.format("<color='#FF000B'>%d</color>", var_51_2) .. "/" .. GameSetting.activity_hero_challenge_barbecue_coin_limit.value[1] or var_51_2 .. "/" .. GameSetting.activity_hero_challenge_barbecue_coin_limit.value[1]

	local var_51_3 = GameSetting.activity_hero_challenge_barbecue_ticket_limit.value[1]
	local var_51_4 = SPHeroChallengeData:GetBarbuceAccelerateNum()

	self.num2Text_.text = var_51_4 == GameSetting.activity_hero_challenge_barbecue_ticket_limit.value[1] and string.format("<color='#FF000B'>%d</color>", var_51_4) .. "/" .. var_51_3 or var_51_4 .. "/" .. var_51_3
end

function SPHeroChallengeBarbuceView:RefreshAward(arg_52_1, arg_52_2)
	CommonTools.SetCommonData(arg_52_2, {
		id = self.showRewardList[arg_52_1][1],
		number = self.showRewardList[arg_52_1][2],
		clickFun = function()
			ShowPopItem(POP_ITEM, {
				self.showRewardList[arg_52_1][1]
			})
		end
	})
end

function SPHeroChallengeBarbuceView:Dispose()
	if self.rewardList then
		for iter_54_0, iter_54_1 in pairs(self.rewardList) do
			iter_54_1:Dispose()
		end
	end

	if self.awardList then
		self.awardList:Dispose()
	end

	if SPHeroChallengeBarbuceView.timer then
		for iter_54_2, iter_54_3 in pairs(SPHeroChallengeBarbuceView.timer) do
			iter_54_3:Stop()
		end
	end

	DormRhythmGameData:Dispose()
	SPHeroChallengeBarbuceView.super.Dispose(self)
end

return SPHeroChallengeBarbuceView
