local EnchantmentStageView = class("EnchantmentStageView", ReduxView)

local function var_0_1(arg_1_0, arg_1_1)
	if GameSetting.fm_stage_unlock.value[arg_1_0] <= PlayerData:GetPlayerInfo().userLevel then
		return false
	end

	if arg_1_1 then
		ShowTips(string.format(GetTips("PLAYER_LEVEL_UNLOCK"), GameSetting.fm_stage_unlock.value[arg_1_0]))
	end

	return true
end

local var_0_2 = GameSetting.fm_free_refresh_limit_count.value[1]
local var_0_3 = GameSetting.fm_item_refresh_limit_count.value[1]
local var_0_4 = GameSetting.fm_item_refresh_cost.value
local var_0_7 = 203

function EnchantmentStageView:UIName()
	return "Widget/System/EnchantmentStage/EnchantmentStageUI"
end

function EnchantmentStageView:UIParent()
	return manager.ui.uiMain.transform
end

function EnchantmentStageView:Init()
	self:InitUI()
	self:AddUIListener()
end

function EnchantmentStageView:InitUI()
	self:BindCfgUI()

	self.stageLuaItem_ = {}
	self.diffButtonList_ = {}
	self.curStageIDList_ = {}
	self.selectingDifficult = false
	self.selectStageController_ = self.mainControllerEx_:GetController("selectStageState")
	self.refreshController_ = self.mainControllerEx_:GetController("refreshState")
	self.diffSelectController_ = self.mainControllerEx_:GetController("diffSelectState")
	self.diffLockController_ = self.mainControllerEx_:GetController("diffLockState")
	self.panelController_ = ControllerUtil.GetController(self.panelTrs_, "name")

	for iter_5_0 = 1, 3 do
		self.stageLuaItem_[iter_5_0] = EnchantmentStageItem.New(self["stageItem" .. iter_5_0 .. "Go_"], function()
			if self.selectingDifficult then
				SetActive(self.diffPanelGo_, false)

				self.selectingDifficult = false

				return
			end

			self:Go("enchantmentSectionInfo", {
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT,
				section = self.curStageIDList_[iter_5_0],
				chapterID = var_0_7
			})
			SetActive(self.closeSectionBtn_.gameObject, true)
			self.selectStageController_:SetSelectedState(iter_5_0)
			self.panelController_:SetSelectedState(iter_5_0)
		end)
		self.diffButtonList_[iter_5_0] = self["diff" .. iter_5_0 .. "Btn_"]
	end

	self.multiView = OperationMultiView.New(self.doubleGo_)
end

function EnchantmentStageView:AddUIListener()
	self:AddBtnListener(self.buyBtn_, nil, function()
		if self.selectingDifficult then
			SetActive(self.diffPanelGo_, false)

			self.selectingDifficult = false

			return
		end

		local var_8_0 = BattleEnchantmentData:GetData()
		local var_8_1 = GameSetting.fm_item_refresh_cost.value[var_8_0.allRefreshedTimes + 1][2] - CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)

		if var_8_1 > 0 then
			ShopTools.DefaultOpenPopUp(var_8_1)

			return
		end

		if _G.SkipTip.SkipEnchantmentRefreshTip then
			BattleEnchantAction.EnchantmentRefresh(2, GameSetting.fm_item_refresh_cost.value[var_8_0.allRefreshedTimes + 1])

			return
		end

		local var_8_2 = false

		JumpTools.OpenPageByJump("popCostItem", {
			costId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
			costCount = GameSetting.fm_item_refresh_cost.value[var_8_0.allRefreshedTimes + 1][2],
			content = GetTipsF("ENCHANTMENT_STAGE_REFRESH_CHECK", GetI18NText(ItemCfg[CurrencyConst.CURRENCY_TYPE_DIAMOND].name), GameSetting.fm_item_refresh_cost.value[var_8_0.allRefreshedTimes + 1][2]),
			popCostCallBack = function()
				BattleEnchantAction.EnchantmentRefresh(2, GameSetting.fm_item_refresh_cost.value[var_8_0.allRefreshedTimes + 1])

				_G.SkipTip.SkipEnchantmentRefreshTip = var_8_2
			end,
			ToggleCallback = function(arg_10_0)
				var_8_2 = arg_10_0
			end
		})
	end)
	self:AddBtnListener(self.freeBtn_, nil, function()
		if self.selectingDifficult then
			SetActive(self.diffPanelGo_, false)

			self.selectingDifficult = false

			return
		end

		if not _G.SkipTip.SkipRefreshEnchantmentTimesTip and SettingData:GetRemindSettingData().refresh_enchantment_times_reminder == 1 then
			local var_11_0 = false

			for iter_11_0, iter_11_1 in ipairs(BattleEnchantmentData:GetData().enchantmentBattleList) do
				if StageGroupCfg[iter_11_1].level >= 3 then
					var_11_0 = true

					break
				end
			end

			if var_11_0 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("EQUIP_STAGE_REFRESH"),
					OkCallback = function()
						_G.SkipTip.SkipRefreshEnchantmentTimesTip = self.SkipRefreshEnchantmentTimesTip_

						BattleEnchantAction.EnchantmentRefresh(1)
					end,
					ToggleCallback = function(arg_13_0)
						self.SkipRefreshEnchantmentTimesTip_ = arg_13_0
					end
				})

				return
			end
		end

		BattleEnchantAction.EnchantmentRefresh(1)
	end)
	self:AddBtnListener(self.noneBtn_, nil, function()
		ShowTips("JM_REFRESH_NONE")
	end)
	self:AddBtnListener(self.closeSectionBtn_, nil, function()
		SetActive(self.closeSectionBtn_.gameObject, false)

		if self:IsOpenRoute("enchantmentSectionInfo") then
			JumpTools.Back()
		end
	end)

	for iter_7_0 = 1, 3 do
		self:AddBtnListener(self.diffButtonList_[iter_7_0], nil, function()
			if var_0_1(iter_7_0, true) then
				return
			end

			self.diffSelectController_:SetSelectedState(iter_7_0)
			BattleEnchantAction.SetSelectLevel(iter_7_0)

			self.selectedDifficulty_ = iter_7_0

			self:RefreshContent()
		end)
	end

	self:AddBtnListener(self.diffSelectBtn_, nil, function()
		SetActive(self.diffPanelGo_, true)

		self.selectingDifficult = true
	end)
	self:AddBtnListener(self.diffCloseBtn_, nil, function()
		SetActive(self.diffPanelGo_, false)

		self.selectingDifficult = false
	end)
