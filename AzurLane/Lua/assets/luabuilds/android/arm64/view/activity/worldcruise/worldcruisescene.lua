local var_0_0 = class("WorldCruiseScene", import("view.base.BaseUI"))

var_0_0.optionsPath = {
	"top/home"
}
var_0_0.PAGE_AWARD = "award"
var_0_0.PAGE_TASK = "task"
var_0_0.PAGE_SHOP = "shop"

local var_0_1 = var_0_0.PAGE_AWARD

function var_0_0.getUIName(arg_1_0)
	return "WorldCruiseUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	local var_2_0 = getProxy(ShopsProxy)

	if getProxy(ShopsProxy):ShouldRefreshChargeList() then
		pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
			callback = function()
				arg_2_0.shop = CruiseShop.New(var_2_0:GetNormalList(), (var_2_0:GetNormalGroupList()))

				var_2_0:SetCruiseShop(arg_2_0.shop)
				arg_2_1()

				return
			end
		})
	else
		(function()
			arg_2_0.shop = CruiseShop.New(var_2_0:GetNormalList(), (var_2_0:GetNormalGroupList()))

			var_2_0:SetCruiseShop(arg_2_0.shop)
			arg_2_1()

			return
		end)()
	end

	return
end

function var_0_0.setShop(arg_4_0, arg_4_1)
	arg_4_0.shop = arg_4_1

	return
end

function var_0_0.setPlayer(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1

	return
end

function var_0_0.setActivity(arg_6_0, arg_6_1)
	arg_6_0.activity = arg_6_1

	for iter_6_0, iter_6_1 in pairs(arg_6_1:GetCrusingInfo()) do
		arg_6_0[iter_6_0] = iter_6_1
	end

	arg_6_0.contextData.phase = arg_6_0.phase

	return
end

function var_0_0.init(arg_7_0)
	arg_7_0.topUI = arg_7_0._tf:Find("top")
	arg_7_0.titleTF = arg_7_0.topUI:Find("title/Text")
	arg_7_0.helpBtn = arg_7_0.topUI:Find("help")
	arg_7_0.gemResBtn = arg_7_0.topUI:Find("res/gem")
	arg_7_0.gemValue = arg_7_0.gemResBtn:Find("Text"):GetComponent(typeof(Text))
	arg_7_0.ticketResBtn = arg_7_0.topUI:Find("res/ticket")
	arg_7_0.ticketValue = arg_7_0.ticketResBtn:Find("Text"):GetComponent(typeof(Text))
	arg_7_0.dayTxt = arg_7_0.topUI:Find("day/Text"):GetComponent(typeof(Text))
	arg_7_0.phaseTF = arg_7_0._tf:Find("frame/phase")

	setText(arg_7_0.phaseTF:Find("progress"), i18n("cruise_phase_title"))

	arg_7_0.pages = {
		[var_0_0.PAGE_AWARD] = WorldCruiseAwardPage.New(arg_7_0._tf:Find("frame/award_container"), arg_7_0.event, arg_7_0.contextData),
		[var_0_0.PAGE_TASK] = WorldCruiseTaskPage.New(arg_7_0._tf:Find("frame/task_container"), arg_7_0.event, arg_7_0.contextData),
		[var_0_0.PAGE_SHOP] = WorldCruiseShopPage.New(arg_7_0._tf:Find("frame/shop_container"), arg_7_0.event, arg_7_0.contextData)
	}
	arg_7_0.togglesTF = arg_7_0._tf:Find("frame/toggles")

	eachChild(arg_7_0.togglesTF, function(arg_8_0)
		onButton(arg_7_0, arg_8_0, function()
			arg_7_0.contextData.page = arg_8_0.name

			arg_7_0:SwitchPage()

			return
		end, SFX_PANEL)

		return
	end)

	local var_7_0 = #arg_7_0.shop:GetCommodities() == 0
	local var_7_1 = arg_7_0.togglesTF:Find("shop")

	if var_7_0 then
		onButton(arg_7_0, var_7_1, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("cruise_shop_no_open"))

			return
		end, SFX_PANEL)
	end

	setActive(var_7_1:Find("lock"), var_7_0)
	setText(var_7_1:Find("lock/Text"), i18n("cruise_shop_no_open"))

	arg_7_0.contextData.windowForCharge = WorldCruiseChargePage.New(arg_7_0._tf, arg_7_0.event)

	arg_7_0:Hx4Channel()

	return
end

function var_0_0.didEnter(arg_11_0)
	LoadImageSpriteAtlasAsync("bg/" .. pg.battlepass_event_pt[arg_11_0.activity.id].bg, "", arg_11_0._tf:Find("bg/bg_1"), true)

	local var_11_0 = arg_11_0._tf:Find("bg/bg_2")

	if pg.battlepass_event_pt[arg_11_0.activity.id].bg_tips ~= "" then
		LoadImageSpriteAtlasAsync("bg/" .. pg.battlepass_event_pt[arg_11_0.activity.id].bg_tips, "", var_11_0, true)
		setActive(var_11_0, true)
	else
		setActive(var_11_0, false)
	end

	onButton(arg_11_0, arg_11_0.topUI:Find("back"), function()
		arg_11_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_11_0, arg_11_0.helpBtn, function()
		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_HELP, {
			helps = i18n("battlepass_main_help_" .. pg.battlepass_event_pt[arg_11_0.activity.id].map_name)
		})

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.gemResBtn, function()
		pg.playerResUI:ClickGem()

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.ticketResBtn, function()
		shoppingBatchNewStyle(Goods.CRUISE_QUICK_TASK_TICKET_ID, {
			id = Item.QUICK_TASK_PASS_TICKET_ID
		}, 20, "build_ship_quickly_buy_stone")

		return
	end, SFX_PANEL)

	local var_11_1 = arg_11_0.activity.stopTime - pg.TimeMgr.GetInstance():GetServerTime()

	arg_11_0.dayTxt.text = i18n("battlepass_main_time_title") .. i18n("battlepass_main_time", math.floor(var_11_1 / 0), math.floor(var_11_1 % 0 / 16))

	arg_11_0:UpdateRes()
	arg_11_0:UpdatePhase()
	arg_11_0:UpdateAwardTip()
	triggerButton(arg_11_0.togglesTF:Find(var_11_2))

	return
