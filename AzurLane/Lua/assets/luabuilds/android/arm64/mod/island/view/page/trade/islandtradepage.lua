local var_0_0 = class("IslandTradePage", import("...base.IslandBasePage"))

var_0_0.OPEN_INVITE_PAGE = "IslandTradePage:OPEN_INVITE_PAGE"
var_0_0.OPEN_CONFIRM_PAGE = "IslandTradePage:OPEN_CONFIRM_PAGE"
var_0_0.MODE_SELL = 1
var_0_0.MODE_PURCHAS = 2

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4

function var_0_0.getUIName(arg_1_0)
	return "IslandTradeUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("adapt/top/closeBtn")
	arg_2_0.helpBtn = arg_2_0._tf:Find("adapt/top/help")
	arg_2_0.itemCntTxt = arg_2_0._tf:Find("adapt/shopPage/res/9900/Text"):GetComponent(typeof(Text))
	arg_2_0.goldCntTxt = arg_2_0._tf:Find("adapt/shopPage/res/1/Text"):GetComponent(typeof(Text))
	arg_2_0.pageContainer = arg_2_0._tf:Find("adapt/shopPage")
	arg_2_0.pagesUIList = UIItemList.New(arg_2_0._tf:Find("adapt/tags"), arg_2_0._tf:Find("adapt/tags/1"))
	arg_2_0.limitTxt = arg_2_0._tf:Find("adapt/shopPage/time/label"):GetComponent(typeof(Text))
	arg_2_0.pages = {
		[var_0_1] = IslandTradeProductListPage.New(arg_2_0.pageContainer, arg_2_0.event),
		[var_0_2] = IslandTradeProductList4SellPage.New(arg_2_0.pageContainer, arg_2_0.event),
		[var_0_3] = IslandTradePriceTrendPage.New(arg_2_0.pageContainer, arg_2_0.event),
		[var_0_4] = IslandTradeRankPage.New(arg_2_0.pageContainer, arg_2_0.event)
	}

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.helpBtn, function()
		local var_5_0 = ""

		if arg_3_0.mode == IslandConst.TRADE_PURCHASE then
			var_5_0 = i18n("island_trade_help_1")
		elseif arg_3_0.mode == IslandConst.TRADE_SELL then
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

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddListener(var_0_0.OPEN_INVITE_PAGE, arg_6_0.OnOpenInvitePage)
	arg_6_0:AddListener(IslandTradegency.WEEK_NUM_UPDATE, arg_6_0.OnWeekNumUpdate)
	arg_6_0:AddListener(var_0_0.OPEN_CONFIRM_PAGE, arg_6_0.OnOpenConfirmPage)
	arg_6_0:AddListener(GAME.ISLAND_TRADE_DONE, arg_6_0.OnTradeDone)
	arg_6_0:AddListener(IslandTradegency.RESET_PRICE, arg_6_0.OnReset)

	return
end

function var_0_0.RemoveListeners(arg_7_0)
	arg_7_0:RemoveListener(var_0_0.OPEN_INVITE_PAGE, arg_7_0.OnOpenInvitePage)
	arg_7_0:RemoveListener(IslandTradegency.WEEK_NUM_UPDATE, arg_7_0.OnWeekNumUpdate)
	arg_7_0:RemoveListener(var_0_0.OPEN_CONFIRM_PAGE, arg_7_0.OnOpenConfirmPage)
	arg_7_0:RemoveListener(GAME.ISLAND_TRADE_DONE, arg_7_0.OnTradeDone)
	arg_7_0:RemoveListener(IslandTradegency.RESET_PRICE, arg_7_0.OnReset)

	return
end

function var_0_0.OnReset(arg_8_0)
	arg_8_0:Hide()
	pg.TipsMgr.GetInstance():ShowTips(i18n("island_trade_reset_label"))

	return
end

function var_0_0.OnTradeDone(arg_9_0)
	arg_9_0:UpdateResource()
	arg_9_0:UpdateLimit()

	return
end

