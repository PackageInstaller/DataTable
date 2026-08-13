class = var_0_10000

local var_0_0 = "SkinShoppingCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.count

	pg = var_1_10005

	local var_1_2 = var_1_10005.shop_template[var_1_0]

	if not var_1_0 then
		pg = var_1_10006
		var_1_10007 = var_1_10006.TipsMgr.GetInstance()
		var_1_10006 = var_1_10006.ShowTips
		i18n = var_1_10008

		var_1_10006(var_1_10007, var_1_10008("common_shopId_noFound"))

		return
	end

	if var_1_1 == 0 then
		return
	end

	getProxy = var_1_10006
	ShopsProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)
	local var_1_4 = var_6.getShopStreet(var_1_3)
	local var_1_5 = false
	local var_1_6 = var_1_2.resource_num * var_1_1

	getProxy = var_1_10010
	PlayerProxy = var_1_10011

	local var_1_7 = var_1_10010(var_1_10011)
	local var_1_8 = var_10.getData(var_1_7)

	if var_1_2.limit_args then
		ipairs = var_12

		for iter_1_0, iter_1_1 in var_12(var_1_2.limit_args) do
			type = var_1_10017

			if var_1_10017(iter_1_1) == "table" and iter_1_1[1] == "level" then
				var_1_10017 = iter_1_1[2]

				if var_1_8.level < var_1_10017 then
					pg = var_1_10017
					var_1_10018 = var_1_10017.TipsMgr.GetInstance()
					var_1_10017 = var_1_10017.ShowTips
					i18n = var_1_10019

					var_1_10017(var_1_10018, var_1_10019("common_limit_level", iter_1_1[2]))

					return
				end
			end
		end
	end

	if var_1_2.discount ~= 0 then
		CommonCommodity = var_12

		if var_12.InCommodityDiscountTime(var_1_2.id) then
			var_1_6 = var_1_6 * ((100 - var_1_2.discount) / 100)
		end
	end

	id2res = var_12

	local var_1_10

	if var_1_8[var_12(var_1_2.resource_type)] < var_1_6 then
		Drop = var_12

		local var_1_9 = var_12.New

		var_1_10 = {}
		DROP_TYPE_RESOURCE = var_1_10014
		var_1_10.type = var_1_10014
		var_1_10.id = var_1_2.resource_type
		var_1_10 = var_1_9(var_1_10)

		local var_1_11 = var_12.getName(var_1_10)
		local var_1_13

		if var_1_2.resource_type == 1 then
			GoShoppingMsgBox = var_1_10
			i18n = var_1_13

			local var_1_12 = "switch_to_shop_tip_2"

			i18n = iter_1_1
			var_1_13 = var_1_13(var_1_12, iter_1_1("word_gold"))
			ChargeScene = var_1_12

			local var_1_14 = var_1_12.TYPE_ITEM

			iter_1_1 = {}

			local var_1_15 = {
				59001
			}

			id2res = var_1_10018
			var_1_15[2] = var_1_6 - var_1_8[var_1_10018(var_1_2.resource_type)]
			var_1_15[3] = var_1_6
			iter_1_1[1] = var_1_15

			var_1_10(var_1_13, var_1_14, iter_1_1)
		elseif var_1_2.resource_type == 4 or var_1_2.resource_type == 14 then
			GoShoppingMsgBox = var_1_10
			i18n = var_1_13

			local var_1_16 = "switch_to_shop_tip_3"

			i18n = iter_1_1
			var_1_13 = var_1_13(var_1_16, iter_1_1("word_gem"))
			ChargeScene = var_1_16

			var_1_10(var_1_13, var_1_16.TYPE_DIAMOND)

			pg = var_1_10
			var_1_13 = var_1_10.TrackerMgr.GetInstance()
			var_1_10 = var_1_10.Tracking
			TRACKING_BUILD_OR_SKIN_FAILD = var_15

			var_1_10(var_1_13, var_15)
		else
			ItemTipPanel = var_1_10
			var_1_10 = var_1_10.ShowItemTip
			DROP_TYPE_RESOURCE = var_1_13

			if not var_1_10(var_1_13, var_1_2.resource_type) then
				pg = var_1_10

				local var_1_17 = var_1_10.TipsMgr.GetInstance()

				var_1_10 = var_1_10.ShowTips
				i18n = var_15

				var_1_10(var_1_17, var_15("buyProp_noResource_error", var_1_11))
			end
		end

		return
	end

	local var_1_18 = {}

	seriesAsync = var_1_10

	var_1_10(var_1_18, function()
		pg = var_2_10000

		local var_2_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_2_0, 16001, {
			id = var_1_0,
			number = var_1_1
		}, 16002, function(arg_3_0)
			local var_3_0

			if arg_3_0.result == 0 then
				var_3_0 = {}
				var_3_10003 = var_0

				local var_3_1 = var_2.getData(var_3_10003)

				var_3_10003 = var_2.consume

				local var_3_2 = {}

				id2res = var_3_10006
				var_3_2[var_3_10006(var_1_2.resource_type)] = var_1_6

				var_3_10003(var_3_1, var_3_2)

				var_3_10003 = nil
				switch = var_3_1

				local var_3_3 = var_1_2.genre
				local var_3_4 = {}

				ShopArgs = var_7
				var_3_4[var_7.SkinShop] = function()
					PlayerConst = var_4_10000
					var_3_0 = var_4_10000.addTranDrop(arg_3_0.drop_list)

					local var_4_0 = var_1_2.effect_args[1]

					getProxy = var_1
					ShipSkinProxy = var_4_10002

					local var_4_1 = var_1(var_4_10002)

					ShipSkin = var_4_10002

					local var_4_2 = var_4_10002.New({
						id = var_4_0
					})

					var_4_1:addSkin(var_4_2)

					return
				end
				ShopArgs = var_7
				var_3_4[var_7.SkinShopTimeLimit] = function()
					local var_5_0 = var_1_2.effect_args[1]

					getProxy = var_4_10001
					ShipSkinProxy = var_4_10002

					local var_5_1 = var_4_10001(var_4_10002)

					if var_1.getSkinById(var_5_1, var_5_0) and var_2:isExpireType() then
						local var_5_2 = var_1_2.time_second * var_1_1 + var_2.endTime

						ShipSkin = var_4

						local var_5_3 = var_4.New({
							id = var_5_0,
							end_time = var_5_2
						})

						var_1:addSkin(var_5_3)
					elseif not var_2 then
						local var_5_4 = var_1_2.time_second * var_1_1

						pg = var_4

						local var_5_5 = var_4.TimeMgr.GetInstance()
						local var_5_6 = var_5_4 + var_4.GetServerTime(var_5_5)

						ShipSkin = var_4

						local var_5_7 = var_4.New({
							id = var_5_0,
							end_time = var_5_6
						})

						var_1:addSkin(var_5_7)
					end

					return
				end

				var_3_1(var_3_3, var_3_4)

				local var_3_5 = var_0

				var_4.updatePlayer(var_3_5, var_2)

				if var_1_2.group > 0 then
					local var_3_6 = var_0

					var_4.updateNormalGroupList(var_3_6, var_1_2.group, var_1_2.group_buy_count)
				end

				local var_3_7 = arg_1_0
				local var_3_8 = var_4.sendNotification

				GAME = var_6

				local var_3_9 = var_6.SKIN_SHOPPIGN_DONE
				local var_3_10 = {
					id = var_1_0,
					shopType = var_3_10003
				}
				local var_3_11 = var_0

				var_3_10.normalList = var_8.GetNormalList(var_3_11)

				local var_3_12 = var_0

				var_3_10.normalGroupList = var_8.GetNormalGroupList(var_3_12)
				var_3_10.awards = var_3_0

				var_3_8(var_3_7, var_3_9, var_3_10)
			else
				originalPrint = var_3_0

				var_3_0(arg_3_0.result)

				local var_3_14

				if arg_3_0.result == 4400 then
					pg = var_3_14

					local var_3_13 = var_3_14.TipsMgr.GetInstance()

					var_3_14 = var_3_14.ShowTips
					i18n = var_3_10003

					var_3_14(var_3_13, var_3_10003("shopping_error_time_limit"))
				else
					pg = var_3_14

					local var_3_15 = var_3_14.TipsMgr.GetInstance()
					local var_3_16 = var_1.ShowTips

					errorTip = var_3_10003

					var_3_16(var_3_15, var_3_10003("", arg_3_0.result))
				end
			end

			return
		end)

		return
	end)

	return
end

return var_0_1