end

function var_0_0.UpdateRes(arg_16_0)
	arg_16_0.gemValue.text = arg_16_0.player:getTotalGem()
	arg_16_0.ticketValue.text = getProxy(BagProxy):getItemCountById(Item.QUICK_TASK_PASS_TICKET_ID)

	return
end

function var_0_0.UpdatePhase(arg_17_0)
	setText(arg_17_0.phaseTF:Find("Text"), "<size=27>lv.</size>" .. arg_17_0.phase)

	if arg_17_0.phase < #arg_17_0.awardList then
		local var_17_0 = arg_17_0.pt - (arg_17_0.phase == 0 and 0 or arg_17_0.awardList[arg_17_0.phase].pt)

		setSlider(arg_17_0.phaseTF:Find("slider"), 0, arg_17_0.awardList[arg_17_0.phase + 1].pt - (arg_17_0.phase == 0 and 0 or arg_17_0.awardList[arg_17_0.phase].pt), arg_17_0.pt - (arg_17_0.phase == 0 and 0 or arg_17_0.awardList[arg_17_0.phase].pt))
		setText(arg_17_0.phaseTF:Find("progress/Text"), var_17_0 .. "/" .. arg_17_0.awardList[arg_17_0.phase + 1].pt - (arg_17_0.phase == 0 and 0 or arg_17_0.awardList[arg_17_0.phase].pt))
	else
		setSlider(arg_17_0.phaseTF:Find("slider"), 0, 1, 1)
		setText(arg_17_0.phaseTF:Find("progress/Text"), "MAX")
	end

	arg_17_0.contextData.phase = arg_17_0.phase

	return
end

function var_0_0.OnChargeSuccess(arg_18_0, arg_18_1)
	arg_18_0.contextData.windowForCharge:ExecuteAction("ShowUnlockWindow", arg_18_1)

	return
end

function var_0_0.UpdateAwardTip(arg_19_0)
	setActive(arg_19_0.togglesTF:Find("award/tip"), #arg_19_0.activity:GetCrusingUnreceiveAward() > 0)

	return
end

function var_0_0.SwitchPage(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.pages) do
		if iter_20_0 == arg_20_0.contextData.page then
			iter_20_1:ExecuteAction("Flush")
		else
			iter_20_1:ExecuteAction("Hide")
		end
	end

	eachChild(arg_20_0.togglesTF, function(arg_21_0)
		setActive(arg_21_0:Find("unselected"), arg_21_0.name ~= arg_20_0.contextData.page)
		setActive(arg_21_0:Find("selected"), arg_21_0.name == arg_20_0.contextData.page)

		return
	end)

	local var_20_0 = arg_20_0.contextData.page == var_0_0.PAGE_SHOP

	setActive(arg_20_0._tf:Find("shop_bg"), arg_20_0.contextData.page == var_0_0.PAGE_SHOP)
	setActive(arg_20_0.phaseTF, not var_20_0)

	local var_20_1 = var_20_0 and i18n("cruise_shop_title") or i18n("cruise_title_" .. pg.battlepass_event_pt[arg_20_0.activity.id].map_name)

	setText(arg_20_0.titleTF, var_20_1)

	return
end

function var_0_0.UpdateView(arg_22_0)
	arg_22_0.pages[arg_22_0.contextData.page]:ExecuteAction("Flush")

	return
end

function var_0_0.UpdateAwardPage(arg_23_0)
	arg_23_0:UpdateAwardTip()
	arg_23_0.pages[var_0_0.PAGE_AWARD]:ExecuteAction("UpdateActivity", arg_23_0.activity)

	return
end

function var_0_0.UpdateTaskPage(arg_24_0)
	arg_24_0.pages[var_0_0.PAGE_TASK]:ExecuteAction("UpdateActivity", arg_24_0.activity)

	return
end

function var_0_0.UpdateShopPage(arg_25_0)
	arg_25_0.pages[var_0_0.PAGE_SHOP]:ExecuteAction("UpdateShop", arg_25_0.shop)
	arg_25_0:UpdateView()

	return
end

function var_0_0.onBackPressed(arg_26_0)
	if arg_26_0.contextData.windowForCharge and arg_26_0.contextData.windowForCharge:GetLoaded() and arg_26_0.contextData.windowForCharge:isShowing() then
		arg_26_0.contextData.windowForCharge:Hide()

		return
	end

	var_0_0.super.onBackPressed(arg_26_0)

	return
end

function var_0_0.willExit(arg_27_0)
	if arg_27_0.contextData.windowForCharge then
		arg_27_0.contextData.windowForCharge:Destroy()

		arg_27_0.contextData.windowForCharge = nil
	end

	for iter_27_0, iter_27_1 in pairs(arg_27_0.pages) do
		iter_27_1:Destroy()

		iter_27_1 = nil
	end

	return
end

local function var_0_2(arg_28_0)
	return (arg_28_0._tf:Find("bg/bg_1/hx_ch" .. pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony()))
end

function var_0_0.Hx4Channel(arg_29_0)
	local var_29_0 = var_0_2(arg_29_0)

	if not IsNil(var_29_0) then
		setActive(var_29_0, HXSet.isHx())
	end

	return
end

return var_0_0
