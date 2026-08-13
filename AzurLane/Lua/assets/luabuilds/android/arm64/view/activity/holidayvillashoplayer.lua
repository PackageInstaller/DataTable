class = var_0_10000

local var_0_0 = "HolidayVillaShopLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SixthAnniversaryIslandShopLayer"))

function var_0_1.getUIName(arg_1_0)
	return "HolidayVillaShopUI"
end

function var_0_1.setPlayer(arg_2_0, arg_2_1)
	arg_2_0.player = arg_2_1
	setText = var_1_10002

	local var_2_0 = arg_2_0.rtRes
	local var_2_1 = var_4.Find(var_2_0, "Text")

	getProxy = var_1_10005
	ActivityProxy = var_7

	local var_2_2 = var_1_10005(var_7)
	local var_2_3 = var_5.getActivityById

	ActivityConst = var_1_10008

	local var_2_4 = var_2_3(var_2_2, var_1_10008.HOLIDAY_ACT_ID)

	var_1_10002(var_2_1, var_5.getVitemNumber(var_2_4, 66005))

	return
end

function var_0_1.refreshAllGoodsCard(arg_3_0)
	local var_3_0 = arg_3_0.shop

	arg_3_0.goodsList = var_1.getSortGoods(var_3_0)

	local var_3_1 = arg_3_0.goodsItemList

	var_1.align(var_3_1, #arg_3_0.goodsList)

	return
end

function var_0_1.init(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_0, arg_4_0._tf)

	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_1.Find(var_4_1, "main")

	setText = var_1_10002

	local var_4_3 = var_4_2:Find("time/Text")

	i18n = var_1_10005

	var_1_10002(var_4_3, var_1_10005("islandshop_tips1"))

	arg_4_0.rtTime = var_4_2:Find("time/Text_2")
	arg_4_0.rtRes = var_4_2:Find("tpl")

	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_2.Find(var_4_4, "main/view/content")

	UIItemList = var_4_1
	arg_4_0.goodsItemList = var_4_1.New(var_4_5, var_4_5:Find("goods"))

	local var_4_6 = arg_4_0.goodsItemList

	var_3.make(var_4_6, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			local var_5_0 = arg_4_0.goodsCardDic

			var_5_0[arg_4_0.goodsList[arg_5_1].id] = arg_5_2
			onButton = var_5_0

			local var_5_1 = arg_4_0
			local var_5_2 = arg_5_2

			local function var_5_3()
				local var_6_0 = arg_4_0
				local var_6_1 = var_0.emit

				HolidayVillaShopMediator = var_3_10003

				var_6_1(var_6_0, var_3_10003.OPEN_GOODS_WINDOW, arg_4_0.goodsList[arg_5_1])

				return
			end

			SFX_PANEL = var_2_10008

			var_5_0(var_5_1, var_5_2, var_5_3, var_2_10008)

			local var_5_4 = arg_4_0

			var_3.updateGoodsCard(var_5_4, arg_5_2, arg_4_0.goodsList[arg_5_1])
		end

		return
	end)

	onButton = var_3

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0._tf
	local var_4_9 = var_6.Find(var_4_8, "bg")

	local function var_4_10()
		local var_7_0 = arg_4_0

		var_0.closeView(var_7_0)

		return
	end

	SFX_CANCEL = var_4_8

	var_3(var_4_7, var_4_9, var_4_10, var_4_8)

	onButton = var_3

	local var_4_11 = arg_4_0
	local var_4_12 = arg_4_0._tf
	local var_4_13 = var_6.Find(var_4_12, "main/btn_back")

	local function var_4_14()
		local var_8_0 = arg_4_0

		var_0.closeView(var_8_0)

		return
	end

	SFX_CANCEL = var_4_12

	var_3(var_4_11, var_4_13, var_4_14, var_4_12)

	return
end

return var_0_1