function var_0_0.OnOpenConfirmPage(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:GetIsland()
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

	arg_10_0:ShowMsgBox({
		type = IslandMsgBox.TYPE_TRADE_CONFRIM,
		mode = arg_10_1,
		price = var_10_2,
		maxCnt = var_10_3,
		onYes = function(arg_11_0)
			arg_10_0:emit(IslandBaseMediator.TRADE_OP, arg_10_1, arg_11_0, var_10_2)

			return
		end
	})

	return
end

function var_0_0.OnWeekNumUpdate(arg_12_0)
	arg_12_0:UpdateLimit()

	return
end

function var_0_0.OnOpenInvitePage(arg_13_0)
	arg_13_0:OpenPage(IslandTradeInvitePage)

	return
end

function var_0_0.OnShow(arg_14_0, arg_14_1)
	arg_14_0.mode = arg_14_1

	arg_14_0:UpdateResource()
	arg_14_0:InitPageSwitcher(arg_14_1)
	arg_14_0:UpdateLabels()
	arg_14_0:UpdateLimit()
	arg_14_0:UpdateTitle(arg_14_1)

	return
end

function var_0_0.UpdateTitle(arg_15_0, arg_15_1)
	if arg_15_1 == var_0_0.MODE_SELL then
		setText(arg_15_0._tf:Find("adapt/toggles/tpl/shop2List/shop2Tpl/selected/name"), i18n("island_trade_sell_sub_label"))
		setText(arg_15_0._tf:Find("adapt/toggles/tpl/shop1Tg/name"), i18n("island_trade_sell_sub_label"))
		setText(arg_15_0._tf:Find("adapt/toggles/tpl/shop1Tg/name/en"), "SELL")
		setText(arg_15_0._tf:Find("adapt/top/title/Text"), i18n("island_trade_title2"))
		setText(arg_15_0._tf:Find("adapt/shopPage/time/Text"), i18n("island_trade_tip_label2"))
	elseif arg_15_1 == var_0_0.MODE_PURCHAS then
		setText(arg_15_0._tf:Find("adapt/toggles/tpl/shop2List/shop2Tpl/selected/name"), i18n("island_trade_purchase_sub_label"))
		setText(arg_15_0._tf:Find("adapt/toggles/tpl/shop1Tg/name"), i18n("island_trade_purchase_sub_label"))
		setText(arg_15_0._tf:Find("adapt/toggles/tpl/shop1Tg/name/en"), "PURCHASE")
		setText(arg_15_0._tf:Find("adapt/top/title/Text"), i18n("island_trade_title"))
		setText(arg_15_0._tf:Find("adapt/shopPage/time/Text"), i18n("island_trade_tip_label"))
	end

	return
end

function var_0_0.UpdateLabels(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:IsSellMode(arg_16_1) and i18n("island_trade_sell_sub_label") or i18n("island_trade_purchase_sub_label")

	setText(arg_16_0._tf:Find("adapt/toggles/tpl/shop1Tg/name"), var_16_0)
	setText(arg_16_0._tf:Find("adapt/toggles/tpl/shop2List/shop2Tpl/selected/name"), var_16_0)

	return
end

function var_0_0.UpdateResource(arg_17_0)
	local var_17_0 = arg_17_0:GetSelfIsland():GetInventoryAgency()

	arg_17_0.itemCntTxt.text = var_17_0:GetOwnCount(IslandItem.PEARL_ID)
	arg_17_0.goldCntTxt.text = var_17_0:GetOwnCount(IslandItem.GOLD_ID)

	return
end

function var_0_0.UpdateLimit(arg_18_0)
	local var_18_0 = arg_18_0:GetSelfIsland():GetTradeAgency()

	if arg_18_0.mode == var_0_0.MODE_PURCHAS or arg_18_0:IsSelfIsland() then
		local var_18_1 = var_18_0:GetWeekNumMax()

		arg_18_0.limitTxt.text = i18n("island_trade_limit_label", var_18_1 - var_18_0:GetWeekNum() .. "/" .. var_18_1)

		if arg_18_0.mode == var_0_0.MODE_SELL then
			arg_18_0.limitTxt.text = ""
		end
	elseif arg_18_0.mode == var_0_0.MODE_SELL then
		local var_18_2 = var_18_0:GetSellLimitMax()

		arg_18_0.limitTxt.text = i18n("island_trade_sell_tip_label", math.max(0, var_18_2 - var_18_0:GetSellLimit(arg_18_0:GetIsland().id)) .. "/" .. var_18_2)
	end

	return
end

function var_0_0.IsSellMode(arg_19_0, arg_19_1)
	return arg_19_1 == var_0_0.MODE_SELL
end

function var_0_0.Page2Name(arg_20_0, arg_20_1)
	var_0_0.CH_NAMES = var_0_0.CH_NAMES or {
		[var_0_1] = i18n("island_trade_purchase_label"),
		[var_0_2] = i18n("island_trade_sell_label"),
		[var_0_3] = i18n("island_trade_trend_label"),
		[var_0_4] = i18n("island_trade_rank_label")
	}

	return var_0_0.CH_NAMES[arg_20_1]
end

function var_0_0.InitPageSwitcher(arg_21_0, arg_21_1)
	if arg_21_0:IsSellMode(arg_21_1) then
		local var_21_0 = {
			var_0_2,
			var_0_3,
			var_0_4
		}

		if not {
			var_0_2,
			var_0_3,
			var_0_4
		} then
			var_21_0 = {
				var_0_1,
				var_0_3,
				var_0_4
			}
		end

		arg_21_0.pagesUIList:make(function(arg_22_0, arg_22_1, arg_22_2)
			if arg_22_0 == UIItemList.EventUpdate then
				local var_22_0 = arg_21_0:Page2Name(var_21_0[arg_22_1 + 1])

				setText(arg_22_2:Find("name"), var_22_0)
				setText(arg_22_2:Find("selected/name"), var_22_0)

				local var_22_1 = arg_22_2:GetComponent(typeof(Animation))

				onToggle(arg_21_0, arg_22_2, function(arg_23_0)
					if arg_23_0 then
						arg_21_0:SwitchPage(var_0)
					end

					if arg_23_0 then
						var_22_1:Play("anim_IslandTradeUI_selected_in")
					else
						var_22_1:Play("anim_IslandTradeUI_selected_out")
					end

					return
				end, SFX_PANEL)

				if arg_22_1 == 0 then
					triggerToggle(arg_22_2, true)
				end
			end

			return
		end)
		arg_21_0.pagesUIList:align(#var_21_0)

		return
	end
end

function var_0_0.SwitchPage(arg_24_0, arg_24_1)
	if arg_24_0.page then
		arg_24_0.page:ExecuteAction("Hide")
	end

	local var_24_0 = arg_24_0.pages[arg_24_1]

	arg_24_0.pages[arg_24_1]:ExecuteAction("Show", arg_24_0:GetIsland(), arg_24_0.mode)

	arg_24_0.page = var_24_0

	return
end

function var_0_0.OnHide(arg_25_0)
	return
end

function var_0_0.OnDestory(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.pages) do
		iter_26_1:Destroy()
	end

	arg_26_0.pages = nil

	return
end

return var_0_0
