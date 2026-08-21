local var_0_0 = class("SailMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesGameUI"
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

	arg_4_0.buildingList_ = {}

	local var_4_0 = arg_4_0.buildingContentTrans_.childCount
	local var_4_1

	for iter_4_0 = 1, var_4_0 do
		local var_4_2 = arg_4_0.buildingContentTrans_:GetChild(iter_4_0 - 1).gameObject

		arg_4_0.buildingList_[iter_4_0] = SailBuildingItem.New(var_4_2)
	end

	arg_4_0.sailCountController_ = ControllerUtil.GetController(arg_4_0.transform_, "sailCount")
	arg_4_0.gameStatusCountController_ = ControllerUtil.GetController(arg_4_0.transform_, "gameStatus")
	arg_4_0.coinIcon_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
	arg_4_0.animTimerList_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		SailGameData:SetSelectedSailBtn(arg_5_0.activityID_)

		if SailGameData:GetCurGameData(arg_5_0.activityID_).gameState ~= SailGameConst.GAME_STATUS.RUNNING then
			if 1 > SailGameData:GetSailCount(arg_5_0.activityID_) then
				ShowTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_NOT_ENOUGH")

				return
			end

			SailGameAction.StartGame(arg_5_0.activityID_)
		else
			SailGameTools.GoToGameView(arg_5_0.activityID_)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.upgradeBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if SailGameData:GetIslandLevel(arg_5_0.activityID_) >= #SailGameIslandLevelCfg.get_id_list_by_activity_id[arg_5_0.activityID_] then
			ShowTips("ACTIVITY_SKADI_SEA_LEVEL_MAX_TIP")

			return
		end

		JumpTools.OpenPageByJump("sailUpgradeIsland", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.islandRewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_5_0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("sailIslandReward", {
			activityID = arg_5_0.activityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.coinBtn_, nil, function()
		ShowPopItem(POP_SOURCE_ITEM, {
			CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id,
			0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.backBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.mainBtn_, nil, function()
		gameContext:Go("/home", nil, nil, true)
	end)
	arg_5_0:AddBtnListener(arg_5_0.descBtn_, nil, function()
		local var_12_0 = GetTips("ACTIVITY_SKADI_SEA_DESCRIBE")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SKADI_SEA_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_12_0
		})
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.activityID_ = arg_13_0.params_.activityID
	arg_13_0.stopTime_ = ActivityData:GetActivityData(arg_13_0.activityID_).stopTime

	arg_13_0:AddTimer()
	arg_13_0:RefreshUI()
	arg_13_0:BindRedPoint()
	SetActive(arg_13_0.coinVaryGo_, false)
end

function var_0_0.OnTop(arg_14_0)
	arg_14_0.coinNumText_.text = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id)
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
	arg_15_0:StopTimer()
	arg_15_0:StopSailTimer()
	arg_15_0:StopAllAnimTimer()

	if arg_15_0.tween_ then
		arg_15_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_15_0.tween_.id)

		arg_15_0.tween_ = nil
	end

	arg_15_0:UnBindRedPoint()
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.buildingList_) do
		iter_16_1:Dispose()
	end

	arg_16_0.buildingList_ = nil

	arg_16_0:StopTimer()
	arg_16_0:StopSailTimer()
	arg_16_0:StopAllAnimTimer()

	if arg_16_0.tween_ then
		arg_16_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_16_0.tween_.id)

		arg_16_0.tween_ = nil
	end

	var_0_0.super.Dispose(arg_16_0)
end

function var_0_0.RefreshUI(arg_17_0)
	arg_17_0:RefreshBuilding()
	arg_17_0:RefreshIslandLevel()
	arg_17_0:RefreshSailCount()

	local var_17_0 = SailGameData:GetCurGameData(arg_17_0.activityID_)

	arg_17_0.gameStatusCountController_:SetSelectedState(var_17_0.gameState == SailGameConst.GAME_STATUS.RUNNING and "on" or "off")
end

function var_0_0.RefreshBuilding(arg_18_0)
	local var_18_0 = SailGameBuildingCfg.get_id_list_by_activity_id[arg_18_0.activityID_]

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		arg_18_0.buildingList_[iter_18_0]:SetData(iter_18_1, arg_18_0.activityID_)
	end
end

