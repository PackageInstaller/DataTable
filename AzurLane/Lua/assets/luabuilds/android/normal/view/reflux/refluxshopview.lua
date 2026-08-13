class = var_0_10000

local var_0_0 = "RefluxShopView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

var_0_1.GiftPackType = {
	Gold = 3,
	Money = 1,
	Diamond = 2
}
var_0_1.GiftPackTypeName = {
	"pack_type_1",
	"pack_type_2",
	"pack_type_3"
}
var_0_1.Special_ID_Gold = 1
var_0_1.Special_ID_Gem = 14

function var_0_1.getUIName(arg_1_0)
	return "RefluxShopUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateUI()
	var_0_1.SaveEnterTag()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	pairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(var_0_1.GiftPackType) do
		if arg_3_0.packTimerList[iter_3_1] then
			var_6:Stop()

			arg_3_0.packTimerList[iter_3_1] = nil
		end

		if arg_3_0.packNextTimerList[iter_3_1] then
			var_7:Stop()

			arg_3_0.packNextTimerList[iter_3_1] = nil
		end
	end

	return
end

function var_0_1.OnBackPress(arg_4_0)
	arg_4_0:Hide()

	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	RefluxProxy = var_1_10002
	arg_5_0.refluxProxy = var_1_10001(var_1_10002)
	getProxy = var_1
	ShopsProxy = var_1_10002
	arg_5_0.shopProxy = var_1(var_1_10002)

	return
end

function var_0_1.initUI(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "BG/MoneyTip")

	setActive = var_6_0

	var_6_0(var_6_1, false)

	local var_6_2 = arg_6_0._tf

	arg_6_0.itemTpl = var_2.Find(var_6_2, "ItemTpl")

	local var_6_3 = arg_6_0._tf

	arg_6_0.packTpl = var_2.Find(var_6_3, "PackTpl")

	local var_6_4 = arg_6_0._tf

	arg_6_0.packContainerTF = var_2.Find(var_6_4, "Container")
	UIItemList = var_2
	arg_6_0.packItemList = var_2.New(arg_6_0.packContainerTF, arg_6_0.packTpl)

	local var_6_5 = arg_6_0.packItemList

	var_2.make(var_6_5, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			arg_7_1 = arg_7_1 + 1

			local var_7_0 = arg_6_0.goodVOList[arg_7_1]
			local var_7_1 = arg_6_0

			var_4.updatePack(var_7_1, arg_7_2, var_7_0, arg_7_1)
		end

		return
	end)

	arg_6_0.packTimerList = {}
	arg_6_0.packNextTimerList = {}

	local var_6_6 = arg_6_0.itemTpl
	local var_6_7 = var_2.Find(var_6_6, "CommonItemTemplate")

	setActive = var_6_6

	var_6_6(var_6_7:Find("icon_bg/count"), true)

	setLocalScale = var_6_6

	var_6_6(var_6_7, {
		x = 0.45,
		y = 0.45
	})

	return
end

function var_0_1.updateData(arg_8_0)
	local var_8_0 = arg_8_0:getCurDayGiftPackIDList()
	local var_8_1 = false
	local var_8_2

	if var_8_0[1] then
		Goods = var_8_2
		var_8_2 = var_8_2.Create

		local var_8_3 = {
			shop_id = var_8_0[1]
		}

		Goods = var_5
		var_8_1 = var_8_2(var_8_3, var_5.TYPE_CHARGE)
	end

	Goods = var_8_2

	local var_8_4 = var_8_2.Create
	local var_8_5 = {
		shop_id = var_8_0[2]
	}

	Goods = var_5

	local var_8_6 = var_8_4(var_8_5, var_5.TYPE_GIFT_PACKAGE)

	Goods = var_8_5

	local var_8_7 = var_8_5.Create
	local var_8_8 = {
		shop_id = var_8_0[3]
	}

	Goods = var_6

	local var_8_9 = var_8_7(var_8_8, var_6.TYPE_GIFT_PACKAGE)

	arg_8_0.goodVOList = {
		var_8_1,
		var_8_6,
		var_8_9
	}

	return
