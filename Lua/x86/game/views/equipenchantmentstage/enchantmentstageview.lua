local var_0_0 = class("EnchantmentStageView", ReduxView)

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = GameSetting.fm_stage_unlock.value[arg_1_0]

	if var_1_0 <= PlayerData:GetPlayerInfo().userLevel then
		return false
	end

	if arg_1_1 then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), var_1_0))
	end

	return true
end

local var_0_2 = GameSetting.fm_free_refresh_limit_count.value[1]
local var_0_3 = GameSetting.fm_item_refresh_limit_count.value[1]
local var_0_4 = GameSetting.fm_item_refresh_cost.value
local var_0_5 = GameSetting.fm_stage_unlock.value[1]
local var_0_6 = GameSetting.fm_get_refresh_count.value[1]
local var_0_7 = 203

function var_0_0.UIName(arg_2_0)
	return "Widget/System/EnchantmentStage/EnchantmentStageUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.stageLuaItem_ = {}
	arg_5_0.diffButtonList_ = {}
	arg_5_0.curStageIDList_ = {}
	arg_5_0.selectingDifficult = false
	arg_5_0.selectStageController_ = arg_5_0.mainControllerEx_:GetController("selectStageState")
	arg_5_0.refreshController_ = arg_5_0.mainControllerEx_:GetController("refreshState")
	arg_5_0.diffSelectController_ = arg_5_0.mainControllerEx_:GetController("diffSelectState")
	arg_5_0.diffLockController_ = arg_5_0.mainControllerEx_:GetController("diffLockState")
	arg_5_0.panelController_ = ControllerUtil.GetController(arg_5_0.panelTrs_, "name")

	for iter_5_0 = 1, 3 do
		arg_5_0.stageLuaItem_[iter_5_0] = EnchantmentStageItem.New(arg_5_0["stageItem" .. iter_5_0 .. "Go_"], function()
			if arg_5_0.selectingDifficult then
				SetActive(arg_5_0.diffPanelGo_, false)

				arg_5_0.selectingDifficult = false

				return
			end

			arg_5_0:Go("enchantmentSectionInfo", {
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT,
				section = arg_5_0.curStageIDList_[iter_5_0],
				chapterID = var_0_7
			})
			SetActive(arg_5_0.closeSectionBtn_.gameObject, true)
			arg_5_0.selectStageController_:SetSelectedState(iter_5_0)
			arg_5_0.panelController_:SetSelectedState(iter_5_0)
		end)
		arg_5_0.diffButtonList_[iter_5_0] = arg_5_0["diff" .. iter_5_0 .. "Btn_"]
	end

	arg_5_0.multiView = OperationMultiView.New(arg_5_0.doubleGo_)
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.buyBtn_, nil, function()
		if arg_7_0.selectingDifficult then
			SetActive(arg_7_0.diffPanelGo_, false)

			arg_7_0.selectingDifficult = false

			return
		end

		local var_8_0 = BattleEnchantmentData:GetData()
		local var_8_1 = GameSetting.fm_item_refresh_cost.value[var_8_0.allRefreshedTimes + 1][2]
		local var_8_2 = var_8_1 - CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)

		if var_8_2 > 0 then
			ShopTools.DefaultOpenPopUp(var_8_2)

			return
		end

		if _G.SkipTip.SkipEnchantmentRefreshTip then
			BattleEnchantAction.EnchantmentRefresh(2, GameSetting.fm_item_refresh_cost.value[var_8_0.allRefreshedTimes + 1])

			return
		end

		local var_8_3 = false

		JumpTools.OpenPageByJump("popCostItem", {
			costId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
			costCount = var_8_1,
			content = GetTipsF("ENCHANTMENT_STAGE_REFRESH_CHECK", GetI18NText(ItemCfg[CurrencyConst.CURRENCY_TYPE_DIAMOND].name), var_8_1),
			popCostCallBack = function()
				BattleEnchantAction.EnchantmentRefresh(2, GameSetting.fm_item_refresh_cost.value[var_8_0.allRefreshedTimes + 1])

				_G.SkipTip.SkipEnchantmentRefreshTip = var_8_3
			end,
			ToggleCallback = function(arg_10_0)
				var_8_3 = arg_10_0
			end
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.freeBtn_, nil, function()
		if arg_7_0.selectingDifficult then
			SetActive(arg_7_0.diffPanelGo_, false)

			arg_7_0.selectingDifficult = false

			return
		end

		local var_11_0 = SettingData:GetRemindSettingData()

		if not _G.SkipTip.SkipRefreshEnchantmentTimesTip and var_11_0.refresh_enchantment_times_reminder == 1 then
			local var_11_1 = false
			local var_11_2 = BattleEnchantmentData:GetData().enchantmentBattleList

			for iter_11_0, iter_11_1 in ipairs(var_11_2) do
				if StageGroupCfg[iter_11_1].level >= 3 then
					var_11_1 = true

					break
				end
			end

			if var_11_1 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("EQUIP_STAGE_REFRESH"),
					OkCallback = function()
						_G.SkipTip.SkipRefreshEnchantmentTimesTip = arg_7_0.SkipRefreshEnchantmentTimesTip_

						BattleEnchantAction.EnchantmentRefresh(1)
					end,
					ToggleCallback = function(arg_13_0)
						arg_7_0.SkipRefreshEnchantmentTimesTip_ = arg_13_0
					end
				})

				return
			end
		end

		BattleEnchantAction.EnchantmentRefresh(1)
	end)
	arg_7_0:AddBtnListener(arg_7_0.noneBtn_, nil, function()
		ShowTips("JM_REFRESH_NONE")
	end)
	arg_7_0:AddBtnListener(arg_7_0.closeSectionBtn_, nil, function()
		SetActive(arg_7_0.closeSectionBtn_.gameObject, false)

		if arg_7_0:IsOpenRoute("enchantmentSectionInfo") then
			JumpTools.Back()
		end
	end)

	for iter_7_0 = 1, 3 do
		arg_7_0:AddBtnListener(arg_7_0.diffButtonList_[iter_7_0], nil, function()
			if var_0_1(iter_7_0, true) then
				return
			end

			arg_7_0.diffSelectController_:SetSelectedState(iter_7_0)
			BattleEnchantAction.SetSelectLevel(iter_7_0)

			arg_7_0.selectedDifficulty_ = iter_7_0

			arg_7_0:RefreshContent()
		end)
	end

	arg_7_0:AddBtnListener(arg_7_0.diffSelectBtn_, nil, function()
		SetActive(arg_7_0.diffPanelGo_, true)

		arg_7_0.selectingDifficult = true
	end)
	arg_7_0:AddBtnListener(arg_7_0.diffCloseBtn_, nil, function()
		SetActive(arg_7_0.diffPanelGo_, false)

		arg_7_0.selectingDifficult = false
	end)
