class = var_0_10000

local var_0_0 = "IslandTradePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

var_0_1.OPEN_INVITE_PAGE = "IslandTradePage:OPEN_INVITE_PAGE"
var_0_1.OPEN_CONFIRM_PAGE = "IslandTradePage:OPEN_CONFIRM_PAGE"
var_0_1.MODE_SELL = 1
var_0_1.MODE_PURCHAS = 2

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4

function var_0_1.getUIName(arg_1_0)
	return "IslandTradeUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "adapt/top/closeBtn")

	local var_2_1 = arg_2_0._tf

	arg_2_0.helpBtn = var_1.Find(var_2_1, "adapt/top/help")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "adapt/shopPage/res/9900/Text")
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.itemCntTxt = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "adapt/shopPage/res/1/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.goldCntTxt = var_2_7(var_2_6, var_3(var_1_10004))

	local var_2_8 = arg_2_0._tf

	arg_2_0.pageContainer = var_1.Find(var_2_8, "adapt/shopPage")
	UIItemList = var_1

	local var_2_9 = var_1.New
	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "adapt/tags")
	local var_2_12 = arg_2_0._tf

	arg_2_0.pagesUIList = var_2_9(var_2_11, var_3.Find(var_2_12, "adapt/tags/1"))

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_1.Find(var_2_13, "adapt/shopPage/time/label")
	local var_2_15 = var_1.GetComponent

	typeof = var_3
	Text = var_2_12
	arg_2_0.limitTxt = var_2_15(var_2_14, var_3(var_2_12))

	local var_2_16 = {}
	local var_2_17 = var_0_2

	IslandTradeProductListPage = var_3
	var_2_16[var_2_17] = var_3.New(arg_2_0.pageContainer, arg_2_0.event)

	local var_2_18 = var_0_3

	IslandTradeProductList4SellPage = var_3
	var_2_16[var_2_18] = var_3.New(arg_2_0.pageContainer, arg_2_0.event)

	local var_2_19 = var_0_4

	IslandTradePriceTrendPage = var_3
	var_2_16[var_2_19] = var_3.New(arg_2_0.pageContainer, arg_2_0.event)

	local var_2_20 = var_0_5

	IslandTradeRankPage = var_3
	var_2_16[var_2_20] = var_3.New(arg_2_0.pageContainer, arg_2_0.event)
	arg_2_0.pages = var_2_16

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.helpBtn

	local function var_3_5()
		local var_5_0 = arg_3_0.mode
		local var_5_1 = ""

		IslandConst = var_2_10002

		if var_5_0 == var_2_10002.TRADE_PURCHASE then
			i18n = var_2
			var_5_1 = var_2("island_trade_help_1")
		else
			IslandConst = var_2

			if var_5_0 == var_2.TRADE_SELL then
				i18n = var_2
				var_5_1 = var_2("island_trade_help_2")
			end
		end

		assert = var_2

		var_2(var_5_1)

		pg = var_2

		local var_5_2 = var_2.MsgboxMgr.GetInstance()
		local var_5_3 = var_2.ShowMsgBox
		local var_5_4 = {}

		MSGBOX_TYPE_HELP = var_2_10005
		var_5_4.type = var_2_10005
		var_5_4.helps = var_5_1

		var_5_3(var_5_2, var_5_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	return
end

function var_0_1.AddListeners(arg_6_0)
	arg_6_0:AddListener(var_0_1.OPEN_INVITE_PAGE, arg_6_0.OnOpenInvitePage)

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.AddListener

	IslandTradegency = var_3

	var_6_1(var_6_0, var_3.WEEK_NUM_UPDATE, arg_6_0.OnWeekNumUpdate)
	arg_6_0:AddListener(var_0_1.OPEN_CONFIRM_PAGE, arg_6_0.OnOpenConfirmPage)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.AddListener

	GAME = var_3

	var_6_3(var_6_2, var_3.ISLAND_TRADE_DONE, arg_6_0.OnTradeDone)

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.AddListener

	IslandTradegency = var_3

	var_6_5(var_6_4, var_3.RESET_PRICE, arg_6_0.OnReset)

	return
end

function var_0_1.RemoveListeners(arg_7_0)
	arg_7_0:RemoveListener(var_0_1.OPEN_INVITE_PAGE, arg_7_0.OnOpenInvitePage)

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.RemoveListener

	IslandTradegency = var_3

	var_7_1(var_7_0, var_3.WEEK_NUM_UPDATE, arg_7_0.OnWeekNumUpdate)
	arg_7_0:RemoveListener(var_0_1.OPEN_CONFIRM_PAGE, arg_7_0.OnOpenConfirmPage)

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.RemoveListener

	GAME = var_3

	var_7_3(var_7_2, var_3.ISLAND_TRADE_DONE, arg_7_0.OnTradeDone)

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.RemoveListener

	IslandTradegency = var_3

	var_7_5(var_7_4, var_3.RESET_PRICE, arg_7_0.OnReset)

	return
end

function var_0_1.OnReset(arg_8_0)
	arg_8_0:Hide()

	pg = var_1

	local var_8_0 = var_1.TipsMgr.GetInstance()
	local var_8_1 = var_1.ShowTips

	i18n = var_1_10003

	var_8_1(var_8_0, var_1_10003("island_trade_reset_label"))

	return
end

function var_0_1.OnTradeDone(arg_9_0)
	arg_9_0:UpdateResource()
	arg_9_0:UpdateLimit()

	return
end

function var_0_1.OnOpenConfirmPage(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:GetIsland()
	local var_10_1 = var_2.GetTradeAgency(var_10_0)
	local var_10_2 = 0
	local var_10_3 = 0

	IslandConst = var_1_10006

	if arg_10_1 == var_1_10006.TRADE_PURCHASE then
		var_10_2 = var_10_1:GetTodayPrice()
		var_10_3 = var_10_1:GetCanPurchaseCnt()
	else
		IslandConst = var_6

		if arg_10_1 == var_6.TRADE_SELL then
			var_10_2 = var_10_1:GetTodaySellPrice()
			var_10_3 = var_10_1:GetCanSellCnt(var_2.id)
		end
	end

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.ShowMsgBox
	local var_10_6 = {}

	IslandMsgBox = var_1_10009
	var_10_6.type = var_1_10009.TYPE_TRADE_CONFRIM
	var_10_6.mode = arg_10_1
	var_10_6.price = var_10_2
	var_10_6.maxCnt = var_10_3

	function var_10_6.onYes(arg_11_0)
		local var_11_0 = arg_10_0
		local var_11_1 = var_1.emit

		IslandBaseMediator = var_2_10003

		var_11_1(var_11_0, var_2_10003.TRADE_OP, arg_10_1, arg_11_0, var_10_2)

		return
	end

	var_10_5(var_10_4, var_10_6)

	return
end

function var_0_1.OnWeekNumUpdate(arg_12_0)
	arg_12_0:UpdateLimit()

	return
end

function var_0_1.OnOpenInvitePage(arg_13_0)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.OpenPage

	IslandTradeInvitePage = var_1_10003

	var_13_1(var_13_0, var_1_10003)

	return
end

function var_0_1.OnShow(arg_14_0, arg_14_1)
	arg_14_0.mode = arg_14_1

	arg_14_0:UpdateResource()
	arg_14_0:InitPageSwitcher(arg_14_1)
	arg_14_0:UpdateLabels()
	arg_14_0:UpdateLimit()
	arg_14_0:UpdateTitle(arg_14_1)

	return
end

function var_0_1.UpdateTitle(arg_15_0, arg_15_1)
	if arg_15_1 == var_0_1.MODE_SELL then
		setText = var_2

		local var_15_0 = arg_15_0._tf
		local var_15_1 = var_3.Find(var_15_0, "adapt/toggles/tpl/shop2List/shop2Tpl/selected/name")

		i18n = var_15_0

		var_2(var_15_1, var_15_0("island_trade_sell_sub_label"))

		setText = var_2

		local var_15_2 = arg_15_0._tf
		local var_15_3 = var_3.Find(var_15_2, "adapt/toggles/tpl/shop1Tg/name")

		i18n = var_15_2

		var_2(var_15_3, var_15_2("island_trade_sell_sub_label"))

		setText = var_2

		local var_15_4 = arg_15_0._tf

		var_2(var_3.Find(var_15_4, "adapt/toggles/tpl/shop1Tg/name/en"), "SELL")

		setText = var_2

		local var_15_5 = arg_15_0._tf
		local var_15_6 = var_3.Find(var_15_5, "adapt/top/title/Text")

		i18n = var_15_5

		var_2(var_15_6, var_15_5("island_trade_title2"))

		setText = var_2

		local var_15_7 = arg_15_0._tf
		local var_15_8 = var_3.Find(var_15_7, "adapt/shopPage/time/Text")

		i18n = var_15_7

		var_2(var_15_8, var_15_7("island_trade_tip_label2"))
	elseif arg_15_1 == var_0_1.MODE_PURCHAS then
		setText = var_2

		local var_15_9 = arg_15_0._tf
		local var_15_10 = var_3.Find(var_15_9, "adapt/toggles/tpl/shop2List/shop2Tpl/selected/name")

		i18n = var_15_9

		var_2(var_15_10, var_15_9("island_trade_purchase_sub_label"))

		setText = var_2

		local var_15_11 = arg_15_0._tf
		local var_15_12 = var_3.Find(var_15_11, "adapt/toggles/tpl/shop1Tg/name")

		i18n = var_15_11

		var_2(var_15_12, var_15_11("island_trade_purchase_sub_label"))

		setText = var_2

		local var_15_13 = arg_15_0._tf

		var_2(var_3.Find(var_15_13, "adapt/toggles/tpl/shop1Tg/name/en"), "PURCHASE")

		setText = var_2

		local var_15_14 = arg_15_0._tf
		local var_15_15 = var_3.Find(var_15_14, "adapt/top/title/Text")

		i18n = var_15_14

		var_2(var_15_15, var_15_14("island_trade_title"))

		setText = var_2

		local var_15_16 = arg_15_0._tf
		local var_15_17 = var_3.Find(var_15_16, "adapt/shopPage/time/Text")

		i18n = var_15_16

		var_2(var_15_17, var_15_16("island_trade_tip_label"))
	end

	return
end

function var_0_1.UpdateLabels(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0

	if arg_16_0.IsSellMode(var_16_0, arg_16_1) then
		i18n = var_16_1

		local var_16_1

		if not var_16_1("island_trade_sell_sub_label") then
			i18n = var_16_1
			var_16_1 = var_16_1("island_trade_purchase_sub_label")
		end

		setText = var_16_0

		local var_16_2 = arg_16_0._tf

		var_16_0(var_4.Find(var_16_2, "adapt/toggles/tpl/shop1Tg/name"), var_16_1)

		setText = var_16_0

		local var_16_3 = arg_16_0._tf

		var_16_0(var_4.Find(var_16_3, "adapt/toggles/tpl/shop2List/shop2Tpl/selected/name"), var_16_1)

		return
	end
end

function var_0_1.UpdateResource(arg_17_0)
	local var_17_0 = arg_17_0:GetSelfIsland()
	local var_17_1 = var_1.GetInventoryAgency(var_17_0)
	local var_17_2 = arg_17_0.itemCntTxt
	local var_17_3 = var_17_1
	local var_17_4 = var_17_1.GetOwnCount

	IslandItem = var_1_10006
	var_17_2.text = var_17_4(var_17_3, var_1_10006.PEARL_ID)

	local var_17_5 = arg_17_0.goldCntTxt
	local var_17_6 = var_17_1
	local var_17_7 = var_17_1.GetOwnCount

	IslandItem = var_6
	var_17_5.text = var_17_7(var_17_6, var_6.GOLD_ID)

	return
end

function var_0_1.UpdateLimit(arg_18_0)
	local var_18_0 = arg_18_0:GetSelfIsland()
	local var_18_1 = var_1.GetTradeAgency(var_18_0)

	if arg_18_0.mode == var_0_1.MODE_PURCHAS or arg_18_0:IsSelfIsland() then
		local var_18_2 = var_18_1:GetWeekNumMax()
		local var_18_3 = arg_18_0.limitTxt

		i18n = var_1_10005
		var_18_3.text = var_1_10005("island_trade_limit_label", var_18_2 - var_18_1:GetWeekNum() .. "/" .. var_18_2)

		if arg_18_0.mode == var_0_1.MODE_SELL then
			arg_18_0.limitTxt.text = ""
		end
	elseif arg_18_0.mode == var_0_1.MODE_SELL then
		local var_18_4 = arg_18_0:GetIsland()
		local var_18_5 = var_18_1:GetSellLimit(var_18_4.id)
		local var_18_6 = var_18_1:GetSellLimitMax()
		local var_18_7 = arg_18_0.limitTxt

		i18n = var_1_10007

		local var_18_8 = "island_trade_sell_tip_label"

		math = var_1_10009
		var_18_7.text = var_1_10007(var_18_8, var_1_10009.max(0, var_18_6 - var_18_5) .. "/" .. var_18_6)
	end

	return
end

function var_0_1.IsSellMode(arg_19_0, arg_19_1)
	return arg_19_1 == var_0_1.MODE_SELL
end

function var_0_1.Page2Name(arg_20_0, arg_20_1)
	if not var_0_1.CH_NAMES then
		local var_20_0 = var_0_1
		local var_20_1 = {}
		local var_20_2 = var_0_2

		i18n = var_1_10005
		var_20_1[var_20_2] = var_1_10005("island_trade_purchase_label")

		local var_20_3 = var_0_3

		i18n = var_5
		var_20_1[var_20_3] = var_5("island_trade_sell_label")

		local var_20_4 = var_0_4

		i18n = var_5
		var_20_1[var_20_4] = var_5("island_trade_trend_label")

		local var_20_5 = var_0_5

		i18n = var_5
		var_20_1[var_20_5] = var_5("island_trade_rank_label")
		var_20_0.CH_NAMES = var_20_1
	end

	return var_0_1.CH_NAMES[arg_20_1]
end

function var_0_1.InitPageSwitcher(arg_21_0, arg_21_1)
	local var_21_0

	if not arg_21_0:IsSellMode(arg_21_1) or not {
		var_0_3,
		var_0_4,
		var_0_5
	} then
		var_21_0 = {
			var_0_2,
			var_0_4,
			var_0_5
		}
	end

	local var_21_1 = arg_21_0.pagesUIList

	var_3.make(var_21_1, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			local var_22_0 = var_21_0[arg_22_1 + 1]
			local var_22_1 = arg_21_0
			local var_22_2 = var_4.Page2Name(var_22_1, var_22_0)

			setText = var_22_1

			var_22_1(arg_22_2:Find("name"), var_22_2)

			setText = var_22_1

			var_22_1(arg_22_2:Find("selected/name"), var_22_2)

			local var_22_3 = arg_22_2
			local var_22_4 = arg_22_2.GetComponent

			typeof = var_7
			Animation = var_8

			local var_22_5 = var_22_4(var_22_3, var_7(var_8))

			onToggle = var_22_3

			local var_22_6 = arg_21_0
			local var_22_7 = arg_22_2

			local function var_22_8(arg_23_0)
				if arg_23_0 then
					local var_23_0 = arg_21_0

					var_1.SwitchPage(var_23_0, var_22_0)
				end

				if arg_23_0 then
					local var_23_1 = var_22_5

					var_1.Play(var_23_1, "anim_IslandTradeUI_selected_in")
				else
					local var_23_2 = var_22_5

					var_1.Play(var_23_2, "anim_IslandTradeUI_selected_out")
				end

				return
			end

			SFX_PANEL = var_2_10010

			var_22_3(var_22_6, var_22_7, var_22_8, var_2_10010)

			if arg_22_1 == 0 then
				triggerToggle = var_22_3

				var_22_3(arg_22_2, true)
			end
		end

		return
	end)

	local var_21_2 = arg_21_0.pagesUIList

	var_3.align(var_21_2, #var_21_0)

	return
end

function var_0_1.SwitchPage(arg_24_0, arg_24_1)
	if arg_24_0.page then
		local var_24_0 = arg_24_0.page

		var_2.ExecuteAction(var_24_0, "Hide")
	end

	local var_24_1 = arg_24_0.pages[arg_24_1]

	var_2.ExecuteAction(var_24_1, "Show", arg_24_0:GetIsland(), arg_24_0.mode)

	arg_24_0.page = var_2

	return
end

function var_0_1.OnHide(arg_25_0)
	return
end

function var_0_1.OnDestory(arg_26_0)
	pairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001(arg_26_0.pages) do
		iter_26_1:Destroy()
	end

	arg_26_0.pages = nil

	return
end

return var_0_1
