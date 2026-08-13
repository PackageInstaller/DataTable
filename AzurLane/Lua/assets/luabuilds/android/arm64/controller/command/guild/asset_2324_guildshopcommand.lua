class = var_0_10000

local var_0_0 = "GuildShopCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().goodsId
	local var_1_1 = #var_2.selectedId

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_1_2 = var_1_10006(var_1_10008)
	local var_1_3 = var_6.getData(var_1_2)
	local var_1_4 = var_7.getResource(var_1_3, 8)

	getProxy = var_1_2
	ShopsProxy = var_11

	local var_1_5 = var_1_2(var_11)
	local var_1_6 = var_9.getGuildShop(var_1_5)
	local var_1_7 = var_10.getGoodsById(var_1_6, var_1_0)

	if var_1_4 < var_11.GetPrice(var_1_7) * var_1_1 then
		pg = var_13

		local var_1_8 = var_13.TipsMgr.GetInstance()
		local var_1_9 = var_13.ShowTips

		i18n = var_1_10016

		var_1_9(var_1_8, var_1_10016("common_no_resource"))

		return
	end

	if not var_11:CanPurchaseCnt(var_1_1) then
		pg = var_13

		local var_1_10 = var_13.TipsMgr.GetInstance()
		local var_1_11 = var_13.ShowTips

		i18n = var_16

		var_1_11(var_1_10, var_16("guild_shop_cnt_no_enough"))

		return
	end

	local var_1_12 = {}

	ipairs = var_1_7

	for iter_1_0, iter_1_1 in var_1_7(var_4) do
		if not var_1_12[iter_1_1] then
			var_1_12[iter_1_1] = {
				count = 1,
				id = iter_1_1
			}
		else
			var_1_12[iter_1_1].count = var_1_12[iter_1_1].count + 1
		end
	end

	pg = var_14

	local var_1_13 = var_14.ConnectionMgr.GetInstance()
	local var_1_14 = var_14.Send
	local var_1_15 = 3
	local var_1_16 = {
		goodsid = var_11.configId,
		index = var_11.index
	}

	_ = var_19
	var_1_16.selected = var_19.values(var_1_12)

	var_1_14(var_1_13, var_1_15, var_1_16, 4, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.drop_list)
			var_2_10004 = var_0

			local var_2_1 = var_2.getGuildShop(var_2_10004)

			var_2.UpdateGoodsCnt(var_2_1, var_1_0, var_1_1)

			local var_2_2 = var_0

			var_3.updateGuildShop(var_2_2, var_2)

			local var_2_3 = var_0

			var_3.consume(var_2_3, {
				guildCoin = var_0 * var_1_1
			})

			local var_2_4 = var_0

			var_3.updatePlayer(var_2_4, var_0)

			local var_2_5 = arg_1_0
			local var_2_6 = var_3.sendNotification

			GAME = var_6

			var_2_6(var_2_5, var_6.ON_GUILD_SHOP_PURCHASE_DONE, {
				awards = var_2_0
			})
		else
			pg = var_2_0

			local var_2_7 = var_2_0.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_8(var_2_7, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
