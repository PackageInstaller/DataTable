local var_0_0 = class("SailLotteryGameView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdSpinachIncidentCardSelectionUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.statusController_ = ControllerUtil.GetController(arg_4_0.transform_, "status")
	arg_4_0.dialogTextList_ = {
		[SailGameConst.EVENT_LOTEERY_STATUS.PLAY] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_START_TIP"),
		[SailGameConst.EVENT_LOTEERY_STATUS.WAIT] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_WAIT_TIP"),
		[SailGameConst.EVENT_LOTEERY_STATUS.WIN] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_SUCCESS_HALFWAY_TIP"),
		[SailGameConst.EVENT_LOTEERY_STATUS.LOSE] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_FAIL_TIP"),
		[SailGameConst.EVENT_LOTEERY_STATUS.END] = GetTips("ACTIVITY_SKADI_SEA_GAMBLE_EVENT_SUCCESS_FINAL_TIP")
	}
	arg_4_0.maxRound_ = #GameSetting.activity_skadi_sea_gamble_event_win_probability.value
	arg_4_0.cardNum_ = arg_4_0.cardContentTrans_.childCount
	arg_4_0.cardIndexList_ = {}
	arg_4_0.cardList_ = {}

	for iter_4_0 = 1, arg_4_0.cardNum_ do
		arg_4_0.cardIndexList_[iter_4_0] = iter_4_0

		local var_4_0 = arg_4_0.cardContentTrans_:GetChild(iter_4_0 - 1).gameObject

		arg_4_0.cardList_[iter_4_0] = SailLotteryItem.New(var_4_0)

		arg_4_0.cardList_[iter_4_0]:SetSelecteCallback(handler(arg_4_0, arg_4_0.OnSelectCard))
	end

	arg_4_0.leftCardPos_ = arg_4_0.cardContentTrans_:InverseTransformPoint(arg_4_0.leftCardMarkTrans_.position)
	arg_4_0.rightCardPos_ = arg_4_0.cardContentTrans_:InverseTransformPoint(arg_4_0.rightCardMarkTrans_.position)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.overBtn_, nil, function()
		arg_5_0:GameOver()
	end)
	arg_5_0:AddBtnListener(arg_5_0.continueBtn_, nil, function()
		arg_5_0:InitCard()
		arg_5_0:UpdateStatus()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID
	arg_8_0.curStageIndex_ = SailGameData:GetCurGameData(arg_8_0.activityID_).curStageIndex

	arg_8_0:GameInit()
	arg_8_0:GameStart()
	arg_8_0:PlayEnterAnim()
	arg_8_0:RegistEventListener(ACTIVITY_UPDATE, handler(arg_8_0, arg_8_0.OnActivityUpdate))
end

function var_0_0.OnExit(arg_9_0)
	arg_9_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.cardList_) do
		iter_10_1:Dispose()
	end

	arg_10_0.cardList_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.GameStart(arg_11_0)
	arg_11_0:RefreshUI()
end

function var_0_0.GameOver(arg_12_0)
	if not arg_12_0.gameWin_ then
		SailGameAction.SetEventEndMark(arg_12_0.activityID_, SailGameConst.LOTTERY_OVER_TIPS_INDEX.LOSE)
		SailGameTools.GoToGameView(arg_12_0.activityID_)
	elseif arg_12_0.curRound_ >= arg_12_0.maxRound_ then
		SailGameAction.SetEventEndMark(arg_12_0.activityID_, SailGameConst.LOTTERY_OVER_TIPS_INDEX.SUCCESS_FULLEST)
		SailGameTools.GoToGameView(arg_12_0.activityID_)
	else
		SailGameAction.EventOperate(arg_12_0.activityID_, arg_12_0.curStageIndex_, SailGameConst.EVENT_COMMON_OPERATE.OVER)
	end
end

function var_0_0.GameInit(arg_13_0)
	arg_13_0:InitCard()

	arg_13_0.rewardNum_ = 0
	arg_13_0.curRound_ = 1
	arg_13_0.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.PLAY

	SetActive(arg_13_0.maskGo_, false)
end

