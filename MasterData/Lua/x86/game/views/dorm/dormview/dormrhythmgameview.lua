local DormRhythmGameView = class("DormRhythmGameView", ReduxView)

function DormRhythmGameView:UIName()
	return "Widget/BackHouseUI/Dorm/DormMinigameUI"
end

function DormRhythmGameView:UIParent()
	return manager.ui.uiMain.transform
end

function DormRhythmGameView:OnCtor()
	self.game = require("game.dorm.minigame.Include").Pizhuan.New(function()
		local var_4_0 = not nullable(self, "startGameFlag")

		if var_4_0 then
			return var_4_0, DormRhythmGameTools:GetGameResult(DormRhythmGameData:GetRunTimeData(), (DormRhythmGameData:GetLevelIDByDiff(self.diff)))
		end

		return var_4_0
	end)
end

function DormRhythmGameView:Init()
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

function DormRhythmGameView:InitUI()
	self:BindCfgUI()

	self.viewController = ControllerUtil.GetController(self.gameObject_.transform, "state")
	self.countDownController = ControllerUtil.GetController(self.gameObject_.transform, "countDown")
	self.batterController = ControllerUtil.GetController(self.gameObject_.transform, "batter")
	self.scoreController = ControllerUtil.GetController(self.settlementpanelGo_.transform, "score")
	self.shareController = ControllerUtil.GetController(self.settlementpanelGo_.transform, "share")

	self:InitAnimationController()

	self.settlePower = DormCharaterFatigueShowView.New(self.settllePowerGo)
	self.startPower = DormCharaterFatigueShowView.New(self.startPowerGo)
end

function DormRhythmGameView:InitAnimationController()
	self.batterAniamtor = self.batterGo:GetComponent("Animator")
	self.countAnimator = self.countGo:GetComponent("Animator")
	self.settleAnimator = self.settlementpanelGo_:GetComponent("Animator")
end

function DormRhythmGameView:ShareExitCallBack()
	self.shareController:SetSelectedState("false")
end

function DormRhythmGameView:OnEnter()
	SetActive(self.shareGo_, OperationData:IsOperationOpen(OperationConst.SHARE_FLAG))

	self.heroID = self.params_.heroID
	self.heroEID = self.params_.heroEID

	self:RegisterEvents()
	self:ResetStartView()
	self.settlePower:RefreshView(self.heroID)
	self.startPower:RefreshView(self.heroID)
end

function DormRhythmGameView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function DormRhythmGameView:RefreshBar()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		self:ExitGame()
	end)
end

function DormRhythmGameView:RegisterEvents()
	self:RegistEventListener(DORM_STOP_RHYTHM_GAME, function(arg_14_0, arg_14_1)
		if arg_14_0 then
			self:RefreshSettleView(arg_14_1)
		else
			self:ResetStartView()
		end
	end)
	self:RegistEventListener(DORM_REFRESH_BATTER_NUM, function(arg_15_0, arg_15_1)
		local var_15_0 = DormRhythmGameData:GetRunTimeData()
		local var_15_1 = DormRhythmGameData:GetLevelIDByDiff(self.diff)

		if BackHomeBreakGameCfg[var_15_1].fail_max <= var_15_0.mistakeNum then
			self:SettlementRhythmGame()

			return
		end

		local var_15_2 = DormRhythmGameTools:GetEffectRank((DormRhythmGameTools:CalGameScore(var_15_0, var_15_1)))

		if var_15_2 then
			self:SetDormGameEffect(var_15_2)
		end

		self:UpdataBatterNum(arg_15_0, var_15_2, arg_15_1)
	end)
	self:RegistEventListener(BACKHOME_HERO_FATIGUR_REFRESH, function()
		self.settlePower:RefreshView(self.heroID)
		self.startPower:RefreshView(self.heroID)
	end)
	self:RegistEventListener(BREAK_GAME_LAST_SUCCESS, function()
		self:SettlementRhythmGame()
	end)
end

function DormRhythmGameView:SettlementRhythmGame()
	self:StopGame()
	DormAction:SettlementRhythmGame({
		stage_id = self.diff,
		percentage_complete = DormRhythmGameTools:CalGameScore(DormRhythmGameData:GetRunTimeData(), (DormRhythmGameData:GetLevelIDByDiff(self.diff))),
		hero_id = self.heroID
	})
end

