class = var_0_10000

local var_0_0 = "FragmentShoppingCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.FRAG_SHOP = 2
var_0_1.FRAG_NORMAL_SHOP = 3

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.count
	local var_1_2 = var_2.type

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.getRawData(var_1_3)

	getProxy = var_1_10008
	ShopsProxy = var_1_10010

	local var_1_5 = var_1_10008(var_1_10010)
	local var_1_6 = var_8.getFragmentShop(var_1_5)
	local var_1_7 = var_9.getGoodsCfg(var_1_6, var_1_0)

	Drop = var_1_5

	local var_1_8 = var_1_5.New({
		type = var_1_7.resource_category,
		id = var_1_7.resource_type
	})

	if var_11.getOwnedCount(var_1_8) < var_1_7.resource_num * var_1_1 then
		pg = var_12

		local var_1_9 = var_12.TipsMgr.GetInstance()
		local var_1_10 = var_12.ShowTips

		i18n = var_1_10015

		var_1_10(var_1_9, var_1_10015("common_no_x", var_11:getName()))

		return
	end

	if var_1_7.commodity_type == 1 then
		if var_1_7.commodity_id == 1 and var_1_4:GoldMax(var_1_7.num * var_1_1) then
			pg = var_12

			local var_1_11 = var_12.TipsMgr.GetInstance()
			local var_1_12 = var_12.ShowTips

			i18n = var_15

			local var_1_13 = var_15("gold_max_tip_title")

			i18n = var_1_10016

			var_1_12(var_1_11, var_1_13 .. var_1_10016("resource_max_tip_shop"))

			return
		end

		if var_1_7.commodity_id == 2 and var_1_4:OilMax(var_1_7.num * var_1_1) then
			pg = var_12

			local var_1_14 = var_12.TipsMgr.GetInstance()
			local var_1_15 = var_12.ShowTips

			i18n = var_15

			local var_1_16 = var_15("oil_max_tip_title")

			i18n = var_1_10016

			var_1_15(var_1_14, var_1_16 .. var_1_10016("resource_max_tip_shop"))

			return
		end
	end

	local var_1_17 = var_9:GetCommodityById(var_1_0)
	local var_1_18 = var_0_1.FRAG_SHOP
	local var_1_19 = var_1_17.type

	Goods = var_15

	if var_1_19 == var_15.TYPE_FRAGMENT_NORMAL then
		var_1_18 = var_0_1.FRAG_NORMAL_SHOP
	end

	pg = var_1_19

	local var_1_20 = var_1_19.ConnectionMgr.GetInstance()

	var_14.Send(var_1_20, 16201, {
		id = var_1_0,
		type = var_1_18,
		count = var_1_1
	}, 16202, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.drop_list)
			var_2_10004 = var_0

			local var_2_1 = var_2.getFragmentShop(var_2_10004)
			local var_2_2 = var_2.getGoodsById(var_2_1, var_1_0)

			var_3.addBuyCount(var_2_2, var_1_1)

			local var_2_3 = var_0

			var_2_10004.updateFragmentShop(var_2_3, var_2)

			reducePlayerOwn = var_2_10004

			var_2_10004({
				type = var_1_7.resource_category,
				id = var_1_7.resource_type,
				count = var_1_7.resource_num * var_1_1
			})

			local var_2_4 = arg_1_0

			var_2_10004 = var_2_10004.sendNotification
			GAME = var_7

			var_2_10004(var_2_4, var_7.FRAG_SHOPPING_DONE, {
				awards = var_2_0,
				id = var_1_0
			})
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_6(var_2_5, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