function var_0_0.UpdateStatus(arg_14_0)
	if arg_14_0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.PLAY then
		arg_14_0.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.WAIT
	elseif arg_14_0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.WAIT then
		arg_14_0:GetCurRoundInfo()

		local var_14_0 = arg_14_0.curRoundInfo_.result == SailGameConst.LOTEERY_GAME_RESULT.WIN

		arg_14_0.gameWin_ = var_14_0

		if var_14_0 == true then
			if arg_14_0.curRound_ < arg_14_0.maxRound_ then
				arg_14_0.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.WIN
			else
				arg_14_0.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.END
			end
		else
			arg_14_0.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.LOSE
		end
	elseif arg_14_0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.WIN then
		arg_14_0.curStatus_ = SailGameConst.EVENT_LOTEERY_STATUS.PLAY
		arg_14_0.curRound_ = arg_14_0.curRound_ + 1
	end

	arg_14_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_15_0)
	arg_15_0.statusController_:SetSelectedIndex(arg_15_0.curStatus_)

	if arg_15_0.dialogTextList_[arg_15_0.curStatus_] ~= nil then
		if arg_15_0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.WIN then
			local var_15_0 = GameSetting.activity_skadi_sea_gamble_event_win_reward.value[arg_15_0.curRound_ + 1][2]

			arg_15_0.dialogText_.text = string.format(arg_15_0.dialogTextList_[arg_15_0.curStatus_], var_15_0)
		elseif arg_15_0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.PLAY then
			local var_15_1 = GameSetting.activity_skadi_sea_gamble_event_win_reward.value[arg_15_0.curRound_][2]

			arg_15_0.dialogText_.text = string.format(arg_15_0.dialogTextList_[arg_15_0.curStatus_], var_15_1)
		else
			arg_15_0.dialogText_.text = arg_15_0.dialogTextList_[arg_15_0.curStatus_]
		end
	end

	if arg_15_0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.PLAY then
		SetActive(arg_15_0.maskGo_, false)
	end
end

function var_0_0.OnSelectCard(arg_16_0, arg_16_1)
	if arg_16_0.curStatus_ ~= SailGameConst.EVENT_LOTEERY_STATUS.PLAY then
		return
	end

	arg_16_0:UpdateStatus()

	arg_16_0.selfCardIndex_ = arg_16_1

	if not arg_16_0:GetCurRoundInfo() then
		SailGameAction.EventOperate(arg_16_0.activityID_, arg_16_0.curStageIndex_)
	else
		arg_16_0:OnEventOperateSuccess()
	end
end

function var_0_0.OnEventOperateSuccess(arg_17_0, arg_17_1)
	if arg_17_1 ~= SailGameConst.EVENT_COMMON_OPERATE.OVER then
		SetActive(arg_17_0.maskGo_, true)

		local var_17_0 = GameSetting.activity_skadi_sea_gamble_event_point.value[1]
		local var_17_1 = GameSetting.activity_skadi_sea_gamble_event_point.value[2]
		local var_17_2 = 0
		local var_17_3 = 0

		arg_17_0:GetCurRoundInfo()

		local var_17_4 = arg_17_0.curRoundInfo_.result == SailGameConst.LOTEERY_GAME_RESULT.WIN

		if var_17_4 == true then
			var_17_2 = math.random(var_17_0 + 1, var_17_1)
			var_17_3 = math.random(var_17_0, var_17_2 - 1)
		else
			var_17_3 = math.random(var_17_0 + 1, var_17_1)
			var_17_2 = math.random(var_17_0, var_17_3 - 1)
		end

		swap(arg_17_0.cardIndexList_, arg_17_0.selfCardIndex_, arg_17_0.cardNum_)

		local var_17_5 = math.random(1, arg_17_0.cardNum_ - 1)
		local var_17_6 = arg_17_0.cardIndexList_[var_17_5]

		swap(arg_17_0.cardIndexList_, arg_17_0.selfCardIndex_, arg_17_0.cardNum_)
		arg_17_0:RefreshResult(var_17_4, arg_17_0.selfCardIndex_, var_17_2, var_17_6, var_17_3)
		arg_17_0:RefreshReward(var_17_4)
	else
		SailGameAction.SetEventEndMark(arg_17_0.activityID_, SailGameConst.LOTTERY_OVER_TIPS_INDEX.SUCCESS)
		SailGameTools.GoToGameView(arg_17_0.activityID_)
	end