end

function var_0_1.updateUI(arg_9_0)
	arg_9_0:updateData()
	arg_9_0:updatePackList()

	return
end

function var_0_1.updateOutline(arg_10_0)
	local var_10_0 = arg_10_0.packContainerTF.childCount

	for iter_10_0 = 1, var_10_0 do
		local var_10_1 = iter_10_0 - 1
		local var_10_2 = arg_10_0.packContainerTF
		local var_10_3 = var_7.GetChild(var_10_2, var_10_1)
		local var_10_4 = var_7.Find(var_10_3, "TimeLimit/Text")
		local var_10_5 = var_8.GetComponent

		typeof = var_1_10011
		Text = var_1_10012

		local var_10_6 = var_10_5(var_10_4, var_1_10011(var_1_10012))

		Object = var_10_4
		var_10_6.material = var_10_4.Instantiate(var_10_6.material)
		var_1_10011 = var_7
		var_1_10012 = var_7.Find(var_1_10011, "Price/Text")
		var_1_10011 = var_10.GetComponent
		typeof = var_1_10013
		Text = var_1_10014
		var_1_10011 = var_1_10011(var_1_10012, var_1_10013(var_1_10014))
		Object = var_1_10012
		var_1_10011.material = var_1_10012.Instantiate(var_1_10011.material)
		var_1_10013 = var_7
		var_1_10014 = var_7.Find(var_1_10013, "Mask/Text")
		var_1_10013 = var_1_10012.GetComponent
		typeof = var_1_10015
		Text = var_1_10016
		var_1_10013 = var_1_10013(var_1_10014, var_1_10015(var_1_10016))
		Object = var_1_10014
		var_1_10013.material = var_1_10014.Instantiate(var_1_10013.material)
	end

	return
end

function var_0_1.updateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1:Find("Frame")
	local var_11_1 = arg_11_1:Find("Icon")
	local var_11_2 = arg_11_1:Find("Count")
	local var_11_3

	if not arg_11_2.type then
		var_11_3 = arg_11_2[1]
	end

	local var_11_4

	if not arg_11_2.id then
		var_11_4 = arg_11_2[2]
	end

	local var_11_5

	if not arg_11_2.count then
		var_11_5 = arg_11_2[3]
	end

	setText = var_1_10009

	var_1_10009(var_11_2, var_11_5)

	setActive = var_1_10009

	var_1_10009(var_11_0, false)

	setActive = var_1_10009

	var_1_10009(var_11_1, false)

	setActive = var_1_10009

	var_1_10009(var_11_2, false)

	findTF = var_1_10009

	local var_11_6 = var_1_10009(arg_11_1, "CommonItemTemplate")

	setActive = var_10

	var_10(var_11_6, true)

	updateDrop = var_10

	var_10(var_11_6, {
		type = var_11_3,
		id = var_11_4,
		count = var_11_5
	})

	return
end

