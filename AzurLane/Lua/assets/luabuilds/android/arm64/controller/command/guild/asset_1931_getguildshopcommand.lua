class = var_0_10000

local var_0_0 = "GetGuildShopCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody().type then
		var_1_0 = 1
	end

	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	PlayerProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	getProxy = var_1_10006
	ShopsProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)

	GuildConst = var_1_10007

	if var_1_0 == var_1_10007.MANUAL_REFRESH then
		local var_1_4 = var_1_2:getData()
		local var_1_5 = var_7.getResource

		PlayerConst = var_1_10011

		local var_1_6 = var_1_5(var_1_4, var_1_10011.ResGuildCoin)
		local var_1_7 = var_1_3:getGuildShop()

		if var_1_6 < var_9.GetResetConsume(var_1_7) then
			pg = var_10

			local var_1_8 = var_10.TipsMgr.GetInstance()
			local var_1_9 = var_10.ShowTips

			i18n = var_1_10013

			var_1_9(var_1_8, var_1_10013("common_no_resource"))

			return
		end
	end

	pg = var_7

	local var_1_10 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_10, 1, {
		type = var_1_0
	}, 2, function(arg_2_0)
		if arg_2_0.result == 0 then
			GuildShop = var_1

			local var_2_0 = var_1.New(arg_2_0.info)

			if var_1_3.guildShop then
				var_2_10004 = var_1_3

				var_2.updateGuildShop(var_2_10004, var_2_0, true)
			else
				var_2_10004 = var_1_3

				var_2.setGuildShop(var_2_10004, var_2_0)
			end

			local var_2_1 = var_1_0

			GuildConst = var_3

			if var_2_1 == var_3.MANUAL_REFRESH then
				var_2_10004 = var_2_0

				local var_2_2 = var_2_0.GetResetConsume(var_2_10004)

				var_2_10005 = var_1_2

				local var_2_3 = var_3.getData(var_2_10005)

				var_3.consume(var_2_3, {
					guildCoin = var_2_2
				})

				local var_2_4 = var_1_2

				var_2_10004.updatePlayer(var_2_4, var_3)

				pg = var_2_10004

				local var_2_5 = var_2_10004.TipsMgr.GetInstance()

				var_2_10004 = var_2_10004.ShowTips
				i18n = var_7

				var_2_10004(var_2_5, var_7("guild_shop_refresh_done"))
			end

			if var_1_1 then
				var_1_1(var_2_0)
			end

			var_2_10004 = arg_1_0

			local var_2_6 = var_2.sendNotification

			GAME = var_2_10005

			var_2_6(var_2_10004, var_2_10005.GET_GUILD_SHOP_DONE)
		else
			if var_1_1 then
				var_1_1()
			end

			pg = var_1

			local var_2_7 = var_1.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_8(var_2_7, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