function var_0_0.RefreshIslandLevel(arg_19_0)
	local var_19_0 = SailGameData:GetIslandLevel(arg_19_0.activityID_)

	arg_19_0.islandLevelText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_ISLAND_LEVEL_TIP"), NumberTools.IntToRomam(var_19_0))
end

function var_0_0.RefreshSailCount(arg_20_0)
	local var_20_0 = false
	local var_20_1 = SailGameData:GetSailCount(arg_20_0.activityID_)
	local var_20_2 = GameSetting.activity_skadi_sea_be_out_num_max.value[1]

	arg_20_0.sailCountText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_TIP"), var_20_1, var_20_2)
	arg_20_0.sailCountText2_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_TIP"), var_20_1, var_20_2)

	if var_20_1 < var_20_2 then
		arg_20_0.nextRefreshSailCountTime_ = SailGameTools.GetNextRecoverTimeStep(arg_20_0.activityID_)

		if arg_20_0.nextRefreshSailCountTime_ ~= -1 and manager.time:GetServerTime() < arg_20_0.stopTime_ then
			var_20_0 = true

			arg_20_0:AddSailTimer()
		else
			var_20_0 = false
		end
	else
		var_20_0 = false

		arg_20_0:StopSailTimer()
	end

	arg_20_0.sailCountController_:SetSelectedState(var_20_0 and "on" or "off")
end

function var_0_0.OnBuildingUnlock(arg_21_0)
	arg_21_0:RefreshBuilding()
end

function var_0_0.OnIslandUpgrade(arg_22_0)
	arg_22_0:RefreshBuilding()
	arg_22_0:RefreshIslandLevel()
end

local var_0_1 = 0.6

function var_0_0.OnReceivedBuildingReward(arg_23_0, arg_23_1)
	arg_23_0:RefreshBuilding()

	arg_23_0.coinVaryText_.text = "+" .. arg_23_1

	SetActive(arg_23_0.coinVaryGo_, true)

	arg_23_0.coinAnim_.enabled = true

	arg_23_0:PlayAnim("XH3rdVoyagesGameUI_text", arg_23_0.coinAnim_, function()
		SetActive(arg_23_0.coinVaryGo_, false)
		arg_23_0:PlayCurrencyRollAnim(arg_23_1)
		arg_23_0:PlayAnim("XH3rdVoyagesGameUI_coin", arg_23_0.coinAnim_, function()
			arg_23_0.coinAnim_.enabled = false
		end)
	end)
end

function var_0_0.PlayCurrencyRollAnim(arg_26_0, arg_26_1)
	local var_26_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_SKADI_SEA_COIN.item_id) - arg_26_1

	arg_26_0.tween_ = LeanTween.value(0, 1, var_0_1):setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
		local var_27_0 = var_26_0 or 0
		local var_27_1 = math.floor(var_27_0 + arg_26_1 * arg_27_0)

		arg_26_0.coinNumText_.text = tostring(var_27_1)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		if arg_26_0.tween_ then
			arg_26_0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
			LeanTween.cancel(arg_26_0.tween_.id)

			arg_26_0.tween_ = nil
		end

		arg_26_0.coinNumText_.text = var_26_0 + arg_26_1
	end)):setEase(LeanTweenType.easeOutQuad)
end

function var_0_0.PlayAnim(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if not arg_29_2 then
		return
	end

	arg_29_2:Play(arg_29_1, -1, 0)
	arg_29_2:Update(0)
	arg_29_0:StopAnimTimer(arg_29_1)

	arg_29_0.animTimerList_[arg_29_1] = Timer.New(function()
		local var_30_0 = arg_29_2:GetCurrentAnimatorStateInfo(0)

		if var_30_0:IsName(arg_29_1) and var_30_0.normalizedTime >= 1 then
			arg_29_0:StopAnimTimer(arg_29_1)

			if arg_29_3 then
				arg_29_3()
			end
		end
	end, 0.033, -1)

	arg_29_0.animTimerList_[arg_29_1]:Start()
end

function var_0_0.AddTimer(arg_31_0)
	if manager.time:GetServerTime() >= arg_31_0.stopTime_ then
		arg_31_0.remainTimeText_.text = GetTips("TIME_OVER")

		return
	end

	arg_31_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_31_0.stopTime_)

	arg_31_0:StopTimer()

	arg_31_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_31_0.stopTime_ then
			arg_31_0:StopTimer()

			arg_31_0.remainTimeText_.text = GetTips("TIME_OVER")

			return
		end

		arg_31_0.remainTimeText_.text = manager.time:GetLostTimeStr(arg_31_0.stopTime_)

		for iter_32_0, iter_32_1 in ipairs(arg_31_0.buildingList_) do
			iter_32_1:RefreshTime()
		end
	end, 1, -1)

	arg_31_0.timer_:Start()
