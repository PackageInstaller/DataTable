class = var_0_10000

local var_0_0 = "WorldCruiseScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

var_0_1.optionsPath = {
	"top/home"
}
var_0_1.PAGE_AWARD = "award"
var_0_1.PAGE_TASK = "task"
var_0_1.PAGE_SHOP = "shop"

local var_0_2 = var_0_1.PAGE_AWARD

function var_0_1.getUIName(arg_1_0)
	return "WorldCruiseUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ShopsProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)

	local function var_2_1()
		local var_3_0 = var_2_0
		local var_3_1 = var_0.GetNormalList(var_3_0)
		local var_3_2 = var_2_0
		local var_3_3 = var_1.GetNormalGroupList(var_3_2)
		local var_3_4 = arg_2_0

		CruiseShop = var_3_2
		var_3_4.shop = var_3_2.New(var_3_1, var_3_3)

		local var_3_5 = var_2_0

		var_2.SetCruiseShop(var_3_5, arg_2_0.shop)
		arg_2_1()

		return
	end

	if var_2_0:ShouldRefreshChargeList() then
		pg = var_4

		local var_2_2 = var_4.m02
		local var_2_3 = var_4.sendNotification

		GAME = var_1_10007

		var_2_3(var_2_2, var_1_10007.GET_CHARGE_LIST, {
			callback = var_2_1
		})
	else
		var_2_1()
	end

	return
end

function var_0_1.setShop(arg_4_0, arg_4_1)
	arg_4_0.shop = arg_4_1

	return
end

function var_0_1.setPlayer(arg_5_0, arg_5_1)
	arg_5_0.player = arg_5_1

	return
end

function var_0_1.setActivity(arg_6_0, arg_6_1)
	arg_6_0.activity = arg_6_1
	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_1:GetCrusingInfo()) do
		arg_6_0[iter_6_0] = iter_6_1
	end

	arg_6_0.contextData.phase = arg_6_0.phase

	return
end

