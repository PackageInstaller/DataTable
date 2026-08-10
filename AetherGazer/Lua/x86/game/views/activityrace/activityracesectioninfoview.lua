local var_0_0 = import("game.views.sectionInfo.SectionInfoMultipleBaseView")
local var_0_1 = class("ActivityRaceSectionInfoView", var_0_0)
local var_0_2 = #GameSetting.challenge_multiple_count_unlock_level.value

function var_0_1.InitUI(arg_1_0)
	var_0_1.super.InitUI(arg_1_0)
end

function var_0_1.OnClickBtn(arg_2_0)
	local var_2_0 = arg_2_0.stageID_

	arg_2_0:Go("/sectionSelectHero", {
		section = var_2_0,
		multiple = arg_2_0.multiple_,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_RACE,
		activityID = arg_2_0.params_.activityID,
		race = ActivityRaceCfg[arg_2_0.params_.activityID].race_id
	})
end

function var_0_1.RefreshData(arg_3_0)
	local var_3_0 = BattleActivityRaceStageCfg[arg_3_0.stageID_]

	arg_3_0.lock_ = false
	arg_3_0.cost = var_3_0.cost
	arg_3_0.drop_lib_id = var_3_0.drop_lib_id
	arg_3_0.isFirstClear_ = ActivityRaceData:GetStateList()[arg_3_0.params_.activityID].completedStageList[arg_3_0.stageID_] == nil

	var_0_1.super.RefreshData(arg_3_0)
end

function var_0_1.RefreshUI(arg_4_0)
	var_0_1.super.RefreshUI(arg_4_0)
	SetActive(arg_4_0.stageTitleGo_, false)

	local var_4_0 = ActivityRaceCfg[arg_4_0.params_.activityID].stage_list

	if not (arg_4_0.stageID_ == var_4_0[#var_4_0]) then
		SetActive(arg_4_0.rewardPanel_, true)
		SetActive(arg_4_0.multiplePanel_, true)
	else
		SetActive(arg_4_0.rewardPanel_, false)
		SetActive(arg_4_0.multiplePanel_, false)
	end
end

function var_0_1.RefreshRewardPanel(arg_5_0, arg_5_1)
	local var_5_0 = getRewardFromDropCfg(arg_5_1, true)

	if arg_5_0.isFirstClear_ and DropCfg[arg_5_1] and #DropCfg[arg_5_1].base_drop >= 1 then
		arg_5_0.rewardTitleText_.text = GetTips("FIRST_DROP")
	else
		arg_5_0.rewardTitleText_.text = GetTips("MAYBE_DROP")
	end

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		if arg_5_0.rewardItems_[iter_5_0] then
			arg_5_0.rewardItems_[iter_5_0]:SetData(iter_5_1, true)
		else
			arg_5_0.rewardGos_[iter_5_0] = arg_5_0.rewardGos_[iter_5_0] or Object.Instantiate(arg_5_0.rewardItem_, arg_5_0.rewardParent_.transform)
			arg_5_0.rewardItems_[iter_5_0] = RewardPoolItem.New(arg_5_0.rewardGos_[iter_5_0], iter_5_1, true)
		end

		SetActive(arg_5_0.rewardGos_[iter_5_0], true)

		if not arg_5_0.isFirstClear_ or not (#DropCfg[arg_5_1].base_drop >= 1) then
			arg_5_0.rewardItems_[iter_5_0]:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
			arg_5_0.rewardItems_[iter_5_0]:HideNum()
		else
			arg_5_0.rewardItems_[iter_5_0]:ShowFloor(ItemConst.ITEM_FLOOR.LONG)
		end
	end

	for iter_5_2 = #var_5_0 + 1, #arg_5_0.rewardItems_ do
		SetActive(arg_5_0.rewardGos_[iter_5_2], false)
	end
end

function var_0_1.RefreshStageInfo(arg_6_0)
	local var_6_0 = BattleActivityRaceStageCfg[arg_6_0.stageID_]

	if arg_6_0.oldCfgID_ ~= var_6_0.id then
		arg_6_0.sectionName_.text = GetI18NText(var_6_0.name)
		arg_6_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, var_6_0.background_1))
		arg_6_0.tipsText_.text = GetI18NText(var_6_0.tips)

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.tipsTextContentTrans_)

		arg_6_0.oldCfgID_ = var_6_0.id
	end
end

function var_0_1.OnExit(arg_7_0)
	var_0_1.super.OnExit(arg_7_0)

	arg_7_0.multiple_ = 1
end

