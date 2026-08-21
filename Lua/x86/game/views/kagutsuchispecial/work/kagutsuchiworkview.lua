local var_0_0 = import("game.tools.KagutsuchiMapGenerator")
local var_0_1 = import("manager.windowBar.WindowCurrencyItem")
local var_0_2 = class("KagutsuchiWorkView", ReduxView)

function var_0_2.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionWorkUI/JapanRegionWorkUI"
end

function var_0_2.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_2.OnCtor(arg_3_0)
	arg_3_0.mapGrids = {}
	arg_3_0.mapGridGos = {}
	arg_3_0.seed_ = 1
end

function var_0_2.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddListeners()
	arg_4_0:RegistEventListener(NEW_DAY, handler(arg_4_0, arg_4_0.OnNewDay))

	arg_4_0.transformList_ = arg_4_0:GetTransformList()
	arg_4_0.rewardList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.rewardUiList_, CommonItem)
	arg_4_0.scrollMoveView_ = ScrollMoveView.New(arg_4_0, arg_4_0.scrollViewGo_)

	arg_4_0.scrollMoveView_:RemoveListeners()

	local var_4_0 = arg_4_0.workContentGo_.transform.localPosition

	arg_4_0.leftX_ = var_4_0.x
	arg_4_0.rightX_ = var_4_0.x + 1000

	local var_4_1 = var_0_1.New(arg_4_0.token1Go_, CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)

	var_4_1:SetActive(true)
	var_4_1:SetCanAdd(false)
	var_4_1:SetCanClick(true)

	arg_4_0.token1_ = var_4_1

	local var_4_2 = var_0_1.New(arg_4_0.token2Go_, CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)

	var_4_2:SetActive(true)
	var_4_2:SetCanAdd(false)
	var_4_2:SetCanClick(true)

	arg_4_0.token2_ = var_4_2
	arg_4_0.clearController = ControllerUtil.GetController(arg_4_0.dispatchInfoTrs_, "clear")
	arg_4_0.battleController = ControllerUtil.GetController(arg_4_0.battleBtnTrs_, "name")
	arg_4_0.dispatchController = ControllerUtil.GetController(arg_4_0.dispatchBtnTrs_, "name")
end

function var_0_2.OnEnter(arg_5_0)
	arg_5_0:InitBar()
	arg_5_0:RefreshUI()

	local var_5_0 = arg_5_0:GetActivityID()
	local var_5_1 = ActivityTools.GetRedPointKey(var_5_0) .. var_5_0
	local var_5_2 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_TALENT, var_5_1)

	manager.redPoint:bindUIandKey(arg_5_0.talentBtn_.transform, var_5_2)

	arg_5_0.lastClickGrid_ = nil

	arg_5_0:AddTimer()
	arg_5_0:RefreshScrollRect(false, true)
end

function var_0_2.InitBar(arg_6_0)
	return
end

function var_0_2.OnExit(arg_7_0)
	local var_7_0 = arg_7_0:GetActivityID()
	local var_7_1 = ActivityTools.GetRedPointKey(var_7_0) .. var_7_0
	local var_7_2 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_TALENT, var_7_1)

	manager.redPoint:unbindUIandKey(arg_7_0.talentBtn_.transform, var_7_2)

	if arg_7_0.lastClickGrid_ then
		arg_7_0.lastClickGrid_:SetSelected(false)
	end

	arg_7_0:StopTimer()
end

function var_0_2.Dispose(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.mapGrids) do
		iter_8_1:Dispose()
	end

	var_0_0:Clear()
	arg_8_0.scrollMoveView_:Dispose()

	arg_8_0.scrollMoveView_ = nil

	arg_8_0.rewardList_:Dispose()
	arg_8_0.token1_:Dispose()
	arg_8_0.token2_:Dispose()
	var_0_2.super.Dispose(arg_8_0)
end