end

function EnchantmentStageView:OnTop()
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
	self.selectStageController_:SetSelectedState("none")
	self.panelController_:SetSelectedState("0")
end

function EnchantmentStageView:OnEnter()
	self.timeText_.text = TimeMgr:DescCDTime(self:during())

	local var_20_0 = 3

	while var_20_0 > 1 do
		if var_0_1(var_20_0) then
			var_20_0 = var_20_0 - 1
		else
			break
		end
	end

	self.diffLockController_:SetSelectedState(var_20_0)

	self.selectedDifficulty_ = BattleEnchantAction.GetSelectLevel()

	if self.selectedDifficulty_ == 0 then
		self.selectedDifficulty_ = var_20_0

		BattleEnchantAction.SetSelectLevel(self.selectedDifficulty_)
	end

	self.diffSelectController_:SetSelectedState(self.selectedDifficulty_)
	self:RefreshUI()
	self:RefreshMultiReward()
end

function EnchantmentStageView:RefreshUI()
	self:RefreshTimePanel()
	self:RefreshContent()
end

function EnchantmentStageView:during()
	return _G.gameTimer:GetNextDayFreshTime() - manager.time:GetServerTime()
end

function EnchantmentStageView:RefreshTimePanel()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	local var_23_0

	self.timer_ = Timer.New(function()
		var_23_0 = self:during()
		self.timeText_.text = TimeMgr:DescCDTime(var_23_0)

		if var_23_0 <= 0 then
			self.timer_:Stop()

			self.timer_ = nil
		end
	end, 1, -1)

	self.timer_:Start()

	local var_23_1 = BattleEnchantmentData:GetData()

	if var_23_1.freeRefreshTimes > 0 then
		self.refreshController_:SetSelectedState("free")

		self.freeText_.text = string.format("%d/%d", var_23_1.freeRefreshTimes, var_0_2)
	elseif var_23_1.allRefreshedTimes < var_0_3 then
		self.refreshController_:SetSelectedState("buy")

		self.butImg_.sprite = ItemTools.getItemSprite(var_0_4[var_23_1.allRefreshedTimes + 1][1])
		self.buyText_.text = string.format("(%d/%d)", var_0_3 - var_23_1.allRefreshedTimes, var_0_3)
		self.butCostText_.text = var_0_4[var_23_1.allRefreshedTimes + 1][2]
	else
		self.refreshController_:SetSelectedState("none")

		self.noneText_.text = string.format("/%d", var_0_3)
	end
end

function EnchantmentStageView:RefreshContent()
	self.itempanelAni1_:Play("BossSwitchUI1", 0, 0)
	self.itempanelAni2_:Play("BossSwitchUI1", 0, 0)
	self.itempanelAni3_:Play("BossSwitchUI1", 0, 0)
	SetActive(self.diffPanelGo_, false)

	self.selectingDifficult = false

	local var_25_0 = BattleEnchantmentData:GetData()

	for iter_25_0 = 1, 3 do
		self.curStageIDList_[iter_25_0] = StageGroupCfg[var_25_0.enchantmentBattleList[iter_25_0]].stage_list[self.selectedDifficulty_]

		self.stageLuaItem_[iter_25_0]:SetData(StageGroupCfg[var_25_0.enchantmentBattleList[iter_25_0]].stage_list[self.selectedDifficulty_], StageGroupCfg[var_25_0.enchantmentBattleList[iter_25_0]].level)
	end
end

function EnchantmentStageView:RefreshMultiReward()
	self.multiView:RefreshUI(203)
end

function EnchantmentStageView:OnExit()
	if self.multiView then
		self.multiView:OnExit()
	end

	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function EnchantmentStageView:Dispose()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end

	if self.multiView then
		self.multiView:Dispose()

		self.multiView = nil
	end

	if self.countdownTimer_ then
		self.countdownTimer_:Stop()

		self.countdownTimer_ = nil
	end

	for iter_28_0 = 1, 3 do
		self.stageLuaItem_[iter_28_0]:Dispose()
	end

	EnchantmentStageView.super.Dispose(self)
end

function EnchantmentStageView:OnEnchantmentRefresh()
	self:RefreshUI()
end

function EnchantmentStageView:OnEnchantmentInit()
	self:RefreshUI()
end

function EnchantmentStageView:OnMultipleRewardCountChange()
	self:RefreshMultiReward()
end

return EnchantmentStageView