function var_0_1.UpdateBar(arg_8_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
end

function var_0_1.RefreshMultiple(arg_9_0)
	arg_9_0.multipleText_.text = "x" .. arg_9_0.multiple_

	if arg_9_0.isFirstClear_ == true then
		arg_9_0.maxMultipleBtn_.interactable = false
		arg_9_0.maxMultipleBtnCanvas_.alpha = 0.5
	elseif arg_9_0.multiple_ >= arg_9_0.maxMultiple_ or arg_9_0.multiple_ >= arg_9_0.challengeCnt_ then
		arg_9_0.maxMultipleBtn_.interactable = false
		arg_9_0.maxMultipleBtnCanvas_.alpha = 0.5
		arg_9_0.minMultipleBtn_.interactable = true
		arg_9_0.minMultipleCanvas_.alpha = 1
		arg_9_0.subBtn_.interactable = true
		arg_9_0.subBtnCanvas_.alpha = 1
	elseif arg_9_0.multiple_ <= 1 then
		arg_9_0.maxMultipleBtn_.interactable = true
		arg_9_0.maxMultipleBtnCanvas_.alpha = 1
		arg_9_0.minMultipleBtn_.interactable = false
		arg_9_0.minMultipleCanvas_.alpha = 0.5
		arg_9_0.subBtn_.interactable = false
		arg_9_0.subBtnCanvas_.alpha = 0.5
	else
		arg_9_0.maxMultipleBtn_.interactable = true
		arg_9_0.maxMultipleBtnCanvas_.alpha = 1
		arg_9_0.minMultipleBtn_.interactable = true
		arg_9_0.minMultipleCanvas_.alpha = 1
		arg_9_0.subBtn_.interactable = true
		arg_9_0.subBtnCanvas_.alpha = 1
	end

	if arg_9_0.multiple_ == var_0_2 then
		arg_9_0.addBtn_.interactable = false
		arg_9_0.addBtnCanvas_.alpha = 0.5
	else
		arg_9_0.addBtn_.interactable = true
		arg_9_0.addBtnCanvas_.alpha = 1
	end

	if arg_9_0.multiple_ <= 1 then
		arg_9_0.minMultipleBtn_.interactable = false
		arg_9_0.minMultipleCanvas_.alpha = 0.5
		arg_9_0.subBtn_.interactable = false
		arg_9_0.subBtnCanvas_.alpha = 0.5
	end
end

function var_0_1.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.battleBtn_, nil, function()
		local var_11_0 = arg_10_0.stageID_
		local var_11_1 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)

		if arg_10_0.lock_ then
			ShowTips(arg_10_0.lockTips_)
		elseif var_11_1 < arg_10_0.cost * arg_10_0.multiple_ then
			if CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
				JumpTools.OpenPopUp("currencyBuyFatigue", arg_10_0.params_, ViewConst.SYSTEM_ID.BUY_FATIGUE)
			else
				ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
			end
		else
			arg_10_0:OnClickBtn()
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.minMultipleBtn_, nil, function()
		OperationRecorder.Record(arg_10_0.class.__cname, "challenge_multiple")

		arg_10_0.multiple_ = 1

		arg_10_0:ChangeMultiple()
	end)
	arg_10_0:AddBtnListener(arg_10_0.subBtn_, nil, function()
		OperationRecorder.Record(arg_10_0.class.__cname, "single")

		arg_10_0.multiple_ = arg_10_0.multiple_ - 1

		arg_10_0:ChangeMultiple()
	end)
	arg_10_0:AddBtnListener(arg_10_0.addBtn_, nil, function()
		OperationRecorder.Record(arg_10_0.class.__cname, "single")

		if arg_10_0.isFirstClear_ == true then
			ShowTips("ACTIVITY_PT_REPEAT_MULTIPLE_UNLOCK")

			return
		end

		if arg_10_0.multiple_ >= arg_10_0.challengeCnt_ then
			local var_14_0 = arg_10_0:GetChallengeCntMaxTip()

			ShowTips(var_14_0)

			return
		end

		arg_10_0.multiple_ = arg_10_0.multiple_ + 1

		arg_10_0:ChangeMultiple()
	end)
	arg_10_0:AddBtnListener(arg_10_0.maxMultipleBtn_, nil, function()
		OperationRecorder.Record(arg_10_0.class.__cname, "challenge_multiple")

		local var_15_0 = arg_10_0.maxMultiple_

		if arg_10_0.challengeCnt_ < arg_10_0.maxMultiple_ then
			var_15_0 = arg_10_0.challengeCnt_
		end

		arg_10_0.multiple_ = var_15_0

		arg_10_0:ChangeMultiple()
	end)
end

return var_0_1