function var_0_1.updatePack(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 == false then
		setActive = var_1_10004

		var_1_10004(arg_12_1, false)

		return
	elseif arg_12_3 == var_0_1.GiftPackType.Money and arg_12_0:isBuyEver(arg_12_2.id) then
		setActive = var_4

		var_4(arg_12_1, false)

		return
	else
		setActive = var_4

		var_4(arg_12_1, true)
	end

	local var_12_0
	local var_12_1

	if arg_12_3 == var_0_1.GiftPackType.Money then
		-- block empty
	else
		local var_12_2 = arg_12_2:getConfig("effect_args")

		Item = var_6
		var_12_1 = var_6.getConfigData(var_12_2[1])
	end

	local var_12_3 = arg_12_1:Find("PackIcon")
	local var_12_4
	local var_12_5

	if arg_12_3 == var_0_1.GiftPackType.Money then
		var_12_5 = "chargeicon/"
		var_1_10010 = arg_12_2
		var_12_4 = var_12_5 .. arg_12_2.getConfig(var_1_10010, "picture")
	else
		var_12_4 = var_12_1.icon
	end

	setImageSprite = var_12_5

	local var_12_6 = var_12_3

	LoadSprite = var_1_10010

	var_12_5(var_12_6, var_1_10010(var_12_4), true)

	local var_12_7 = arg_12_1:Find("PackName")

	if arg_12_3 == var_0_1.GiftPackType.Money then
		setText = var_9

		var_9(var_12_7, arg_12_2:getConfig("name_display"))
	else
		setText = var_9

		var_9(var_12_7, var_12_1.name)
	end

	local var_12_8 = arg_12_1:Find("ItemList")
	local var_12_9

	if arg_12_3 == var_0_1.GiftPackType.Money then
		var_12_9 = arg_12_2:getConfig("display")
	else
		var_12_9 = var_12_1.display_icon
	end

	UIItemList = var_11

	local var_12_10 = var_11.New(var_12_8, arg_12_0.itemTpl)

	var_11.make(var_12_10, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			arg_13_1 = arg_13_1 + 1

			local var_13_0 = var_12_9[arg_13_1]
			local var_13_1 = arg_12_0

			var_4.updateItem(var_13_1, arg_13_2, var_13_0)
		end

		return
	end)
	var_11:align(#var_12_9)

	local var_12_11 = arg_12_1:Find("DescFrame/Text")

	if arg_12_3 == var_0_1.GiftPackType.Money then
		setText = var_13

		var_13(var_12_11, arg_12_2:getConfig("descrip"))
	else
		setText = var_13

		var_13(var_12_11, var_12_1.display)
	end

	local var_12_12 = arg_12_1:Find("TimeLimit")
	local var_12_13 = var_13.Find(var_12_12, "Text")
	local var_12_14, var_12_15

	if arg_12_3 ~= var_0_1.GiftPackType.Money then
		var_12_14 = arg_12_0
		var_12_15 = arg_12_0.isHaveNextPack(var_12_14, var_0_1.GiftPackTypeName[arg_12_3])
	else
		var_12_15 = false
	end

	if false then
		var_12_15 = true
	end

	var_12_15 = var_12_15 and not arg_12_0:isBuyEver(arg_12_2.id)

	if var_12_15 then
		setActive = var_12_14

		var_12_14(var_13, true)
		arg_12_0:updatePackTimeLimit(var_12_13, arg_12_3)
	else
		setActive = var_12_14

		var_12_14(var_13, false)
	end

	local var_12_16 = arg_12_1
	local var_12_17 = arg_12_1.Find(var_12_16, "MoneyTag")

	setActive = var_12_16

	var_12_16(var_12_17, arg_12_3 == var_0_1.GiftPackType.Money)

	local var_12_18 = arg_12_1:Find("Price/IconMoney")
	local var_12_19 = arg_12_1:Find("Price/Icon")
	local var_12_20 = arg_12_1:Find("Price/Icon/Res")
	local var_12_21 = arg_12_1:Find("Price/Text")

	if arg_12_3 == var_0_1.GiftPackType.Money then
		setActive = var_21

		var_21(var_12_18, true)

		setActive = var_21

		var_21(var_12_19, false)

		setText = var_21

		var_21(var_12_21, arg_12_2:getConfig("money"))
	else
		setActive = var_21

		var_21(var_12_18, false)

		setActive = var_21

		var_21(var_12_19, true)

		setText = var_21

		var_21(var_12_21, arg_12_2:getConfig("resource_num"))

		local var_12_22 = arg_12_2:getConfig("resource_type")
		local var_12_23

		if var_12_22 == var_0_1.Special_ID_Gem then
			var_12_23 = "props/gem"
		elseif var_12_22 == var_0_1.Special_ID_Gold then
			var_12_23 = "props/gold"
		end

		setImageSprite = var_23

		local var_12_24 = var_12_20

		LoadSprite = var_25

		var_23(var_12_24, var_25(var_12_23), true)
	end

	local var_12_25 = arg_12_1:Find("Mask")
	local var_12_26 = arg_12_0
	local var_12_27 = arg_12_0.isBuyEver(var_12_26, arg_12_2.id)

	setActive = var_12_26

	var_12_26(var_12_25, var_12_27)

	if var_12_27 then
		var_12_26 = var_12_25:Find("NextTime")

		local var_12_28 = var_12_25:Find("Text")
		local var_12_29 = var_12_25:Find("Sellout")

		var_1_10027 = arg_12_0

		if arg_12_0.isHaveNextPack(var_1_10027, var_0_1.GiftPackTypeName[arg_12_3]) then
			setActive = var_26

			var_26(var_12_26, true)

			setActive = var_26

			var_26(var_12_28, true)

			setActive = var_26

			var_26(var_12_29, false)

			var_1_10027 = arg_12_0

			arg_12_0.updatePackNextTime(var_1_10027, var_12_28, arg_12_3)
		else
			setActive = var_26

			var_26(var_12_26, false)

			setActive = var_26

			var_26(var_12_28, false)

			setActive = var_26

			var_26(var_12_29, true)
		end
	end

	onButton = var_12_26

	local var_12_30 = arg_12_0
	local var_12_31 = arg_12_1

	local function var_12_32()
		isActive = var_2_10000

		if not var_2_10000(var_12_25) then
			local var_14_0 = arg_12_0

			var_0.confirm(var_14_0, arg_12_2)
		end

		return
	end

	SFX_PANEL = var_1_10027

	var_12_26(var_12_30, var_12_31, var_12_32, var_1_10027)

	return
end

function var_0_1.updatePackTimeLimit(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:getCurDay()
	local var_15_1 = var_0_1.GiftPackTypeName[arg_15_2]
	local var_15_2 = arg_15_0:calcNextGiftPackSecByType(var_15_1, var_15_0)
	local var_15_3

	if arg_15_0.packTimerList[arg_15_2] then
		var_15_3 = var_6

		var_6.Stop(var_15_3)

		arg_15_0.packTimerList[arg_15_2] = nil
	end

	local function var_15_4()
		if var_15_2 >= 0 then
			pg = var_0

			local var_16_0 = var_0.TimeMgr.GetInstance()
			local var_16_1 = var_0.DescCDTime(var_16_0, var_15_2)

			setText = var_16_0

			var_16_0(arg_15_1, var_16_1)

			var_15_2 = var_15_2 - 1
		else
			local var_16_2 = var_0

			var_0.Stop(var_16_2)

			arg_15_0.packTimerList[arg_15_2] = nil
		end

		return
	end

	Timer = var_15_3

	local var_15_5 = var_15_3.New(var_15_4, 1, -1)

	var_6.Start(var_15_5)

	arg_15_0.packTimerList[arg_15_2] = var_6

	var_15_4()

	return
end

function var_0_1.updatePackNextTime(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getCurDay()
	local var_17_1 = var_0_1.GiftPackTypeName[arg_17_2]
	local var_17_2 = arg_17_0:calcNextGiftPackSecByType(var_17_1, var_17_0)
	local var_17_3

	if arg_17_0.packNextTimerList[arg_17_2] then
		var_17_3 = var_6

		var_6.Stop(var_17_3)

		arg_17_0.packNextTimerList[arg_17_2] = nil
	end

	local function var_17_4()
		if var_17_2 >= 0 then
			pg = var_0

			local var_18_0 = var_0.TimeMgr.GetInstance()
			local var_18_1 = var_0.DescCDTime(var_18_0, var_17_2)

			setText = var_18_0

			var_18_0(arg_17_1, var_18_1)

			var_17_2 = var_17_2 - 1
		else
			local var_18_2 = var_0

			var_0.Stop(var_18_2)

			arg_17_0.packNextTimerList[arg_17_2] = nil
		end

		return
	end

	Timer = var_17_3

	local var_17_5 = var_17_3.New(var_17_4, 1, -1)

	var_6.Start(var_17_5)

	arg_17_0.packNextTimerList[arg_17_2] = var_6

	var_17_4()

	return
end

function var_0_1.updatePackList(arg_19_0)
	local var_19_0 = arg_19_0.packItemList

	var_1.align(var_19_0, #arg_19_0.goodVOList)

	return
end

function var_0_1.isShowRedPot()
	PlayerPrefs = var_1_10000

	local var_20_0 = var_1_10000.GetInt("RefluxShop_Enter_Day", 0)

	getProxy = var_1
	RefluxProxy = var_2

	if var_20_0 < var_1(var_2).signCount then
		return true
	else
		return false
	end

	return
end

function var_0_1.SaveEnterTag()
	getProxy = var_1_10000
	RefluxProxy = var_1_10001

	local var_21_0 = var_1_10000(var_1_10001).signCount

	PlayerPrefs = var_1_10001

	var_1_10001.SetInt("RefluxShop_Enter_Day", var_21_0)

	return
end

function var_0_1.getCurDay(arg_22_0)
	local var_22_0 = arg_22_0.refluxProxy.returnTimestamp

	pg = var_1_10002

	local var_22_1 = var_1_10002.TimeMgr.GetInstance()
	local var_22_2 = var_2.GetServerTime(var_22_1)

	pg = var_22_1

	local var_22_3 = var_22_1.TimeMgr.GetInstance()
	local var_22_4 = var_3.DiffDay(var_22_3, var_22_0, var_22_2)

	pg = var_22_3

	if var_22_4 < #var_22_3.return_giftpack_template.all then
		return var_22_4 + 1
	else
		return var_4
	end

	return
end

function var_0_1.getLevelIndex(arg_23_0, arg_23_1)
	local var_23_0

	if not arg_23_1 then
		::label_23_0::

		var_1_10003 = arg_23_0
		var_23_0 = arg_23_0.getCurDay(var_1_10003)
	end

	pg = var_1_10003

	local var_23_1 = var_1_10003.return_giftpack_template[var_23_0].level
	local var_23_2 = arg_23_0.refluxProxy.returnLV
	local var_23_3

	ipairs = var_1_10006

	for iter_23_0, iter_23_1 in var_1_10006(var_23_1) do
		local var_23_4 = iter_23_1[1]
		local var_23_5 = iter_23_1[2]

		if var_23_4 <= var_23_2 and var_23_2 <= var_23_5 then
			return iter_23_0
		end
	end

	return
end

function var_0_1.getCurDayGiftPackIDByType(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0

	if not arg_24_2 then
		::label_24_0::

		var_1_10004 = arg_24_0
		var_24_0 = arg_24_0.getCurDay(var_1_10004)
	end

	pg = var_1_10004

	if #var_1_10004.return_giftpack_template.all < var_24_0 then
		return false
	end

	pg = var_4

	local var_24_1 = var_4.return_giftpack_template[var_24_0][arg_24_1]
	local var_24_2 = var_24_0

	while var_24_1 == "" and 1 < var_24_2 do
		var_24_2 = var_24_2 - 1
		pg = var_6
		var_24_1 = var_6.return_giftpack_template[var_24_2][arg_24_1]
	end

	if var_24_1 == "" then
		return false
	else
		return var_24_1[arg_24_0:getLevelIndex(var_24_2)]
	end

	return
end

function var_0_1.getCurDayGiftPackIDList(arg_25_0)
	local var_25_0 = arg_25_0:getCurDay()

	return {
		[var_0_1.GiftPackType.Money] = arg_25_0:getCurDayGiftPackIDByType("pack_type_1", var_25_0),
		[var_0_1.GiftPackType.Diamond] = arg_25_0:getCurDayGiftPackIDByType("pack_type_2", var_25_0),
		[var_0_1.GiftPackType.Gold] = arg_25_0:getCurDayGiftPackIDByType("pack_type_3", var_25_0)
	}
end

function var_0_1.getNextGiftPackDayByType(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0

	if not arg_26_2 then
		::label_26_0::

		var_1_10004 = arg_26_0
		var_26_0 = arg_26_0.getCurDay(var_1_10004)
	end

	pg = var_1_10004

	if #var_1_10004.return_giftpack_template.all <= var_26_0 then
		return false
	end

	local var_26_1 = var_26_0 + 1

	pg = var_4

	local var_26_2 = var_4.return_giftpack_template[var_26_1][arg_26_1]
	local var_26_3 = var_26_1

	::label_26_1::

	if var_26_2 == "" and 1 < var_26_3 then
		pg = var_6

		if var_26_3 <= #var_6.return_giftpack_template.all then
			repeat
				pg = var_6
				var_26_2 = var_6.return_giftpack_template[var_26_3][arg_26_1]
				var_26_3 = var_26_3 + 1

				goto label_26_1
			until true
		end
	end

	if var_26_2 == "" then
		return false
	else
		return var_26_3
	end

	return
end

function var_0_1.isHaveNextPack(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_2 or arg_27_0:getCurDay()

	return arg_27_0:getNextGiftPackDayByType(arg_27_1, var_27_0) ~= false
end

function var_0_1.calcNextGiftPackSecByType(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2 or arg_28_0:getCurDay()
	local var_28_1 = arg_28_0:getNextGiftPackDayByType(arg_28_1, var_28_0)
	local var_28_2 = 0
	local var_28_3 = arg_28_0.refluxProxy.returnTimestamp + (var_28_1 - 1) * var_28_2

	pg = var_7

	local var_28_4 = var_7.TimeMgr.GetInstance()

	return var_28_3 - var_7.GetServerTime(var_28_4)
end

function var_0_1.isBuyEver(arg_29_0, arg_29_1)
	getProxy = var_1_10002
	ShopsProxy = var_1_10003

	local var_29_0 = var_1_10002(var_1_10003)
	local var_29_1 = var_2.getChargedList(var_29_0)
	local var_29_2 = var_2:GetNormalList()
	local var_29_3 = 0

	ChargeConst = var_1_10006

	local var_29_4 = var_29_3 + var_1_10006.getBuyCount(var_29_1, arg_29_1)

	ChargeConst = var_6

	return var_29_4 + var_6.getBuyCount(var_29_2, arg_29_1) > 0
end

function var_0_1.confirm(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return
	end

	Clone = var_1_10002

	local var_30_0 = var_1_10002(arg_30_1)

	if arg_30_1.isChargeType(var_30_0) then
		table = var_2

		local var_30_1 = not var_2.contains(arg_30_0.firstChargeIds, arg_30_1.id) and arg_30_1:firstPayDouble() and 4 or arg_30_1:getConfig("tag")

		var_1_10006 = arg_30_1

		if not arg_30_1.isMonthCard(var_1_10006) then
			var_1_10006 = arg_30_1

			if not arg_30_1.isGiftBox(var_1_10006) then
				var_1_10006 = arg_30_1

				if not arg_30_1.isItemBox(var_1_10006) then
					var_1_10006 = arg_30_1

					if arg_30_1.isPassItem(var_1_10006) then
						var_1_10006 = arg_30_1

						local var_30_2 = arg_30_1.GetExtraServiceItem(var_1_10006)

						var_1_10006 = arg_30_1:GetExtraDrop()

						local var_30_3 = arg_30_1:GetBonusItem()
						local var_30_4
						local var_30_5

						var_1_10011 = arg_30_1

						if arg_30_1.isPassItem(var_1_10011) then
							i18n = var_10
							var_30_4 = var_10("battlepass_pay_tip")
						else
							var_1_10011 = arg_30_1

							if arg_30_1.isMonthCard(var_1_10011) then
								i18n = var_10
								var_30_4 = var_10("charge_title_getitem_month")
								i18n = var_10
								var_30_5 = var_10("charge_title_getitem_soon")
							else
								i18n = var_10
								var_30_4 = var_10("charge_title_getitem")
							end
						end

						local var_30_6 = {
							isChargeType = true,
							commodity = arg_30_1,
							infoTip = arg_30_1:GetInfoTip()
						}

						var_1_10011 = "chargeicon/"
						var_1_10013 = arg_30_1
						var_30_6.icon = var_1_10011 .. arg_30_1.getConfig(var_1_10013, "picture")
						var_30_6.name = arg_30_1:getConfig("name_display")
						var_30_6.tipExtra = var_30_4
						var_30_6.extraItems = var_30_2
						var_30_6.price = arg_30_1:getConfig("money")
						var_30_6.isLocalPrice = arg_30_1:IsLocalPrice()
						var_30_6.tagType = var_30_1
						var_30_6.isMonthCard = arg_30_1:isMonthCard()
						var_30_6.tipBonus = var_30_5
						var_30_6.bonusItem = var_30_3
						var_30_6.extraDrop = var_1_10006
						var_30_6.descExtra = arg_30_1:getConfig("descrip_extra")
						var_30_6.limitArgs = arg_30_1:getConfig("limit_args")

						function var_30_6.onYes()
							ChargeConst = var_2_10000

							local var_31_1

							if var_2_10000.isNeedSetBirth() then
								local var_31_0 = arg_30_0

								var_31_1 = var_31_1.emit
								RefluxMediator = var_2_10002

								var_31_1(var_31_0, var_2_10002.OPEN_CHARGE_BIRTHDAY)
							else
								pg = var_31_1

								local var_31_2 = var_31_1.m02
								local var_31_3 = var_0.sendNotification

								GAME = var_2_10002

								var_31_3(var_31_2, var_2_10002.CHARGE_OPERATION, {
									shopId = arg_30_1.id
								})
							end

							return
						end

						local var_30_7 = arg_30_0

						var_1_10011 = arg_30_0.emit
						RefluxMediator = var_1_10013

						var_1_10011(var_30_7, var_1_10013.OPEN_CHARGE_ITEM_PANEL, var_30_6)
					else
						var_1_10006 = arg_30_1

						if arg_30_1.isGem(var_1_10006) then
							var_1_10006 = arg_30_1

							local var_30_8 = arg_30_1.getConfig(var_1_10006, "money")

							var_1_10006 = arg_30_1:getConfig("gem")

							if var_3 then
								var_1_10006 = var_1_10006 + arg_30_1:getConfig("gem")
							else
								var_1_10006 = var_1_10006 + arg_30_1:getConfig("extra_gem")
							end

							local var_30_9 = {
								isChargeType = true,
								commodity = arg_30_1,
								icon = "chargeicon/" .. arg_30_1:getConfig("picture"),
								name = arg_30_1:getConfig("name_display"),
								price = arg_30_1:getConfig("money"),
								isLocalPrice = arg_30_1:IsLocalPrice(),
								tagType = var_30_1
							}

							i18n = var_8
							var_30_9.normalTip = var_8("charge_start_tip", var_30_8, var_1_10006)

							function var_30_9.onYes()
								ChargeConst = var_2_10000

								local var_32_1

								if var_2_10000.isNeedSetBirth() then
									local var_32_0 = arg_30_0

									var_32_1 = var_32_1.emit
									RefluxMediator = var_2_10002

									var_32_1(var_32_0, var_2_10002.OPEN_CHARGE_BIRTHDAY)
								else
									pg = var_32_1

									local var_32_2 = var_32_1.m02
									local var_32_3 = var_0.sendNotification

									GAME = var_2_10002

									var_32_3(var_32_2, var_2_10002.CHARGE_OPERATION, {
										shopId = arg_30_1.id
									})
								end

								return
							end

							local var_30_10 = arg_30_0
							local var_30_11 = arg_30_0.emit

							RefluxMediator = var_10

							var_30_11(var_30_10, var_10.OPEN_CHARGE_ITEM_BOX, var_30_9)
						end
					end

					goto label_30_0

					do
						local var_30_12 = {}
						local var_30_13 = arg_30_1
						local var_30_14 = arg_30_1.getConfig(var_30_13, "effect_args")

						Item = var_30_13

						local var_30_15 = var_30_13.getConfigData(var_30_14[1]).display_icon

						type = var_1_10006

						if var_1_10006(var_30_15) == "table" then
							ipairs = var_6

							for iter_30_0, iter_30_1 in var_6(var_30_15) do
								table = var_1_10011
								var_1_10011 = var_1_10011.insert

								local var_30_16 = var_30_12

								Drop = var_1_10013

								var_1_10011(var_30_16, var_1_10013.Create(iter_30_1))
							end
						end

						local var_30_17 = arg_30_1:getConfig("resource_type") == var_0_1.Special_ID_Gold
						local var_30_18

						if var_30_17 then
							i18n = var_8
							var_30_18 = var_8("charge_scene_buy_confirm_gold", arg_30_1:getConfig("resource_num"), var_4.name)
						else
							i18n = var_8
							var_30_18 = var_8("charge_scene_buy_confirm", arg_30_1:getConfig("resource_num"), var_4.name)
						end

						local var_30_19 = {
							isLocalPrice = false,
							isChargeType = false,
							isMonthCard = false,
							commodity = arg_30_1,
							icon = var_4.icon,
							name = var_4.name
						}

						i18n = var_9
						var_30_19.tipExtra = var_9("charge_title_getitem")
						var_30_19.extraItems = var_30_12
						var_30_19.price = arg_30_1:getConfig("resource_num")
						var_30_19.tagType = arg_30_1:getConfig("tag")
						var_30_19.isForceGold = var_30_17

						function var_30_19.onYes()
							pg = var_2_10000

							local var_33_0 = var_2_10000.MsgboxMgr.GetInstance()

							var_0.ShowMsgBox(var_33_0, {
								content = var_30_18,
								onYes = function()
									pg = var_3_10000

									local var_34_0 = var_3_10000.m02
									local var_34_1 = var_0.sendNotification

									GAME = var_3_10002

									var_34_1(var_34_0, var_3_10002.SHOPPING, {
										count = 1,
										id = arg_30_1.id
									})

									return
								end
							})

							return
						end

						local var_30_20 = arg_30_0
						local var_30_21 = arg_30_0.emit

						RefluxMediator = var_11

						var_30_21(var_30_20, var_11.OPEN_CHARGE_ITEM_PANEL, var_30_19)
					end

					::label_30_0::

					return
				end
			end
		end
	end
end

function var_0_1.getAllRefluxPackID()
	local var_35_0 = {}

	ipairs = var_1_10001
	pg = var_1_10002

	for iter_35_0, iter_35_1 in var_1_10001(var_1_10002.return_giftpack_template.all) do
		pg = var_1_10006

		local var_35_1 = var_1_10006.return_giftpack_template[iter_35_1].pack_type_1
		local var_35_2 = var_1_10006.pack_type_2
		local var_35_3 = var_1_10006.pack_type_3

		type = var_1_10010

		if var_1_10010(var_35_1) == "table" then
			pairs = var_1_10010

			for iter_35_2, iter_35_3 in var_1_10010(var_35_1) do
				table = var_1_10015

				var_1_10015.insert(var_35_0, iter_35_3)
			end
		end

		type = var_1_10010

		if var_1_10010(var_35_2) == "table" then
			pairs = var_1_10010

			for iter_35_4, iter_35_5 in var_1_10010(var_35_2) do
				table = var_1_10015

				var_1_10015.insert(var_35_0, iter_35_5)
			end
		end

		type = var_1_10010

		if var_1_10010(var_35_3) == "table" then
			pairs = var_1_10010

			for iter_35_6, iter_35_7 in var_1_10010(var_35_3) do
				table = var_1_10015

				var_1_10015.insert(var_35_0, iter_35_7)
			end
		end
	end

	return var_35_0
end

return var_0_1
