class = var_0_10000

local var_0_0 = "GuildShopPurchasePanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "GuildShopPurchaseMsgUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_3.Find(var_2_1, "got/bottom/scroll/list")
	local var_2_3 = arg_2_0._tf

	arg_2_0.list = var_2_0(var_2_2, var_4.Find(var_2_3, "got/bottom/scroll/list/tpl"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_4, "confirm")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "got/top/desc")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.descTxt = var_2_7(var_2_6, var_4(var_2_3))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "got/top/exchange/Text")
	local var_2_10 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.exchagneCnt = var_2_10(var_2_9, var_4(var_2_3))

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_1.Find(var_2_11, "confirm/consume/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_2_3
	arg_2_0.consumeCnt = var_2_13(var_2_12, var_4(var_2_3))

	local var_2_14 = arg_2_0._tf

	arg_2_0.title = var_1.Find(var_2_14, "got/top/title")
	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_3.Find(var_2_15, "got/top/exchange/label")

	i18n = var_4

	var_1(var_2_16, var_4("guild_shop_label_2"))

	setText = var_1

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_3.Find(var_2_17, "confirm/Text")

	i18n = var_4

	var_1(var_2_18, var_4("guild_shop_label_3"))

	setText = var_1

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_3.Find(var_2_19, "confirm/consume/label")

	i18n = var_4

	var_1(var_2_20, var_4("guild_shop_label_4"))

	local var_2_21 = arg_2_0._tf

	arg_2_0.resIcon = var_1.Find(var_2_21, "confirm/consume/icon")

	arg_2_0:Hide()

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.confirmBtn

	local function var_3_2()
		if #arg_3_0.selectedList == 0 then
			pg = var_0

			local var_4_0 = var_0.TipsMgr.GetInstance()
			local var_4_1 = var_0.ShowTips

			i18n = var_2_10003

			var_4_1(var_4_0, var_2_10003("guild_shop_must_select_goods"))

			return
		end

		local var_4_2 = arg_3_0

		var_0.OnConfirm(var_4_2)

		local var_4_3 = arg_3_0

		var_0.Hide(var_4_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	return
end

function var_0_1.OnConfirm(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.emit

	NewShopMainMediator = var_1_10004

	var_6_1(var_6_0, var_1_10004.ON_GUILD_SHOPPING, arg_6_0.data.id, arg_6_0.selectedList)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	pg = var_2

	local var_7_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_7_0, arg_7_0._tf)

	arg_7_0.data = arg_7_1
	arg_7_0.maxCnt = arg_7_1.count
	arg_7_0.selectedList = {}

	arg_7_0:InitList()
	arg_7_0:UpdateValue()

	if arg_7_1.type == 4 then
		setText = var_2

		local var_7_1 = arg_7_0.title

		i18n = var_5

		var_2(var_7_1, var_5("guild_shop_label_5"))
	else
		setText = var_2

		local var_7_2 = arg_7_0.title

		i18n = var_5

		var_2(var_7_2, var_5("guild_shop_label_1"))
	end

	arg_7_0.descTxt.text = ""

	return
end

function var_0_1.UpdateValue(arg_8_0)
	local var_8_0

	if not (arg_8_0.maxCnt - #arg_8_0.selectedList > 0) or not ("<color=#92FC63FF>" .. var_1 .. "</color>/") then
		var_8_0 = "<color=#FF5C5CFF>" .. var_1 .. "</color>/"
	end

	local var_8_1 = arg_8_0.exchagneCnt

	var_8_1.text = var_8_0 .. arg_8_0.maxCnt
	setActive = var_8_1

	local var_8_2 = arg_8_0._tf

	var_8_1(var_5.Find(var_8_2, "got/top/exchange"), arg_8_0.maxCnt ~= 0)

	arg_8_0.consumeCnt.text = arg_8_0.data.price * #arg_8_0.selectedList

	return
end

function var_0_1.InitList(arg_9_0)
	arg_9_0.displays = arg_9_0.data.displays

	local var_9_0 = arg_9_0.list

	var_2.make(var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_9_0.displays[arg_10_1 + 1]
			local var_10_1 = arg_9_0

			var_4.UpdateItem(var_10_1, var_0, var_10_0, arg_10_2)
		end

		return
	end)

	local var_9_1 = arg_9_0.list

	var_2.align(var_9_1, #arg_9_0.displays)

	return
end

function var_0_1.UpdateItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_1.type

	updateDrop = var_1_10005

	var_1_10005(arg_11_3:Find("item/bg"), {
		type = var_11_0,
		id = arg_11_2,
		count = arg_11_1.num
	})

	Drop = var_1_10005

	local var_11_1 = var_1_10005.New({
		type = var_11_0,
		id = arg_11_2
	})
	local var_11_2 = arg_11_3:Find("name_bg/Text")
	local var_11_3 = var_6.GetComponent(var_11_2, "ScrollText")
	local var_11_4 = var_11_1:getConfig("name")

	var_11_3:SetText(var_11_4)

	local var_11_5 = arg_11_3:Find("cnt/Text")
	local var_11_6 = var_8.GetComponent

	typeof = var_11
	Text = var_1_10013

	local var_11_7 = var_11_6(var_11_5, var_11(var_1_10013))

	local function var_11_8()
		local var_12_0 = 0

		ipairs = var_2_10001

		for iter_12_0, iter_12_1 in var_2_10001(arg_11_0.selectedList) do
			if iter_12_1 == arg_11_2 then
				var_12_0 = var_12_0 + 1
			end
		end

		var_11_7.text = var_12_0

		return
	end

	onButton = var_11_5

	local var_11_9 = arg_11_0
	local var_11_10 = arg_11_3

	local function var_11_11()
		local var_13_0 = arg_11_0

		var_0.ClickItem(var_13_0, arg_11_3, arg_11_2)

		return
	end

	SFX_PANEL = var_1_10015

	var_11_5(var_11_9, var_11_10, var_11_11, var_1_10015)

	pressPersistTrigger = var_11_5

	local var_11_12 = arg_11_3:Find("cnt/minus")
	local var_11_13 = 0.5

	local function var_11_14()
		local var_14_0 = arg_11_0

		var_0.PressMinusBtn(var_14_0, arg_11_3, arg_11_2)
		var_11_8()

		return
	end

	local var_11_15
	local var_11_16 = true
	local var_11_17 = true
	local var_11_18 = 0.1

	SFX_PANEL = var_1_10019

	var_11_5(var_11_12, var_11_13, var_11_14, var_11_15, var_11_16, var_11_17, var_11_18, var_1_10019)

	pressPersistTrigger = var_11_5

	local var_11_19 = arg_11_3:Find("cnt/add")
	local var_11_20 = 0.5

	local function var_11_21()
		local var_15_0 = arg_11_0

		var_0.PressAddBtn(var_15_0, arg_11_3, arg_11_2)
		var_11_8()

		return
	end

	local var_11_22
	local var_11_23 = true
	local var_11_24 = true
	local var_11_25 = 0.1

	SFX_PANEL = var_1_10019

	var_11_5(var_11_19, var_11_20, var_11_21, var_11_22, var_11_23, var_11_24, var_11_25, var_1_10019)

	local var_11_26 = arg_11_3:Find("mask")

	setActive = var_11

	var_11(var_11_26, false)
	var_11_8()

	return
end

function var_0_1.ClearZeroItem(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.list

	var_2.each(var_16_0, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_16_0.displays[arg_17_0 + 1]

		if arg_16_1 ~= arg_17_1 then
			table = var_3

			if not var_3.contains(arg_16_0.selectedList, var_17_0) then
				setActive = var_3

				var_3(arg_17_1:Find("cnt"), false)

				setActive = var_3

				var_3(arg_17_1:Find("selected"), false)
			end
		end

		return
	end)

	return
end

function var_0_1.ClickItem(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:ClearZeroItem(arg_18_1)

	setActive = var_3

	var_3(arg_18_1:Find("cnt"), true)

	setActive = var_3

	var_3(arg_18_1:Find("selected"), true)

	return
end

function var_0_1.PressMinusBtn(arg_19_0, arg_19_1, arg_19_2)
	if #arg_19_0.selectedList == 0 then
		return
	end

	ipairs = var_3

	for iter_19_0, iter_19_1 in var_3(arg_19_0.selectedList) do
		if iter_19_1 == arg_19_2 then
			table = var_1_10008

			var_1_10008.remove(arg_19_0.selectedList, iter_19_0)

			break
		end
	end

	arg_19_0:UpdateValue()

	return
end

function var_0_1.PressAddBtn(arg_20_0, arg_20_1, arg_20_2)
	if #arg_20_0.selectedList == arg_20_0.maxCnt and arg_20_0.maxCnt ~= 0 then
		return
	end

	table = var_3

	var_3.insert(arg_20_0.selectedList, arg_20_2)
	arg_20_0:UpdateValue()

	return
end

function var_0_1.Hide(arg_21_0)
	if arg_21_0:isShowing() then
		pg = var_1

		local var_21_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_21_0, arg_21_0._tf, arg_21_0._parentTf)
	end

	local var_21_1 = arg_21_0.list

	var_1.each(var_21_1, function(arg_22_0, arg_22_1)
		setActive = var_2_10002

		var_2_10002(arg_22_1:Find("cnt"), false)

		setActive = var_2_10002

		var_2_10002(arg_22_1:Find("selected"), false)

		return
	end)
	var_0_1.super.Hide(arg_21_0)

	return
end

function var_0_1.OnDestroy(arg_23_0)
	arg_23_0:Hide()

	return
end

return var_0_1
