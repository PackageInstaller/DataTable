local var_0_0 = class("KagutsuchiWorkPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionWorkUI/JapanRegionWorkDispatchUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
	arg_3_0:RegistEventListener(NEW_DAY, handler(arg_3_0, arg_3_0.OnNewDay))

	arg_3_0.winController_ = ControllerUtil.GetController(arg_3_0.transform_, "window")
	arg_3_0.entrustingController_ = ControllerUtil.GetController(arg_3_0.transform_, "entrusting")
	arg_3_0.heroScroll = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.heroUiList_, KagutsuchiWorkEntrustHeroItem)
	arg_3_0.commonItem_ = CommonItem.New(arg_3_0.rewardGo_)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.isEntrusting = true

	arg_4_0:RefreshHeroList()
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.isEntrusting = false
	arg_5_0.isEntrustFinished = false
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgmask_, nil, function()
		arg_6_0.isEntrusting = false
		arg_6_0.isEntrustFinished = false

		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.entrustCancelBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.finishBtn_, nil, function()
		arg_6_0.isEntrusting = false
		arg_6_0.isEntrustFinished = false

		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.entrustStartBtn_, nil, function()
		if arg_6_0.heroselectedNum < KagutsuchiWorkData:GetMinEntrustHeroNum() then
			ShowTips("ACTIVITY_KAGUTSUCHI_BATTLE_ENTRUST_FAIL_TIPS")

			return
		end

		arg_6_0:StartEntrust()
	end)
end

function var_0_0.IndexItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:SetHeroData(arg_11_0.heroIdList[arg_11_1])
	arg_11_2:TrySetSelected(arg_11_0.heroSelected[arg_11_1])
	arg_11_2:RefreshUI()
	arg_11_2:SetClickHandler(function(arg_12_0, arg_12_1)
		if arg_11_0.heroSelected[arg_11_1] then
			arg_11_2:TrySetSelected(false)

			arg_11_0.heroSelected[arg_11_1] = false
			arg_11_0.heroselectedNum = arg_11_0.heroselectedNum - 1

			arg_11_2:RefreshUI()
			arg_11_0:RefreshUI()
		elseif arg_11_0.heroselectedNum >= KagutsuchiWorkData:GetMinEntrustHeroNum() then
			return
		elseif arg_11_2:TrySetSelected(true) then
			arg_11_0.heroSelected[arg_11_1] = true
			arg_11_0.heroselectedNum = arg_11_0.heroselectedNum + 1

			arg_11_2:RefreshUI()
			arg_11_0:RefreshUI()
		end
	end)
end

function var_0_0.RefreshHeroList(arg_13_0)
	if arg_13_0.params_.isBattle then
		return
	end

	arg_13_0.heroIdList = KagutsuchiWorkData:GetEntrustHeroIdList()

	arg_13_0:SortHeroIdList()

	arg_13_0.heroSelected = {}

	for iter_13_0 = 1, #arg_13_0.heroIdList do
		arg_13_0.heroSelected[iter_13_0] = false
	end

	arg_13_0.heroselectedNum = 0

	arg_13_0.heroScroll:StartScroll(#arg_13_0.heroIdList)
end

function var_0_0.JumpToBattlePage(arg_14_0)
	gameContext:Go("/sectionSelectHero", {
		section = arg_14_0.params_.stageId,
		sectionType = BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME,
		activityID = arg_14_0.params_.activityId
	})
end

function var_0_0.StartEntrust(arg_15_0)
	local var_15_0 = {}

	for iter_15_0 = 1, #arg_15_0.heroIdList do
		if arg_15_0.heroSelected[iter_15_0] then
			table.insert(var_15_0, arg_15_0.heroIdList[iter_15_0])
		end
	end

	KagutsuchiWorkAction:StartEntrust(arg_15_0.params_.gridId, var_15_0, handler(arg_15_0, arg_15_0.FinishEntrust))
end

function var_0_0.FinishEntrust(arg_16_0, arg_16_1)
	arg_16_0.isEntrustFinished = true
	arg_16_0.entrustReward = arg_16_0.params_.entrustReward

	arg_16_0:RefreshUI()

	if arg_16_0.params_.entrustFinishHandler_ then
		arg_16_0.params_.entrustFinishHandler_(arg_16_1)
	end
end

function var_0_0.RefreshUI(arg_17_0)
	if arg_17_0.params_.isBattle then
		arg_17_0:RefreshBattleUI()
	else
		arg_17_0:RefreshEntrustUI()
	end
end

function var_0_0.RefreshBattleUI(arg_18_0)
	arg_18_0.battleTitleText_.text = arg_18_0.params_.battleName
	arg_18_0.battleLevelText_.text = "Lv." .. arg_18_0.params_.battleLevel
	arg_18_0.battleSummaryText_.text = arg_18_0.params_.battleSummary
	arg_18_0.battleRewardText_.text = "x" .. arg_18_0.params_.battleReward
	arg_18_0.battleCostText_.text = "x" .. arg_18_0.params_.battleCost

	arg_18_0.winController_:SetSelectedState("battle")
end

function var_0_0.RefreshEntrustUI(arg_19_0)
	if arg_19_0.isEntrustFinished then
		local var_19_0 = ItemCfg[CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id]

		arg_19_0.commonItem_:RefreshData({
			id = var_19_0.id,
			type = var_19_0.type,
			number = arg_19_0.params_.entrustReward
		})

		arg_19_0.finishText_.text = arg_19_0.params_.entrustCompleteText

		arg_19_0.winController_:SetSelectedState("finish")
	elseif arg_19_0.isEntrusting then
		local var_19_1 = KagutsuchiWorkData:GetMinEntrustHeroNum()

		arg_19_0.entrustingNumText_.text = string.format("%d/%d", arg_19_0.heroselectedNum, var_19_1)

		if arg_19_0.heroselectedNum == var_19_1 then
			arg_19_0.entrustingController_:SetSelectedState("valid")
		else
			arg_19_0.entrustingController_:SetSelectedState("invalid")
		end

		arg_19_0.winController_:SetSelectedState("entrusting")
	end
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0.commonItem_:Dispose()

	arg_20_0.commonItem_ = nil

	if arg_20_0.heroScroll then
		arg_20_0.heroScroll:Dispose()

		arg_20_0.heroScroll = nil
	end

	var_0_0.super.Dispose(arg_20_0)
end

function var_0_0.OnNewDay(arg_21_0)
	if gameContext:IsOpenRoute("kagutsuchiWorkPop") then
		arg_21_0:Back()
	end
end

function var_0_0.OnKagutsuchiWorkDataInit(arg_22_0)
	arg_22_0:OnNewDay()
end

function var_0_0.SortHeroIdList(arg_23_0)
	table.sort(arg_23_0.heroIdList, function(arg_24_0, arg_24_1)
		return arg_23_0:GetHeroPriority(arg_24_0) > arg_23_0:GetHeroPriority(arg_24_1)
	end)
end

function var_0_0.GetHeroPriority(arg_25_0, arg_25_1)
	local var_25_0 = HeroData:GetHeroData(arg_25_1)

	if var_25_0.unlock == 0 then
		return 1
	end

	if var_25_0.level < KagutsuchiWorkData:GetMinEntrustHeroLevel() then
		return 2
	end

	if KagutsuchiWorkData:IsEntrusted(arg_25_1) then
		return 3
	end

	return 4
end

return var_0_0
