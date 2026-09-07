local IslandTradePage = class("IslandTradePage", import("...base.IslandBasePage"))

IslandTradePage.OPEN_INVITE_PAGE = "IslandTradePage:OPEN_INVITE_PAGE"
IslandTradePage.OPEN_CONFIRM_PAGE = "IslandTradePage:OPEN_CONFIRM_PAGE"
IslandTradePage.MODE_SELL = 1
IslandTradePage.MODE_PURCHAS = 2

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

function IslandTradePage:getUIName()
	return "IslandTradeUI"
end

function IslandTradePage:OnLoaded()
	self.closeBtn = self._tf:Find("adapt/top/closeBtn")
	self.helpBtn = self._tf:Find("adapt/top/help")
	self.itemCntTxt = self._tf:Find("adapt/shopPage/res/9900/Text"):GetComponent(typeof(Text))
	self.goldCntTxt = self._tf:Find("adapt/shopPage/res/1/Text"):GetComponent(typeof(Text))
	self.pageContainer = self._tf:Find("adapt/shopPage")
	self.pagesUIList = UIItemList.New(self._tf:Find("adapt/tags"), self._tf:Find("adapt/tags/1"))
	self.limitTxt = self._tf:Find("adapt/shopPage/time/label"):GetComponent(typeof(Text))
	self.pages = {
		[var_0_1] = IslandTradeProductListPage.New(self.pageContainer, self.event),
		[var_0_2] = IslandTradeProductList4SellPage.New(self.pageContainer, self.event),
		[var_0_3] = IslandTradePriceTrendPage.New(self.pageContainer, self.event),
		[var_0_4] = IslandTradeRankPage.New(self.pageContainer, self.event)
	}

	return
end

function IslandTradePage:OnInit()
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		local var_5_0 = ""

		if self.mode == IslandConst.TRADE_PURCHASE then
			var_5_0 = i18n("island_trade_help_1")
		elseif self.mode == IslandConst.TRADE_SELL then
			var_5_0 = i18n("island_trade_help_2")
		end

		assert(var_5_0)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = var_5_0
		})

		return
	end, SFX_PANEL)

	return
end

function IslandTradePage:AddListeners()
	self:AddListener(IslandTradePage.OPEN_INVITE_PAGE, self.OnOpenInvitePage)
	self:AddListener(IslandTradegency.WEEK_NUM_UPDATE, self.OnWeekNumUpdate)
	self:AddListener(IslandTradePage.OPEN_CONFIRM_PAGE, self.OnOpenConfirmPage)
	self:AddListener(GAME.ISLAND_TRADE_DONE, self.OnTradeDone)
	self:AddListener(IslandTradegency.RESET_PRICE, self.OnReset)

	return
end

function IslandTradePage:RemoveListeners()
	self:RemoveListener(IslandTradePage.OPEN_INVITE_PAGE, self.OnOpenInvitePage)
	self:RemoveListener(IslandTradegency.WEEK_NUM_UPDATE, self.OnWeekNumUpdate)
	self:RemoveListener(IslandTradePage.OPEN_CONFIRM_PAGE, self.OnOpenConfirmPage)
	self:RemoveListener(GAME.ISLAND_TRADE_DONE, self.OnTradeDone)
	self:RemoveListener(IslandTradegency.RESET_PRICE, self.OnReset)

	return
end

function IslandTradePage:OnReset()
	self:Hide()
	pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_reset_label"))

	return
end

function IslandTradePage:OnTradeDone()
	self:UpdateResource()
	self:UpdateLimit()

	return
end

function IslandTradePage:OnOpenConfirmPage(arg_10_1)
	local var_10_0 = self:GetIsland()
	local var_10_1 = var_10_0:GetTradeAgency()
	local var_10_2 = 0
	local var_10_3 = 0

	if arg_10_1 == IslandConst.TRADE_PURCHASE then
		var_10_2 = var_10_1:GetTodayPrice()
		var_10_3 = var_10_1:GetCanPurchaseCnt()
	elseif arg_10_1 == IslandConst.TRADE_SELL then
		var_10_2 = var_10_1:GetTodaySellPrice()
		var_10_3 = var_10_1:GetCanSellCnt(var_10_0.id)
	end

	self:ShowMsgBox({
		type = IslandMsgBox.TYPE_TRADE_CONFRIM,
		mode = arg_10_1,
		price = var_10_2,
		maxCnt = var_10_3,
		onYes = function(arg_11_0)
			self:emit(IslandBaseMediator.TRADE_OP, arg_10_1, arg_11_0, var_10_2)

			return
		end
	})

	return
end

function IslandTradePage:OnWeekNumUpdate()
	self:UpdateLimit()

	return
end

function IslandTradePage:OnOpenInvitePage()
	self:OpenPage(IslandTradeInvitePage)

	return
end

function IslandTradePage:OnShow(arg_14_1)
	self.mode = arg_14_1

	self:UpdateResource()
	self:InitPageSwitcher(arg_14_1)
	self:UpdateLabels()
	self:UpdateLimit()
	self:UpdateTitle(arg_14_1)

	return
end