function var_0_2.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.gachaBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("activity_kagutsuchi_draw2")
		JumpTools.OpenPageByJump("/kagutsuchiGacha", {})
	end)
	arg_9_0:AddBtnListener(arg_9_0.talentBtn_, nil, function()
		local var_11_0 = arg_9_0:GetActivityID()
		local var_11_1 = ActivityTools.GetRedPointKey(var_11_0) .. var_11_0
		local var_11_2 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_TALENT, var_11_1)

		if manager.redPoint:getTipBoolean(var_11_2) then
			KagutsuchiTalentAction:BanRedPoint(var_11_2)
		end

		JumpTools.OpenPageByJump("/kagutsuchiTalent", {})
	end)
	arg_9_0:AddBtnListener(arg_9_0.workMaskBtn_, nil, function()
		arg_9_0:OnClickBackground()
	end)
	arg_9_0:AddBtnListener(arg_9_0.battleBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_9_0:GetActivityID()) then
			return
		end

		if arg_9_0.lastClickGrid_ then
			if not arg_9_0.lastClickGrid_:GetPlayGridData():IsBattle() then
				return
			end

			if arg_9_0.playGridParams_.battleCost > KagutsuchiWorkData:GetStamina() then
				ShowTips("ACTIVITY_KAGUTSUCHI_BATTLE_COST_NOT_ENOUGH")

				return
			end

			gameContext:Go("/sectionSelectHero", {
				section = arg_9_0.playGridParams_.stageId,
				sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME,
				activityID = arg_9_0.playGridParams_.activityId
			})
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.entrustBtn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_9_0:GetActivityID()) then
			return
		end

		function arg_9_0.playGridParams_.entrustFinishHandler_()
			if arg_9_0.lastClickGrid_ then
				arg_9_0.lastClickGrid_:RefreshUI()
			end

			arg_9_0:OnClickBackground()
			arg_9_0:RefreshUI()
		end

		if arg_9_0.lastClickGrid_ then
			if arg_9_0.lastClickGrid_:GetPlayGridData():IsCleared() then
				return
			end

			JumpTools.OpenPageByJump("kagutsuchiWorkPop", arg_9_0.playGridParams_)
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.backBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_9_0:AddBtnListener(arg_9_0.homeBtn_, nil, function()
		gameContext:Go("/home", nil, nil, true)
	end)
	arg_9_0:AddBtnListener(arg_9_0.infoBtn_, nil, function()
		local var_18_0 = "ACTIVITY_KAGUTSUCHI_BATTLE_DESCRIBE"
		local var_18_1 = GetTips(var_18_0)

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_18_1,
			key = var_18_0
		})
	end)
end

function var_0_2.OnClickBackground(arg_19_0)
	if arg_19_0.lastClickGrid_ then
		arg_19_0.lastClickGrid_:SetSelected(false)

		arg_19_0.lastClickGrid_ = nil
	end

	arg_19_0:RefreshScrollRect(false)
end

function var_0_2.GetTransformList(arg_20_0)
	local var_20_0 = {}

	arg_20_0.mapGridsGo_:InjectUI(var_20_0)

	local var_20_1 = {}

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		table.insert(var_20_1, iter_20_1)
	end

	return var_20_1
end

function var_0_2.UpdateMap(arg_21_0)
	var_0_0:SetMapSize(20, 20)
	var_0_0:SetMapSeed(KagutsuchiWorkData:GetMapSeed() + arg_21_0.seed_)
	var_0_0:SetMapGrids(arg_21_0.transformList_, handler(arg_21_0, arg_21_0.CreateMapItem), handler(arg_21_0, arg_21_0.Transform2Xy))
	var_0_0:GeneratePlaceableGrids(KagutsuchiWorkData:GetPlayGridNum(), handler(arg_21_0, arg_21_0.ModifyMapItem))
end

function var_0_2.ResetMap(arg_22_0)
	arg_22_0:OnClickBackground()

	for iter_22_0, iter_22_1 in pairs(arg_22_0.mapGrids) do
		iter_22_1:Dispose()
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_0.mapGridGos) do
		Object.Destroy(iter_22_3)
	end

	arg_22_0.mapGrids = {}
	arg_22_0.mapGridGos = {}

	var_0_0:Clear()
end