end

function var_0_0.RefreshResult(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = arg_18_0.cardList_[arg_18_2]

	var_18_0:SetPoint(arg_18_3, true)

	local var_18_1 = arg_18_0.cardList_[arg_18_4]

	var_18_1:SetPoint(arg_18_5, false)
	var_18_0:SetResult(arg_18_1)

	local var_18_2 = arg_18_4 < arg_18_2

	var_18_0:SetTargetPos(var_18_2 and arg_18_0.rightCardPos_ or arg_18_0.leftCardPos_)
	var_18_1:SetTargetPos(not var_18_2 and arg_18_0.rightCardPos_ or arg_18_0.leftCardPos_)

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.cardList_) do
		if iter_18_0 ~= arg_18_2 and iter_18_0 ~= arg_18_4 then
			iter_18_1:PlayExitAnim()
		end
	end
end

function var_0_0.OnWaitStatusEnd(arg_19_0)
	SetActive(arg_19_0.maskGo_, false)

	if arg_19_0.curStatus_ == SailGameConst.EVENT_LOTEERY_STATUS.WAIT then
		arg_19_0:UpdateStatus()
	end
end

function var_0_0.RefreshReward(arg_20_0, arg_20_1)
	if arg_20_1 == true then
		arg_20_0.rewardNum_ = arg_20_0.rewardNum_ + GameSetting.activity_skadi_sea_gamble_event_win_reward.value[arg_20_0.curRound_][2]
	else
		arg_20_0.rewardNum_ = 0
	end

	arg_20_0.rewardNumText_.text = arg_20_0.rewardNum_
	arg_20_0.rewardIcon_.sprite = ItemTools.getItemSprite(GameSetting.activity_skadi_sea_gamble_event_win_reward.value[1][1])
end

function var_0_0.GetCurRoundInfo(arg_21_0)
	local var_21_0 = false
	local var_21_1 = SailGameData:GetCurGameData(arg_21_0.activityID_)

	if var_21_1.eventList[arg_21_0.curStageIndex_].lotteryInfo then
		arg_21_0.curRoundInfo_ = var_21_1.eventList[arg_21_0.curStageIndex_].lotteryInfo[arg_21_0.curRound_]
		var_21_0 = arg_21_0.curRoundInfo_ ~= nil and true or false
	end

	return var_21_0
end

function var_0_0.InitCard(arg_22_0)
	for iter_22_0 = 1, arg_22_0.cardNum_ do
		arg_22_0.cardList_[iter_22_0]:SetData(iter_22_0, arg_22_0.activityID_)
	end
end

function var_0_0.PlayEnterAnim(arg_23_0)
	arg_23_0.animator_.enabled = true

	local var_23_0 = "XH3rdSpinachIncidentCardSelectionUI"

	arg_23_0.animator_:Play(var_23_0, -1, 0)

	if arg_23_0.timer_ then
		arg_23_0.timer_:Stop()

		arg_23_0.timer_ = nil
	end

	arg_23_0.timer_ = Timer.New(function()
		local var_24_0 = arg_23_0.animator_:GetCurrentAnimatorStateInfo(0)

		if var_24_0:IsName(var_23_0) and var_24_0.normalizedTime >= 1 then
			if arg_23_0.timer_ ~= nil then
				arg_23_0.timer_:Stop()

				arg_23_0.timer_ = nil
			end

			arg_23_0.animator_.enabled = false
		end
	end, 0.033, -1)

	arg_23_0.timer_:Start()
end

function var_0_0.OnActivityUpdate(arg_25_0, arg_25_1)
	if arg_25_1 == arg_25_0.activityID_ and not ActivityData:GetActivityIsOpen(arg_25_1) then
		ShowTips("TIME_OVER")
		SailGameTools.ShutDown()
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = arg_25_0.activityID_
		})
	end
end

return var_0_0