end

function var_0_0.OnTop(arg_19_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_VITALITY,
		CurrencyConst.CURRENCY_TYPE_GOLD,
		CurrencyConst.CURRENCY_TYPE_DIAMOND
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetGameHelpKey("ENCHANTMENT_DESCRIPE")
	arg_19_0.selectStageController_:SetSelectedState("none")
	arg_19_0.panelController_:SetSelectedState("0")
end

function var_0_0.OnEnter(arg_20_0)
	arg_20_0.timeText_.text = TimeMgr:DescCDTime(arg_20_0:during())

	local var_20_0 = 3

	while var_20_0 > 1 do
		if var_0_1(var_20_0) then
			var_20_0 = var_20_0 - 1
		else
			break
		end
	end

	arg_20_0.diffLockController_:SetSelectedState(var_20_0)

	arg_20_0.selectedDifficulty_ = BattleEnchantAction.GetSelectLevel()

	if arg_20_0.selectedDifficulty_ == 0 then
		arg_20_0.selectedDifficulty_ = var_20_0

		BattleEnchantAction.SetSelectLevel(arg_20_0.selectedDifficulty_)
	end

	arg_20_0.diffSelectController_:SetSelectedState(arg_20_0.selectedDifficulty_)
	arg_20_0:RefreshUI()
	arg_20_0:RefreshMultiReward()
end

function var_0_0.RefreshUI(arg_21_0)
	arg_21_0:RefreshTimePanel()
	arg_21_0:RefreshContent()
end

function var_0_0.during(arg_22_0)
	return _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime()
end

function var_0_0.RefreshTimePanel(arg_23_0)
	if arg_23_0.timer_ then
		arg_23_0.timer_:Stop()

		arg_23_0.timer_ = nil
	end

	local var_23_0

	arg_23_0.timer_ = Timer.New(function()
		var_23_0 = arg_23_0:during()
		arg_23_0.timeText_.text = TimeMgr:DescCDTime(var_23_0)

		if var_23_0 <= 0 then
			arg_23_0.timer_:Stop()

			arg_23_0.timer_ = nil
		end
	end, 1, -1)

	arg_23_0.timer_:Start()

	local var_23_1 = BattleEnchantmentData:GetData()

	if var_23_1.freeRefreshTimes > 0 then
		arg_23_0.refreshController_:SetSelectedState("free")

		local var_23_2 = string.format("%d/%d", var_23_1.freeRefreshTimes, var_0_2)

		arg_23_0.freeText_.text = var_23_2
	elseif var_23_1.allRefreshedTimes < var_0_3 then
		arg_23_0.refreshController_:SetSelectedState("buy")

		arg_23_0.butImg_.sprite = ItemTools.getItemSprite(var_0_4[var_23_1.allRefreshedTimes + 1][1])
		arg_23_0.buyText_.text = string.format("(%d/%d)", var_0_3 - var_23_1.allRefreshedTimes, var_0_3)
		arg_23_0.butCostText_.text = var_0_4[var_23_1.allRefreshedTimes + 1][2]
	else
		arg_23_0.refreshController_:SetSelectedState("none")

		arg_23_0.noneText_.text = string.format("/%d", var_0_3)
	end
end

function var_0_0.RefreshContent(arg_25_0)
	arg_25_0.itempanelAni1_:Play("BossSwitchUI1", 0, 0)
	arg_25_0.itempanelAni2_:Play("BossSwitchUI1", 0, 0)
	arg_25_0.itempanelAni3_:Play("BossSwitchUI1", 0, 0)
	SetActive(arg_25_0.diffPanelGo_, false)

	arg_25_0.selectingDifficult = false

	local var_25_0 = BattleEnchantmentData:GetData()

	for iter_25_0 = 1, 3 do
		local var_25_1 = var_25_0.enchantmentBattleList[iter_25_0]
		local var_25_2 = StageGroupCfg[var_25_1].stage_list[arg_25_0.selectedDifficulty_]
		local var_25_3 = StageGroupCfg[var_25_1].level

		arg_25_0.curStageIDList_[iter_25_0] = var_25_2

		arg_25_0.stageLuaItem_[iter_25_0]:SetData(var_25_2, var_25_3)
	end
end

function var_0_0.RefreshMultiReward(arg_26_0)
	arg_26_0.multiView:RefreshUI(203)
end

function var_0_0.OnExit(arg_27_0)
	if arg_27_0.multiView then
		arg_27_0.multiView:OnExit()
	end

	if arg_27_0.timer_ then
		arg_27_0.timer_:Stop()

		arg_27_0.timer_ = nil
	end

	if arg_27_0.countdownTimer_ then
		arg_27_0.countdownTimer_:Stop()

		arg_27_0.countdownTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_28_0)
	if arg_28_0.timer_ then
		arg_28_0.timer_:Stop()

		arg_28_0.timer_ = nil
	end

	if arg_28_0.multiView then
		arg_28_0.multiView:Dispose()

		arg_28_0.multiView = nil
	end

	if arg_28_0.countdownTimer_ then
		arg_28_0.countdownTimer_:Stop()

		arg_28_0.countdownTimer_ = nil
	end

	for iter_28_0 = 1, 3 do
		arg_28_0.stageLuaItem_[iter_28_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_28_0)
end

function var_0_0.OnEnchantmentRefresh(arg_29_0)
	arg_29_0:RefreshUI()
end

function var_0_0.OnEnchantmentInit(arg_30_0)
	arg_30_0:RefreshUI()
end

function var_0_0.OnMultipleRewardCountChange(arg_31_0)
	arg_31_0:RefreshMultiReward()
end

return var_0_0
