local GuildShopCommand = class("GuildShopCommand", pm.SimpleCommand)

function GuildShopCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.goodsId
	local var_1_2 = #var_1_0.selectedId
	local var_1_3 = getProxy(PlayerProxy)
	local var_1_4 = var_1_3:getData()
	local var_1_5 = getProxy(ShopsProxy)
	local var_1_6 = var_1_5:getGuildShop():getGoodsById(var_1_0.goodsId)
	local var_1_7 = var_1_6:GetPrice()

	if var_1_4:getResource(8) < var_1_7 * #var_1_0.selectedId then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	if not var_1_6:CanPurchaseCnt(#var_1_0.selectedId) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("guild_shop_cnt_no_enough"))

		return
	end

	local var_1_8 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.selectedId) do
		if not var_1_8[iter_1_1] then
			var_1_8[iter_1_1] = {
				count = 1,
				id = iter_1_1
			}
		else
			var_1_8[iter_1_1].count = var_1_8[iter_1_1].count + 1
		end
	end

	pg.ConnectionMgr.GetInstance():Send(3, {
		goodsid = var_1_6.configId,
		index = var_1_6.index,
		selected = _.values(var_1_8)
	}, 4, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_5:getGuildShop()

			var_2_0:UpdateGoodsCnt(var_1_1, var_1_2)
			var_1_5:updateGuildShop(var_2_0)
			var_1_4:consume({
				guildCoin = var_1_7 * var_1_2
			})
			var_1_3:updatePlayer(var_1_4)
			self:sendNotification(GAME.ON_GUILD_SHOP_PURCHASE_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.drop_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return GuildShopCommand
