class = var_0_10000

local var_0_0 = "NewServerGiftPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "NewServerGiftPage"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()

	return
end

function var_0_1.initData(arg_3_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	arg_3_0.player = var_1.getData(var_3_0)
	getProxy = var_1
	ActivityProxy = var_3_0

	local var_3_1 = var_1(var_3_0)
	local var_3_2 = var_1.getActivityByType

	ActivityConst = var_1_10004
	arg_3_0.activity = var_3_2(var_3_1, var_1_10004.ACTIVITY_TYPE_NEWSERVER_GIFT)

	local var_3_3 = arg_3_0.activity

	arg_3_0.goodIdList = var_1.getConfig(var_3_3, "config_data")

	arg_3_0:updateGiftGoodsVOList()

	return
end

function var_0_1.initUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.content = var_1.Find(var_4_0, "scrollrect/content")

	local var_4_1 = arg_4_0._tf

	arg_4_0.soldOutTF = var_1.Find(var_4_1, "sold_out")
	setText = var_1

	local var_4_2 = arg_4_0.soldOutTF
	local var_4_3 = var_3.Find(var_4_2, "Text")

	i18n = var_4

	var_1(var_4_3, var_4("newserver_soldout"))

	setActive = var_1

	var_1(arg_4_0.soldOutTF, #arg_4_0.giftGoodsVOList == 0)

	UIItemList = var_1

	local var_4_4 = var_1.New
	local var_4_5 = arg_4_0.content
	local var_4_6 = arg_4_0._tf

	arg_4_0.giftItemList = var_4_4(var_4_5, var_4.Find(var_4_6, "gift_tpl"))
	arg_4_0.chargeCardTable = {}

	local var_4_7 = arg_4_0.giftItemList

	var_1.make(var_4_7, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		local var_5_1

		if arg_5_0 == var_2_10003.EventInit then
			local var_5_0 = arg_4_0

			var_5_1 = var_5_1.initGift
			go = var_2_10006

			var_5_1(var_5_0, var_2_10006(arg_5_2))
		else
			UIItemList = var_5_1

			if arg_5_0 == var_5_1.EventUpdate then
				local var_5_2 = arg_4_0
				local var_5_3 = var_3.updateGift

				go = var_2_10006

				var_5_3(var_5_2, var_2_10006(arg_5_2), arg_5_1)
			end
		end

		return
	end)

	local var_4_8 = arg_4_0.giftItemList

	var_1.align(var_4_8, #arg_4_0.giftGoodsVOList)

	return
end

function var_0_1.initGift(arg_6_0, arg_6_1)
	OldChargeCard = var_1_10002

	local var_6_0 = var_1_10002.New(arg_6_1)

	onButton = var_1_10003

	local var_6_1 = arg_6_0
	local var_6_2 = var_6_0.tr

	local function var_6_3()
		local var_7_0 = arg_6_0

		var_0.confirm(var_7_0, var_6_0.goods)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_6_1, var_6_2, var_6_3, var_1_10008)

	arg_6_0.chargeCardTable[arg_6_1] = var_6_0

	return
end

function var_0_1.updateGift(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0

	if not arg_8_0.chargeCardTable[arg_8_1] then
		arg_8_0.initGift(arg_8_1)

		var_8_0 = arg_8_0.chargeCardTable[arg_8_1]
	end

	if arg_8_0.giftGoodsVOList[arg_8_2] then
		var_8_0:update(var_4, arg_8_0.player, arg_8_0.firstChargeIds)
	end

	return
end

function var_0_1.confirm(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	Clone = var_1_10002
	arg_9_1 = var_1_10002(arg_9_1)

	local var_9_0 = {}
	local var_9_1 = arg_9_1:getConfig("effect_args")

	Item = var_4

	local var_9_2 = var_4.getConfigData(var_9_1[1]).display_icon

	type = var_6

	if var_6(var_9_2) == "table" then
		ipairs = var_6

		for iter_9_0, iter_9_1 in var_6(var_9_2) do
			table = var_1_10011
			var_1_10011 = var_1_10011.insert

			local var_9_3 = var_9_0

			Drop = var_1_10014

			var_1_10011(var_9_3, var_1_10014.Create(iter_9_1))
		end
	end

	local var_9_4 = {
		isLocalPrice = false,
		isChargeType = false,
		isMonthCard = false,
		commodity = arg_9_1,
		icon = var_4.icon,
		name = var_4.name
	}

	i18n = var_7
	var_9_4.tipExtra = var_7("charge_title_getitem")
	var_9_4.extraItems = var_9_0
	var_9_4.price = arg_9_1:getConfig("resource_num")
	var_9_4.tagType = arg_9_1:getConfig("tag")

	function var_9_4.onYes()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		i18n = var_2_10004

		local var_10_3 = "charge_scene_buy_confirm"
		local var_10_4 = arg_9_1

		var_10_2.content = var_2_10004(var_10_3, var_7.getConfig(var_10_4, "resource_num"), var_0.name)

		function var_10_2.onYes()
			local var_11_0 = arg_9_0
			local var_11_1 = var_0.emit

			NewServerCarnivalMediator = var_3_10003

			var_11_1(var_11_0, var_3_10003.GIFT_BUY_ITEM, arg_9_1.id, 1)

			return
		end

		var_10_1(var_10_0, var_10_2)

		return
	end

	local var_9_5 = arg_9_0
	local var_9_6 = arg_9_0.emit

	NewServerCarnivalMediator = var_10

	var_9_6(var_9_5, var_10.GIFT_OPEN_ITEM_PANEL, var_9_4)

	return
end

function var_0_1.onUpdatePlayer(arg_12_0, arg_12_1)
	arg_12_0.player = arg_12_1

	return
end

function var_0_1.onUpdateGift(arg_13_0)
	arg_13_0:updateGiftGoodsVOList()

	local var_13_0 = arg_13_0.giftItemList

	var_1.align(var_13_0, #arg_13_0.giftGoodsVOList)

	setActive = var_1

	var_1(arg_13_0.soldOutTF, #arg_13_0.giftGoodsVOList == 0)

	return
end

function var_0_1.updateGiftGoodsVOList(arg_14_0)
	getProxy = var_1_10001
	ShopsProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)

	arg_14_0.normalList = var_1.GetNormalList(var_14_0)
	arg_14_0.giftGoodsVOList = {}
	pg = var_1

	local var_14_1 = var_1.shop_template

	pairs = var_1_10002

	for iter_14_0, iter_14_1 in var_1_10002(arg_14_0.goodIdList) do
		Goods = var_1_10007
		var_1_10007 = var_1_10007.Create

		local var_14_2 = {
			shop_id = iter_14_1
		}

		Goods = var_1_10010
		var_1_10007 = var_1_10007(var_14_2, var_1_10010.TYPE_NEW_SERVER)
		table = var_1_10008

		var_1_10008.insert(arg_14_0.giftGoodsVOList, var_1_10007)
	end

	local var_14_3 = {}

	ipairs = var_3

	for iter_14_2, iter_14_3 in var_3(arg_14_0.giftGoodsVOList) do
		ChargeConst = var_1_10008
		var_1_10008 = var_1_10008.getBuyCount(arg_14_0.normalList, iter_14_3.id)

		iter_14_3:updateBuyCount(var_1_10008)

		if iter_14_3:canPurchase() then
			table = var_9

			var_9.insert(var_14_3, iter_14_3)
		end
	end

	arg_14_0.giftGoodsVOList = var_14_3

	return
end

function var_0_1.isTip(arg_15_0)
	if not arg_15_0.playerId then
		getProxy = var_1
		PlayerProxy = var_1_10003

		local var_15_0 = var_1(var_1_10003)

		arg_15_0.playerId = var_1.getData(var_15_0).id
	end

	PlayerPrefs = var_1

	return var_1.GetInt("newserver_gift_first_" .. arg_15_0.playerId) == 0
end

function var_0_1.OnDestroy(arg_16_0)
	return
end

return var_0_1
