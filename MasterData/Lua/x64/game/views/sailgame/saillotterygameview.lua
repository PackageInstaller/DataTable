local SailLotteryGameView = class("SailLotteryGameView", ReduxView)

function SailLotteryGameView:UIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdSpinachIncidentCardSelectionUI"
end

function SailLotteryGameView:UIParent()
	return manager.ui.uiMain.transform
end

function SailLotteryGameView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SailLotteryGameView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.dialogTextList_ = {
		[SailGameConst.EVENT_LOTEERY_STATUS.PLAY] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_START_TIP"),
		[SailGameConst.EVENT_LOTEERY_STATUS.WAIT] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_WAIT_TIP"),
		[SailGameConst.EVENT_LOTEERY_STATUS.WIN] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_SUCCESS_HALFWAY_TIP"),
		[SailGameConst.EVENT_LOTEERY_STATUS.LOSE] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_FAIL_TIP"),
		[SailGameConst.EVENT_LOTEERY_STATUS.END] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_SUCCESS_FINAL_TIP")
	}
	self.maxRound_ = #GameSetting.activity_skadi_sea_gamble_event_win_probability.value
	self.cardNum_ = self.cardContentTrans_.childCount
	self.cardIndexList_ = {}
	self.cardList_ = {}

	for iter_4_0 = 1, self.cardNum_ do
		self.cardIndexList_[iter_4_0] = iter_4_0
		self.cardList_[iter_4_0] = SailLotteryItem.New(self.cardContentTrans_:GetChild(iter_4_0 - 1).gameObject)

		self.cardList_[iter_4_0]:SetSelecteCallback(handler(self, self.OnSelectCard))
	end

	self.leftCardPos_ = self.cardContentTrans_:InverseTransformPoint(self.leftCardMarkTrans_.position)
	self.rightCardPos_ = self.cardContentTrans_:InverseTransformPoint(self.rightCardMarkTrans_.position)
end

function SailLotteryGameView:AddUIListener()
	self:AddBtnListener(self.overBtn_, nil, function()
		self:GameOver()
	end)
	self:AddBtnListener(self.continueBtn_, nil, function()
		self:InitCard()
		self:UpdateStatus()
	end)
end

function SailLotteryGameView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.curStageIndex_ = SailGameData:GetCurGameData(self.activityID_).curStageIndex

	self:GameInit()
	self:GameStart()
	self:PlayEnterAnim()
	self:RegistEventListener(ACTIVITY_UPDATE, handler(self, self.OnActivityUpdate))
end

function SailLotteryGameView:OnExit()
	self:RemoveAllEventListener()
end

function SailLotteryGameView:Dispose()
	for iter_10_0, iter_10_1 in ipairs(self.cardList_) do
		iter_10_1:Dispose()
	end

	self.cardList_ = nil

	SailLotteryGameView.super.Dispose(self)
end

function SailLotteryGameView:GameStart()
	self:RefreshUI()
end

function SailLotteryGameView:GameOver()
	if not self.gameWin_ then
		SailGameAction.SetEventEndMark(self.activityID_, SailGameConst.LOTTERY_OVER_TIPS_INDEX.LOSE)
		SailGameTools.GoToGameView(self.activityID_)
	elseif self.curRound_ >= self.maxRound_ then
		SailGameAction.SetEventEndMark(self.activityID_, SailGameConst.LOTTERY_OVER_TIPS_INDEX.SUCCESS_FULLEST)
		SailGameTools.GoToGameView(self.activityID_)
	else
		SailGameAction.EventOperate(self.activityID_, self.curStageIndex_, SailGameConst.EVENT_COMMON_OPERATE.OVER)
	end
end

function SailLotteryGameView:GameInit()
	self:InitCard()

	self.rewardNum_ = 0
	self.curRound_ = 1
	self.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.PLAY

	SetActive(self.maskGo_, false)
end

function SailLotteryGameView:UpdateStatus()
	if self.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.PLAY then
		self.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.WAIT
	elseif self.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.WAIT then
		self:GetCurRoundInfo()

		self.gameWin_ = self.curRoundInfo_.result == SailGameConst.LOTEERY_GAME_RESULT.WIN
		self.curStatus_ = self.curRoundInfo_.result == SailGameConst.LOTEERY_GAME_RESULT.WIN == true and (self.curRound_ < self.maxRound_ and SailGameConst.EVENT_LOTEERY_STATUS.WIN or SailGameConst.EVENT_LOTEERY_STATUS.END) or SailGameConst.EVENT_LOTEERY_STATUS.LOSE
	elseif self.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.WIN then
		self.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.PLAY
		self.curRound_ = self.curRound_ + 1
	end

	self:RefreshUI()
end

function SailLotteryGameView:RefreshUI()
	self.statusController_:SetSelectedIndex(self.curStatus_)

	if self.dialogTextList_[self.curStatus_] ~= nil then
		self.dialogText_.text = self.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.WIN and string.format(self.dialogTextList_[self.curStatus_], GameSetting.activity_skadi_sea_gamble_event_win_reward.value[self.curRound_ + 1][2]) or self.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.PLAY and string.format(self.dialogTextList_[self.curStatus_], GameSetting.activity_skadi_sea_gamble_event_win_reward.value[self.curRound_][2]) or self.dialogTextList_[self.curStatus_]
	end

	if self.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.PLAY then
		SetActive(self.maskGo_, false)
	end