function IslandTradePage:UpdateTitle(arg_15_1)
	if arg_15_1 == IslandTradePage.MODE_SELL then
		setText(self._tf:Find("adapt/toggles/tpl/shop2List/shop2Tpl/selected/name"), i18n("island_trade_sell_sub_label"))
		setText(self._tf:Find("adapt/toggles/tpl/shop1Tg/name"), i18n("island_trade_sell_sub_label"))
		setText(self._tf:Find("adapt/toggles/tpl/shop1Tg/name/en"), "SELL")
		setText(self._tf:Find("adapt/top/title/Text"), i18n("island_trade_title2"))
		setText(self._tf:Find("adapt/shopPage/time/Text"), i18n("island_trade_tip_label2"))
	elseif arg_15_1 == IslandTradePage.MODE_PURCHAS then
		setText(self._tf:Find("adapt/toggles/tpl/shop2List/shop2Tpl/selected/name"), i18n("island_trade_purchase_sub_label"))
		setText(self._tf:Find("adapt/toggles/tpl/shop1Tg/name"), i18n("island_trade_purchase_sub_label"))
		setText(self._tf:Find("adapt/toggles/tpl/shop1Tg/name/en"), "PURCHASE")
		setText(self._tf:Find("adapt/top/title/Text"), i18n("island_trade_title"))
		setText(self._tf:Find("adapt/shopPage/time/Text"), i18n("island_trade_tip_label"))
	end

	return
end

function IslandTradePage:UpdateLabels(arg_16_1)
	local var_16_0 = self:IsSellMode(arg_16_1) and i18n("island_trade_sell_sub_label") or i18n("island_trade_purchase_sub_label")

	setText(self._tf:Find("adapt/toggles/tpl/shop1Tg/name"), var_16_0)
	setText(self._tf:Find("adapt/toggles/tpl/shop2List/shop2Tpl/selected/name"), var_16_0)

	return
end

function IslandTradePage:UpdateResource()
	local var_17_0 = self:GetSelfIsland():GetInventoryAgency()

	self.itemCntTxt.text = var_17_0:GetOwnCount(IslandItem.PEARL_ID)
	self.goldCntTxt.text = var_17_0:GetOwnCount(IslandItem.GOLD_ID)

	return
end

function IslandTradePage:UpdateLimit()
	local var_18_0 = self:GetSelfIsland():GetTradeAgency()

	if self.mode == IslandTradePage.MODE_PURCHAS or self:IsSelfIsland() then
		local var_18_1 = var_18_0:GetWeekNumMax()

		self.limitTxt.text = i18n("island_trade_limit_label", var_18_1 - var_18_0:GetWeekNum() .. "/" .. var_18_1)

		if self.mode == IslandTradePage.MODE_SELL then
			self.limitTxt.text = ""
		end
	elseif self.mode == IslandTradePage.MODE_SELL then
		local var_18_2 = var_18_0:GetSellLimitMax()

		self.limitTxt.text = i18n("island_trade_sell_tip_label", math.max(0, var_18_2 - var_18_0:GetSellLimit(self:GetIsland().id)) .. "/" .. var_18_2)
	end

	return
end

function IslandTradePage:IsSellMode(arg_19_1)
	return arg_19_1 == IslandTradePage.MODE_SELL
end

function IslandTradePage:Page2Name(arg_20_1)
	IslandTradePage.CH_NAMES = IslandTradePage.CH_NAMES or {
		[var_0_1] = i18n("island_trade_purchase_label"),
		[var_0_2] = i18n("island_trade_sell_label"),
		[var_0_3] = i18n("island_trade_trend_label"),
		[var_0_4] = i18n("island_trade_rank_label")
	}

	return IslandTradePage.CH_NAMES[arg_20_1]
end

function IslandTradePage:InitPageSwitcher(arg_21_1)
	local var_21_0 = self:IsSellMode(arg_21_1) and {
		var_0_2,
		var_0_3,
		var_0_4
	} or {
		var_0_1,
		var_0_3,
		var_0_4
	}

	self.pagesUIList:make(function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = var_21_0[arg_22_1 + 1]
			local var_22_1 = self:Page2Name(var_21_0[arg_22_1 + 1])

			setText(arg_22_2:Find("name"), var_22_1)
			setText(arg_22_2:Find("selected/name"), var_22_1)

			local var_22_2 = arg_22_2:GetComponent(typeof(Animation))

			onToggle(self, arg_22_2, function(arg_23_0)
				if arg_23_0 then
					self:SwitchPage(var_22_0)
				end

				if arg_23_0 then
					var_22_2:Play("anim_IslandTradeUI_selected_in")
				else
					var_22_2:Play("anim_IslandTradeUI_selected_out")
				end

				return
			end, SFX_PANEL)

			if arg_22_1 == 0 then
				triggerToggle(arg_22_2, true)
			end
		end

		return
	end)
	self.pagesUIList:align(#var_21_0)

	return
end

function IslandTradePage:SwitchPage(arg_24_1)
	if self.page then
		self.page:ExecuteAction("Hide")
	end

	local var_24_0 = self.pages[arg_24_1]

	self.pages[arg_24_1]:ExecuteAction("Show", self:GetIsland(), self.mode)

	self.page = var_24_0

	return
end

function IslandTradePage:OnHide()
	return
end

function IslandTradePage:OnDestory()
	for iter_26_0, iter_26_1 in pairs(self.pages) do
		iter_26_1:Destroy()
	end

	self.pages = nil

	return
end

return IslandTradePage
