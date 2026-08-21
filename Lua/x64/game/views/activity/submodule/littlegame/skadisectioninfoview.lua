local var_0_0 = class("SectionInfoBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/Stage/ChapterSectionInfoUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.rewardItems_ = {}
	arg_3_0.rewardGos_ = {}

	arg_3_0:InitUI()
	arg_3_0:AddListeners()

	arg_3_0.multiple_ = 1
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.activityID_ = arg_4_0.params_.activityID
	arg_4_0.chapterID_ = arg_4_0.params_.chapterID

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)

	arg_4_0.stageID_ = arg_4_0.params_.section
	arg_4_0.stageType_ = arg_4_0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED

	arg_4_0:RefreshData()
	arg_4_0:RefreshUI()
end

function var_0_0.OnUpdate(arg_5_0)
	if arg_5_0.stageID_ == arg_5_0.params_.section then
		return
	end

	arg_5_0.stageID_ = arg_5_0.params_.section

	arg_5_0:RefreshData()
	arg_5_0:RefreshUI()
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	for iter_6_0, iter_6_1 in pairs(arg_6_0.rewardItems_) do
		iter_6_1:Dispose()
	end

	arg_6_0.rewardItems_ = {}
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()

	arg_7_0.sectionImage_.immediate = true

	SetActive(arg_7_0.multiplePanel_, false)
	SetActive(arg_7_0.tipsPanel_, false)
	SetActive(arg_7_0.targetPanel_, false)
	SetActive(arg_7_0.targetPanel_, true)

	arg_7_0.controller_ = ControllerUtil.GetController(arg_7_0.transform_, "name")

	arg_7_0.controller_:SetSelectedState("skadi")

	if arg_7_0.readyTxt_ then
		arg_7_0.readyTxt_.text = GetTips("BATTLE_READY_1")
	end

	arg_7_0.sectionTargets_ = {}

	for iter_7_0 = 1, 3 do
		arg_7_0.sectionTargets_[iter_7_0] = SectionTargetItem.New(arg_7_0[string.format("targetItem%s_", iter_7_0)], iter_7_0)
	end
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.battleBtn_, nil, function()
		local var_9_0 = arg_8_0.stageID_
		local var_9_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)

		if arg_8_0.lock_ then
			ShowTips(arg_8_0.lockTips_)
		elseif var_9_1 < arg_8_0.cost * arg_8_0.multiple_ then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", arg_8_0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		else
			local var_9_2 = BattleSkadiLittleGameTemplate.New(arg_8_0.chapterID_, arg_8_0.activityID_)

			BattleController.GetInstance():LaunchBattle(var_9_2)
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.maskBtn_, nil, function()
		arg_8_0:Back()
	end)
end

function var_0_0.RemoveListeners(arg_11_0)
	arg_11_0.battleBtn_.onClick:RemoveAllListeners()
end

function var_0_0.RefreshData(arg_12_0)
	arg_12_0.lock_ = false
	arg_12_0.lockTips_ = ""
	arg_12_0.cost = 0
	arg_12_0.isFirstClear_ = false
	arg_12_0.drop_lib_id = 0

	local var_12_0 = BattleStageTools.GetStageCfg(arg_12_0.stageType_, arg_12_0.stageID_)

	arg_12_0.lock_ = false
	arg_12_0.lockTips_ = ""
	arg_12_0.cost = var_12_0.cost or 0
	arg_12_0.drop_lib_id = var_12_0.drop_lib_id
	arg_12_0.isFirstClear_ = false
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:RefreshStageInfo()
	arg_13_0:RefreshReward()
	arg_13_0:RefreshCost()
	SetActive(arg_13_0.unlockGo_, arg_13_0.lock_)
	SetActive(arg_13_0.battleBtnGo_, not arg_13_0.lock_)

	arg_13_0.lockText_.text = GetI18NText(arg_13_0.lockTips_)
	arg_13_0.rewardView_.horizontalNormalizedPosition = 0

	for iter_13_0, iter_13_1 in pairs(arg_13_0.sectionTargets_) do
		local var_13_0, var_13_1 = arg_13_0:GetThreeStar(iter_13_0)

		iter_13_1:Refresh(var_13_0, var_13_1)
	end
end

function var_0_0.RefreshStageInfo(arg_14_0)
	local var_14_0 = BattleStageTools.GetStageCfg(arg_14_0.stageType_, arg_14_0.stageID_)

	if arg_14_0.oldCfgID_ ~= var_14_0.id then
		arg_14_0.sectionName_.text = GetI18NText(var_14_0.name)
		arg_14_0.sectionImage_.spriteSync = string.format("%s%s", SpritePathCfg.Stage.path, var_14_0.background_1)
		arg_14_0.textStory_.text = GetI18NText(var_14_0.tips)
		arg_14_0.oldCfgID_ = var_14_0.id
	end
end

function var_0_0.RefreshReward(arg_15_0)
	arg_15_0:RefreshRewardPanel(arg_15_0.drop_lib_id)
end

function var_0_0.RefreshRewardPanel(arg_16_0, arg_16_1)
	local var_16_0 = getRewardFromDropCfg(arg_16_1, arg_16_0.isFirstClear_)

	if arg_16_0.isFirstClear_ and DropCfg[arg_16_1] and #DropCfg[arg_16_1].base_drop >= 1 then
		arg_16_0.rewardTitleText_.text = GetTips("FIRST_DROP")
	else
		arg_16_0.rewardTitleText_.text = GetTips("MAYBE_DROP")
	end

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		if arg_16_0.rewardItems_[iter_16_0] then
			arg_16_0.rewardItems_[iter_16_0]:SetData(iter_16_1, true)
		else
			arg_16_0.rewardGos_[iter_16_0] = arg_16_0.rewardGos_[iter_16_0] or Object.Instantiate(arg_16_0.rewardItem_, arg_16_0.rewardParent_.transform)
			arg_16_0.rewardItems_[iter_16_0] = RewardPoolItem.New(arg_16_0.rewardGos_[iter_16_0], iter_16_1, true)
		end

		SetActive(arg_16_0.rewardGos_[iter_16_0], true)

		if not arg_16_0.isFirstClear_ or not (#DropCfg[arg_16_1].base_drop >= 1) then
			arg_16_0.rewardItems_[iter_16_0]:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
			arg_16_0.rewardItems_[iter_16_0]:HideNum()
		else
			arg_16_0.rewardItems_[iter_16_0]:ShowFloor(ItemConst.ITEM_FLOOR.LONG)
		end
	end

	for iter_16_2 = #var_16_0 + 1, #arg_16_0.rewardItems_ do
		SetActive(arg_16_0.rewardGos_[iter_16_2], false)
	end
end

function var_0_0.GetThreeStar(arg_17_0, arg_17_1)
	local var_17_0 = BattleStageTools.GetStageCfg(arg_17_0.stageType_, arg_17_0.stageID_)
	local var_17_1 = SummerLittleGameData:GetSkadiStars(arg_17_0.chapterID_)

	return table.indexof(var_17_1, arg_17_1), var_17_0.three_star_need[arg_17_1]
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.sectionTargets_) do
		iter_18_1:Dispose()
	end

	arg_18_0.sectionTargets_ = {}

	arg_18_0:RemoveListeners()

	for iter_18_2, iter_18_3 in pairs(arg_18_0.rewardGos_) do
		Object.Destroy(iter_18_3)
	end

	arg_18_0.rewardGos_ = nil

	for iter_18_4, iter_18_5 in pairs(arg_18_0.rewardItems_) do
		iter_18_5:Dispose()
	end

	arg_18_0.rewardItems_ = nil

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