end

function SailLotteryGameView:OnSelectCard(arg_16_1)
	if self.curStatus_ ~= SailGameConst.EVENT_LOTEERY_STATUS.PLAY then
		return
	end

	self:UpdateStatus()

	self.selfCardIndex_ = arg_16_1

	if not self:GetCurRoundInfo() then
		SailGameAction.EventOperate(self.activityID_, self.curStageIndex_)
	else
		self:OnEventOperateSuccess()
	end
end

function SailLotteryGameView:OnEventOperateSuccess(arg_17_1)
	if arg_17_1 ~= SailGameConst.EVENT_COMMON_OPERATE.OVER then
		SetActive(self.maskGo_, true)

		local var_17_0 = GameSetting.activity_skadi_sea_gamble_event_point.value[1]
		local var_17_1 = GameSetting.activity_skadi_sea_gamble_event_point.value[2]
		local var_17_2 = 0
		local var_17_3 = 0

		self:GetCurRoundInfo()

		local var_17_4 = self.curRoundInfo_.result == SailGameConst.LOTEERY_GAME_RESULT.WIN

		if self.curRoundInfo_.result == SailGameConst.LOTEERY_GAME_RESULT.WIN == true then
			var_17_2 = math.random(var_17_0 + 1, var_17_1)
			var_17_3 = math.random(var_17_0, var_17_2 - 1)
		else
			var_17_3 = math.random(var_17_0 + 1, var_17_1)
			var_17_2 = math.random(var_17_0, var_17_3 - 1)
		end

		swap(self.cardIndexList_, self.selfCardIndex_, self.cardNum_)
		swap(self.cardIndexList_, self.selfCardIndex_, self.cardNum_)
		self:RefreshResult(var_17_4, self.selfCardIndex_, var_17_2, self.cardIndexList_[math.random(1, self.cardNum_ - 1)], var_17_3)
		self:RefreshReward(var_17_4)
	else
		SailGameAction.SetEventEndMark(self.activityID_, SailGameConst.LOTTERY_OVER_TIPS_INDEX.SUCCESS)
		SailGameTools.GoToGameView(self.activityID_)
	end
end

function SailLotteryGameView:RefreshResult(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = self.cardList_[arg_18_2]

	self.cardList_[arg_18_2]:SetPoint(arg_18_3, true)

	local var_18_1 = self.cardList_[arg_18_4]

	self.cardList_[arg_18_4]:SetPoint(arg_18_5, false)
	var_18_0:SetResult(arg_18_1)

	local var_18_2 = arg_18_4 < arg_18_2

	var_18_0:SetTargetPos((arg_18_4 < arg_18_2 or nil) and (self.rightCardPos_ or self.leftCardPos_))
	var_18_1:SetTargetPos((not var_18_2 or nil) and (self.rightCardPos_ or self.leftCardPos_))

	for iter_18_0, iter_18_1 in ipairs(self.cardList_) do
		if iter_18_0 ~= arg_18_2 and iter_18_0 ~= arg_18_4 then
			iter_18_1:PlayExitAnim()
		end
	end
end

function SailLotteryGameView:OnWaitStatusEnd()
	SetActive(self.maskGo_, false)

	if self.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.WAIT then
		self:UpdateStatus()
	end
end

function SailLotteryGameView:RefreshReward(arg_20_1)
	self.rewardNum_ = arg_20_1 == true and self.rewardNum_ + GameSetting.activity_skadi_sea_gamble_event_win_reward.value[self.curRound_][2] or 0
	self.rewardNumText_.text = self.rewardNum_
	self.rewardIcon_.sprite = ItemTools.getItemSprite(GameSetting.activity_skadi_sea_gamble_event_win_reward.value[1][1])
end

function SailLotteryGameView:GetCurRoundInfo()
	local var_21_0 = false
	local var_21_1 = SailGameData:GetCurGameData(self.activityID_)

	if var_21_1.eventList[self.curStageIndex_].lotteryInfo then
		self.curRoundInfo_ = var_21_1.eventList[self.curStageIndex_].lotteryInfo[self.curRound_]
		var_21_0 = self.curRoundInfo_ ~= nil
	end

	return var_21_0
end

function SailLotteryGameView:InitCard()
	for iter_22_0 = 1, self.cardNum_ do
		self.cardList_[iter_22_0]:SetData(iter_22_0, self.activityID_)
	end
end

function SailLotteryGameView:PlayEnterAnim()
	self.animator_.enabled = true

	local var_23_0 = "XH3rdSpinachIncidentCardSelectionUI"

	self.animator_:Play("XH3rdSpinachIncidentCardSelectionUI", -1, 0)

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	self.timer_ = Timer.New(function()
		local var_24_0 = self.animator_:GetCurrentAnimatorStateInfo(0)

		if var_24_0:IsName(var_23_0) and var_24_0.normalizedTime >= 1 then
			if self.timer_ ~= nil then
				self.timer_:Stop()

				self.timer_ = nil
			end

			self.animator_.enabled = false
		end
	end, 0.033, -1)

	self.timer_:Start()
end

function SailLotteryGameView:OnActivityUpdate(arg_25_1)
	if arg_25_1 == self.activityID_ and not ActivityData:GetActivityIsOpen(arg_25_1) then
		ShowTips("TIME_OVER")
		SailGameTools.ShutDown()
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = self.activityID_
		})
	end
end

return SailLotteryGameView