function DormRhythmGameView:AddUIListener()
	self:AddBtnListener(self.startBtn, nil, function()
		local var_20_0, var_20_1 = BackHomeTools.CheckHeroIsLockForAnyFeatureWithTips(self.heroID)

		if var_20_0 then
			ShowTips(var_20_1)

			return
		end

		if self:CheckFatigue() then
			self:StartGame()
		else
			ShowTips(GetTips("DORM_FATIGUE_NOT_ENOUGH"))
		end
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
		self:ExitGame()
	end)
	self:AddBtnListener(self.reStartBtn, nil, function()
		if self:CheckFatigue() then
			self:ResetStartView()
		else
			ShowTips("DORM_FATIGUE_NOT_ENOUGH")
		end
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

function DormRhythmGameView:OnQte(arg_34_1)
	if self.startGameFlag then
		self.game:OnQte(arg_34_1)
	end
end

function DormRhythmGameView:StartGame()
	if self.diff then
		self.startGameFlag = true

		self.game:Start(self.heroEID)
		self:ResetGameView()
	else
		print("未选择游戏难度")
	end
end

function DormRhythmGameView:ChoiceDiff(arg_36_1)
	self.diff = arg_36_1
end

function DormRhythmGameView:ResetTimer()
	if DormRhythmGameView.timer then
		for iter_37_0, iter_37_1 in pairs(DormRhythmGameView.timer) do
			iter_37_1:Stop()
		end
	end

	DormRhythmGameView.timer = {}

	local var_37_0 = GameDisplayCfg.dorm_mg_start_time.value[1]

	self.countDownController:SetSelectedState("true")

	self.countDownText.text = GameDisplayCfg.dorm_mg_start_time.value[1]
	DormRhythmGameView.timer.startTimer = Timer.New(function()
		self.countAnimator:Play("batter", 0, 0)

		var_37_0 = var_37_0 - 1

		if var_37_0 <= 0 then
			local var_38_0 = {
				stageID = 1
			}

			var_38_0.diff = self.diff or 1
			var_38_0.heroID = self.heroID
			var_38_0.goInfo = self.goData

			self.countDownController:SetSelectedState("false")
			DormRhythmGameData:StartGame(var_38_0)
			DormRhythmGameView.timer.startTimer:Stop()
		end

		self.countDownText.text = var_37_0
	end, 1, -1)
end

function DormRhythmGameView:ResetStartView()
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
end

function DormRhythmGameView:ResetGameView()
	self.judgeEffectController:SetSelectedState("none")
	manager.audio:StopEffect()

	local var_40_0 = {}

	var_40_0.diff = self.diff or 1
	var_40_0.heroID = self.heroID

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

function DormRhythmGameView:awardIndexItem(arg_41_1, arg_41_2)
	arg_41_2:SetData(self.awardList[arg_41_1])
end

function DormRhythmGameView:RefreshSettleView(arg_42_1)
	self.viewController:SetSelectedState("settlement")
	self.settleAnimator:Play("settle", -1, 0)
	self.settleAnimator:Update(0)
	self.settlePower:RefreshView(self.heroID)

	local var_42_0 = DormRhythmGameData:GetResultInfo()

	self.successNum.text = tostring(var_42_0.successfulNum)
	self.mistakeNum.text = tostring(var_42_0.mistakeNum)
	self.maxBatterNum.text = tostring(var_42_0.maxBatterNum)
	self.rewardList = self.rewardList or {}

	for iter_42_0, iter_42_1 in pairs(self.rewardList) do
		self.rewardList[iter_42_0]:Show(false)
	end

	if arg_42_1 and arg_42_1[1] and arg_42_1[1].num > 0 then
		for iter_42_2, iter_42_3 in ipairs(arg_42_1) do
			if self.rewardList[iter_42_2] then
				local var_42_1 = clone(ItemTemplateData)

				var_42_1.id = iter_42_3.id
				var_42_1.number = iter_42_3.num

				function var_42_1:clickFun()
					ShowPopItem(POP_ITEM, {
						self.id,
						self.number
					})
				end

				self.rewardList[iter_42_2]:SetData(var_42_1)
			else
				self.rewardList[iter_42_2] = CommonItemView.New(Object.Instantiate(self.itemGo_, self.rewardParent_), true)

				local var_42_2 = clone(ItemTemplateData)

				var_42_2.id = iter_42_3.id
				var_42_2.number = iter_42_3.num

				function var_42_2:clickFun()
					ShowPopItem(POP_ITEM, {
						self.id,
						self.number
					})
				end

				self.rewardList[iter_42_2]:SetData(var_42_2)
			end

			self.rewardList[iter_42_2]:Show(true)
		end
	end

	if DormConst.DORM_RHYTHMGAME_RANK[DormRhythmGameTools:GetRank((DormRhythmGameTools:CalGameScore(DormRhythmGameData:GetRunTimeData(), (DormRhythmGameData:GetLevelIDByDiff(self.diff)))))] then
		self.scoreController:SetSelectedState(DormConst.DORM_RHYTHMGAME_RANK[DormRhythmGameTools:GetRank((DormRhythmGameTools:CalGameScore(DormRhythmGameData:GetRunTimeData(), (DormRhythmGameData:GetLevelIDByDiff(self.diff)))))])
	end

	local var_42_3 = DormitoryData:GetDailyCurrency()

	self.reduceFatigue.text = "x" .. tostring(self:GetGameNeedFatigue())
	self.awardText.text = var_42_3 >= GameSetting.dorm_mg_reward_daily_max.value[1] and string.format(GetTips("DORM_MG_REWARD_MAX_INFO"), var_42_3, GameSetting.dorm_mg_reward_daily_max.value[1]) or string.format(GetTips("DORM_MG_REWARD_INFO"), var_42_3, GameSetting.dorm_mg_reward_daily_max.value[1])
end

function DormRhythmGameView:GetGameNeedFatigue()
	if DormitoryData:GetDailyCurrency() >= GameSetting.dorm_mg_reward_daily_max.value[1] then
		return 0
	else
		return GameSetting.dorm_mg_break_cost.value[1]
	end
end

function DormRhythmGameView:UpdataBatterNum(arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = false
	local var_46_1 = DormRhythmGameData:GetRunTimeData()
	local var_46_2 = var_46_1.batterNum

	if var_46_1.batterNum > 0 then
		if self.curBatterType == arg_46_1 then
			var_46_0 = true
		end
	elseif self.curBatterType == DormConst.DORM_RHYTHM_BUTTON_TYPE.fail then
		var_46_0 = true
	end

	if arg_46_2 then
		self.effectLevel = arg_46_2
	end

	if self.effectLevel ~= self.effectLevel or var_46_0 then
		manager.audio:StopEffect()

		local var_46_3 = self.effectLevel

		if self.effectLevel == 4 then
			var_46_3 = 3
		end

		if var_46_3 > 0 then
			manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_energy0" .. var_46_3 .. "_loop", "")
		end
	end

	if var_46_1 then
		self.batterNum.text = string.format(GetTips("DORM_MG_BREAK_COMBO_COUNT"), var_46_2)

		if var_46_2 > 0 then
			self.batterController:SetSelectedState("true")
			self.batterAniamtor:Play("batter", 0, 0)
			self.judgeEffectController:SetSelectedState("none")

			if not arg_46_3 then
				self.judgeAnimator:Play("New Animation", -1, 0)
				self.judgeAnimator:Update(0)

				if arg_46_1 == DormConst.DORM_RHYTHM_BUTTON_TYPE.left then
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

			if not arg_46_3 then
				self.judgeAnimator:Play("GameObject_defeated", -1, 0)
				self.judgeAnimator:Update(0)
				manager.audio:PlayEffect("ui_dorm", "ui_dorm_game_hit02", "")

				self.curBatterType = DormConst.DORM_RHYTHM_BUTTON_TYPE.fail
			end
		end
	end
end

function DormRhythmGameView:UpdataMistakeItem()
	if self.mistakeList then
		for iter_47_0, iter_47_1 in ipairs(self.mistakeList) do
			if iter_47_1.flag then
				iter_47_1.flag = false

				iter_47_1.controller:SetSelectedState("false")

				break
			end
		end
	end
end

function DormRhythmGameView:UpdataMistakeNum()
	if self.diff then
		self.mistakeList = {}

		for iter_48_0 = 1, BackHomeBreakGameCfg[DormRhythmGameData:GetLevelIDByDiff(self.diff)].fail_max do
			local var_48_0 = Object.Instantiate(self.bgpowerGo_, self.mistakeTrs)
			local var_48_1 = {
				flag = true,
				index = iter_48_0,
				go = var_48_0,
				controller = ControllerUtil.GetController(var_48_0.transform, "state")
			}

			var_48_1.controller:SetSelectedState("true")

			self.mistakeList[iter_48_0] = var_48_1
		end
	end
end

function DormRhythmGameView:StopGame()
	DormRhythmGameData:StopGame()

	self.startGameFlag = false

	self:ResetTimer()

	if self.mistakeList then
		for iter_49_0, iter_49_1 in ipairs(self.mistakeList) do
			Object.Destroy(iter_49_1.go)
		end

		self.mistakeList = nil
	end
end

function DormRhythmGameView:SelDiff(arg_50_1)
	self.diff = arg_50_1
end

function DormRhythmGameView:ExitGame()
	manager.audio:StopEffect()
	DormRhythmGameData:Dispose()
	JumpTools.OpenPageByJump("/heroInteractView")
	self.game:Abort()
end

function DormRhythmGameView:CheckFatigue()
	local var_52_0 = DormData:GetHeroTemplateInfo(self.heroID)

	if var_52_0 then
		if var_52_0:GetFatigue() < self:GetGameNeedFatigue() then
			return false
		end

		return true
	else
		print("未找到人物信息")
	end
end

function DormRhythmGameView:SetDormGameEffect(arg_53_1)
	if arg_53_1 <= 0 then
		arg_53_1 = require("game.dorm.minigame.Include").Pizhuan.QTE_LEVEL_RESET
	end

	self:OnQte(arg_53_1)
end

function DormRhythmGameView:Dispose()
	if self.rewardList then
		for iter_54_0, iter_54_1 in ipairs(self.rewardList) do
			self.rewardList[iter_54_0]:Dispose()

			self.rewardList[iter_54_0] = nil
		end
	end

	if DormRhythmGameView.timer then
		for iter_54_2, iter_54_3 in pairs(DormRhythmGameView.timer) do
			iter_54_3:Stop()
		end
	end

	if self.settlePower then
		self.settlePower:Dispose(self)
	end

	if self.startPower then
		self.startPower:Dispose(self)
	end

	DormRhythmGameData:Dispose()
	DormRhythmGameView.super.Dispose(self)
end

return DormRhythmGameView