function var_0_2.CreateMapItem(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.transform.gameObject

	var_23_0:SetActive(true)

	local var_23_1 = KagutsuchiWorkMapGrid.New(var_23_0, handler(arg_23_0, arg_23_0.CreatePlayGridGo))

	var_23_1:SetClickHandler(handler(arg_23_0, arg_23_0.OnClickPlayGrid))
	table.insert(arg_23_0.mapGrids, var_23_1)

	return var_23_1
end

function var_0_2.CreatePlayGridGo(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = Object.Instantiate(arg_24_0.playGridGo_, arg_24_1)

	var_24_0:SetActive(true)
	table.insert(arg_24_0.mapGridGos, var_24_0)

	return var_24_0
end

function var_0_2.ModifyMapItem(arg_25_0, arg_25_1)
	arg_25_1.grid:BindPlayGrid(arg_25_1.index)
end

function var_0_2.OnClickPlayGrid(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_0.lastClickGrid_ == arg_26_1 then
		return
	end

	if arg_26_0.lastClickGrid_ then
		arg_26_0.lastClickGrid_:SetSelected(false)
	end

	arg_26_0.playGridParams_ = arg_26_2
	arg_26_0.lastClickGrid_ = arg_26_1

	arg_26_0:RefreshGridInfo()
end

function var_0_2.IndexItem(arg_27_0, arg_27_1, arg_27_2)
	arg_27_2:RegistCallBack(function(arg_28_0)
		ShowPopItem(POP_ITEM, {
			arg_28_0.id,
			arg_28_0.number,
			0
		})
	end)

	local var_27_0 = ItemCfg[CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id]

	arg_27_2:RefreshData({
		id = var_27_0.id,
		type = var_27_0.type,
		number = arg_27_0.rewardNumber_
	})
end

function var_0_2.RefreshUI(arg_29_0)
	KagutsuchiTalentAction:UpdateRedPoint(arg_29_0:GetActivityID())

	arg_29_0.coinText_.text = KagutsuchiWorkData:GetCoins()
	arg_29_0.staminaText_.text = KagutsuchiWorkData:GetStamina()
	arg_29_0.coinImage_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)
	arg_29_0.staminaImage_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
	arg_29_0.upgradeConditionText_.text = KagutsuchiWorkData:GetUpgradeConditionText()

	SetActive(arg_29_0.unclearTextGo_, not KagutsuchiWorkData:IsUpgraded())
	SetActive(arg_29_0.clearTextGo_, KagutsuchiWorkData:IsUpgraded())
	SetActive(arg_29_0.upgradeBoxGo_, not KagutsuchiWorkData:IsMaxLevel())
	arg_29_0:UpdateMap()
end

function var_0_2.RefreshGridInfo(arg_30_0)
	SetActive(arg_30_0.workContentGo_, true)

	local var_30_0 = arg_30_0.lastClickGrid_:GetPlayGridData()
	local var_30_1 = var_30_0:IsCleared()

	if arg_30_0.playGridParams_.isBattle then
		arg_30_0.titleText_.text = arg_30_0.playGridParams_.battleName
		arg_30_0.levelText_.text = "Lv." .. arg_30_0.playGridParams_.battleLevel
		arg_30_0.summaryText_.text = arg_30_0.playGridParams_.battleSummary
		arg_30_0.costImage_.sprite = ItemTools.getItemSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
		arg_30_0.costText_.text = "x" .. arg_30_0.playGridParams_.battleCost

		local var_30_2 = var_30_0:GetBattleMinTime()
		local var_30_3 = math.floor(var_30_2 / 60)
		local var_30_4 = math.fmod(var_30_2, 60)

		arg_30_0.minTimeText_.text = string.format("%02d:%02d", var_30_3, var_30_4)

		arg_30_0.clearController:SetSelectedState(var_30_1 and "true" or "false")
		arg_30_0.battleController:SetSelectedState("false")

		arg_30_0.rewardNumber_ = arg_30_0.playGridParams_.battleReward

		SetActive(arg_30_0.battleGo_, true)
		SetActive(arg_30_0.costGo_, true)
		SetActive(arg_30_0.levelGo_, true)
		SetActive(arg_30_0.entrustGo_, false)
	else
		arg_30_0.titleText_.text = arg_30_0.playGridParams_.entrustName
		arg_30_0.levelText_.text = ""
		arg_30_0.summaryText_.text = arg_30_0.playGridParams_.entrustSummary
		arg_30_0.rewardNumber_ = arg_30_0.playGridParams_.entrustReward

		arg_30_0.clearController:SetSelectedState("false")
		arg_30_0.battleController:SetSelectedState(var_30_1 and "true" or "false")
		SetActive(arg_30_0.battleGo_, false)
		SetActive(arg_30_0.costGo_, false)
		SetActive(arg_30_0.levelGo_, false)
		SetActive(arg_30_0.entrustGo_, not var_30_1)
	end

	arg_30_0.rewardList_:StartScroll(arg_30_0.rewardNumber_ > 0 and 1 or 0)
	arg_30_0:RefreshScrollRect(true)
end

function var_0_2.RefreshScrollRect(arg_31_0, arg_31_1, arg_31_2)
	local function var_31_0()
		arg_31_0:StopMapTimer()

		local var_32_0 = arg_31_1 and arg_31_0:GetScrollPos() or arg_31_0:GetScrollWidth() / 2
		local var_32_1 = arg_31_0:GetScrollWidth()

		arg_31_0.scrollMoveView_:RefreshUI(var_32_0, var_32_1, arg_31_2)
	end

	if arg_31_1 then
		if not arg_31_0.mapTimer_ then
			arg_31_0.mapTimer_ = Timer.New(var_31_0, 0.2, 1)

			arg_31_0.mapTimer_:Start()
		end
	else
		var_31_0()
	end

	if arg_31_0.workContentAni_ and arg_31_0.workContentAni_.runtimeAnimatorController then
		local var_31_1 = arg_31_1
		local var_31_2 = arg_31_0.workContentAni_:GetCurrentAnimatorStateInfo(0)
		local var_31_3 = math.min(math.max(var_31_2.normalizedTime, 0), 1)

		arg_31_0.workContentAni_:SetFloat("Direction", var_31_1 and 1 or -1)
		arg_31_0.workContentAni_:Play("Fx_right_cx", -1, var_31_3)
	else
		LeanTween.moveLocalX(arg_31_0.workContentGo_, arg_31_1 and arg_31_0.leftX_ or arg_31_0.rightX_, 0.2)
	end
end

function var_0_2.RefreshTimeUI(arg_33_0)
	local var_33_0 = ActivityData:GetActivityData(arg_33_0:GetActivityID()).stopTime
	local var_33_1 = manager.time:GetNextFreshTime()
	local var_33_2 = KagutsuchiWorkData:GetNextBossTime()

	arg_33_0.timeText_.text = manager.time:GetLostTimeStr2(var_33_0)
	arg_33_0.mapUpdateText_.text = manager.time:GetLostTimeStr2(var_33_1)
	arg_33_0.bossTimeText_.text = manager.time:GetLostTimeStr2(var_33_2)

	SetActive(arg_33_0.bossTimeGo_, not KagutsuchiWorkData:IsBossDay())
end

function var_0_2.IsOpenSectionInfo(arg_34_0)
	return false
end

function var_0_2.GetScrollWidth(arg_35_0)
	return arg_35_0.mapGridsGo_.transform.rect.width
end

function var_0_2.GetScrollPos(arg_36_0)
	return arg_36_0.lastClickGrid_:GetPosition().x
end

function var_0_2.OnNewDay(arg_37_0)
	arg_37_0:ResetMap()
	arg_37_0:RefreshUI()
end

function var_0_2.OnKagutsuchiWorkDataInit(arg_38_0)
	arg_38_0:OnNewDay()
end

function var_0_2.AddTimer(arg_39_0)
	arg_39_0:StopTimer()
	arg_39_0:RefreshTimeUI()

	arg_39_0.timer_ = Timer.New(function()
		arg_39_0:RefreshTimeUI()
	end, 1, -1)

	arg_39_0.timer_:Start()
end

function var_0_2.StopTimer(arg_41_0)
	arg_41_0:StopMapTimer()

	if arg_41_0.timer_ then
		arg_41_0.timer_:Stop()

		arg_41_0.timer_ = nil
	end
end

function var_0_2.StopMapTimer(arg_42_0)
	if arg_42_0.mapTimer_ ~= nil then
		arg_42_0.mapTimer_:Stop()

		arg_42_0.mapTimer_ = nil
	end
end

function var_0_2.GetActivityID(arg_43_0)
	return ActivityConst.KAGUTSUCHI_ACTIVITY
end

function var_0_2.Transform2Xy(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_1.anchoredPosition
	local var_44_1 = arg_44_1.rect
	local var_44_2 = {
		arg_44_1.rect.width / 2,
		arg_44_1.rect.height / 2
	}
	local var_44_3 = math.floor(var_44_0.x / (var_44_1.width + var_44_2[1])) + 1
	local var_44_4 = math.floor(var_44_0.y / (var_44_1.height + var_44_2[2])) + 1

	return var_44_3, var_44_4
end

return var_0_2