function var_0_1.init(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.topUI = var_1.Find(var_7_0, "top")

	local var_7_1 = arg_7_0.topUI

	arg_7_0.titleTF = var_1.Find(var_7_1, "title/Text")

	local var_7_2 = arg_7_0.topUI

	arg_7_0.helpBtn = var_1.Find(var_7_2, "help")

	local var_7_3 = arg_7_0.topUI

	arg_7_0.gemResBtn = var_1.Find(var_7_3, "res/gem")

	local var_7_4 = arg_7_0.gemResBtn
	local var_7_5 = var_1.Find(var_7_4, "Text")
	local var_7_6 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_7_0.gemValue = var_7_6(var_7_5, var_4(var_1_10006))

	local var_7_7 = arg_7_0.topUI

	arg_7_0.ticketResBtn = var_1.Find(var_7_7, "res/ticket")

	local var_7_8 = arg_7_0.ticketResBtn
	local var_7_9 = var_1.Find(var_7_8, "Text")
	local var_7_10 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_7_0.ticketValue = var_7_10(var_7_9, var_4(var_1_10006))

	local var_7_11 = arg_7_0.topUI
	local var_7_12 = var_1.Find(var_7_11, "day/Text")
	local var_7_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_7_0.dayTxt = var_7_13(var_7_12, var_4(var_1_10006))

	local var_7_14 = arg_7_0._tf

	arg_7_0.phaseTF = var_1.Find(var_7_14, "frame/phase")
	setText = var_1

	local var_7_15 = arg_7_0.phaseTF
	local var_7_16 = var_3.Find(var_7_15, "progress")

	i18n = var_4

	var_1(var_7_16, var_4("cruise_phase_title"))

	local var_7_17 = {}
	local var_7_18 = var_0_1.PAGE_AWARD

	WorldCruiseAwardPage = var_7_16

	local var_7_19 = var_7_16.New
	local var_7_20 = arg_7_0._tf

	var_7_17[var_7_18] = var_7_19(var_5.Find(var_7_20, "frame/award_container"), arg_7_0.event, arg_7_0.contextData)

	local var_7_21 = var_0_1.PAGE_TASK

	WorldCruiseTaskPage = var_3

	local var_7_22 = var_3.New
	local var_7_23 = arg_7_0._tf

	var_7_17[var_7_21] = var_7_22(var_5.Find(var_7_23, "frame/task_container"), arg_7_0.event, arg_7_0.contextData)

	local var_7_24 = var_0_1.PAGE_SHOP

	WorldCruiseShopPage = var_3

	local var_7_25 = var_3.New
	local var_7_26 = arg_7_0._tf

	var_7_17[var_7_24] = var_7_25(var_5.Find(var_7_26, "frame/shop_container"), arg_7_0.event, arg_7_0.contextData)
	arg_7_0.pages = var_7_17

	local var_7_27 = arg_7_0._tf

	arg_7_0.togglesTF = var_1.Find(var_7_27, "frame/toggles")
	eachChild = var_1

	var_1(arg_7_0.togglesTF, function(arg_8_0)
		onButton = var_2_10001

		local var_8_0 = arg_7_0
		local var_8_1 = arg_8_0

		local function var_8_2()
			arg_7_0.contextData.page = arg_8_0.name

			local var_9_0 = arg_7_0

			var_0.SwitchPage(var_9_0)

			return
		end

		SFX_PANEL = var_2_10006

		var_2_10001(var_8_0, var_8_1, var_8_2, var_2_10006)

		return
	end)

	local var_7_28 = arg_7_0.shop
	local var_7_29 = #var_1.GetCommodities(var_7_28) == 0
	local var_7_30 = arg_7_0.togglesTF
	local var_7_31 = var_2.Find(var_7_30, "shop")

	if var_7_29 then
		onButton = var_7_28

		local var_7_32 = arg_7_0
		local var_7_33 = var_7_31

		local function var_7_34()
			pg = var_2_10000

			local var_10_0 = var_2_10000.TipsMgr.GetInstance()
			local var_10_1 = var_0.ShowTips

			i18n = var_2_10003

			var_10_1(var_10_0, var_2_10003("cruise_shop_no_open"))

			return
		end

		SFX_PANEL = var_8

		var_7_28(var_7_32, var_7_33, var_7_34, var_8)
	end

	setActive = var_7_28

	var_7_28(var_7_31:Find("lock"), var_7_29)

	setText = var_7_28

	local var_7_35 = var_7_31:Find("lock/Text")

	i18n = var_6

	var_7_28(var_7_35, var_6("cruise_shop_no_open"))

	local var_7_36 = arg_7_0.contextData

	WorldCruiseChargePage = var_7_30
	var_7_36.windowForCharge = var_7_30.New(arg_7_0._tf, arg_7_0.event)

	arg_7_0:Hx4Channel()

	return
end

function var_0_1.didEnter(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.battlepass_event_pt[arg_11_0.activity.id]

	LoadImageSpriteAtlasAsync = var_2

	local var_11_1 = "bg/" .. var_11_0.bg
	local var_11_2 = ""
	local var_11_3 = arg_11_0._tf

	var_2(var_11_1, var_11_2, var_6.Find(var_11_3, "bg/bg_1"), true)

	local var_11_4 = arg_11_0._tf
	local var_11_5 = var_2.Find(var_11_4, "bg/bg_2")

	if var_11_0.bg_tips ~= "" then
		LoadImageSpriteAtlasAsync = var_3

		var_3("bg/" .. var_11_0.bg_tips, "", var_11_5, true)

		setActive = var_3

		var_3(var_11_5, true)
	else
		setActive = var_3

		var_3(var_11_5, false)
	end

	onButton = var_3

	local var_11_6 = arg_11_0
	local var_11_7 = arg_11_0.topUI
	local var_11_8 = var_6.Find(var_11_7, "back")

	local function var_11_9()
		local var_12_0 = arg_11_0

		var_0.closeView(var_12_0)

		return
	end

	SFX_CANCEL = var_11_7

	var_3(var_11_6, var_11_8, var_11_9, var_11_7)

	onButton = var_3

	local var_11_10 = arg_11_0
	local var_11_11 = arg_11_0.helpBtn

	local function var_11_12()
		pg = var_2_10000

		local var_13_0 = var_2_10000.NewStyleMsgboxMgr.GetInstance()
		local var_13_1 = var_0.Show

		pg = var_2_10003

		local var_13_2 = var_2_10003.NewStyleMsgboxMgr.TYPE_COMMON_HELP
		local var_13_3 = {}

		i18n = var_2_10005

		local var_13_4 = "battlepass_main_help_"

		pg = var_2_10008
		var_13_3.helps = var_2_10005(var_13_4 .. var_2_10008.battlepass_event_pt[arg_11_0.activity.id].map_name)

		var_13_1(var_13_0, var_13_2, var_13_3)

		return
	end

	SFX_PANEL = var_11_7

	var_3(var_11_10, var_11_11, var_11_12, var_11_7)

	onButton = var_3

	local var_11_13 = arg_11_0
	local var_11_14 = arg_11_0.gemResBtn

	local function var_11_15()
		pg = var_2_10000

		local var_14_0 = var_2_10000.playerResUI

		var_0.ClickGem(var_14_0)

		return
	end

	SFX_PANEL = var_11_7

	var_3(var_11_13, var_11_14, var_11_15, var_11_7)

	onButton = var_3

	local var_11_16 = arg_11_0
	local var_11_17 = arg_11_0.ticketResBtn

	local function var_11_18()
		shoppingBatchNewStyle = var_2_10000
		Goods = var_2_10002

		local var_15_0 = var_2_10002.CRUISE_QUICK_TASK_TICKET_ID
		local var_15_1 = {}

		Item = var_2_10004
		var_15_1.id = var_2_10004.QUICK_TASK_PASS_TICKET_ID

		var_2_10000(var_15_0, var_15_1, 20, "build_ship_quickly_buy_stone")

		return
	end

	SFX_PANEL = var_11_7

	var_3(var_11_16, var_11_17, var_11_18, var_11_7)

	local var_11_19 = arg_11_0.activity.stopTime

	pg = var_11_4

	local var_11_20 = var_11_4.TimeMgr.GetInstance()
	local var_11_21 = var_11_19 - var_4.GetServerTime(var_11_20)
	local var_11_22 = arg_11_0.dayTxt

	i18n = var_11_16

	local var_11_23 = var_11_16("battlepass_main_time_title")

	i18n = var_11_20

	local var_11_24 = "battlepass_main_time"

	math = var_9

	local var_11_25 = var_9.floor(var_11_21 / 0)

	math = var_1_10010
	var_11_22.text = var_11_23 .. var_11_20(var_11_24, var_11_25, var_1_10010.floor(var_11_21 % 0 / 16))

	arg_11_0:UpdateRes()
	arg_11_0:UpdatePhase()
	arg_11_0:UpdateAwardTip()

	triggerButton = var_4

	local var_11_26 = arg_11_0.togglesTF
	local var_11_27 = var_6.Find
	local var_11_28

	if not arg_11_0.contextData.page then
		var_11_28 = var_0_2
	end

	var_4(var_11_27(var_11_26, var_11_28))

	return
end

function var_0_1.UpdateRes(arg_16_0)
	local var_16_0 = arg_16_0.gemValue
	local var_16_1 = arg_16_0.player

	var_16_0.text = var_2.getTotalGem(var_16_1)

	local var_16_2 = arg_16_0.ticketValue

	getProxy = var_2
	BagProxy = var_16_1

	local var_16_3 = var_2(var_16_1)
	local var_16_4 = var_2.getItemCountById

	Item = var_1_10005
	var_16_2.text = var_16_4(var_16_3, var_1_10005.QUICK_TASK_PASS_TICKET_ID)

	return
end

function var_0_1.UpdatePhase(arg_17_0)
	setText = var_1_10001

	local var_17_0 = arg_17_0.phaseTF

	var_1_10001(var_3.Find(var_17_0, "Text"), "<size=27>lv.</size>" .. arg_17_0.phase)

	local var_17_1

	if arg_17_0.phase < #arg_17_0.awardList then
		var_17_1 = arg_17_0.phase == 0 and 0 or arg_17_0.awardList[arg_17_0.phase].pt

		local var_17_2 = arg_17_0.pt - var_17_1
		local var_17_3 = arg_17_0.awardList[arg_17_0.phase + 1].pt - var_17_1

		setSlider = var_4

		local var_17_4 = arg_17_0.phaseTF

		var_4(var_6.Find(var_17_4, "slider"), 0, var_17_3, var_17_2)

		setText = var_4

		local var_17_5 = arg_17_0.phaseTF

		var_4(var_6.Find(var_17_5, "progress/Text"), var_17_2 .. "/" .. var_17_3)
	else
		setSlider = var_17_1

		local var_17_6 = arg_17_0.phaseTF

		var_17_1(var_3.Find(var_17_6, "slider"), 0, 1, 1)

		setText = var_17_1

		local var_17_7 = arg_17_0.phaseTF

		var_17_1(var_3.Find(var_17_7, "progress/Text"), "MAX")
	end

	arg_17_0.contextData.phase = arg_17_0.phase

	return
end

function var_0_1.OnChargeSuccess(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.contextData.windowForCharge

	var_2.ExecuteAction(var_18_0, "ShowUnlockWindow", arg_18_1)

	return
end

function var_0_1.UpdateAwardTip(arg_19_0)
	setActive = var_1_10001

	local var_19_0 = arg_19_0.togglesTF
	local var_19_1 = var_3.Find(var_19_0, "award/tip")
	local var_19_2 = arg_19_0.activity

	var_1_10001(var_19_1, #var_4.GetCrusingUnreceiveAward(var_19_2) > 0)

	return
end

function var_0_1.SwitchPage(arg_20_0)
	pairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.pages) do
		if iter_20_0 == arg_20_0.contextData.page then
			iter_20_1:ExecuteAction("Flush")
		else
			iter_20_1:ExecuteAction("Hide")
		end
	end

	eachChild = var_1

	var_1(arg_20_0.togglesTF, function(arg_21_0)
		setActive = var_2_10001

		var_2_10001(arg_21_0:Find("unselected"), arg_21_0.name ~= arg_20_0.contextData.page)

		setActive = var_2_10001

		var_2_10001(arg_21_0:Find("selected"), arg_21_0.name == arg_20_0.contextData.page)

		return
	end)

	local var_20_0 = arg_20_0.contextData.page == var_0_1.PAGE_SHOP

	setActive = var_2

	local var_20_1 = arg_20_0._tf

	var_2(var_4.Find(var_20_1, "shop_bg"), var_20_0)

	setActive = var_2

	var_2(arg_20_0.phaseTF, not var_20_0)

	pg = var_2

	local var_20_2 = var_2.battlepass_event_pt[arg_20_0.activity.id].map_name

	setText = var_3

	local var_20_3 = arg_20_0.titleTF

	if var_20_0 then
		i18n = var_20_1

		if not var_20_1("cruise_shop_title") then
			i18n = var_20_1
			var_20_1 = var_20_1("cruise_title_" .. var_20_2)
		end

		var_3(var_20_3, var_20_1)

		return
	end
end

function var_0_1.UpdateView(arg_22_0)
	local var_22_0 = arg_22_0.pages[arg_22_0.contextData.page]

	var_1.ExecuteAction(var_22_0, "Flush")

	return
end

function var_0_1.UpdateAwardPage(arg_23_0)
	arg_23_0:UpdateAwardTip()

	local var_23_0 = arg_23_0.pages[var_0_1.PAGE_AWARD]

	var_1.ExecuteAction(var_23_0, "UpdateActivity", arg_23_0.activity)

	return
end

function var_0_1.UpdateTaskPage(arg_24_0)
	local var_24_0 = arg_24_0.pages[var_0_1.PAGE_TASK]

	var_1.ExecuteAction(var_24_0, "UpdateActivity", arg_24_0.activity)

	return
end

function var_0_1.UpdateShopPage(arg_25_0)
	local var_25_0 = arg_25_0.pages[var_0_1.PAGE_SHOP]

	var_1.ExecuteAction(var_25_0, "UpdateShop", arg_25_0.shop)
	arg_25_0:UpdateView()

	return
end

function var_0_1.onBackPressed(arg_26_0)
	if arg_26_0.contextData.windowForCharge then
		local var_26_0 = arg_26_0.contextData.windowForCharge

		if var_1.GetLoaded(var_26_0) then
			local var_26_1 = arg_26_0.contextData.windowForCharge

			if var_1.isShowing(var_26_1) then
				local var_26_2 = arg_26_0.contextData.windowForCharge

				var_1.Hide(var_26_2)

				return
			end
		end
	end

	var_0_1.super.onBackPressed(arg_26_0)

	return
end

function var_0_1.willExit(arg_27_0)
	local var_27_1

	if arg_27_0.contextData.windowForCharge then
		local var_27_0 = arg_27_0.contextData.windowForCharge

		var_27_1.Destroy(var_27_0)

		var_27_1 = arg_27_0.contextData
		var_27_1.windowForCharge = nil
	end

	pairs = var_27_1

	for iter_27_0, iter_27_1 in var_27_1(arg_27_0.pages) do
		iter_27_1:Destroy()

		iter_27_1 = nil
	end

	return
end

local function var_0_3(arg_28_0)
	pg = var_1_10001

	local var_28_0 = var_1_10001.SdkMgr.GetInstance()
	local var_28_1 = var_1.GetChannelUIDIncludeHarmony(var_28_0)
	local var_28_2 = arg_28_0._tf

	return (var_2.Find(var_28_2, "bg/bg_1/hx_ch" .. var_28_1))
end

function var_0_1.Hx4Channel(arg_29_0)
	local var_29_0 = var_0_3(arg_29_0)

	IsNil = var_1_10002

	if not var_1_10002(var_29_0) then
		setActive = var_2

		local var_29_1 = var_29_0

		HXSet = var_1_10005

		var_2(var_29_1, var_1_10005.isHx())
	end

	return
end

return var_0_1