end

function var_0_0.StopTimer(arg_33_0)
	if arg_33_0.timer_ then
		arg_33_0.timer_:Stop()

		arg_33_0.timer_ = nil
	end
end

function var_0_0.AddSailTimer(arg_34_0)
	if manager.time:GetServerTime() >= arg_34_0.stopTime_ or manager.time:GetServerTime() >= arg_34_0.nextRefreshSailCountTime_ then
		return
	end

	arg_34_0.leftTime_ = arg_34_0.nextRefreshSailCountTime_ - manager.time:GetServerTime()
	arg_34_0.sailCountTimeText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_ADD_TIP"), manager.time:DescCDTime(arg_34_0.leftTime_))

	arg_34_0:StopSailTimer()

	arg_34_0.sailCountTimer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_34_0.stopTime_ or manager.time:GetServerTime() >= arg_34_0.nextRefreshSailCountTime_ then
			arg_34_0:StopSailTimer()
			arg_34_0:RefreshSailCount()

			return
		end

		arg_34_0.sailCountTimeText_.text = string.format(GetTips("ACTIVITY_SKADI_SEA_BE_OUT_NUM_ADD_TIP"), manager.time:DescCDTime(arg_34_0.leftTime_))
		arg_34_0.leftTime_ = arg_34_0.leftTime_ - 1
	end, 1, -1)

	arg_34_0.sailCountTimer_:Start()
end

function var_0_0.StopSailTimer(arg_36_0)
	if arg_36_0.sailCountTimer_ then
		arg_36_0.sailCountTimer_:Stop()

		arg_36_0.sailCountTimer_ = nil
	end
end

function var_0_0.StopAllAnimTimer(arg_37_0)
	for iter_37_0, iter_37_1 in pairs(arg_37_0.animTimerList_) do
		arg_37_0.animTimerList_[iter_37_0]:Stop()

		arg_37_0.animTimerList_[iter_37_0] = nil
	end
end

function var_0_0.StopAnimTimer(arg_38_0, arg_38_1)
	if arg_38_0.animTimerList_[arg_38_1] then
		arg_38_0.animTimerList_[arg_38_1]:Stop()

		arg_38_0.animTimerList_[arg_38_1] = nil
	end
end

function var_0_0.BindRedPoint(arg_39_0)
	local var_39_0 = string.format("%s_%s", RedPointConst.SAIL_GAME_COUNT, arg_39_0.activityID_)

	manager.redPoint:bindUIandKey(arg_39_0.goBtn_.transform, var_39_0)

	local var_39_1 = string.format("%s_%s", RedPointConst.SAIL_GAME_TASK, arg_39_0.activityID_)

	manager.redPoint:bindUIandKey(arg_39_0.islandRewardBtn_.transform, var_39_1)

	local var_39_2 = string.format("%s_%s", RedPointConst.SAIL_GAME_ISLAND_UPGRADE, arg_39_0.activityID_)

	manager.redPoint:bindUIandKey(arg_39_0.upgradeBtn_.transform, var_39_2)
end

function var_0_0.UnBindRedPoint(arg_40_0)
	local var_40_0 = string.format("%s_%s", RedPointConst.SAIL_GAME_COUNT, arg_40_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_40_0.goBtn_.transform, var_40_0)

	local var_40_1 = string.format("%s_%s", RedPointConst.SAIL_GAME_TASK, arg_40_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_40_0.islandRewardBtn_.transform, var_40_1)

	local var_40_2 = string.format("%s_%s", RedPointConst.SAIL_GAME_ISLAND_UPGRADE, arg_40_0.activityID_)

	manager.redPoint:unbindUIandKey(arg_40_0.upgradeBtn_.transform, var_40_2)
end

return var_0_0
